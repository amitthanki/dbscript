
IF OBJECT_ID ('USP_APP_UPD_HoldingQueues_PendingFTT_AddressScrubLetter') IS NOT NULL 
BEGIN
	DROP PROC [dbo].[USP_APP_UPD_HoldingQueues_PendingFTT_AddressScrubLetter]
END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: Rakesh
-- Create date: 08/14/2017
-- Modified By: 
-- Modification Date: 
-- Description: Update Cases in Pending FTT queue to Open DisEnroll based on Disenrollment Date
-- Eg.
-- Exec [USP_APP_UPD_HoldingQueues_PendingFTT_AddressScrubLetter]
-- =============================================
CREATE PROC [dbo].[USP_APP_UPD_HoldingQueues_PendingFTT_AddressScrubLetter]
as
BEGIN	
	Declare @UTCDate DATETIME = GETUTCDATE()
	Declare @LoginUserId BIGINT = 22 -- SISS Admin Holding Queue
	Declare @RoleLkup BIGINT = 2001 -- Admin
	Declare @IsMARxAddressCompleted BIT = 1

	BEGIN TRY  
		BEGIN TRAN PendingFTT_AddressScrubLetter
		
  SELECT GQ.[GEN_QueueId],GQ.[WorkBasketLkup],GQ.[DiscrepancyCategoryLkup],GQ.[AssignedToRef],GQ.[PreviousAssignedToRef],GQ.[MostRecentWorkQueueLkup],GQ.[DiscrepancySourceLkup],
			GQ.[MostRecentStatusLkup],GQ.[MostRecentActionLkup],GQ.[PreviousWorkQueueLkup],GQ.[PreviousAuditWorkQueueLkup],GQ.[LockedByRef],GQ.[UTCLockedOn]
	 	INTO dbo.[#TGEN_Queue]
		FROM [dbo].[GEN_Queue] GQ  WITH(NOLOCK)
		LEFT JOIN [dbo].[GEN_OSTActions] GOST WITH(NOLOCK) ON GOST.[GEN_QueueRef] = GQ.[GEN_QueueId]
		WHERE GQ.[MostRecentWorkQueueLkup] = 10012 AND
			(GQ.[MostRecentStatusLkup] = 20001 OR GQ.[MostRecentStatusLkup] = 20002) AND GQ.[IsActive]=1 AND			
			GOST.[FirstLetterMailDate] IS NOT NULL AND GOST.[SecondLetterMailDate] IS NOT NULL AND
			(GQ.[DiscrepancySourceLkup]=13001 AND GQ.TRCLkup = 22005 and TRCLkup <> 22006 AND GQ.CreatedByRef=16 AND GQ.MemberSCCCode IS NULL) AND
			((GQ.[IsMARxAddressCompleted] = 1 AND GQ.TRCLkup <> 22006) OR ((GQ.[IsMARxAddressCompleted] IS NULL OR GQ.[IsMARxAddressCompleted] =0) AND GQ.TRCLkup = 22006)) AND (GQ.[IsAddressScrubCompleted] IS NULL OR GQ.[IsAddressScrubCompleted] = 0) AND
			--GQ.[LockedByRef] IS NULL AND GQ.[UTCLockedOn] IS NULL AND
			GQ.[IsCasePended] = 0 AND GQ.[PendedbyRef] IS NULL AND GQ.[UTCPendedOn] IS NULL AND
			GQ.[IsCaseResolved] = 0 AND GQ.[ResolvedByRef] IS NULL AND GQ.[UTCResolvedOn] IS NULL 
	ORDER BY GQ.[GEN_QueueId]

		DELETE RL 
		FROM [CMN_RecordsLocked] RL 
		INNER JOIN dbo.[#TGEN_Queue] TGQ ON TGQ.[GEN_QueueId] = RL.[CaseId] AND RL.ScreenLkup = 37010
		WHERE TGQ.[UTCLockedOn] IS NOT NULL AND TGQ.[LockedByRef] IS NOT NULL

		UPDATE GQ SET 
		GQ.[LockedByRef] = @LoginUserId
		,GQ.[UTCLockedOn]=@UTCDate
		,GQ.[UTCLockedOnId]=FORMAT(@UTCDate, 'yyyyMMdd')
		,GQ.[UTCLockedOnYear]=FORMAT(@UTCDate, 'yyyy')
		,GQ.[UTCLockedOnMonth]=FORMAT(@UTCDate, 'MM')
		,GQ.[UTCLockedOnDay]=FORMAT(@UTCDate, 'dd')
		,GQ.[CSTLockedOn]=DATEADD(hh, -6, @UTCDate)
		,GQ.[CSTLockedOnId]=FORMAT(DATEADD(hh, -6, @UTCDate), 'yyyyMMdd')
		,GQ.[CSTLockedOnYear]=FORMAT(DATEADD(hh, -6, @UTCDate), 'yyyy')
		,GQ.[CSTLockedOnMonth]=FORMAT(DATEADD(hh, -6, @UTCDate), 'MM')
		,GQ.[CSTLockedOnDay]=FORMAT(DATEADD(hh, -6, @UTCDate), 'dd')
		FROM [dbo].[GEN_Queue] GQ 
		INNER JOIN dbo.[#TGEN_Queue] TGQ ON TGQ.[GEN_QueueId] = GQ.[GEN_QueueId]
		--WHERE GQ.[LockedByRef] IS NULL AND GQ.[UTCLockedOn] IS NULL

		INSERT INTO [dbo].[CMN_RecordsLocked]([ScreenLkup],[CaseId],[StartTime],[Guid],[IsActive],[UTCCreatedOn],[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef])
		SELECT 37010,TGQ.[GEN_QueueId],@UTCDATE,NEWID(),1,@UTCDATE,@LoginUserId,@UTCDATE,@LoginUserId
		FROM dbo.[#TGEN_Queue] TGQ
		--WHERE TGQ.[LockedByRef] IS NULL AND TGQ.[UTCLockedOn] IS NULL

		Declare @MostRecentQueueLkup BIGINT = NULL
		Declare @MostRecentStatusLkup BIGINT = NULL
		Declare @MostRecentActionLkup BIGINT = NULL
		Declare @NextQueueLkup BIGINT = NULL
		Declare @NextStatusLkup BIGINT = NULL
		Declare @WorkBasketLkup BIGINT = NULL
		Declare @DiscrepancyCategoryLkup BIGINT = NULL
		Declare @AssignedToRef BIGINT = NULL
		Declare @ActionLkup BIGINT = NULL		
		Declare @IsActive BIT = 1

		DECLARE @GEN_QueueId BIGINT = 0
		WHILE(1 = 1)
			BEGIN
				SELECT @GEN_QueueId = MIN(GEN_QueueId)
				FROM dbo.[#TGEN_Queue] WHERE GEN_QueueId > @GEN_QueueId

				IF @GEN_QueueId IS NULL
					BREAK

				SET @NextQueueLkup = NULL
				SET @NextStatusLkup = NULL
				SET @ActionLkup = 28053 --Requires Address Scrub

				SELECT @WorkBasketLkup=[WorkBasketLkup],@DiscrepancyCategoryLkup=[DiscrepancyCategoryLkup],@AssignedToRef=[AssignedToRef],@MostRecentQueueLkup=[MostRecentWorkQueueLkup],
				@MostRecentStatusLkup=[MostRecentStatusLkup],@MostRecentActionLkup=[MostRecentActionLkup]
				FROM dbo.[#TGEN_Queue]
				WHERE [GEN_QueueId]=@GEN_QueueId

				SELECT @NextQueueLkup=[NextWorkQueueLkup],@NextStatusLkup=[NextStatusLkup] FROM [dbo].[GEN_WorkFlowMaster] WHERE [CurrentWorkQueueLkup]=@MostRecentQueueLkup AND [CurrentActionLkup]=@ActionLkup

				UPDATE [dbo].[GEN_Queue] 
				SET 
				MostRecentWorkQueueLkup = @NextQueueLkup,
				MostRecentActionLkup = @ActionLkup,
				MostRecentStatusLkup = @NextStatusLkup,
				IsMARxAddressCompleted = @IsMARxAddressCompleted,
				LockedByRef=NULL,
				UTCLockedOn=NULL,
				UTCLockedOnId=NULL,
				UTCLockedOnYear=NULL,
				UTCLockedOnMonth=NULL,
				UTCLockedOnDay=NULL,
				CSTLockedOn=NULL,
				CSTLockedOnId=NULL,
				CSTLockedOnYear=NULL,
				CSTLockedOnMonth=NULL,
				CSTLockedOnDay=NULL,
				UTCLastUpdatedOn = @UTCDate,
				UTCLastUpdatedOnId = FORMAT(@UTCDate, 'yyyyMMdd'),
				UTCLastUpdatedOnYear = FORMAT(@UTCDate, 'yyyy'),
				UTCLastUpdatedOnMonth = FORMAT(@UTCDate, 'MM'),
				UTCLastUpdatedOnDay = FORMAT(@UTCDate, 'dd'),
				CSTLastUpdatedOn = DATEADD(hh, -6, @UTCDate),
				CSTLastUpdatedOnId = FORMAT(DATEADD(hh, -6, @UTCDate), 'yyyyMMdd'),
				CSTLastUpdatedOnYear = FORMAT(DATEADD(hh, -6, @UTCDate), 'yyyy'),
				CSTLastUpdatedOnMonth = FORMAT(DATEADD(hh, -6, @UTCDate), 'MM'),
				CSTLastUpdatedOnDay = FORMAT(DATEADD(hh, -6, @UTCDate), 'dd'),
				LastUpdatedByRef = @LoginUserId
				WHERE [GEN_QueueId]=@GEN_QueueId

				UPDATE [dbo].[GEN_OSTActions] 
				SET [ActionLkup]=@ActionLkup,[IsActive]=@IsActive,[PendReasonLkup]=30022,--Pend Reason - Address Scrub
				[UTCLastUpdatedOn]=@UTCDate,[LastUpdatedByRef]=@LoginUserId
				WHERE [GEN_QueueRef] = @GEN_QueueId
			
				--- Insert record into Manage cases
				INSERT INTO [dbo].[GEN_ManageCases]([GEN_QueueRef],[ActionPerformedLkup],[CurrentUserRef],[CasesComments],[ReAssignUserRef],[IsActive],[UTCCreatedOn],
								[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef])
				VALUES(@GEN_QueueId,@ActionLkup,@LoginUserId,NULL,NULL,@IsActive,@UTCDate,@LoginUserId,@UTCDate,@LoginUserId)
			
				--- Insert record into Gen_Queue Workflow correlation
				INSERT INTO [dbo].[GEN_QueueWorkFlowCorrelation]
				([GEN_QueueRef],[RoleLkup],[WorkBasketLkup],[DiscrepancyCategoryLkup],[PreviousActionLkup],[PreviousWorkQueuesLkup],
					[PreviousStatusLkup],[CurrentActionLkup],[CurrentWorkQueuesLkup],[CurrentStatusLkup],[IsActive],[UTCCreatedOn],
					[CreatedByRef])
				VALUES(@GEN_QueueId,@RoleLkup,@WorkBasketLkup,@DiscrepancyCategoryLkup,@MostRecentActionLkup,@MostRecentQueueLkup,@MostRecentStatusLkup,
					@ActionLkup,@NextQueueLkup,@NextStatusLkup,@IsActive,@UTCDate,@LoginUserId)

				-----------Unlock record BEGIN-----------
				--37010 = Queue Screen
				DELETE FROM CMN_RecordsLocked WHERE [ScreenLkup]=37010 AND [CaseId]=@GEN_QueueId
				-----------Unlock record END-----------
			END
		COMMIT TRAN PendingFTT_AddressScrubLetter
	END TRY
	BEGIN CATCH		
			ROLLBACK TRAN PendingFTT_OpenDisEnroll;
			INSERT INTO [dbo].[CMN_AppErrorLog] (ADM_UserMasterRef,[ErrorLocation],[ErrorSourceLkup],[ErrorMessage],[ErrorDescription],[UTCErrorDateTime],[UTCCreatedOn])
			VALUES(@LoginUserId,'[dbo].[USP_APP_UPD_HoldingQueues_PendingFTT_AddressScrubLetter]',null,ERROR_NUMBER(),ERROR_MESSAGE(),GETUTCDATE(),GETUTCDATE())

	END CATCH 
END