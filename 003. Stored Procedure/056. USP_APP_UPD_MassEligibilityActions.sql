IF OBJECT_ID ('USP_APP_UPD_MassEligibilityActions') IS NOT NULL 
BEGIN
	DROP PROC [dbo].[USP_APP_UPD_MassEligibilityActions]
END
GO

/****** Object:  StoredProcedure [dbo].[USP_APP_UPD_MassEligibilityActions]    Script Date: 04-07-2017 16:46:51 ******/
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
-- Exec [UUSP_APP_UPD_MassEligibilityActions] @ErrorMessage = @ErrorMessage Output
-- =============================================
CREATE PROCEDURE [dbo].[USP_APP_UPD_MassEligibilityActions]
@QueueIds VARCHAR(MAX),
@ActionLkup BIGINT=NULL,
@HICN VARCHAR(20)=NULL,
@LastName VARCHAR(35)=NULL,
@DateofBirth DATETIME=NULL,
@ContractIDLkup BIGINT=NULL,
@PBPLkup BIGINT=NULL,
@TransactionTypeCodeLkup BIGINT=NULL,
@ApplicationDate DATETIME=NULL,
@ElectionTypeLkup BIGINT=NULL,
@EffectiveDate DATETIME=NULL,
@ResolutionLkup BIGINT=NULL,
@OtherResolution VARCHAR(35)=NULL,
@RootCauseLkup BIGINT=NULL,
@EGHPIndicator BIT=NULL,
@PendReasonLkup BIGINT=NULL,
@ContainsErrorsLkup BIGINT=NULL,
@FirstLetterMailDate DATETIME=NULL,
@SecondLetterMailDate DATETIME=NULL,
@Reason VARCHAR(20)=NULL,
@InitialAddressVerificationDate DATETIME =NULL,
@MemberResponseVerificationDate DATETIME =NULL,
@MemberVerifiedStateLkup BIGINT=NULL,
@OtherRootCause Varchar(150)=null,
@IsActive BIT,
@Comments VARCHAR(4000)=NULL,
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
@CommentsSourceSystemLkup bigint = 0,
@ErrorMessage VARCHAR(2000) OUT
AS
BEGIN
BEGIN TRY  
		BEGIN TRAN ELIGIBILITYACTIONS
			Declare @UTCDate DATETIME = GETUTCDATE()
			Declare @MostRecentQueueLkup BIGINT = NULL
			Declare @MostRecentStatusLkup BIGINT = NULL
			Declare @MostRecentActionLkup BIGINT = NULL
			Declare @NextQueueLkup BIGINT = NULL
			Declare @NextStatusLkup BIGINT = NULL
			Declare @IsCasePended BIT = 0
			Declare @IsCaseResolved BIT = 0
			Declare @WorkBasketLkup BIGINT = NULL
			Declare @DiscrepancyCategoryLkup BIGINT = NULL
			Declare @PreviousWorkQueueLkup BIGINT = NULL
			Declare @PreviousAuditWorkQueueLkup BIGINT = NULL
			Declare @PendedWorkQueueLkup BIGINT = NULL
			Declare @PreviousAssignedToRef BIGINT = NULL
			Declare @AssignedToRef BIGINT = NULL
			Declare @ChildQueueRef BIGINT = NULL
			Declare @RPRCategoryLkup BIGINT = NULL

			SET @IsActive = 1

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

				SELECT @PendReasonLkup = CASE WHEN @PendReasonLkup IS NULL THEN [PendReasonLkup] ELSE @PendReasonLkup END
				FROM [dbo].[GEN_EligibilityActions]
				WHERE [GEN_QueueRef]=@GEN_QueueId

				--Set login user id for assigned to ref
				SET @AssignedToRef = @LoginUserId

				IF(@ActionLkup = 28007) -- Action - Pend Case
					BEGIN
						SET @IsCasePended = 1
						IF(@MostRecentQueueLkup != 10055 AND @MostRecentQueueLkup != 10061 AND @MostRecentQueueLkup != 10065)
						BEGIN
							SET @PreviousWorkQueueLkup = @MostRecentQueueLkup
						END
					END
				ELSE IF(@ActionLkup = 28002 OR @ActionLkup = 28026 OR @ActionLkup = 28027 OR @ActionLkup = 28028 OR @ActionLkup = 28065 OR @ActionLkup = 28072) -- 28002 = Action - Close Case / 28026 = Action - Update GPS / 28027 = Action - Update Plan / 28028 = Action - Update Plan & Create RPR / 28028 = Action - Close Case & Create RPR / 28072 = Action - Close Case - No Action Needed
					BEGIN
						SET @IsCaseResolved = 1
					END
				ELSE IF(@ActionLkup = 28018 AND @PreviousAuditWorkQueueLkup IS NULL) -- Action - Send to Peer Audit
					BEGIN
						SET @PreviousAssignedToRef = @LoginUserId
						IF(@MostRecentQueueLkup = 10055 OR @MostRecentQueueLkup = 10061 OR @MostRecentQueueLkup = 10065) -- Pended Queue Lkup for Eligibility, DOB and Gender
							BEGIN
								SET @PreviousAuditWorkQueueLkup = @PreviousWorkQueueLkup
							END
						ELSE
							BEGIN
								SET @PreviousAuditWorkQueueLkup = @MostRecentQueueLkup
							END	
					END

				IF(@MostRecentQueueLkup = 10055 OR @MostRecentQueueLkup = 10061 OR @MostRecentQueueLkup = 10065) -- Pended Queue Lkup for Eligibility, DOB and Gender
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
				IF(@ActionLkup = 28001 OR (@ActionLkup = 28007 AND (@MostRecentQueueLkup = 10055 OR @MostRecentQueueLkup = 10061 OR @MostRecentQueueLkup = 10065))) --28001- Add Comments / 28007- Pend Case
					BEGIN
						SET @NextQueueLkup = @MostRecentQueueLkup
						SET @NextStatusLkup = @MostRecentStatusLkup
					END
				ELSE IF(@ActionLkup = 28006) -- Peer Audit Completed
					BEGIN
						IF(@ContainsErrorsLkup = 1)
							BEGIN
								SET @NextQueueLkup = CASE WHEN @DiscrepancyCategoryLkup = 6004 THEN 10097 
														ELSE CASE WHEN @DiscrepancyCategoryLkup = 6005 THEN 10099
															ELSE CASE WHEN @DiscrepancyCategoryLkup = 6006 THEN 10098 END
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

				IF NOT EXISTS(SELECT TOP 1 * FROM [dbo].[GEN_EligibilityActions] WHERE [GEN_QueueRef]=@GEN_QueueId)
				BEGIN
					INSERT INTO [dbo].[GEN_EligibilityActions]
							([GEN_QueueRef],[ActionLkup],[HICN],[LastName],[DateofBirth],[ContractIDLkup],[PBPLkup],[TransactionTypeCodeLkup],
							[ApplicationDate],[ElectionTypeLkup],[EffectiveDate],[ResolutionLkup],[RootCauseLkup],[EGHPIndicator],[PendReasonLkup],
							[ContainsErrorsLkup],[OtherRootCause],[IsActive],[UTCCreatedOn],[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef])
					VALUES  (@GEN_QueueId,@ActionLkup,@HICN,@LastName,@DateofBirth,@ContractIDLkup,@PBPLkup,@TransactionTypeCodeLkup,@ApplicationDate,
							@ElectionTypeLkup,@EffectiveDate,@ResolutionLkup,@RootCauseLkup,@EGHPIndicator,@PendReasonLkup,@ContainsErrorsLkup,@OtherRootCause,
							@IsActive,@UTCDate,@LoginUserId,@UTCDate,@LoginUserId)
				END
				ELSE
					BEGIN
						UPDATE [dbo].[GEN_EligibilityActions] 
						SET [ActionLkup]=ISNULL(@ActionLkup,[ActionLkup]),[HICN]=ISNULL(@HICN,[HICN]),[LastName]=ISNULL(@LastName,[LastName]),[DateofBirth]=ISNULL(@DateofBirth,[DateofBirth]),[ContractIDLkup]=ISNULL(@ContractIDLkup,[ContractIDLkup]),[PBPLkup]=ISNULL(@PBPLkup,[PBPLkup]),[TransactionTypeCodeLkup]=ISNULL(@TransactionTypeCodeLkup,[TransactionTypeCodeLkup]),
							[ApplicationDate]=ISNULL(@ApplicationDate,[ApplicationDate]),[ElectionTypeLkup]=ISNULL(@ElectionTypeLkup,[ElectionTypeLkup]),[EffectiveDate]=ISNULL(@EffectiveDate,[EffectiveDate]),[ResolutionLkup]=ISNULL(@ResolutionLkup,[ResolutionLkup]),[RootCauseLkup]=ISNULL(@RootCauseLkup,[RootCauseLkup]),
							[EGHPIndicator]=ISNULL(@EGHPIndicator,[EGHPIndicator]),[PendReasonLkup]=ISNULL(@PendReasonLkup,[PendReasonLkup]),[ContainsErrorsLkup]=ISNULL(@ContainsErrorsLkup,[ContainsErrorsLkup]),[Reason]=ISNULL(@Reason,[Reason]),[MemberVerifiedStateLkup]=ISNULL(@MemberVerifiedStateLkup,[MemberVerifiedStateLkup]),
							[FirstLetterMailDate]=ISNULL(@FirstLetterMailDate,[FirstLetterMailDate]),[FirstLetterMailDateId]= CASE WHEN @FirstLetterMailDate IS NULL THEN NULL ELSE FORMAT(@FirstLetterMailDate, 'yyyyMMdd') END,
							[SecondLetterMailDate]=ISNULL(@SecondLetterMailDate,[SecondLetterMailDate]),[SecondLetterMailDateId]= CASE WHEN @SecondLetterMailDate IS NULL THEN NULL ELSE FORMAT(@SecondLetterMailDate, 'yyyyMMdd') END,
							[InitialAddressVerificationDate]=ISNULL(@InitialAddressVerificationDate,[InitialAddressVerificationDate]),[InitialAddressVerificationDateId]= CASE WHEN @InitialAddressVerificationDate IS NULL THEN NULL ELSE FORMAT(@InitialAddressVerificationDate, 'yyyyMMdd') END,
							[MemberResponseVerificationDate]=ISNULL(@MemberResponseVerificationDate,[MemberResponseVerificationDate]),[MemberResponseVerificationDateId]= CASE WHEN @MemberResponseVerificationDate IS NULL THEN NULL ELSE FORMAT(@MemberResponseVerificationDate, 'yyyyMMdd') END,
							[OtherResolution]=ISNULL(@OtherResolution,[OtherResolution]),[OtherRootCause] = @OtherRootCause,[IsActive]=@IsActive,[UTCLastUpdatedOn]=@UTCDate,[LastUpdatedByRef]=@LoginUserId
						WHERE [GEN_QueueRef]=@GEN_QueueId
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

		  IF(@ActionLkup=28028 OR @ActionLkup=28065) --28028 - Update Plan & Create RPR / 28065 - Close Case & Create RPR 
		  BEGIN
			  DECLARE @MostRecentWorkQueueLkup BIGINT
			  IF @RPRCTMMember=1
				BEGIN
					SET @MostRecentWorkQueueLkup=10076   --10076--RPR - Request - Category 2
					SET @RPRCategoryLkup = 49001 --RPR Category - Category 2
				END
			  ELSE IF @RPRRequestedEffectiveDate IS NOT NULL
				BEGIN
					IF DATEDIFF(mm,@RPRRequestedEffectiveDate,GETDATE())=3
					  BEGIN
						SET @MostRecentWorkQueueLkup=10077   --10076--RPR - Request - Category 3
						SET @RPRCategoryLkup = 49002 --RPR Category - Category 3
					  END
					ELSE
					  BEGIN
						SET @MostRecentWorkQueueLkup=10076   --10076--RPR - Request - Category 2
						SET @RPRCategoryLkup = 49001 --RPR Category - Category 2
					  END 	 
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
					   ,[RPRCategoryLkup]
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
					   ,[MemberMedicareId])
				 SELECT
						BusinessSegmentLkup --[BusinessSegmentLkup]
						,3003 --[WorkBasketLkup]
						,6007 --[DiscrepancyCategoryLkup]
						,7010 --[DiscrepancyTypeLkup] --RPR
						,28032 -- Action - Save --[MostRecentActionLkup]
						,@MostRecentWorkQueueLkup --[MostRecentWorkQueueLkup]
						,20001 -- Status - NEW --[MostRecentStatusLkup]
						,NULL --[PreviousWorkQueueLkup]
						,NULL --[PreviousAuditWorkQueueLkup]
						,38001 --[SourceSystemLkup]
						,NULL --[SourceSystemId]
						,DiscrepancySourceLkup --[DiscrepancySourceLkup]
						,DiscrepancyReceiptDate --[DiscrepancyReceiptDate]
						,DiscrepancyReceiptDateId --[DiscrepancyReceiptDateId]
						,CONVERT(date,GetDate()) --[ComplianceStartDate]
						,FORMAT(GetDate() , 'yyyyMMdd') --[ComplianceStartDateId]
						,DisenrollmentDate --[DisenrollmentDate]
						,DateAdd(mm, 1,DateAdd(mm, DateDiff(mm, 1, GetDate()), 0)) --[DiscrepancyStartDate]
						,FORMAT(DateAdd(mm, 1,DateAdd(mm, DateDiff(mm, 1, GetDate()), 0)), 'yyyyMMdd') --[DiscrepancyStartDateId]
						,NULL --[DiscrepancyEndDate]
						,NULL --[DiscrepancyEndDateId]
						,NULL --[MemberSCCCode]
						,NULL --[PDPAutoEnrolleeInd]
						,NULL --[ReferencedEligibilityCaseInd]
						,NULL --[ReferencedSCCCaseInd]
						,NULL --[FileTypeLkup]
						,NULL --[ODMDocID]
						,NULL --[ODMAddressLink]
						,NULL --[UndeliveredAddress1]
						,NULL --[UndeliveredAddress2]
						,NULL --[UndeliveredCity]
						,NULL --[UndeliveredState]
						,NULL --[UndeliveredZip]
						,NULL --[COAOldAddress1]
						,NULL --[COAOldAddress2]
						,NULL --[COAOldCity]
						,NULL --[COAOldState]
						,NULL --[COAOldZip]
						,NULL --[COANewAddress1]
						,NULL --[COANewAddress2]
						,NULL --[COANewCity]
						,NULL --[COANewState]
						,NULL --[COANewZip]
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
						,EligOOAFlagLkup --[EligOOAFlagLkup]
						,@RPRRequestedEffectiveDate --[RPRRequestedEffectiveDate]
						,FORMAT(@RPRRequestedEffectiveDate,'yyyyMMdd') --[RPRRequestedEffectiveDateId]
						,@RPRActionRequestedLkup --[RPRActionRequestedLkup]
						,@RPROtherActionRequested --[RPROtherActionRequested]
						,@RPRSupervisorOrRequesterRef --[RPRSupervisorOrRequesterRef]
						,@RPRReasonforRequest --[RPRReasonforRequest]
						,@RPRTaskPerformedLkup --[RPRTaskPerformedLkup]
						,@RPROtherTaskPerformed --[RPROtherTaskPerformed]
						,@RPRCTMMember --[RPRCTMMember]
						,@RPRCTMNumber --[RPRCTMNumber]
						,@RPREGHPMember --[RPREGHPMember]
						,@RPREmployerID --[RPREmployerID]
						,@RPRCategoryLkup--[RPRCategoryLkup]
						,NULL --[SCCRPRRequested]
						,NULL --[SCCRPRRequestedZip]
						,NULL --[SCCRPRRequstedSubmissionDate]
						,NULL --[SCCRPRRequstedSubmissionDateId]
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
		COMMIT TRAN ELIGIBILITYACTIONS
	END TRY
	BEGIN CATCH		
		ROLLBACK TRAN ELIGIBILITYACTIONS;
		INSERT INTO [dbo].[CMN_AppErrorLog] (ADM_UserMasterRef,[ErrorLocation],[ErrorSourceLkup],[ErrorMessage],[ErrorDescription],[UTCErrorDateTime],[UTCCreatedOn])
		VALUES(@LoginUserId,'[dbo].[USP_APP_UPD_MassEligibilityActions]',null,ERROR_NUMBER(),ERROR_MESSAGE(),GETUTCDATE(),GETUTCDATE())
	END CATCH  
END