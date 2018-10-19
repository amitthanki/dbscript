IF OBJECT_ID ('USP_APP_UPD_UpdateOOAComments') IS NOT NULL 
BEGIN
	DROP PROC [dbo].[USP_APP_UPD_UpdateOOAComments]
END
GO


/****** Object:  StoredProcedure [dbo].[USP_APP_UPD_UpdateOOAComments]    Script Date: 8/17/2017 5:31:47 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author: Pradeep Patil
-- Create date: 08/16/2017
-- Modified By: 
-- Modification Date: 
-- Description: Insert Comments From MIIM
-- Eg.
-- Declare @ErrorMessage VARCHAR(2000)
-- Set @ErrorMessage=''
-- Exec [USP_APP_UPD_UpdateOOAComments] @ErrorMessage = @ErrorMessage Output
-- =============================================
CREATE PROCEDURE [dbo].[USP_APP_UPD_UpdateOOAComments]
@LoginUserId BIGINT,
@XMLComments   NVARCHAR(MAX),
@ErrorMessage VARCHAR(2000) OUT
AS
BEGIN
BEGIN TRY  
		BEGIN TRAN ADDCOMMENTS
		    DECLARE @UTCDate DATETIME = GETUTCDATE();
			DECLARE @tblcomments TABLE( ERSCaseId INT, MIIMReferenceId VARCHAR(10), Comments VARCHAR(MAX))
			DECLARE @Xml INT
            ----------Parsing------------
            EXEC sp_xml_preparedocument @Xml OUTPUT,@XMLComments

			INSERT INTO @tblcomments
            SELECT *
            FROM OPENXML(@Xml,'//DOMIIMOOACommentUpdate',0)
            WITH
            (
                [ERSCaseId]  INT  'ERSCaseId'
                ,[MIIMReferenceId] VARCHAR(10) 'MIIMReferenceId'
                ,[Comments] VARCHAR(MAX) 'Comments'
            )

			EXEC sp_xml_removedocument @Xml

			--- Insert record into comments 
			BEGIN
				INSERT INTO [dbo].[GEN_Comments] ([GEN_QueueRef],[Comments],[ActionLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef],[SourceSystemLkup])
				SELECT [ERSCaseId],[Comments],28001,1,@UTCDate,@LoginUserId,@UTCDate,@LoginUserId,38002 FROM @tblcomments
			END	

			---Update gen_queue with reference Id and new Queue
			DECLARE @tempMiimReferenceId VARCHAR(10)
			DECLARE @tempErsCaseId BIGINT
			DECLARE @PreviousWorkQueueLkup BIGINT = NULL
			DECLARE @MostRecentQueueLkup BIGINT
			DECLARE @MostRecentStatusLkup BIGINT
			DECLARE @MostRecentActionLkup BIGINT
			DECLARE @DiscrepancyCategoryLkup BIGINT
			DECLARE @NextQueueLkup BIGINT
			DECLARE @NextStatusLkup BIGINT
			DECLARE MiimRef_Cursor CURSOR FOR  
			SELECT [ERSCaseId], [MIIMReferenceId]   
			FROM @tblcomments
			OPEN MiimRef_Cursor;  
			FETCH NEXT FROM MiimRef_Cursor INTO @tempErsCaseId,@tempMiimReferenceId;
			WHILE @@FETCH_STATUS = 0  
				BEGIN
					--update miim ref id
					IF(@tempMiimReferenceId IS NOT NULL AND @tempMiimReferenceId != '')
					BEGIN
						UPDATE [dbo].[GEN_Queue] SET [MIIMReferenceId] = @tempMiimReferenceId
						WHERE [GEN_QueueId] = @tempErsCaseId
					END

					--seelct Current case details
					SELECT @DiscrepancyCategoryLkup=DiscrepancyCategoryLkup,@MostRecentQueueLkup = MostRecentWorkQueueLkup,@PreviousWorkQueueLkup = PreviousWorkQueueLkup,
						@MostRecentActionLkup = MostRecentActionLkup,@MostRecentStatusLkup = MostRecentStatusLkup FROM GEN_QUEUE WHERE GEN_QueueId = @tempErsCaseId

					IF(@MostRecentQueueLkup NOT IN (10025,10010))--If cases are not pended(OOA Pended and SCC Pended)
						BEGIN
							SET @PreviousWorkQueueLkup = @MostRecentQueueLkup
						END
					
					IF(@DiscrepancyCategoryLkup IN (6001,6002) AND @MostRecentStatusLkup <> 20003) --OOA and SCC Cases
					BEGIN

						--set next queue
						SET @NextQueueLkup = (CASE WHEN @DiscrepancyCategoryLkup = 6001 THEN 10006 ELSE (CASE WHEN @DiscrepancyCategoryLkup = 6002 THEN 10021 ELSE NULL END) END)
						SET @NextStatusLkup = 20002 --in progress

						--update queue and status
						UPDATE [dbo].[GEN_Queue] SET
						 [LockedByRef]=NULL
						,[UTCLockedOn]=NULL
						,[UTCLockedOnId]=NULL
						,[UTCLockedOnYear]=NULL
						,[UTCLockedOnMonth]=NULL
						,[UTCLockedOnDay]=NULL
						,[CSTLockedOn]=NULL
						,[CSTLockedOnId]=NULL
						,[CSTLockedOnYear]=NULL
						,[CSTLockedOnMonth]=NULL
						,[CSTLockedOnDay]=NULL
						,[MostRecentActionLkup]=28001
						,[MostRecentWorkQueueLkup]=@NextQueueLkup
						,[MostRecentStatusLkup]=@NextStatusLkup
						,[PreviousWorkQueueLkup]=@PreviousWorkQueueLkup
						,[PreviousAuditWorkQueueLkup]=null
						,[IsExtendTrackingRequired]=0
						,[IsMARxAddressCompleted]=0
						,[IsAddressScrubCompleted]=0
						,[IsCasePended]=0
						,[PendedbyRef]= null
						,[UTCPendedOn]= null
						,[UTCPendedOnId]= null
						,[UTCPendedOnYear]= null
						,[UTCPendedOnMonth]= null
						,[UTCPendedOnDay]= null
						,[CSTPendedOn]= null
						,[CSTPendedOnId]= null
						,[CSTPendedOnYear]= null
						,[CSTPendedOnMonth]= null
						,[CSTPendedOnDay]= null
						,[IsCaseResolved]= 0
						,[ResolvedByRef]= null
						,[UTCResolvedOn]= null
						,[UTCResolvedOnId]= null
						,[UTCResolvedOnYear]= null
						,[UTCResolvedOnMonth]= null
						,[UTCResolvedOnDay]= null
						,[CSTResolvedOn]= null
						,[CSTResolvedOnId]= null
						,[CSTResolvedOnYear]= null
						,[CSTResolvedOnMonth]= null
						,[CSTResolvedOnDay]= null
						,[UTCLastUpdatedOn]= @UTCDate
						,[UTCLastUpdatedOnId]= FORMAT(@UTCDate, 'yyyyMMdd')
						,[UTCLastUpdatedOnYear]= FORMAT(@UTCDate, 'yyyy')
						,[UTCLastUpdatedOnMonth]= FORMAT(@UTCDate, 'MM')
						,[UTCLastUpdatedOnDay]= FORMAT(@UTCDate, 'dd')
						,[CSTLastUpdatedOn]= DATEADD(hh, -6, @UTCDate)
						,[CSTLastUpdatedOnId]= FORMAT(DATEADD(hh, -6, @UTCDate), 'yyyyMMdd')
						,[CSTLastUpdatedOnYear]= FORMAT(DATEADD(hh, -6, @UTCDate), 'yyyy')
						,[CSTLastUpdatedOnMonth]= FORMAT(DATEADD(hh, -6, @UTCDate), 'MM')
						,[CSTLastUpdatedOnDay]= FORMAT(DATEADD(hh, -6, @UTCDate), 'dd')
						,[LastUpdatedByRef] =@LoginUserId
						WHERE [GEN_QueueId] = @tempErsCaseId

						--- Insert record into Manage cases
						INSERT INTO [dbo].[GEN_ManageCases]([GEN_QueueRef],[ActionPerformedLkup],[CurrentUserRef],[CasesComments],[ReAssignUserRef],[IsActive],[UTCCreatedOn],
										[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef])
						VALUES(@tempErsCaseId,28001,@LoginUserId,NULL,NULL,1,@UTCDate,@LoginUserId,@UTCDate,@LoginUserId)

						--- Insert record into Gen_Queue Workflow correlation
						INSERT INTO [dbo].[GEN_QueueWorkFlowCorrelation]
						([GEN_QueueRef],[RoleLkup],[WorkBasketLkup],[DiscrepancyCategoryLkup],[PreviousActionLkup],[PreviousWorkQueuesLkup],
							[PreviousStatusLkup],[CurrentActionLkup],[CurrentWorkQueuesLkup],[CurrentStatusLkup],[IsActive],[UTCCreatedOn],
							[CreatedByRef])
						VALUES(@tempErsCaseId,2003,3001,@DiscrepancyCategoryLkup,@MostRecentActionLkup,@MostRecentQueueLkup,@MostRecentStatusLkup,
							28001,@NextQueueLkup,@NextStatusLkup,1,@UTCDate,@LoginUserId)
					END

					FETCH NEXT FROM MiimRef_Cursor INTO @tempErsCaseId,@tempMiimReferenceId;
				END;  
			CLOSE MiimRef_Cursor;
			DEALLOCATE MiimRef_Cursor;  
			
		COMMIT TRAN ADDCOMMENTS
			
	END TRY
	BEGIN CATCH		
		ROLLBACK TRAN ADDCOMMENTS;
		INSERT INTO [dbo].[CMN_AppErrorLog] (ADM_UserMasterRef,[ErrorLocation],[ErrorSourceLkup],[ErrorMessage],[ErrorDescription],[UTCErrorDateTime],[UTCCreatedOn])
		VALUES(@LoginUserId,'[dbo].[USP_APP_UPD_UpdateOOAComments]',null,ERROR_NUMBER(),ERROR_MESSAGE(),GETUTCDATE(),GETUTCDATE())
	END CATCH 
END


GO

