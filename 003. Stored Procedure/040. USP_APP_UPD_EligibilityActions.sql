IF OBJECT_ID ('USP_APP_UPD_EligibilityActions') IS NOT NULL 
BEGIN
	DROP PROC [dbo].[USP_APP_UPD_EligibilityActions]
END
GO

/****** Object:  StoredProcedure [dbo].[USP_APP_UPD_EligibilityActions]    Script Date: 04-07-2017 16:46:51 ******/
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
-- Exec [USP_APP_UPD_EligibilityActions] @ErrorMessage = @ErrorMessage Output
-- =============================================

CREATE PROCEDURE [dbo].[USP_APP_UPD_EligibilityActions]
@GEN_QueueRef BIGINT,
@ActionLkup BIGINT=NULL,
@ReOpenoptionLkup BIGINT=NULL,
@ReOpenQueueLkup  BIGINT=NULL,
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
@IsActive BIT,
@Comments VARCHAR(4000)=NULL,
@LoginUserId BIGINT,
@RoleLkup BIGINT,
@RPRRequestedEffectiveDate Datetime=null,
@RPRActionRequestedLkup BIGINT=null,
@RPROtherActionRequested Varchar(50)=null,
@RPRSupervisorOrRequesterRef BIGINT=null,
@RPRReasonforRequest VARCHAR(2000)=NULL,
@RPRTaskPerformedLkup BIGINT=null,
@RPROtherTaskPerformed Varchar(50)=null,
@RPRCTMMember bit=null,
@RPRCTMNumber Varchar(20)=null,
@RPREGHPMember bit=null,
@RPREmployerID Varchar(20)=null,
@CommentsSourceSystemLkup bigint = 0,
@CMSTransactionStatusLkup bigint = NULL,
@OtherRootCause Varchar(150)=null,
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
			
			SELECT @WorkBasketLkup=[WorkBasketLkup],@DiscrepancyCategoryLkup=[DiscrepancyCategoryLkup],@PreviousAssignedToRef=[PreviousAssignedToRef],@MostRecentQueueLkup=[MostRecentWorkQueueLkup],
				   @MostRecentStatusLkup=[MostRecentStatusLkup],@MostRecentActionLkup=[MostRecentActionLkup],@PreviousWorkQueueLkup=[PreviousWorkQueueLkup],@PreviousAuditWorkQueueLkup=[PreviousAuditWorkQueueLkup]
			FROM [dbo].[GEN_Queue]
			WHERE [GEN_QueueId]=@GEN_QueueRef

			SELECT @PendReasonLkup = CASE WHEN @PendReasonLkup IS NULL THEN [PendReasonLkup] ELSE @PendReasonLkup END
			FROM [dbo].[GEN_EligibilityActions]
			WHERE [GEN_QueueRef]=@GEN_QueueRef

			--Set login user id for assigned to ref
			SET @AssignedToRef = @LoginUserId
			IF(@ReOpenoptionLkup = 48001 or @ReOpenoptionLkup = 0)
			BEGIN
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
				ELSE IF(@ActionLkup = 28025 AND @CMSTransactionStatusLkup = 55004) -- Update CMS Eligibility
					BEGIN
						SET @NextQueueLkup = @MostRecentQueueLkup
						SET @NextStatusLkup = 20002 --Status - IN PROGRESS
					END
				ELSE
					BEGIN
						SELECT @NextQueueLkup=[NextWorkQueueLkup],@NextStatusLkup=[NextStatusLkup] FROM [dbo].[GEN_WorkFlowMaster] WHERE [CurrentWorkQueueLkup]=@MostRecentQueueLkup AND [CurrentActionLkup]=@ActionLkup
					END

				IF NOT EXISTS(SELECT TOP 1 * FROM [dbo].[GEN_EligibilityActions] WHERE [GEN_QueueRef]=@GEN_QueueRef)
					BEGIN
						INSERT INTO [dbo].[GEN_EligibilityActions]
								([GEN_QueueRef],[ActionLkup],[HICN],[LastName],[DateofBirth],[ContractIDLkup],[PBPLkup],[TransactionTypeCodeLkup],
								[ApplicationDate],[ElectionTypeLkup],[EffectiveDate],[ResolutionLkup],[RootCauseLkup],[EGHPIndicator],[PendReasonLkup],
								[ContainsErrorsLkup],[OtherRootCause],[IsActive],[UTCCreatedOn],[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef])
						VALUES  (@GEN_QueueRef,@ActionLkup,@HICN,@LastName,@DateofBirth,@ContractIDLkup,@PBPLkup,@TransactionTypeCodeLkup,@ApplicationDate,
								@ElectionTypeLkup,@EffectiveDate,@ResolutionLkup,@RootCauseLkup,@EGHPIndicator,@PendReasonLkup,@ContainsErrorsLkup,@OtherRootCause,
								@IsActive,@UTCDate,@LoginUserId,@UTCDate,@LoginUserId)
					END
				ELSE
					BEGIN
						UPDATE [dbo].[GEN_EligibilityActions] 
						SET [ActionLkup]=@ActionLkup,[HICN]=@HICN,[LastName]=@LastName,[DateofBirth]=@DateofBirth,[ContractIDLkup]=@ContractIDLkup,[PBPLkup]=@PBPLkup,[TransactionTypeCodeLkup]=@TransactionTypeCodeLkup,
							[ApplicationDate]=@ApplicationDate,[ElectionTypeLkup]=@ElectionTypeLkup,[EffectiveDate]=@EffectiveDate,[ResolutionLkup]=@ResolutionLkup,[RootCauseLkup]=@RootCauseLkup,
							[EGHPIndicator]=@EGHPIndicator,[PendReasonLkup]=@PendReasonLkup,[ContainsErrorsLkup]=@ContainsErrorsLkup,[Reason]=@Reason,[MemberVerifiedStateLkup]=@MemberVerifiedStateLkup,
							[FirstLetterMailDate]=@FirstLetterMailDate,[FirstLetterMailDateId]= CASE WHEN @FirstLetterMailDate IS NULL THEN NULL ELSE FORMAT(@FirstLetterMailDate, 'yyyyMMdd') END,
							[SecondLetterMailDate]=@SecondLetterMailDate,[SecondLetterMailDateId]= CASE WHEN @SecondLetterMailDate IS NULL THEN NULL ELSE FORMAT(@SecondLetterMailDate, 'yyyyMMdd') END,
							[InitialAddressVerificationDate]=@InitialAddressVerificationDate,[InitialAddressVerificationDateId]= CASE WHEN @InitialAddressVerificationDate IS NULL THEN NULL ELSE FORMAT(@InitialAddressVerificationDate, 'yyyyMMdd') END,
							[MemberResponseVerificationDate]=@MemberResponseVerificationDate,[MemberResponseVerificationDateId]= CASE WHEN @MemberResponseVerificationDate IS NULL THEN NULL ELSE FORMAT(@MemberResponseVerificationDate, 'yyyyMMdd') END,
							[OtherResolution]=@OtherResolution,[OtherRootCause] = @OtherRootCause,[IsActive]=@IsActive,[UTCLastUpdatedOn]=@UTCDate,[LastUpdatedByRef]=@LoginUserId
						WHERE [GEN_QueueRef]=@GEN_QueueRef
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
				,[CMSTransactionStatusLkup]=CASE WHEN (@ActionLkup = 28025 AND @CMSTransactionStatusLkup IS NOT NULL) THEN @CMSTransactionStatusLkup ELSE [CMSTransactionStatusLkup] END
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
				WHERE [GEN_QueueId] = @GEN_QueueRef
			END
		ELSE IF(@ReOpenoptionLkup = 48002)
			BEGIN	
				SET @ActionLkup = 28060 --ReOpen - Edit and Initiate Workflow
				SET @NextQueueLkup = @ReOpenQueueLkup
				SET @NextStatusLkup = 20002 -- In Progress
				UPDATE [dbo].[GEN_Queue] SET
				[AssignedToRef]=@AssignedToRef
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
				,[MostRecentWorkQueueLkup]=@ReOpenQueueLkup
				,[MostRecentStatusLkup]=@NextStatusLkup
				,[IsCaseResolved]=0
				,[ResolvedByRef]= NULL
				,[UTCResolvedOn]= NULL
				,[UTCResolvedOnId]= NULL
				,[UTCResolvedOnYear]= NULL
				,[UTCResolvedOnMonth]= NULL
				,[UTCResolvedOnDay]= NULL
				,[CSTResolvedOn]= NULL
				,[CSTResolvedOnId]= NULL
				,[CSTResolvedOnYear]= NULL
				,[CSTResolvedOnMonth]= NULL
				,[CSTResolvedOnDay]= NULL
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
				WHERE [GEN_QueueId] = @GEN_QueueRef
			END			
			--- Insert record into comments 
			IF(@Comments IS NOT NULL)
			BEGIN
				INSERT INTO [dbo].[GEN_Comments] ([GEN_QueueRef],[Comments],[ActionLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef],[SourceSystemLkup])
				VALUES (@GEN_QueueRef,@Comments,@ActionLkup,@IsActive,@UTCDate,@LoginUserId,@UTCDate,@LoginUserId,@CommentsSourceSystemLkup)
			END

			--- Insert record into Manage cases
			INSERT INTO [dbo].[GEN_ManageCases]([GEN_QueueRef],[ActionPerformedLkup],[CurrentUserRef],[CasesComments],[ReAssignUserRef],[IsActive],[UTCCreatedOn],
							[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef])
			VALUES(@GEN_QueueRef,@ActionLkup,@LoginUserId,NULL,NULL,@IsActive,@UTCDate,@LoginUserId,@UTCDate,@LoginUserId)

			--- Insert record into Gen_Queue Workflow correlation
			INSERT INTO [dbo].[GEN_QueueWorkFlowCorrelation]
			([GEN_QueueRef],[RoleLkup],[WorkBasketLkup],[DiscrepancyCategoryLkup],[PreviousActionLkup],[PreviousWorkQueuesLkup],
				[PreviousStatusLkup],[CurrentActionLkup],[CurrentWorkQueuesLkup],[CurrentStatusLkup],[IsActive],[UTCCreatedOn],
				[CreatedByRef])
			VALUES(@GEN_QueueRef,@RoleLkup,@WorkBasketLkup,@DiscrepancyCategoryLkup,@MostRecentActionLkup,ISNULL(@PendedWorkQueueLkup,@MostRecentQueueLkup),@MostRecentStatusLkup,
				@ActionLkup,@NextQueueLkup,@NextStatusLkup,@IsActive,@UTCDate,@LoginUserId)
				
			-----------Unlock record BEGIN-----------
			--37010 = Queue Screen
			DELETE FROM CMN_RecordsLocked WHERE [ScreenLkup]=37010 AND [CaseId]=@GEN_QueueRef
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
					,FORMAT(DiscrepancyReceiptDate , 'yyyyMMdd') --[DiscrepancyReceiptDateId]
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
					,@GEN_QueueRef --[ParentQueueRef]
					,1 --[IsActive]
					,@UTCDate --[UTCCreatedOn]
					,FORMAT(@UTCDate, 'yyyyMMdd') --[UTCCreatedOnId]
					,FORMAT(@UTCDate, 'yyyy') --[UTCCreatedOnYear]
					,FORMAT(@UTCDate, 'MM') --[UTCCreatedOnMonth]
					,FORMAT(@UTCDate, 'dd') --[UTCCreatedOnDay]
					,DATEADD(hh, -6, @UTCDate) --[CSTCreatedOn]
					,FORMAT(DATEADD(hh, -6, @UTCDate), 'yyyyMMdd') --[CSTCreatedOnId]
					,FORMAT(DATEADD(hh, -6, @UTCDate), 'yyyy') --[CSTCreatedOnYear]
					,FORMAT(DATEADD(hh, -6, @UTCDate), 'MM') --[CSTCreatedOnMonth]
					,FORMAT(DATEADD(hh, -6, @UTCDate), 'dd') --[CSTCreatedOnDay]
					,@LoginUserId --[CreatedByRef]
					,@UTCDate --[UTCLastUpdatedOn]
					,FORMAT(@UTCDate, 'yyyyMMdd') --[UTCLastUpdatedOnId]
					,FORMAT(@UTCDate, 'yyyy') --[UTCLastUpdatedOnYear]
					,FORMAT(@UTCDate, 'MM') --[UTCLastUpdatedOnMonth]
					,FORMAT(@UTCDate, 'dd') --[UTCLastUpdatedOnDay]
					,DATEADD(hh, -6, @UTCDate) --[CSTLastUpdatedOn]
					,FORMAT(DATEADD(hh, -6, @UTCDate), 'yyyyMMdd') --[CSTLastUpdatedOnId]
					,FORMAT(DATEADD(hh, -6, @UTCDate), 'yyyy') --[CSTLastUpdatedOnYear]
					,FORMAT(DATEADD(hh, -6, @UTCDate), 'MM') --[CSTLastUpdatedOnMonth]
					,FORMAT(DATEADD(hh, -6, @UTCDate), 'dd') --[CSTLastUpdatedOnDay]
					,@LoginUserId --[LastUpdatedByRef]
					,MemberMedicareId
					FROM [dbo].Gen_Queue where GEN_QueueId=@GEN_QueueRef 

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
				WHERE [GEN_QueueRef] = @GEN_QueueRef AND [IsActive] = 1

				--- Insert Attachments from Parent case
				INSERT INTO [dbo].[GEN_Attachments] ([GEN_QueueRef],[UploadedFileName],[FileName],[FilePath],[GEN_DMSDataRef],[IsActive],[UTCCreatedOn],[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef])
				SELECT @ChildQueueRef,[UploadedFileName],[FileName],[FilePath],[GEN_DMSDataRef],[IsActive],[UTCCreatedOn],[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef]
				FROM [dbo].[GEN_Attachments]
				WHERE [GEN_QueueRef] = @GEN_QueueRef AND [IsActive] = 1
	  END
		COMMIT TRAN ELIGIBILITYACTIONS
	END TRY
	BEGIN CATCH
		ROLLBACK TRAN ELIGIBILITYACTIONS;
		INSERT INTO [dbo].[CMN_AppErrorLog] (ADM_UserMasterRef,[ErrorLocation],[ErrorSourceLkup],[ErrorMessage],[ErrorDescription],[UTCErrorDateTime],[UTCCreatedOn])
		VALUES(@LoginUserId,'[dbo].[USP_APP_UPD_EligibilityActions]',null,ERROR_NUMBER(),ERROR_MESSAGE(),GETUTCDATE(),GETUTCDATE())
	END CATCH  
END