IF OBJECT_ID ('USP_APP_INS_CreateSuspectCase') IS NOT NULL 
BEGIN
	DROP PROC [dbo].[USP_APP_INS_CreateSuspectCase]
END
GO

IF TYPE_ID ('TVP_Attachments') IS NOT NULL
BEGIN
	DROP Type [DBO].[TVP_Attachments]
END
GO

/****** Object:  UserDefinedTableType [dbo].[TVP_Skills]    Script Date: 06/21/2017 10:37:47 AM ******/
CREATE TYPE [dbo].[TVP_Attachments] AS TABLE(
[GEN_AttachmentsId] bigint NULL,
[GEN_QueueRef] bigint NULL,
[UploadedFileName] varchar(100) NULL,
[FileName] varchar(100) NULL,
[FilePath] varchar(500) NULL,
[GEN_DMSDataRef] bigint NULL,
[IsActive] bit NULL
)
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: Praveen Joshi
-- Create date: 06/19/2017
-- Modified By: 
-- Modification Date: 
-- Description: insert values into GEN_QUEUE,GEN_Comment, GEN_QUEUEWorkFlowCorrelation,
-- GEN_Comments table in db while creating a new suspect case.
-- Eg.
-- Declare @ErrorMessage VARCHAR(2000)
-- Set @ErrorMessage=''
-- Exec [USP_APP_INS_SuspectCase] @ErrorMessage = @ErrorMessage Output
-- =============================================
CREATE PROCEDURE [dbo].[USP_APP_INS_CreateSuspectCase]
@IsCloneCase BIT = NULL,
@BusinessSegmentLkup bigint = NULL,
@WorkBasketLkup bigint = NULL,
@DiscrepancyCategoryLkup bigint = NULL,
@DiscrepancyTypeLkup bigint = NULL,
@StartDate datetime = NULL,
@StartDateId bigint = NULL,
@EndDate datetime = NULL,
@EndDateId bigint = NULL,
@PreviousAssignedToRef bigint=NULL,
@MostRecentActionLkup bigint = NULL,
@MostRecentWorkQueueLkup bigint = NULL,
@MostRecentStatusLkup bigint = NULL,
@SourceSystemLkup bigint = NULL,
@SourceSystemId varchar(20) = NULL,
@DiscrepancySourceLkup bigint = NULL,
@DiscrepancyReceiptDate datetime = NULL,
@DiscrepancyReceiptDateId bigint = NULL,
@ComplianceStartDate datetime = NULL,
@ComplianceStartDateId bigint = NULL,
@DisenrollmentDate datetime =NULL,
@DiscrepancyStartDate datetime = NULL,
@DiscrepancyStartDateId bigint = NULL,
@DiscrepancyEndDate datetime = NULL,
@DiscrepancyEndDateId bigint = NULL,
@MemberSCCCode varchar(50) = NULL,
@MemberID varchar(20) = NULL,
@MemberCurrentHICN varchar(20) = NULL,
@GPSHouseholdID varchar(20) = NULL,
@MemberFirstName varchar(35) = NULL,
@MemberMiddleName varchar(35) = NULL,
@MemberLastName varchar(35) = NULL,
@MemberContractIDLkup bigint = NULL,
@MemberPBPLkup bigint = NULL,
@MemberLOBLkup bigint = NULL,
@MemberVerifiedState varchar(5) = NULL,
@MemberVerifiedCountyCode varchar(3) = NULL,
@MemberDOB datetime = NULL,
@MemberDOBId bigint = NULL,
@MemberGenderLkup bigint = NULL,
@EligGPSContractIDLkup bigint = NULL,
@EligGPSPBPLkup bigint = NULL,
@EligGPSSCCCode varchar(50) = NULL,
@EligGPSCurrentHICN varchar(20) = NULL,
@EligGPSInsuredPlanEffectiveDate datetime = NULL,
@EligGPSInsuredPlanEffectiveDateId bigint = NULL,
@EligGPSInsuredPlanTermDate datetime = NULL,
@EligGPSInsuredPlanTermDateId bigint = NULL,
@EligGPSLOBLkup bigint = NULL,
@EligGPSMemberDOB datetime = NULL,
@EligGPSMemberDOBId bigint = NULL,
@EligGPSGenderLkup bigint = NULL,
@EligMMRContractIDLkup bigint = NULL,
@EligMMRPBPLkup bigint = NULL,
@EligMMRSCCCode varchar(50) = NULL,
@EligMMRCurrentHICN varchar(20) = NULL,
@EligMMRPaymentAdjustmentStartDate datetime = NULL,
@EligMMRPaymentAdjustmentStartDateId bigint = NULL,
@EligMMRPaymentAdjustmentEndDate datetime = NULL,
@EligMMRPaymentAdjustmentEndDateId bigint = NULL,
@EligMMRPaymentMonth datetime = NULL,
@EligMMRDOB datetime = NULL,
@EligMMRDOBId bigint = NULL,
@EligMMRGenderLkup bigint = NULL,
@EligOOAFlagLkup bit = NULL,
@RPRRequestedEffectiveDate datetime = NULL,
@RPRRequestedEffectiveDateId bigint = NULL,
@RPRActionRequestedLkup bigint = NULL,
@RPROtherActionRequested varchar(50) = NULL,
@RPRSupervisorOrRequesterRef bigint = NULL,
@RPRReasonforRequest varchar(2000) = NULL,
@RPRTaskPerformedLkup bigint = NULL,
@RPROtherTaskPerformed varchar(50) = NULL,
@RPRCTMMember bit = NULL,
@RPRCTMNumber varchar(20) = NULL,
@RPREGHPMember bit = NULL,
@RPREmployerID varchar(20) = NULL,
@SCCRPRRequested varchar(50) = NULL,
@SCCRPRRequestedZip varchar(11) = NULL,
@SCCRPRRequstedSubmissionDate datetime = NULL,
@SCCRPRRequstedSubmissionDateId bigint = NULL,
@SCCRPREffectiveStartDate datetime = NULL,
@SCCRPREffectiveStartDateId bigint = NULL,
@SCCRPREffectiveEndDate datetime = NULL,
@SCCRPREffectiveEndDateId bigint = NULL,
@IsParentCase bit = NULL,
@IsChildCase bit = NULL,
@ParentQueueRef bigint = NULL,
@Comments varchar(4000) = NULL,
@ReAssignUserRef bigint = NULL,
@CasesComments Varchar(4000)=NULL,
@RoleLkup bigint = 0,
@PreviousActionLkup bigint = 0,
@PreviousWorkQueuesLkup bigint = 0,
@PreviousStatusLkup bigint = 0,
@CurrentActionLkup bigint = 0,
@CurrentWorkQueuesLkup bigint = 0,
@CurrentStatusLkup bigint = 0,
@TRCLkup bigint = NULL,
@LoginUserId BIGINT,
@MIIMReferenceId Varchar(10)=null,
@RPRCategoryLkup bigint = 0,
@CommentsSourceSystemLkup bigint = 0,
@OOALetterStatusLkup bigint = NULL,
@CMSTransactionStatusLkup bigint = NULL,
@IsRestricted bit = NULL,
@PDPAutoEnrolleeInd bit=NULL,
@TV_Attachments as [dbo].[TVP_Attachments] readonly,
@GEN_QueueId BIGINT OUT,
@ErrorMessage VARCHAR(2000) OUT

