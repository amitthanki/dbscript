IF OBJECT_ID ('USP_APP_UPD_RPRActions') IS NOT NULL 
BEGIN
	DROP PROC [dbo].[USP_APP_UPD_RPRActions]
END
GO

/****** Object:  StoredProcedure [dbo].[USP_APP_UPD_RPRActions]    Script Date: 04-07-2017 16:46:51 ******/
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
-- Exec [USP_APP_UPD_RPRActions] @ErrorMessage = @ErrorMessage Output
-- =============================================
CREATE PROCEDURE [dbo].[USP_APP_UPD_RPRActions]
@GEN_QueueRef BIGINT,
@ActionLkup BIGINT=NULL,
@ReOpenoptionLkup BIGINT=NULL,
@ReOpenQueueLkup  BIGINT=NULL,
@ResolutionLkup BIGINT=NULL,
@RootCauseLkup BIGINT=NULL,
@PendReasonLkup BIGINT=NULL,
@AdjustedCreateDate DATETIME=NULL,
@AdjustedCreateDateReasonLkup BIGINT=NULL,
@OtherAdjustedCreateDateReason VARCHAR(35)=NULL,
@SubmissionTypeLkup BIGINT=NULL,
@ContainsErrorsLkup BIGINT=NULL,
@RPCSubmissionDate DATETIME=NULL,
@CMSAccountManagerSubmissionDate DATETIME=NULL,
@CMSAccountManagerApprovalDate DATETIME=NULL,
@FDRStatusLkup BIGINT=NULL,
@OtherFDRStatus VARCHAR(35)=NULL,
@FDRReceivedDate DATETIME=NULL,
@FDRCodeReceived VARCHAR(50)=NULL,
@FDRDescription VARCHAR(50)=NULL,
@CMSProcessDate DATETIME=NULL,
@TransactionType VARCHAR(50)=NULL,
@FDRRejectionTypeLkup BIGINT=NULL,
@ElectionTypeLkup BIGINT=NULL,
@LastName VARCHAR(35)=NULL,
@DateofBirth DATETIME=NULL,
@ContractIDLkup BIGINT=NULL,
@PBPLkup BIGINT=NULL,
@ApplicationDate DATETIME=NULL,
@EffectiveDate DATETIME=NULL,
@EndDate DATETIME=NULL,
@ActualSubmissionDate DATETIME=NULL,
@ReasonSubmissionRejected VARCHAR(4000)=NULL,
@RequestedSCC VARCHAR(10)=NULL,
@RequestedZIP VARCHAR(10)=NULL,
@ResubmissionDate DATETIME=NULL,
@PotentialSubmissionDate DATETIME=NULL,
@IsActive BIT,
@Comments VARCHAR(4000)=NULL,
@LoginUserId BIGINT,
@RoleLkup BIGINT,
@CommentsSourceSystemLkup bigint = 0,
@CMSTransactionStatusLkup bigint = NULL,
@TransactionTypeCodeLkup BIGINT=NULL,
@ExplanationOfRootCauseLkup BIGINT=NULL,
@VerifiedRootCauseLkup BIGINT=NULL,
@PlanError BIT = NULL,
@ErrorMessage VARCHAR(2000) OUT
AS
BEGIN
BEGIN TRY  
		BEGIN TRAN RPRACTIONS
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
			Declare @ParentQueueRef BIGINT = NULL
			Declare @RPRCategoryLkup BIGINT = NULL
			Declare @IsCTMMember BIT = 0

			SELECT @WorkBasketLkup=[WorkBasketLkup],@DiscrepancyCategoryLkup=[DiscrepancyCategoryLkup],@PreviousAssignedToRef=[PreviousAssignedToRef],@MostRecentQueueLkup=[MostRecentWorkQueueLkup],
				   @MostRecentStatusLkup=[MostRecentStatusLkup],@MostRecentActionLkup=[MostRecentActionLkup],@PreviousWorkQueueLkup=[PreviousWorkQueueLkup],@PreviousAuditWorkQueueLkup=[PreviousAuditWorkQueueLkup],@ParentQueueRef=[ParentQueueRef],
				   @RPRCategoryLkup=[RPRCategoryLkup],@IsCTMMember=[RPRCTMMember]
			FROM [dbo].[GEN_Queue]
			WHERE [GEN_QueueId]=@GEN_QueueRef

			SELECT @PendReasonLkup = CASE WHEN @PendReasonLkup IS NULL THEN [PendReasonLkup] ELSE @PendReasonLkup END,
				   @SubmissionTypeLkup = CASE WHEN @SubmissionTypeLkup IS NULL THEN [SubmissionTypeLkup] ELSE @SubmissionTypeLkup END
			FROM [dbo].[GEN_RPRActions]
			WHERE [GEN_QueueRef]=@GEN_QueueRef

			--Set login user id for assigned to ref
			SET @AssignedToRef = @LoginUserId
			IF(@ReOpenoptionLkup = 48001 or @ReOpenoptionLkup = 0)
			BEGIN
			IF(@ActionLkup = 28007) -- Action - Pend Case
				BEGIN
					IF(@SubmissionTypeLkup = 17002)
						SET @RPRCategoryLkup = 49002 --RPR Category-Category 3
					ELSE IF(@SubmissionTypeLkup = 17001)
						SET @RPRCategoryLkup = 49001 --RPR Category-Category 2

					IF(@PendReasonLkup != 30007 AND @PendReasonLkup != 30009)
						BEGIN
							SET @IsCasePended = 1
							IF(@MostRecentQueueLkup != 10081) -- 10081 - Pended Queue Lkup for RPR
								BEGIN
									SET @PreviousWorkQueueLkup = @MostRecentQueueLkup
								END
						END
				END
			ELSE IF(@ActionLkup = 28002 OR @ActionLkup = 28004 OR @ActionLkup = 28011 OR @ActionLkup = 28027) -- 28002 = Action - Close Case / 28004 = Action - FDR Approved / 28011 = Action - SCC RPR Not Required / 28027 = Action - Update Plan
				BEGIN
					SET @IsCaseResolved = 1
				END
			ELSE IF(@ActionLkup = 28018 AND @PreviousAuditWorkQueueLkup IS NULL) -- Action - Send to Peer Audit
				BEGIN
					SET @PreviousAssignedToRef = @LoginUserId
					SET @PreviousAuditWorkQueueLkup = @MostRecentQueueLkup
					IF(@MostRecentQueueLkup = 10081) -- Pended Queue Lkup for RPR
						BEGIN
							SET @PreviousAuditWorkQueueLkup = @PreviousWorkQueueLkup
						END
					ELSE
						BEGIN
							SET @PreviousAuditWorkQueueLkup = @MostRecentQueueLkup
						END
					
					--If Submission type is changed then previous audit work queue has to be set based on Submission type
					IF(@SubmissionTypeLkup IS NOT NULL)
					BEGIN
						IF((@PreviousAuditWorkQueueLkup = 10076 OR @PreviousAuditWorkQueueLkup = 10110) AND @SubmissionTypeLkup = 17002)
							SET @PreviousAuditWorkQueueLkup = 10077 -- RPR Request Category 3
						ELSE IF(@PreviousAuditWorkQueueLkup = 10077 AND @SubmissionTypeLkup = 17001)
							IF(@IsCTMMember = 1) -- CTM Member
								BEGIN
									SET @PreviousAuditWorkQueueLkup = 10110 -- RPR Request Category 2 CTM
								END
							ELSE
								BEGIN
									SET @PreviousAuditWorkQueueLkup = 10076 -- RPR Request Category 2
								END

						IF(@SubmissionTypeLkup = 17002)
							SET @RPRCategoryLkup = 49002 --RPR Category-Category 3
						ELSE IF(@SubmissionTypeLkup = 17001)
							SET @RPRCategoryLkup = 49001 --RPR Category-Category 2
					END
				END
			ELSE IF(@ActionLkup = 28066)
				BEGIN
					SET @RPRCategoryLkup = 49001 --RPR Category-Category 2
				END
			ELSE IF(@ActionLkup = 28067)
				BEGIN
					SET @RPRCategoryLkup = 49002 --RPR Category-Category 3
				END
			ELSE IF(@ActionLkup = 28071)
				BEGIN
					IF(@SubmissionTypeLkup = 17002)
						SET @RPRCategoryLkup = 49002 --RPR Category-Category 3
					ELSE IF(@SubmissionTypeLkup = 17001)
						SET @RPRCategoryLkup = 49001 --RPR Category-Category 2
				END
			
			IF(@MostRecentQueueLkup = 10081) -- Pended Queue Lkup for RPR
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
			IF(@ActionLkup = 28001 OR (@ActionLkup = 28007 AND @PendReasonLkup = 30007) OR (@ActionLkup = 28007 AND @PendReasonLkup = 30009) OR (@ActionLkup = 28007 AND @MostRecentQueueLkup = 10081)) --28001- Add Comments / 28007- Pend Case
				BEGIN
					IF (@ActionLkup = 28007 AND @PendReasonLkup = 30007)
					BEGIN
						SET @NextQueueLkup = 10106
						SET @NextStatusLkup = 20002
						SET @IsCasePended = 0
						SET @PreviousWorkQueueLkup = NULL
					END 
					ELSE IF (@ActionLkup = 28007 AND @PendReasonLkup = 30009)
					BEGIN
						SET @NextQueueLkup = 10109
						SET @NextStatusLkup = 20002
						SET @IsCasePended = 0
						SET @PreviousWorkQueueLkup = NULL
					END
					ELSE
					BEGIN
						SET @NextQueueLkup = @MostRecentQueueLkup
						SET @NextStatusLkup = @MostRecentStatusLkup
					END
				END
			ELSE IF(@ActionLkup = 28006) -- Peer Audit Completed
				BEGIN
					IF(@ContainsErrorsLkup = 1)
						BEGIN
							SET @NextQueueLkup = CASE WHEN @DiscrepancyCategoryLkup = 6007 THEN 10074 END
							SET @NextStatusLkup = 20002 -- Status - IN PROGRESS
							SET @AssignedToRef = @PreviousAssignedToRef
						END
					ELSE
						BEGIN							
							IF((@SubmissionTypeLkup IS NOT NULL AND @SubmissionTypeLkup = 17001) OR (@SubmissionTypeLkup IS NULL AND (@PreviousAuditWorkQueueLkup = 10076 OR @PreviousAuditWorkQueueLkup = 10110))) -- RPC Request - Category 2/CTM
								BEGIN
									SET @NextQueueLkup = 10079 --RPR Submission (Category 2)
									SET @NextStatusLkup = 20002 -- Status - IN PROGRESS
								END
							ELSE IF((@SubmissionTypeLkup IS NOT NULL AND @SubmissionTypeLkup = 17002) OR (@SubmissionTypeLkup IS NULL AND @PreviousAuditWorkQueueLkup = 10077)) -- RPC Request - Category 3
								BEGIN
									SET @NextQueueLkup = 10080 --RPR Submission (Category 3)
									SET @NextStatusLkup = 20002 -- Status - IN PROGRESS
								END

							--SET @NextQueueLkup = @PreviousAuditWorkQueueLkup
							--SET @NextStatusLkup = @MostRecentStatusLkup
							--SET @PreviousAuditWorkQueueLkup = NULL
						END
				END
			ELSE IF(@ActionLkup = 28013 AND @CMSTransactionStatusLkup = 55004) -- Update CMS Eligibility
				BEGIN
					SET @NextQueueLkup = @MostRecentQueueLkup
					SET @NextStatusLkup = 20002 --Status - IN PROGRESS
				END
			ELSE IF(@ActionLkup = 28071) -- Update Submission Type
				BEGIN
					IF((@MostRecentQueueLkup = 10076 OR @MostRecentQueueLkup = 10110) AND @SubmissionTypeLkup = 17002)
						SET @NextQueueLkup = 10077 -- RPR Request Category 3
					ELSE IF(@MostRecentQueueLkup = 10077 AND @SubmissionTypeLkup = 17001)
						IF(@IsCTMMember = 1) -- CTM Member
							BEGIN
								SET @NextQueueLkup = 10110 -- RPR Request Category 2 CTM
							END
						ELSE
							BEGIN
								SET @NextQueueLkup = 10076 -- RPR Request Category 2
							END
					ELSE IF(@MostRecentQueueLkup = 10079 AND @SubmissionTypeLkup = 17002)
						SET @NextQueueLkup = 10080
					ELSE IF(@MostRecentQueueLkup = 10080 AND @SubmissionTypeLkup = 17001)
						SET @NextQueueLkup = 10079
					ELSE
						SET @NextQueueLkup = @MostRecentQueueLkup
					SET @NextStatusLkup = 20002 --Status - IN PROGRESS
				END
			ELSE IF(@ActionLkup = 28073) --Return To Request Queue
				BEGIN
					IF(@RPRCategoryLkup = 49001) -- Category 2
						IF(@IsCTMMember = 1) -- CTM Member
							BEGIN
								SET @NextQueueLkup = 10110 -- RPR Request Category 2 CTM
							END
						ELSE
							BEGIN
								SET @NextQueueLkup = 10076 -- RPR Request Category 2
							END
					ELSE IF(@RPRCategoryLkup = 49002) -- Category 3
							SET @NextQueueLkup = 10077 -- RPR Request Category 3
					SET @NextStatusLkup = 20002 --Status - IN PROGRESS
				END
			ELSE
				BEGIN
					SELECT @NextQueueLkup=[NextWorkQueueLkup],@NextStatusLkup=[NextStatusLkup] FROM [dbo].[GEN_WorkFlowMaster] WHERE [CurrentWorkQueueLkup]=@MostRecentQueueLkup AND [CurrentActionLkup]=@ActionLkup
				END

			IF NOT EXISTS(SELECT TOP 1 * FROM [dbo].[GEN_RPRActions] WHERE [GEN_QueueRef]=@GEN_QueueRef)
				BEGIN
					INSERT INTO [dbo].[GEN_RPRActions]
							([GEN_QueueRef],[ActionLkup],[ResolutionLkup],[RootCauseLkup],[PendReasonLkup],[AdjustedCreateDate],
							[AdjustedCreateDateReasonLkup],[SubmissionTypeLkup],[ContainsErrorsLkup],[RPCSubmissionDate],
							[CMSAccountManagerSubmissionDate],[CMSAccountManagerApprovalDate],[FDRStatusLkup],[FDRReceivedDate],[FDRCodeReceived],
							[FDRDescription],[CMSProcessDate],[TransactionType],[FDRRejectionTypeLkup],[LastName],[DateofBirth],[ContractIDLkup],
							[PBPLkup],[ApplicationDate],[EffectiveDate],[EndDate],[ActualSubmissionDate],[ReasonSubmissionRejected],[RequestedSCC],
							[RequestedZIP],[ResubmissionDate],[TransactionTypeCodeLkup],[ExplanationOfRootCauseLkup],[VerifiedRootCauseLkup],[PlanError],[IsActive],
							[UTCCreatedOn],[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef])
					VALUES  (@GEN_QueueRef,@ActionLkup,@ResolutionLkup,@RootCauseLkup,@PendReasonLkup,@AdjustedCreateDate,@AdjustedCreateDateReasonLkup,
							@SubmissionTypeLkup,@ContainsErrorsLkup,@RPCSubmissionDate,@CMSAccountManagerSubmissionDate,@CMSAccountManagerApprovalDate,
							@FDRStatusLkup,@FDRReceivedDate,@FDRCodeReceived,@FDRDescription,@CMSProcessDate,@TransactionType,@FDRRejectionTypeLkup,
							@LastName,@DateofBirth,@ContractIDLkup,@PBPLkup,@ApplicationDate,@EffectiveDate,@EndDate,@ActualSubmissionDate,
							@ReasonSubmissionRejected,@RequestedSCC,@RequestedZIP,@ResubmissionDate,@TransactionTypeCodeLkup,@ExplanationOfRootCauseLkup,@VerifiedRootCauseLkup,
							@PlanError,@IsActive,@UTCDate,@LoginUserId,
							@UTCDate,@LoginUserId)
				END
			ELSE
				BEGIN
					UPDATE [dbo].[GEN_RPRActions] 
					SET	 [ActionLkup]=@ActionLkup,[ResolutionLkup]=@ResolutionLkup,[RootCauseLkup]=@RootCauseLkup,[PendReasonLkup]=@PendReasonLkup,[AdjustedCreateDate]=@AdjustedCreateDate,[AdjustedCreateDateId]=FORMAT(@AdjustedCreateDate, 'yyyyMMdd'),
						 [AdjustedCreateDateReasonLkup]=@AdjustedCreateDateReasonLkup,[OtherAdjustedCreateDateReason]=@OtherAdjustedCreateDateReason,[SubmissionTypeLkup]=@SubmissionTypeLkup,[ContainsErrorsLkup]=@ContainsErrorsLkup,[RPCSubmissionDate]=@RPCSubmissionDate,
						 [RPCSubmissionDateId]=FORMAT(@RPCSubmissionDate, 'yyyyMMdd'),[CMSAccountManagerSubmissionDate]=@CMSAccountManagerSubmissionDate,[CMSAccountManagerApprovalDate]=@CMSAccountManagerApprovalDate,[CMSAccountManagerApprovalDateId]=FORMAT(@CMSAccountManagerApprovalDate, 'yyyyMMdd'),[FDRStatusLkup]=@FDRStatusLkup,[OtherFDRStatus]=@OtherFDRStatus,
						 [FDRReceivedDate]=@FDRReceivedDate,[FDRReceivedDateId]=FORMAT(@FDRReceivedDate, 'yyyyMMdd'),[FDRCodeReceived]=@FDRCodeReceived,[FDRDescription]=@FDRDescription,[CMSProcessDate]=@CMSProcessDate,[TransactionType]=@TransactionType,
						 [FDRRejectionTypeLkup]=@FDRRejectionTypeLkup,[LastName]=@LastName,[ElectionTypeLkup]=@ElectionTypeLkup,[DateofBirth]=@DateofBirth,[ContractIDLkup]=@ContractIDLkup,[PBPLkup]=@PBPLkup,[ApplicationDate]=@ApplicationDate,
						 [EffectiveDate]=@EffectiveDate,[EndDate]=@EndDate,[ActualSubmissionDate]=@ActualSubmissionDate,[ReasonSubmissionRejected]=@ReasonSubmissionRejected,
						 [RequestedSCC]=@RequestedSCC,[RequestedZIP]=@RequestedZIP,[ResubmissionDate]=@ResubmissionDate,[PotentialSubmissionDate]=@PotentialSubmissionDate,[PotentialSubmissionDateId]=FORMAT(@PotentialSubmissionDate, 'yyyyMMdd'),
						 [TransactionTypeCodeLkup]=@TransactionTypeCodeLkup,[ExplanationOfRootCauseLkup]=@ExplanationOfRootCauseLkup,[VerifiedRootCauseLkup]=@VerifiedRootCauseLkup,[PlanError] = @PlanError,[IsActive]=@IsActive,[UTCLastUpdatedOn]=@UTCDate,[LastUpdatedByRef]=@LoginUserId
					WHERE [GEN_QueueRef]=@GEN_QueueRef
			END

			UPDATE [dbo].[GEN_Queue] SET
			 [RPRCategoryLkup]= CASE WHEN ([RPRCategoryLkup] IS NULL OR @RPRCategoryLkup != [RPRCategoryLkup]) THEN @RPRCategoryLkup ELSE [RPRCategoryLkup] END
			,[PreviousAssignedToRef]=@PreviousAssignedToRef
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
			,[CMSTransactionStatusLkup]=CASE WHEN (@ActionLkup = 28013 AND @CMSTransactionStatusLkup IS NOT NULL) THEN @CMSTransactionStatusLkup ELSE [CMSTransactionStatusLkup] END
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
				,[CMSTransactionStatusLkup]=NULL
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

			-----------Close Parent case of RPR record BEGIN-----------
			IF(@ParentQueueRef IS NOT NULL AND (@ActionLkup = 28002 OR @ActionLkup = 28004 OR @ActionLkup = 28011 OR @ActionLkup = 28027))
			BEGIN
				SELECT @WorkBasketLkup=[WorkBasketLkup],@DiscrepancyCategoryLkup=[DiscrepancyCategoryLkup],@AssignedToRef=[AssignedToRef],@PreviousAssignedToRef=[PreviousAssignedToRef],@MostRecentQueueLkup=[MostRecentWorkQueueLkup],
					   @MostRecentStatusLkup=[MostRecentStatusLkup],@MostRecentActionLkup=[MostRecentActionLkup],@PreviousWorkQueueLkup=[PreviousWorkQueueLkup],@PreviousAuditWorkQueueLkup=[PreviousAuditWorkQueueLkup]
				FROM [dbo].[GEN_Queue]
				WHERE [GEN_QueueId]=@ParentQueueRef
				
				IF(@DiscrepancyCategoryLkup = 6002 OR @DiscrepancyCategoryLkup = 6003)
				BEGIN
					SET @IsCaseResolved = 1
					SET @NextQueueLkup = CASE WHEN @DiscrepancyCategoryLkup = 6002 THEN 10019 ELSE (CASE WHEN @DiscrepancyCategoryLkup = 6003 THEN 10036 END) END
					SET @NextStatusLkup = 20003
					UPDATE [dbo].[GEN_Queue] SET
					 [MostRecentActionLkup]=28002
					,[MostRecentWorkQueueLkup]=@NextQueueLkup
					,[MostRecentStatusLkup]=@NextStatusLkup -- Resolved- Completed
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
					WHERE [GEN_QueueId] = @ParentQueueRef AND [DiscrepancyCategoryLkup] IN (6002,6003) AND [MostRecentWorkQueueLkup] IN (10029,10091) AND [MostRecentStatusLkup]!=20003 AND [IsActive]=1 

				--- Insert record into Manage cases
				INSERT INTO [dbo].[GEN_ManageCases]([GEN_QueueRef],[ActionPerformedLkup],[CurrentUserRef],[CasesComments],[ReAssignUserRef],[IsActive],[UTCCreatedOn],
								[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef])
				VALUES(@ParentQueueRef,28002,@LoginUserId,NULL,NULL,@IsActive,@UTCDate,@LoginUserId,@UTCDate,@LoginUserId)
			
				--- Insert record into Gen_Queue Workflow correlation
				INSERT INTO [dbo].[GEN_QueueWorkFlowCorrelation]
				([GEN_QueueRef],[RoleLkup],[WorkBasketLkup],[DiscrepancyCategoryLkup],[PreviousActionLkup],[PreviousWorkQueuesLkup],
					[PreviousStatusLkup],[CurrentActionLkup],[CurrentWorkQueuesLkup],[CurrentStatusLkup],[IsActive],[UTCCreatedOn],
					[CreatedByRef])
				VALUES(@ParentQueueRef,@RoleLkup,@WorkBasketLkup,@DiscrepancyCategoryLkup,@MostRecentActionLkup,@MostRecentQueueLkup,@MostRecentStatusLkup,
					28002,@NextQueueLkup,@NextStatusLkup,@IsActive,@UTCDate,@LoginUserId)

				END
			END
			-----------Close Parent case of RPR record END-----------

		COMMIT TRAN RPRACTIONS
	END TRY
	BEGIN CATCH		
		ROLLBACK TRAN RPRACTIONS;
		INSERT INTO [dbo].[CMN_AppErrorLog] (ADM_UserMasterRef,[ErrorLocation],[ErrorSourceLkup],[ErrorMessage],[ErrorDescription],[UTCErrorDateTime],[UTCCreatedOn])
		VALUES(@LoginUserId,'[dbo].[USP_APP_UPD_RPRActions]',null,ERROR_NUMBER(),ERROR_MESSAGE(),GETUTCDATE(),GETUTCDATE())
	END CATCH 
END