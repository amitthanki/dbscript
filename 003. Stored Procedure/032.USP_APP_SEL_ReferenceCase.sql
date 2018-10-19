IF OBJECT_ID ('USP_APP_SEL_ReferenceCase') IS NOT NULL 
DROP PROC [DBO].[USP_APP_SEL_ReferenceCase]
GO

/****** Object:  StoredProcedure [dbo].[USP_APP_SEL_ReferenceCase]    Script Date: 05/07/2017 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: Amit Thanki
-- Create date: 09/04/2017
-- Modified By: 
-- Modification Date: 
-- Eg.
-- Declare @ErrorMessage VARCHAR(2000)
-- Set @ErrorMessage=''
-- Exec [USP_APP_SEL_ReferenceCase] @ErrorMessage = @ErrorMessage Output
-- =============================================
CREATE PROCEDURE [dbo].[USP_APP_SEL_ReferenceCase]
@GEN_QueueId BIGINT=NULL,
@ErrorMessage VARCHAR(2000) OUT
AS
BEGIN  
BEGIN TRY  

DECLARE @BusinessSegmentLkup BIGINT
DECLARE @WorkBasketLkup BIGINT
DECLARE @MemberCurrentHICN VARCHAR(20)
DECLARE @MemberContractIDLkup BIGINT
DECLARE @MemberPBPLkup BIGINT

SELECT @BusinessSegmentLkup=[BusinessSegmentLkup], @WorkBasketLkup=[WorkBasketLkup], @MemberCurrentHICN=[MemberMedicareId], @MemberContractIDLkup=[MemberContractIDLkup], @MemberPBPLkup=[MemberPBPLkup] FROM [dbo].[GEN_Queue] WHERE [GEN_QueueId] = @GEN_QueueId

;WITH childcte AS (
		  SELECT Gen_QueueId,ParentQueueRef
			FROM GEN_Queue
		   WHERE GEN_QueueID = @Gen_QueueId
		  UNION all
		  SELECT d.Gen_QueueId, d.ParentQueueRef
			FROM GEN_Queue d
		JOIN childcte on d.Gen_QueueId = childcte.ParentQueueRef 
	), parentcte AS (
		 SELECT Gen_QueueId,ParentQueueRef
		   FROM GEN_Queue
		  WHERE GEN_QueueID = @Gen_QueueId
		  UNION ALL
		 SELECT d.Gen_QueueId, d.ParentQueueRef
		   FROM GEN_Queue d
	 INNER JOIN parentcte on d.ParentQueueRef  = parentcte.Gen_QueueId 
	  )

	SELECT * INTO #RefferenceCasesID 
	FROM (SELECT Gen_QueueId,ParentQueueRef
			FROM childcte
			UNION 
		SELECT Gen_QueueId,ParentQueueRef
			FROM parentcte) AS T1;

		SELECT GQ.[GEN_QueueId],GQ.[BusinessSegmentLkup],LMBusinessSegment.LookupValue,GQ.[WorkBasketLkup],LMWorkBasket.LookupValue AS WorkBasket,GQ.[DiscrepancyTypeLkup],LMDiscrepancyType.LookupValue AS DiscrepancyType,GQ.[DiscrepancyStartDate],GQ.[DiscrepancySourceLkup],LMDiscrepancySource.LookupValue AS DiscrepancySource
			,GQ.[DiscrepancyCategoryLkup],LMDiscrepancyCategory.LookupValue AS DiscrepancyCategory,GQ.[IsParentCase],GQ.[IsChildCase],GQ.[ParentQueueRef],GQ.[MostRecentWorkQueueLkup],LMMostRecentWorkQueue.LookupValue as MostRecentWorkQueue,GQ.[MostRecentStatusLkup],LMMostRecentStatus.LookupValue as MostRecentStatus
		FROM [dbo].[GEN_Queue] GQ With(Nolock)
	  INNER JOIN #RefferenceCasesID RC With(Nolock) ON RC.[GEN_QueueId] = GQ.[GEN_QueueId]
	  LEFT JOIN [dbo].[CMN_LookupMaster] LMBusinessSegment With(Nolock) ON GQ.[BusinessSegmentLkup]=LMBusinessSegment.[CMN_LookupMasterId] AND LMBusinessSegment.IsActive=1
      LEFT JOIN [dbo].[CMN_LookupMaster] LMWorkBasket With(Nolock) ON GQ.[WorkBasketLkup]=LMWorkBasket.[CMN_LookupMasterId] AND LMWorkBasket.IsActive=1
	  LEFT JOIN [dbo].[CMN_LookupMaster] LMDiscrepancyCategory With(Nolock) ON GQ.[DiscrepancyCategoryLkup]=LMDiscrepancyCategory.[CMN_LookupMasterId] AND LMDiscrepancyCategory.IsActive=1
	  LEFT JOIN [dbo].[CMN_LookupMaster] LMDiscrepancyType With(Nolock) ON GQ.[DiscrepancyTypeLkup]=LMDiscrepancyType.[CMN_LookupMasterId] AND LMDiscrepancyType.IsActive=1
	  LEFT JOIN [dbo].[CMN_LookupMaster] LMDiscrepancySource With(Nolock) ON GQ.[DiscrepancySourceLkup]=LMDiscrepancySource.[CMN_LookupMasterId] AND LMDiscrepancySource.IsActive=1
	  LEFT JOIN [dbo].[CMN_LookupMaster] LMMostRecentWorkQueue With(Nolock) ON GQ.[MostRecentWorkQueueLkup]=LMMostRecentWorkQueue.[CMN_LookupMasterId] AND LMMostRecentWorkQueue.IsActive=1
	  LEFT JOIN [dbo].[CMN_LookupMaster] LMMostRecentStatus With(Nolock) ON GQ.[MostRecentStatusLkup]=LMMostRecentStatus.[CMN_LookupMasterId] AND LMMostRecentStatus.IsActive=1
	  WHERE GQ.Gen_QueueId != @Gen_QueueId

	  UNION

		SELECT GQ.[GEN_QueueId],GQ.[BusinessSegmentLkup],LMBusinessSegment.LookupValue,GQ.[WorkBasketLkup],LMWorkBasket.LookupValue AS WorkBasket,GQ.[DiscrepancyTypeLkup],LMDiscrepancyType.LookupValue AS DiscrepancyType,GQ.[DiscrepancyStartDate],GQ.[DiscrepancySourceLkup],LMDiscrepancySource.LookupValue AS DiscrepancySource
			   ,GQ.[DiscrepancyCategoryLkup],LMDiscrepancyCategory.LookupValue AS DiscrepancyCategory,GQ.[IsParentCase],GQ.[IsChildCase],GQ.[ParentQueueRef],GQ.[MostRecentWorkQueueLkup],LMMostRecentWorkQueue.LookupValue as MostRecentWorkQueue,GQ.[MostRecentStatusLkup],LMMostRecentStatus.LookupValue as MostRecentStatus
		   FROM [dbo].[GEN_Queue] GQ With(Nolock)
	  LEFT JOIN [dbo].[CMN_LookupMaster] LMBusinessSegment With(Nolock) ON GQ.[BusinessSegmentLkup]=LMBusinessSegment.[CMN_LookupMasterId] AND LMBusinessSegment.IsActive=1
      LEFT JOIN [dbo].[CMN_LookupMaster] LMWorkBasket With(Nolock) ON GQ.[WorkBasketLkup]=LMWorkBasket.[CMN_LookupMasterId] AND LMWorkBasket.IsActive=1
	  LEFT JOIN [dbo].[CMN_LookupMaster] LMDiscrepancyCategory With(Nolock) ON GQ.[DiscrepancyCategoryLkup]=LMDiscrepancyCategory.[CMN_LookupMasterId] AND LMDiscrepancyCategory.IsActive=1
	  LEFT JOIN [dbo].[CMN_LookupMaster] LMDiscrepancyType With(Nolock) ON GQ.[DiscrepancyTypeLkup]=LMDiscrepancyType.[CMN_LookupMasterId] AND LMDiscrepancyType.IsActive=1
	  LEFT JOIN [dbo].[CMN_LookupMaster] LMDiscrepancySource With(Nolock) ON GQ.[DiscrepancySourceLkup]=LMDiscrepancySource.[CMN_LookupMasterId] AND LMDiscrepancySource.IsActive=1
	  LEFT JOIN [dbo].[CMN_LookupMaster] LMMostRecentWorkQueue With(Nolock) ON GQ.[MostRecentWorkQueueLkup]=LMMostRecentWorkQueue.[CMN_LookupMasterId] AND LMMostRecentWorkQueue.IsActive=1
	  LEFT JOIN [dbo].[CMN_LookupMaster] LMMostRecentStatus With(Nolock) ON GQ.[MostRecentStatusLkup]=LMMostRecentStatus.[CMN_LookupMasterId] AND LMMostRecentStatus.IsActive=1
		WHERE GQ.Gen_QueueId != @Gen_QueueId AND GQ.[BusinessSegmentLkup]=@BusinessSegmentLkup AND GQ.[WorkBasketLkup]=@WorkBasketLkup AND GQ.[MostRecentStatusLkup] != 20003 AND (GQ.[MemberCurrentHICN]=@MemberCurrentHICN OR GQ.[MemberMedicareId]=@MemberCurrentHICN) AND GQ.[MemberContractIDLkup]=@MemberContractIDLkup AND GQ.[MemberPBPLkup]=@MemberPBPLkup AND GQ.[IsActive]=1

	    END TRY
	BEGIN CATCH
		SET @ErrorMessage= ERROR_MESSAGE();
	END CATCH  
END