AS
BEGIN  
	BEGIN TRY  
		BEGIN TRAN CreateSusPectCase
		Declare @UserId bigint=@LoginUserId
		DECLARE @UTCDate DATETIME
		Declare @UTCDateId bigint
		Declare @UTCMonth int
		Declare @UTCDay int
		Declare @UTCYear int

		----CST
		DECLARE @CSTDate DATETIME
		Declare @CSTDateId bigint
		Declare @CSTMonth int
		Declare @CSTDay int
		Declare @CSTYear int
		SET @UTCDate=getutcdate()
		SET @UTCDateId =FORMAT(@UTCDate, 'yyyyMMdd')
		SET @UTCMonth =FORMAT(@UTCDate, 'MM')
		SET @UTCDay =FORMAT(@UTCDate, 'dd')
		SET @UTCYear =FORMAT(@UTCDate, 'yyyy')
		
		SET @CSTDate=GetDate()
		SET @CSTDateId =FORMAT(@CSTDate, 'yyyyMMdd')
		SET @CSTMonth =FORMAT(@CSTDate, 'MM')
		SET @CSTDay =FORMAT(@CSTDate, 'dd')
		SET @CSTYear =FORMAT(@CSTDate, 'yyyy')

		SET @GEN_QueueId = 0
		DECLARE @GEN_OSTActionsId bigint = 0
		DECLARE @GEN_EligibilityActionsId bigint = 0
		DECLARE @GEN_RPRActionsId bigint = 0
		DECLARE @GEN_ManageCasesId bigint = 0
		
		INSERT INTO [dbo].[GEN_Queue]([BusinessSegmentLkup],[WorkBasketLkup],[DiscrepancyCategoryLkup],[DiscrepancyTypeLkup],[StartDate],[StartDateId],[EndDate],
		       [EndDateId],[MostRecentActionLkup],[MostRecentWorkQueueLkup],[MostRecentStatusLkup],[SourceSystemLkup],
		       [SourceSystemId],[DiscrepancySourceLkup],[DiscrepancyReceiptDate],[DiscrepancyReceiptDateId],[ComplianceStartDate],
		       [ComplianceStartDateId],[DisenrollmentDate],[DiscrepancyStartDate],[DiscrepancyStartDateId],[DiscrepancyEndDate],[DiscrepancyEndDateId],
			   [MemberSCCCode],[MemberID],[MemberCurrentHICN],[GPSHouseholdID],[MemberFirstName],[MemberMiddleName],[MemberLastName],
			   [MemberContractIDLkup],[MemberPBPLkup],[MemberLOBLkup],[MemberVerifiedState],[MemberVerifiedCountyCode],[MemberDOB],[MemberDOBId],[MemberGenderLkup],[EligGPSContractIDLkup],[EligGPSPBPLkup],
			   [EligGPSSCCCode],[EligGPSCurrentHICN],[EligGPSInsuredPlanEffectiveDate],[EligGPSInsuredPlanEffectiveDateId],
			   [EligGPSInsuredPlanTermDate],[EligGPSInsuredPlanTermDateId],[EligGPSLOBLkup],[EligGPSMemberDOB],[EligGPSMemberDOBId],
			   [EligGPSGenderLkup],[EligMMRContractIDLkup],[EligMMRPBPLkup],[EligMMRSCCCode],[EligMMRCurrentHICN],
			   [EligMMRPaymentAdjustmentStartDate],[EligMMRPaymentAdjustmentStartDateId],[EligMMRPaymentAdjustmentEndDate],
			   [EligMMRPaymentAdjustmentEndDateId],[EligMMRPaymentMonth],[EligMMRDOB],[EligMMRDOBId],[EligMMRGenderLkup],[EligOOAFlagLkup],
			   [RPRRequestedEffectiveDate],[RPRRequestedEffectiveDateId],[RPRActionRequestedLkup],[RPROtherActionRequested],[RPRSupervisorOrRequesterRef]
			   ,[RPRReasonforRequest],[RPRTaskPerformedLkup],[RPROtherTaskPerformed],[RPRCTMMember],[RPRCTMNumber],
			   [RPREGHPMember],[RPREmployerID],[SCCRPRRequested],[SCCRPRRequestedZip],
			   [SCCRPRRequstedSubmissionDate],[SCCRPRRequstedSubmissionDateId],[SCCRPREffectiveStartDate],[SCCRPREffectiveStartDateId],
			   [SCCRPREffectiveEndDate],[SCCRPREffectiveEndDateId],[OOALetterStatusLkup],[CMSTransactionStatusLkup],[IsParentCase],
			   [IsChildCase],[ParentQueueRef],[TRCLkup],[IsActive],[UTCCreatedOn],[UTCCreatedOnId],[UTCCreatedOnYear],[UTCCreatedOnMonth],
			   [UTCCreatedOnDay],[CSTCreatedOn],[CSTCreatedOnId],[CSTCreatedOnYear],[CSTCreatedOnMonth],[CSTCreatedOnDay],[CreatedByRef],
			   [UTCLastUpdatedOn],[UTCLastUpdatedOnId],[UTCLastUpdatedOnYear],[UTCLastUpdatedOnMonth],[UTCLastUpdatedOnDay],
			   [CSTLastUpdatedOn],[CSTLastUpdatedOnId],[CSTLastUpdatedOnYear],[CSTLastUpdatedOnMonth],[CSTLastUpdatedOnDay],[LastUpdatedByRef],[MIIMReferenceId],[RPRCategoryLkup],[IsRestricted],[PDPAutoEnrolleeInd],[MemberMedicareId])
		 VALUES		 
			   (@BusinessSegmentLkup,@WorkBasketLkup,@DiscrepancyCategoryLkup,@DiscrepancyTypeLkup,@StartDate,@StartDateId,@EndDate,@EndDateId,
			   @MostRecentActionLkup,@MostRecentWorkQueueLkup,@MostRecentStatusLkup,@SourceSystemLkup,@SourceSystemId,
			   @DiscrepancySourceLkup,@DiscrepancyReceiptDate,@DiscrepancyReceiptDateId,@ComplianceStartDate,@ComplianceStartDateId,@DisenrollmentDate,
			   @DiscrepancyStartDate,@DiscrepancyStartDateId,@DiscrepancyEndDate,@DiscrepancyEndDateId,@MemberSCCCode
			   ,@MemberID,@MemberCurrentHICN,@GPSHouseholdID,@MemberFirstName,@MemberMiddleName,@MemberLastName
			   ,@MemberContractIDLkup,@MemberPBPLkup,
			   @MemberLOBLkup,@MemberVerifiedState,@MemberVerifiedCountyCode,@MemberDOB,@MemberDOBId,@MemberGenderLkup,@EligGPSContractIDLkup
			   ,@EligGPSPBPLkup,@EligGPSSCCCode,@EligGPSCurrentHICN,
			   @EligGPSInsuredPlanEffectiveDate,@EligGPSInsuredPlanEffectiveDateId,@EligGPSInsuredPlanTermDate,@EligGPSInsuredPlanTermDateId,
			   @EligGPSLOBLkup,@EligGPSMemberDOB,@EligGPSMemberDOBId,@EligGPSGenderLkup,@EligMMRContractIDLkup,@EligMMRPBPLkup,
			   @EligMMRSCCCode,@EligMMRCurrentHICN,@EligMMRPaymentAdjustmentStartDate,@EligMMRPaymentAdjustmentStartDateId,
			   @EligMMRPaymentAdjustmentEndDate,@EligMMRPaymentAdjustmentEndDateId,@EligMMRPaymentMonth,@EligMMRDOB,@EligMMRDOBId,
			   @EligMMRGenderLkup,@EligOOAFlagLkup,@RPRRequestedEffectiveDate,@RPRRequestedEffectiveDateId,@RPRActionRequestedLkup,@RPROtherActionRequested,
			   @RPRSupervisorOrRequesterRef,@RPRReasonforRequest,@RPRTaskPerformedLkup,@RPROtherTaskPerformed,@RPRCTMMember,@RPRCTMNumber
			   ,@RPREGHPMember,@RPREmployerID,@SCCRPRRequested,
			   @SCCRPRRequestedZip,@SCCRPRRequstedSubmissionDate,@SCCRPRRequstedSubmissionDateId,@SCCRPREffectiveStartDate,@SCCRPREffectiveStartDateId,
			   @SCCRPREffectiveEndDate,@SCCRPREffectiveEndDateId,@OOALetterStatusLkup,@CMSTransactionStatusLkup,@IsParentCase,@IsChildCase,
			   @ParentQueueRef,@TRCLkup,1,@UTCDate,@UTCDateId,@UTCYear,@UTCMonth,@UTCDay,@CSTDate,
			   @CSTDateId,@CSTYear,@CSTMonth,@CSTDay,@LoginUserId,@UTCDate,@UTCDateId,
			   @UTCYear,@UTCMonth,@UTCDay,@CSTDate,@CSTDateId,@CSTYear,
			   @CSTMonth,@CSTDay,@LoginUserId,@MIIMReferenceId,@RPRCategoryLkup,@IsRestricted,@PDPAutoEnrolleeInd,@MemberCurrentHICN)

			   SELECT @GEN_QueueId = Scope_Identity()

        --Clone a Record
	    IF(@IsCloneCase=1 AND @ParentQueueRef IS NOT NULL AND @ParentQueueRef>0)
		BEGIN

		  DECLARE @PDiscrepancyCategoryLkup BIGINT = NULL
		          ,@PMostRecentQueueLkup BIGINT = NULL
				  ,@PMostRecentStatusLkup BIGINT = NULL
				  ,@PMostRecentActionLkup BIGINT = NULL
				  ,@NextWorkQueueLkup BIGINT = NULL
				  ,@NextStatusLkup BIGINT = 20003 --Status - RESOLVED COMPLETED
				  ,@ActionLkup BIGINT = 28079 --Action - Clone Case
		
			SELECT @PDiscrepancyCategoryLkup=[DiscrepancyCategoryLkup],@PMostRecentQueueLkup=[MostRecentWorkQueueLkup],
			@PMostRecentStatusLkup=[MostRecentStatusLkup],@PMostRecentActionLkup=[MostRecentActionLkup]
			FROM dbo.[GEN_Queue]
			WHERE [GEN_QueueId]=@ParentQueueRef
			
			IF(@PDiscrepancyCategoryLkup = 6001)
				SET @NextWorkQueueLkup = 10004
			ELSE IF(@PDiscrepancyCategoryLkup = 6002)
				SET @NextWorkQueueLkup = 10019
			ELSE IF(@PDiscrepancyCategoryLkup = 6003)
				SET @NextWorkQueueLkup = 10036
			ELSE IF(@PDiscrepancyCategoryLkup = 6004)
				SET @NextWorkQueueLkup = 10053
			ELSE IF(@PDiscrepancyCategoryLkup = 6005)
				SET @NextWorkQueueLkup = 10059
			ELSE IF(@PDiscrepancyCategoryLkup = 6006)
				SET @NextWorkQueueLkup = 10063
			ELSE IF(@PDiscrepancyCategoryLkup = 6007)
				SET @NextWorkQueueLkup = 10069
		  
		----------Unlock ParentRecord--------------
			DELETE FROM CMN_RecordsLocked WHERE [ScreenLkup]=37010 AND [CaseId]=@ParentQueueRef

		--------Update Gen_Queue---------- To close
		    UPDATE GEN_QUEUE SET
			 [MostRecentActionLkup] = @ActionLkup 
			,[MostRecentWorkQueueLkup] = @NextWorkQueueLkup
			,[MostRecentStatusLkup] = @NextStatusLkup 
			,[PreviousWorkQueueLkup] = NULL,[PreviousAuditWorkQueueLkup] = NULL	,[AssignedToRef]= @LoginUserId
			,[UTCAssignedOn]=@UTCDate,[UTCAssignedOnId]=FORMAT(@UTCDate, 'yyyyMMdd'),[UTCAssignedOnYear]=FORMAT(@UTCDate, 'yyyy')
			,[UTCAssignedOnMonth]=FORMAT(@UTCDate, 'MM'),[UTCAssignedOnDay]=FORMAT(@UTCDate, 'dd')
			,[CSTAssignedOn]=DATEADD(hh, -6, @UTCDate),[CSTAssignedOnId]=FORMAT(DATEADD(hh, -6, @UTCDate), 'yyyyMMdd')
			,[CSTAssignedOnYear]=FORMAT(DATEADD(hh, -6, @UTCDate), 'yyyy'),[CSTAssignedOnMonth]=FORMAT(DATEADD(hh, -6, @UTCDate), 'MM')
			,[CSTAssignedOnDay]=FORMAT(DATEADD(hh, -6, @UTCDate), 'dd'),[IsCasePended] = 0
			,[PendedbyRef] = NULL,[UTCPendedOn] = NULL,[UTCPendedOnId] = NULL
			,[UTCPendedOnYear] = NULL,[UTCPendedOnMonth] = NULL,[UTCPendedOnDay] = NULL
			,[CSTPendedOn] = NULL,[CSTPendedOnId] = NULL,[CSTPendedOnYear] = NULL
			,[CSTPendedOnMonth] = NULL,[CSTPendedOnDay] = NULL,[IsCaseResolved] = 1,[ResolvedByRef] = @LoginUserId
			,[UTCResolvedOn] = @UTCDate,[UTCResolvedOnId] = FORMAT(@UTCDate, 'yyyyMMdd')
			,[UTCResolvedOnYear] = FORMAT(@UTCDate, 'yyyy'),[UTCResolvedOnMonth] = FORMAT(@UTCDate, 'MM')
			,[UTCResolvedOnDay] = FORMAT(@UTCDate, 'dd'),[CSTResolvedOn] = DATEADD(hh, -6, @UTCDate)
			,[CSTResolvedOnId] = FORMAT(DATEADD(hh, -6, @UTCDate), 'yyyyMMdd')
			,[CSTResolvedOnYear] = FORMAT(DATEADD(hh, -6, @UTCDate), 'yyyy')
			,[CSTResolvedOnMonth] = FORMAT(DATEADD(hh, -6, @UTCDate), 'MM')
			,[CSTResolvedOnDay] = FORMAT(DATEADD(hh, -6, @UTCDate), 'dd'),[LockedByRef]= NULL,[UTCLockedOn]=NULL
			,[UTCLockedOnId]=NULL,[UTCLockedOnYear]=NULL,[UTCLockedOnMonth]=NULL
			,[UTCLockedOnDay]=NULL,[CSTLockedOn]=NULL,[CSTLockedOnId]=NULL,[CSTLockedOnYear]=NULL
			,[CSTLockedOnMonth]=NULL,[CSTLockedOnDay]=NULL,[UTCLastUpdatedOn]= @UTCDate
			,[UTCLastUpdatedOnId]= FORMAT(@UTCDate, 'yyyyMMdd'),[UTCLastUpdatedOnYear]= FORMAT(@UTCDate, 'yyyy')
			,[UTCLastUpdatedOnMonth]= FORMAT(@UTCDate, 'MM'),[UTCLastUpdatedOnDay]= FORMAT(@UTCDate, 'dd')
			,[CSTLastUpdatedOn]= DATEADD(hh, -6, @UTCDate),[CSTLastUpdatedOnId]= FORMAT(DATEADD(hh, -6, @UTCDate), 'yyyyMMdd')
			,[CSTLastUpdatedOnYear]= FORMAT(DATEADD(hh, -6, @UTCDate), 'yyyy'),[CSTLastUpdatedOnMonth]= FORMAT(DATEADD(hh, -6, @UTCDate), 'MM')
			,[CSTLastUpdatedOnDay]= FORMAT(DATEADD(hh, -6, @UTCDate), 'dd')
			,[LastUpdatedByRef] =@LoginUserId
			WHERE GEN_QueueId=@ParentQueueRef

		    IF NOT EXISTS(SELECT TOP 1 * FROM [dbo].[GEN_OSTActions] WHERE [GEN_QueueRef]=@ParentQueueRef)
		    BEGIN
				INSERT INTO [dbo].[GEN_OSTActions]
							([GEN_QueueRef],[ActionLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef])
					VALUES  (@ParentQueueRef,@ActionLkup,1,@UTCDate,@LoginUserId,@UTCDate,@LoginUserId)
			END
			ELSE
			BEGIN
				UPDATE [dbo].[GEN_OSTActions] 
				SET [ActionLkup]=@ActionLkup,
				[UTCLastUpdatedOn]=@UTCDate,[LastUpdatedByRef]=@LoginUserId
				WHERE [GEN_QueueRef] = @ParentQueueRef
			END

			--- Insert record into Manage cases
			INSERT INTO [dbo].[GEN_ManageCases]([GEN_QueueRef],[ActionPerformedLkup],[CurrentUserRef],[CasesComments],[ReAssignUserRef],[IsActive],[UTCCreatedOn],
							[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef])
			VALUES(@ParentQueueRef,@ActionLkup,@LoginUserId,NULL,NULL,1,@UTCDate,@LoginUserId,@UTCDate,@LoginUserId)

			---------Insert Into Workflow Cor-relation
			INSERT INTO [dbo].[GEN_QueueWorkFlowCorrelation]
			([GEN_QueueRef],[RoleLkup],[WorkBasketLkup],[DiscrepancyCategoryLkup],[PreviousActionLkup],[PreviousWorkQueuesLkup],
				[PreviousStatusLkup],[CurrentActionLkup],[CurrentWorkQueuesLkup],[CurrentStatusLkup],[IsActive],[UTCCreatedOn],
				[CreatedByRef])
			VALUES(@ParentQueueRef,@RoleLkup,@WorkBasketLkup,@PDiscrepancyCategoryLkup,@PMostRecentActionLkup,@PMostRecentQueueLkup,@PMostRecentStatusLkup,
				@ActionLkup,@NextWorkQueueLkup,@NextStatusLkup,1,@UTCDate,@LoginUserId)

		    --- Insert Comments from Parent case
			INSERT INTO [dbo].[GEN_Comments] ([GEN_QueueRef],[Comments],[ActionLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef],[SourceSystemLkup])
			SELECT @GEN_QueueId,[Comments],[ActionLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef],[SourceSystemLkup]
			FROM [dbo].[GEN_Comments]
			WHERE [GEN_QueueRef] = @ParentQueueRef AND [IsActive] = 1

			--- Insert Attachments from Parent case
			INSERT INTO [dbo].[GEN_Attachments] ([GEN_QueueRef],[UploadedFileName],[FileName],[FilePath],[GEN_DMSDataRef],[IsActive],[UTCCreatedOn],[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef])
			SELECT @GEN_QueueId,[UploadedFileName],[FileName],[FilePath],[GEN_DMSDataRef],[IsActive],[UTCCreatedOn],[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef]
			FROM [dbo].[GEN_Attachments]
			WHERE [GEN_QueueRef] = @ParentQueueRef AND [IsActive] = 1
		   
		END
		
		ELSE IF((@IsCloneCase=0 OR @IsCloneCase IS NULL) AND @ParentQueueRef IS NOT NULL AND @ParentQueueRef>0)
		BEGIN
			--- Insert Comments from Parent case
			INSERT INTO [dbo].[GEN_Comments] ([GEN_QueueRef],[Comments],[ActionLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef],[SourceSystemLkup])
			SELECT @GEN_QueueId,[Comments],[ActionLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef],[SourceSystemLkup]
			FROM [dbo].[GEN_Comments]
			WHERE [GEN_QueueRef] = @ParentQueueRef AND [IsActive] = 1

			--- Insert Attachments from Parent case
			INSERT INTO [dbo].[GEN_Attachments] ([GEN_QueueRef],[UploadedFileName],[FileName],[FilePath],[GEN_DMSDataRef],[IsActive],[UTCCreatedOn],[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef])
			SELECT @GEN_QueueId,[UploadedFileName],[FileName],[FilePath],[GEN_DMSDataRef],[IsActive],[UTCCreatedOn],[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef]
			FROM [dbo].[GEN_Attachments]
			WHERE [GEN_QueueRef] = @ParentQueueRef AND [IsActive] = 1
		END

		IF @TRCLkup = 22001 AND @LoginUserId > 1000 --insert extra comment for TRC case when TRC = 016 and User is other than system
		BEGIN
			INSERT INTO [dbo].[GEN_Comments]
						([GEN_QueueRef],[Comments],[ActionLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef],[SourceSystemLkup])
			VALUES      (@GEN_QueueId,'Manually Created TRC 016 Case - Routed to Escalated Queue Per Designated Workflow',@MostRecentActionLkup,1,@UTCDate,@LoginUserId,@UTCDate,@LoginUserId,@CommentsSourceSystemLkup)
		END

		IF @TRCLkup = 22005 AND @LoginUserId > 1000 --insert extra comment for TRC case when TRC = 154 and User is other than system
		BEGIN
			INSERT INTO [dbo].[GEN_Comments]
						([GEN_QueueRef],[Comments],[ActionLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef],[SourceSystemLkup])
			VALUES      (@GEN_QueueId,'Manually Created TRC 154 Case - Routed to Escalated Queue Per Designated Workflow',@MostRecentActionLkup,1,@UTCDate,@LoginUserId,@UTCDate,@LoginUserId,@CommentsSourceSystemLkup)
		END
	    --- Insert record into comments 
		IF @Comments IS NOT NULL
		BEGIN
			INSERT INTO [dbo].[GEN_Comments]
						([GEN_QueueRef],[Comments],[ActionLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef],[SourceSystemLkup])
			VALUES      (@GEN_QueueId,@Comments,@MostRecentActionLkup,1,@UTCDate,@LoginUserId,@UTCDate,@LoginUserId,@CommentsSourceSystemLkup)
		END

		--- Insert record into Manage cases

		INSERT INTO [dbo].[GEN_ManageCases]
					([GEN_QueueRef],[ActionPerformedLkup],[CurrentUserRef],[CasesComments],[ReAssignUserRef],[IsActive],[UTCCreatedOn],
					 [CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef])
		VALUES		(@GEN_QueueId,@MostRecentActionLkup,@LoginUserId,@CasesComments,@ReAssignUserRef,1,@UTCDate,@LoginUserId,
					@UTCDate,@LoginUserId)

			

		--- Insert record into Gen_Queue Workflow correlation

		INSERT INTO [dbo].[GEN_QueueWorkFlowCorrelation]
					([GEN_QueueRef],[RoleLkup],[WorkBasketLkup],[DiscrepancyCategoryLkup],[PreviousActionLkup],[PreviousWorkQueuesLkup],
					 [PreviousStatusLkup],[CurrentActionLkup],[CurrentWorkQueuesLkup],[CurrentStatusLkup],[IsActive],[UTCCreatedOn],
					 [CreatedByRef])
		VALUES		(@GEN_QueueId,@RoleLkup,@WorkBasketLkup,@DiscrepancyCategoryLkup,@PreviousActionLkup,@PreviousWorkQueuesLkup,
					 @PreviousStatusLkup,@CurrentActionLkup,@CurrentWorkQueuesLkup,@CurrentStatusLkup,1,@UTCDate,@LoginUserId)

		-----------Attachments Begin-----------
		IF EXISTS ( Select 1 from @TV_Attachments)
		BEGIN
			--Temp Table to Get newly inserted row id for Skills Correlation Table
			Create Table dbo.[#TAttachments] (GEN_AttachmentsId Bigint)

			-- Insert all new attchemnts
			INSERT INTO [dbo].[GEN_Attachments]
					([GEN_QueueRef],[UploadedFileName],[FileName],[FilePath],[GEN_DMSDataRef],[IsActive],[UTCCreatedOn],[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef])
    
			Output INSERTED.GEN_AttachmentsId Into dbo.[#TAttachments]
    
			Select @GEN_QueueId,[UploadedFileName],[FileName],[FilePath],[GEN_DMSDataRef],[IsActive],@UTCDate,@LoginUserId,@UTCDate,@LoginUserId From @TV_Attachments WHere [GEN_AttachmentsId] = 0
		END
		-----------Attachments END-----------

		





    COMMIT TRAN CreateSusPectCase
	END TRY
	BEGIN CATCH
		ROLLBACK TRAN CreateSusPectCase

		INSERT INTO [dbo].[CMN_AppErrorLog](ADM_UserMasterRef,[ErrorLocation],[ErrorSourceLkup],[ErrorMessage],[ErrorDescription],[UTCErrorDateTime],[UTCCreatedOn])
		VALUES( @UserId,'[dbo].[USP_APP_INS_CreateSuspectCase]',null,ERROR_NUMBER(),ERROR_MESSAGE(),GETUTCDATE(),GETUTCDATE())
        
		SET @ErrorMessage=ERROR_MESSAGE()

	END CATCH  
END