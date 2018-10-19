IF OBJECT_ID ('USP_APP_SEL_ReassignUserList') IS NOT NULL 
DROP PROC [DBO].[USP_APP_SEL_ReassignUserList]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- =============================================
-- Author: Venkatasubramanyam
-- Create date: 20/07/2017
-- Description: Get assigned Records(OST,Eligibility, RPR) to reassign to ther user.
-- Eg.
 --Declare @ErrorMessage VARCHAR(2000)
 --Set @ErrorMessage=''
 --Exec [USP_APP_SEL_ReassignUserList] @ErrorMessage = @ErrorMessage Output
-- =============================================
Create PROCEDURE [dbo].[USP_APP_SEL_ReassignUserList]    
(            
  @GEN_QueueIds VARCHAR(MAX)=NULL,
  @ErrorMessage varchar(2000) OUTPUT
)
AS
BEGIN  
BEGIN TRY 

   DECLARE @lstQueues VARCHAR(MAX)=NULL
   DECLARE @WorkQueueCount INT=NULL
   DECLARE @TotalCount BIGINT = 0
   DECLARE @UnRestrictedCount BIGINT = 0
   DECLARE @IsAllUnRestrictedRecords BIT=0

   SELECT DISTINCT Item as GEN_QueueId 
			  INTO [dbo].[#TEMPQueueIds]
			  FROM SplitString(@GEN_QueueIds,',') WHERE Item <>''

   ----------------GET commaseparated Queues From GEN_QueueIds------------------
   SELECT @lstQueues =CASE WHEN GQ.PreviousWorkQueueLkup IS NOT NULL 
			            THEN 
						    ISNULL(@lstQueues+',' , '') + CAST(GQ.MostRecentWorkQueueLkup AS VARCHAR)+','+CAST(GQ.PreviousWorkQueueLkup AS VARCHAR)
						ELSE
						   ISNULL(@lstQueues+',' , '')+CAST(GQ.MostRecentWorkQueueLkup AS VARCHAR) 
						END
		      FROM GEN_Queue GQ with(nolock)
	    INNER JOIN [dbo].[#TEMPQueueIds] TQ with(nolock) ON GQ.GEN_QueueId=TQ.GEN_QueueId

   SELECT DISTINCT Item as WorkQueuesLkup 
			  INTO [dbo].[#TEMPWorkQueuesLkup]
			  FROM SplitString(@lstQueues,',') WHERE Item <>''

   SELECT @WorkQueueCount=COUNT(*) FROM [dbo].[#TEMPWorkQueuesLkup] with(nolock)

    SELECT @TotalCount = COUNT(*)
	FROM GEN_Queue GQ with(nolock)
	INNER JOIN [dbo].[#TEMPQueueIds] TQ with(nolock) ON GQ.GEN_QueueId=TQ.GEN_QueueId

	SELECT @UnRestrictedCount = COUNT(*)
	FROM GEN_Queue GQ with(nolock) 
	INNER JOIN [dbo].[#TEMPQueueIds] TQ with(nolock) ON GQ.GEN_QueueId=TQ.GEN_QueueId
	WHERE GQ.IsRestricted IS NULL OR GQ.IsRestricted = 0

	IF(@TotalCount > 0 AND @TotalCount = @UnRestrictedCount)
	BEGIN
		SET @IsAllUnRestrictedRecords = 1
	END
	
   SELECT  DISTINCT UM.ADM_UserMasterId
			       ,UM.MSID
				   ,UM.Email
				   ,UM.FirstName
				   ,UM.LastName
				   ,UM.FullName
				   ,COUNT (DISTINCT  SCM.WorkQueuesLkup) AS WorkQueuesLkup
			  FROM [dbo].[ADM_UserMaster] UM with(nolock) 
		INNER JOIN [dbo].[ADM_AccessGroupUserCorrelation] ACM with(nolock) ON UM.ADM_UserMasterId=ACM.ADM_UserMasterRef AND ACM.IsActive=1 AND UM.IsActive=1
		INNER JOIN [dbo].[ADM_AccessGroupSkillsCorrelation] AGC with(nolock) ON ACM.ADM_AccessGroupMasterRef=AGC.ADM_AccessGroupMasterRef AND AGC.IsActive=1
		INNER JOIN [dbo].[ADM_SkillWorkQueuesCorrelation] SCM with(nolock) ON AGC.ADM_SkillsMasterRef=SCM.ADM_SkillsMasterRef AND AGC.IsActive=1
		INNER JOIN [dbo].[#TEMPWorkQueuesLkup] TMP with(nolock) ON SCM.WorkQueuesLkup=TMP.WorkQueuesLkup
		WHERE (@IsAllUnRestrictedRecords = 1 OR (@IsAllUnRestrictedRecords = 0 AND UM.LocationLkup=33001)) --33001 - Onshore
		  GROUP BY UM.ADM_UserMasterId,UM.MSID,UM.Email,UM.FirstName,UM.LastName,UM.FullName
		    HAVING COUNT (DISTINCT  SCM.WorkQueuesLkup) =@WorkQueueCount
	   	  ORDER BY  UM.FullName ASC

END TRY 
BEGIN CATCH

    SET @ErrorMessage= ERROR_MESSAGE();
END CATCH 
END
GO

