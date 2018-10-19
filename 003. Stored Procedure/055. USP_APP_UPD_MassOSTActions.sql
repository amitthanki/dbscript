IF OBJECT_ID ('USP_APP_UPD_MassOSTActions') IS NOT NULL 
BEGIN
	DROP PROC [dbo].[USP_APP_UPD_MassOSTActions]
END
GO

/****** Object:  StoredProcedure [dbo].[USP_APP_UPD_MassOSTActions]    Script Date: 04-07-2017 16:46:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: Rakesh
-- Create date: 07/04/2017
-- Modified By: 
-- Modification Date: 
-- Description: Get Pended records from the queue within the date range
-- Eg.
-- Declare @ErrorMessage VARCHAR(2000)
-- Set @ErrorMessage=''
-- Exec [USP_APP_UPD_MassOSTActions] @ErrorMessage = @ErrorMessage Output
-- =============================================
CREATE PROCEDURE [dbo].[USP_APP_UPD_MassOSTActions]
@QueueIds VARCHAR(MAX),
@ActionLkup BIGINT,
@LastName VARCHAR(35)=NULL,
@DateofBirth DATETIME =NULL,
@ContractIDLkup BIGINT=NULL,
@PBPLkup BIGINT=NULL,
@ApplicationDate DATETIME=NULL,
@EffectiveDate DATETIME=NULL,
@EndDate DATETIME=NULL,
@FirstLetterMailDate DATETIME=NULL,
@SecondLetterMailDate DATETIME=NULL,
@ResidentialDocumentationRequired BIT=NULL,
@CountyAttestationRequired BIT=NULL,
@PendReasonLkup BIGINT=NULL,
@ContainsErrorsLkup BIGINT=NULL,
@ResolutionLkup BIGINT=NULL,
@Reason VARCHAR(20)=NULL,
@InitialAddressVerificationDate DATETIME =NULL,
@MemberResponseVerificationDate DATETIME =NULL,
@MemberVerifiedState VARCHAR(5)=NULL,
@SCCLetterMailDate DATETIME =NULL,
@IsActive BIT,
@Comments VARCHAR(4000) = NULL,
@LoginUserId BIGINT,
@RoleLkup BIGINT,
@RPRRequestedEffectiveDate Datetime=null,
@RPRActionRequestedLkup BIGINT=null,
@RPROtherActionRequested Varchar(50)=null,
@RPRSupervisorOrRequesterRef BIGINT=null,
@RPRReasonforRequest Varchar(2000)=null,
@RPRTaskPerformedLkup BIGINT=null,
@RPROtherTaskPerformed Varchar(50)=null,
@RPRCTMMember bit=null,
@RPRCTMNumber Varchar(20)=null,
@RPREGHPMember bit=null,
@RPREmployerID Varchar(20)=null,
@SCCRPRRequested varchar(50)=null,
@SCCRPRRequestedZip varchar(11)=null,
@SCCRPRRequstedSubmissionDate datetime=null,
@CommentsSourceSystemLkup bigint = 0,
@AdjustedDiscrepancyReceiptDate DATETIME = NULL,
@AdjustedComplianceStartDate DATETIME = NULL,
@MARxAddressResolutionLkup BIGINT=null,
@PDPAutoEnrolleeInd bit=NULL,
@ErrorMessage VARCHAR(2000) OUT
AS
BEGIN
BEGIN TRY  
		BEGIN TRAN OSTACTIONS
			Declare @UTCDate DATETIME = GETUTCDATE()
			Declare @MostRecentQueueLkup BIGINT = NULL
			Declare @MostRecentStatusLkup BIGINT = NULL
			Declare @MostRecentActionLkup BIGINT = NULL
			Declare @NextQueueLkup BIGINT = NULL
			Declare @NextStatusLkup BIGINT = NULL
			Declare @IsCasePended BIT = 0
			Declare @IsCaseResolved BIT = 0
			Declare @IsExtendTrackingRequired BIT = 0
			Declare @WorkBasketLkup BIGINT = NULL
			Declare @DiscrepancyCategoryLkup BIGINT = NULL
			Declare @PreviousWorkQueueLkup BIGINT = NULL
			Declare @PreviousAuditWorkQueueLkup BIGINT = NULL
			Declare @PendedWorkQueueLkup BIGINT = NULL
			Declare @PreviousAssignedToRef BIGINT = NULL
			Declare @AssignedToRef BIGINT = NULL
			Declare @IsMARxAddressCompleted BIT = NULL
			Declare @IsAddressScrubCompleted BIT = NULL
			Declare @ChildQueueRef BIGINT = NULL

			SELECT Item as GEN_QueueId 
			INTO dbo.[#TGEN_QueueId]
			FROM SplitString(@QueueIds,',') WHERE Item <>''

			SELECT GQ.[GEN_QueueId],GQ.[WorkBasketLkup],GQ.[DiscrepancyCategoryLkup],GQ.[AssignedToRef],GQ.[PreviousAssignedToRef],GQ.[MostRecentWorkQueueLkup],
			GQ.[MostRecentStatusLkup],GQ.[MostRecentActionLkup],GQ.[PreviousWorkQueueLkup],GQ.[PreviousAuditWorkQueueLkup],GQ.[LockedByRef],GQ.[UTCLockedOn]
			INTO dbo.[#TGEN_Queue]
			FROM [dbo].[GEN_Queue] GQ INNER JOIN dbo.[#TGEN_QueueId] T ON T.GEN_QueueId = GQ.GEN_QueueId
			WHERE GQ.[LockedByRef] IS NULL AND GQ.[UTCLockedOn] IS NULL

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
		   WHERE TGQ.[LockedByRef] IS NULL AND TGQ.[UTCLockedOn] IS NULL

		   	INSERT INTO [dbo].[CMN_RecordsLocked]([ScreenLkup],[CaseId],[StartTime],[Guid],[IsActive],[UTCCreatedOn],[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef])
			SELECT 37010,TGQ.[GEN_QueueId],@UTCDATE,NEWID(),1,@UTCDATE,@LoginUserId,@UTCDATE,@LoginUserId
			FROM dbo.[#TGEN_Queue] TGQ
			WHERE TGQ.[LockedByRef] IS NULL AND TGQ.[UTCLockedOn] IS NULL

			DECLARE @GEN_QueueId BIGINT = 0
			WHILE(1 = 1)
			BEGIN
				SELECT @GEN_QueueId = MIN(GEN_QueueId)
				FROM dbo.[#TGEN_Queue] WHERE GEN_QueueId > @GEN_QueueId AND [LockedByRef] IS NULL AND [UTCLockedOn] IS NULL

				IF @GEN_QueueId IS NULL
					BREAK
					
				SET @NextQueueLkup = NULL
				SET @NextStatusLkup = NULL
				SET @IsCasePended = 0
				SET @IsCaseResolved = 0
				SET @PendedWorkQueueLkup = NULL

				SELECT @WorkBasketLkup=[WorkBasketLkup],@DiscrepancyCategoryLkup=[DiscrepancyCategoryLkup],@PreviousAssignedToRef=[PreviousAssignedToRef],@MostRecentQueueLkup=[MostRecentWorkQueueLkup],
				@MostRecentStatusLkup=[MostRecentStatusLkup],@MostRecentActionLkup=[MostRecentActionLkup],@PreviousWorkQueueLkup=[PreviousWorkQueueLkup],@PreviousAuditWorkQueueLkup=[PreviousAuditWorkQueueLkup]
				FROM dbo.[#TGEN_Queue]
				WHERE [GEN_QueueId]=@GEN_QueueId

				--Set login user id for assigned to ref
				SET @AssignedToRef = @LoginUserId
			
				IF(@ActionLkup = 28007) -- Action - Pend Case
					BEGIN
						IF(@MostRecentQueueLkup != 10010 AND @MostRecentQueueLkup != 10025 AND @MostRecentQueueLkup != 10090)
						BEGIN
							SET @PreviousWorkQueueLkup = @MostRecentQueueLkup
						END
					END
				ELSE IF(@ActionLkup = 28002) -- 28002 = Action - Close Case / 28013 = Action - SCC RPR Required / 28016 = Action - Send SCC Letter / 28026 = Action - Update GPS / 28029 = Action - Close & Mailing Address Not Verified
					BEGIN
						SET @IsCaseResolved = 1
					END
				ELSE IF(@ActionLkup = 28018 AND @PreviousAuditWorkQueueLkup IS NULL) -- Action - Send to Peer Audit
					BEGIN
						SET @PreviousAssignedToRef = @LoginUserId
						IF(@MostRecentQueueLkup = 10010 OR @MostRecentQueueLkup = 10025 OR @MostRecentQueueLkup = 10090) -- Pended Queue Lkup for OOA, SCC and TRR
							BEGIN
								SET @PreviousAuditWorkQueueLkup = @PreviousWorkQueueLkup
							END
						ELSE
							BEGIN
								SET @PreviousAuditWorkQueueLkup = @MostRecentQueueLkup
							END					
					END
				ELSE IF(@ActionLkup = 28046)
					BEGIN
						SET @IsMARxAddressCompleted = 1
					END
				ELSE IF(@ActionLkup = 28047)
					BEGIN
						SET @IsAddressScrubCompleted = 1
					END
			
				IF(@MostRecentQueueLkup = 10010 OR @MostRecentQueueLkup = 10025 OR @MostRecentQueueLkup = 10090) -- Pended Queue Lkup for OOA, SCC and TRR
					BEGIN
						IF(@ActionLkup = 28007 OR @ActionLkup = 28001) --Action - Pend Case / Action - Add Comments
							BEGIN
								SET @IsCasePended = 1
								SET @PendedWorkQueueLkup = @MostRecentQueueLkup
							END
						ELSE
							BEGIN
								SET @IsCasePended = 0

								SET @PendedWorkQueueLkup = @MostRecentQueueLkup
								SET @MostRecentQueueLkup = @PreviousWorkQueueLkup
								SET @PreviousWorkQueueLkup = NULL
							END
					END
			
				--GET Next Queue & Status from Workflow master
				IF(@ActionLkup = 28001 OR (@ActionLkup = 28007 AND (@MostRecentQueueLkup = 10010 OR @MostRecentQueueLkup = 10025 OR @MostRecentQueueLkup = 10090))) --28001- Add Comments / 28007- Pend Case
					BEGIN
						SET @NextQueueLkup = @MostRecentQueueLkup
						SET @NextStatusLkup = @MostRecentStatusLkup
					END
				ELSE IF(@ActionLkup = 28015) -- Send OOA Letter
					BEGIN
						SET @NextQueueLkup = @MostRecentQueueLkup
						SET @NextStatusLkup = 20002 --In Progress
					END
				ELSE IF(@ActionLkup = 28006) -- Peer Audit Completed
					BEGIN
						IF(@ContainsErrorsLkup = 1)
							BEGIN
								SET @NextQueueLkup = CASE WHEN @DiscrepancyCategoryLkup = 6001 THEN 10094 
														ELSE CASE WHEN @DiscrepancyCategoryLkup = 6002 THEN 10095
															ELSE CASE WHEN @DiscrepancyCategoryLkup = 6003 THEN 10096 END
														END
													 END

								SET @NextStatusLkup = 20002 -- Status - IN PROGRESS
								SET @AssignedToRef = @PreviousAssignedToRef
							END
						ELSE
							BEGIN
								SET @NextQueueLkup = @PreviousAuditWorkQueueLkup
								SET @NextStatusLkup = @MostRecentStatusLkup
								SET @PreviousAuditWorkQueueLkup = NULL
							END
					END
				ELSE
					BEGIN
						SELECT @NextQueueLkup=[NextWorkQueueLkup],@NextStatusLkup=[NextStatusLkup] FROM [dbo].[GEN_WorkFlowMaster] WHERE [CurrentWorkQueueLkup]=@MostRecentQueueLkup AND [CurrentActionLkup]=@ActionLkup
					END
			
				IF NOT EXISTS(SELECT TOP 1 * FROM [dbo].[GEN_OSTActions] WHERE [GEN_QueueRef]=@GEN_QueueId)
					BEGIN
						INSERT INTO [dbo].[GEN_OSTActions]
								([GEN_QueueRef],[ActionLkup],[LastName],[DateofBirth],[ContractIDLkup],[PBPLkup],[ApplicationDate],[EffectiveDate],
								[EndDate],[FirstLetterMailDate],[FirstLetterMailDateId],[SecondLetterMailDate],[SecondLetterMailDateId],[ResidentialDocumentationRequired],[CountyAttestationRequired],
								[PendReasonLkup],[ContainsErrorsLkup],[ResolutionLkup],[Reason],[InitialAddressVerificationDate],[InitialAddressVerificationDateId],
								[MemberResponseVerificationDate],[MemberVerifiedState],[SCCLetterMailDate],[SCCLetterMailDateId],
								[AdjustedComplianceStartDate],[AdjustedComplianceStartDateId],[AdjustedDiscrepancyReceiptDate],[AdjustedDiscrepancyReceiptDateId],
								[MARxAddressResolutionLkup],[PDPAutoEnrolleeInd],[IsActive],[UTCCreatedOn],[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef])
						VALUES  (@GEN_QueueId,@MostRecentActionLkup,@LastName,@DateofBirth,@ContractIDLkup,@PBPLkup,@ApplicationDate,
								 @EffectiveDate,@EndDate,@FirstLetterMailDate,FORMAT(@FirstLetterMailDate, 'yyyyMMdd'),@SecondLetterMailDate,FORMAT(@SecondLetterMailDate, 'yyyyMMdd'),@ResidentialDocumentationRequired,
								 @CountyAttestationRequired,@PendReasonLkup,@ContainsErrorsLkup,@ResolutionLkup,@Reason,@InitialAddressVerificationDate,FORMAT(@InitialAddressVerificationDate, 'yyyyMMdd'),
								 @MemberResponseVerificationDate,@MemberVerifiedState,@SCCLetterMailDate,FORMAT(@SCCLetterMailDate, 'yyyyMMdd'),
								 @AdjustedComplianceStartDate,FORMAT(@AdjustedComplianceStartDate, 'yyyyMMdd'),@AdjustedDiscrepancyReceiptDate,FORMAT(@AdjustedDiscrepancyReceiptDate, 'yyyyMMdd'),
								 @MARxAddressResolutionLkup,@PDPAutoEnrolleeInd,1,@UTCDate,@LoginUserId,@UTCDate,@LoginUserId)
					END
				ELSE
					BEGIN
						IF(@ActionLkup = 28046 AND @DiscrepancyCategoryLkup = 6003)
							SET @PendReasonLkup = NULL
						IF(@ActionLkup = 28047 AND (@DiscrepancyCategoryLkup = 6001 OR @DiscrepancyCategoryLkup = 6002))
							SET @PendReasonLkup = NULL	

						UPDATE [dbo].[GEN_OSTActions] SET 
						[ActionLkup]=ISNULL(@ActionLkup,[ActionLkup]),
						[LastName]=ISNULL(@LastName,[LastName]),
						[DateofBirth]=ISNULL(@DateofBirth,[DateofBirth]),
						[ContractIDLkup]=ISNULL(@ContractIDLkup,[ContractIDLkup]),
						[PBPLkup]=ISNULL(@PBPLkup,[PBPLkup]),
						[ApplicationDate]=ISNULL(@ApplicationDate,[ApplicationDate]),
						[EffectiveDate]=ISNULL(@EffectiveDate,[EffectiveDate]),
						[EndDate]=ISNULL(@EndDate,[EndDate]),
						[ResidentialDocumentationRequired]=ISNULL(@ResidentialDocumentationRequired,[ResidentialDocumentationRequired]),
						[CountyAttestationRequired]=ISNULL(@CountyAttestationRequired,[CountyAttestationRequired]),
						[PendReasonLkup]= CASE WHEN (@ActionLkup = 28046 OR @ActionLkup = 28047) THEN @PendReasonLkup ELSE ISNULL(@PendReasonLkup,[PendReasonLkup]) END,
						[ContainsErrorsLkup]=ISNULL(@ContainsErrorsLkup,[ContainsErrorsLkup]),
						[ResolutionLkup]=ISNULL(@ResolutionLkup,[ResolutionLkup]),
						[Reason]=ISNULL(@Reason,[Reason]),
						[MemberVerifiedState]=ISNULL(@MemberVerifiedState,[MemberVerifiedState]),
						[FirstLetterMailDate]=ISNULL(@FirstLetterMailDate,[FirstLetterMailDate]),
						[FirstLetterMailDateId]= CASE WHEN @FirstLetterMailDate IS NULL THEN [FirstLetterMailDateId] ELSE FORMAT(@FirstLetterMailDate, 'yyyyMMdd') END,
						[SecondLetterMailDate]=ISNULL(@SecondLetterMailDate,[SecondLetterMailDate]),
						[SecondLetterMailDateId]= CASE WHEN @SecondLetterMailDate IS NULL THEN [SecondLetterMailDateId] ELSE FORMAT(@SecondLetterMailDate, 'yyyyMMdd') END,
						[InitialAddressVerificationDate]=ISNULL(@InitialAddressVerificationDate,[InitialAddressVerificationDate]),
						[InitialAddressVerificationDateId]= CASE WHEN @InitialAddressVerificationDate IS NULL THEN [InitialAddressVerificationDateId] ELSE FORMAT(@InitialAddressVerificationDate, 'yyyyMMdd') END,
						[MemberResponseVerificationDate]=ISNULL(@MemberResponseVerificationDate,[MemberResponseVerificationDate]),
						[MemberResponseVerificationDateId]= CASE WHEN @MemberResponseVerificationDate IS NULL THEN [MemberResponseVerificationDateId] ELSE FORMAT(@MemberResponseVerificationDate, 'yyyyMMdd') END,
						[SCCLetterMailDate]=ISNULL(@SCCLetterMailDate,[SCCLetterMailDate]),
						[SCCLetterMailDateId]= CASE WHEN @SCCLetterMailDate IS NULL THEN [SCCLetterMailDateId] ELSE FORMAT(@SCCLetterMailDate, 'yyyyMMdd') END,
						[AdjustedComplianceStartDate]=ISNULL(@AdjustedComplianceStartDate,AdjustedComplianceStartDate),[AdjustedComplianceStartDateId]= CASE WHEN @AdjustedComplianceStartDate IS NULL THEN [AdjustedComplianceStartDateId] ELSE FORMAT(@AdjustedComplianceStartDate, 'yyyyMMdd') END,
						[AdjustedDiscrepancyReceiptDate]=ISNULL(@AdjustedDiscrepancyReceiptDate,[AdjustedDiscrepancyReceiptDate]),[AdjustedDiscrepancyReceiptDateId]= CASE WHEN @AdjustedDiscrepancyReceiptDate IS NULL THEN [AdjustedDiscrepancyReceiptDateId] ELSE FORMAT(@AdjustedDiscrepancyReceiptDate, 'yyyyMMdd') END,
						[MARxAddressResolutionLkup]=ISNULL(@MARxAddressResolutionLkup,[MARxAddressResolutionLkup]),
						[PDPAutoEnrolleeInd]=ISNULL(@PDPAutoEnrolleeInd,[PDPAutoEnrolleeInd]),
						[IsActive]=@IsActive,
						[UTCLastUpdatedOn]=@UTCDate,
						[LastUpdatedByRef]=@LoginUserId
						WHERE [GEN_QueueRef] = @GEN_QueueId
					END
					
				UPDATE [dbo].[GEN_Queue] SET
				 [PreviousAssignedToRef]=@PreviousAssignedToRef
				,[AssignedToRef]=@AssignedToRef
				,[UTCAssignedOn]=@UTCDate
				,[UTCAssignedOnId]=FORMAT(@UTCDate, 'yyyyMMdd')
				,[UTCAssignedOnYear]=FORMAT(@UTCDate, 'yyyy')
				,[UTCAssignedOnMonth]=FORMAT(@UTCDate, 'MM')
				,[UTCAssignedOnDay]=FORMAT(@UTCDate, 'dd')
				,[CSTAssignedOn]=DATEADD(hh, -6, @UTCDate)
				,[CSTAssignedOnId]=FORMAT(DATEADD(hh, -6, @UTCDate), 'yyyyMMdd')
				,[CSTAssignedOnYear]=FORMAT(DATEADD(hh, -6, @UTCDate), 'yyyy')
				,[CSTAssignedOnMonth]=FORMAT(DATEADD(hh, -6, @UTCDate), 'MM')
				,[CSTAssignedOnDay]=FORMAT(DATEADD(hh, -6, @UTCDate), 'dd')
				,[LockedByRef]=NULL
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
				,[MostRecentActionLkup]=@ActionLkup
				,[MostRecentWorkQueueLkup]=@NextQueueLkup
				,[MostRecentStatusLkup]=@NextStatusLkup
				,[PreviousWorkQueueLkup]=@PreviousWorkQueueLkup
				,[PreviousAuditWorkQueueLkup]=@PreviousAuditWorkQueueLkup
				,[IsExtendTrackingRequired]=CASE WHEN (@ActionLkup = 28003) THEN @IsExtendTrackingRequired ELSE [IsExtendTrackingRequired] END
				,[IsMARxAddressCompleted]=CASE WHEN (@ActionLkup = 28046) THEN @IsMARxAddressCompleted ELSE [IsMARxAddressCompleted] END
				,[IsAddressScrubCompleted]=CASE WHEN (@ActionLkup = 28047) THEN @IsAddressScrubCompleted ELSE [IsAddressScrubCompleted] END
				,[OOALetterStatusLkup]=CASE WHEN (@ActionLkup = 28015) THEN 53001 ELSE NULL END --53001 - OOA Letter Status - Ready
				,[IsCasePended]=@IsCasePended
				,[PendedbyRef]= CASE WHEN (@IsCasePended = 0) THEN NULL ELSE @LoginUserId END
				,[UTCPendedOn]= CASE WHEN (@IsCasePended = 0) THEN NULL ELSE @UTCDate END
				,[UTCPendedOnId]= CASE WHEN (@IsCasePended = 0) THEN NULL ELSE FORMAT(@UTCDate, 'yyyyMMdd') END
				,[UTCPendedOnYear]= CASE WHEN (@IsCasePended = 0) THEN NULL ELSE FORMAT(@UTCDate, 'yyyy') END
				,[UTCPendedOnMonth]= CASE WHEN (@IsCasePended = 0) THEN NULL ELSE FORMAT(@UTCDate, 'MM') END
				,[UTCPendedOnDay]= CASE WHEN (@IsCasePended = 0) THEN NULL ELSE FORMAT(@UTCDate, 'dd') END
				,[CSTPendedOn]= CASE WHEN (@IsCasePended = 0) THEN NULL ELSE DATEADD(hh, -6, @UTCDate) END
				,[CSTPendedOnId]= CASE WHEN (@IsCasePended = 0) THEN NULL ELSE FORMAT(DATEADD(hh, -6, @UTCDate), 'yyyyMMdd') END
				,[CSTPendedOnYear]= CASE WHEN (@IsCasePended = 0) THEN NULL ELSE FORMAT(DATEADD(hh, -6, @UTCDate), 'yyyy') END
				,[CSTPendedOnMonth]= CASE WHEN (@IsCasePended = 0) THEN NULL ELSE FORMAT(DATEADD(hh, -6, @UTCDate), 'MM') END
				,[CSTPendedOnDay]= CASE WHEN (@IsCasePended = 0) THEN NULL ELSE FORMAT(DATEADD(hh, -6, @UTCDate), 'dd') END
				,[IsCaseResolved]=@IsCaseResolved
				,[ResolvedByRef]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE @LoginUserId END
				,[UTCResolvedOn]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE @UTCDate END
				,[UTCResolvedOnId]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE FORMAT(@UTCDate, 'yyyyMMdd') END
				,[UTCResolvedOnYear]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE FORMAT(@UTCDate, 'yyyy') END
				,[UTCResolvedOnMonth]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE FORMAT(@UTCDate, 'MM') END
				,[UTCResolvedOnDay]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE FORMAT(@UTCDate, 'dd') END
				,[CSTResolvedOn]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE DATEADD(hh, -6, @UTCDate) END
				,[CSTResolvedOnId]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE FORMAT(DATEADD(hh, -6, @UTCDate), 'yyyyMMdd') END
				,[CSTResolvedOnYear]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE FORMAT(DATEADD(hh, -6, @UTCDate), 'yyyy') END
				,[CSTResolvedOnMonth]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE FORMAT(DATEADD(hh, -6, @UTCDate), 'MM') END
				,[CSTResolvedOnDay]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE FORMAT(DATEADD(hh, -6, @UTCDate), 'dd') END
				,[PeerAuditCompletedDate]=CASE WHEN @ActionLkup = 28006 THEN @UTCDate ELSE [PeerAuditCompletedDate] END
				,[PeerAuditCompletedDateId]=CASE WHEN @ActionLkup = 28006 THEN FORMAT(@UTCDate, 'yyyyMMdd') ELSE [PeerAuditCompletedDateId] END
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
				WHERE [GEN_QueueId] = @GEN_QueueId

				--- Insert record into comments 
				IF(@Comments IS NOT NULL)
				BEGIN
					INSERT INTO [dbo].[GEN_Comments] ([GEN_QueueRef],[Comments],[ActionLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef],[SourceSystemLkup])
					VALUES (@GEN_QueueId,@Comments,@ActionLkup,@IsActive,@UTCDate,@LoginUserId,@UTCDate,@LoginUserId,@CommentsSourceSystemLkup)
				END

				--- Insert record into Manage cases
				INSERT INTO [dbo].[GEN_ManageCases]([GEN_QueueRef],[ActionPerformedLkup],[CurrentUserRef],[CasesComments],[ReAssignUserRef],[IsActive],[UTCCreatedOn],
								[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef])
				VALUES(@GEN_QueueId,@ActionLkup,@LoginUserId,NULL,NULL,@IsActive,@UTCDate,@LoginUserId,@UTCDate,@LoginUserId)
			
				--- Insert record into Gen_Queue Workflow correlation
				INSERT INTO [dbo].[GEN_QueueWorkFlowCorrelation]
				([GEN_QueueRef],[RoleLkup],[WorkBasketLkup],[DiscrepancyCategoryLkup],[PreviousActionLkup],[PreviousWorkQueuesLkup],
					[PreviousStatusLkup],[CurrentActionLkup],[CurrentWorkQueuesLkup],[CurrentStatusLkup],[IsActive],[UTCCreatedOn],
					[CreatedByRef])
				VALUES(@GEN_QueueId,@RoleLkup,@WorkBasketLkup,@DiscrepancyCategoryLkup,@MostRecentActionLkup,ISNULL(@PendedWorkQueueLkup,@MostRecentQueueLkup),@MostRecentStatusLkup,
					@ActionLkup,@NextQueueLkup,@NextStatusLkup,@IsActive,@UTCDate,@LoginUserId)
				
				-----------Unlock record BEGIN-----------
				--37010 = Queue Screen
				DELETE FROM CMN_RecordsLocked WHERE [ScreenLkup]=37010 AND [CaseId]=@GEN_QueueId
				-----------Unlock record END-----------

		  IF(@ActionLkup=28012 OR ((@ActionLkup=28015 OR @ActionLkup=28068) AND (@DiscrepancyCategoryLkup = 6002 OR @DiscrepancyCategoryLkup = 6003))) --28012 - SCC RPR Request / 28015 - Send OOA Letter
		  BEGIN
			  DECLARE @MostRecentWorkQueueLkup BIGINT = NULL 

			  IF(@ActionLkup=28012)
			  BEGIN
				SET @MostRecentWorkQueueLkup = 10070  --RPR - Initial SCC RPR
			  END
			  ELSE IF(@ActionLkup=28015)
			  BEGIN
				SET @MostRecentWorkQueueLkup = 10007  --OOA - New Case
			  END
			  ELSE IF(@ActionLkup=28068)
			  BEGIN
				SET @MostRecentWorkQueueLkup = 10013  --OOA - Pending NOT
			  END

			INSERT INTO [dbo].[GEN_Queue]
					   ([BusinessSegmentLkup]
					   ,[WorkBasketLkup]
					   ,[DiscrepancyCategoryLkup]
					   ,[DiscrepancyTypeLkup]
					   ,[MostRecentActionLkup]
					   ,[MostRecentWorkQueueLkup]
					   ,[MostRecentStatusLkup]
					   ,[PreviousWorkQueueLkup]
					   ,[PreviousAuditWorkQueueLkup]
					   ,[SourceSystemLkup]
					   ,[SourceSystemId]
					   ,[DiscrepancySourceLkup]
					   ,[DiscrepancyReceiptDate]
					   ,[DiscrepancyReceiptDateId]
					   ,[ComplianceStartDate]
					   ,[ComplianceStartDateId]
					   ,[DisenrollmentDate]
					   ,[DiscrepancyStartDate]
					   ,[DiscrepancyStartDateId]
					   ,[DiscrepancyEndDate]
					   ,[DiscrepancyEndDateId]
					   ,[MemberSCCCode]
					   ,[PDPAutoEnrolleeInd]
					   ,[ReferencedEligibilityCaseInd]
					   ,[ReferencedSCCCaseInd]
					   ,[FileTypeLkup]
					   ,[ODMDocID]
					   ,[ODMAddressLink]
					   ,[UndeliveredAddress1]
					   ,[UndeliveredAddress2]
					   ,[UndeliveredCity]
					   ,[UndeliveredState]
					   ,[UndeliveredZip]
					   ,[COAOldAddress1]
					   ,[COAOldAddress2]
					   ,[COAOldCity]
					   ,[COAOldState]
					   ,[COAOldZip]
					   ,[COANewAddress1]
					   ,[COANewAddress2]
					   ,[COANewCity]
					   ,[COANewState]
					   ,[COANewZip]
					   ,[OOALetterStatusLkup]
					   ,[CMSTransactionStatusLkup]
					   ,[MemberID]
					   ,[MemberCurrentHICN]
					   ,[GPSHouseholdID]
					   ,[MemberFirstName]
					   ,[MemberMiddleName]
					   ,[MemberLastName]
					   ,[MemberContractIDLkup]
					   ,[MemberPBPLkup]
					   ,[MemberLOBLkup]
					   ,[MemberVerifiedState]
					   ,[MemberVerifiedCountyCode]
					   ,[MemberDOB]
					   ,[MemberGenderLkup]
					   ,[EligGPSContractIDLkup]
					   ,[EligGPSPBPLkup]
					   ,[EligGPSSCCCode]
					   ,[EligGPSCurrentHICN]
					   ,[EligGPSInsuredPlanEffectiveDate]
					   ,[EligGPSInsuredPlanEffectiveDateId]
					   ,[EligGPSInsuredPlanTermDate]
					   ,[EligGPSInsuredPlanTermDateId]
					   ,[EligGPSLOBLkup]
					   ,[EligGPSMemberDOB]
					   ,[EligGPSMemberDOBId]
					   ,[EligGPSGenderLkup]
					   ,[EligMMRContractIDLkup]
					   ,[EligMMRPBPLkup]
					   ,[EligMMRSCCCode]
					   ,[EligMMRCurrentHICN]
					   ,[EligMMRPaymentAdjustmentStartDate]
					   ,[EligMMRPaymentAdjustmentStartDateId]
					   ,[EligMMRPaymentAdjustmentEndDate]
					   ,[EligMMRPaymentAdjustmentEndDateId]
					   ,[EligMMRPaymentMonth]
					   ,[EligMMRDOB]
					   ,[EligMMRDOBId]
					   ,[EligMMRGenderLkup]
					   ,[EligOOAFlagLkup]
					   ,[RPRRequestedEffectiveDate]
					   ,[RPRRequestedEffectiveDateId]
					   ,[RPRActionRequestedLkup]
					   ,[RPROtherActionRequested]
					   ,[RPRSupervisorOrRequesterRef]
					   ,[RPRReasonforRequest]
					   ,[RPRTaskPerformedLkup]
					   ,[RPROtherTaskPerformed]
					   ,[RPRCTMMember]
					   ,[RPRCTMNumber]
					   ,[RPREGHPMember]
					   ,[RPREmployerID]
					   ,[SCCRPRRequested]
					   ,[SCCRPRRequestedZip]
					   ,[SCCRPRRequstedSubmissionDate]
					   ,[SCCRPRRequstedSubmissionDateId]
					   ,[SCCRPREffectiveStartDate]
					   ,[SCCRPREffectiveStartDateId]
					   ,[SCCRPREffectiveEndDate]
					   ,[SCCRPREffectiveEndDateId]
					   ,[IsCasePended]
					   ,[PendedbyRef]
					   ,[UTCPendedOn]
					   ,[UTCPendedOnId]
					   ,[UTCPendedOnYear]
					   ,[UTCPendedOnMonth]
					   ,[UTCPendedOnDay]
					   ,[CSTPendedOn]
					   ,[CSTPendedOnId]
					   ,[CSTPendedOnYear]
					   ,[CSTPendedOnMonth]
					   ,[CSTPendedOnDay]
					   ,[IsCaseResolved]
					   ,[ResolvedByRef]
					   ,[UTCResolvedOn]
					   ,[UTCResolvedOnId]
					   ,[UTCResolvedOnYear]
					   ,[UTCResolvedOnMonth]
					   ,[UTCResolvedOnDay]
					   ,[CSTResolvedOn]
					   ,[CSTResolvedOnId]
					   ,[CSTResolvedOnYear]
					   ,[CSTResolvedOnMonth]
					   ,[CSTResolvedOnDay]
					   ,[PeerAuditCompletedDate]
					   ,[PeerAuditCompletedDateId]
					   ,[IsParentCase]
					   ,[IsChildCase]
					   ,[ParentQueueRef]
					   ,[IsActive]
					   ,[UTCCreatedOn]
					   ,[UTCCreatedOnId]
					   ,[UTCCreatedOnYear]
					   ,[UTCCreatedOnMonth]
					   ,[UTCCreatedOnDay]
					   ,[CSTCreatedOn]
					   ,[CSTCreatedOnId]
					   ,[CSTCreatedOnYear]
					   ,[CSTCreatedOnMonth]
					   ,[CSTCreatedOnDay]
					   ,[CreatedByRef]
					   ,[UTCLastUpdatedOn]
					   ,[UTCLastUpdatedOnId]
					   ,[UTCLastUpdatedOnYear]
					   ,[UTCLastUpdatedOnMonth]
					   ,[UTCLastUpdatedOnDay]
					   ,[CSTLastUpdatedOn]
					   ,[CSTLastUpdatedOnId]
					   ,[CSTLastUpdatedOnYear]
					   ,[CSTLastUpdatedOnMonth]
					   ,[CSTLastUpdatedOnDay]
					   ,[LastUpdatedByRef]
					   ,[TRCLkup]
					   ,[MemberMedicareId])
				 SELECT
						BusinessSegmentLkup --[BusinessSegmentLkup]
						,CASE WHEN (@ActionLkup=28012) THEN 3003 ELSE 3001 END --[WorkBasketLkup]
						,CASE WHEN (@ActionLkup=28012) THEN 6007 ELSE 6001 END --[DiscrepancyCategoryLkup]
						,CASE WHEN (@ActionLkup=28012) THEN 7011 ELSE 7001 END --[DiscrepancyTypeLkup] -- SCC RPR / Out of Area
						,CASE WHEN (@ActionLkup=28012) THEN 28032 ELSE @ActionLkup END --[MostRecentActionLkup] -- Action - Save / Send OOA Letter / No OOA LTR/Pending NOT
						,@MostRecentWorkQueueLkup --[MostRecentWorkQueueLkup]
						,20001 -- Status - NEW --[MostRecentStatusLkup]
						,NULL --[PreviousWorkQueueLkup]
						,NULL --[PreviousAuditWorkQueueLkup]
						,38001 --[SourceSystemLkup]
						,NULL --[SourceSystemId]
						,DiscrepancySourceLkup --[DiscrepancySourceLkup]
						,CONVERT(date,GetDate()) --[DiscrepancyReceiptDate]
						,FORMAT(GetDate() , 'yyyyMMdd') --[DiscrepancyReceiptDateId]
						,CONVERT(date,GetDate()) --[ComplianceStartDate]
						,FORMAT(GetDate() , 'yyyyMMdd') --[ComplianceStartDateId]
						,CASE WHEN (@ActionLkup=28012) THEN NULL ELSE (CASE WHEN MemberLOBLkup = 31004 THEN DATEADD(Day, -1, DATEADD(month, DATEDIFF(month, 0, DATEADD(Month,6,CONVERT(date, GetDate()))) + 1, 0)) 
																								       ELSE DATEADD(Day, -1, DATEADD(month, DATEDIFF(month, 0, DATEADD(Month,12,CONVERT(date, GetDate()))) + 1, 0)) END) END --[DisenrollmentDate]
						,DateAdd(mm, 1,DateAdd(mm, DateDiff(mm, 1, GetDate()), 0)) --[DiscrepancyStartDate]
						,FORMAT(DateAdd(mm, 1,DateAdd(mm, DateDiff(mm, 1, GetDate()), 0)), 'yyyyMMdd') --[DiscrepancyStartDateId]
						,NULL --[DiscrepancyEndDate]
						,NULL --[DiscrepancyEndDateId]
						,MemberSCCCode --[MemberSCCCode]
						,PDPAutoEnrolleeInd --[PDPAutoEnrolleeInd]
						,ReferencedEligibilityCaseInd --[ReferencedEligibilityCaseInd]
						,ReferencedSCCCaseInd --[ReferencedSCCCaseInd]
						,CASE WHEN (@ActionLkup=28012) THEN NULL ELSE FileTypeLkup END --[FileTypeLkup]
						,CASE WHEN (@ActionLkup=28012) THEN NULL ELSE ODMDocID END --[ODMDocID]
						,CASE WHEN (@ActionLkup=28012) THEN NULL ELSE ODMAddressLink END --[ODMAddressLink]
						,CASE WHEN (@ActionLkup=28012) THEN NULL ELSE UndeliveredAddress1 END --[UndeliveredAddress1]
						,CASE WHEN (@ActionLkup=28012) THEN NULL ELSE UndeliveredAddress2 END --[UndeliveredAddress2]
						,CASE WHEN (@ActionLkup=28012) THEN NULL ELSE UndeliveredCity END --[UndeliveredCity]
						,CASE WHEN (@ActionLkup=28012) THEN NULL ELSE UndeliveredState END --[UndeliveredState]
						,CASE WHEN (@ActionLkup=28012) THEN NULL ELSE UndeliveredZip END --[UndeliveredZip]
						,CASE WHEN (@ActionLkup=28012) THEN NULL ELSE COAOldAddress1 END --[COAOldAddress1]
						,CASE WHEN (@ActionLkup=28012) THEN NULL ELSE COAOldAddress2 END --[COAOldAddress2]
						,CASE WHEN (@ActionLkup=28012) THEN NULL ELSE COAOldCity END --[COAOldCity]
						,CASE WHEN (@ActionLkup=28012) THEN NULL ELSE COAOldState END --[COAOldState]
						,CASE WHEN (@ActionLkup=28012) THEN NULL ELSE COAOldZip END --[COAOldZip]
						,CASE WHEN (@ActionLkup=28012) THEN NULL ELSE COANewAddress1 END --[COANewAddress1]
						,CASE WHEN (@ActionLkup=28012) THEN NULL ELSE COANewAddress2 END --[COANewAddress2]
						,CASE WHEN (@ActionLkup=28012) THEN NULL ELSE COANewCity END --[COANewCity]
						,CASE WHEN (@ActionLkup=28012) THEN NULL ELSE COANewState END --[COANewState]
						,CASE WHEN (@ActionLkup=28012) THEN NULL ELSE COANewZip END --[COANewZip]
						,CASE WHEN (@ActionLkup=28012 OR @ActionLkup=28068) THEN NULL ELSE 53001 END --[OOALetterStatusLkup] -- 53001 - OOA Letter Status - Ready
						,NULL --[CMSTransactionStatusLkup]
						,MemberID --[MemberID]
						,MemberCurrentHICN --[MemberCurrentHICN]
						,GPSHouseholdID --[GPSHouseholdID]
						,MemberFirstName --[MemberFirstName]
						,MemberMiddleName --[MemberMiddleName]
						,MemberLastName --[MemberLastName]
						,MemberContractIDLkup --[MemberContractIDLkup]
						,MemberPBPLkup --[MemberPBPLkup]
						,MemberLOBLkup --[MemberLOBLkup]
						,MemberVerifiedState --[MemberVerifiedState]
						,MemberVerifiedCountyCode --[MemberVerifiedCountyCode]
						,MemberDOB --[MemberDOB]
						,MemberGenderLkup --[MemberGenderLkup]
						,NULL --[EligGPSContractIDLkup]
						,NULL --[EligGPSPBPLkup]
						,NULL --[EligGPSSCCCode]
						,NULL --[EligGPSCurrentHICN]
						,NULL --[EligGPSInsuredPlanEffectiveDate]
						,NULL --[EligGPSInsuredPlanEffectiveDateId]
						,NULL --[EligGPSInsuredPlanTermDate]
						,NULL --[EligGPSInsuredPlanTermDateId]
						,NULL --[EligGPSLOBLkup]
						,NULL --[EligGPSMemberDOB]
						,NULL --[EligGPSMemberDOBId]
						,NULL --[EligGPSGenderLkup]
						,NULL --[EligMMRContractIDLkup]
						,NULL --[EligMMRPBPLkup]
						,NULL --[EligMMRSCCCode]
						,NULL --[EligMMRCurrentHICN]
						,NULL --[EligMMRPaymentAdjustmentStartDate]
						,NULL --[EligMMRPaymentAdjustmentStartDateId]
						,NULL --[EligMMRPaymentAdjustmentEndDate]
						,NULL --[EligMMRPaymentAdjustmentEndDateId]
						,NULL --[EligMMRPaymentMonth]
						,NULL --[EligMMRDOB]
						,NULL --[EligMMRDOBId]
						,NULL --[EligMMRGenderLkup]
						,0 --[EligOOAFlagLkup]
						,CASE WHEN (@ActionLkup=28012) THEN @RPRRequestedEffectiveDate ELSE NULL END --[RPRRequestedEffectiveDate]
						,CASE WHEN (@ActionLkup=28012) THEN FORMAT(@RPRRequestedEffectiveDate,'yyyyMMdd') ELSE NULL END --[RPRRequestedEffectiveDateId]
						,CASE WHEN (@ActionLkup=28012) THEN @RPRActionRequestedLkup ELSE NULL END --[RPRActionRequestedLkup]
						,CASE WHEN (@ActionLkup=28012) THEN @RPROtherActionRequested ELSE NULL END --[RPROtherActionRequested]
						,CASE WHEN (@ActionLkup=28012) THEN @RPRSupervisorOrRequesterRef ELSE NULL END --[RPRSupervisorOrRequesterRef]
						,CASE WHEN (@ActionLkup=28012) THEN @RPRReasonforRequest ELSE NULL END --[RPRReasonforRequest]
						,CASE WHEN (@ActionLkup=28012) THEN @RPRTaskPerformedLkup ELSE NULL END--[RPRTaskPerformedLkup]
						,CASE WHEN (@ActionLkup=28012) THEN @RPROtherTaskPerformed ELSE NULL END --[RPROtherTaskPerformed]
						,CASE WHEN (@ActionLkup=28012) THEN @RPRCTMMember ELSE NULL END --[RPRCTMMember]
						,CASE WHEN (@ActionLkup=28012) THEN @RPRCTMNumber ELSE NULL END --[RPRCTMNumber]
						,CASE WHEN (@ActionLkup=28012) THEN @RPREGHPMember ELSE NULL END --[RPREGHPMember]
						,CASE WHEN (@ActionLkup=28012) THEN @RPREmployerID ELSE NULL END --[RPREmployerID]
						,CASE WHEN (@ActionLkup=28012) THEN @SCCRPRRequested ELSE NULL END --[SCCRPRRequested]
						,CASE WHEN (@ActionLkup=28012) THEN @SCCRPRRequestedZip ELSE NULL END --[SCCRPRRequestedZip]
						,CASE WHEN (@ActionLkup=28012) THEN @SCCRPRRequstedSubmissionDate ELSE NULL END --[SCCRPRRequstedSubmissionDate]
						,CASE WHEN (@ActionLkup=28012) THEN FORMAT(@SCCRPRRequstedSubmissionDate,'yyyyMMdd') ELSE NULL END --[SCCRPRRequstedSubmissionDateId]
						,NULL --[SCCRPREffectiveStartDate]
						,NULL --[SCCRPREffectiveStartDateId]
						,NULL --[SCCRPREffectiveEndDate]
						,NULL --[SCCRPREffectiveEndDateId]
						,0 --[IsCasePended]
						,NULL --[PendedbyRef]
						,NULL --[UTCPendedOn]
						,NULL --[UTCPendedOnId]
						,NULL --[UTCPendedOnYear]
						,NULL --[UTCPendedOnMonth]
						,NULL --[UTCPendedOnDay]
						,NULL --[CSTPendedOn]
						,NULL --[CSTPendedOnId]
						,NULL --[CSTPendedOnYear]
						,NULL --[CSTPendedOnMonth]
						,NULL --[CSTPendedOnDay]
						,0 --[IsCaseResolved]
						,NULL --[ResolvedByRef]
						,NULL --[UTCResolvedOn]
						,NULL --[UTCResolvedOnId]
						,NULL --[UTCResolvedOnYear]
						,NULL --[UTCResolvedOnMonth]
						,NULL --[UTCResolvedOnDay]
						,NULL --[CSTResolvedOn]
						,NULL --[CSTResolvedOnId]
						,NULL --[CSTResolvedOnYear]
						,NULL --[CSTResolvedOnMonth]
						,NULL --[CSTResolvedOnDay]
						,NULL --[PeerAuditCompletedDate]
						,NULL --[PeerAuditCompletedDateId]
						,0 --[IsParentCase]
						,1 --[IsChildCase]
						,@GEN_QueueId --[ParentQueueRef]
						,1 --[IsActive]
						,GetUTCDATE() --[UTCCreatedOn]
						,FORMAT(GetUTCDATE(),'yyyyMMdd') --[UTCCreatedOnId]
						,UTCCreatedOnYear --[UTCCreatedOnYear]
						,UTCCreatedOnMonth --[UTCCreatedOnMonth]
						,UTCCreatedOnDay --[UTCCreatedOnDay]
						,GetDATE() --[CSTCreatedOn]
						,FORMAT(GetDATE(),'yyyyMMdd') --[CSTCreatedOnId]
						,CSTCreatedOnYear --[CSTCreatedOnYear]
						,CSTCreatedOnMonth --[CSTCreatedOnMonth]
						,CSTCreatedOnDay --[CSTCreatedOnDay]
						,@LoginUserId --[CreatedByRef]
						,GetUTCDATE() --[UTCLastUpdatedOn]
						,FORMAT(GetUTCDATE(),'yyyyMMdd') --[UTCLastUpdatedOnId]
						,UTCLastUpdatedOnYear --[UTCLastUpdatedOnYear]
						,UTCLastUpdatedOnMonth --[UTCLastUpdatedOnMonth]
						,UTCLastUpdatedOnDay --[UTCLastUpdatedOnDay]
						,GetDATE() --[CSTLastUpdatedOn]
						,FORMAT(GetDATE(),'yyyyMMdd') --[CSTLastUpdatedOnId]
						,CSTLastUpdatedOnYear --[CSTLastUpdatedOnYear]
						,CSTLastUpdatedOnMonth --[CSTLastUpdatedOnMonth]
						,CSTLastUpdatedOnDay --[CSTLastUpdatedOnDay]
						,@LoginUserId --[LastUpdatedByRef]
						,TRCLkup
						,MemberMedicareId
						FROM [dbo].Gen_Queue where GEN_QueueId=@GEN_QueueId

				SELECT @ChildQueueRef = Scope_Identity()

				--- Insert record into Manage cases
				INSERT INTO [dbo].[GEN_ManageCases]([GEN_QueueRef],[ActionPerformedLkup],[CurrentUserRef],[CasesComments],[ReAssignUserRef],[IsActive],[UTCCreatedOn],
								[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef])
				VALUES(@ChildQueueRef,28032,@LoginUserId,NULL,NULL,1,@UTCDate,@LoginUserId,@UTCDate,@LoginUserId)
			
				--- Insert record into Gen_Queue Workflow correlation
				INSERT INTO [dbo].[GEN_QueueWorkFlowCorrelation]
				([GEN_QueueRef],[RoleLkup],[WorkBasketLkup],[DiscrepancyCategoryLkup],[PreviousActionLkup],[PreviousWorkQueuesLkup],
					[PreviousStatusLkup],[CurrentActionLkup],[CurrentWorkQueuesLkup],[CurrentStatusLkup],[IsActive],[UTCCreatedOn],
					[CreatedByRef])
				VALUES(@ChildQueueRef,@RoleLkup,@WorkBasketLkup,6007,NULL,NULL,NULL,
					28032,@MostRecentWorkQueueLkup,20001,1,@UTCDate,@LoginUserId)

				--- Insert Comments from Parent case
				INSERT INTO [dbo].[GEN_Comments] ([GEN_QueueRef],[Comments],[ActionLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef],[SourceSystemLkup])
				SELECT @ChildQueueRef,[Comments],[ActionLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef],[SourceSystemLkup]
				FROM [dbo].[GEN_Comments]
				WHERE [GEN_QueueRef] = @GEN_QueueId AND [IsActive] = 1

				--- Insert Attachments from Parent case
				INSERT INTO [dbo].[GEN_Attachments] ([GEN_QueueRef],[UploadedFileName],[FileName],[FilePath],[GEN_DMSDataRef],[IsActive],[UTCCreatedOn],[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef])
				SELECT @ChildQueueRef,[UploadedFileName],[FileName],[FilePath],[GEN_DMSDataRef],[IsActive],[UTCCreatedOn],[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef]
				FROM [dbo].[GEN_Attachments]
				WHERE [GEN_QueueRef] = @GEN_QueueId AND [IsActive] = 1
  
			END
	  END
		COMMIT TRAN OSTACTIONS
	END TRY
	BEGIN CATCH		
		ROLLBACK TRAN OSTACTIONS;
		SET @ErrorMessage = ERROR_MESSAGE()
		INSERT INTO [dbo].[CMN_AppErrorLog] (ADM_UserMasterRef,[ErrorLocation],[ErrorSourceLkup],[ErrorMessage],[ErrorDescription],[UTCErrorDateTime],[UTCCreatedOn])
		VALUES(@LoginUserId,'[dbo].[USP_APP_UPD_MassOSTActions]',null,ERROR_NUMBER(),ERROR_MESSAGE(),GETUTCDATE(),GETUTCDATE())
	END CATCH  
END