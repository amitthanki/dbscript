IF OBJECT_ID ('USP_APP_SEL_QueueSearch') IS NOT NULL 
DROP PROC [DBO].[USP_APP_SEL_QueueSearch]
GO

/****** Object:  StoredProcedure [dbo].[USP_APP_SEL_QueueSearch]    Script Date: 05/07/2017 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- =============================================
-- Author: Venkatasubramanyam
-- Create date: 05/07/2017
-- Description: Get Record(OST,Eligibility, RPR) search details
-- Eg.
 --Declare @ErrorMessage VARCHAR(2000)
 --Set @ErrorMessage=''
 --Exec [USP_APP_SEL_QueueSearch] ,@PageType=3001,@WorkItemId=29,@ErrorMessage = ''
-- =============================================
Create PROCEDURE [dbo].[USP_APP_SEL_QueueSearch]
@WorkItemId BIGINT=NULL,
@BusinessSegmentLkup BIGINT=NULL,
@WorkBasketLkup BIGINT=NULL,
@DiscrepancyCategoryLkup BIGINT=NULL,    
@DiscrepancyTypeLkup BIGINT=NULL,
@DiscrepancyTypeLkupNot BIGINT=NULL,
@DiscrepancySourceLkup BIGINT=NULL,       
@LOBLkup BIGINT=NULL,    
@CaseAgeFrom BIGINT=NULL,    
@CaseAgeTo BIGINT=NULL,    
@LastUpdatedOperator BIGINT=NULL,    
@AssignedTo BIGINT=NULL,    
@ActionRequested BIGINT=NULL,    
@SupervisiorofthePersonEnteringtheRequest BIGINT=NULL,    
@EGHPMember BIT=NULL,    
@EmployerId VARCHAR(100)=NULL,
@FDRStatus BIGINT=NULL,    
@VerifiedRootCause BIGINT=NULL,    
@TaskBeingPerformedWhenThisDiscrepancyWasIdentified BIGINT=NULL,    
@SubmissionTypeLkup BIGINT=NULL,    
@PendReason BIGINT=NULL,    
@Resolution BIGINT=NULL,    
@RPRRequestor BIGINT=NULL,    
@Queue BIGINT=NULL,    
@Status BIGINT=NULL,    
@StatusNot BIGINT=NULL,
@GenderLkup BIGINT=NULL,    
@CurrentHICN VARCHAR(100)=NULL,
@CTMNumber VARCHAR(100)=NULL,
@CTMMember BIT=NULL,
@MemberSCCCode VARCHAR(100)=NULL,
@FirstName VARCHAR(100)=NULL,
@LastName VARCHAR(100)=NULL,
@ContractIDLkup BIGINT=NULL,
@PBPLkup BIGINT=NULL,
@FDRCodeReceived VARCHAR(100)=NULL,
@DiscrepancyStartDateId BIGINT=NULL,
@DiscrepancyEndDateId BIGINT=NULL,
@DOBId BIGINT=NULL,
@FirstLetterMailStartDateId BIGINT=NULL,
@FirstLetterMailEndDateId BIGINT=NULL,
@SecondLetterMailStartDateId BIGINT=NULL,
@SecondLetterMailEndDateId BIGINT=NULL,
@ComplianceStartDateId BIGINT=NULL,
@ComplianceEndDateId BIGINT=NULL,
@CaseCreationStartDateId BIGINT=NULL,
@CaseCreationEndDateId BIGINT=NULL,
@CaseLastUpdatedStartDateId BIGINT=NULL,
@CaseLastUpdatedEndDateId BIGINT=NULL,
@MemberResponseVerificationStartDateId BIGINT=NULL,
@MemberResponseVerificationEndDateId BIGINT=NULL,   
@RequestedEffectiveStartDateId BIGINT=NULL,
@RequestedEffectiveEndDateId BIGINT=NULL,
@AdjustedCreateStartDateId BIGINT=NULL,
@AdjustedCreateEndDateId BIGINT=NULL,
@RPCSubmissionStartDateId BIGINT=NULL,
@RPCSubmissionEndDateId BIGINT=NULL,
@CMSAccountManagerApprovalStartDateId BIGINT=NULL,
@CMSAccountManagerApprovalEndDateId BIGINT=NULL,
@FDRReceivedStartDateId BIGINT=NULL,
@FDRReceivedEndDateId BIGINT=NULL,
@PeerAuditCompletionStartDateId BIGINT=NULL,
@PeerAuditCompletionEndDateId BIGINT=NULL,
@PageType bigint=null,--OST=3001,Eligibility=3002,RPR=3003
@TimeZoneLkup BIGINT = NULL,
@UserLoginId BIGINT = NULL,
@IsUnlock BIT = NULL,
@IsReAssign BIT = NULL,
@IsMassUpdate BIT = NULL,
@IsRestricted BIT = 0,
@TopCount BIGINT = 500,
@TransactionReplyCode BIGINT = NULL,
@MemberVerifiedState VARCHAR(10)=NULL,
@MemberVerifiedCountryCode VARCHAR(10)=NULL,
@GPSHouseholdId VARCHAR(20)=NULL,
@PDPAutoEnrolleeInd Bit = NULL,
@ErrorMessage varchar(2000) OUTPUT
as

BEGIN  

BEGIN TRY 
--Common variables for all the DiscCat
Declare @IsERSIdSelected Bit = 0;
Declare @IsMedicareIdSelected Bit = 0;
Declare @IsBothCaseAndMedicareIdSelected  Bit = 0;
Declare @IsBothDiscCatAndCaseIdSelected Bit = 0;
Declare @IsBothDiscCatAndMedicareIdSelected Bit = 0;
Declare @IsDiscCatAndCaseIdAndMedicareIdSelected Bit = 0;

--for OST
Declare @IsDiscCatOSTAndComplianceDateSelected Bit = 0;
Declare @IsDiscCatOSTAndDiscTypeAndComplianceDateSelected Bit = 0;

--For Eligibility
Declare @IsDiscCatEligibilityAndCreatedDateSelected Bit = 0;
Declare @IsDiscCatEligibilityAndDiscTypeAndCreatedDateSelected Bit = 0;

--For RPR
Declare @IsDiscCatRPRAndCreatedDateSelected Bit = 0;
Declare @IsDiscCatRPRAndDiscTypeAndCreatedDateSelected Bit = 0;


IF(@WorkItemId IS NOT NULL 
AND (@BusinessSegmentLkup IS NULL AND @WorkBasketLkup IS NULL AND @DiscrepancyCategoryLkup IS NULL AND @DiscrepancyTypeLkup  IS NULL AND @DiscrepancyTypeLkupNot  IS NULL AND @DiscrepancySourceLkup  IS NULL AND @LOBLkup  IS NULL AND @CaseAgeFrom  IS NULL AND @CaseAgeTo  IS NULL AND @LastUpdatedOperator  IS NULL AND @AssignedTo  IS NULL AND @ActionRequested  IS NULL AND @SupervisiorofthePersonEnteringtheRequest  IS NULL AND @EGHPMember IS NULL AND @EmployerId  IS NULL AND @FDRStatus  IS NULL AND @VerifiedRootCause  IS NULL AND @TaskBeingPerformedWhenThisDiscrepancyWasIdentified  IS NULL AND @SubmissionTypeLkup  IS NULL AND @PendReason  IS NULL AND @Resolution  IS NULL AND @RPRRequestor  IS NULL AND @Queue  IS NULL AND @Status  IS NULL AND @StatusNot  IS NULL AND @GenderLkup  IS NULL AND @CurrentHICN  IS NULL AND @CTMNumber  IS NULL AND @CTMMember  IS NULL AND @MemberSCCCode  IS NULL AND @FirstName  IS NULL AND @LastName  IS NULL AND @ContractIDLkup  IS NULL AND @PBPLkup  IS NULL AND @FDRCodeReceived  IS NULL AND @DiscrepancyStartDateId  IS NULL AND @DiscrepancyEndDateId  IS NULL AND @DOBId  IS NULL AND @FirstLetterMailStartDateId  IS NULL AND @FirstLetterMailEndDateId  IS NULL AND @SecondLetterMailStartDateId  IS NULL AND @SecondLetterMailEndDateId  IS NULL AND @ComplianceStartDateId  IS NULL AND @ComplianceEndDateId  IS NULL AND @CaseCreationStartDateId  IS NULL AND @CaseCreationEndDateId  IS NULL AND @CaseLastUpdatedStartDateId  IS NULL AND @CaseLastUpdatedEndDateId  IS NULL AND @MemberResponseVerificationStartDateId  IS NULL AND @MemberResponseVerificationEndDateId IS NULL AND @RequestedEffectiveStartDateId  IS NULL AND @RequestedEffectiveEndDateId  IS NULL AND @AdjustedCreateStartDateId  IS NULL AND @AdjustedCreateEndDateId 	 IS NULL AND @RPCSubmissionStartDateId  IS NULL AND @RPCSubmissionEndDateId  IS NULL AND @CMSAccountManagerApprovalStartDateId  IS NULL AND @CMSAccountManagerApprovalEndDateId  IS NULL AND @FDRReceivedStartDateId  IS NULL AND @FDRReceivedEndDateId  IS NULL AND @PeerAuditCompletionStartDateId  IS NULL AND @PeerAuditCompletionEndDateId  IS NULL AND @TimeZoneLkup  IS NULL AND @UserLoginId  IS NULL AND @IsMassUpdate  IS NULL AND @IsRestricted = 0  AND @TransactionReplyCode  IS NULL AND @MemberVerifiedState IS NULL AND @MemberVerifiedCountryCode IS NULL AND @GPSHouseholdId IS NULL))
BEGIN
SET @IsERSIdSelected = 1;
END

IF(@CurrentHICN IS NOT NULL 
AND (@WorkItemId IS NULL AND @BusinessSegmentLkup IS NULL AND @WorkBasketLkup IS NULL AND @DiscrepancyCategoryLkup IS NULL AND @DiscrepancyTypeLkup  IS NULL AND @DiscrepancyTypeLkupNot  IS NULL AND @DiscrepancySourceLkup  IS NULL AND @LOBLkup  IS NULL AND @CaseAgeFrom  IS NULL AND @CaseAgeTo  IS NULL AND @LastUpdatedOperator  IS NULL AND @AssignedTo  IS NULL AND @ActionRequested  IS NULL AND @SupervisiorofthePersonEnteringtheRequest  IS NULL AND @EGHPMember IS NULL AND @EmployerId  IS NULL AND @FDRStatus  IS NULL AND @VerifiedRootCause  IS NULL AND @TaskBeingPerformedWhenThisDiscrepancyWasIdentified  IS NULL AND @SubmissionTypeLkup  IS NULL AND @PendReason  IS NULL AND @Resolution  IS NULL AND @RPRRequestor  IS NULL AND @Queue  IS NULL AND @Status  IS NULL AND @StatusNot  IS NULL AND @GenderLkup  IS NULL AND  @CTMNumber  IS NULL AND @CTMMember  IS NULL AND @MemberSCCCode  IS NULL AND @FirstName  IS NULL AND @LastName  IS NULL AND @ContractIDLkup  IS NULL AND @PBPLkup  IS NULL AND @FDRCodeReceived  IS NULL AND @DiscrepancyStartDateId  IS NULL AND @DiscrepancyEndDateId  IS NULL AND @DOBId  IS NULL AND @FirstLetterMailStartDateId  IS NULL AND @FirstLetterMailEndDateId  IS NULL AND @SecondLetterMailStartDateId  IS NULL AND @SecondLetterMailEndDateId  IS NULL AND @ComplianceStartDateId  IS NULL AND @ComplianceEndDateId  IS NULL AND @CaseCreationStartDateId  IS NULL AND @CaseCreationEndDateId  IS NULL AND @CaseLastUpdatedStartDateId  IS NULL AND @CaseLastUpdatedEndDateId  IS NULL AND @MemberResponseVerificationStartDateId  IS NULL AND @MemberResponseVerificationEndDateId IS NULL AND @RequestedEffectiveStartDateId  IS NULL AND @RequestedEffectiveEndDateId  IS NULL AND @AdjustedCreateStartDateId  IS NULL AND @AdjustedCreateEndDateId 	 IS NULL AND @RPCSubmissionStartDateId  IS NULL AND @RPCSubmissionEndDateId  IS NULL AND @CMSAccountManagerApprovalStartDateId  IS NULL AND @CMSAccountManagerApprovalEndDateId  IS NULL AND @FDRReceivedStartDateId  IS NULL AND @FDRReceivedEndDateId  IS NULL AND @PeerAuditCompletionStartDateId  IS NULL AND @PeerAuditCompletionEndDateId  IS NULL AND @TimeZoneLkup  IS NULL AND @UserLoginId  IS NULL AND @IsMassUpdate  IS NULL AND @IsRestricted = 0  AND @TransactionReplyCode  IS NULL AND @MemberVerifiedState IS NULL AND @MemberVerifiedCountryCode IS NULL AND @GPSHouseholdId IS NULL))
BEGIN
SET @IsMedicareIdSelected = 1;
End

IF(@WorkItemId IS NOT NULL AND @CurrentHICN IS NOT NULL 
AND (@BusinessSegmentLkup IS NULL AND @WorkBasketLkup IS NULL AND @DiscrepancyCategoryLkup IS NULL AND @DiscrepancyTypeLkup  IS NULL AND @DiscrepancyTypeLkupNot  IS NULL AND @DiscrepancySourceLkup  IS NULL AND @LOBLkup  IS NULL AND @CaseAgeFrom  IS NULL AND @CaseAgeTo  IS NULL AND @LastUpdatedOperator  IS NULL AND @AssignedTo  IS NULL AND @ActionRequested  IS NULL AND @SupervisiorofthePersonEnteringtheRequest  IS NULL AND @EGHPMember IS NULL AND @EmployerId  IS NULL AND @FDRStatus  IS NULL AND @VerifiedRootCause  IS NULL AND @TaskBeingPerformedWhenThisDiscrepancyWasIdentified  IS NULL AND @SubmissionTypeLkup  IS NULL AND @PendReason  IS NULL AND @Resolution  IS NULL AND @RPRRequestor  IS NULL AND @Queue  IS NULL AND @Status  IS NULL AND @StatusNot  IS NULL AND @GenderLkup  IS NULL AND @CTMNumber  IS NULL AND @CTMMember  IS NULL AND @MemberSCCCode  IS NULL AND @FirstName  IS NULL AND @LastName  IS NULL AND @ContractIDLkup  IS NULL AND @PBPLkup  IS NULL AND @FDRCodeReceived  IS NULL AND @DiscrepancyStartDateId  IS NULL AND @DiscrepancyEndDateId  IS NULL AND @DOBId  IS NULL AND @FirstLetterMailStartDateId  IS NULL AND @FirstLetterMailEndDateId  IS NULL AND @SecondLetterMailStartDateId  IS NULL AND @SecondLetterMailEndDateId  IS NULL AND @ComplianceStartDateId  IS NULL AND @ComplianceEndDateId  IS NULL AND @CaseCreationStartDateId  IS NULL AND @CaseCreationEndDateId  IS NULL AND @CaseLastUpdatedStartDateId  IS NULL AND @CaseLastUpdatedEndDateId  IS NULL AND @MemberResponseVerificationStartDateId  IS NULL AND @MemberResponseVerificationEndDateId IS NULL AND @RequestedEffectiveStartDateId  IS NULL AND @RequestedEffectiveEndDateId  IS NULL AND @AdjustedCreateStartDateId  IS NULL AND @AdjustedCreateEndDateId 	 IS NULL AND @RPCSubmissionStartDateId  IS NULL AND @RPCSubmissionEndDateId  IS NULL AND @CMSAccountManagerApprovalStartDateId  IS NULL AND @CMSAccountManagerApprovalEndDateId  IS NULL AND @FDRReceivedStartDateId  IS NULL AND @FDRReceivedEndDateId  IS NULL AND @PeerAuditCompletionStartDateId  IS NULL AND @PeerAuditCompletionEndDateId  IS NULL AND @TimeZoneLkup  IS NULL AND @UserLoginId  IS NULL AND @IsMassUpdate  IS NULL AND @IsRestricted = 0  AND @TransactionReplyCode  IS NULL AND @MemberVerifiedState IS NULL AND @MemberVerifiedCountryCode IS NULL AND @GPSHouseholdId IS NULL))
BEGIN
SET @IsBothCaseAndMedicareIdSelected = 1;
End

IF(@WorkItemId IS NOT NULL AND  @DiscrepancyCategoryLkup IS NOT NULL 
AND (@BusinessSegmentLkup IS NULL AND @WorkBasketLkup IS NULL AND @DiscrepancyTypeLkup  IS NULL AND @DiscrepancyTypeLkupNot  IS NULL AND @DiscrepancySourceLkup  IS NULL AND @LOBLkup  IS NULL AND @CaseAgeFrom  IS NULL AND @CaseAgeTo  IS NULL AND @LastUpdatedOperator  IS NULL AND @AssignedTo  IS NULL AND @ActionRequested  IS NULL AND @SupervisiorofthePersonEnteringtheRequest  IS NULL AND @EGHPMember IS NULL AND @EmployerId  IS NULL AND @FDRStatus  IS NULL AND @VerifiedRootCause  IS NULL AND @TaskBeingPerformedWhenThisDiscrepancyWasIdentified  IS NULL AND @SubmissionTypeLkup  IS NULL AND @PendReason  IS NULL AND @Resolution  IS NULL AND @RPRRequestor  IS NULL AND @Queue  IS NULL AND @Status  IS NULL AND @StatusNot  IS NULL AND @GenderLkup  IS NULL AND @CurrentHICN  IS NULL AND @CTMNumber  IS NULL AND @CTMMember  IS NULL AND @MemberSCCCode  IS NULL AND @FirstName  IS NULL AND @LastName  IS NULL AND @ContractIDLkup  IS NULL AND @PBPLkup  IS NULL AND @FDRCodeReceived  IS NULL AND @DiscrepancyStartDateId  IS NULL AND @DiscrepancyEndDateId  IS NULL AND @DOBId  IS NULL AND @FirstLetterMailStartDateId  IS NULL AND @FirstLetterMailEndDateId  IS NULL AND @SecondLetterMailStartDateId  IS NULL AND @SecondLetterMailEndDateId  IS NULL AND @ComplianceStartDateId  IS NULL AND @ComplianceEndDateId  IS NULL AND @CaseCreationStartDateId  IS NULL AND @CaseCreationEndDateId  IS NULL AND @CaseLastUpdatedStartDateId  IS NULL AND @CaseLastUpdatedEndDateId  IS NULL AND @MemberResponseVerificationStartDateId  IS NULL AND @MemberResponseVerificationEndDateId IS NULL AND @RequestedEffectiveStartDateId  IS NULL AND @RequestedEffectiveEndDateId  IS NULL AND @AdjustedCreateStartDateId  IS NULL AND @AdjustedCreateEndDateId 	 IS NULL AND @RPCSubmissionStartDateId  IS NULL AND @RPCSubmissionEndDateId  IS NULL AND @CMSAccountManagerApprovalStartDateId  IS NULL AND @CMSAccountManagerApprovalEndDateId  IS NULL AND @FDRReceivedStartDateId  IS NULL AND @FDRReceivedEndDateId  IS NULL AND @PeerAuditCompletionStartDateId  IS NULL AND @PeerAuditCompletionEndDateId  IS NULL AND @TimeZoneLkup  IS NULL AND @UserLoginId  IS NULL AND @IsMassUpdate  IS NULL AND @IsRestricted = 0 AND @TransactionReplyCode  IS NULL AND @MemberVerifiedState IS NULL AND @MemberVerifiedCountryCode IS NULL AND @GPSHouseholdId IS NULL))
BEGIN
SET @IsBothDiscCatAndCaseIdSelected = 1;
End

IF(@CurrentHICN IS NOT NULL AND  @DiscrepancyCategoryLkup IS NOT NULL 
AND (@WorkItemId IS NULL AND @BusinessSegmentLkup IS NULL AND @WorkBasketLkup IS NULL AND @DiscrepancyCategoryLkup IS NULL AND @DiscrepancyTypeLkup  IS NULL AND @DiscrepancyTypeLkupNot  IS NULL AND @DiscrepancySourceLkup  IS NULL AND @LOBLkup  IS NULL AND @CaseAgeFrom  IS NULL AND @CaseAgeTo  IS NULL AND @LastUpdatedOperator  IS NULL AND @AssignedTo  IS NULL AND @ActionRequested  IS NULL AND @SupervisiorofthePersonEnteringtheRequest  IS NULL AND @EGHPMember IS NULL AND @EmployerId  IS NULL AND @FDRStatus  IS NULL AND @VerifiedRootCause  IS NULL AND @TaskBeingPerformedWhenThisDiscrepancyWasIdentified  IS NULL AND @SubmissionTypeLkup  IS NULL AND @PendReason  IS NULL AND @Resolution  IS NULL AND @RPRRequestor  IS NULL AND @Queue  IS NULL AND @Status  IS NULL AND @StatusNot  IS NULL AND @GenderLkup  IS NULL  AND @CTMNumber  IS NULL AND @CTMMember  IS NULL AND @MemberSCCCode  IS NULL AND @FirstName  IS NULL AND @LastName  IS NULL AND @ContractIDLkup  IS NULL AND @PBPLkup  IS NULL AND @FDRCodeReceived  IS NULL AND @DiscrepancyStartDateId  IS NULL AND @DiscrepancyEndDateId  IS NULL AND @DOBId  IS NULL AND @FirstLetterMailStartDateId  IS NULL AND @FirstLetterMailEndDateId  IS NULL AND @SecondLetterMailStartDateId  IS NULL AND @SecondLetterMailEndDateId  IS NULL AND @ComplianceStartDateId  IS NULL AND @ComplianceEndDateId  IS NULL AND @CaseCreationStartDateId  IS NULL AND @CaseCreationEndDateId  IS NULL AND @CaseLastUpdatedStartDateId  IS NULL AND @CaseLastUpdatedEndDateId  IS NULL AND @MemberResponseVerificationStartDateId  IS NULL AND @MemberResponseVerificationEndDateId IS NULL AND @RequestedEffectiveStartDateId  IS NULL AND @RequestedEffectiveEndDateId  IS NULL AND @AdjustedCreateStartDateId  IS NULL AND @AdjustedCreateEndDateId 	 IS NULL AND @RPCSubmissionStartDateId  IS NULL AND @RPCSubmissionEndDateId  IS NULL AND @CMSAccountManagerApprovalStartDateId  IS NULL AND @CMSAccountManagerApprovalEndDateId  IS NULL AND @FDRReceivedStartDateId  IS NULL AND @FDRReceivedEndDateId  IS NULL AND @PeerAuditCompletionStartDateId  IS NULL AND @PeerAuditCompletionEndDateId  IS NULL AND @TimeZoneLkup  IS NULL AND @UserLoginId  IS NULL AND @IsMassUpdate  IS NULL AND @IsRestricted = 0 AND @TransactionReplyCode  IS NULL AND @MemberVerifiedState IS NULL AND @MemberVerifiedCountryCode IS NULL AND @GPSHouseholdId IS NULL))
BEGIN
SET @IsBothDiscCatAndMedicareIdSelected = 1;
End

IF(@CurrentHICN IS NOT NULL AND  @DiscrepancyCategoryLkup IS NOT NULL AND @WorkItemId IS NOT NULL 
AND (@BusinessSegmentLkup IS NULL AND @WorkBasketLkup IS NULL AND  @DiscrepancyTypeLkup  IS NULL AND @DiscrepancyTypeLkupNot  IS NULL AND @DiscrepancySourceLkup  IS NULL AND @LOBLkup  IS NULL AND @CaseAgeFrom  IS NULL AND @CaseAgeTo  IS NULL AND @LastUpdatedOperator  IS NULL AND @AssignedTo  IS NULL AND @ActionRequested  IS NULL AND @SupervisiorofthePersonEnteringtheRequest  IS NULL AND @EGHPMember IS NULL AND @EmployerId  IS NULL AND @FDRStatus  IS NULL AND @VerifiedRootCause  IS NULL AND @TaskBeingPerformedWhenThisDiscrepancyWasIdentified  IS NULL AND @SubmissionTypeLkup  IS NULL AND @PendReason  IS NULL AND @Resolution  IS NULL AND @RPRRequestor  IS NULL AND @Queue  IS NULL AND @Status  IS NULL AND @StatusNot  IS NULL AND @GenderLkup  IS NULL AND  @CTMNumber  IS NULL AND @CTMMember  IS NULL AND @MemberSCCCode  IS NULL AND @FirstName  IS NULL AND @LastName  IS NULL AND @ContractIDLkup  IS NULL AND @PBPLkup  IS NULL AND @FDRCodeReceived  IS NULL AND @DiscrepancyStartDateId  IS NULL AND @DiscrepancyEndDateId  IS NULL AND @DOBId  IS NULL AND @FirstLetterMailStartDateId  IS NULL AND @FirstLetterMailEndDateId  IS NULL AND @SecondLetterMailStartDateId  IS NULL AND @SecondLetterMailEndDateId  IS NULL AND @ComplianceStartDateId  IS NULL AND @ComplianceEndDateId  IS NULL AND @CaseCreationStartDateId  IS NULL AND @CaseCreationEndDateId  IS NULL AND @CaseLastUpdatedStartDateId  IS NULL AND @CaseLastUpdatedEndDateId  IS NULL AND @MemberResponseVerificationStartDateId  IS NULL AND @MemberResponseVerificationEndDateId IS NULL AND @RequestedEffectiveStartDateId  IS NULL AND @RequestedEffectiveEndDateId  IS NULL AND @AdjustedCreateStartDateId  IS NULL AND @AdjustedCreateEndDateId 	 IS NULL AND @RPCSubmissionStartDateId  IS NULL AND @RPCSubmissionEndDateId  IS NULL AND @CMSAccountManagerApprovalStartDateId  IS NULL AND @CMSAccountManagerApprovalEndDateId  IS NULL AND @FDRReceivedStartDateId  IS NULL AND @FDRReceivedEndDateId  IS NULL AND @PeerAuditCompletionStartDateId  IS NULL AND @PeerAuditCompletionEndDateId  IS NULL AND @TimeZoneLkup  IS NULL AND @UserLoginId  IS NULL AND @IsMassUpdate  IS NULL AND @IsRestricted = 0 AND @TransactionReplyCode  IS NULL AND @MemberVerifiedState IS NULL AND @MemberVerifiedCountryCode IS NULL AND @GPSHouseholdId IS NULL))
BEGIN
SET @IsDiscCatAndCaseIdAndMedicareIdSelected = 1;
End

IF(@DiscrepancyCategoryLkup IS NOT NULL AND  @ComplianceStartDateId IS NOT NULL AND @ComplianceEndDateId IS NOT NULL  
AND (@WorkItemId IS NULL AND @BusinessSegmentLkup IS NULL AND @WorkBasketLkup IS NULL AND @DiscrepancyTypeLkup  IS NULL AND @DiscrepancyTypeLkupNot  IS NULL AND @DiscrepancySourceLkup  IS NULL AND @LOBLkup  IS NULL AND @CaseAgeFrom  IS NULL AND @CaseAgeTo  IS NULL AND @LastUpdatedOperator  IS NULL AND @AssignedTo  IS NULL AND @ActionRequested  IS NULL AND @SupervisiorofthePersonEnteringtheRequest  IS NULL AND @EGHPMember IS NULL AND @EmployerId  IS NULL AND @FDRStatus  IS NULL AND @VerifiedRootCause  IS NULL AND @TaskBeingPerformedWhenThisDiscrepancyWasIdentified  IS NULL AND @SubmissionTypeLkup  IS NULL AND @PendReason  IS NULL AND @Resolution  IS NULL AND @RPRRequestor  IS NULL AND @Queue  IS NULL AND @Status  IS NULL AND @StatusNot  IS NULL AND @GenderLkup  IS NULL AND @CurrentHICN  IS NULL AND @CTMNumber  IS NULL AND @CTMMember  IS NULL AND @MemberSCCCode  IS NULL AND @FirstName  IS NULL AND @LastName  IS NULL AND @ContractIDLkup  IS NULL AND @PBPLkup  IS NULL AND @FDRCodeReceived  IS NULL AND @DiscrepancyStartDateId  IS NULL AND @DiscrepancyEndDateId  IS NULL AND @DOBId  IS NULL AND @FirstLetterMailStartDateId  IS NULL AND @FirstLetterMailEndDateId  IS NULL AND @SecondLetterMailStartDateId  IS NULL AND @SecondLetterMailEndDateId  IS NULL AND @CaseCreationStartDateId  IS NULL AND @CaseCreationEndDateId  IS NULL AND @CaseLastUpdatedStartDateId  IS NULL AND @CaseLastUpdatedEndDateId  IS NULL AND @MemberResponseVerificationStartDateId  IS NULL AND @MemberResponseVerificationEndDateId IS NULL AND @RequestedEffectiveStartDateId  IS NULL AND @RequestedEffectiveEndDateId  IS NULL AND @AdjustedCreateStartDateId  IS NULL AND @AdjustedCreateEndDateId 	 IS NULL AND @RPCSubmissionStartDateId  IS NULL AND @RPCSubmissionEndDateId  IS NULL AND @CMSAccountManagerApprovalStartDateId  IS NULL AND @CMSAccountManagerApprovalEndDateId  IS NULL AND @FDRReceivedStartDateId  IS NULL AND @FDRReceivedEndDateId  IS NULL AND @PeerAuditCompletionStartDateId  IS NULL AND @PeerAuditCompletionEndDateId  IS NULL AND @TimeZoneLkup  IS NULL AND @UserLoginId  IS NULL AND @IsMassUpdate  IS NULL AND @IsRestricted = 0 AND @TransactionReplyCode  IS NULL AND @MemberVerifiedState IS NULL AND @MemberVerifiedCountryCode IS NULL AND @GPSHouseholdId IS NULL))
BEGIN
SET @IsDiscCatOSTAndComplianceDateSelected = 1;
End

IF(@DiscrepancyCategoryLkup IS NOT NULL AND  @ComplianceStartDateId IS NOT NULL AND @ComplianceEndDateId IS NOT NULL AND @DiscrepancyTypeLkup IS NOT NULL  
AND (@WorkItemId IS NULL AND @BusinessSegmentLkup IS NULL AND @WorkBasketLkup IS NULL AND @DiscrepancyTypeLkupNot  IS NULL AND @DiscrepancySourceLkup  IS NULL AND @LOBLkup  IS NULL AND @CaseAgeFrom  IS NULL AND @CaseAgeTo  IS NULL AND @LastUpdatedOperator  IS NULL AND @AssignedTo  IS NULL AND @ActionRequested  IS NULL AND @SupervisiorofthePersonEnteringtheRequest  IS NULL AND @EGHPMember IS NULL AND @EmployerId  IS NULL AND @FDRStatus  IS NULL AND @VerifiedRootCause  IS NULL AND @TaskBeingPerformedWhenThisDiscrepancyWasIdentified  IS NULL AND @SubmissionTypeLkup  IS NULL AND @PendReason  IS NULL AND @Resolution  IS NULL AND @RPRRequestor  IS NULL AND @Queue  IS NULL AND @Status  IS NULL AND @StatusNot  IS NULL AND @GenderLkup  IS NULL AND @CurrentHICN  IS NULL AND @CTMNumber  IS NULL AND @CTMMember  IS NULL AND @MemberSCCCode  IS NULL AND @FirstName  IS NULL AND @LastName  IS NULL AND @ContractIDLkup  IS NULL AND @PBPLkup  IS NULL AND @FDRCodeReceived  IS NULL AND @DiscrepancyStartDateId  IS NULL AND @DiscrepancyEndDateId  IS NULL AND @DOBId  IS NULL AND @FirstLetterMailStartDateId  IS NULL AND @FirstLetterMailEndDateId  IS NULL AND @SecondLetterMailStartDateId  IS NULL AND @SecondLetterMailEndDateId  IS NULL AND @CaseCreationStartDateId  IS NULL AND @CaseCreationEndDateId  IS NULL AND @CaseLastUpdatedStartDateId  IS NULL AND @CaseLastUpdatedEndDateId  IS NULL AND @MemberResponseVerificationStartDateId  IS NULL AND @MemberResponseVerificationEndDateId IS NULL AND @RequestedEffectiveStartDateId  IS NULL AND @RequestedEffectiveEndDateId  IS NULL AND @AdjustedCreateStartDateId  IS NULL AND @AdjustedCreateEndDateId 	 IS NULL AND @RPCSubmissionStartDateId  IS NULL AND @RPCSubmissionEndDateId  IS NULL AND @CMSAccountManagerApprovalStartDateId  IS NULL AND @CMSAccountManagerApprovalEndDateId  IS NULL AND @FDRReceivedStartDateId  IS NULL AND @FDRReceivedEndDateId  IS NULL AND @PeerAuditCompletionStartDateId  IS NULL AND @PeerAuditCompletionEndDateId  IS NULL AND @TimeZoneLkup  IS NULL AND @UserLoginId  IS NULL AND @IsMassUpdate  IS NULL AND @IsRestricted = 0 AND @TransactionReplyCode  IS NULL AND @MemberVerifiedState IS NULL AND @MemberVerifiedCountryCode IS NULL AND @GPSHouseholdId IS NULL))
BEGIN
SET @IsDiscCatOSTAndDiscTypeAndComplianceDateSelected = 1;
End

IF(@DiscrepancyCategoryLkup IS NOT NULL AND  @CaseCreationStartDateId  IS NOT NULL AND @CaseCreationEndDateId  IS NOT NULL  
AND (@WorkItemId IS NULL AND @BusinessSegmentLkup IS NULL AND @WorkBasketLkup IS NULL AND @DiscrepancyTypeLkup  IS NULL AND @DiscrepancyTypeLkupNot  IS NULL AND @DiscrepancySourceLkup  IS NULL AND @LOBLkup  IS NULL AND @CaseAgeFrom  IS NULL AND @CaseAgeTo  IS NULL AND @LastUpdatedOperator  IS NULL AND @AssignedTo  IS NULL AND @ActionRequested  IS NULL AND @SupervisiorofthePersonEnteringtheRequest  IS NULL AND @EGHPMember IS NULL AND @EmployerId  IS NULL AND @FDRStatus  IS NULL AND @VerifiedRootCause  IS NULL AND @TaskBeingPerformedWhenThisDiscrepancyWasIdentified  IS NULL AND @SubmissionTypeLkup  IS NULL AND @PendReason  IS NULL AND @Resolution  IS NULL AND @RPRRequestor  IS NULL AND @Queue  IS NULL AND @Status  IS NULL AND @StatusNot  IS NULL AND @GenderLkup  IS NULL AND @CurrentHICN  IS NULL AND @CTMNumber  IS NULL AND @CTMMember  IS NULL AND @MemberSCCCode  IS NULL AND @FirstName  IS NULL AND @LastName  IS NULL AND @ContractIDLkup  IS NULL AND @PBPLkup  IS NULL AND @FDRCodeReceived  IS NULL AND @DiscrepancyStartDateId  IS NULL AND @DiscrepancyEndDateId  IS NULL AND @DOBId  IS NULL AND @FirstLetterMailStartDateId  IS NULL AND @FirstLetterMailEndDateId  IS NULL AND @SecondLetterMailStartDateId  IS NULL AND @SecondLetterMailEndDateId  IS NULL AND @ComplianceStartDateId  IS NULL AND @ComplianceEndDateId  IS NULL AND @CaseLastUpdatedStartDateId  IS NULL AND @CaseLastUpdatedEndDateId  IS NULL AND @MemberResponseVerificationStartDateId  IS NULL AND @MemberResponseVerificationEndDateId IS NULL AND @RequestedEffectiveStartDateId  IS NULL AND @RequestedEffectiveEndDateId  IS NULL AND @AdjustedCreateStartDateId  IS NULL AND @AdjustedCreateEndDateId 	 IS NULL AND @RPCSubmissionStartDateId  IS NULL AND @RPCSubmissionEndDateId  IS NULL AND @CMSAccountManagerApprovalStartDateId  IS NULL AND @CMSAccountManagerApprovalEndDateId  IS NULL AND @FDRReceivedStartDateId  IS NULL AND @FDRReceivedEndDateId  IS NULL AND @PeerAuditCompletionStartDateId  IS NULL AND @PeerAuditCompletionEndDateId  IS NULL AND @TimeZoneLkup  IS NULL AND @UserLoginId  IS NULL AND @IsMassUpdate  IS NULL AND @IsRestricted = 0 AND @TransactionReplyCode  IS NULL AND @MemberVerifiedState IS NULL AND @MemberVerifiedCountryCode IS NULL AND @GPSHouseholdId IS NULL))
BEGIN
SET @IsDiscCatEligibilityAndCreatedDateSelected = 1;
SET @IsDiscCatRPRAndCreatedDateSelected = 1;
End

IF(@DiscrepancyCategoryLkup IS NOT NULL AND  @CaseCreationStartDateId IS NOT NULL AND @CaseCreationEndDateId IS NOT NULL AND @DiscrepancyTypeLkup IS NOT NULL  
AND (@WorkItemId IS NULL AND @BusinessSegmentLkup IS NULL AND @WorkBasketLkup IS NULL AND @DiscrepancyTypeLkupNot  IS NULL AND @DiscrepancySourceLkup  IS NULL AND @LOBLkup  IS NULL AND @CaseAgeFrom  IS NULL AND @CaseAgeTo  IS NULL AND @LastUpdatedOperator  IS NULL AND @AssignedTo  IS NULL AND @ActionRequested  IS NULL AND @SupervisiorofthePersonEnteringtheRequest  IS NULL AND @EGHPMember IS NULL AND @EmployerId  IS NULL AND @FDRStatus  IS NULL AND @VerifiedRootCause  IS NULL AND @TaskBeingPerformedWhenThisDiscrepancyWasIdentified  IS NULL AND @SubmissionTypeLkup  IS NULL AND @PendReason  IS NULL AND @Resolution  IS NULL AND @RPRRequestor  IS NULL AND @Queue  IS NULL AND @Status  IS NULL AND @StatusNot  IS NULL AND @GenderLkup  IS NULL AND @CurrentHICN  IS NULL AND @CTMNumber  IS NULL AND @CTMMember  IS NULL AND @MemberSCCCode  IS NULL AND @FirstName  IS NULL AND @LastName  IS NULL AND @ContractIDLkup  IS NULL AND @PBPLkup  IS NULL AND @FDRCodeReceived  IS NULL AND @DiscrepancyStartDateId  IS NULL AND @DiscrepancyEndDateId  IS NULL AND @DOBId  IS NULL AND @FirstLetterMailStartDateId  IS NULL AND @FirstLetterMailEndDateId  IS NULL AND @SecondLetterMailStartDateId  IS NULL AND @SecondLetterMailEndDateId  IS NULL AND @ComplianceStartDateId  IS NULL AND @ComplianceEndDateId  IS NULL AND @CaseLastUpdatedStartDateId  IS NULL AND @CaseLastUpdatedEndDateId  IS NULL AND @MemberResponseVerificationStartDateId  IS NULL AND @MemberResponseVerificationEndDateId IS NULL AND @RequestedEffectiveStartDateId  IS NULL AND @RequestedEffectiveEndDateId  IS NULL AND @AdjustedCreateStartDateId  IS NULL AND @AdjustedCreateEndDateId 	 IS NULL AND @RPCSubmissionStartDateId  IS NULL AND @RPCSubmissionEndDateId  IS NULL AND @CMSAccountManagerApprovalStartDateId  IS NULL AND @CMSAccountManagerApprovalEndDateId  IS NULL AND @FDRReceivedStartDateId  IS NULL AND @FDRReceivedEndDateId  IS NULL AND @PeerAuditCompletionStartDateId  IS NULL AND @PeerAuditCompletionEndDateId  IS NULL AND @TimeZoneLkup  IS NULL AND @UserLoginId  IS NULL AND @IsMassUpdate  IS NULL AND @IsRestricted = 0 AND @TransactionReplyCode  IS NULL AND @MemberVerifiedState IS NULL AND @MemberVerifiedCountryCode IS NULL AND @GPSHouseholdId IS NULL))
BEGIN
SET @IsDiscCatEligibilityAndDiscTypeAndCreatedDateSelected = 1;
SET @IsDiscCatRPRAndDiscTypeAndCreatedDateSelected = 1;
End


IF @PageType IS NOT NULL AND @PageType=3001--OST
BEGIN
IF(@IsERSIdSelected = 1)
Begin
Select DISTINCT TOP (@TopCount)
	GEN_QueueId as WorkItemID,
	[dbo].[GetAge](GQ.[GEN_QueueId]) AS Aging,
	GQ.MemberSCCCode as MemberSCCCode,
	GQ.MemberID as MemberID,
	GQ.MemberMedicareId as MemberCurrentHICN,
	GQ.GPSHouseholdID as GPSHouseholdID,
	GQ.MemberFirstName as MemberFirstName,
	GQ.MemberMiddleName as MemberMiddleName,
	GQ.MemberLastName as MemberLastName,
	LMContractId.LookupValue as MemberContractID,
	GQ.MemberDOB as MemberDOB,
	LMPBPId.LookupValue as MemberPBP,
	LMLOBId.LookupValue as MemberLOB,
	NULL as MemberGender,
	LMDiscType.LookupValue as DiscrepancyType,
	GQ.MostRecentStatusLkup,
	LMStatus.LookupValue as MostRecentStatus,
	GQ.MostRecentWorkQueueLkup,
	LMQueue.LookupValue as MostRecentQueue,
	LMQueueType.GroupingLookupMasterRef as QueueProgressTypeLkup,
	LMQueueProgType.LookupValue as QueueProgressType,
	LMAction.LookupValue as MostRecentAction,
	GQ.MemberMedicareId as CurrentHICN,
	GQ.EligGPSCurrentHICN as GPSHICN,
	GQ.EligMMRCurrentHICN as MMRHICN,
	LMWorkBasket.LookupValue as BusinessSegment,
	GQ.BusinessSegmentLkup, 
	LMDiscrepancy.LookupValue as DiscrepancyCategory,
	GQ.DiscrepancyCategoryLkup, 
	GQ.DiscrepancyStartDate as DiscrepancyStartDate,
	GQ.DiscrepancyEndDate as DiscrepancyEndDate,
	GOST.Reason as Reason,
	LMResolution.LookupValue as Resolution,
	GQ.ReferencedEligibilityCaseInd as ReferencedEligibilityCaseIndicator,
	NULL as MMRPBP,
	NULL as GPSIndividualID,
	LMDiscSource.LookupValue as DiscrepancySource,
	NULL as SubmissionType,
	NULL as CTMMember,
	NULL as EGHPMember,
	NULL as RequestedEffectiveDate,
	NULL as ActionRequested,
	NULL as PotentialSubmissionDate,
	NULL as RPCSubmissionDate,
	NULL as FDRReceivedDate,
	NULL as FDRCodeReceived,
	NULL as FDRStatus,
	NULL as RPRRequestor,
	GQ.ComplianceStartDate as ComplianceStartDate,
	GOST.AdjustedComplianceStartDate as AdjustedComplianceStartDate,
	GQ.UTCCreatedOn,
	GQ.CreatedByRef,
	UMC.FullName as CreatedBy,
	GQ.UTCLastUpdatedOn,
	GQ.LastUpdatedByRef,
	UML.FullName as LastUpdatedBy,
	GQ.LockedByRef,
	GQ.UTCLockedOn,
	UMLock.FullName as LockedBy,
	GQ.AssignedToRef,
	GQ.UTCAssignedOn,
	UMAssign.FullName as AssignedTo,
	GQ.PendedbyRef,
	GQ.UTCPendedOn,
	UMPended.FullName as PendedBy,
	GQ.OOALetterStatusLkup,
	LMOOALetterStatus.LookupValue as OOALetterStatus,
	GQ.CMSTransactionStatusLkup,
	LMCTranStatus.LookupValue as CMSTransactionStatus,
    GQ.MemberVerifiedState,GQ.MemberVerifiedCountyCode
	From GEN_Queue GQ with(nolock)
	LEFT JOIN GEN_OSTActions GOST with(nolock) ON GQ.GEN_QueueId=GOST.GEN_QueueRef
	LEFT JOIN CMN_LookupMaster LMWorkBasket with(nolock) ON GQ.BusinessSegmentLkup=LMWorkBasket.CMN_LookupMasterId And LMWorkBasket.CMN_LookupTypeRef = 1
	LEFT JOIN CMN_LookupMaster LMDiscrepancy with(nolock) ON GQ.DiscrepancyCategoryLkup=LMDiscrepancy.CMN_LookupMasterId And LMDiscrepancy.CMN_LookupTypeRef = 6
	LEFT JOIN CMN_LookupMaster LMDiscType with(nolock) ON GQ.DiscrepancyTypeLkup=LMDiscType.CMN_LookupMasterId And 	LMDiscType.CMN_LookupTypeRef = 7
	LEFT JOIN CMN_LookupMaster LMDiscSource with(nolock) ON GQ.DiscrepancySourceLkup=LMDiscSource.CMN_LookupMasterId And LMDiscSource.CMN_LookupTypeRef =13	
	LEFT JOIN CMN_LookupMaster LMStatus with(nolock) ON GQ.MostRecentStatusLkup=LMStatus.CMN_LookupMasterId And LMStatus.CMN_LookupTypeRef = 20
	LEFT JOIN CMN_LookupMaster LMQueue with(nolock) ON GQ.MostRecentWorkQueueLkup=LMQueue.CMN_LookupMasterId And LMQueue.CMN_LookupTypeRef = 10
	LEFT JOIN CMN_LookupMaster LMAction with(nolock) ON GQ.MostRecentActionLkup=LMAction.CMN_LookupMasterId  And LMAction.CMN_LookupTypeRef = 28
	LEFT JOIN CMN_LookupMasterCorrelations LMQueueType with(nolock) ON GQ.MostRecentWorkQueueLkup=LMQueueType.CMN_LookupMasterChildRef AND LMQueueType.CMN_LookupTypeCorrelationsRef=3
	LEFT JOIN CMN_LookupMaster LMQueueProgType with(nolock) ON LMQueueType.GroupingLookupMasterRef=LMQueueProgType.CMN_LookupMasterId AND LMQueueProgType.CMN_LookupTypeRef = 9
	LEFT JOIN CMN_LookupMaster LMContractId with(nolock) ON GQ.MemberContractIDLkup=LMContractId.CMN_LookupMasterId And LMContractId.CMN_LookupTypeRef = 11
	LEFT JOIN CMN_LookupMaster LMPBPId with(nolock) ON GQ.MemberPBPLkup=LMPBPId.CMN_LookupMasterId And LMPBPId.CMN_LookupTypeRef = 12
	LEFT JOIN CMN_LookupMaster LMLOBId with(nolock) ON GQ.MemberLOBLkup=LMLOBId.CMN_LookupMasterId And LMLOBId.CMN_LookupTypeRef = 31
	LEFT JOIN CMN_LookupMaster LMResolution with(nolock) ON GOST.ResolutionLkup=LMResolution.CMN_LookupMasterId And LMResolution.CMN_LookupTypeRef = 18
	LEFT JOIN CMN_LookupMaster LMOOALetterStatus with(nolock) ON GQ.OOALetterStatusLkup=LMOOALetterStatus.CMN_LookupMasterId And LMOOALetterStatus.CMN_LookupTypeRef = 53
	LEFT JOIN CMN_LookupMaster LMCTranStatus with(nolock) ON GQ.CMSTransactionStatusLkup=LMCTranStatus.CMN_LookupMasterId And LMCTranStatus.CMN_LookupTypeRef = 55
	INNER JOIN ADM_UserMaster UMC with(nolock) ON GQ.CreatedByRef=UMC.ADM_UserMasterId
	INNER JOIN ADM_UserMaster UML with(nolock) ON GQ.LastUpdatedByRef=UML.ADM_UserMasterId
	LEFT JOIN ADM_UserMaster UMLock with(nolock) ON GQ.LockedByRef=UMLock.ADM_UserMasterId
	LEFT JOIN ADM_UserMaster UMAssign with(nolock) ON GQ.AssignedToRef=UMAssign.ADM_UserMasterId
	LEFT JOIN ADM_UserMaster UMPended with(nolock) ON GQ.PendedbyRef=UMPended.ADM_UserMasterId
	LEFT JOIN CMN_RecordsLocked RL with(nolock) ON RL.CaseId=GQ.GEN_QueueId AND RL.ScreenLkup = 37010 AND RL.IsActive=1
	Where
	GQ.GEN_QueueId=@WorkItemId
	AND GQ.IsActive=1	
	AND (@IsUnlock IS NULL OR @IsUnlock = 0 OR (@IsUnlock = 1 AND GQ.LockedByRef is not null AND GQ.UTCLockedOn < DATEADD(hh,-1,GETUTCDATE())))	
	AND (@IsReAssign IS NULL OR @IsReAssign = 0 OR (@IsReAssign = 1 AND GQ.LockedByRef is null AND ((GQ.AssignedToRef IS NOT NULL AND GQ.MostRecentWorkQueueLkup = 10074) OR (GQ.PendedbyRef IS NOT NULL AND GQ.MostRecentWorkQueueLkup = 10081))))
	AND (@IsRestricted = 1 OR (@IsRestricted = 0 AND (GQ.IsRestricted = 0 OR GQ.IsRestricted IS NULL)))
	SELECT DISTINCT COUNT(*) AS TotalRecords
      ,COUNT(CASE WHEN (IsRestricted=1)  THEN 1 END) AS RestrictedRecords
	  ,COUNT(CASE WHEN (IsRestricted=0 OR IsRestricted IS NULL)  THEN 1 END) AS UnRestrictedRecords
	From GEN_Queue GQ with(nolock)
	LEFT JOIN GEN_OSTActions GOST with(nolock) ON GQ.GEN_QueueId=GOST.GEN_QueueRef
	LEFT JOIN CMN_RecordsLocked RL with(nolock) ON RL.CaseId=GQ.GEN_QueueId AND RL.ScreenLkup = 37010 AND RL.IsActive=1
	Where
	GQ.GEN_QueueId=@WorkItemId
	AND GQ.IsActive=1		
	AND (@IsUnlock IS NULL OR @IsUnlock = 0 OR (@IsUnlock = 1 AND GQ.LockedByRef is not null AND GQ.UTCLockedOn < DATEADD(hh,-1,GETUTCDATE())))	
	AND (@IsReAssign IS NULL OR @IsReAssign = 0 OR (@IsReAssign = 1 AND GQ.LockedByRef is null AND ((GQ.AssignedToRef IS NOT NULL AND GQ.MostRecentWorkQueueLkup = 10074) OR (GQ.PendedbyRef IS NOT NULL AND GQ.MostRecentWorkQueueLkup = 10081))))
	
End
ELSE IF(@IsMedicareIdSelected =1)
Begin
Select DISTINCT TOP (@TopCount)
	GEN_QueueId as WorkItemID,
	[dbo].[GetAge](GQ.[GEN_QueueId]) AS Aging,
	GQ.MemberSCCCode as MemberSCCCode,
	GQ.MemberID as MemberID,
	GQ.MemberMedicareId as MemberCurrentHICN,
	GQ.GPSHouseholdID as GPSHouseholdID,
	GQ.MemberFirstName as MemberFirstName,
	GQ.MemberMiddleName as MemberMiddleName,
	GQ.MemberLastName as MemberLastName,
	LMContractId.LookupValue as MemberContractID,
	GQ.MemberDOB as MemberDOB,
	LMPBPId.LookupValue as MemberPBP,
	LMLOBId.LookupValue as MemberLOB,
	NULL as MemberGender,
	LMDiscType.LookupValue as DiscrepancyType,
	GQ.MostRecentStatusLkup,
	LMStatus.LookupValue as MostRecentStatus,
	GQ.MostRecentWorkQueueLkup,
	LMQueue.LookupValue as MostRecentQueue,
	LMQueueType.GroupingLookupMasterRef as QueueProgressTypeLkup,
	LMQueueProgType.LookupValue as QueueProgressType,
	LMAction.LookupValue as MostRecentAction,
	GQ.MemberMedicareId as CurrentHICN,
	GQ.EligGPSCurrentHICN as GPSHICN,
	GQ.EligMMRCurrentHICN as MMRHICN,
	LMWorkBasket.LookupValue as BusinessSegment,
	GQ.BusinessSegmentLkup, 
	LMDiscrepancy.LookupValue as DiscrepancyCategory,
	GQ.DiscrepancyCategoryLkup, 
	GQ.DiscrepancyStartDate as DiscrepancyStartDate,
	GQ.DiscrepancyEndDate as DiscrepancyEndDate,
	GOST.Reason as Reason,
	LMResolution.LookupValue as Resolution,
	GQ.ReferencedEligibilityCaseInd as ReferencedEligibilityCaseIndicator,
	NULL as MMRPBP,
	NULL as GPSIndividualID,
	LMDiscSource.LookupValue as DiscrepancySource,
	NULL as SubmissionType,
	NULL as CTMMember,
	NULL as EGHPMember,
	NULL as RequestedEffectiveDate,
	NULL as ActionRequested,
	NULL as PotentialSubmissionDate,
	NULL as RPCSubmissionDate,
	NULL as FDRReceivedDate,
	NULL as FDRCodeReceived,
	NULL as FDRStatus,
	NULL as RPRRequestor,
	GQ.ComplianceStartDate as ComplianceStartDate,
	GOST.AdjustedComplianceStartDate as AdjustedComplianceStartDate,
	GQ.UTCCreatedOn,
	GQ.CreatedByRef,
	UMC.FullName as CreatedBy,
	GQ.UTCLastUpdatedOn,
	GQ.LastUpdatedByRef,
	UML.FullName as LastUpdatedBy,
	GQ.LockedByRef,
	GQ.UTCLockedOn,
	UMLock.FullName as LockedBy,
	GQ.AssignedToRef,
	GQ.UTCAssignedOn,
	UMAssign.FullName as AssignedTo,
	GQ.PendedbyRef,
	GQ.UTCPendedOn,
	UMPended.FullName as PendedBy,
	GQ.OOALetterStatusLkup,
	LMOOALetterStatus.LookupValue as OOALetterStatus,
	GQ.CMSTransactionStatusLkup,
	LMCTranStatus.LookupValue as CMSTransactionStatus,
    GQ.MemberVerifiedState,GQ.MemberVerifiedCountyCode
	From GEN_Queue GQ with(nolock)
	LEFT JOIN GEN_OSTActions GOST with(nolock) ON GQ.GEN_QueueId=GOST.GEN_QueueRef
	LEFT JOIN CMN_LookupMaster LMWorkBasket with(nolock) ON GQ.BusinessSegmentLkup=LMWorkBasket.CMN_LookupMasterId And LMWorkBasket.CMN_LookupTypeRef = 1
	LEFT JOIN CMN_LookupMaster LMDiscrepancy with(nolock) ON GQ.DiscrepancyCategoryLkup=LMDiscrepancy.CMN_LookupMasterId And LMDiscrepancy.CMN_LookupTypeRef = 6
	LEFT JOIN CMN_LookupMaster LMDiscType with(nolock) ON GQ.DiscrepancyTypeLkup=LMDiscType.CMN_LookupMasterId And 	LMDiscType.CMN_LookupTypeRef = 7
	LEFT JOIN CMN_LookupMaster LMDiscSource with(nolock) ON GQ.DiscrepancySourceLkup=LMDiscSource.CMN_LookupMasterId And LMDiscSource.CMN_LookupTypeRef =13	
	LEFT JOIN CMN_LookupMaster LMStatus with(nolock) ON GQ.MostRecentStatusLkup=LMStatus.CMN_LookupMasterId And LMStatus.CMN_LookupTypeRef = 20
	LEFT JOIN CMN_LookupMaster LMQueue with(nolock) ON GQ.MostRecentWorkQueueLkup=LMQueue.CMN_LookupMasterId And LMQueue.CMN_LookupTypeRef = 10
	LEFT JOIN CMN_LookupMaster LMAction with(nolock) ON GQ.MostRecentActionLkup=LMAction.CMN_LookupMasterId  And LMAction.CMN_LookupTypeRef = 28
	LEFT JOIN CMN_LookupMasterCorrelations LMQueueType with(nolock) ON GQ.MostRecentWorkQueueLkup=LMQueueType.CMN_LookupMasterChildRef AND LMQueueType.CMN_LookupTypeCorrelationsRef=3
	LEFT JOIN CMN_LookupMaster LMQueueProgType with(nolock) ON LMQueueType.GroupingLookupMasterRef=LMQueueProgType.CMN_LookupMasterId AND LMQueueProgType.CMN_LookupTypeRef = 9
	LEFT JOIN CMN_LookupMaster LMContractId with(nolock) ON GQ.MemberContractIDLkup=LMContractId.CMN_LookupMasterId And LMContractId.CMN_LookupTypeRef = 11
	LEFT JOIN CMN_LookupMaster LMPBPId with(nolock) ON GQ.MemberPBPLkup=LMPBPId.CMN_LookupMasterId And LMPBPId.CMN_LookupTypeRef = 12
	LEFT JOIN CMN_LookupMaster LMLOBId with(nolock) ON GQ.MemberLOBLkup=LMLOBId.CMN_LookupMasterId And LMLOBId.CMN_LookupTypeRef = 31
	LEFT JOIN CMN_LookupMaster LMResolution with(nolock) ON GOST.ResolutionLkup=LMResolution.CMN_LookupMasterId And LMResolution.CMN_LookupTypeRef = 18
	LEFT JOIN CMN_LookupMaster LMOOALetterStatus with(nolock) ON GQ.OOALetterStatusLkup=LMOOALetterStatus.CMN_LookupMasterId And LMOOALetterStatus.CMN_LookupTypeRef = 53
	LEFT JOIN CMN_LookupMaster LMCTranStatus with(nolock) ON GQ.CMSTransactionStatusLkup=LMCTranStatus.CMN_LookupMasterId And LMCTranStatus.CMN_LookupTypeRef = 55
	INNER JOIN ADM_UserMaster UMC with(nolock) ON GQ.CreatedByRef=UMC.ADM_UserMasterId
	INNER JOIN ADM_UserMaster UML with(nolock) ON GQ.LastUpdatedByRef=UML.ADM_UserMasterId
	LEFT JOIN ADM_UserMaster UMLock with(nolock) ON GQ.LockedByRef=UMLock.ADM_UserMasterId
	LEFT JOIN ADM_UserMaster UMAssign with(nolock) ON GQ.AssignedToRef=UMAssign.ADM_UserMasterId
	LEFT JOIN ADM_UserMaster UMPended with(nolock) ON GQ.PendedbyRef=UMPended.ADM_UserMasterId
	LEFT JOIN CMN_RecordsLocked RL with(nolock) ON RL.CaseId=GQ.GEN_QueueId AND RL.ScreenLkup = 37010 AND RL.IsActive=1
	Where
	(GQ.MemberCurrentHICN = @CurrentHICN OR GQ.EligGPSCurrentHICN = @CurrentHICN OR GQ.EligMMRCurrentHICN = @CurrentHICN OR GQ.[MemberMedicareId] = @CurrentHICN)
	AND GQ.IsActive=1
	AND (@IsUnlock IS NULL OR @IsUnlock = 0 OR (@IsUnlock = 1 AND GQ.LockedByRef is not null AND GQ.UTCLockedOn < DATEADD(hh,-1,GETUTCDATE())))	
	AND (@IsReAssign IS NULL OR @IsReAssign = 0 OR (@IsReAssign = 1 AND GQ.LockedByRef is null AND ((GQ.AssignedToRef IS NOT NULL AND GQ.MostRecentWorkQueueLkup = 10074) OR (GQ.PendedbyRef IS NOT NULL AND GQ.MostRecentWorkQueueLkup = 10081))))
	AND (@IsRestricted = 1 OR (@IsRestricted = 0 AND (GQ.IsRestricted = 0 OR GQ.IsRestricted IS NULL)))

	SELECT DISTINCT COUNT(*) AS TotalRecords
      ,COUNT(CASE WHEN (IsRestricted=1)  THEN 1 END) AS RestrictedRecords
	  ,COUNT(CASE WHEN (IsRestricted=0 OR IsRestricted IS NULL)  THEN 1 END) AS UnRestrictedRecords
	From GEN_Queue GQ with(nolock)
	LEFT JOIN GEN_OSTActions GOST with(nolock) ON GQ.GEN_QueueId=GOST.GEN_QueueRef
	LEFT JOIN CMN_RecordsLocked RL with(nolock) ON RL.CaseId=GQ.GEN_QueueId AND RL.ScreenLkup = 37010 AND RL.IsActive=1
	Where
	(GQ.MemberCurrentHICN = @CurrentHICN OR GQ.EligGPSCurrentHICN = @CurrentHICN OR GQ.EligMMRCurrentHICN = @CurrentHICN OR GQ.[MemberMedicareId] = @CurrentHICN)
	AND GQ.IsActive=1
	AND (@IsUnlock IS NULL OR @IsUnlock = 0 OR (@IsUnlock = 1 AND GQ.LockedByRef is not null AND GQ.UTCLockedOn < DATEADD(hh,-1,GETUTCDATE())))	
	AND (@IsReAssign IS NULL OR @IsReAssign = 0 OR (@IsReAssign = 1 AND GQ.LockedByRef is null AND ((GQ.AssignedToRef IS NOT NULL AND GQ.MostRecentWorkQueueLkup = 10074) OR (GQ.PendedbyRef IS NOT NULL AND GQ.MostRecentWorkQueueLkup = 10081))))	
End
ELSE IF(@IsBothCaseAndMedicareIdSelected = 1)
Begin
Select DISTINCT TOP (@TopCount)
	GEN_QueueId as WorkItemID,
	[dbo].[GetAge](GQ.[GEN_QueueId]) AS Aging,
	GQ.MemberSCCCode as MemberSCCCode,
	GQ.MemberID as MemberID,
	GQ.MemberMedicareId as MemberCurrentHICN,
	GQ.GPSHouseholdID as GPSHouseholdID,
	GQ.MemberFirstName as MemberFirstName,
	GQ.MemberMiddleName as MemberMiddleName,
	GQ.MemberLastName as MemberLastName,
	LMContractId.LookupValue as MemberContractID,
	GQ.MemberDOB as MemberDOB,
	LMPBPId.LookupValue as MemberPBP,
	LMLOBId.LookupValue as MemberLOB,
	NULL as MemberGender,
	LMDiscType.LookupValue as DiscrepancyType,
	GQ.MostRecentStatusLkup,
	LMStatus.LookupValue as MostRecentStatus,
	GQ.MostRecentWorkQueueLkup,
	LMQueue.LookupValue as MostRecentQueue,
	LMQueueType.GroupingLookupMasterRef as QueueProgressTypeLkup,
	LMQueueProgType.LookupValue as QueueProgressType,
	LMAction.LookupValue as MostRecentAction,
	GQ.MemberMedicareId as CurrentHICN,
	GQ.EligGPSCurrentHICN as GPSHICN,
	GQ.EligMMRCurrentHICN as MMRHICN,
	LMWorkBasket.LookupValue as BusinessSegment,
	GQ.BusinessSegmentLkup, 
	LMDiscrepancy.LookupValue as DiscrepancyCategory,
	GQ.DiscrepancyCategoryLkup, 
	GQ.DiscrepancyStartDate as DiscrepancyStartDate,
	GQ.DiscrepancyEndDate as DiscrepancyEndDate,
	GOST.Reason as Reason,
	LMResolution.LookupValue as Resolution,
	GQ.ReferencedEligibilityCaseInd as ReferencedEligibilityCaseIndicator,
	NULL as MMRPBP,
	NULL as GPSIndividualID,
	LMDiscSource.LookupValue as DiscrepancySource,
	NULL as SubmissionType,
	NULL as CTMMember,
	NULL as EGHPMember,
	NULL as RequestedEffectiveDate,
	NULL as ActionRequested,
	NULL as PotentialSubmissionDate,
	NULL as RPCSubmissionDate,
	NULL as FDRReceivedDate,
	NULL as FDRCodeReceived,
	NULL as FDRStatus,
	NULL as RPRRequestor,
	GQ.ComplianceStartDate as ComplianceStartDate,
	GOST.AdjustedComplianceStartDate as AdjustedComplianceStartDate,
	GQ.UTCCreatedOn,
	GQ.CreatedByRef,
	UMC.FullName as CreatedBy,
	GQ.UTCLastUpdatedOn,
	GQ.LastUpdatedByRef,
	UML.FullName as LastUpdatedBy,
	GQ.LockedByRef,
	GQ.UTCLockedOn,
	UMLock.FullName as LockedBy,
	GQ.AssignedToRef,
	GQ.UTCAssignedOn,
	UMAssign.FullName as AssignedTo,
	GQ.PendedbyRef,
	GQ.UTCPendedOn,
	UMPended.FullName as PendedBy,
	GQ.OOALetterStatusLkup,
	LMOOALetterStatus.LookupValue as OOALetterStatus,
	GQ.CMSTransactionStatusLkup,
	LMCTranStatus.LookupValue as CMSTransactionStatus,
    GQ.MemberVerifiedState,GQ.MemberVerifiedCountyCode
	From GEN_Queue GQ with(nolock)
	LEFT JOIN GEN_OSTActions GOST with(nolock) ON GQ.GEN_QueueId=GOST.GEN_QueueRef
	LEFT JOIN CMN_LookupMaster LMWorkBasket with(nolock) ON GQ.BusinessSegmentLkup=LMWorkBasket.CMN_LookupMasterId And LMWorkBasket.CMN_LookupTypeRef = 1
	LEFT JOIN CMN_LookupMaster LMDiscrepancy with(nolock) ON GQ.DiscrepancyCategoryLkup=LMDiscrepancy.CMN_LookupMasterId And LMDiscrepancy.CMN_LookupTypeRef = 6
	LEFT JOIN CMN_LookupMaster LMDiscType with(nolock) ON GQ.DiscrepancyTypeLkup=LMDiscType.CMN_LookupMasterId And 	LMDiscType.CMN_LookupTypeRef = 7
	LEFT JOIN CMN_LookupMaster LMDiscSource with(nolock) ON GQ.DiscrepancySourceLkup=LMDiscSource.CMN_LookupMasterId And LMDiscSource.CMN_LookupTypeRef =13	
	LEFT JOIN CMN_LookupMaster LMStatus with(nolock) ON GQ.MostRecentStatusLkup=LMStatus.CMN_LookupMasterId And LMStatus.CMN_LookupTypeRef = 20
	LEFT JOIN CMN_LookupMaster LMQueue with(nolock) ON GQ.MostRecentWorkQueueLkup=LMQueue.CMN_LookupMasterId And LMQueue.CMN_LookupTypeRef = 10
	LEFT JOIN CMN_LookupMaster LMAction with(nolock) ON GQ.MostRecentActionLkup=LMAction.CMN_LookupMasterId  And LMAction.CMN_LookupTypeRef = 28
	LEFT JOIN CMN_LookupMasterCorrelations LMQueueType with(nolock) ON GQ.MostRecentWorkQueueLkup=LMQueueType.CMN_LookupMasterChildRef AND LMQueueType.CMN_LookupTypeCorrelationsRef=3
	LEFT JOIN CMN_LookupMaster LMQueueProgType with(nolock) ON LMQueueType.GroupingLookupMasterRef=LMQueueProgType.CMN_LookupMasterId AND LMQueueProgType.CMN_LookupTypeRef = 9
	LEFT JOIN CMN_LookupMaster LMContractId with(nolock) ON GQ.MemberContractIDLkup=LMContractId.CMN_LookupMasterId And LMContractId.CMN_LookupTypeRef = 11
	LEFT JOIN CMN_LookupMaster LMPBPId with(nolock) ON GQ.MemberPBPLkup=LMPBPId.CMN_LookupMasterId And LMPBPId.CMN_LookupTypeRef = 12
	LEFT JOIN CMN_LookupMaster LMLOBId with(nolock) ON GQ.MemberLOBLkup=LMLOBId.CMN_LookupMasterId And LMLOBId.CMN_LookupTypeRef = 31
	LEFT JOIN CMN_LookupMaster LMResolution with(nolock) ON GOST.ResolutionLkup=LMResolution.CMN_LookupMasterId And LMResolution.CMN_LookupTypeRef = 18
	LEFT JOIN CMN_LookupMaster LMOOALetterStatus with(nolock) ON GQ.OOALetterStatusLkup=LMOOALetterStatus.CMN_LookupMasterId And LMOOALetterStatus.CMN_LookupTypeRef = 53
	LEFT JOIN CMN_LookupMaster LMCTranStatus with(nolock) ON GQ.CMSTransactionStatusLkup=LMCTranStatus.CMN_LookupMasterId And LMCTranStatus.CMN_LookupTypeRef = 55
	INNER JOIN ADM_UserMaster UMC with(nolock) ON GQ.CreatedByRef=UMC.ADM_UserMasterId
	INNER JOIN ADM_UserMaster UML with(nolock) ON GQ.LastUpdatedByRef=UML.ADM_UserMasterId
	LEFT JOIN ADM_UserMaster UMLock with(nolock) ON GQ.LockedByRef=UMLock.ADM_UserMasterId
	LEFT JOIN ADM_UserMaster UMAssign with(nolock) ON GQ.AssignedToRef=UMAssign.ADM_UserMasterId
	LEFT JOIN ADM_UserMaster UMPended with(nolock) ON GQ.PendedbyRef=UMPended.ADM_UserMasterId
	LEFT JOIN CMN_RecordsLocked RL with(nolock) ON RL.CaseId=GQ.GEN_QueueId AND RL.ScreenLkup = 37010 AND RL.IsActive=1
	Where
	GQ.GEN_QueueId=@WorkItemId 
	AND (GQ.MemberCurrentHICN = @CurrentHICN OR GQ.EligGPSCurrentHICN = @CurrentHICN OR GQ.EligMMRCurrentHICN = @CurrentHICN OR GQ.[MemberMedicareId] = @CurrentHICN)
	AND GQ.IsActive=1
	AND (@IsUnlock IS NULL OR @IsUnlock = 0 OR (@IsUnlock = 1 AND GQ.LockedByRef is not null AND GQ.UTCLockedOn < DATEADD(hh,-1,GETUTCDATE())))	
	AND (@IsReAssign IS NULL OR @IsReAssign = 0 OR (@IsReAssign = 1 AND GQ.LockedByRef is null AND ((GQ.AssignedToRef IS NOT NULL AND GQ.MostRecentWorkQueueLkup = 10074) OR (GQ.PendedbyRef IS NOT NULL AND GQ.MostRecentWorkQueueLkup = 10081))))
	AND (@IsRestricted = 1 OR (@IsRestricted = 0 AND (GQ.IsRestricted = 0 OR GQ.IsRestricted IS NULL)))

	SELECT DISTINCT COUNT(*) AS TotalRecords
      ,COUNT(CASE WHEN (IsRestricted=1)  THEN 1 END) AS RestrictedRecords
	  ,COUNT(CASE WHEN (IsRestricted=0 OR IsRestricted IS NULL)  THEN 1 END) AS UnRestrictedRecords
	From GEN_Queue GQ with(nolock)
	LEFT JOIN GEN_OSTActions GOST with(nolock) ON GQ.GEN_QueueId=GOST.GEN_QueueRef
	LEFT JOIN CMN_RecordsLocked RL with(nolock) ON RL.CaseId=GQ.GEN_QueueId AND RL.ScreenLkup = 37010 AND RL.IsActive=1
	Where
	GQ.GEN_QueueId=@WorkItemId 
	AND (GQ.MemberCurrentHICN = @CurrentHICN OR GQ.EligGPSCurrentHICN = @CurrentHICN OR GQ.EligMMRCurrentHICN = @CurrentHICN OR GQ.[MemberMedicareId] = @CurrentHICN)
	AND GQ.IsActive=1
	AND (@IsUnlock IS NULL OR @IsUnlock = 0 OR (@IsUnlock = 1 AND GQ.LockedByRef is not null AND GQ.UTCLockedOn < DATEADD(hh,-1,GETUTCDATE())))	
	AND (@IsReAssign IS NULL OR @IsReAssign = 0 OR (@IsReAssign = 1 AND GQ.LockedByRef is null AND ((GQ.AssignedToRef IS NOT NULL AND GQ.MostRecentWorkQueueLkup = 10074) OR (GQ.PendedbyRef IS NOT NULL AND GQ.MostRecentWorkQueueLkup = 10081))))	
End
ELSE IF(@IsBothDiscCatAndCaseIdSelected = 1)
Begin
Select DISTINCT TOP (@TopCount)
	GEN_QueueId as WorkItemID,
	[dbo].[GetAge](GQ.[GEN_QueueId]) AS Aging,
	GQ.MemberSCCCode as MemberSCCCode,
	GQ.MemberID as MemberID,
	GQ.MemberMedicareId as MemberCurrentHICN,
	GQ.GPSHouseholdID as GPSHouseholdID,
	GQ.MemberFirstName as MemberFirstName,
	GQ.MemberMiddleName as MemberMiddleName,
	GQ.MemberLastName as MemberLastName,
	LMContractId.LookupValue as MemberContractID,
	GQ.MemberDOB as MemberDOB,
	LMPBPId.LookupValue as MemberPBP,
	LMLOBId.LookupValue as MemberLOB,
	NULL as MemberGender,
	LMDiscType.LookupValue as DiscrepancyType,
	GQ.MostRecentStatusLkup,
	LMStatus.LookupValue as MostRecentStatus,
	GQ.MostRecentWorkQueueLkup,
	LMQueue.LookupValue as MostRecentQueue,
	LMQueueType.GroupingLookupMasterRef as QueueProgressTypeLkup,
	LMQueueProgType.LookupValue as QueueProgressType,
	LMAction.LookupValue as MostRecentAction,
	GQ.MemberMedicareId as CurrentHICN,
	GQ.EligGPSCurrentHICN as GPSHICN,
	GQ.EligMMRCurrentHICN as MMRHICN,
	LMWorkBasket.LookupValue as BusinessSegment,
	GQ.BusinessSegmentLkup, 
	LMDiscrepancy.LookupValue as DiscrepancyCategory,
	GQ.DiscrepancyCategoryLkup, 
	GQ.DiscrepancyStartDate as DiscrepancyStartDate,
	GQ.DiscrepancyEndDate as DiscrepancyEndDate,
	GOST.Reason as Reason,
	LMResolution.LookupValue as Resolution,
	GQ.ReferencedEligibilityCaseInd as ReferencedEligibilityCaseIndicator,
	NULL as MMRPBP,
	NULL as GPSIndividualID,
	LMDiscSource.LookupValue as DiscrepancySource,
	NULL as SubmissionType,
	NULL as CTMMember,
	NULL as EGHPMember,
	NULL as RequestedEffectiveDate,
	NULL as ActionRequested,
	NULL as PotentialSubmissionDate,
	NULL as RPCSubmissionDate,
	NULL as FDRReceivedDate,
	NULL as FDRCodeReceived,
	NULL as FDRStatus,
	NULL as RPRRequestor,
	GQ.ComplianceStartDate as ComplianceStartDate,
	GOST.AdjustedComplianceStartDate as AdjustedComplianceStartDate,
	GQ.UTCCreatedOn,
	GQ.CreatedByRef,
	UMC.FullName as CreatedBy,
	GQ.UTCLastUpdatedOn,
	GQ.LastUpdatedByRef,
	UML.FullName as LastUpdatedBy,
	GQ.LockedByRef,
	GQ.UTCLockedOn,
	UMLock.FullName as LockedBy,
	GQ.AssignedToRef,
	GQ.UTCAssignedOn,
	UMAssign.FullName as AssignedTo,
	GQ.PendedbyRef,
	GQ.UTCPendedOn,
	UMPended.FullName as PendedBy,
	GQ.OOALetterStatusLkup,
	LMOOALetterStatus.LookupValue as OOALetterStatus,
	GQ.CMSTransactionStatusLkup,
	LMCTranStatus.LookupValue as CMSTransactionStatus,
    GQ.MemberVerifiedState,GQ.MemberVerifiedCountyCode
	From GEN_Queue GQ with(nolock)
	LEFT JOIN GEN_OSTActions GOST with(nolock) ON GQ.GEN_QueueId=GOST.GEN_QueueRef
	LEFT JOIN CMN_LookupMaster LMWorkBasket with(nolock) ON GQ.BusinessSegmentLkup=LMWorkBasket.CMN_LookupMasterId And LMWorkBasket.CMN_LookupTypeRef = 1
	LEFT JOIN CMN_LookupMaster LMDiscrepancy with(nolock) ON GQ.DiscrepancyCategoryLkup=LMDiscrepancy.CMN_LookupMasterId And LMDiscrepancy.CMN_LookupTypeRef = 6
	LEFT JOIN CMN_LookupMaster LMDiscType with(nolock) ON GQ.DiscrepancyTypeLkup=LMDiscType.CMN_LookupMasterId And 	LMDiscType.CMN_LookupTypeRef = 7
	LEFT JOIN CMN_LookupMaster LMDiscSource with(nolock) ON GQ.DiscrepancySourceLkup=LMDiscSource.CMN_LookupMasterId And LMDiscSource.CMN_LookupTypeRef =13	
	LEFT JOIN CMN_LookupMaster LMStatus with(nolock) ON GQ.MostRecentStatusLkup=LMStatus.CMN_LookupMasterId And LMStatus.CMN_LookupTypeRef = 20
	LEFT JOIN CMN_LookupMaster LMQueue with(nolock) ON GQ.MostRecentWorkQueueLkup=LMQueue.CMN_LookupMasterId And LMQueue.CMN_LookupTypeRef = 10
	LEFT JOIN CMN_LookupMaster LMAction with(nolock) ON GQ.MostRecentActionLkup=LMAction.CMN_LookupMasterId  And LMAction.CMN_LookupTypeRef = 28
	LEFT JOIN CMN_LookupMasterCorrelations LMQueueType with(nolock) ON GQ.MostRecentWorkQueueLkup=LMQueueType.CMN_LookupMasterChildRef AND LMQueueType.CMN_LookupTypeCorrelationsRef=3
	LEFT JOIN CMN_LookupMaster LMQueueProgType with(nolock) ON LMQueueType.GroupingLookupMasterRef=LMQueueProgType.CMN_LookupMasterId AND LMQueueProgType.CMN_LookupTypeRef = 9
	LEFT JOIN CMN_LookupMaster LMContractId with(nolock) ON GQ.MemberContractIDLkup=LMContractId.CMN_LookupMasterId And LMContractId.CMN_LookupTypeRef = 11
	LEFT JOIN CMN_LookupMaster LMPBPId with(nolock) ON GQ.MemberPBPLkup=LMPBPId.CMN_LookupMasterId And LMPBPId.CMN_LookupTypeRef = 12
	LEFT JOIN CMN_LookupMaster LMLOBId with(nolock) ON GQ.MemberLOBLkup=LMLOBId.CMN_LookupMasterId And LMLOBId.CMN_LookupTypeRef = 31
	LEFT JOIN CMN_LookupMaster LMResolution with(nolock) ON GOST.ResolutionLkup=LMResolution.CMN_LookupMasterId And LMResolution.CMN_LookupTypeRef = 18
	LEFT JOIN CMN_LookupMaster LMOOALetterStatus with(nolock) ON GQ.OOALetterStatusLkup=LMOOALetterStatus.CMN_LookupMasterId And LMOOALetterStatus.CMN_LookupTypeRef = 53
	LEFT JOIN CMN_LookupMaster LMCTranStatus with(nolock) ON GQ.CMSTransactionStatusLkup=LMCTranStatus.CMN_LookupMasterId And LMCTranStatus.CMN_LookupTypeRef = 55
	INNER JOIN ADM_UserMaster UMC with(nolock) ON GQ.CreatedByRef=UMC.ADM_UserMasterId
	INNER JOIN ADM_UserMaster UML with(nolock) ON GQ.LastUpdatedByRef=UML.ADM_UserMasterId
	LEFT JOIN ADM_UserMaster UMLock with(nolock) ON GQ.LockedByRef=UMLock.ADM_UserMasterId
	LEFT JOIN ADM_UserMaster UMAssign with(nolock) ON GQ.AssignedToRef=UMAssign.ADM_UserMasterId
	LEFT JOIN ADM_UserMaster UMPended with(nolock) ON GQ.PendedbyRef=UMPended.ADM_UserMasterId
	LEFT JOIN CMN_RecordsLocked RL with(nolock) ON RL.CaseId=GQ.GEN_QueueId AND RL.ScreenLkup = 37010 AND RL.IsActive=1
	Where
	GQ.DiscrepancyCategoryLkup=@DiscrepancyCategoryLkup
	AND GQ.GEN_QueueId=@WorkItemId
	AND GQ.IsActive=1
	AND (@IsUnlock IS NULL OR @IsUnlock = 0 OR (@IsUnlock = 1 AND GQ.LockedByRef is not null AND GQ.UTCLockedOn < DATEADD(hh,-1,GETUTCDATE())))	
	AND (@IsReAssign IS NULL OR @IsReAssign = 0 OR (@IsReAssign = 1 AND GQ.LockedByRef is null AND ((GQ.AssignedToRef IS NOT NULL AND GQ.MostRecentWorkQueueLkup = 10074) OR (GQ.PendedbyRef IS NOT NULL AND GQ.MostRecentWorkQueueLkup = 10081))))
	AND (@IsRestricted = 1 OR (@IsRestricted = 0 AND (GQ.IsRestricted = 0 OR GQ.IsRestricted IS NULL)))

	SELECT DISTINCT COUNT(*) AS TotalRecords
      ,COUNT(CASE WHEN (IsRestricted=1)  THEN 1 END) AS RestrictedRecords
	  ,COUNT(CASE WHEN (IsRestricted=0 OR IsRestricted IS NULL)  THEN 1 END) AS UnRestrictedRecords
	From GEN_Queue GQ with(nolock)
	LEFT JOIN GEN_OSTActions GOST with(nolock) ON GQ.GEN_QueueId=GOST.GEN_QueueRef
	LEFT JOIN CMN_RecordsLocked RL with(nolock) ON RL.CaseId=GQ.GEN_QueueId AND RL.ScreenLkup = 37010 AND RL.IsActive=1
	Where
	GQ.DiscrepancyCategoryLkup=@DiscrepancyCategoryLkup
	AND GQ.GEN_QueueId=@WorkItemId
	AND GQ.IsActive=1	
	AND (@IsUnlock IS NULL OR @IsUnlock = 0 OR (@IsUnlock = 1 AND GQ.LockedByRef is not null AND GQ.UTCLockedOn < DATEADD(hh,-1,GETUTCDATE())))	
	AND (@IsReAssign IS NULL OR @IsReAssign = 0 OR (@IsReAssign = 1 AND GQ.LockedByRef is null AND ((GQ.AssignedToRef IS NOT NULL AND GQ.MostRecentWorkQueueLkup = 10074) OR (GQ.PendedbyRef IS NOT NULL AND GQ.MostRecentWorkQueueLkup = 10081))))
End
ELSE IF(@IsBothDiscCatAndMedicareIdSelected =1)
Begin
Select DISTINCT TOP (@TopCount)
	GEN_QueueId as WorkItemID,
	[dbo].[GetAge](GQ.[GEN_QueueId]) AS Aging,
	GQ.MemberSCCCode as MemberSCCCode,
	GQ.MemberID as MemberID,
	GQ.MemberMedicareId as MemberCurrentHICN,
	GQ.GPSHouseholdID as GPSHouseholdID,
	GQ.MemberFirstName as MemberFirstName,
	GQ.MemberMiddleName as MemberMiddleName,
	GQ.MemberLastName as MemberLastName,
	LMContractId.LookupValue as MemberContractID,
	GQ.MemberDOB as MemberDOB,
	LMPBPId.LookupValue as MemberPBP,
	LMLOBId.LookupValue as MemberLOB,
	NULL as MemberGender,
	LMDiscType.LookupValue as DiscrepancyType,
	GQ.MostRecentStatusLkup,
	LMStatus.LookupValue as MostRecentStatus,
	GQ.MostRecentWorkQueueLkup,
	LMQueue.LookupValue as MostRecentQueue,
	LMQueueType.GroupingLookupMasterRef as QueueProgressTypeLkup,
	LMQueueProgType.LookupValue as QueueProgressType,
	LMAction.LookupValue as MostRecentAction,
	GQ.MemberMedicareId as CurrentHICN,
	GQ.EligGPSCurrentHICN as GPSHICN,
	GQ.EligMMRCurrentHICN as MMRHICN,
	LMWorkBasket.LookupValue as BusinessSegment,
	GQ.BusinessSegmentLkup, 
	LMDiscrepancy.LookupValue as DiscrepancyCategory,
	GQ.DiscrepancyCategoryLkup, 
	GQ.DiscrepancyStartDate as DiscrepancyStartDate,
	GQ.DiscrepancyEndDate as DiscrepancyEndDate,
	GOST.Reason as Reason,
	LMResolution.LookupValue as Resolution,
	GQ.ReferencedEligibilityCaseInd as ReferencedEligibilityCaseIndicator,
	NULL as MMRPBP,
	NULL as GPSIndividualID,
	LMDiscSource.LookupValue as DiscrepancySource,
	NULL as SubmissionType,
	NULL as CTMMember,
	NULL as EGHPMember,
	NULL as RequestedEffectiveDate,
	NULL as ActionRequested,
	NULL as PotentialSubmissionDate,
	NULL as RPCSubmissionDate,
	NULL as FDRReceivedDate,
	NULL as FDRCodeReceived,
	NULL as FDRStatus,
	NULL as RPRRequestor,
	GQ.ComplianceStartDate as ComplianceStartDate,
	GOST.AdjustedComplianceStartDate as AdjustedComplianceStartDate,
	GQ.UTCCreatedOn,
	GQ.CreatedByRef,
	UMC.FullName as CreatedBy,
	GQ.UTCLastUpdatedOn,
	GQ.LastUpdatedByRef,
	UML.FullName as LastUpdatedBy,
	GQ.LockedByRef,
	GQ.UTCLockedOn,
	UMLock.FullName as LockedBy,
	GQ.AssignedToRef,
	GQ.UTCAssignedOn,
	UMAssign.FullName as AssignedTo,
	GQ.PendedbyRef,
	GQ.UTCPendedOn,
	UMPended.FullName as PendedBy,
	GQ.OOALetterStatusLkup,
	LMOOALetterStatus.LookupValue as OOALetterStatus,
	GQ.CMSTransactionStatusLkup,
	LMCTranStatus.LookupValue as CMSTransactionStatus,
    GQ.MemberVerifiedState,GQ.MemberVerifiedCountyCode
	From GEN_Queue GQ with(nolock)
	LEFT JOIN GEN_OSTActions GOST with(nolock) ON GQ.GEN_QueueId=GOST.GEN_QueueRef
	LEFT JOIN CMN_LookupMaster LMWorkBasket with(nolock) ON GQ.BusinessSegmentLkup=LMWorkBasket.CMN_LookupMasterId And LMWorkBasket.CMN_LookupTypeRef = 1
	LEFT JOIN CMN_LookupMaster LMDiscrepancy with(nolock) ON GQ.DiscrepancyCategoryLkup=LMDiscrepancy.CMN_LookupMasterId And LMDiscrepancy.CMN_LookupTypeRef = 6
	LEFT JOIN CMN_LookupMaster LMDiscType with(nolock) ON GQ.DiscrepancyTypeLkup=LMDiscType.CMN_LookupMasterId And 	LMDiscType.CMN_LookupTypeRef = 7
	LEFT JOIN CMN_LookupMaster LMDiscSource with(nolock) ON GQ.DiscrepancySourceLkup=LMDiscSource.CMN_LookupMasterId And LMDiscSource.CMN_LookupTypeRef =13	
	LEFT JOIN CMN_LookupMaster LMStatus with(nolock) ON GQ.MostRecentStatusLkup=LMStatus.CMN_LookupMasterId And LMStatus.CMN_LookupTypeRef = 20
	LEFT JOIN CMN_LookupMaster LMQueue with(nolock) ON GQ.MostRecentWorkQueueLkup=LMQueue.CMN_LookupMasterId And LMQueue.CMN_LookupTypeRef = 10
	LEFT JOIN CMN_LookupMaster LMAction with(nolock) ON GQ.MostRecentActionLkup=LMAction.CMN_LookupMasterId  And LMAction.CMN_LookupTypeRef = 28
	LEFT JOIN CMN_LookupMasterCorrelations LMQueueType with(nolock) ON GQ.MostRecentWorkQueueLkup=LMQueueType.CMN_LookupMasterChildRef AND LMQueueType.CMN_LookupTypeCorrelationsRef=3
	LEFT JOIN CMN_LookupMaster LMQueueProgType with(nolock) ON LMQueueType.GroupingLookupMasterRef=LMQueueProgType.CMN_LookupMasterId AND LMQueueProgType.CMN_LookupTypeRef = 9
	LEFT JOIN CMN_LookupMaster LMContractId with(nolock) ON GQ.MemberContractIDLkup=LMContractId.CMN_LookupMasterId And LMContractId.CMN_LookupTypeRef = 11
	LEFT JOIN CMN_LookupMaster LMPBPId with(nolock) ON GQ.MemberPBPLkup=LMPBPId.CMN_LookupMasterId And LMPBPId.CMN_LookupTypeRef = 12
	LEFT JOIN CMN_LookupMaster LMLOBId with(nolock) ON GQ.MemberLOBLkup=LMLOBId.CMN_LookupMasterId And LMLOBId.CMN_LookupTypeRef = 31
	LEFT JOIN CMN_LookupMaster LMResolution with(nolock) ON GOST.ResolutionLkup=LMResolution.CMN_LookupMasterId And LMResolution.CMN_LookupTypeRef = 18
	LEFT JOIN CMN_LookupMaster LMOOALetterStatus with(nolock) ON GQ.OOALetterStatusLkup=LMOOALetterStatus.CMN_LookupMasterId And LMOOALetterStatus.CMN_LookupTypeRef = 53
	LEFT JOIN CMN_LookupMaster LMCTranStatus with(nolock) ON GQ.CMSTransactionStatusLkup=LMCTranStatus.CMN_LookupMasterId And LMCTranStatus.CMN_LookupTypeRef = 55
	INNER JOIN ADM_UserMaster UMC with(nolock) ON GQ.CreatedByRef=UMC.ADM_UserMasterId
	INNER JOIN ADM_UserMaster UML with(nolock) ON GQ.LastUpdatedByRef=UML.ADM_UserMasterId
	LEFT JOIN ADM_UserMaster UMLock with(nolock) ON GQ.LockedByRef=UMLock.ADM_UserMasterId
	LEFT JOIN ADM_UserMaster UMAssign with(nolock) ON GQ.AssignedToRef=UMAssign.ADM_UserMasterId
	LEFT JOIN ADM_UserMaster UMPended with(nolock) ON GQ.PendedbyRef=UMPended.ADM_UserMasterId
	LEFT JOIN CMN_RecordsLocked RL with(nolock) ON RL.CaseId=GQ.GEN_QueueId AND RL.ScreenLkup = 37010 AND RL.IsActive=1
	Where
	GQ.DiscrepancyCategoryLkup=@DiscrepancyCategoryLkup
	AND (GQ.MemberCurrentHICN = @CurrentHICN OR GQ.EligGPSCurrentHICN = @CurrentHICN OR GQ.EligMMRCurrentHICN = @CurrentHICN  OR GQ.[MemberMedicareId] = @CurrentHICN)
	AND GQ.IsActive=1
	AND (@IsUnlock IS NULL OR @IsUnlock = 0 OR (@IsUnlock = 1 AND GQ.LockedByRef is not null AND GQ.UTCLockedOn < DATEADD(hh,-1,GETUTCDATE())))	
	AND (@IsReAssign IS NULL OR @IsReAssign = 0 OR (@IsReAssign = 1 AND GQ.LockedByRef is null AND ((GQ.AssignedToRef IS NOT NULL AND GQ.MostRecentWorkQueueLkup = 10074) OR (GQ.PendedbyRef IS NOT NULL AND GQ.MostRecentWorkQueueLkup = 10081))))
	AND (@IsRestricted = 1 OR (@IsRestricted = 0 AND (GQ.IsRestricted = 0 OR GQ.IsRestricted IS NULL)))

	SELECT DISTINCT COUNT(*) AS TotalRecords
      ,COUNT(CASE WHEN (IsRestricted=1)  THEN 1 END) AS RestrictedRecords
	  ,COUNT(CASE WHEN (IsRestricted=0 OR IsRestricted IS NULL)  THEN 1 END) AS UnRestrictedRecords
	From GEN_Queue GQ with(nolock)
	LEFT JOIN GEN_OSTActions GOST with(nolock) ON GQ.GEN_QueueId=GOST.GEN_QueueRef
	LEFT JOIN CMN_RecordsLocked RL with(nolock) ON RL.CaseId=GQ.GEN_QueueId AND RL.ScreenLkup = 37010 AND RL.IsActive=1
	Where
	GQ.DiscrepancyCategoryLkup=@DiscrepancyCategoryLkup
	AND (GQ.MemberCurrentHICN = @CurrentHICN OR GQ.EligGPSCurrentHICN = @CurrentHICN OR GQ.EligMMRCurrentHICN = @CurrentHICN  OR GQ.[MemberMedicareId] = @CurrentHICN)
	AND GQ.IsActive=1
	AND (@IsUnlock IS NULL OR @IsUnlock = 0 OR (@IsUnlock = 1 AND GQ.LockedByRef is not null AND GQ.UTCLockedOn < DATEADD(hh,-1,GETUTCDATE())))	
	AND (@IsReAssign IS NULL OR @IsReAssign = 0 OR (@IsReAssign = 1 AND GQ.LockedByRef is null AND ((GQ.AssignedToRef IS NOT NULL AND GQ.MostRecentWorkQueueLkup = 10074) OR (GQ.PendedbyRef IS NOT NULL AND GQ.MostRecentWorkQueueLkup = 10081))))	
End
ELSE IF(@IsDiscCatAndCaseIdAndMedicareIdSelected = 1)
Begin
Select DISTINCT TOP (@TopCount)
	GEN_QueueId as WorkItemID,
	[dbo].[GetAge](GQ.[GEN_QueueId]) AS Aging,
	GQ.MemberSCCCode as MemberSCCCode,
	GQ.MemberID as MemberID,
	GQ.MemberMedicareId as MemberCurrentHICN,
	GQ.GPSHouseholdID as GPSHouseholdID,
	GQ.MemberFirstName as MemberFirstName,
	GQ.MemberMiddleName as MemberMiddleName,
	GQ.MemberLastName as MemberLastName,
	LMContractId.LookupValue as MemberContractID,
	GQ.MemberDOB as MemberDOB,
	LMPBPId.LookupValue as MemberPBP,
	LMLOBId.LookupValue as MemberLOB,
	NULL as MemberGender,
	LMDiscType.LookupValue as DiscrepancyType,
	GQ.MostRecentStatusLkup,
	LMStatus.LookupValue as MostRecentStatus,
	GQ.MostRecentWorkQueueLkup,
	LMQueue.LookupValue as MostRecentQueue,
	LMQueueType.GroupingLookupMasterRef as QueueProgressTypeLkup,
	LMQueueProgType.LookupValue as QueueProgressType,
	LMAction.LookupValue as MostRecentAction,
	GQ.MemberMedicareId as CurrentHICN,
	GQ.EligGPSCurrentHICN as GPSHICN,
	GQ.EligMMRCurrentHICN as MMRHICN,
	LMWorkBasket.LookupValue as BusinessSegment,
	GQ.BusinessSegmentLkup, 
	LMDiscrepancy.LookupValue as DiscrepancyCategory,
	GQ.DiscrepancyCategoryLkup, 
	GQ.DiscrepancyStartDate as DiscrepancyStartDate,
	GQ.DiscrepancyEndDate as DiscrepancyEndDate,
	GOST.Reason as Reason,
	LMResolution.LookupValue as Resolution,
	GQ.ReferencedEligibilityCaseInd as ReferencedEligibilityCaseIndicator,
	NULL as MMRPBP,
	NULL as GPSIndividualID,
	LMDiscSource.LookupValue as DiscrepancySource,
	NULL as SubmissionType,
	NULL as CTMMember,
	NULL as EGHPMember,
	NULL as RequestedEffectiveDate,
	NULL as ActionRequested,
	NULL as PotentialSubmissionDate,
	NULL as RPCSubmissionDate,
	NULL as FDRReceivedDate,
	NULL as FDRCodeReceived,
	NULL as FDRStatus,
	NULL as RPRRequestor,
	GQ.ComplianceStartDate as ComplianceStartDate,
	GOST.AdjustedComplianceStartDate as AdjustedComplianceStartDate,
	GQ.UTCCreatedOn,
	GQ.CreatedByRef,
	UMC.FullName as CreatedBy,
	GQ.UTCLastUpdatedOn,
	GQ.LastUpdatedByRef,
	UML.FullName as LastUpdatedBy,
	GQ.LockedByRef,
	GQ.UTCLockedOn,
	UMLock.FullName as LockedBy,
	GQ.AssignedToRef,
	GQ.UTCAssignedOn,
	UMAssign.FullName as AssignedTo,
	GQ.PendedbyRef,
	GQ.UTCPendedOn,
	UMPended.FullName as PendedBy,
	GQ.OOALetterStatusLkup,
	LMOOALetterStatus.LookupValue as OOALetterStatus,
	GQ.CMSTransactionStatusLkup,
	LMCTranStatus.LookupValue as CMSTransactionStatus,
    GQ.MemberVerifiedState,GQ.MemberVerifiedCountyCode
	From GEN_Queue GQ with(nolock)
	LEFT JOIN GEN_OSTActions GOST with(nolock) ON GQ.GEN_QueueId=GOST.GEN_QueueRef
	LEFT JOIN CMN_LookupMaster LMWorkBasket with(nolock) ON GQ.BusinessSegmentLkup=LMWorkBasket.CMN_LookupMasterId And LMWorkBasket.CMN_LookupTypeRef = 1
	LEFT JOIN CMN_LookupMaster LMDiscrepancy with(nolock) ON GQ.DiscrepancyCategoryLkup=LMDiscrepancy.CMN_LookupMasterId And LMDiscrepancy.CMN_LookupTypeRef = 6
	LEFT JOIN CMN_LookupMaster LMDiscType with(nolock) ON GQ.DiscrepancyTypeLkup=LMDiscType.CMN_LookupMasterId And 	LMDiscType.CMN_LookupTypeRef = 7
	LEFT JOIN CMN_LookupMaster LMDiscSource with(nolock) ON GQ.DiscrepancySourceLkup=LMDiscSource.CMN_LookupMasterId And LMDiscSource.CMN_LookupTypeRef =13	
	LEFT JOIN CMN_LookupMaster LMStatus with(nolock) ON GQ.MostRecentStatusLkup=LMStatus.CMN_LookupMasterId And LMStatus.CMN_LookupTypeRef = 20
	LEFT JOIN CMN_LookupMaster LMQueue with(nolock) ON GQ.MostRecentWorkQueueLkup=LMQueue.CMN_LookupMasterId And LMQueue.CMN_LookupTypeRef = 10
	LEFT JOIN CMN_LookupMaster LMAction with(nolock) ON GQ.MostRecentActionLkup=LMAction.CMN_LookupMasterId  And LMAction.CMN_LookupTypeRef = 28
	LEFT JOIN CMN_LookupMasterCorrelations LMQueueType with(nolock) ON GQ.MostRecentWorkQueueLkup=LMQueueType.CMN_LookupMasterChildRef AND LMQueueType.CMN_LookupTypeCorrelationsRef=3
	LEFT JOIN CMN_LookupMaster LMQueueProgType with(nolock) ON LMQueueType.GroupingLookupMasterRef=LMQueueProgType.CMN_LookupMasterId AND LMQueueProgType.CMN_LookupTypeRef = 9
	LEFT JOIN CMN_LookupMaster LMContractId with(nolock) ON GQ.MemberContractIDLkup=LMContractId.CMN_LookupMasterId And LMContractId.CMN_LookupTypeRef = 11
	LEFT JOIN CMN_LookupMaster LMPBPId with(nolock) ON GQ.MemberPBPLkup=LMPBPId.CMN_LookupMasterId And LMPBPId.CMN_LookupTypeRef = 12
	LEFT JOIN CMN_LookupMaster LMLOBId with(nolock) ON GQ.MemberLOBLkup=LMLOBId.CMN_LookupMasterId And LMLOBId.CMN_LookupTypeRef = 31
	LEFT JOIN CMN_LookupMaster LMResolution with(nolock) ON GOST.ResolutionLkup=LMResolution.CMN_LookupMasterId And LMResolution.CMN_LookupTypeRef = 18
	LEFT JOIN CMN_LookupMaster LMOOALetterStatus with(nolock) ON GQ.OOALetterStatusLkup=LMOOALetterStatus.CMN_LookupMasterId And LMOOALetterStatus.CMN_LookupTypeRef = 53
	LEFT JOIN CMN_LookupMaster LMCTranStatus with(nolock) ON GQ.CMSTransactionStatusLkup=LMCTranStatus.CMN_LookupMasterId And LMCTranStatus.CMN_LookupTypeRef = 55
	INNER JOIN ADM_UserMaster UMC with(nolock) ON GQ.CreatedByRef=UMC.ADM_UserMasterId
	INNER JOIN ADM_UserMaster UML with(nolock) ON GQ.LastUpdatedByRef=UML.ADM_UserMasterId
	LEFT JOIN ADM_UserMaster UMLock with(nolock) ON GQ.LockedByRef=UMLock.ADM_UserMasterId
	LEFT JOIN ADM_UserMaster UMAssign with(nolock) ON GQ.AssignedToRef=UMAssign.ADM_UserMasterId
	LEFT JOIN ADM_UserMaster UMPended with(nolock) ON GQ.PendedbyRef=UMPended.ADM_UserMasterId
	LEFT JOIN CMN_RecordsLocked RL with(nolock) ON RL.CaseId=GQ.GEN_QueueId AND RL.ScreenLkup = 37010 AND RL.IsActive=1
	Where
	GQ.GEN_QueueId=@WorkItemId
	AND GQ.DiscrepancyCategoryLkup=@DiscrepancyCategoryLkup
	AND (GQ.MemberCurrentHICN = @CurrentHICN OR GQ.EligGPSCurrentHICN = @CurrentHICN OR GQ.EligMMRCurrentHICN = @CurrentHICN  OR GQ.[MemberMedicareId] = @CurrentHICN)
	AND GQ.IsActive=1
	AND (@IsUnlock IS NULL OR @IsUnlock = 0 OR (@IsUnlock = 1 AND GQ.LockedByRef is not null AND GQ.UTCLockedOn < DATEADD(hh,-1,GETUTCDATE())))	
	AND (@IsReAssign IS NULL OR @IsReAssign = 0 OR (@IsReAssign = 1 AND GQ.LockedByRef is null AND ((GQ.AssignedToRef IS NOT NULL AND GQ.MostRecentWorkQueueLkup = 10074) OR (GQ.PendedbyRef IS NOT NULL AND GQ.MostRecentWorkQueueLkup = 10081))))
	AND (@IsRestricted = 1 OR (@IsRestricted = 0 AND (GQ.IsRestricted = 0 OR GQ.IsRestricted IS NULL)))

	SELECT DISTINCT COUNT(*) AS TotalRecords
      ,COUNT(CASE WHEN (IsRestricted=1)  THEN 1 END) AS RestrictedRecords
	  ,COUNT(CASE WHEN (IsRestricted=0 OR IsRestricted IS NULL)  THEN 1 END) AS UnRestrictedRecords
	From GEN_Queue GQ with(nolock)
	LEFT JOIN GEN_OSTActions GOST with(nolock) ON GQ.GEN_QueueId=GOST.GEN_QueueRef
	LEFT JOIN CMN_RecordsLocked RL with(nolock) ON RL.CaseId=GQ.GEN_QueueId AND RL.ScreenLkup = 37010 AND RL.IsActive=1
	Where
	GQ.GEN_QueueId=@WorkItemId
	AND GQ.DiscrepancyCategoryLkup=@DiscrepancyCategoryLkup
	AND (GQ.MemberCurrentHICN = @CurrentHICN OR GQ.EligGPSCurrentHICN = @CurrentHICN OR GQ.EligMMRCurrentHICN = @CurrentHICN  OR GQ.[MemberMedicareId] = @CurrentHICN)
	AND GQ.IsActive=1
	AND (@IsUnlock IS NULL OR @IsUnlock = 0 OR (@IsUnlock = 1 AND GQ.LockedByRef is not null AND GQ.UTCLockedOn < DATEADD(hh,-1,GETUTCDATE())))	
	AND (@IsReAssign IS NULL OR @IsReAssign = 0 OR (@IsReAssign = 1 AND GQ.LockedByRef is null AND ((GQ.AssignedToRef IS NOT NULL AND GQ.MostRecentWorkQueueLkup = 10074) OR (GQ.PendedbyRef IS NOT NULL AND GQ.MostRecentWorkQueueLkup = 10081))))	
End
ELSE IF(@IsDiscCatOSTAndComplianceDateSelected = 1)
Begin
Select DISTINCT TOP (@TopCount)
	GEN_QueueId as WorkItemID,
	[dbo].[GetAge](GQ.[GEN_QueueId]) AS Aging,
	GQ.MemberSCCCode as MemberSCCCode,
	GQ.MemberID as MemberID,
	GQ.MemberMedicareId as MemberCurrentHICN,
	GQ.GPSHouseholdID as GPSHouseholdID,
	GQ.MemberFirstName as MemberFirstName,
	GQ.MemberMiddleName as MemberMiddleName,
	GQ.MemberLastName as MemberLastName,
	LMContractId.LookupValue as MemberContractID,
	GQ.MemberDOB as MemberDOB,
	LMPBPId.LookupValue as MemberPBP,
	LMLOBId.LookupValue as MemberLOB,
	NULL as MemberGender,
	LMDiscType.LookupValue as DiscrepancyType,
	GQ.MostRecentStatusLkup,
	LMStatus.LookupValue as MostRecentStatus,
	GQ.MostRecentWorkQueueLkup,
	LMQueue.LookupValue as MostRecentQueue,
	LMQueueType.GroupingLookupMasterRef as QueueProgressTypeLkup,
	LMQueueProgType.LookupValue as QueueProgressType,
	LMAction.LookupValue as MostRecentAction,
	GQ.MemberMedicareId as CurrentHICN,
	GQ.EligGPSCurrentHICN as GPSHICN,
	GQ.EligMMRCurrentHICN as MMRHICN,
	LMWorkBasket.LookupValue as BusinessSegment,
	GQ.BusinessSegmentLkup, 
	LMDiscrepancy.LookupValue as DiscrepancyCategory,
	GQ.DiscrepancyCategoryLkup, 
	GQ.DiscrepancyStartDate as DiscrepancyStartDate,
	GQ.DiscrepancyEndDate as DiscrepancyEndDate,
	GOST.Reason as Reason,
	LMResolution.LookupValue as Resolution,
	GQ.ReferencedEligibilityCaseInd as ReferencedEligibilityCaseIndicator,
	NULL as MMRPBP,
	NULL as GPSIndividualID,
	LMDiscSource.LookupValue as DiscrepancySource,
	NULL as SubmissionType,
	NULL as CTMMember,
	NULL as EGHPMember,
	NULL as RequestedEffectiveDate,
	NULL as ActionRequested,
	NULL as PotentialSubmissionDate,
	NULL as RPCSubmissionDate,
	NULL as FDRReceivedDate,
	NULL as FDRCodeReceived,
	NULL as FDRStatus,
	NULL as RPRRequestor,
	GQ.ComplianceStartDate as ComplianceStartDate,
	GOST.AdjustedComplianceStartDate as AdjustedComplianceStartDate,
	GQ.UTCCreatedOn,
	GQ.CreatedByRef,
	UMC.FullName as CreatedBy,
	GQ.UTCLastUpdatedOn,
	GQ.LastUpdatedByRef,
	UML.FullName as LastUpdatedBy,
	GQ.LockedByRef,
	GQ.UTCLockedOn,
	UMLock.FullName as LockedBy,
	GQ.AssignedToRef,
	GQ.UTCAssignedOn,
	UMAssign.FullName as AssignedTo,
	GQ.PendedbyRef,
	GQ.UTCPendedOn,
	UMPended.FullName as PendedBy,
	GQ.OOALetterStatusLkup,
	LMOOALetterStatus.LookupValue as OOALetterStatus,
	GQ.CMSTransactionStatusLkup,
	LMCTranStatus.LookupValue as CMSTransactionStatus,
    GQ.MemberVerifiedState,GQ.MemberVerifiedCountyCode
	From GEN_Queue GQ with(nolock)
	LEFT JOIN GEN_OSTActions GOST with(nolock) ON GQ.GEN_QueueId=GOST.GEN_QueueRef
	LEFT JOIN CMN_LookupMaster LMWorkBasket with(nolock) ON GQ.BusinessSegmentLkup=LMWorkBasket.CMN_LookupMasterId And LMWorkBasket.CMN_LookupTypeRef = 1
	LEFT JOIN CMN_LookupMaster LMDiscrepancy with(nolock) ON GQ.DiscrepancyCategoryLkup=LMDiscrepancy.CMN_LookupMasterId And LMDiscrepancy.CMN_LookupTypeRef = 6
	LEFT JOIN CMN_LookupMaster LMDiscType with(nolock) ON GQ.DiscrepancyTypeLkup=LMDiscType.CMN_LookupMasterId And 	LMDiscType.CMN_LookupTypeRef = 7
	LEFT JOIN CMN_LookupMaster LMDiscSource with(nolock) ON GQ.DiscrepancySourceLkup=LMDiscSource.CMN_LookupMasterId And LMDiscSource.CMN_LookupTypeRef =13	
	LEFT JOIN CMN_LookupMaster LMStatus with(nolock) ON GQ.MostRecentStatusLkup=LMStatus.CMN_LookupMasterId And LMStatus.CMN_LookupTypeRef = 20
	LEFT JOIN CMN_LookupMaster LMQueue with(nolock) ON GQ.MostRecentWorkQueueLkup=LMQueue.CMN_LookupMasterId And LMQueue.CMN_LookupTypeRef = 10
	LEFT JOIN CMN_LookupMaster LMAction with(nolock) ON GQ.MostRecentActionLkup=LMAction.CMN_LookupMasterId  And LMAction.CMN_LookupTypeRef = 28
	LEFT JOIN CMN_LookupMasterCorrelations LMQueueType with(nolock) ON GQ.MostRecentWorkQueueLkup=LMQueueType.CMN_LookupMasterChildRef AND LMQueueType.CMN_LookupTypeCorrelationsRef=3
	LEFT JOIN CMN_LookupMaster LMQueueProgType with(nolock) ON LMQueueType.GroupingLookupMasterRef=LMQueueProgType.CMN_LookupMasterId AND LMQueueProgType.CMN_LookupTypeRef = 9
	LEFT JOIN CMN_LookupMaster LMContractId with(nolock) ON GQ.MemberContractIDLkup=LMContractId.CMN_LookupMasterId And LMContractId.CMN_LookupTypeRef = 11
	LEFT JOIN CMN_LookupMaster LMPBPId with(nolock) ON GQ.MemberPBPLkup=LMPBPId.CMN_LookupMasterId And LMPBPId.CMN_LookupTypeRef = 12
	LEFT JOIN CMN_LookupMaster LMLOBId with(nolock) ON GQ.MemberLOBLkup=LMLOBId.CMN_LookupMasterId And LMLOBId.CMN_LookupTypeRef = 31
	LEFT JOIN CMN_LookupMaster LMResolution with(nolock) ON GOST.ResolutionLkup=LMResolution.CMN_LookupMasterId And LMResolution.CMN_LookupTypeRef = 18
	LEFT JOIN CMN_LookupMaster LMOOALetterStatus with(nolock) ON GQ.OOALetterStatusLkup=LMOOALetterStatus.CMN_LookupMasterId And LMOOALetterStatus.CMN_LookupTypeRef = 53
	LEFT JOIN CMN_LookupMaster LMCTranStatus with(nolock) ON GQ.CMSTransactionStatusLkup=LMCTranStatus.CMN_LookupMasterId And LMCTranStatus.CMN_LookupTypeRef = 55
	INNER JOIN ADM_UserMaster UMC with(nolock) ON GQ.CreatedByRef=UMC.ADM_UserMasterId
	INNER JOIN ADM_UserMaster UML with(nolock) ON GQ.LastUpdatedByRef=UML.ADM_UserMasterId
	LEFT JOIN ADM_UserMaster UMLock with(nolock) ON GQ.LockedByRef=UMLock.ADM_UserMasterId
	LEFT JOIN ADM_UserMaster UMAssign with(nolock) ON GQ.AssignedToRef=UMAssign.ADM_UserMasterId
	LEFT JOIN ADM_UserMaster UMPended with(nolock) ON GQ.PendedbyRef=UMPended.ADM_UserMasterId
	LEFT JOIN CMN_RecordsLocked RL with(nolock) ON RL.CaseId=GQ.GEN_QueueId AND RL.ScreenLkup = 37010 AND RL.IsActive=1
	Where	
	GQ.DiscrepancyCategoryLkup=@DiscrepancyCategoryLkup
	AND (GQ.ComplianceStartDateId>=@ComplianceStartDateId)
	AND (GQ.ComplianceStartDateId<=@ComplianceEndDateId )	
	AND GQ.IsActive=1
	AND (@IsUnlock IS NULL OR @IsUnlock = 0 OR (@IsUnlock = 1 AND GQ.LockedByRef is not null AND GQ.UTCLockedOn < DATEADD(hh,-1,GETUTCDATE())))	
	AND (@IsReAssign IS NULL OR @IsReAssign = 0 OR (@IsReAssign = 1 AND GQ.LockedByRef is null AND ((GQ.AssignedToRef IS NOT NULL AND GQ.MostRecentWorkQueueLkup = 10074) OR (GQ.PendedbyRef IS NOT NULL AND GQ.MostRecentWorkQueueLkup = 10081))))
	AND (@IsRestricted = 1 OR (@IsRestricted = 0 AND (GQ.IsRestricted = 0 OR GQ.IsRestricted IS NULL)))

	SELECT DISTINCT COUNT(*) AS TotalRecords
      ,COUNT(CASE WHEN (IsRestricted=1)  THEN 1 END) AS RestrictedRecords
	  ,COUNT(CASE WHEN (IsRestricted=0 OR IsRestricted IS NULL)  THEN 1 END) AS UnRestrictedRecords
	From GEN_Queue GQ with(nolock)
	LEFT JOIN GEN_OSTActions GOST with(nolock) ON GQ.GEN_QueueId=GOST.GEN_QueueRef
	LEFT JOIN CMN_RecordsLocked RL with(nolock) ON RL.CaseId=GQ.GEN_QueueId AND RL.ScreenLkup = 37010 AND RL.IsActive=1
	Where
	GQ.DiscrepancyCategoryLkup=@DiscrepancyCategoryLkup
	AND (GQ.ComplianceStartDateId>=@ComplianceStartDateId)
	AND (GQ.ComplianceStartDateId<=@ComplianceEndDateId )	
	AND GQ.IsActive=1
	AND (@IsUnlock IS NULL OR @IsUnlock = 0 OR (@IsUnlock = 1 AND GQ.LockedByRef is not null AND GQ.UTCLockedOn < DATEADD(hh,-1,GETUTCDATE())))	
	AND (@IsReAssign IS NULL OR @IsReAssign = 0 OR (@IsReAssign = 1 AND GQ.LockedByRef is null AND ((GQ.AssignedToRef IS NOT NULL AND GQ.MostRecentWorkQueueLkup = 10074) OR (GQ.PendedbyRef IS NOT NULL AND GQ.MostRecentWorkQueueLkup = 10081))))	
End
ELSE IF(@IsDiscCatOSTAndDiscTypeAndComplianceDateSelected = 1)
Begin
Select DISTINCT TOP (@TopCount)
	GEN_QueueId as WorkItemID,
	[dbo].[GetAge](GQ.[GEN_QueueId]) AS Aging,
	GQ.MemberSCCCode as MemberSCCCode,
	GQ.MemberID as MemberID,
	GQ.MemberMedicareId as MemberCurrentHICN,
	GQ.GPSHouseholdID as GPSHouseholdID,
	GQ.MemberFirstName as MemberFirstName,
	GQ.MemberMiddleName as MemberMiddleName,
	GQ.MemberLastName as MemberLastName,
	LMContractId.LookupValue as MemberContractID,
	GQ.MemberDOB as MemberDOB,
	LMPBPId.LookupValue as MemberPBP,
	LMLOBId.LookupValue as MemberLOB,
	NULL as MemberGender,
	LMDiscType.LookupValue as DiscrepancyType,
	GQ.MostRecentStatusLkup,
	LMStatus.LookupValue as MostRecentStatus,
	GQ.MostRecentWorkQueueLkup,
	LMQueue.LookupValue as MostRecentQueue,
	LMQueueType.GroupingLookupMasterRef as QueueProgressTypeLkup,
	LMQueueProgType.LookupValue as QueueProgressType,
	LMAction.LookupValue as MostRecentAction,
	GQ.MemberMedicareId as CurrentHICN,
	GQ.EligGPSCurrentHICN as GPSHICN,
	GQ.EligMMRCurrentHICN as MMRHICN,
	LMWorkBasket.LookupValue as BusinessSegment,
	GQ.BusinessSegmentLkup, 
	LMDiscrepancy.LookupValue as DiscrepancyCategory,
	GQ.DiscrepancyCategoryLkup, 
	GQ.DiscrepancyStartDate as DiscrepancyStartDate,
	GQ.DiscrepancyEndDate as DiscrepancyEndDate,
	GOST.Reason as Reason,
	LMResolution.LookupValue as Resolution,
	GQ.ReferencedEligibilityCaseInd as ReferencedEligibilityCaseIndicator,
	NULL as MMRPBP,
	NULL as GPSIndividualID,
	LMDiscSource.LookupValue as DiscrepancySource,
	NULL as SubmissionType,
	NULL as CTMMember,
	NULL as EGHPMember,
	NULL as RequestedEffectiveDate,
	NULL as ActionRequested,
	NULL as PotentialSubmissionDate,
	NULL as RPCSubmissionDate,
	NULL as FDRReceivedDate,
	NULL as FDRCodeReceived,
	NULL as FDRStatus,
	NULL as RPRRequestor,
	GQ.ComplianceStartDate as ComplianceStartDate,
	GOST.AdjustedComplianceStartDate as AdjustedComplianceStartDate,
	GQ.UTCCreatedOn,
	GQ.CreatedByRef,
	UMC.FullName as CreatedBy,
	GQ.UTCLastUpdatedOn,
	GQ.LastUpdatedByRef,
	UML.FullName as LastUpdatedBy,
	GQ.LockedByRef,
	GQ.UTCLockedOn,
	UMLock.FullName as LockedBy,
	GQ.AssignedToRef,
	GQ.UTCAssignedOn,
	UMAssign.FullName as AssignedTo,
	GQ.PendedbyRef,
	GQ.UTCPendedOn,
	UMPended.FullName as PendedBy,
	GQ.OOALetterStatusLkup,
	LMOOALetterStatus.LookupValue as OOALetterStatus,
	GQ.CMSTransactionStatusLkup,
	LMCTranStatus.LookupValue as CMSTransactionStatus,
    GQ.MemberVerifiedState,GQ.MemberVerifiedCountyCode
	From GEN_Queue GQ with(nolock)
	LEFT JOIN GEN_OSTActions GOST with(nolock) ON GQ.GEN_QueueId=GOST.GEN_QueueRef
	LEFT JOIN CMN_LookupMaster LMWorkBasket with(nolock) ON GQ.BusinessSegmentLkup=LMWorkBasket.CMN_LookupMasterId And LMWorkBasket.CMN_LookupTypeRef = 1
	LEFT JOIN CMN_LookupMaster LMDiscrepancy with(nolock) ON GQ.DiscrepancyCategoryLkup=LMDiscrepancy.CMN_LookupMasterId And LMDiscrepancy.CMN_LookupTypeRef = 6
	LEFT JOIN CMN_LookupMaster LMDiscType with(nolock) ON GQ.DiscrepancyTypeLkup=LMDiscType.CMN_LookupMasterId And 	LMDiscType.CMN_LookupTypeRef = 7
	LEFT JOIN CMN_LookupMaster LMDiscSource with(nolock) ON GQ.DiscrepancySourceLkup=LMDiscSource.CMN_LookupMasterId And LMDiscSource.CMN_LookupTypeRef =13	
	LEFT JOIN CMN_LookupMaster LMStatus with(nolock) ON GQ.MostRecentStatusLkup=LMStatus.CMN_LookupMasterId And LMStatus.CMN_LookupTypeRef = 20
	LEFT JOIN CMN_LookupMaster LMQueue with(nolock) ON GQ.MostRecentWorkQueueLkup=LMQueue.CMN_LookupMasterId And LMQueue.CMN_LookupTypeRef = 10
	LEFT JOIN CMN_LookupMaster LMAction with(nolock) ON GQ.MostRecentActionLkup=LMAction.CMN_LookupMasterId  And LMAction.CMN_LookupTypeRef = 28
	LEFT JOIN CMN_LookupMasterCorrelations LMQueueType with(nolock) ON GQ.MostRecentWorkQueueLkup=LMQueueType.CMN_LookupMasterChildRef AND LMQueueType.CMN_LookupTypeCorrelationsRef=3
	LEFT JOIN CMN_LookupMaster LMQueueProgType with(nolock) ON LMQueueType.GroupingLookupMasterRef=LMQueueProgType.CMN_LookupMasterId AND LMQueueProgType.CMN_LookupTypeRef = 9
	LEFT JOIN CMN_LookupMaster LMContractId with(nolock) ON GQ.MemberContractIDLkup=LMContractId.CMN_LookupMasterId And LMContractId.CMN_LookupTypeRef = 11
	LEFT JOIN CMN_LookupMaster LMPBPId with(nolock) ON GQ.MemberPBPLkup=LMPBPId.CMN_LookupMasterId And LMPBPId.CMN_LookupTypeRef = 12
	LEFT JOIN CMN_LookupMaster LMLOBId with(nolock) ON GQ.MemberLOBLkup=LMLOBId.CMN_LookupMasterId And LMLOBId.CMN_LookupTypeRef = 31
	LEFT JOIN CMN_LookupMaster LMResolution with(nolock) ON GOST.ResolutionLkup=LMResolution.CMN_LookupMasterId And LMResolution.CMN_LookupTypeRef = 18
	LEFT JOIN CMN_LookupMaster LMOOALetterStatus with(nolock) ON GQ.OOALetterStatusLkup=LMOOALetterStatus.CMN_LookupMasterId And LMOOALetterStatus.CMN_LookupTypeRef = 53
	LEFT JOIN CMN_LookupMaster LMCTranStatus with(nolock) ON GQ.CMSTransactionStatusLkup=LMCTranStatus.CMN_LookupMasterId And LMCTranStatus.CMN_LookupTypeRef = 55
	INNER JOIN ADM_UserMaster UMC with(nolock) ON GQ.CreatedByRef=UMC.ADM_UserMasterId
	INNER JOIN ADM_UserMaster UML with(nolock) ON GQ.LastUpdatedByRef=UML.ADM_UserMasterId
	LEFT JOIN ADM_UserMaster UMLock with(nolock) ON GQ.LockedByRef=UMLock.ADM_UserMasterId
	LEFT JOIN ADM_UserMaster UMAssign with(nolock) ON GQ.AssignedToRef=UMAssign.ADM_UserMasterId
	LEFT JOIN ADM_UserMaster UMPended with(nolock) ON GQ.PendedbyRef=UMPended.ADM_UserMasterId
	LEFT JOIN CMN_RecordsLocked RL with(nolock) ON RL.CaseId=GQ.GEN_QueueId AND RL.ScreenLkup = 37010 AND RL.IsActive=1
	Where	
	GQ.DiscrepancyCategoryLkup=@DiscrepancyCategoryLkup
	AND (GQ.ComplianceStartDateId>=@ComplianceStartDateId)
	AND (GQ.ComplianceStartDateId<=@ComplianceEndDateId )
	AND GQ.DiscrepancyTypeLkup=@DiscrepancyTypeLkup
	AND GQ.IsActive=1
	AND (@IsUnlock IS NULL OR @IsUnlock = 0 OR (@IsUnlock = 1 AND GQ.LockedByRef is not null AND GQ.UTCLockedOn < DATEADD(hh,-1,GETUTCDATE())))	
	AND (@IsReAssign IS NULL OR @IsReAssign = 0 OR (@IsReAssign = 1 AND GQ.LockedByRef is null AND ((GQ.AssignedToRef IS NOT NULL AND GQ.MostRecentWorkQueueLkup = 10074) OR (GQ.PendedbyRef IS NOT NULL AND GQ.MostRecentWorkQueueLkup = 10081))))
	AND (@IsRestricted = 1 OR (@IsRestricted = 0 AND (GQ.IsRestricted = 0 OR GQ.IsRestricted IS NULL)))

	SELECT DISTINCT COUNT(*) AS TotalRecords
      ,COUNT(CASE WHEN (IsRestricted=1)  THEN 1 END) AS RestrictedRecords
	  ,COUNT(CASE WHEN (IsRestricted=0 OR IsRestricted IS NULL)  THEN 1 END) AS UnRestrictedRecords
	From GEN_Queue GQ with(nolock)
	LEFT JOIN GEN_OSTActions GOST with(nolock) ON GQ.GEN_QueueId=GOST.GEN_QueueRef
	LEFT JOIN CMN_RecordsLocked RL with(nolock) ON RL.CaseId=GQ.GEN_QueueId AND RL.ScreenLkup = 37010 AND RL.IsActive=1
	Where
	GQ.DiscrepancyCategoryLkup=@DiscrepancyCategoryLkup
	AND (GQ.ComplianceStartDateId>=@ComplianceStartDateId)
	AND (GQ.ComplianceStartDateId<=@ComplianceEndDateId )
	AND GQ.DiscrepancyTypeLkup=@DiscrepancyTypeLkup
	AND GQ.IsActive=1
	AND (@IsUnlock IS NULL OR @IsUnlock = 0 OR (@IsUnlock = 1 AND GQ.LockedByRef is not null AND GQ.UTCLockedOn < DATEADD(hh,-1,GETUTCDATE())))	
	AND (@IsReAssign IS NULL OR @IsReAssign = 0 OR (@IsReAssign = 1 AND GQ.LockedByRef is null AND ((GQ.AssignedToRef IS NOT NULL AND GQ.MostRecentWorkQueueLkup = 10074) OR (GQ.PendedbyRef IS NOT NULL AND GQ.MostRecentWorkQueueLkup = 10081))))
End
Else
Begin
Select DISTINCT TOP (@TopCount)
	GEN_QueueId as WorkItemID,
	[dbo].[GetAge](GQ.[GEN_QueueId]) AS Aging,
	GQ.MemberSCCCode as MemberSCCCode,
	GQ.MemberID as MemberID,
	GQ.MemberMedicareId as MemberCurrentHICN,
	GQ.GPSHouseholdID as GPSHouseholdID,
	GQ.MemberFirstName as MemberFirstName,
	GQ.MemberMiddleName as MemberMiddleName,
	GQ.MemberLastName as MemberLastName,
	LMContractId.LookupValue as MemberContractID,
	GQ.MemberDOB as MemberDOB,
	LMPBPId.LookupValue as MemberPBP,
	LMLOBId.LookupValue as MemberLOB,
	NULL as MemberGender,
	LMDiscType.LookupValue as DiscrepancyType,
	GQ.MostRecentStatusLkup,
	LMStatus.LookupValue as MostRecentStatus,
	GQ.MostRecentWorkQueueLkup,
	LMQueue.LookupValue as MostRecentQueue,
	LMQueueType.GroupingLookupMasterRef as QueueProgressTypeLkup,
	LMQueueProgType.LookupValue as QueueProgressType,
	LMAction.LookupValue as MostRecentAction,
	GQ.MemberMedicareId as CurrentHICN,
	GQ.EligGPSCurrentHICN as GPSHICN,
	GQ.EligMMRCurrentHICN as MMRHICN,
	LMWorkBasket.LookupValue as BusinessSegment,
	GQ.BusinessSegmentLkup, 
	LMDiscrepancy.LookupValue as DiscrepancyCategory,
	GQ.DiscrepancyCategoryLkup, 
	GQ.DiscrepancyStartDate as DiscrepancyStartDate,
	GQ.DiscrepancyEndDate as DiscrepancyEndDate,
	GOST.Reason as Reason,
	LMResolution.LookupValue as Resolution,
	GQ.ReferencedEligibilityCaseInd as ReferencedEligibilityCaseIndicator,
	NULL as MMRPBP,
	NULL as GPSIndividualID,
	LMDiscSource.LookupValue as DiscrepancySource,
	NULL as SubmissionType,
	NULL as CTMMember,
	NULL as EGHPMember,
	NULL as RequestedEffectiveDate,
	NULL as ActionRequested,
	NULL as PotentialSubmissionDate,
	NULL as RPCSubmissionDate,
	NULL as FDRReceivedDate,
	NULL as FDRCodeReceived,
	NULL as FDRStatus,
	NULL as RPRRequestor,
	GQ.ComplianceStartDate as ComplianceStartDate,
	GOST.AdjustedComplianceStartDate as AdjustedComplianceStartDate,
	GQ.UTCCreatedOn,
	GQ.CreatedByRef,
	UMC.FullName as CreatedBy,
	GQ.UTCLastUpdatedOn,
	GQ.LastUpdatedByRef,
	UML.FullName as LastUpdatedBy,
	GQ.LockedByRef,
	GQ.UTCLockedOn,
	UMLock.FullName as LockedBy,
	GQ.AssignedToRef,
	GQ.UTCAssignedOn,
	UMAssign.FullName as AssignedTo,
	GQ.PendedbyRef,
	GQ.UTCPendedOn,
	UMPended.FullName as PendedBy,
	GQ.OOALetterStatusLkup,
	LMOOALetterStatus.LookupValue as OOALetterStatus,
	GQ.CMSTransactionStatusLkup,
	LMCTranStatus.LookupValue as CMSTransactionStatus,
    GQ.MemberVerifiedState,GQ.MemberVerifiedCountyCode
	From GEN_Queue GQ with(nolock)
	LEFT JOIN GEN_OSTActions GOST with(nolock) ON GQ.GEN_QueueId=GOST.GEN_QueueRef
	LEFT JOIN CMN_LookupMaster LMWorkBasket with(nolock) ON GQ.BusinessSegmentLkup=LMWorkBasket.CMN_LookupMasterId And LMWorkBasket.CMN_LookupTypeRef = 1
	LEFT JOIN CMN_LookupMaster LMDiscrepancy with(nolock) ON GQ.DiscrepancyCategoryLkup=LMDiscrepancy.CMN_LookupMasterId And LMDiscrepancy.CMN_LookupTypeRef = 6
	LEFT JOIN CMN_LookupMaster LMDiscType with(nolock) ON GQ.DiscrepancyTypeLkup=LMDiscType.CMN_LookupMasterId And 	LMDiscType.CMN_LookupTypeRef = 7
	LEFT JOIN CMN_LookupMaster LMDiscSource with(nolock) ON GQ.DiscrepancySourceLkup=LMDiscSource.CMN_LookupMasterId And LMDiscSource.CMN_LookupTypeRef =13	
	LEFT JOIN CMN_LookupMaster LMStatus with(nolock) ON GQ.MostRecentStatusLkup=LMStatus.CMN_LookupMasterId And LMStatus.CMN_LookupTypeRef = 20
	LEFT JOIN CMN_LookupMaster LMQueue with(nolock) ON GQ.MostRecentWorkQueueLkup=LMQueue.CMN_LookupMasterId And LMQueue.CMN_LookupTypeRef = 10
	LEFT JOIN CMN_LookupMaster LMAction with(nolock) ON GQ.MostRecentActionLkup=LMAction.CMN_LookupMasterId  And LMAction.CMN_LookupTypeRef = 28
	LEFT JOIN CMN_LookupMasterCorrelations LMQueueType with(nolock) ON GQ.MostRecentWorkQueueLkup=LMQueueType.CMN_LookupMasterChildRef AND LMQueueType.CMN_LookupTypeCorrelationsRef=3
	LEFT JOIN CMN_LookupMaster LMQueueProgType with(nolock) ON LMQueueType.GroupingLookupMasterRef=LMQueueProgType.CMN_LookupMasterId AND LMQueueProgType.CMN_LookupTypeRef = 9
	LEFT JOIN CMN_LookupMaster LMContractId with(nolock) ON GQ.MemberContractIDLkup=LMContractId.CMN_LookupMasterId And LMContractId.CMN_LookupTypeRef = 11
	LEFT JOIN CMN_LookupMaster LMPBPId with(nolock) ON GQ.MemberPBPLkup=LMPBPId.CMN_LookupMasterId And LMPBPId.CMN_LookupTypeRef = 12
	LEFT JOIN CMN_LookupMaster LMLOBId with(nolock) ON GQ.MemberLOBLkup=LMLOBId.CMN_LookupMasterId And LMLOBId.CMN_LookupTypeRef = 31
	LEFT JOIN CMN_LookupMaster LMResolution with(nolock) ON GOST.ResolutionLkup=LMResolution.CMN_LookupMasterId And LMResolution.CMN_LookupTypeRef = 18
	LEFT JOIN CMN_LookupMaster LMOOALetterStatus with(nolock) ON GQ.OOALetterStatusLkup=LMOOALetterStatus.CMN_LookupMasterId And LMOOALetterStatus.CMN_LookupTypeRef = 53
	LEFT JOIN CMN_LookupMaster LMCTranStatus with(nolock) ON GQ.CMSTransactionStatusLkup=LMCTranStatus.CMN_LookupMasterId And LMCTranStatus.CMN_LookupTypeRef = 55
	INNER JOIN ADM_UserMaster UMC with(nolock) ON GQ.CreatedByRef=UMC.ADM_UserMasterId
	INNER JOIN ADM_UserMaster UML with(nolock) ON GQ.LastUpdatedByRef=UML.ADM_UserMasterId
	LEFT JOIN ADM_UserMaster UMLock with(nolock) ON GQ.LockedByRef=UMLock.ADM_UserMasterId
	LEFT JOIN ADM_UserMaster UMAssign with(nolock) ON GQ.AssignedToRef=UMAssign.ADM_UserMasterId
	LEFT JOIN ADM_UserMaster UMPended with(nolock) ON GQ.PendedbyRef=UMPended.ADM_UserMasterId
	LEFT JOIN CMN_RecordsLocked RL with(nolock) ON RL.CaseId=GQ.GEN_QueueId AND RL.ScreenLkup = 37010 AND RL.IsActive=1
	Where
	(@WorkItemId Is Null OR GQ.GEN_QueueId=@WorkItemId)
	AND GQ.IsActive=1
	AND (GOST.GEN_OSTActionsId IS NULL OR GOST.IsActive=1)
	AND (@IsUnlock IS NULL OR @IsUnlock = 0 OR (@IsUnlock = 1 AND GQ.LockedByRef is not null AND GQ.UTCLockedOn < DATEADD(hh,-1,GETUTCDATE())))
	AND (@IsReAssign IS NULL OR @IsReAssign = 0 OR (@IsReAssign = 1 AND GQ.LockedByRef is null AND (((@DiscrepancyCategoryLkup IS NULL AND GQ.AssignedToRef IS NOT NULL AND GQ.MostRecentWorkQueueLkup in (10094,10095,10096)) OR (@DiscrepancyCategoryLkup IS NOT NULL AND GQ.AssignedToRef IS NOT NULL AND GQ.MostRecentWorkQueueLkup = CASE WHEN @DiscrepancyCategoryLkup = 6001 THEN 10094 ELSE (CASE WHEN @DiscrepancyCategoryLkup = 6002 THEN 10095 ELSE (CASE WHEN @DiscrepancyCategoryLkup = 6003 THEN 10095 END) END) END)) OR 
		((@DiscrepancyCategoryLkup IS NULL AND GQ.PendedbyRef IS NOT NULL AND GQ.MostRecentWorkQueueLkup in (10010,10025,10090)) OR (@DiscrepancyCategoryLkup IS NOT NULL AND GQ.PendedbyRef IS NOT NULL AND GQ.MostRecentWorkQueueLkup = CASE WHEN @DiscrepancyCategoryLkup = 6001 THEN 10010 ELSE (CASE WHEN @DiscrepancyCategoryLkup = 6002 THEN 10025 ELSE (CASE WHEN @DiscrepancyCategoryLkup = 6003 THEN 10090 END) END) END)))))
	AND (@IsMassUpdate IS NULL OR @IsMassUpdate =0 OR (@IsMassUpdate =1 AND GQ.LockedByRef is null AND GQ.UTCLockedOn IS NULL AND (GQ.OOALetterStatusLkup IS NULL OR  GQ.OOALetterStatusLkup = 53003)))
	AND (@BusinessSegmentLkup IS NULL OR GQ.BusinessSegmentLkup=@BusinessSegmentLkup)
	AND (@WorkBasketLkup IS NULL OR GQ.WorkBasketLkup=@WorkBasketLkup)
	AND (@DiscrepancyCategoryLkup Is Null OR GQ.DiscrepancyCategoryLkup=@DiscrepancyCategoryLkup)
	AND (@DiscrepancyTypeLkup Is Null OR GQ.DiscrepancyTypeLkup=@DiscrepancyTypeLkup)
	AND (@DiscrepancyTypeLkupNot Is Null OR GQ.DiscrepancyTypeLkup!=@DiscrepancyTypeLkupNot)
	AND (@DiscrepancySourceLkup Is Null OR GQ.DiscrepancySourceLkup=@DiscrepancySourceLkup)
	AND (@LOBLkup Is Null OR GQ.MemberLOBLkup=@LOBLkup )
	AND (@AssignedTo Is Null OR GQ.AssignedToRef=@AssignedTo)
	AND (@Queue Is Null OR GQ.MostRecentWorkQueueLkup=@Queue)
	AND (@GPSHouseholdId Is Null OR GQ.GPSHouseholdID=@GPSHouseholdId)
	AND (@CurrentHICN Is Null OR GQ.MemberCurrentHICN = @CurrentHICN OR GQ.EligGPSCurrentHICN = @CurrentHICN OR GQ.EligMMRCurrentHICN = @CurrentHICN OR GQ.[MemberMedicareId] = @CurrentHICN)
	AND (@ContractIDLkup Is Null OR GQ.MemberContractIDLkup =@ContractIDLkup OR GQ.EligGPSContractIDLkup =@ContractIDLkup OR GQ.EligMMRContractIDLkup = @ContractIDLkup)
	AND (@PBPLkup Is Null OR GQ.MemberPBPLkup =@PBPLkup OR GQ.EligGPSPBPLkup =@PBPLkup OR GQ.EligMMRPBPLkup = @PBPLkup)
	AND (@Status Is Null OR GQ.MostRecentStatusLkup=@Status) AND (@StatusNot IS NULL OR GQ.MostRecentStatusLkup !=@StatusNot)
	AND (@MemberSCCCode Is Null OR GQ.MemberSCCCode=@MemberSCCCode)
	AND (@FirstName  Is Null OR GQ.MemberFirstName like '%'+@FirstName+'%' )
	AND (@LastName  Is Null OR GQ.MemberLastName like '%'+@LastName+'%' )
	AND (@DOBId Is Null OR GQ.MemberDOBId=@DOBId)
	AND (@DiscrepancyStartDateId Is Null OR GQ.DiscrepancyStartDateId>=@DiscrepancyStartDateId)
	AND (@DiscrepancyEndDateId Is Null OR GQ.DiscrepancyStartDateId<=@DiscrepancyEndDateId)
	AND (@ComplianceStartDateId Is Null OR ((GOST.AdjustedComplianceStartDateId IS NULL AND GQ.ComplianceStartDateId>=@ComplianceStartDateId) OR (GOST.AdjustedComplianceStartDateId IS NOT NULL AND GOST.AdjustedComplianceStartDateId >=@ComplianceStartDateId)))
	AND (@ComplianceEndDateId Is Null OR ((GOST.AdjustedComplianceStartDateId IS NULL AND GQ.ComplianceStartDateId<=@ComplianceEndDateId) OR(GOST.AdjustedComplianceStartDateId IS NOT NULL AND GOST.AdjustedComplianceStartDateId<=@ComplianceEndDateId)))	
	AND (@CaseCreationStartDateId Is Null OR GQ.UTCCreatedOnId>=@CaseCreationStartDateId)
	AND (@CaseCreationEndDateId Is Null OR GQ.UTCCreatedOnId<=@CaseCreationEndDateId)
	AND (@CaseLastUpdatedStartDateId Is Null OR GQ.UTCLastUpdatedOnId>=@CaseLastUpdatedStartDateId)
	AND (@CaseLastUpdatedEndDateId Is Null OR GQ.UTCLastUpdatedOnId<=@CaseLastUpdatedEndDateId)
	AND (@CaseAgeFrom  Is Null OR Aging>=@CaseAgeFrom)
	AND (@CaseAgeTo Is Null OR Aging<=@CaseAgeTo)
	AND (@PendReason Is Null OR GOST.PendReasonLkup=@PendReason)
	AND (@Resolution Is Null OR GOST.ResolutionLkup=@Resolution)	
	AND (@LastUpdatedOperator Is Null OR GQ.LastUpdatedByRef=@LastUpdatedOperator)
	AND (@FirstLetterMailStartDateId Is Null OR (@FirstLetterMailStartDateId Is NOT Null AND GOST.FirstLetterMailDateId>=@FirstLetterMailStartDateId ))
	AND (@FirstLetterMailEndDateId Is Null OR (@FirstLetterMailEndDateId Is NOT Null AND GOST.FirstLetterMailDateId<=@FirstLetterMailEndDateId ))
	AND (@SecondLetterMailStartDateId Is Null OR (@SecondLetterMailStartDateId Is NOT Null AND GOST.SecondLetterMailDateId>=@SecondLetterMailStartDateId ))
	AND (@SecondLetterMailEndDateId Is Null OR  (@SecondLetterMailEndDateId Is NOT Null AND GOST.SecondLetterMailDateId<=@SecondLetterMailEndDateId))
	AND (@MemberResponseVerificationStartDateId Is Null OR GOST.MemberResponseVerificationDateId>=@MemberResponseVerificationStartDateId )
	AND (@MemberResponseVerificationEndDateId Is Null OR  GOST.MemberResponseVerificationDateId<=@MemberResponseVerificationEndDateId )
	AND (@PeerAuditCompletionStartDateId Is Null OR GQ.PeerAuditCompletedDateId >= @PeerAuditCompletionStartDateId)
	AND (@PeerAuditCompletionEndDateId Is Null OR GQ.PeerAuditCompletedDateId <= @PeerAuditCompletionEndDateId)
	AND (@IsRestricted = 1 OR (@IsRestricted = 0 AND (GQ.IsRestricted = 0 OR GQ.IsRestricted IS NULL)))
	And (@TransactionReplyCode Is Null OR GQ.[TRCLkup] = @TransactionReplyCode)
    AND (@MemberVerifiedState Is Null OR GQ.MemberVerifiedState=@MemberVerifiedState)
	AND (@MemberVerifiedCountryCode Is Null OR GQ.MemberVerifiedCountyCode=@MemberVerifiedCountryCode)
	AND (@PDPAutoEnrolleeInd Is Null OR (GOST.PDPAutoEnrolleeInd =@PDPAutoEnrolleeInd ))

SELECT DISTINCT COUNT(*) AS TotalRecords
      ,COUNT(CASE WHEN (IsRestricted=1)  THEN 1 END) AS RestrictedRecords
	  ,COUNT(CASE WHEN (IsRestricted=0 OR IsRestricted IS NULL)  THEN 1 END) AS UnRestrictedRecords
	From GEN_Queue GQ with(nolock)
	LEFT JOIN GEN_OSTActions GOST with(nolock) ON GQ.GEN_QueueId=GOST.GEN_QueueRef
	LEFT JOIN CMN_RecordsLocked RL with(nolock) ON RL.CaseId=GQ.GEN_QueueId AND RL.ScreenLkup = 37010 AND RL.IsActive=1
	Where
	(@WorkItemId Is Null OR GQ.GEN_QueueId=@WorkItemId)
	AND GQ.IsActive=1
	AND (GOST.GEN_OSTActionsId IS NULL OR GOST.IsActive=1)
	AND (@IsUnlock IS NULL OR @IsUnlock = 0 OR (@IsUnlock = 1 AND GQ.LockedByRef is not null AND GQ.UTCLockedOn < DATEADD(hh,-1,GETUTCDATE())))
	AND (@IsReAssign IS NULL OR @IsReAssign = 0 OR (@IsReAssign = 1 AND GQ.LockedByRef is null AND (((@DiscrepancyCategoryLkup IS NULL AND GQ.AssignedToRef IS NOT NULL AND GQ.MostRecentWorkQueueLkup in (10094,10095,10096)) OR (@DiscrepancyCategoryLkup IS NOT NULL AND GQ.AssignedToRef IS NOT NULL AND GQ.MostRecentWorkQueueLkup = CASE WHEN @DiscrepancyCategoryLkup = 6001 THEN 10094 ELSE (CASE WHEN @DiscrepancyCategoryLkup = 6002 THEN 10095 ELSE (CASE WHEN @DiscrepancyCategoryLkup = 6003 THEN 10095 END) END) END)) OR 
		((@DiscrepancyCategoryLkup IS NULL AND GQ.PendedbyRef IS NOT NULL AND GQ.MostRecentWorkQueueLkup in (10010,10025,10090)) OR (@DiscrepancyCategoryLkup IS NOT NULL AND GQ.PendedbyRef IS NOT NULL AND GQ.MostRecentWorkQueueLkup = CASE WHEN @DiscrepancyCategoryLkup = 6001 THEN 10010 ELSE (CASE WHEN @DiscrepancyCategoryLkup = 6002 THEN 10025 ELSE (CASE WHEN @DiscrepancyCategoryLkup = 6003 THEN 10090 END) END) END)))))
	AND (@IsMassUpdate IS NULL OR @IsMassUpdate =0 OR (@IsMassUpdate =1 AND GQ.LockedByRef is null AND GQ.UTCLockedOn IS NULL AND (GQ.OOALetterStatusLkup IS NULL OR  GQ.OOALetterStatusLkup = 53003)))
	AND (@BusinessSegmentLkup IS NULL OR GQ.BusinessSegmentLkup=@BusinessSegmentLkup)
	AND (@WorkBasketLkup IS NULL OR GQ.WorkBasketLkup=@WorkBasketLkup)
	AND (@DiscrepancyCategoryLkup Is Null OR GQ.DiscrepancyCategoryLkup=@DiscrepancyCategoryLkup)
	AND (@DiscrepancyTypeLkup Is Null OR GQ.DiscrepancyTypeLkup=@DiscrepancyTypeLkup)
	AND (@DiscrepancyTypeLkupNot Is Null OR GQ.DiscrepancyTypeLkup!=@DiscrepancyTypeLkupNot)
	AND (@DiscrepancySourceLkup Is Null OR GQ.DiscrepancySourceLkup=@DiscrepancySourceLkup)
	AND (@LOBLkup Is Null OR GQ.MemberLOBLkup=@LOBLkup )
	AND (@AssignedTo Is Null OR GQ.AssignedToRef=@AssignedTo)
	AND (@Queue Is Null OR GQ.MostRecentWorkQueueLkup=@Queue)
	AND (@GPSHouseholdId Is Null OR GQ.GPSHouseholdID=@GPSHouseholdId)
	AND (@CurrentHICN Is Null OR GQ.MemberCurrentHICN = @CurrentHICN OR GQ.EligGPSCurrentHICN = @CurrentHICN OR GQ.EligMMRCurrentHICN = @CurrentHICN OR GQ.[MemberMedicareId] = @CurrentHICN)
	AND (@ContractIDLkup Is Null OR GQ.MemberContractIDLkup =@ContractIDLkup OR GQ.EligGPSContractIDLkup =@ContractIDLkup OR GQ.EligMMRContractIDLkup = @ContractIDLkup)
	AND (@PBPLkup Is Null OR GQ.MemberPBPLkup =@PBPLkup OR GQ.EligGPSPBPLkup =@PBPLkup OR GQ.EligMMRPBPLkup = @PBPLkup)
	AND (@Status Is Null OR GQ.MostRecentStatusLkup=@Status) AND (@StatusNot IS NULL OR GQ.MostRecentStatusLkup !=@StatusNot)
	AND (@MemberSCCCode Is Null OR GQ.MemberSCCCode=@MemberSCCCode)
	AND (@FirstName  Is Null OR GQ.MemberFirstName like '%'+@FirstName+'%' )
	AND (@LastName  Is Null OR GQ.MemberLastName like '%'+@LastName+'%' )
	AND (@DOBId Is Null OR GQ.MemberDOBId=@DOBId)
	AND (@DiscrepancyStartDateId Is Null OR GQ.DiscrepancyStartDateId>=@DiscrepancyStartDateId)
	AND (@DiscrepancyEndDateId Is Null OR GQ.DiscrepancyStartDateId<=@DiscrepancyEndDateId)
	AND (@ComplianceStartDateId Is Null OR ((GOST.AdjustedComplianceStartDateId IS NULL AND GQ.ComplianceStartDateId>=@ComplianceStartDateId) OR (GOST.AdjustedComplianceStartDateId IS NOT NULL AND GOST.AdjustedComplianceStartDateId >=@ComplianceStartDateId)))
	AND (@ComplianceEndDateId Is Null OR ((GOST.AdjustedComplianceStartDateId IS NULL AND GQ.ComplianceStartDateId<=@ComplianceEndDateId) OR(GOST.AdjustedComplianceStartDateId IS NOT NULL AND GOST.AdjustedComplianceStartDateId<=@ComplianceEndDateId)))	
	AND (@CaseCreationStartDateId Is Null OR GQ.UTCCreatedOnId>=@CaseCreationStartDateId)
	AND (@CaseCreationEndDateId Is Null OR GQ.UTCCreatedOnId<=@CaseCreationEndDateId)
	AND (@CaseLastUpdatedStartDateId Is Null OR GQ.UTCLastUpdatedOnId>=@CaseLastUpdatedStartDateId)
	AND (@CaseLastUpdatedEndDateId Is Null OR GQ.UTCLastUpdatedOnId<=@CaseLastUpdatedEndDateId)
	AND (@CaseAgeFrom  Is Null OR Aging>=@CaseAgeFrom)
	AND (@CaseAgeTo Is Null OR Aging<=@CaseAgeTo)
	AND (@PendReason Is Null OR GOST.PendReasonLkup=@PendReason)
	AND (@Resolution Is Null OR GOST.ResolutionLkup=@Resolution)	
	AND (@LastUpdatedOperator Is Null OR GQ.LastUpdatedByRef=@LastUpdatedOperator)
	AND (@FirstLetterMailStartDateId Is Null OR GOST.FirstLetterMailDateId>=@FirstLetterMailStartDateId )
	AND (@FirstLetterMailEndDateId Is Null OR GOST.FirstLetterMailDateId<=@FirstLetterMailEndDateId )
	AND (@SecondLetterMailStartDateId Is Null OR GOST.SecondLetterMailDateId>=@SecondLetterMailStartDateId )
	AND (@SecondLetterMailEndDateId Is Null OR  GOST.SecondLetterMailDateId<=@SecondLetterMailEndDateId)
	AND (@MemberResponseVerificationStartDateId Is Null OR GOST.MemberResponseVerificationDateId>=@MemberResponseVerificationStartDateId )
	AND (@MemberResponseVerificationEndDateId Is Null OR  GOST.MemberResponseVerificationDateId<=@MemberResponseVerificationEndDateId )
	AND (@PeerAuditCompletionStartDateId Is Null OR GQ.PeerAuditCompletedDateId >= @PeerAuditCompletionStartDateId)
	AND (@PeerAuditCompletionEndDateId Is Null OR GQ.PeerAuditCompletedDateId <= @PeerAuditCompletionEndDateId)
	And (@TransactionReplyCode Is Null OR GQ.[TRCLkup] = @TransactionReplyCode)
	AND (@MemberVerifiedState Is Null OR GQ.MemberVerifiedState=@MemberVerifiedState)
	AND (@MemberVerifiedCountryCode Is Null OR GQ.MemberVerifiedCountyCode=@MemberVerifiedCountryCode)
	AND (@PDPAutoEnrolleeInd Is Null OR (GOST.PDPAutoEnrolleeInd =@PDPAutoEnrolleeInd ))
End

END


ELSE IF @PageType IS NOT NULL AND @PageType=3002--Eligibility
BEGIN
IF(@IsERSIdSelected = 1)
Begin
Select DISTINCT TOP (@TopCount)
	GEN_QueueId as WorkItemID,
	[dbo].[GetAge](GQ.[GEN_QueueId]) AS Aging,
	GQ.MemberSCCCode as MemberSCCCode,
	GQ.MemberID as MemberID,
	GQ.MemberMedicareId as MemberCurrentHICN,
	GQ.GPSHouseholdID as GPSHouseholdID,
	GQ.MemberFirstName as MemberFirstName,
	GQ.MemberMiddleName as MemberMiddleName,
	GQ.MemberLastName as MemberLastName,
	LMContractId.LookupValue as MemberContractID,
	GQ.MemberDOB as MemberDOB,
	LMPBPId.LookupValue as MemberPBP,
	LMLOBId.LookupValue as MemberLOB,
	LMGender.LookupValue as MemberGender,
	LMDiscType.LookupValue as DiscrepancyType,
	GQ.MostRecentStatusLkup,
	LMStatus.LookupValue as MostRecentStatus,
	GQ.MostRecentWorkQueueLkup,	
	LMQueue.LookupValue as MostRecentQueue,
	LMQueueType.GroupingLookupMasterRef as QueueProgressTypeLkup,
	LMQueueProgType.LookupValue as QueueProgressType,
	LMAction.LookupValue as MostRecentAction,
	GQ.MemberMedicareId as CurrentHICN,
	GQ.EligGPSCurrentHICN as GPSHICN,
	GQ.EligMMRCurrentHICN as MMRHICN,
	LMWorkBasket.LookupValue as BusinessSegment,
	GQ.BusinessSegmentLkup, 
	LMDiscrepancy.LookupValue as DiscrepancyCategory,
	GQ.DiscrepancyCategoryLkup, 
	GQ.DiscrepancyStartDate as DiscrepancyStartDate,
	GQ.DiscrepancyEndDate as DiscrepancyEndDate,
	GEligibility.Reason as Reason,
	LMResolution.LookupValue as Resolution,
	GQ.ReferencedEligibilityCaseInd as ReferencedEligibilityCaseIndicator,
	LMMMRPBP.LookupValue as MMRPBP,
	NULL as GPSIndividualID,
	LMDiscSource.LookupValue as DiscrepancySource,
	NULL as SubmissionType,
	NULL as CTMMember,
	NULL as EGHPMember,
	NULL as RequestedEffectiveDate,
	NULL as ActionRequested,
	NULL as PotentialSubmissionDate,
	NULL as RPCSubmissionDate,
	NULL as FDRReceivedDate,
	NULL as FDRCodeReceived,
	NULL as FDRStatus,
	NULL as RPRRequestor,
	GQ.ComplianceStartDate as ComplianceStartDate,
	NULL as AdjustedComplianceStartDate,
	GQ.UTCCreatedOn,
	GQ.CreatedByRef,
	UMC.FullName as CreatedBy,
	GQ.UTCLastUpdatedOn,
	GQ.LastUpdatedByRef,
	UML.FullName as LastUpdatedBy,
	GQ.LockedByRef,
	GQ.UTCLockedOn,
	UMLock.FullName as LockedBy,
	GQ.AssignedToRef,
	GQ.UTCAssignedOn,
	UMAssign.FullName as AssignedTo,
	GQ.PendedbyRef,
	GQ.UTCPendedOn,
	UMPended.FullName as PendedBy,
	NULL as OOALetterStatusLkup,
	NULL as OOALetterStatus,
	GQ.CMSTransactionStatusLkup,
	LMCTranStatus.LookupValue as CMSTransactionStatus
	From GEN_Queue GQ with(nolock)
	LEFT JOIN GEN_EligibilityActions GEligibility with(nolock) ON GQ.GEN_QueueId=GEligibility.GEN_QueueRef
	LEFT JOIN CMN_LookupMaster LMWorkBasket with(nolock) ON GQ.BusinessSegmentLkup=LMWorkBasket.CMN_LookupMasterId And LMWorkBasket.CMN_LookupTypeRef = 1
	LEFT JOIN CMN_LookupMaster LMDiscrepancy with(nolock) ON GQ.DiscrepancyCategoryLkup=LMDiscrepancy.CMN_LookupMasterId And LMDiscrepancy.CMN_LookupTypeRef = 6
	LEFT JOIN CMN_LookupMaster LMDiscType with(nolock) ON GQ.DiscrepancyTypeLkup=LMDiscType.CMN_LookupMasterId And LMDiscType.CMN_LookupTypeRef = 7
	LEFT JOIN CMN_LookupMaster LMStatus with(nolock) ON GQ.MostRecentStatusLkup=LMStatus.CMN_LookupMasterId And LMStatus.CMN_LookupTypeRef = 20
	LEFT JOIN CMN_LookupMaster LMQueue with(nolock) ON GQ.MostRecentWorkQueueLkup=LMQueue.CMN_LookupMasterId And LMQueue.CMN_LookupTypeRef = 10
	LEFT JOIN CMN_LookupMaster LMAction with(nolock) ON GQ.MostRecentActionLkup=LMAction.CMN_LookupMasterId And LMAction.CMN_LookupTypeRef = 28
	LEFT JOIN CMN_LookupMasterCorrelations LMQueueType with(nolock) ON GQ.MostRecentWorkQueueLkup=LMQueueType.CMN_LookupMasterChildRef AND LMQueueType.CMN_LookupTypeCorrelationsRef=3
	LEFT JOIN CMN_LookupMaster LMQueueProgType with(nolock) ON LMQueueType.GroupingLookupMasterRef=LMQueueProgType.CMN_LookupMasterId AND LMQueueProgType.CMN_LookupTypeRef = 9
	LEFT JOIN CMN_LookupMaster LMContractId with(nolock) ON GQ.MemberContractIDLkup=LMContractId.CMN_LookupMasterId And LMContractId.CMN_LookupTypeRef = 11
	LEFT JOIN CMN_LookupMaster LMPBPId with(nolock) ON GQ.MemberPBPLkup=LMPBPId.CMN_LookupMasterId And LMPBPId.CMN_LookupTypeRef = 12
	LEFT JOIN CMN_LookupMaster LMLOBId with(nolock) ON GQ.MemberLOBLkup=LMLOBId.CMN_LookupMasterId	And LMLOBId.CMN_LookupTypeRef = 31
	LEFT JOIN CMN_LookupMaster LMResolution with(nolock) ON GEligibility.ResolutionLkup=LMResolution.CMN_LookupMasterId And LMResolution.CMN_LookupTypeRef = 18
	LEFT JOIN CMN_LookupMaster LMMMRPBP with(nolock) ON GQ.EligMMRPBPLkup=LMMMRPBP.CMN_LookupMasterId 
	LEFT JOIN CMN_LookupMaster LMDiscSource with(nolock) ON GQ.DiscrepancySourceLkup=LMDiscSource.CMN_LookupMasterId And LMDiscSource.CMN_LookupTypeRef = 13
	LEFT JOIN CMN_LookupMaster LMGender with(nolock) ON GQ.MemberGenderLkup=LMGender.CMN_LookupMasterId And LMGender.CMN_LookupTypeRef = 21
	LEFT JOIN CMN_LookupMaster LMCTranStatus with(nolock) ON GQ.CMSTransactionStatusLkup=LMCTranStatus.CMN_LookupMasterId And LMCTranStatus.CMN_LookupTypeRef = 55
	INNER JOIN ADM_UserMaster UMC with(nolock) ON GQ.CreatedByRef=UMC.ADM_UserMasterId
	INNER JOIN ADM_UserMaster UML with(nolock) ON GQ.LastUpdatedByRef=UML.ADM_UserMasterId
	LEFT JOIN ADM_UserMaster UMLock with(nolock) ON GQ.LockedByRef=UMLock.ADM_UserMasterId
	LEFT JOIN ADM_UserMaster UMAssign with(nolock) ON GQ.AssignedToRef=UMAssign.ADM_UserMasterId
	LEFT JOIN ADM_UserMaster UMPended with(nolock) ON GQ.PendedbyRef=UMPended.ADM_UserMasterId	
	LEFT JOIN CMN_RecordsLocked RL with(nolock) ON RL.CaseId=GQ.GEN_QueueId AND RL.ScreenLkup = 37010 AND RL.IsActive=1
	Where
		GQ.GEN_QueueId=@WorkItemId
	AND GQ.IsActive=1
	AND (@IsUnlock IS NULL OR @IsUnlock = 0 OR (@IsUnlock = 1 AND GQ.LockedByRef is not null AND GQ.UTCLockedOn < DATEADD(hh,-1,GETUTCDATE())))	
	AND (@IsReAssign IS NULL OR @IsReAssign = 0 OR (@IsReAssign = 1 AND GQ.LockedByRef is null AND ((GQ.AssignedToRef IS NOT NULL AND GQ.MostRecentWorkQueueLkup = 10074) OR (GQ.PendedbyRef IS NOT NULL AND GQ.MostRecentWorkQueueLkup = 10081))))
	AND (@IsRestricted = 1 OR (@IsRestricted = 0 AND (GQ.IsRestricted = 0 OR GQ.IsRestricted IS NULL)))

	SELECT DISTINCT COUNT(*) AS TotalRecords
    ,COUNT(CASE WHEN (IsRestricted=1)  THEN 1 END) AS RestrictedRecords
	,COUNT(CASE WHEN (IsRestricted=0 OR IsRestricted IS NULL)  THEN 1 END) AS UnRestrictedRecords
	From GEN_Queue GQ with(nolock)
	LEFT JOIN GEN_EligibilityActions GEligibility with(nolock) ON GQ.GEN_QueueId=GEligibility.GEN_QueueRef
	LEFT JOIN CMN_RecordsLocked RL with(nolock) ON RL.CaseId=GQ.GEN_QueueId AND RL.ScreenLkup = 37010 AND RL.IsActive=1
	Where
	GQ.GEN_QueueId=@WorkItemId
	AND GQ.IsActive=1
	AND (@IsUnlock IS NULL OR @IsUnlock = 0 OR (@IsUnlock = 1 AND GQ.LockedByRef is not null AND GQ.UTCLockedOn < DATEADD(hh,-1,GETUTCDATE())))	
	AND (@IsReAssign IS NULL OR @IsReAssign = 0 OR (@IsReAssign = 1 AND GQ.LockedByRef is null AND ((GQ.AssignedToRef IS NOT NULL AND GQ.MostRecentWorkQueueLkup = 10074) OR (GQ.PendedbyRef IS NOT NULL AND GQ.MostRecentWorkQueueLkup = 10081))))
End
ELSE IF(@IsMedicareIdSelected =1)
Begin
Select DISTINCT TOP (@TopCount)
	GEN_QueueId as WorkItemID,
	[dbo].[GetAge](GQ.[GEN_QueueId]) AS Aging,
	GQ.MemberSCCCode as MemberSCCCode,
	GQ.MemberID as MemberID,
	GQ.MemberMedicareId as MemberCurrentHICN,
	GQ.GPSHouseholdID as GPSHouseholdID,
	GQ.MemberFirstName as MemberFirstName,
	GQ.MemberMiddleName as MemberMiddleName,
	GQ.MemberLastName as MemberLastName,
	LMContractId.LookupValue as MemberContractID,
	GQ.MemberDOB as MemberDOB,
	LMPBPId.LookupValue as MemberPBP,
	LMLOBId.LookupValue as MemberLOB,
	LMGender.LookupValue as MemberGender,
	LMDiscType.LookupValue as DiscrepancyType,
	GQ.MostRecentStatusLkup,
	LMStatus.LookupValue as MostRecentStatus,
	GQ.MostRecentWorkQueueLkup,	
	LMQueue.LookupValue as MostRecentQueue,
	LMQueueType.GroupingLookupMasterRef as QueueProgressTypeLkup,
	LMQueueProgType.LookupValue as QueueProgressType,
	LMAction.LookupValue as MostRecentAction,
	GQ.MemberMedicareId as CurrentHICN,
	GQ.EligGPSCurrentHICN as GPSHICN,
	GQ.EligMMRCurrentHICN as MMRHICN,
	LMWorkBasket.LookupValue as BusinessSegment,
	GQ.BusinessSegmentLkup, 
	LMDiscrepancy.LookupValue as DiscrepancyCategory,
	GQ.DiscrepancyCategoryLkup, 
	GQ.DiscrepancyStartDate as DiscrepancyStartDate,
	GQ.DiscrepancyEndDate as DiscrepancyEndDate,
	GEligibility.Reason as Reason,
	LMResolution.LookupValue as Resolution,
	GQ.ReferencedEligibilityCaseInd as ReferencedEligibilityCaseIndicator,
	LMMMRPBP.LookupValue as MMRPBP,
	NULL as GPSIndividualID,
	LMDiscSource.LookupValue as DiscrepancySource,
	NULL as SubmissionType,
	NULL as CTMMember,
	NULL as EGHPMember,
	NULL as RequestedEffectiveDate,
	NULL as ActionRequested,
	NULL as PotentialSubmissionDate,
	NULL as RPCSubmissionDate,
	NULL as FDRReceivedDate,
	NULL as FDRCodeReceived,
	NULL as FDRStatus,
	NULL as RPRRequestor,
	GQ.ComplianceStartDate as ComplianceStartDate,
	NULL as AdjustedComplianceStartDate,
	GQ.UTCCreatedOn,
	GQ.CreatedByRef,
	UMC.FullName as CreatedBy,
	GQ.UTCLastUpdatedOn,
	GQ.LastUpdatedByRef,
	UML.FullName as LastUpdatedBy,
	GQ.LockedByRef,
	GQ.UTCLockedOn,
	UMLock.FullName as LockedBy,
	GQ.AssignedToRef,
	GQ.UTCAssignedOn,
	UMAssign.FullName as AssignedTo,
	GQ.PendedbyRef,
	GQ.UTCPendedOn,
	UMPended.FullName as PendedBy,
	NULL as OOALetterStatusLkup,
	NULL as OOALetterStatus,
	GQ.CMSTransactionStatusLkup,
	LMCTranStatus.LookupValue as CMSTransactionStatus
	From GEN_Queue GQ with(nolock)
	LEFT JOIN GEN_EligibilityActions GEligibility with(nolock) ON GQ.GEN_QueueId=GEligibility.GEN_QueueRef
	LEFT JOIN CMN_LookupMaster LMWorkBasket with(nolock) ON GQ.BusinessSegmentLkup=LMWorkBasket.CMN_LookupMasterId And LMWorkBasket.CMN_LookupTypeRef = 1
	LEFT JOIN CMN_LookupMaster LMDiscrepancy with(nolock) ON GQ.DiscrepancyCategoryLkup=LMDiscrepancy.CMN_LookupMasterId And LMDiscrepancy.CMN_LookupTypeRef = 6
	LEFT JOIN CMN_LookupMaster LMDiscType with(nolock) ON GQ.DiscrepancyTypeLkup=LMDiscType.CMN_LookupMasterId And LMDiscType.CMN_LookupTypeRef = 7
	LEFT JOIN CMN_LookupMaster LMStatus with(nolock) ON GQ.MostRecentStatusLkup=LMStatus.CMN_LookupMasterId And LMStatus.CMN_LookupTypeRef = 20
	LEFT JOIN CMN_LookupMaster LMQueue with(nolock) ON GQ.MostRecentWorkQueueLkup=LMQueue.CMN_LookupMasterId And LMQueue.CMN_LookupTypeRef = 10
	LEFT JOIN CMN_LookupMaster LMAction with(nolock) ON GQ.MostRecentActionLkup=LMAction.CMN_LookupMasterId And LMAction.CMN_LookupTypeRef = 28
	LEFT JOIN CMN_LookupMasterCorrelations LMQueueType with(nolock) ON GQ.MostRecentWorkQueueLkup=LMQueueType.CMN_LookupMasterChildRef AND LMQueueType.CMN_LookupTypeCorrelationsRef=3
	LEFT JOIN CMN_LookupMaster LMQueueProgType with(nolock) ON LMQueueType.GroupingLookupMasterRef=LMQueueProgType.CMN_LookupMasterId AND LMQueueProgType.CMN_LookupTypeRef = 9
	LEFT JOIN CMN_LookupMaster LMContractId with(nolock) ON GQ.MemberContractIDLkup=LMContractId.CMN_LookupMasterId And LMContractId.CMN_LookupTypeRef = 11
	LEFT JOIN CMN_LookupMaster LMPBPId with(nolock) ON GQ.MemberPBPLkup=LMPBPId.CMN_LookupMasterId And LMPBPId.CMN_LookupTypeRef = 12
	LEFT JOIN CMN_LookupMaster LMLOBId with(nolock) ON GQ.MemberLOBLkup=LMLOBId.CMN_LookupMasterId	And LMLOBId.CMN_LookupTypeRef = 31
	LEFT JOIN CMN_LookupMaster LMResolution with(nolock) ON GEligibility.ResolutionLkup=LMResolution.CMN_LookupMasterId And LMResolution.CMN_LookupTypeRef = 18
	LEFT JOIN CMN_LookupMaster LMMMRPBP with(nolock) ON GQ.EligMMRPBPLkup=LMMMRPBP.CMN_LookupMasterId 
	LEFT JOIN CMN_LookupMaster LMDiscSource with(nolock) ON GQ.DiscrepancySourceLkup=LMDiscSource.CMN_LookupMasterId And LMDiscSource.CMN_LookupTypeRef = 13
	LEFT JOIN CMN_LookupMaster LMGender with(nolock) ON GQ.MemberGenderLkup=LMGender.CMN_LookupMasterId And LMGender.CMN_LookupTypeRef = 21
	LEFT JOIN CMN_LookupMaster LMCTranStatus with(nolock) ON GQ.CMSTransactionStatusLkup=LMCTranStatus.CMN_LookupMasterId And LMCTranStatus.CMN_LookupTypeRef = 55
	INNER JOIN ADM_UserMaster UMC with(nolock) ON GQ.CreatedByRef=UMC.ADM_UserMasterId
	INNER JOIN ADM_UserMaster UML with(nolock) ON GQ.LastUpdatedByRef=UML.ADM_UserMasterId
	LEFT JOIN ADM_UserMaster UMLock with(nolock) ON GQ.LockedByRef=UMLock.ADM_UserMasterId
	LEFT JOIN ADM_UserMaster UMAssign with(nolock) ON GQ.AssignedToRef=UMAssign.ADM_UserMasterId
	LEFT JOIN ADM_UserMaster UMPended with(nolock) ON GQ.PendedbyRef=UMPended.ADM_UserMasterId	
	LEFT JOIN CMN_RecordsLocked RL with(nolock) ON RL.CaseId=GQ.GEN_QueueId AND RL.ScreenLkup = 37010 AND RL.IsActive=1
	Where
	(GQ.MemberCurrentHICN = @CurrentHICN OR GQ.EligGPSCurrentHICN = @CurrentHICN OR GQ.EligMMRCurrentHICN = @CurrentHICN OR GQ.[MemberMedicareId] = @CurrentHICN)
	AND GQ.IsActive=1
	AND (@IsUnlock IS NULL OR @IsUnlock = 0 OR (@IsUnlock = 1 AND GQ.LockedByRef is not null AND GQ.UTCLockedOn < DATEADD(hh,-1,GETUTCDATE())))	
	AND (@IsReAssign IS NULL OR @IsReAssign = 0 OR (@IsReAssign = 1 AND GQ.LockedByRef is null AND ((GQ.AssignedToRef IS NOT NULL AND GQ.MostRecentWorkQueueLkup = 10074) OR (GQ.PendedbyRef IS NOT NULL AND GQ.MostRecentWorkQueueLkup = 10081))))
	AND (@IsRestricted = 1 OR (@IsRestricted = 0 AND (GQ.IsRestricted = 0 OR GQ.IsRestricted IS NULL)))

	SELECT DISTINCT COUNT(*) AS TotalRecords
    ,COUNT(CASE WHEN (IsRestricted=1)  THEN 1 END) AS RestrictedRecords
	,COUNT(CASE WHEN (IsRestricted=0 OR IsRestricted IS NULL)  THEN 1 END) AS UnRestrictedRecords
	From GEN_Queue GQ with(nolock)
	LEFT JOIN GEN_EligibilityActions GEligibility with(nolock) ON GQ.GEN_QueueId=GEligibility.GEN_QueueRef
	LEFT JOIN CMN_RecordsLocked RL with(nolock) ON RL.CaseId=GQ.GEN_QueueId AND RL.ScreenLkup = 37010 AND RL.IsActive=1
	Where
	(GQ.MemberCurrentHICN = @CurrentHICN OR GQ.EligGPSCurrentHICN = @CurrentHICN OR GQ.EligMMRCurrentHICN = @CurrentHICN OR GQ.[MemberMedicareId] = @CurrentHICN)
	AND GQ.IsActive=1
	AND (@IsUnlock IS NULL OR @IsUnlock = 0 OR (@IsUnlock = 1 AND GQ.LockedByRef is not null AND GQ.UTCLockedOn < DATEADD(hh,-1,GETUTCDATE())))	
	AND (@IsReAssign IS NULL OR @IsReAssign = 0 OR (@IsReAssign = 1 AND GQ.LockedByRef is null AND ((GQ.AssignedToRef IS NOT NULL AND GQ.MostRecentWorkQueueLkup = 10074) OR (GQ.PendedbyRef IS NOT NULL AND GQ.MostRecentWorkQueueLkup = 10081))))
End
ELSE IF(@IsBothCaseAndMedicareIdSelected = 1)
Begin
Select DISTINCT TOP (@TopCount)
	GEN_QueueId as WorkItemID,
	[dbo].[GetAge](GQ.[GEN_QueueId]) AS Aging,
	GQ.MemberSCCCode as MemberSCCCode,
	GQ.MemberID as MemberID,
	GQ.MemberMedicareId as MemberCurrentHICN,
	GQ.GPSHouseholdID as GPSHouseholdID,
	GQ.MemberFirstName as MemberFirstName,
	GQ.MemberMiddleName as MemberMiddleName,
	GQ.MemberLastName as MemberLastName,
	LMContractId.LookupValue as MemberContractID,
	GQ.MemberDOB as MemberDOB,
	LMPBPId.LookupValue as MemberPBP,
	LMLOBId.LookupValue as MemberLOB,
	LMGender.LookupValue as MemberGender,
	LMDiscType.LookupValue as DiscrepancyType,
	GQ.MostRecentStatusLkup,
	LMStatus.LookupValue as MostRecentStatus,
	GQ.MostRecentWorkQueueLkup,	
	LMQueue.LookupValue as MostRecentQueue,
	LMQueueType.GroupingLookupMasterRef as QueueProgressTypeLkup,
	LMQueueProgType.LookupValue as QueueProgressType,
	LMAction.LookupValue as MostRecentAction,
	GQ.MemberMedicareId as CurrentHICN,
	GQ.EligGPSCurrentHICN as GPSHICN,
	GQ.EligMMRCurrentHICN as MMRHICN,
	LMWorkBasket.LookupValue as BusinessSegment,
	GQ.BusinessSegmentLkup, 
	LMDiscrepancy.LookupValue as DiscrepancyCategory,
	GQ.DiscrepancyCategoryLkup, 
	GQ.DiscrepancyStartDate as DiscrepancyStartDate,
	GQ.DiscrepancyEndDate as DiscrepancyEndDate,
	GEligibility.Reason as Reason,
	LMResolution.LookupValue as Resolution,
	GQ.ReferencedEligibilityCaseInd as ReferencedEligibilityCaseIndicator,
	LMMMRPBP.LookupValue as MMRPBP,
	NULL as GPSIndividualID,
	LMDiscSource.LookupValue as DiscrepancySource,
	NULL as SubmissionType,
	NULL as CTMMember,
	NULL as EGHPMember,
	NULL as RequestedEffectiveDate,
	NULL as ActionRequested,
	NULL as PotentialSubmissionDate,
	NULL as RPCSubmissionDate,
	NULL as FDRReceivedDate,
	NULL as FDRCodeReceived,
	NULL as FDRStatus,
	NULL as RPRRequestor,
	GQ.ComplianceStartDate as ComplianceStartDate,
	NULL as AdjustedComplianceStartDate,
	GQ.UTCCreatedOn,
	GQ.CreatedByRef,
	UMC.FullName as CreatedBy,
	GQ.UTCLastUpdatedOn,
	GQ.LastUpdatedByRef,
	UML.FullName as LastUpdatedBy,
	GQ.LockedByRef,
	GQ.UTCLockedOn,
	UMLock.FullName as LockedBy,
	GQ.AssignedToRef,
	GQ.UTCAssignedOn,
	UMAssign.FullName as AssignedTo,
	GQ.PendedbyRef,
	GQ.UTCPendedOn,
	UMPended.FullName as PendedBy,
	NULL as OOALetterStatusLkup,
	NULL as OOALetterStatus,
	GQ.CMSTransactionStatusLkup,
	LMCTranStatus.LookupValue as CMSTransactionStatus
	From GEN_Queue GQ with(nolock)
	LEFT JOIN GEN_EligibilityActions GEligibility with(nolock) ON GQ.GEN_QueueId=GEligibility.GEN_QueueRef
	LEFT JOIN CMN_LookupMaster LMWorkBasket with(nolock) ON GQ.BusinessSegmentLkup=LMWorkBasket.CMN_LookupMasterId And LMWorkBasket.CMN_LookupTypeRef = 1
	LEFT JOIN CMN_LookupMaster LMDiscrepancy with(nolock) ON GQ.DiscrepancyCategoryLkup=LMDiscrepancy.CMN_LookupMasterId And LMDiscrepancy.CMN_LookupTypeRef = 6
	LEFT JOIN CMN_LookupMaster LMDiscType with(nolock) ON GQ.DiscrepancyTypeLkup=LMDiscType.CMN_LookupMasterId And LMDiscType.CMN_LookupTypeRef = 7
	LEFT JOIN CMN_LookupMaster LMStatus with(nolock) ON GQ.MostRecentStatusLkup=LMStatus.CMN_LookupMasterId And LMStatus.CMN_LookupTypeRef = 20
	LEFT JOIN CMN_LookupMaster LMQueue with(nolock) ON GQ.MostRecentWorkQueueLkup=LMQueue.CMN_LookupMasterId And LMQueue.CMN_LookupTypeRef = 10
	LEFT JOIN CMN_LookupMaster LMAction with(nolock) ON GQ.MostRecentActionLkup=LMAction.CMN_LookupMasterId And LMAction.CMN_LookupTypeRef = 28
	LEFT JOIN CMN_LookupMasterCorrelations LMQueueType with(nolock) ON GQ.MostRecentWorkQueueLkup=LMQueueType.CMN_LookupMasterChildRef AND LMQueueType.CMN_LookupTypeCorrelationsRef=3
	LEFT JOIN CMN_LookupMaster LMQueueProgType with(nolock) ON LMQueueType.GroupingLookupMasterRef=LMQueueProgType.CMN_LookupMasterId AND LMQueueProgType.CMN_LookupTypeRef = 9
	LEFT JOIN CMN_LookupMaster LMContractId with(nolock) ON GQ.MemberContractIDLkup=LMContractId.CMN_LookupMasterId And LMContractId.CMN_LookupTypeRef = 11
	LEFT JOIN CMN_LookupMaster LMPBPId with(nolock) ON GQ.MemberPBPLkup=LMPBPId.CMN_LookupMasterId And LMPBPId.CMN_LookupTypeRef = 12
	LEFT JOIN CMN_LookupMaster LMLOBId with(nolock) ON GQ.MemberLOBLkup=LMLOBId.CMN_LookupMasterId	And LMLOBId.CMN_LookupTypeRef = 31
	LEFT JOIN CMN_LookupMaster LMResolution with(nolock) ON GEligibility.ResolutionLkup=LMResolution.CMN_LookupMasterId And LMResolution.CMN_LookupTypeRef = 18
	LEFT JOIN CMN_LookupMaster LMMMRPBP with(nolock) ON GQ.EligMMRPBPLkup=LMMMRPBP.CMN_LookupMasterId 
	LEFT JOIN CMN_LookupMaster LMDiscSource with(nolock) ON GQ.DiscrepancySourceLkup=LMDiscSource.CMN_LookupMasterId And LMDiscSource.CMN_LookupTypeRef = 13
	LEFT JOIN CMN_LookupMaster LMGender with(nolock) ON GQ.MemberGenderLkup=LMGender.CMN_LookupMasterId And LMGender.CMN_LookupTypeRef = 21
	LEFT JOIN CMN_LookupMaster LMCTranStatus with(nolock) ON GQ.CMSTransactionStatusLkup=LMCTranStatus.CMN_LookupMasterId And LMCTranStatus.CMN_LookupTypeRef = 55
	INNER JOIN ADM_UserMaster UMC with(nolock) ON GQ.CreatedByRef=UMC.ADM_UserMasterId
	INNER JOIN ADM_UserMaster UML with(nolock) ON GQ.LastUpdatedByRef=UML.ADM_UserMasterId
	LEFT JOIN ADM_UserMaster UMLock with(nolock) ON GQ.LockedByRef=UMLock.ADM_UserMasterId
	LEFT JOIN ADM_UserMaster UMAssign with(nolock) ON GQ.AssignedToRef=UMAssign.ADM_UserMasterId
	LEFT JOIN ADM_UserMaster UMPended with(nolock) ON GQ.PendedbyRef=UMPended.ADM_UserMasterId	
	LEFT JOIN CMN_RecordsLocked RL with(nolock) ON RL.CaseId=GQ.GEN_QueueId AND RL.ScreenLkup = 37010 AND RL.IsActive=1
	Where
	GQ.GEN_QueueId=@WorkItemId 
	AND (GQ.MemberCurrentHICN = @CurrentHICN OR GQ.EligGPSCurrentHICN = @CurrentHICN OR GQ.EligMMRCurrentHICN = @CurrentHICN OR GQ.[MemberMedicareId] = @CurrentHICN)
	AND GQ.IsActive=1
	AND (@IsUnlock IS NULL OR @IsUnlock = 0 OR (@IsUnlock = 1 AND GQ.LockedByRef is not null AND GQ.UTCLockedOn < DATEADD(hh,-1,GETUTCDATE())))	
	AND (@IsReAssign IS NULL OR @IsReAssign = 0 OR (@IsReAssign = 1 AND GQ.LockedByRef is null AND ((GQ.AssignedToRef IS NOT NULL AND GQ.MostRecentWorkQueueLkup = 10074) OR (GQ.PendedbyRef IS NOT NULL AND GQ.MostRecentWorkQueueLkup = 10081))))	
	AND (@IsRestricted = 1 OR (@IsRestricted = 0 AND (GQ.IsRestricted = 0 OR GQ.IsRestricted IS NULL)))

	SELECT DISTINCT COUNT(*) AS TotalRecords
    ,COUNT(CASE WHEN (IsRestricted=1)  THEN 1 END) AS RestrictedRecords
	,COUNT(CASE WHEN (IsRestricted=0 OR IsRestricted IS NULL)  THEN 1 END) AS UnRestrictedRecords
	From GEN_Queue GQ with(nolock)
	LEFT JOIN GEN_EligibilityActions GEligibility with(nolock) ON GQ.GEN_QueueId=GEligibility.GEN_QueueRef
	LEFT JOIN CMN_RecordsLocked RL with(nolock) ON RL.CaseId=GQ.GEN_QueueId AND RL.ScreenLkup = 37010 AND RL.IsActive=1
	Where
	GQ.GEN_QueueId=@WorkItemId 
	AND (GQ.MemberCurrentHICN = @CurrentHICN OR GQ.EligGPSCurrentHICN = @CurrentHICN OR GQ.EligMMRCurrentHICN = @CurrentHICN OR GQ.[MemberMedicareId] = @CurrentHICN)
	AND GQ.IsActive=1
	AND (@IsUnlock IS NULL OR @IsUnlock = 0 OR (@IsUnlock = 1 AND GQ.LockedByRef is not null AND GQ.UTCLockedOn < DATEADD(hh,-1,GETUTCDATE())))	
	AND (@IsReAssign IS NULL OR @IsReAssign = 0 OR (@IsReAssign = 1 AND GQ.LockedByRef is null AND ((GQ.AssignedToRef IS NOT NULL AND GQ.MostRecentWorkQueueLkup = 10074) OR (GQ.PendedbyRef IS NOT NULL AND GQ.MostRecentWorkQueueLkup = 10081))))	
End
ELSE IF(@IsBothDiscCatAndCaseIdSelected = 1)
Begin
Select DISTINCT TOP (@TopCount)
	GEN_QueueId as WorkItemID,
	[dbo].[GetAge](GQ.[GEN_QueueId]) AS Aging,
	GQ.MemberSCCCode as MemberSCCCode,
	GQ.MemberID as MemberID,
	GQ.MemberMedicareId as MemberCurrentHICN,
	GQ.GPSHouseholdID as GPSHouseholdID,
	GQ.MemberFirstName as MemberFirstName,
	GQ.MemberMiddleName as MemberMiddleName,
	GQ.MemberLastName as MemberLastName,
	LMContractId.LookupValue as MemberContractID,
	GQ.MemberDOB as MemberDOB,
	LMPBPId.LookupValue as MemberPBP,
	LMLOBId.LookupValue as MemberLOB,
	LMGender.LookupValue as MemberGender,
	LMDiscType.LookupValue as DiscrepancyType,
	GQ.MostRecentStatusLkup,
	LMStatus.LookupValue as MostRecentStatus,
	GQ.MostRecentWorkQueueLkup,	
	LMQueue.LookupValue as MostRecentQueue,
	LMQueueType.GroupingLookupMasterRef as QueueProgressTypeLkup,
	LMQueueProgType.LookupValue as QueueProgressType,
	LMAction.LookupValue as MostRecentAction,
	GQ.MemberMedicareId as CurrentHICN,
	GQ.EligGPSCurrentHICN as GPSHICN,
	GQ.EligMMRCurrentHICN as MMRHICN,
	LMWorkBasket.LookupValue as BusinessSegment,
	GQ.BusinessSegmentLkup, 
	LMDiscrepancy.LookupValue as DiscrepancyCategory,
	GQ.DiscrepancyCategoryLkup, 
	GQ.DiscrepancyStartDate as DiscrepancyStartDate,
	GQ.DiscrepancyEndDate as DiscrepancyEndDate,
	GEligibility.Reason as Reason,
	LMResolution.LookupValue as Resolution,
	GQ.ReferencedEligibilityCaseInd as ReferencedEligibilityCaseIndicator,
	LMMMRPBP.LookupValue as MMRPBP,
	NULL as GPSIndividualID,
	LMDiscSource.LookupValue as DiscrepancySource,
	NULL as SubmissionType,
	NULL as CTMMember,
	NULL as EGHPMember,
	NULL as RequestedEffectiveDate,
	NULL as ActionRequested,
	NULL as PotentialSubmissionDate,
	NULL as RPCSubmissionDate,
	NULL as FDRReceivedDate,
	NULL as FDRCodeReceived,
	NULL as FDRStatus,
	NULL as RPRRequestor,
	GQ.ComplianceStartDate as ComplianceStartDate,
	NULL as AdjustedComplianceStartDate,
	GQ.UTCCreatedOn,
	GQ.CreatedByRef,
	UMC.FullName as CreatedBy,
	GQ.UTCLastUpdatedOn,
	GQ.LastUpdatedByRef,
	UML.FullName as LastUpdatedBy,
	GQ.LockedByRef,
	GQ.UTCLockedOn,
	UMLock.FullName as LockedBy,
	GQ.AssignedToRef,
	GQ.UTCAssignedOn,
	UMAssign.FullName as AssignedTo,
	GQ.PendedbyRef,
	GQ.UTCPendedOn,
	UMPended.FullName as PendedBy,
	NULL as OOALetterStatusLkup,
	NULL as OOALetterStatus,
	GQ.CMSTransactionStatusLkup,
	LMCTranStatus.LookupValue as CMSTransactionStatus
	From GEN_Queue GQ with(nolock)
	LEFT JOIN GEN_EligibilityActions GEligibility with(nolock) ON GQ.GEN_QueueId=GEligibility.GEN_QueueRef
	LEFT JOIN CMN_LookupMaster LMWorkBasket with(nolock) ON GQ.BusinessSegmentLkup=LMWorkBasket.CMN_LookupMasterId And LMWorkBasket.CMN_LookupTypeRef = 1
	LEFT JOIN CMN_LookupMaster LMDiscrepancy with(nolock) ON GQ.DiscrepancyCategoryLkup=LMDiscrepancy.CMN_LookupMasterId And LMDiscrepancy.CMN_LookupTypeRef = 6
	LEFT JOIN CMN_LookupMaster LMDiscType with(nolock) ON GQ.DiscrepancyTypeLkup=LMDiscType.CMN_LookupMasterId And LMDiscType.CMN_LookupTypeRef = 7
	LEFT JOIN CMN_LookupMaster LMStatus with(nolock) ON GQ.MostRecentStatusLkup=LMStatus.CMN_LookupMasterId And LMStatus.CMN_LookupTypeRef = 20
	LEFT JOIN CMN_LookupMaster LMQueue with(nolock) ON GQ.MostRecentWorkQueueLkup=LMQueue.CMN_LookupMasterId And LMQueue.CMN_LookupTypeRef = 10
	LEFT JOIN CMN_LookupMaster LMAction with(nolock) ON GQ.MostRecentActionLkup=LMAction.CMN_LookupMasterId And LMAction.CMN_LookupTypeRef = 28
	LEFT JOIN CMN_LookupMasterCorrelations LMQueueType with(nolock) ON GQ.MostRecentWorkQueueLkup=LMQueueType.CMN_LookupMasterChildRef AND LMQueueType.CMN_LookupTypeCorrelationsRef=3
	LEFT JOIN CMN_LookupMaster LMQueueProgType with(nolock) ON LMQueueType.GroupingLookupMasterRef=LMQueueProgType.CMN_LookupMasterId AND LMQueueProgType.CMN_LookupTypeRef = 9
	LEFT JOIN CMN_LookupMaster LMContractId with(nolock) ON GQ.MemberContractIDLkup=LMContractId.CMN_LookupMasterId And LMContractId.CMN_LookupTypeRef = 11
	LEFT JOIN CMN_LookupMaster LMPBPId with(nolock) ON GQ.MemberPBPLkup=LMPBPId.CMN_LookupMasterId And LMPBPId.CMN_LookupTypeRef = 12
	LEFT JOIN CMN_LookupMaster LMLOBId with(nolock) ON GQ.MemberLOBLkup=LMLOBId.CMN_LookupMasterId	And LMLOBId.CMN_LookupTypeRef = 31
	LEFT JOIN CMN_LookupMaster LMResolution with(nolock) ON GEligibility.ResolutionLkup=LMResolution.CMN_LookupMasterId And LMResolution.CMN_LookupTypeRef = 18
	LEFT JOIN CMN_LookupMaster LMMMRPBP with(nolock) ON GQ.EligMMRPBPLkup=LMMMRPBP.CMN_LookupMasterId 
	LEFT JOIN CMN_LookupMaster LMDiscSource with(nolock) ON GQ.DiscrepancySourceLkup=LMDiscSource.CMN_LookupMasterId And LMDiscSource.CMN_LookupTypeRef = 13
	LEFT JOIN CMN_LookupMaster LMGender with(nolock) ON GQ.MemberGenderLkup=LMGender.CMN_LookupMasterId And LMGender.CMN_LookupTypeRef = 21
	LEFT JOIN CMN_LookupMaster LMCTranStatus with(nolock) ON GQ.CMSTransactionStatusLkup=LMCTranStatus.CMN_LookupMasterId And LMCTranStatus.CMN_LookupTypeRef = 55
	INNER JOIN ADM_UserMaster UMC with(nolock) ON GQ.CreatedByRef=UMC.ADM_UserMasterId
	INNER JOIN ADM_UserMaster UML with(nolock) ON GQ.LastUpdatedByRef=UML.ADM_UserMasterId
	LEFT JOIN ADM_UserMaster UMLock with(nolock) ON GQ.LockedByRef=UMLock.ADM_UserMasterId
	LEFT JOIN ADM_UserMaster UMAssign with(nolock) ON GQ.AssignedToRef=UMAssign.ADM_UserMasterId
	LEFT JOIN ADM_UserMaster UMPended with(nolock) ON GQ.PendedbyRef=UMPended.ADM_UserMasterId	
	LEFT JOIN CMN_RecordsLocked RL with(nolock) ON RL.CaseId=GQ.GEN_QueueId AND RL.ScreenLkup = 37010 AND RL.IsActive=1
	Where
	GQ.DiscrepancyCategoryLkup=@DiscrepancyCategoryLkup
	AND GQ.GEN_QueueId=@WorkItemId
	AND GQ.IsActive=1
	AND (@IsUnlock IS NULL OR @IsUnlock = 0 OR (@IsUnlock = 1 AND GQ.LockedByRef is not null AND GQ.UTCLockedOn < DATEADD(hh,-1,GETUTCDATE())))	
	AND (@IsReAssign IS NULL OR @IsReAssign = 0 OR (@IsReAssign = 1 AND GQ.LockedByRef is null AND ((GQ.AssignedToRef IS NOT NULL AND GQ.MostRecentWorkQueueLkup = 10074) OR (GQ.PendedbyRef IS NOT NULL AND GQ.MostRecentWorkQueueLkup = 10081))))	
	AND (@IsRestricted = 1 OR (@IsRestricted = 0 AND (GQ.IsRestricted = 0 OR GQ.IsRestricted IS NULL)))

	SELECT DISTINCT COUNT(*) AS TotalRecords
    ,COUNT(CASE WHEN (IsRestricted=1)  THEN 1 END) AS RestrictedRecords
	,COUNT(CASE WHEN (IsRestricted=0 OR IsRestricted IS NULL)  THEN 1 END) AS UnRestrictedRecords
	From GEN_Queue GQ with(nolock)
	LEFT JOIN GEN_EligibilityActions GEligibility with(nolock) ON GQ.GEN_QueueId=GEligibility.GEN_QueueRef
	LEFT JOIN CMN_RecordsLocked RL with(nolock) ON RL.CaseId=GQ.GEN_QueueId AND RL.ScreenLkup = 37010 AND RL.IsActive=1
	Where
	GQ.DiscrepancyCategoryLkup=@DiscrepancyCategoryLkup
	AND GQ.GEN_QueueId=@WorkItemId
	AND GQ.IsActive=1
	AND (@IsUnlock IS NULL OR @IsUnlock = 0 OR (@IsUnlock = 1 AND GQ.LockedByRef is not null AND GQ.UTCLockedOn < DATEADD(hh,-1,GETUTCDATE())))	
	AND (@IsReAssign IS NULL OR @IsReAssign = 0 OR (@IsReAssign = 1 AND GQ.LockedByRef is null AND ((GQ.AssignedToRef IS NOT NULL AND GQ.MostRecentWorkQueueLkup = 10074) OR (GQ.PendedbyRef IS NOT NULL AND GQ.MostRecentWorkQueueLkup = 10081))))	
End
ELSE IF(@IsBothDiscCatAndMedicareIdSelected =1)
Begin
Select DISTINCT TOP (@TopCount)
	GEN_QueueId as WorkItemID,
	[dbo].[GetAge](GQ.[GEN_QueueId]) AS Aging,
	GQ.MemberSCCCode as MemberSCCCode,
	GQ.MemberID as MemberID,
	GQ.MemberMedicareId as MemberCurrentHICN,
	GQ.GPSHouseholdID as GPSHouseholdID,
	GQ.MemberFirstName as MemberFirstName,
	GQ.MemberMiddleName as MemberMiddleName,
	GQ.MemberLastName as MemberLastName,
	LMContractId.LookupValue as MemberContractID,
	GQ.MemberDOB as MemberDOB,
	LMPBPId.LookupValue as MemberPBP,
	LMLOBId.LookupValue as MemberLOB,
	LMGender.LookupValue as MemberGender,
	LMDiscType.LookupValue as DiscrepancyType,
	GQ.MostRecentStatusLkup,
	LMStatus.LookupValue as MostRecentStatus,
	GQ.MostRecentWorkQueueLkup,	
	LMQueue.LookupValue as MostRecentQueue,
	LMQueueType.GroupingLookupMasterRef as QueueProgressTypeLkup,
	LMQueueProgType.LookupValue as QueueProgressType,
	LMAction.LookupValue as MostRecentAction,
	GQ.MemberMedicareId as CurrentHICN,
	GQ.EligGPSCurrentHICN as GPSHICN,
	GQ.EligMMRCurrentHICN as MMRHICN,
	LMWorkBasket.LookupValue as BusinessSegment,
	GQ.BusinessSegmentLkup, 
	LMDiscrepancy.LookupValue as DiscrepancyCategory,
	GQ.DiscrepancyCategoryLkup, 
	GQ.DiscrepancyStartDate as DiscrepancyStartDate,
	GQ.DiscrepancyEndDate as DiscrepancyEndDate,
	GEligibility.Reason as Reason,
	LMResolution.LookupValue as Resolution,
	GQ.ReferencedEligibilityCaseInd as ReferencedEligibilityCaseIndicator,
	LMMMRPBP.LookupValue as MMRPBP,
	NULL as GPSIndividualID,
	LMDiscSource.LookupValue as DiscrepancySource,
	NULL as SubmissionType,
	NULL as CTMMember,
	NULL as EGHPMember,
	NULL as RequestedEffectiveDate,
	NULL as ActionRequested,
	NULL as PotentialSubmissionDate,
	NULL as RPCSubmissionDate,
	NULL as FDRReceivedDate,
	NULL as FDRCodeReceived,
	NULL as FDRStatus,
	NULL as RPRRequestor,
	GQ.ComplianceStartDate as ComplianceStartDate,
	NULL as AdjustedComplianceStartDate,
	GQ.UTCCreatedOn,
	GQ.CreatedByRef,
	UMC.FullName as CreatedBy,
	GQ.UTCLastUpdatedOn,
	GQ.LastUpdatedByRef,
	UML.FullName as LastUpdatedBy,
	GQ.LockedByRef,
	GQ.UTCLockedOn,
	UMLock.FullName as LockedBy,
	GQ.AssignedToRef,
	GQ.UTCAssignedOn,
	UMAssign.FullName as AssignedTo,
	GQ.PendedbyRef,
	GQ.UTCPendedOn,
	UMPended.FullName as PendedBy,
	NULL as OOALetterStatusLkup,
	NULL as OOALetterStatus,
	GQ.CMSTransactionStatusLkup,
	LMCTranStatus.LookupValue as CMSTransactionStatus
	From GEN_Queue GQ with(nolock)
	LEFT JOIN GEN_EligibilityActions GEligibility with(nolock) ON GQ.GEN_QueueId=GEligibility.GEN_QueueRef
	LEFT JOIN CMN_LookupMaster LMWorkBasket with(nolock) ON GQ.BusinessSegmentLkup=LMWorkBasket.CMN_LookupMasterId And LMWorkBasket.CMN_LookupTypeRef = 1
	LEFT JOIN CMN_LookupMaster LMDiscrepancy with(nolock) ON GQ.DiscrepancyCategoryLkup=LMDiscrepancy.CMN_LookupMasterId And LMDiscrepancy.CMN_LookupTypeRef = 6
	LEFT JOIN CMN_LookupMaster LMDiscType with(nolock) ON GQ.DiscrepancyTypeLkup=LMDiscType.CMN_LookupMasterId And LMDiscType.CMN_LookupTypeRef = 7
	LEFT JOIN CMN_LookupMaster LMStatus with(nolock) ON GQ.MostRecentStatusLkup=LMStatus.CMN_LookupMasterId And LMStatus.CMN_LookupTypeRef = 20
	LEFT JOIN CMN_LookupMaster LMQueue with(nolock) ON GQ.MostRecentWorkQueueLkup=LMQueue.CMN_LookupMasterId And LMQueue.CMN_LookupTypeRef = 10
	LEFT JOIN CMN_LookupMaster LMAction with(nolock) ON GQ.MostRecentActionLkup=LMAction.CMN_LookupMasterId And LMAction.CMN_LookupTypeRef = 28
	LEFT JOIN CMN_LookupMasterCorrelations LMQueueType with(nolock) ON GQ.MostRecentWorkQueueLkup=LMQueueType.CMN_LookupMasterChildRef AND LMQueueType.CMN_LookupTypeCorrelationsRef=3
	LEFT JOIN CMN_LookupMaster LMQueueProgType with(nolock) ON LMQueueType.GroupingLookupMasterRef=LMQueueProgType.CMN_LookupMasterId AND LMQueueProgType.CMN_LookupTypeRef = 9
	LEFT JOIN CMN_LookupMaster LMContractId with(nolock) ON GQ.MemberContractIDLkup=LMContractId.CMN_LookupMasterId And LMContractId.CMN_LookupTypeRef = 11
	LEFT JOIN CMN_LookupMaster LMPBPId with(nolock) ON GQ.MemberPBPLkup=LMPBPId.CMN_LookupMasterId And LMPBPId.CMN_LookupTypeRef = 12
	LEFT JOIN CMN_LookupMaster LMLOBId with(nolock) ON GQ.MemberLOBLkup=LMLOBId.CMN_LookupMasterId	And LMLOBId.CMN_LookupTypeRef = 31
	LEFT JOIN CMN_LookupMaster LMResolution with(nolock) ON GEligibility.ResolutionLkup=LMResolution.CMN_LookupMasterId And LMResolution.CMN_LookupTypeRef = 18
	LEFT JOIN CMN_LookupMaster LMMMRPBP with(nolock) ON GQ.EligMMRPBPLkup=LMMMRPBP.CMN_LookupMasterId 
	LEFT JOIN CMN_LookupMaster LMDiscSource with(nolock) ON GQ.DiscrepancySourceLkup=LMDiscSource.CMN_LookupMasterId And LMDiscSource.CMN_LookupTypeRef = 13
	LEFT JOIN CMN_LookupMaster LMGender with(nolock) ON GQ.MemberGenderLkup=LMGender.CMN_LookupMasterId And LMGender.CMN_LookupTypeRef = 21
	LEFT JOIN CMN_LookupMaster LMCTranStatus with(nolock) ON GQ.CMSTransactionStatusLkup=LMCTranStatus.CMN_LookupMasterId And LMCTranStatus.CMN_LookupTypeRef = 55
	INNER JOIN ADM_UserMaster UMC with(nolock) ON GQ.CreatedByRef=UMC.ADM_UserMasterId
	INNER JOIN ADM_UserMaster UML with(nolock) ON GQ.LastUpdatedByRef=UML.ADM_UserMasterId
	LEFT JOIN ADM_UserMaster UMLock with(nolock) ON GQ.LockedByRef=UMLock.ADM_UserMasterId
	LEFT JOIN ADM_UserMaster UMAssign with(nolock) ON GQ.AssignedToRef=UMAssign.ADM_UserMasterId
	LEFT JOIN ADM_UserMaster UMPended with(nolock) ON GQ.PendedbyRef=UMPended.ADM_UserMasterId	
	LEFT JOIN CMN_RecordsLocked RL with(nolock) ON RL.CaseId=GQ.GEN_QueueId AND RL.ScreenLkup = 37010 AND RL.IsActive=1
	Where
	GQ.DiscrepancyCategoryLkup=@DiscrepancyCategoryLkup
	AND (GQ.MemberCurrentHICN = @CurrentHICN OR GQ.EligGPSCurrentHICN = @CurrentHICN OR GQ.EligMMRCurrentHICN = @CurrentHICN  OR GQ.[MemberMedicareId] = @CurrentHICN)
	AND GQ.IsActive=1
	AND (@IsUnlock IS NULL OR @IsUnlock = 0 OR (@IsUnlock = 1 AND GQ.LockedByRef is not null AND GQ.UTCLockedOn < DATEADD(hh,-1,GETUTCDATE())))	
	AND (@IsReAssign IS NULL OR @IsReAssign = 0 OR (@IsReAssign = 1 AND GQ.LockedByRef is null AND ((GQ.AssignedToRef IS NOT NULL AND GQ.MostRecentWorkQueueLkup = 10074) OR (GQ.PendedbyRef IS NOT NULL AND GQ.MostRecentWorkQueueLkup = 10081))))	
	AND (@IsRestricted = 1 OR (@IsRestricted = 0 AND (GQ.IsRestricted = 0 OR GQ.IsRestricted IS NULL)))

	SELECT DISTINCT COUNT(*) AS TotalRecords
    ,COUNT(CASE WHEN (IsRestricted=1)  THEN 1 END) AS RestrictedRecords
	,COUNT(CASE WHEN (IsRestricted=0 OR IsRestricted IS NULL)  THEN 1 END) AS UnRestrictedRecords
	From GEN_Queue GQ with(nolock)
	LEFT JOIN GEN_EligibilityActions GEligibility with(nolock) ON GQ.GEN_QueueId=GEligibility.GEN_QueueRef
	LEFT JOIN CMN_RecordsLocked RL with(nolock) ON RL.CaseId=GQ.GEN_QueueId AND RL.ScreenLkup = 37010 AND RL.IsActive=1
	Where
	GQ.DiscrepancyCategoryLkup=@DiscrepancyCategoryLkup
	AND (GQ.MemberCurrentHICN = @CurrentHICN OR GQ.EligGPSCurrentHICN = @CurrentHICN OR GQ.EligMMRCurrentHICN = @CurrentHICN  OR GQ.[MemberMedicareId] = @CurrentHICN)
	AND GQ.IsActive=1
	AND (@IsUnlock IS NULL OR @IsUnlock = 0 OR (@IsUnlock = 1 AND GQ.LockedByRef is not null AND GQ.UTCLockedOn < DATEADD(hh,-1,GETUTCDATE())))	
	AND (@IsReAssign IS NULL OR @IsReAssign = 0 OR (@IsReAssign = 1 AND GQ.LockedByRef is null AND ((GQ.AssignedToRef IS NOT NULL AND GQ.MostRecentWorkQueueLkup = 10074) OR (GQ.PendedbyRef IS NOT NULL AND GQ.MostRecentWorkQueueLkup = 10081))))
End
ELSE IF(@IsDiscCatAndCaseIdAndMedicareIdSelected = 1)
Begin
Select DISTINCT TOP (@TopCount)
	GEN_QueueId as WorkItemID,
	[dbo].[GetAge](GQ.[GEN_QueueId]) AS Aging,
	GQ.MemberSCCCode as MemberSCCCode,
	GQ.MemberID as MemberID,
	GQ.MemberMedicareId as MemberCurrentHICN,
	GQ.GPSHouseholdID as GPSHouseholdID,
	GQ.MemberFirstName as MemberFirstName,
	GQ.MemberMiddleName as MemberMiddleName,
	GQ.MemberLastName as MemberLastName,
	LMContractId.LookupValue as MemberContractID,
	GQ.MemberDOB as MemberDOB,
	LMPBPId.LookupValue as MemberPBP,
	LMLOBId.LookupValue as MemberLOB,
	LMGender.LookupValue as MemberGender,
	LMDiscType.LookupValue as DiscrepancyType,
	GQ.MostRecentStatusLkup,
	LMStatus.LookupValue as MostRecentStatus,
	GQ.MostRecentWorkQueueLkup,	
	LMQueue.LookupValue as MostRecentQueue,
	LMQueueType.GroupingLookupMasterRef as QueueProgressTypeLkup,
	LMQueueProgType.LookupValue as QueueProgressType,
	LMAction.LookupValue as MostRecentAction,
	GQ.MemberMedicareId as CurrentHICN,
	GQ.EligGPSCurrentHICN as GPSHICN,
	GQ.EligMMRCurrentHICN as MMRHICN,
	LMWorkBasket.LookupValue as BusinessSegment,
	GQ.BusinessSegmentLkup, 
	LMDiscrepancy.LookupValue as DiscrepancyCategory,
	GQ.DiscrepancyCategoryLkup, 
	GQ.DiscrepancyStartDate as DiscrepancyStartDate,
	GQ.DiscrepancyEndDate as DiscrepancyEndDate,
	GEligibility.Reason as Reason,
	LMResolution.LookupValue as Resolution,
	GQ.ReferencedEligibilityCaseInd as ReferencedEligibilityCaseIndicator,
	LMMMRPBP.LookupValue as MMRPBP,
	NULL as GPSIndividualID,
	LMDiscSource.LookupValue as DiscrepancySource,
	NULL as SubmissionType,
	NULL as CTMMember,
	NULL as EGHPMember,
	NULL as RequestedEffectiveDate,
	NULL as ActionRequested,
	NULL as PotentialSubmissionDate,
	NULL as RPCSubmissionDate,
	NULL as FDRReceivedDate,
	NULL as FDRCodeReceived,
	NULL as FDRStatus,
	NULL as RPRRequestor,
	GQ.ComplianceStartDate as ComplianceStartDate,
	NULL as AdjustedComplianceStartDate,
	GQ.UTCCreatedOn,
	GQ.CreatedByRef,
	UMC.FullName as CreatedBy,
	GQ.UTCLastUpdatedOn,
	GQ.LastUpdatedByRef,
	UML.FullName as LastUpdatedBy,
	GQ.LockedByRef,
	GQ.UTCLockedOn,
	UMLock.FullName as LockedBy,
	GQ.AssignedToRef,
	GQ.UTCAssignedOn,
	UMAssign.FullName as AssignedTo,
	GQ.PendedbyRef,
	GQ.UTCPendedOn,
	UMPended.FullName as PendedBy,
	NULL as OOALetterStatusLkup,
	NULL as OOALetterStatus,
	GQ.CMSTransactionStatusLkup,
	LMCTranStatus.LookupValue as CMSTransactionStatus
	From GEN_Queue GQ with(nolock)
	LEFT JOIN GEN_EligibilityActions GEligibility with(nolock) ON GQ.GEN_QueueId=GEligibility.GEN_QueueRef
	LEFT JOIN CMN_LookupMaster LMWorkBasket with(nolock) ON GQ.BusinessSegmentLkup=LMWorkBasket.CMN_LookupMasterId And LMWorkBasket.CMN_LookupTypeRef = 1
	LEFT JOIN CMN_LookupMaster LMDiscrepancy with(nolock) ON GQ.DiscrepancyCategoryLkup=LMDiscrepancy.CMN_LookupMasterId And LMDiscrepancy.CMN_LookupTypeRef = 6
	LEFT JOIN CMN_LookupMaster LMDiscType with(nolock) ON GQ.DiscrepancyTypeLkup=LMDiscType.CMN_LookupMasterId And LMDiscType.CMN_LookupTypeRef = 7
	LEFT JOIN CMN_LookupMaster LMStatus with(nolock) ON GQ.MostRecentStatusLkup=LMStatus.CMN_LookupMasterId And LMStatus.CMN_LookupTypeRef = 20
	LEFT JOIN CMN_LookupMaster LMQueue with(nolock) ON GQ.MostRecentWorkQueueLkup=LMQueue.CMN_LookupMasterId And LMQueue.CMN_LookupTypeRef = 10
	LEFT JOIN CMN_LookupMaster LMAction with(nolock) ON GQ.MostRecentActionLkup=LMAction.CMN_LookupMasterId And LMAction.CMN_LookupTypeRef = 28
	LEFT JOIN CMN_LookupMasterCorrelations LMQueueType with(nolock) ON GQ.MostRecentWorkQueueLkup=LMQueueType.CMN_LookupMasterChildRef AND LMQueueType.CMN_LookupTypeCorrelationsRef=3
	LEFT JOIN CMN_LookupMaster LMQueueProgType with(nolock) ON LMQueueType.GroupingLookupMasterRef=LMQueueProgType.CMN_LookupMasterId AND LMQueueProgType.CMN_LookupTypeRef = 9
	LEFT JOIN CMN_LookupMaster LMContractId with(nolock) ON GQ.MemberContractIDLkup=LMContractId.CMN_LookupMasterId And LMContractId.CMN_LookupTypeRef = 11
	LEFT JOIN CMN_LookupMaster LMPBPId with(nolock) ON GQ.MemberPBPLkup=LMPBPId.CMN_LookupMasterId And LMPBPId.CMN_LookupTypeRef = 12
	LEFT JOIN CMN_LookupMaster LMLOBId with(nolock) ON GQ.MemberLOBLkup=LMLOBId.CMN_LookupMasterId	And LMLOBId.CMN_LookupTypeRef = 31
	LEFT JOIN CMN_LookupMaster LMResolution with(nolock) ON GEligibility.ResolutionLkup=LMResolution.CMN_LookupMasterId And LMResolution.CMN_LookupTypeRef = 18
	LEFT JOIN CMN_LookupMaster LMMMRPBP with(nolock) ON GQ.EligMMRPBPLkup=LMMMRPBP.CMN_LookupMasterId 
	LEFT JOIN CMN_LookupMaster LMDiscSource with(nolock) ON GQ.DiscrepancySourceLkup=LMDiscSource.CMN_LookupMasterId And LMDiscSource.CMN_LookupTypeRef = 13
	LEFT JOIN CMN_LookupMaster LMGender with(nolock) ON GQ.MemberGenderLkup=LMGender.CMN_LookupMasterId And LMGender.CMN_LookupTypeRef = 21
	LEFT JOIN CMN_LookupMaster LMCTranStatus with(nolock) ON GQ.CMSTransactionStatusLkup=LMCTranStatus.CMN_LookupMasterId And LMCTranStatus.CMN_LookupTypeRef = 55
	INNER JOIN ADM_UserMaster UMC with(nolock) ON GQ.CreatedByRef=UMC.ADM_UserMasterId
	INNER JOIN ADM_UserMaster UML with(nolock) ON GQ.LastUpdatedByRef=UML.ADM_UserMasterId
	LEFT JOIN ADM_UserMaster UMLock with(nolock) ON GQ.LockedByRef=UMLock.ADM_UserMasterId
	LEFT JOIN ADM_UserMaster UMAssign with(nolock) ON GQ.AssignedToRef=UMAssign.ADM_UserMasterId
	LEFT JOIN ADM_UserMaster UMPended with(nolock) ON GQ.PendedbyRef=UMPended.ADM_UserMasterId	
	LEFT JOIN CMN_RecordsLocked RL with(nolock) ON RL.CaseId=GQ.GEN_QueueId AND RL.ScreenLkup = 37010 AND RL.IsActive=1
	Where
	GQ.GEN_QueueId=@WorkItemId
	AND GQ.DiscrepancyCategoryLkup=@DiscrepancyCategoryLkup
	AND (GQ.MemberCurrentHICN = @CurrentHICN OR GQ.EligGPSCurrentHICN = @CurrentHICN OR GQ.EligMMRCurrentHICN = @CurrentHICN  OR GQ.[MemberMedicareId] = @CurrentHICN)
	AND GQ.IsActive=1
	AND (@IsUnlock IS NULL OR @IsUnlock = 0 OR (@IsUnlock = 1 AND GQ.LockedByRef is not null AND GQ.UTCLockedOn < DATEADD(hh,-1,GETUTCDATE())))	
	AND (@IsReAssign IS NULL OR @IsReAssign = 0 OR (@IsReAssign = 1 AND GQ.LockedByRef is null AND ((GQ.AssignedToRef IS NOT NULL AND GQ.MostRecentWorkQueueLkup = 10074) OR (GQ.PendedbyRef IS NOT NULL AND GQ.MostRecentWorkQueueLkup = 10081))))	
	AND (@IsRestricted = 1 OR (@IsRestricted = 0 AND (GQ.IsRestricted = 0 OR GQ.IsRestricted IS NULL)))

	SELECT DISTINCT COUNT(*) AS TotalRecords
    ,COUNT(CASE WHEN (IsRestricted=1)  THEN 1 END) AS RestrictedRecords
	,COUNT(CASE WHEN (IsRestricted=0 OR IsRestricted IS NULL)  THEN 1 END) AS UnRestrictedRecords
	From GEN_Queue GQ with(nolock)
	LEFT JOIN GEN_EligibilityActions GEligibility with(nolock) ON GQ.GEN_QueueId=GEligibility.GEN_QueueRef
	LEFT JOIN CMN_RecordsLocked RL with(nolock) ON RL.CaseId=GQ.GEN_QueueId AND RL.ScreenLkup = 37010 AND RL.IsActive=1
	Where
	GQ.GEN_QueueId=@WorkItemId
	AND GQ.DiscrepancyCategoryLkup=@DiscrepancyCategoryLkup
	AND (GQ.MemberCurrentHICN = @CurrentHICN OR GQ.EligGPSCurrentHICN = @CurrentHICN OR GQ.EligMMRCurrentHICN = @CurrentHICN  OR GQ.[MemberMedicareId] = @CurrentHICN)
	AND GQ.IsActive=1
	AND (@IsUnlock IS NULL OR @IsUnlock = 0 OR (@IsUnlock = 1 AND GQ.LockedByRef is not null AND GQ.UTCLockedOn < DATEADD(hh,-1,GETUTCDATE())))	
	AND (@IsReAssign IS NULL OR @IsReAssign = 0 OR (@IsReAssign = 1 AND GQ.LockedByRef is null AND ((GQ.AssignedToRef IS NOT NULL AND GQ.MostRecentWorkQueueLkup = 10074) OR (GQ.PendedbyRef IS NOT NULL AND GQ.MostRecentWorkQueueLkup = 10081))))		
End
ELSE IF(@IsDiscCatEligibilityAndCreatedDateSelected = 1)
Begin
Select DISTINCT TOP (@TopCount)
	GEN_QueueId as WorkItemID,
	[dbo].[GetAge](GQ.[GEN_QueueId]) AS Aging,
	GQ.MemberSCCCode as MemberSCCCode,
	GQ.MemberID as MemberID,
	GQ.MemberMedicareId as MemberCurrentHICN,
	GQ.GPSHouseholdID as GPSHouseholdID,
	GQ.MemberFirstName as MemberFirstName,
	GQ.MemberMiddleName as MemberMiddleName,
	GQ.MemberLastName as MemberLastName,
	LMContractId.LookupValue as MemberContractID,
	GQ.MemberDOB as MemberDOB,
	LMPBPId.LookupValue as MemberPBP,
	LMLOBId.LookupValue as MemberLOB,
	LMGender.LookupValue as MemberGender,
	LMDiscType.LookupValue as DiscrepancyType,
	GQ.MostRecentStatusLkup,
	LMStatus.LookupValue as MostRecentStatus,
	GQ.MostRecentWorkQueueLkup,	
	LMQueue.LookupValue as MostRecentQueue,
	LMQueueType.GroupingLookupMasterRef as QueueProgressTypeLkup,
	LMQueueProgType.LookupValue as QueueProgressType,
	LMAction.LookupValue as MostRecentAction,
	GQ.MemberMedicareId as CurrentHICN,
	GQ.EligGPSCurrentHICN as GPSHICN,
	GQ.EligMMRCurrentHICN as MMRHICN,
	LMWorkBasket.LookupValue as BusinessSegment,
	GQ.BusinessSegmentLkup, 
	LMDiscrepancy.LookupValue as DiscrepancyCategory,
	GQ.DiscrepancyCategoryLkup, 
	GQ.DiscrepancyStartDate as DiscrepancyStartDate,
	GQ.DiscrepancyEndDate as DiscrepancyEndDate,
	GEligibility.Reason as Reason,
	LMResolution.LookupValue as Resolution,
	GQ.ReferencedEligibilityCaseInd as ReferencedEligibilityCaseIndicator,
	LMMMRPBP.LookupValue as MMRPBP,
	NULL as GPSIndividualID,
	LMDiscSource.LookupValue as DiscrepancySource,
	NULL as SubmissionType,
	NULL as CTMMember,
	NULL as EGHPMember,
	NULL as RequestedEffectiveDate,
	NULL as ActionRequested,
	NULL as PotentialSubmissionDate,
	NULL as RPCSubmissionDate,
	NULL as FDRReceivedDate,
	NULL as FDRCodeReceived,
	NULL as FDRStatus,
	NULL as RPRRequestor,
	GQ.ComplianceStartDate as ComplianceStartDate,
	NULL as AdjustedComplianceStartDate,
	GQ.UTCCreatedOn,
	GQ.CreatedByRef,
	UMC.FullName as CreatedBy,
	GQ.UTCLastUpdatedOn,
	GQ.LastUpdatedByRef,
	UML.FullName as LastUpdatedBy,
	GQ.LockedByRef,
	GQ.UTCLockedOn,
	UMLock.FullName as LockedBy,
	GQ.AssignedToRef,
	GQ.UTCAssignedOn,
	UMAssign.FullName as AssignedTo,
	GQ.PendedbyRef,
	GQ.UTCPendedOn,
	UMPended.FullName as PendedBy,
	NULL as OOALetterStatusLkup,
	NULL as OOALetterStatus,
	GQ.CMSTransactionStatusLkup,
	LMCTranStatus.LookupValue as CMSTransactionStatus
	From GEN_Queue GQ with(nolock)
	LEFT JOIN GEN_EligibilityActions GEligibility with(nolock) ON GQ.GEN_QueueId=GEligibility.GEN_QueueRef
	LEFT JOIN CMN_LookupMaster LMWorkBasket with(nolock) ON GQ.BusinessSegmentLkup=LMWorkBasket.CMN_LookupMasterId And LMWorkBasket.CMN_LookupTypeRef = 1
	LEFT JOIN CMN_LookupMaster LMDiscrepancy with(nolock) ON GQ.DiscrepancyCategoryLkup=LMDiscrepancy.CMN_LookupMasterId And LMDiscrepancy.CMN_LookupTypeRef = 6
	LEFT JOIN CMN_LookupMaster LMDiscType with(nolock) ON GQ.DiscrepancyTypeLkup=LMDiscType.CMN_LookupMasterId And LMDiscType.CMN_LookupTypeRef = 7
	LEFT JOIN CMN_LookupMaster LMStatus with(nolock) ON GQ.MostRecentStatusLkup=LMStatus.CMN_LookupMasterId And LMStatus.CMN_LookupTypeRef = 20
	LEFT JOIN CMN_LookupMaster LMQueue with(nolock) ON GQ.MostRecentWorkQueueLkup=LMQueue.CMN_LookupMasterId And LMQueue.CMN_LookupTypeRef = 10
	LEFT JOIN CMN_LookupMaster LMAction with(nolock) ON GQ.MostRecentActionLkup=LMAction.CMN_LookupMasterId And LMAction.CMN_LookupTypeRef = 28
	LEFT JOIN CMN_LookupMasterCorrelations LMQueueType with(nolock) ON GQ.MostRecentWorkQueueLkup=LMQueueType.CMN_LookupMasterChildRef AND LMQueueType.CMN_LookupTypeCorrelationsRef=3
	LEFT JOIN CMN_LookupMaster LMQueueProgType with(nolock) ON LMQueueType.GroupingLookupMasterRef=LMQueueProgType.CMN_LookupMasterId AND LMQueueProgType.CMN_LookupTypeRef = 9
	LEFT JOIN CMN_LookupMaster LMContractId with(nolock) ON GQ.MemberContractIDLkup=LMContractId.CMN_LookupMasterId And LMContractId.CMN_LookupTypeRef = 11
	LEFT JOIN CMN_LookupMaster LMPBPId with(nolock) ON GQ.MemberPBPLkup=LMPBPId.CMN_LookupMasterId And LMPBPId.CMN_LookupTypeRef = 12
	LEFT JOIN CMN_LookupMaster LMLOBId with(nolock) ON GQ.MemberLOBLkup=LMLOBId.CMN_LookupMasterId	And LMLOBId.CMN_LookupTypeRef = 31
	LEFT JOIN CMN_LookupMaster LMResolution with(nolock) ON GEligibility.ResolutionLkup=LMResolution.CMN_LookupMasterId And LMResolution.CMN_LookupTypeRef = 18
	LEFT JOIN CMN_LookupMaster LMMMRPBP with(nolock) ON GQ.EligMMRPBPLkup=LMMMRPBP.CMN_LookupMasterId 
	LEFT JOIN CMN_LookupMaster LMDiscSource with(nolock) ON GQ.DiscrepancySourceLkup=LMDiscSource.CMN_LookupMasterId And LMDiscSource.CMN_LookupTypeRef = 13
	LEFT JOIN CMN_LookupMaster LMGender with(nolock) ON GQ.MemberGenderLkup=LMGender.CMN_LookupMasterId And LMGender.CMN_LookupTypeRef = 21
	LEFT JOIN CMN_LookupMaster LMCTranStatus with(nolock) ON GQ.CMSTransactionStatusLkup=LMCTranStatus.CMN_LookupMasterId And LMCTranStatus.CMN_LookupTypeRef = 55
	INNER JOIN ADM_UserMaster UMC with(nolock) ON GQ.CreatedByRef=UMC.ADM_UserMasterId
	INNER JOIN ADM_UserMaster UML with(nolock) ON GQ.LastUpdatedByRef=UML.ADM_UserMasterId
	LEFT JOIN ADM_UserMaster UMLock with(nolock) ON GQ.LockedByRef=UMLock.ADM_UserMasterId
	LEFT JOIN ADM_UserMaster UMAssign with(nolock) ON GQ.AssignedToRef=UMAssign.ADM_UserMasterId
	LEFT JOIN ADM_UserMaster UMPended with(nolock) ON GQ.PendedbyRef=UMPended.ADM_UserMasterId	
	LEFT JOIN CMN_RecordsLocked RL with(nolock) ON RL.CaseId=GQ.GEN_QueueId AND RL.ScreenLkup = 37010 AND RL.IsActive=1
	Where	
	GQ.DiscrepancyCategoryLkup=@DiscrepancyCategoryLkup
	AND (@CaseCreationStartDateId Is Null OR GQ.UTCCreatedOnId>=@CaseCreationStartDateId)
	AND (@CaseCreationEndDateId Is Null OR GQ.UTCCreatedOnId<=@CaseCreationEndDateId)
	AND GQ.IsActive=1
	AND (@IsUnlock IS NULL OR @IsUnlock = 0 OR (@IsUnlock = 1 AND GQ.LockedByRef is not null AND GQ.UTCLockedOn < DATEADD(hh,-1,GETUTCDATE())))	
	AND (@IsReAssign IS NULL OR @IsReAssign = 0 OR (@IsReAssign = 1 AND GQ.LockedByRef is null AND ((GQ.AssignedToRef IS NOT NULL AND GQ.MostRecentWorkQueueLkup = 10074) OR (GQ.PendedbyRef IS NOT NULL AND GQ.MostRecentWorkQueueLkup = 10081))))	
	AND (@IsRestricted = 1 OR (@IsRestricted = 0 AND (GQ.IsRestricted = 0 OR GQ.IsRestricted IS NULL)))

	SELECT DISTINCT COUNT(*) AS TotalRecords
    ,COUNT(CASE WHEN (IsRestricted=1)  THEN 1 END) AS RestrictedRecords
	,COUNT(CASE WHEN (IsRestricted=0 OR IsRestricted IS NULL)  THEN 1 END) AS UnRestrictedRecords
	From GEN_Queue GQ with(nolock)
	LEFT JOIN GEN_EligibilityActions GEligibility with(nolock) ON GQ.GEN_QueueId=GEligibility.GEN_QueueRef
	LEFT JOIN CMN_RecordsLocked RL with(nolock) ON RL.CaseId=GQ.GEN_QueueId AND RL.ScreenLkup = 37010 AND RL.IsActive=1
	Where
	GQ.DiscrepancyCategoryLkup=@DiscrepancyCategoryLkup
	AND (@CaseCreationStartDateId Is Null OR GQ.UTCCreatedOnId>=@CaseCreationStartDateId)
	AND (@CaseCreationEndDateId Is Null OR GQ.UTCCreatedOnId<=@CaseCreationEndDateId)
	AND GQ.IsActive=1
	AND (@IsUnlock IS NULL OR @IsUnlock = 0 OR (@IsUnlock = 1 AND GQ.LockedByRef is not null AND GQ.UTCLockedOn < DATEADD(hh,-1,GETUTCDATE())))	
	AND (@IsReAssign IS NULL OR @IsReAssign = 0 OR (@IsReAssign = 1 AND GQ.LockedByRef is null AND ((GQ.AssignedToRef IS NOT NULL AND GQ.MostRecentWorkQueueLkup = 10074) OR (GQ.PendedbyRef IS NOT NULL AND GQ.MostRecentWorkQueueLkup = 10081))))		
End
ELSE IF(@IsDiscCatEligibilityAndDiscTypeAndCreatedDateSelected = 1)
Begin
Select DISTINCT TOP (@TopCount)
	GEN_QueueId as WorkItemID,
	[dbo].[GetAge](GQ.[GEN_QueueId]) AS Aging,
	GQ.MemberSCCCode as MemberSCCCode,
	GQ.MemberID as MemberID,
	GQ.MemberMedicareId as MemberCurrentHICN,
	GQ.GPSHouseholdID as GPSHouseholdID,
	GQ.MemberFirstName as MemberFirstName,
	GQ.MemberMiddleName as MemberMiddleName,
	GQ.MemberLastName as MemberLastName,
	LMContractId.LookupValue as MemberContractID,
	GQ.MemberDOB as MemberDOB,
	LMPBPId.LookupValue as MemberPBP,
	LMLOBId.LookupValue as MemberLOB,
	LMGender.LookupValue as MemberGender,
	LMDiscType.LookupValue as DiscrepancyType,
	GQ.MostRecentStatusLkup,
	LMStatus.LookupValue as MostRecentStatus,
	GQ.MostRecentWorkQueueLkup,	
	LMQueue.LookupValue as MostRecentQueue,
	LMQueueType.GroupingLookupMasterRef as QueueProgressTypeLkup,
	LMQueueProgType.LookupValue as QueueProgressType,
	LMAction.LookupValue as MostRecentAction,
	GQ.MemberMedicareId as CurrentHICN,
	GQ.EligGPSCurrentHICN as GPSHICN,
	GQ.EligMMRCurrentHICN as MMRHICN,
	LMWorkBasket.LookupValue as BusinessSegment,
	GQ.BusinessSegmentLkup, 
	LMDiscrepancy.LookupValue as DiscrepancyCategory,
	GQ.DiscrepancyCategoryLkup, 
	GQ.DiscrepancyStartDate as DiscrepancyStartDate,
	GQ.DiscrepancyEndDate as DiscrepancyEndDate,
	GEligibility.Reason as Reason,
	LMResolution.LookupValue as Resolution,
	GQ.ReferencedEligibilityCaseInd as ReferencedEligibilityCaseIndicator,
	LMMMRPBP.LookupValue as MMRPBP,
	NULL as GPSIndividualID,
	LMDiscSource.LookupValue as DiscrepancySource,
	NULL as SubmissionType,
	NULL as CTMMember,
	NULL as EGHPMember,
	NULL as RequestedEffectiveDate,
	NULL as ActionRequested,
	NULL as PotentialSubmissionDate,
	NULL as RPCSubmissionDate,
	NULL as FDRReceivedDate,
	NULL as FDRCodeReceived,
	NULL as FDRStatus,
	NULL as RPRRequestor,
	GQ.ComplianceStartDate as ComplianceStartDate,
	NULL as AdjustedComplianceStartDate,
	GQ.UTCCreatedOn,
	GQ.CreatedByRef,
	UMC.FullName as CreatedBy,
	GQ.UTCLastUpdatedOn,
	GQ.LastUpdatedByRef,
	UML.FullName as LastUpdatedBy,
	GQ.LockedByRef,
	GQ.UTCLockedOn,
	UMLock.FullName as LockedBy,
	GQ.AssignedToRef,
	GQ.UTCAssignedOn,
	UMAssign.FullName as AssignedTo,
	GQ.PendedbyRef,
	GQ.UTCPendedOn,
	UMPended.FullName as PendedBy,
	NULL as OOALetterStatusLkup,
	NULL as OOALetterStatus,
	GQ.CMSTransactionStatusLkup,
	LMCTranStatus.LookupValue as CMSTransactionStatus
	From GEN_Queue GQ with(nolock)
	LEFT JOIN GEN_EligibilityActions GEligibility with(nolock) ON GQ.GEN_QueueId=GEligibility.GEN_QueueRef
	LEFT JOIN CMN_LookupMaster LMWorkBasket with(nolock) ON GQ.BusinessSegmentLkup=LMWorkBasket.CMN_LookupMasterId And LMWorkBasket.CMN_LookupTypeRef = 1
	LEFT JOIN CMN_LookupMaster LMDiscrepancy with(nolock) ON GQ.DiscrepancyCategoryLkup=LMDiscrepancy.CMN_LookupMasterId And LMDiscrepancy.CMN_LookupTypeRef = 6
	LEFT JOIN CMN_LookupMaster LMDiscType with(nolock) ON GQ.DiscrepancyTypeLkup=LMDiscType.CMN_LookupMasterId And LMDiscType.CMN_LookupTypeRef = 7
	LEFT JOIN CMN_LookupMaster LMStatus with(nolock) ON GQ.MostRecentStatusLkup=LMStatus.CMN_LookupMasterId And LMStatus.CMN_LookupTypeRef = 20
	LEFT JOIN CMN_LookupMaster LMQueue with(nolock) ON GQ.MostRecentWorkQueueLkup=LMQueue.CMN_LookupMasterId And LMQueue.CMN_LookupTypeRef = 10
	LEFT JOIN CMN_LookupMaster LMAction with(nolock) ON GQ.MostRecentActionLkup=LMAction.CMN_LookupMasterId And LMAction.CMN_LookupTypeRef = 28
	LEFT JOIN CMN_LookupMasterCorrelations LMQueueType with(nolock) ON GQ.MostRecentWorkQueueLkup=LMQueueType.CMN_LookupMasterChildRef AND LMQueueType.CMN_LookupTypeCorrelationsRef=3
	LEFT JOIN CMN_LookupMaster LMQueueProgType with(nolock) ON LMQueueType.GroupingLookupMasterRef=LMQueueProgType.CMN_LookupMasterId AND LMQueueProgType.CMN_LookupTypeRef = 9
	LEFT JOIN CMN_LookupMaster LMContractId with(nolock) ON GQ.MemberContractIDLkup=LMContractId.CMN_LookupMasterId And LMContractId.CMN_LookupTypeRef = 11
	LEFT JOIN CMN_LookupMaster LMPBPId with(nolock) ON GQ.MemberPBPLkup=LMPBPId.CMN_LookupMasterId And LMPBPId.CMN_LookupTypeRef = 12
	LEFT JOIN CMN_LookupMaster LMLOBId with(nolock) ON GQ.MemberLOBLkup=LMLOBId.CMN_LookupMasterId	And LMLOBId.CMN_LookupTypeRef = 31
	LEFT JOIN CMN_LookupMaster LMResolution with(nolock) ON GEligibility.ResolutionLkup=LMResolution.CMN_LookupMasterId And LMResolution.CMN_LookupTypeRef = 18
	LEFT JOIN CMN_LookupMaster LMMMRPBP with(nolock) ON GQ.EligMMRPBPLkup=LMMMRPBP.CMN_LookupMasterId 
	LEFT JOIN CMN_LookupMaster LMDiscSource with(nolock) ON GQ.DiscrepancySourceLkup=LMDiscSource.CMN_LookupMasterId And LMDiscSource.CMN_LookupTypeRef = 13
	LEFT JOIN CMN_LookupMaster LMGender with(nolock) ON GQ.MemberGenderLkup=LMGender.CMN_LookupMasterId And LMGender.CMN_LookupTypeRef = 21
	LEFT JOIN CMN_LookupMaster LMCTranStatus with(nolock) ON GQ.CMSTransactionStatusLkup=LMCTranStatus.CMN_LookupMasterId And LMCTranStatus.CMN_LookupTypeRef = 55
	INNER JOIN ADM_UserMaster UMC with(nolock) ON GQ.CreatedByRef=UMC.ADM_UserMasterId
	INNER JOIN ADM_UserMaster UML with(nolock) ON GQ.LastUpdatedByRef=UML.ADM_UserMasterId
	LEFT JOIN ADM_UserMaster UMLock with(nolock) ON GQ.LockedByRef=UMLock.ADM_UserMasterId
	LEFT JOIN ADM_UserMaster UMAssign with(nolock) ON GQ.AssignedToRef=UMAssign.ADM_UserMasterId
	LEFT JOIN ADM_UserMaster UMPended with(nolock) ON GQ.PendedbyRef=UMPended.ADM_UserMasterId	
	LEFT JOIN CMN_RecordsLocked RL with(nolock) ON RL.CaseId=GQ.GEN_QueueId AND RL.ScreenLkup = 37010 AND RL.IsActive=1
	Where	
	GQ.DiscrepancyCategoryLkup=@DiscrepancyCategoryLkup
	AND (@DiscrepancyTypeLkup Is Null OR GQ.DiscrepancyTypeLkup=@DiscrepancyTypeLkup)
	AND (@CaseCreationStartDateId Is Null OR GQ.UTCCreatedOnId>=@CaseCreationStartDateId)
	AND (@CaseCreationEndDateId Is Null OR GQ.UTCCreatedOnId<=@CaseCreationEndDateId)
	AND GQ.IsActive=1
	AND (@IsUnlock IS NULL OR @IsUnlock = 0 OR (@IsUnlock = 1 AND GQ.LockedByRef is not null AND GQ.UTCLockedOn < DATEADD(hh,-1,GETUTCDATE())))	
	AND (@IsReAssign IS NULL OR @IsReAssign = 0 OR (@IsReAssign = 1 AND GQ.LockedByRef is null AND ((GQ.AssignedToRef IS NOT NULL AND GQ.MostRecentWorkQueueLkup = 10074) OR (GQ.PendedbyRef IS NOT NULL AND GQ.MostRecentWorkQueueLkup = 10081))))	
	AND (@IsRestricted = 1 OR (@IsRestricted = 0 AND (GQ.IsRestricted = 0 OR GQ.IsRestricted IS NULL)))

	SELECT DISTINCT COUNT(*) AS TotalRecords
    ,COUNT(CASE WHEN (IsRestricted=1)  THEN 1 END) AS RestrictedRecords
	,COUNT(CASE WHEN (IsRestricted=0 OR IsRestricted IS NULL)  THEN 1 END) AS UnRestrictedRecords
	From GEN_Queue GQ with(nolock)
	LEFT JOIN GEN_EligibilityActions GEligibility with(nolock) ON GQ.GEN_QueueId=GEligibility.GEN_QueueRef
	LEFT JOIN CMN_RecordsLocked RL with(nolock) ON RL.CaseId=GQ.GEN_QueueId AND RL.ScreenLkup = 37010 AND RL.IsActive=1
	Where
	GQ.DiscrepancyCategoryLkup=@DiscrepancyCategoryLkup
	AND (@DiscrepancyTypeLkup Is Null OR GQ.DiscrepancyTypeLkup=@DiscrepancyTypeLkup)
	AND (@CaseCreationStartDateId Is Null OR GQ.UTCCreatedOnId>=@CaseCreationStartDateId)
	AND (@CaseCreationEndDateId Is Null OR GQ.UTCCreatedOnId<=@CaseCreationEndDateId)
	AND GQ.IsActive=1
	AND (@IsUnlock IS NULL OR @IsUnlock = 0 OR (@IsUnlock = 1 AND GQ.LockedByRef is not null AND GQ.UTCLockedOn < DATEADD(hh,-1,GETUTCDATE())))	
	AND (@IsReAssign IS NULL OR @IsReAssign = 0 OR (@IsReAssign = 1 AND GQ.LockedByRef is null AND ((GQ.AssignedToRef IS NOT NULL AND GQ.MostRecentWorkQueueLkup = 10074) OR (GQ.PendedbyRef IS NOT NULL AND GQ.MostRecentWorkQueueLkup = 10081))))			
End
ELSE
Begin
Select DISTINCT TOP (@TopCount)
	GEN_QueueId as WorkItemID,
	[dbo].[GetAge](GQ.[GEN_QueueId]) AS Aging,
	GQ.MemberSCCCode as MemberSCCCode,
	GQ.MemberID as MemberID,
	GQ.MemberMedicareId as MemberCurrentHICN,
	GQ.GPSHouseholdID as GPSHouseholdID,
	GQ.MemberFirstName as MemberFirstName,
	GQ.MemberMiddleName as MemberMiddleName,
	GQ.MemberLastName as MemberLastName,
	LMContractId.LookupValue as MemberContractID,
	GQ.MemberDOB as MemberDOB,
	LMPBPId.LookupValue as MemberPBP,
	LMLOBId.LookupValue as MemberLOB,
	LMGender.LookupValue as MemberGender,
	LMDiscType.LookupValue as DiscrepancyType,
	GQ.MostRecentStatusLkup,
	LMStatus.LookupValue as MostRecentStatus,
	GQ.MostRecentWorkQueueLkup,	
	LMQueue.LookupValue as MostRecentQueue,
	LMQueueType.GroupingLookupMasterRef as QueueProgressTypeLkup,
	LMQueueProgType.LookupValue as QueueProgressType,
	LMAction.LookupValue as MostRecentAction,
	GQ.MemberMedicareId as CurrentHICN,
	GQ.EligGPSCurrentHICN as GPSHICN,
	GQ.EligMMRCurrentHICN as MMRHICN,
	LMWorkBasket.LookupValue as BusinessSegment,
	GQ.BusinessSegmentLkup, 
	LMDiscrepancy.LookupValue as DiscrepancyCategory,
	GQ.DiscrepancyCategoryLkup, 
	GQ.DiscrepancyStartDate as DiscrepancyStartDate,
	GQ.DiscrepancyEndDate as DiscrepancyEndDate,
	GEligibility.Reason as Reason,
	LMResolution.LookupValue as Resolution,
	GQ.ReferencedEligibilityCaseInd as ReferencedEligibilityCaseIndicator,
	LMMMRPBP.LookupValue as MMRPBP,
	NULL as GPSIndividualID,
	LMDiscSource.LookupValue as DiscrepancySource,
	NULL as SubmissionType,
	NULL as CTMMember,
	NULL as EGHPMember,
	NULL as RequestedEffectiveDate,
	NULL as ActionRequested,
	NULL as PotentialSubmissionDate,
	NULL as RPCSubmissionDate,
	NULL as FDRReceivedDate,
	NULL as FDRCodeReceived,
	NULL as FDRStatus,
	NULL as RPRRequestor,
	GQ.ComplianceStartDate as ComplianceStartDate,
	NULL as AdjustedComplianceStartDate,
	GQ.UTCCreatedOn,
	GQ.CreatedByRef,
	UMC.FullName as CreatedBy,
	GQ.UTCLastUpdatedOn,
	GQ.LastUpdatedByRef,
	UML.FullName as LastUpdatedBy,
	GQ.LockedByRef,
	GQ.UTCLockedOn,
	UMLock.FullName as LockedBy,
	GQ.AssignedToRef,
	GQ.UTCAssignedOn,
	UMAssign.FullName as AssignedTo,
	GQ.PendedbyRef,
	GQ.UTCPendedOn,
	UMPended.FullName as PendedBy,
	NULL as OOALetterStatusLkup,
	NULL as OOALetterStatus,
	GQ.CMSTransactionStatusLkup,
	LMCTranStatus.LookupValue as CMSTransactionStatus
	From GEN_Queue GQ with(nolock)
	LEFT JOIN GEN_EligibilityActions GEligibility with(nolock) ON GQ.GEN_QueueId=GEligibility.GEN_QueueRef
	LEFT JOIN CMN_LookupMaster LMWorkBasket with(nolock) ON GQ.BusinessSegmentLkup=LMWorkBasket.CMN_LookupMasterId And LMWorkBasket.CMN_LookupTypeRef = 1
	LEFT JOIN CMN_LookupMaster LMDiscrepancy with(nolock) ON GQ.DiscrepancyCategoryLkup=LMDiscrepancy.CMN_LookupMasterId And LMDiscrepancy.CMN_LookupTypeRef = 6
	LEFT JOIN CMN_LookupMaster LMDiscType with(nolock) ON GQ.DiscrepancyTypeLkup=LMDiscType.CMN_LookupMasterId And LMDiscType.CMN_LookupTypeRef = 7
	LEFT JOIN CMN_LookupMaster LMStatus with(nolock) ON GQ.MostRecentStatusLkup=LMStatus.CMN_LookupMasterId And LMStatus.CMN_LookupTypeRef = 20
	LEFT JOIN CMN_LookupMaster LMQueue with(nolock) ON GQ.MostRecentWorkQueueLkup=LMQueue.CMN_LookupMasterId And LMQueue.CMN_LookupTypeRef = 10
	LEFT JOIN CMN_LookupMaster LMAction with(nolock) ON GQ.MostRecentActionLkup=LMAction.CMN_LookupMasterId And LMAction.CMN_LookupTypeRef = 28
	LEFT JOIN CMN_LookupMasterCorrelations LMQueueType with(nolock) ON GQ.MostRecentWorkQueueLkup=LMQueueType.CMN_LookupMasterChildRef AND LMQueueType.CMN_LookupTypeCorrelationsRef=3
	LEFT JOIN CMN_LookupMaster LMQueueProgType with(nolock) ON LMQueueType.GroupingLookupMasterRef=LMQueueProgType.CMN_LookupMasterId AND LMQueueProgType.CMN_LookupTypeRef = 9
	LEFT JOIN CMN_LookupMaster LMContractId with(nolock) ON GQ.MemberContractIDLkup=LMContractId.CMN_LookupMasterId And LMContractId.CMN_LookupTypeRef = 11
	LEFT JOIN CMN_LookupMaster LMPBPId with(nolock) ON GQ.MemberPBPLkup=LMPBPId.CMN_LookupMasterId And LMPBPId.CMN_LookupTypeRef = 12
	LEFT JOIN CMN_LookupMaster LMLOBId with(nolock) ON GQ.MemberLOBLkup=LMLOBId.CMN_LookupMasterId	And LMLOBId.CMN_LookupTypeRef = 31
	LEFT JOIN CMN_LookupMaster LMResolution with(nolock) ON GEligibility.ResolutionLkup=LMResolution.CMN_LookupMasterId And LMResolution.CMN_LookupTypeRef = 18
	LEFT JOIN CMN_LookupMaster LMMMRPBP with(nolock) ON GQ.EligMMRPBPLkup=LMMMRPBP.CMN_LookupMasterId 
	LEFT JOIN CMN_LookupMaster LMDiscSource with(nolock) ON GQ.DiscrepancySourceLkup=LMDiscSource.CMN_LookupMasterId And LMDiscSource.CMN_LookupTypeRef = 13
	LEFT JOIN CMN_LookupMaster LMGender with(nolock) ON GQ.MemberGenderLkup=LMGender.CMN_LookupMasterId And LMGender.CMN_LookupTypeRef = 21
	LEFT JOIN CMN_LookupMaster LMCTranStatus with(nolock) ON GQ.CMSTransactionStatusLkup=LMCTranStatus.CMN_LookupMasterId And LMCTranStatus.CMN_LookupTypeRef = 55
	INNER JOIN ADM_UserMaster UMC with(nolock) ON GQ.CreatedByRef=UMC.ADM_UserMasterId
	INNER JOIN ADM_UserMaster UML with(nolock) ON GQ.LastUpdatedByRef=UML.ADM_UserMasterId
	LEFT JOIN ADM_UserMaster UMLock with(nolock) ON GQ.LockedByRef=UMLock.ADM_UserMasterId
	LEFT JOIN ADM_UserMaster UMAssign with(nolock) ON GQ.AssignedToRef=UMAssign.ADM_UserMasterId
	LEFT JOIN ADM_UserMaster UMPended with(nolock) ON GQ.PendedbyRef=UMPended.ADM_UserMasterId	
	LEFT JOIN CMN_RecordsLocked RL with(nolock) ON RL.CaseId=GQ.GEN_QueueId AND RL.ScreenLkup = 37010 AND RL.IsActive=1
	Where
		(@WorkItemId Is Null OR GQ.GEN_QueueId=@WorkItemId)
	AND GQ.IsActive=1
	AND (GEligibility.GEN_EligibilityActionsId IS NULL OR GEligibility.IsActive=1)
	AND (@IsUnlock IS NULL OR @IsUnlock = 0 OR (@IsUnlock = 1 AND GQ.LockedByRef is not null AND GQ.UTCLockedOn < DATEADD(hh,-1,GETUTCDATE())))
	AND (@IsReAssign IS NULL OR @IsReAssign = 0 OR (@IsReAssign = 1 AND GQ.LockedByRef is null AND (((@DiscrepancyCategoryLkup IS NULL AND GQ.AssignedToRef IS NOT NULL AND GQ.MostRecentWorkQueueLkup in (10097,10098,10099)) OR (@DiscrepancyCategoryLkup IS NOT NULL AND GQ.AssignedToRef IS NOT NULL AND GQ.MostRecentWorkQueueLkup = CASE WHEN @DiscrepancyCategoryLkup = 6004 THEN 10097 ELSE (CASE WHEN @DiscrepancyCategoryLkup = 6005 THEN 10099 ELSE (CASE WHEN @DiscrepancyCategoryLkup = 6006 THEN 10098 END) END) END)) OR 
		((@DiscrepancyCategoryLkup IS NULL AND GQ.PendedbyRef IS NOT NULL AND GQ.MostRecentWorkQueueLkup in (10055,10061,10065)) OR (@DiscrepancyCategoryLkup IS NOT NULL AND GQ.PendedbyRef IS NOT NULL AND GQ.MostRecentWorkQueueLkup = CASE WHEN @DiscrepancyCategoryLkup = 6004 THEN 10055 ELSE (CASE WHEN @DiscrepancyCategoryLkup = 6005 THEN 10061 ELSE (CASE WHEN @DiscrepancyCategoryLkup = 6006 THEN 10065 END) END) END)))))
	AND (@IsMassUpdate IS NULL OR @IsMassUpdate = 0 OR (@IsMassUpdate =1 AND GQ.LockedByRef is null AND GQ.UTCLockedOn IS NULL))
	AND (@BusinessSegmentLkup IS NULL OR GQ.BusinessSegmentLkup=@BusinessSegmentLkup)
	AND (@WorkBasketLkup IS NULL OR GQ.WorkBasketLkup=@WorkBasketLkup)
	AND (@DiscrepancyCategoryLkup Is Null OR GQ.DiscrepancyCategoryLkup=@DiscrepancyCategoryLkup)
	AND (@DiscrepancyTypeLkup Is Null OR GQ.DiscrepancyTypeLkup=@DiscrepancyTypeLkup)
	AND (@DiscrepancyTypeLkupNot Is Null OR GQ.DiscrepancyTypeLkup!=@DiscrepancyTypeLkupNot)
	AND (@DiscrepancySourceLkup Is Null OR GQ.DiscrepancySourceLkup=@DiscrepancySourceLkup)
	AND (@LOBLkup Is Null OR GQ.MemberLOBLkup=@LOBLkup )
	AND (@AssignedTo Is Null OR GQ.AssignedToRef=@AssignedTo)
	AND (@Queue Is Null OR GQ.MostRecentWorkQueueLkup=@Queue)
	AND (@GPSHouseholdId Is Null OR GQ.GPSHouseholdID=@GPSHouseholdId)
	AND (@CurrentHICN Is Null OR GQ.MemberCurrentHICN = @CurrentHICN OR GQ.EligGPSCurrentHICN = @CurrentHICN OR GQ.EligMMRCurrentHICN = @CurrentHICN  OR GQ.[MemberMedicareId] = @CurrentHICN)
	AND (@ContractIDLkup Is Null OR GQ.MemberContractIDLkup =@ContractIDLkup OR GQ.EligGPSContractIDLkup =@ContractIDLkup OR GQ.EligMMRContractIDLkup = @ContractIDLkup)
	AND (@PBPLkup Is Null OR GQ.MemberPBPLkup =@PBPLkup OR GQ.EligGPSPBPLkup =@PBPLkup OR GQ.EligMMRPBPLkup = @PBPLkup)
	AND (@Status Is Null OR GQ.MostRecentStatusLkup=@Status) AND (@StatusNot IS NULL OR GQ.MostRecentStatusLkup !=@StatusNot)
	AND (@MemberSCCCode Is Null OR GQ.MemberSCCCode=@MemberSCCCode)
	AND (@FirstName  Is Null OR GQ.MemberFirstName like '%'+@FirstName+'%' )
	AND (@LastName  Is Null OR GQ.MemberLastName like '%'+@LastName+'%' )
	AND (@GenderLkup IS NULL OR GQ.MemberGenderLkup=@GenderLkup)
	AND (@DOBId Is Null OR GQ.MemberDOBId=@DOBId)
	AND (@DiscrepancyStartDateId Is Null OR GQ.DiscrepancyStartDateId>=@DiscrepancyStartDateId)
	AND (@DiscrepancyEndDateId Is Null OR GQ.DiscrepancyStartDateId<=@DiscrepancyEndDateId)
	AND (@ComplianceStartDateId  Is Null OR GQ.ComplianceStartDateId>=@ComplianceStartDateId)
	AND (@ComplianceEndDateId Is Null OR GQ.ComplianceStartDateId<=@ComplianceEndDateId )	
	AND (@CaseCreationStartDateId Is Null OR GQ.UTCCreatedOnId>=@CaseCreationStartDateId)
	AND (@CaseCreationEndDateId Is Null OR GQ.UTCCreatedOnId<=@CaseCreationEndDateId)
	AND (@CaseLastUpdatedStartDateId Is Null OR GQ.UTCLastUpdatedOnId>=@CaseLastUpdatedStartDateId)
	AND (@CaseLastUpdatedEndDateId Is Null OR GQ.UTCLastUpdatedOnId<=@CaseLastUpdatedEndDateId)
	AND (@CaseAgeFrom  Is Null OR Aging>=@CaseAgeFrom)
	AND (@CaseAgeTo Is Null OR Aging<=@CaseAgeTo)	
	AND (@PendReason Is Null OR GEligibility.PendReasonLkup=@PendReason)
	AND (@Resolution Is Null OR GEligibility.ResolutionLkup=@Resolution)
	AND (@VerifiedRootCause Is Null OR GEligibility.RootCauseLkup=@VerifiedRootCause)
	AND (@LastUpdatedOperator Is Null OR GQ.LastUpdatedByRef=@LastUpdatedOperator)
	AND (@PeerAuditCompletionStartDateId Is Null OR GQ.PeerAuditCompletedDateId >= @PeerAuditCompletionStartDateId)
	AND (@PeerAuditCompletionEndDateId Is Null OR GQ.PeerAuditCompletedDateId <= @PeerAuditCompletionEndDateId)
	AND (@IsRestricted = 1 OR (@IsRestricted = 0 AND (GQ.IsRestricted = 0 OR GQ.IsRestricted IS NULL)))

	SELECT DISTINCT COUNT(*) AS TotalRecords
    ,COUNT(CASE WHEN (IsRestricted=1)  THEN 1 END) AS RestrictedRecords
	,COUNT(CASE WHEN (IsRestricted=0 OR IsRestricted IS NULL)  THEN 1 END) AS UnRestrictedRecords
	From GEN_Queue GQ with(nolock)
	LEFT JOIN GEN_EligibilityActions GEligibility with(nolock) ON GQ.GEN_QueueId=GEligibility.GEN_QueueRef
	LEFT JOIN CMN_RecordsLocked RL with(nolock) ON RL.CaseId=GQ.GEN_QueueId AND RL.ScreenLkup = 37010 AND RL.IsActive=1
	Where
	(@WorkItemId Is Null OR GQ.GEN_QueueId=@WorkItemId)
	AND GQ.IsActive=1
	AND (GEligibility.GEN_EligibilityActionsId IS NULL OR GEligibility.IsActive=1)
	AND (@IsUnlock IS NULL OR @IsUnlock = 0 OR (@IsUnlock = 1 AND GQ.LockedByRef is not null AND GQ.UTCLockedOn < DATEADD(hh,-1,GETUTCDATE())))
	AND (@IsReAssign IS NULL OR @IsReAssign = 0 OR (@IsReAssign = 1 AND GQ.LockedByRef is null AND (((@DiscrepancyCategoryLkup IS NULL AND GQ.AssignedToRef IS NOT NULL AND GQ.MostRecentWorkQueueLkup in (10097,10098,10099)) OR (@DiscrepancyCategoryLkup IS NOT NULL AND GQ.AssignedToRef IS NOT NULL AND GQ.MostRecentWorkQueueLkup = CASE WHEN @DiscrepancyCategoryLkup = 6004 THEN 10097 ELSE (CASE WHEN @DiscrepancyCategoryLkup = 6005 THEN 10099 ELSE (CASE WHEN @DiscrepancyCategoryLkup = 6006 THEN 10098 END) END) END)) OR 
		((@DiscrepancyCategoryLkup IS NULL AND GQ.PendedbyRef IS NOT NULL AND GQ.MostRecentWorkQueueLkup in (10055,10061,10065)) OR (@DiscrepancyCategoryLkup IS NOT NULL AND GQ.PendedbyRef IS NOT NULL AND GQ.MostRecentWorkQueueLkup = CASE WHEN @DiscrepancyCategoryLkup = 6004 THEN 10055 ELSE (CASE WHEN @DiscrepancyCategoryLkup = 6005 THEN 10061 ELSE (CASE WHEN @DiscrepancyCategoryLkup = 6006 THEN 10065 END) END) END)))))
	AND (@IsMassUpdate IS NULL OR @IsMassUpdate = 0 OR (@IsMassUpdate =1 AND GQ.LockedByRef is null AND GQ.UTCLockedOn IS NULL))
	AND (@BusinessSegmentLkup IS NULL OR GQ.BusinessSegmentLkup=@BusinessSegmentLkup)
	AND (@WorkBasketLkup IS NULL OR GQ.WorkBasketLkup=@WorkBasketLkup)
	AND (@DiscrepancyCategoryLkup Is Null OR GQ.DiscrepancyCategoryLkup=@DiscrepancyCategoryLkup)
	AND (@DiscrepancyTypeLkup Is Null OR GQ.DiscrepancyTypeLkup=@DiscrepancyTypeLkup)
	AND (@DiscrepancyTypeLkupNot Is Null OR GQ.DiscrepancyTypeLkup!=@DiscrepancyTypeLkupNot)
	AND (@DiscrepancySourceLkup Is Null OR GQ.DiscrepancySourceLkup=@DiscrepancySourceLkup)
	AND (@LOBLkup Is Null OR GQ.MemberLOBLkup=@LOBLkup )
	AND (@AssignedTo Is Null OR GQ.AssignedToRef=@AssignedTo)
	AND (@Queue Is Null OR GQ.MostRecentWorkQueueLkup=@Queue)
	AND (@GPSHouseholdId Is Null OR GQ.GPSHouseholdID=@GPSHouseholdId)
	AND (@CurrentHICN Is Null OR GQ.MemberCurrentHICN = @CurrentHICN OR GQ.EligGPSCurrentHICN = @CurrentHICN OR GQ.EligMMRCurrentHICN = @CurrentHICN  OR GQ.[MemberMedicareId] = @CurrentHICN)
	AND (@ContractIDLkup Is Null OR GQ.MemberContractIDLkup =@ContractIDLkup OR GQ.EligGPSContractIDLkup =@ContractIDLkup OR GQ.EligMMRContractIDLkup = @ContractIDLkup)
	AND (@PBPLkup Is Null OR GQ.MemberPBPLkup =@PBPLkup OR GQ.EligGPSPBPLkup =@PBPLkup OR GQ.EligMMRPBPLkup = @PBPLkup)
	AND (@Status Is Null OR GQ.MostRecentStatusLkup=@Status) AND (@StatusNot IS NULL OR GQ.MostRecentStatusLkup !=@StatusNot)
	AND (@MemberSCCCode Is Null OR GQ.MemberSCCCode=@MemberSCCCode)
	AND (@FirstName  Is Null OR GQ.MemberFirstName like '%'+@FirstName+'%' )
	AND (@LastName  Is Null OR GQ.MemberLastName like '%'+@LastName+'%' )
	AND (@GenderLkup IS NULL OR GQ.MemberGenderLkup=@GenderLkup)
	AND (@DOBId Is Null OR GQ.MemberDOBId=@DOBId)
	AND (@DiscrepancyStartDateId Is Null OR GQ.DiscrepancyStartDateId>=@DiscrepancyStartDateId)
	AND (@DiscrepancyEndDateId Is Null OR GQ.DiscrepancyStartDateId<=@DiscrepancyEndDateId)
	AND (@ComplianceStartDateId  Is Null OR GQ.ComplianceStartDateId>=@ComplianceStartDateId)
	AND (@ComplianceEndDateId Is Null OR GQ.ComplianceStartDateId<=@ComplianceEndDateId )	
	AND (@CaseCreationStartDateId Is Null OR GQ.UTCCreatedOnId>=@CaseCreationStartDateId)
	AND (@CaseCreationEndDateId Is Null OR GQ.UTCCreatedOnId<=@CaseCreationEndDateId)
	AND (@CaseLastUpdatedStartDateId Is Null OR GQ.UTCLastUpdatedOnId>=@CaseLastUpdatedStartDateId)
	AND (@CaseLastUpdatedEndDateId Is Null OR GQ.UTCLastUpdatedOnId<=@CaseLastUpdatedEndDateId)
	AND (@CaseAgeFrom  Is Null OR Aging>=@CaseAgeFrom)
	AND (@CaseAgeTo Is Null OR Aging<=@CaseAgeTo)	
	AND (@PendReason Is Null OR GEligibility.PendReasonLkup=@PendReason)
	AND (@Resolution Is Null OR GEligibility.ResolutionLkup=@Resolution)
	AND (@VerifiedRootCause Is Null OR GEligibility.RootCauseLkup=@VerifiedRootCause)
	AND (@LastUpdatedOperator Is Null OR GQ.LastUpdatedByRef=@LastUpdatedOperator)
	AND (@PeerAuditCompletionStartDateId Is Null OR GQ.PeerAuditCompletedDateId >= @PeerAuditCompletionStartDateId)
	AND (@PeerAuditCompletionEndDateId Is Null OR GQ.PeerAuditCompletedDateId <= @PeerAuditCompletionEndDateId)
End

END

ELSE IF @PageType IS NOT NULL AND @PageType=3003--RPR
BEGIN
IF(@IsERSIdSelected = 1)
Begin
Select DISTINCT TOP (@TopCount)
	GEN_QueueId as WorkItemID,
	[dbo].[GetAge](GQ.[GEN_QueueId]) AS Aging,
	GQ.MemberSCCCode as MemberSCCCode,
	GQ.MemberID as MemberID,
	GQ.MemberMedicareId as MemberCurrentHICN,
	GQ.GPSHouseholdID as GPSHouseholdID,
	GQ.MemberFirstName as MemberFirstName,
	GQ.MemberMiddleName as MemberMiddleName,
	GQ.MemberLastName as MemberLastName,
	LMContractId.LookupValue as MemberContractID,
	GQ.MemberDOB as MemberDOB,
	LMPBPId.LookupValue as MemberPBP,
	LMLOBId.LookupValue as MemberLOB,
	LMGender.LookupValue as MemberGender,
	LMAction.LookupValue as MostRecentAction,
	GQ.MemberMedicareId as CurrentHICN,
	NULL as GPSHICN,
	NULL as MMRHICN,
	LMWorkBasket.LookupValue as BusinessSegment,
	GQ.BusinessSegmentLkup, 
	LMDiscrepancy.LookupValue as DiscrepancyCategory,
	GQ.DiscrepancyCategoryLkup, 
	LMDiscType.LookupValue as DiscrepancyType,
	GQ.MostRecentStatusLkup,
	LMStatus.LookupValue as MostRecentStatus,	
	GQ.MostRecentWorkQueueLkup,
	LMQueue.LookupValue as MostRecentQueue,
	LMQueueType.GroupingLookupMasterRef as QueueProgressTypeLkup,
	LMQueueProgType.LookupValue as QueueProgressType,
	GQ.DiscrepancyStartDate as DiscrepancyStartDate,
	GQ.DiscrepancyEndDate as DiscrepancyEndDate,
	NULL as Reason,
	LMResolution.LookupValue as Resolution,
	NULL as ReferencedEligibilityCaseIndicator,
	NULL as MMRPBP,
	NULL as GPSIndividualID,
	LMDiscSource.LookupValue as DiscrepancySource,
	LMSubmissionType.LookupValue as SubmissionType,
	GQ.RPRCTMMember as CTMMember,
	GQ.RPREGHPMember as EGHPMember,
	GQ.RPRRequestedEffectiveDate as RequestedEffectiveDate,
	GQ.RPRActionRequestedLkup as RPRActionRequestedLkup,
	LMActionRequested.LookupValue as ActionRequested,
	LMElectionType.LookupValue as ElectionType,
	GRPR.PotentialSubmissionDate as PotentialSubmissionDate,
	GRPR.RPCSubmissionDate as RPCSubmissionDate,
	GRPR.FDRReceivedDate as FDRReceivedDate,
	GRPR.FDRCodeReceived as FDRCodeReceived,
	UMC.FullName as RPRRequestor,
	GQ.ComplianceStartDate as ComplianceStartDate,
	NULL as AdjustedComplianceStartDate,
	GQ.UTCCreatedOn,
	GQ.CreatedByRef,
	UMC.FullName as CreatedBy,
	GQ.UTCLastUpdatedOn,
	GQ.LastUpdatedByRef,
	UML.FullName as LastUpdatedBy,
	GQ.LockedByRef,
	GQ.UTCLockedOn,
	UMLock.FullName as LockedBy,
	GQ.AssignedToRef,
	GQ.UTCAssignedOn,
	UMAssign.FullName as AssignedTo,
	GQ.PendedbyRef,
	GQ.UTCPendedOn,
	UMPended.FullName as PendedBy,
	NULL as OOALetterStatusLkup,
	NULL as OOALetterStatus,
	GQ.CMSTransactionStatusLkup,
	LMCTranStatus.LookupValue as CMSTransactionStatus
	From GEN_Queue GQ with(nolock)
	LEFT JOIN GEN_RPRActions GRPR with(nolock) ON GQ.GEN_QueueId=GRPR.GEN_QueueRef 
	LEFT JOIN CMN_LookupMaster LMWorkBasket with(nolock) ON GQ.BusinessSegmentLkup=LMWorkBasket.CMN_LookupMasterId And LMWorkBasket.CMN_LookupTypeRef = 1
	LEFT JOIN CMN_LookupMaster LMDiscrepancy with(nolock) ON GQ.DiscrepancyCategoryLkup=LMDiscrepancy.CMN_LookupMasterId And LMDiscrepancy.CMN_LookupTypeRef = 6
	LEFT JOIN CMN_LookupMaster LMDiscType with(nolock) ON GQ.DiscrepancyTypeLkup=LMDiscType.CMN_LookupMasterId And LMDiscType.CMN_LookupTypeRef = 7
	LEFT JOIN CMN_RecordsLocked RL with(nolock) ON RL.CaseId=GQ.GEN_QueueId AND RL.ScreenLkup = 37010 AND RL.IsActive=1
	LEFT JOIN CMN_LookupMaster LMAction with(nolock) ON GQ.MostRecentActionLkup=LMAction.CMN_LookupMasterId And LMAction.CMN_LookupTypeRef = 28
	LEFT JOIN CMN_LookupMaster LMStatus with(nolock) ON GQ.MostRecentStatusLkup=LMStatus.CMN_LookupMasterId And LMStatus.CMN_LookupTypeRef = 20
	LEFT JOIN CMN_LookupMaster LMQueue with(nolock) ON GQ.MostRecentWorkQueueLkup=LMQueue.CMN_LookupMasterId And LMQueue.CMN_LookupTypeRef = 10
	LEFT JOIN CMN_LookupMasterCorrelations LMQueueType with(nolock) ON GQ.MostRecentWorkQueueLkup=LMQueueType.CMN_LookupMasterChildRef AND LMQueueType.CMN_LookupTypeCorrelationsRef=3
	LEFT JOIN CMN_LookupMaster LMQueueProgType with(nolock) ON LMQueueType.GroupingLookupMasterRef=LMQueueProgType.CMN_LookupMasterId AND LMQueueProgType.CMN_LookupTypeRef = 9
	LEFT JOIN CMN_LookupMaster LMContractId with(nolock) ON GQ.MemberContractIDLkup=LMContractId.CMN_LookupMasterId And LMContractId.CMN_LookupTypeRef = 11
	LEFT JOIN CMN_LookupMaster LMPBPId with(nolock) ON GQ.MemberPBPLkup=LMPBPId.CMN_LookupMasterId And LMPBPId.CMN_LookupTypeRef = 12
	LEFT JOIN CMN_LookupMaster LMLOBId with(nolock) ON GQ.MemberLOBLkup=LMLOBId.CMN_LookupMasterId And LMLOBId.CMN_LookupTypeRef = 31
	LEFT JOIN CMN_LookupMaster LMActionRequested with(nolock) ON GQ.RPRActionRequestedLkup=LMActionRequested.CMN_LookupMasterId And LMActionRequested.CMN_LookupTypeRef = 14
	LEFT JOIN CMN_LookupMaster LMResolution with(nolock) ON GRPR.ResolutionLkup=LMResolution.CMN_LookupMasterId And LMResolution.CMN_LookupTypeRef = 18
	LEFT JOIN CMN_LookupMaster LMDiscSource with(nolock) ON GQ.DiscrepancySourceLkup=LMDiscSource.CMN_LookupMasterId	And LMDiscSource.CMN_LookupTypeRef = 13
	LEFT JOIN CMN_LookupMaster LMSubmissionType with(nolock) ON GRPR.SubmissionTypeLkup=LMSubmissionType.CMN_LookupMasterId And LMSubmissionType.CMN_LookupTypeRef = 17
	LEFT JOIN CMN_LookupMaster LMGender with(nolock) ON GQ.MemberGenderLkup=LMGender.CMN_LookupMasterId And LMGender.CMN_LookupTypeRef = 21
	LEFT JOIN CMN_LookupMaster LMElectionType with(nolock) ON GRPR.ElectionTypeLkup=LMElectionType.CMN_LookupMasterId And LMElectionType.CMN_LookupTypeRef = 23
	LEFT JOIN CMN_LookupMaster LMCTranStatus with(nolock) ON GQ.CMSTransactionStatusLkup=LMCTranStatus.CMN_LookupMasterId And LMCTranStatus.CMN_LookupTypeRef = 55
	INNER JOIN ADM_UserMaster UMC with(nolock) ON GQ.CreatedByRef=UMC.ADM_UserMasterId
	INNER JOIN ADM_UserMaster UML with(nolock) ON GQ.LastUpdatedByRef=UML.ADM_UserMasterId
	INNER JOIN ADM_UserMaster UMSupervior with(nolock) ON GQ.RPRSupervisorOrRequesterRef=UMSupervior.ADM_UserMasterId
	LEFT JOIN ADM_UserMaster UMLock with(nolock) ON GQ.LockedByRef=UMLock.ADM_UserMasterId
	LEFT JOIN ADM_UserMaster UMAssign with(nolock) ON GQ.AssignedToRef=UMAssign.ADM_UserMasterId
	LEFT JOIN ADM_UserMaster UMPended with(nolock) ON GQ.PendedbyRef=UMPended.ADM_UserMasterId
		
	Where
	GQ.GEN_QueueId=@WorkItemId
	AND GQ.IsActive=1
	AND (@IsUnlock IS NULL OR @IsUnlock = 0 OR (@IsUnlock = 1 AND GQ.LockedByRef is not null AND GQ.UTCLockedOn < DATEADD(hh,-1,GETUTCDATE())))	
	AND (@IsReAssign IS NULL OR @IsReAssign = 0 OR (@IsReAssign = 1 AND GQ.LockedByRef is null AND ((GQ.AssignedToRef IS NOT NULL AND GQ.MostRecentWorkQueueLkup = 10074) OR (GQ.PendedbyRef IS NOT NULL AND GQ.MostRecentWorkQueueLkup = 10081))))
	AND (@IsRestricted = 1 OR (@IsRestricted = 0 AND (GQ.IsRestricted = 0 OR GQ.IsRestricted IS NULL)))

	SELECT DISTINCT COUNT(*) AS TotalRecords
    ,COUNT(CASE WHEN (IsRestricted=1)  THEN 1 END) AS RestrictedRecords
	,COUNT(CASE WHEN (IsRestricted=0 OR IsRestricted IS NULL)  THEN 1 END) AS UnRestrictedRecords
	From GEN_Queue GQ with(nolock)
	LEFT JOIN GEN_RPRActions GRPR with(nolock) ON GQ.GEN_QueueId=GRPR.GEN_QueueRef
	LEFT JOIN CMN_RecordsLocked RL with(nolock) ON RL.CaseId=GQ.GEN_QueueId AND RL.ScreenLkup = 37010 AND RL.IsActive=1
	Where
	GQ.GEN_QueueId=@WorkItemId
	AND GQ.IsActive=1
	AND (@IsUnlock IS NULL OR @IsUnlock = 0 OR (@IsUnlock = 1 AND GQ.LockedByRef is not null AND GQ.UTCLockedOn < DATEADD(hh,-1,GETUTCDATE())))	
	AND (@IsReAssign IS NULL OR @IsReAssign = 0 OR (@IsReAssign = 1 AND GQ.LockedByRef is null AND ((GQ.AssignedToRef IS NOT NULL AND GQ.MostRecentWorkQueueLkup = 10074) OR (GQ.PendedbyRef IS NOT NULL AND GQ.MostRecentWorkQueueLkup = 10081))))
End
ELSE IF(@IsMedicareIdSelected =1) 	
Begin
Select DISTINCT TOP (@TopCount)
	GEN_QueueId as WorkItemID,
	[dbo].[GetAge](GQ.[GEN_QueueId]) AS Aging,
	GQ.MemberSCCCode as MemberSCCCode,
	GQ.MemberID as MemberID,
	GQ.MemberMedicareId as MemberCurrentHICN,
	GQ.GPSHouseholdID as GPSHouseholdID,
	GQ.MemberFirstName as MemberFirstName,
	GQ.MemberMiddleName as MemberMiddleName,
	GQ.MemberLastName as MemberLastName,
	LMContractId.LookupValue as MemberContractID,
	GQ.MemberDOB as MemberDOB,
	LMPBPId.LookupValue as MemberPBP,
	LMLOBId.LookupValue as MemberLOB,
	LMGender.LookupValue as MemberGender,
	LMAction.LookupValue as MostRecentAction,
	GQ.MemberMedicareId as CurrentHICN,
	NULL as GPSHICN,
	NULL as MMRHICN,
	LMWorkBasket.LookupValue as BusinessSegment,
	GQ.BusinessSegmentLkup, 
	LMDiscrepancy.LookupValue as DiscrepancyCategory,
	GQ.DiscrepancyCategoryLkup, 
	LMDiscType.LookupValue as DiscrepancyType,
	GQ.MostRecentStatusLkup,
	LMStatus.LookupValue as MostRecentStatus,	
	GQ.MostRecentWorkQueueLkup,
	LMQueue.LookupValue as MostRecentQueue,
	LMQueueType.GroupingLookupMasterRef as QueueProgressTypeLkup,
	LMQueueProgType.LookupValue as QueueProgressType,
	GQ.DiscrepancyStartDate as DiscrepancyStartDate,
	GQ.DiscrepancyEndDate as DiscrepancyEndDate,
	NULL as Reason,
	LMResolution.LookupValue as Resolution,
	NULL as ReferencedEligibilityCaseIndicator,
	NULL as MMRPBP,
	NULL as GPSIndividualID,
	LMDiscSource.LookupValue as DiscrepancySource,
	LMSubmissionType.LookupValue as SubmissionType,
	GQ.RPRCTMMember as CTMMember,
	GQ.RPREGHPMember as EGHPMember,
	GQ.RPRRequestedEffectiveDate as RequestedEffectiveDate,
	GQ.RPRActionRequestedLkup as RPRActionRequestedLkup,
	LMActionRequested.LookupValue as ActionRequested,
	LMElectionType.LookupValue as ElectionType,
	GRPR.PotentialSubmissionDate as PotentialSubmissionDate,
	GRPR.RPCSubmissionDate as RPCSubmissionDate,
	GRPR.FDRReceivedDate as FDRReceivedDate,
	GRPR.FDRCodeReceived as FDRCodeReceived,
	UMC.FullName as RPRRequestor,
	GQ.ComplianceStartDate as ComplianceStartDate,
	NULL as AdjustedComplianceStartDate,
	GQ.UTCCreatedOn,
	GQ.CreatedByRef,
	UMC.FullName as CreatedBy,
	GQ.UTCLastUpdatedOn,
	GQ.LastUpdatedByRef,
	UML.FullName as LastUpdatedBy,
	GQ.LockedByRef,
	GQ.UTCLockedOn,
	UMLock.FullName as LockedBy,
	GQ.AssignedToRef,
	GQ.UTCAssignedOn,
	UMAssign.FullName as AssignedTo,
	GQ.PendedbyRef,
	GQ.UTCPendedOn,
	UMPended.FullName as PendedBy,
	NULL as OOALetterStatusLkup,
	NULL as OOALetterStatus,
	GQ.CMSTransactionStatusLkup,
	LMCTranStatus.LookupValue as CMSTransactionStatus
	From GEN_Queue GQ with(nolock)
	LEFT JOIN GEN_RPRActions GRPR with(nolock) ON GQ.GEN_QueueId=GRPR.GEN_QueueRef 
	LEFT JOIN CMN_LookupMaster LMWorkBasket with(nolock) ON GQ.BusinessSegmentLkup=LMWorkBasket.CMN_LookupMasterId And LMWorkBasket.CMN_LookupTypeRef = 1
	LEFT JOIN CMN_LookupMaster LMDiscrepancy with(nolock) ON GQ.DiscrepancyCategoryLkup=LMDiscrepancy.CMN_LookupMasterId And LMDiscrepancy.CMN_LookupTypeRef = 6
	LEFT JOIN CMN_LookupMaster LMDiscType with(nolock) ON GQ.DiscrepancyTypeLkup=LMDiscType.CMN_LookupMasterId And LMDiscType.CMN_LookupTypeRef = 7
	LEFT JOIN CMN_RecordsLocked RL with(nolock) ON RL.CaseId=GQ.GEN_QueueId AND RL.ScreenLkup = 37010 AND RL.IsActive=1
	LEFT JOIN CMN_LookupMaster LMAction with(nolock) ON GQ.MostRecentActionLkup=LMAction.CMN_LookupMasterId And LMAction.CMN_LookupTypeRef = 28
	LEFT JOIN CMN_LookupMaster LMStatus with(nolock) ON GQ.MostRecentStatusLkup=LMStatus.CMN_LookupMasterId And LMStatus.CMN_LookupTypeRef = 20
	LEFT JOIN CMN_LookupMaster LMQueue with(nolock) ON GQ.MostRecentWorkQueueLkup=LMQueue.CMN_LookupMasterId And LMQueue.CMN_LookupTypeRef = 10
	LEFT JOIN CMN_LookupMasterCorrelations LMQueueType with(nolock) ON GQ.MostRecentWorkQueueLkup=LMQueueType.CMN_LookupMasterChildRef AND LMQueueType.CMN_LookupTypeCorrelationsRef=3
	LEFT JOIN CMN_LookupMaster LMQueueProgType with(nolock) ON LMQueueType.GroupingLookupMasterRef=LMQueueProgType.CMN_LookupMasterId AND LMQueueProgType.CMN_LookupTypeRef = 9
	LEFT JOIN CMN_LookupMaster LMContractId with(nolock) ON GQ.MemberContractIDLkup=LMContractId.CMN_LookupMasterId And LMContractId.CMN_LookupTypeRef = 11
	LEFT JOIN CMN_LookupMaster LMPBPId with(nolock) ON GQ.MemberPBPLkup=LMPBPId.CMN_LookupMasterId And LMPBPId.CMN_LookupTypeRef = 12
	LEFT JOIN CMN_LookupMaster LMLOBId with(nolock) ON GQ.MemberLOBLkup=LMLOBId.CMN_LookupMasterId And LMLOBId.CMN_LookupTypeRef = 31
	LEFT JOIN CMN_LookupMaster LMActionRequested with(nolock) ON GQ.RPRActionRequestedLkup=LMActionRequested.CMN_LookupMasterId And LMActionRequested.CMN_LookupTypeRef = 14
	LEFT JOIN CMN_LookupMaster LMResolution with(nolock) ON GRPR.ResolutionLkup=LMResolution.CMN_LookupMasterId And LMResolution.CMN_LookupTypeRef = 18
	LEFT JOIN CMN_LookupMaster LMDiscSource with(nolock) ON GQ.DiscrepancySourceLkup=LMDiscSource.CMN_LookupMasterId	And LMDiscSource.CMN_LookupTypeRef = 13
	LEFT JOIN CMN_LookupMaster LMSubmissionType with(nolock) ON GRPR.SubmissionTypeLkup=LMSubmissionType.CMN_LookupMasterId And LMSubmissionType.CMN_LookupTypeRef = 17
	LEFT JOIN CMN_LookupMaster LMGender with(nolock) ON GQ.MemberGenderLkup=LMGender.CMN_LookupMasterId And LMGender.CMN_LookupTypeRef = 21
	LEFT JOIN CMN_LookupMaster LMElectionType with(nolock) ON GRPR.ElectionTypeLkup=LMElectionType.CMN_LookupMasterId And LMElectionType.CMN_LookupTypeRef = 23
	LEFT JOIN CMN_LookupMaster LMCTranStatus with(nolock) ON GQ.CMSTransactionStatusLkup=LMCTranStatus.CMN_LookupMasterId And LMCTranStatus.CMN_LookupTypeRef = 55
	INNER JOIN ADM_UserMaster UMC with(nolock) ON GQ.CreatedByRef=UMC.ADM_UserMasterId
	INNER JOIN ADM_UserMaster UML with(nolock) ON GQ.LastUpdatedByRef=UML.ADM_UserMasterId
	INNER JOIN ADM_UserMaster UMSupervior with(nolock) ON GQ.RPRSupervisorOrRequesterRef=UMSupervior.ADM_UserMasterId
	LEFT JOIN ADM_UserMaster UMLock with(nolock) ON GQ.LockedByRef=UMLock.ADM_UserMasterId
	LEFT JOIN ADM_UserMaster UMAssign with(nolock) ON GQ.AssignedToRef=UMAssign.ADM_UserMasterId
	LEFT JOIN ADM_UserMaster UMPended with(nolock) ON GQ.PendedbyRef=UMPended.ADM_UserMasterId
		
	Where
	GQ.IsActive=1
	AND (GQ.MemberCurrentHICN = @CurrentHICN OR GQ.EligGPSCurrentHICN = @CurrentHICN OR GQ.EligMMRCurrentHICN = @CurrentHICN OR GQ.[MemberMedicareId] = @CurrentHICN)
	AND (@IsUnlock IS NULL OR @IsUnlock = 0 OR (@IsUnlock = 1 AND GQ.LockedByRef is not null AND GQ.UTCLockedOn < DATEADD(hh,-1,GETUTCDATE())))	
	AND (@IsReAssign IS NULL OR @IsReAssign = 0 OR (@IsReAssign = 1 AND GQ.LockedByRef is null AND ((GQ.AssignedToRef IS NOT NULL AND GQ.MostRecentWorkQueueLkup = 10074) OR (GQ.PendedbyRef IS NOT NULL AND GQ.MostRecentWorkQueueLkup = 10081))))
	AND (@IsRestricted = 1 OR (@IsRestricted = 0 AND (GQ.IsRestricted = 0 OR GQ.IsRestricted IS NULL))) 

	SELECT DISTINCT COUNT(*) AS TotalRecords
    ,COUNT(CASE WHEN (IsRestricted=1)  THEN 1 END) AS RestrictedRecords
	,COUNT(CASE WHEN (IsRestricted=0 OR IsRestricted IS NULL)  THEN 1 END) AS UnRestrictedRecords
	From GEN_Queue GQ with(nolock)
	LEFT JOIN GEN_RPRActions GRPR with(nolock) ON GQ.GEN_QueueId=GRPR.GEN_QueueRef
	LEFT JOIN CMN_RecordsLocked RL with(nolock) ON RL.CaseId=GQ.GEN_QueueId AND RL.ScreenLkup = 37010 AND RL.IsActive=1
	Where
	GQ.IsActive=1
	AND (GQ.MemberCurrentHICN = @CurrentHICN OR GQ.EligGPSCurrentHICN = @CurrentHICN OR GQ.EligMMRCurrentHICN = @CurrentHICN OR GQ.[MemberMedicareId] = @CurrentHICN)
	AND (@IsUnlock IS NULL OR @IsUnlock = 0 OR (@IsUnlock = 1 AND GQ.LockedByRef is not null AND GQ.UTCLockedOn < DATEADD(hh,-1,GETUTCDATE())))	
	AND (@IsReAssign IS NULL OR @IsReAssign = 0 OR (@IsReAssign = 1 AND GQ.LockedByRef is null AND ((GQ.AssignedToRef IS NOT NULL AND GQ.MostRecentWorkQueueLkup = 10074) OR (GQ.PendedbyRef IS NOT NULL AND GQ.MostRecentWorkQueueLkup = 10081))))
End
ELSE IF(@IsBothCaseAndMedicareIdSelected = 1) 	
Begin
Select DISTINCT TOP (@TopCount)
	GEN_QueueId as WorkItemID,
	[dbo].[GetAge](GQ.[GEN_QueueId]) AS Aging,
	GQ.MemberSCCCode as MemberSCCCode,
	GQ.MemberID as MemberID,
	GQ.MemberMedicareId as MemberCurrentHICN,
	GQ.GPSHouseholdID as GPSHouseholdID,
	GQ.MemberFirstName as MemberFirstName,
	GQ.MemberMiddleName as MemberMiddleName,
	GQ.MemberLastName as MemberLastName,
	LMContractId.LookupValue as MemberContractID,
	GQ.MemberDOB as MemberDOB,
	LMPBPId.LookupValue as MemberPBP,
	LMLOBId.LookupValue as MemberLOB,
	LMGender.LookupValue as MemberGender,
	LMAction.LookupValue as MostRecentAction,
	GQ.MemberMedicareId as CurrentHICN,
	NULL as GPSHICN,
	NULL as MMRHICN,
	LMWorkBasket.LookupValue as BusinessSegment,
	GQ.BusinessSegmentLkup, 
	LMDiscrepancy.LookupValue as DiscrepancyCategory,
	GQ.DiscrepancyCategoryLkup, 
	LMDiscType.LookupValue as DiscrepancyType,
	GQ.MostRecentStatusLkup,
	LMStatus.LookupValue as MostRecentStatus,	
	GQ.MostRecentWorkQueueLkup,
	LMQueue.LookupValue as MostRecentQueue,
	LMQueueType.GroupingLookupMasterRef as QueueProgressTypeLkup,
	LMQueueProgType.LookupValue as QueueProgressType,
	GQ.DiscrepancyStartDate as DiscrepancyStartDate,
	GQ.DiscrepancyEndDate as DiscrepancyEndDate,
	NULL as Reason,
	LMResolution.LookupValue as Resolution,
	NULL as ReferencedEligibilityCaseIndicator,
	NULL as MMRPBP,
	NULL as GPSIndividualID,
	LMDiscSource.LookupValue as DiscrepancySource,
	LMSubmissionType.LookupValue as SubmissionType,
	GQ.RPRCTMMember as CTMMember,
	GQ.RPREGHPMember as EGHPMember,
	GQ.RPRRequestedEffectiveDate as RequestedEffectiveDate,
	GQ.RPRActionRequestedLkup as RPRActionRequestedLkup,
	LMActionRequested.LookupValue as ActionRequested,
	LMElectionType.LookupValue as ElectionType,
	GRPR.PotentialSubmissionDate as PotentialSubmissionDate,
	GRPR.RPCSubmissionDate as RPCSubmissionDate,
	GRPR.FDRReceivedDate as FDRReceivedDate,
	GRPR.FDRCodeReceived as FDRCodeReceived,
	UMC.FullName as RPRRequestor,
	GQ.ComplianceStartDate as ComplianceStartDate,
	NULL as AdjustedComplianceStartDate,
	GQ.UTCCreatedOn,
	GQ.CreatedByRef,
	UMC.FullName as CreatedBy,
	GQ.UTCLastUpdatedOn,
	GQ.LastUpdatedByRef,
	UML.FullName as LastUpdatedBy,
	GQ.LockedByRef,
	GQ.UTCLockedOn,
	UMLock.FullName as LockedBy,
	GQ.AssignedToRef,
	GQ.UTCAssignedOn,
	UMAssign.FullName as AssignedTo,
	GQ.PendedbyRef,
	GQ.UTCPendedOn,
	UMPended.FullName as PendedBy,
	NULL as OOALetterStatusLkup,
	NULL as OOALetterStatus,
	GQ.CMSTransactionStatusLkup,
	LMCTranStatus.LookupValue as CMSTransactionStatus
	From GEN_Queue GQ with(nolock)
	LEFT JOIN GEN_RPRActions GRPR with(nolock) ON GQ.GEN_QueueId=GRPR.GEN_QueueRef 
	LEFT JOIN CMN_LookupMaster LMWorkBasket with(nolock) ON GQ.BusinessSegmentLkup=LMWorkBasket.CMN_LookupMasterId And LMWorkBasket.CMN_LookupTypeRef = 1
	LEFT JOIN CMN_LookupMaster LMDiscrepancy with(nolock) ON GQ.DiscrepancyCategoryLkup=LMDiscrepancy.CMN_LookupMasterId And LMDiscrepancy.CMN_LookupTypeRef = 6
	LEFT JOIN CMN_LookupMaster LMDiscType with(nolock) ON GQ.DiscrepancyTypeLkup=LMDiscType.CMN_LookupMasterId And LMDiscType.CMN_LookupTypeRef = 7
	LEFT JOIN CMN_RecordsLocked RL with(nolock) ON RL.CaseId=GQ.GEN_QueueId AND RL.ScreenLkup = 37010 AND RL.IsActive=1
	LEFT JOIN CMN_LookupMaster LMAction with(nolock) ON GQ.MostRecentActionLkup=LMAction.CMN_LookupMasterId And LMAction.CMN_LookupTypeRef = 28
	LEFT JOIN CMN_LookupMaster LMStatus with(nolock) ON GQ.MostRecentStatusLkup=LMStatus.CMN_LookupMasterId And LMStatus.CMN_LookupTypeRef = 20
	LEFT JOIN CMN_LookupMaster LMQueue with(nolock) ON GQ.MostRecentWorkQueueLkup=LMQueue.CMN_LookupMasterId And LMQueue.CMN_LookupTypeRef = 10
	LEFT JOIN CMN_LookupMasterCorrelations LMQueueType with(nolock) ON GQ.MostRecentWorkQueueLkup=LMQueueType.CMN_LookupMasterChildRef AND LMQueueType.CMN_LookupTypeCorrelationsRef=3
	LEFT JOIN CMN_LookupMaster LMQueueProgType with(nolock) ON LMQueueType.GroupingLookupMasterRef=LMQueueProgType.CMN_LookupMasterId AND LMQueueProgType.CMN_LookupTypeRef = 9
	LEFT JOIN CMN_LookupMaster LMContractId with(nolock) ON GQ.MemberContractIDLkup=LMContractId.CMN_LookupMasterId And LMContractId.CMN_LookupTypeRef = 11
	LEFT JOIN CMN_LookupMaster LMPBPId with(nolock) ON GQ.MemberPBPLkup=LMPBPId.CMN_LookupMasterId And LMPBPId.CMN_LookupTypeRef = 12
	LEFT JOIN CMN_LookupMaster LMLOBId with(nolock) ON GQ.MemberLOBLkup=LMLOBId.CMN_LookupMasterId And LMLOBId.CMN_LookupTypeRef = 31
	LEFT JOIN CMN_LookupMaster LMActionRequested with(nolock) ON GQ.RPRActionRequestedLkup=LMActionRequested.CMN_LookupMasterId And LMActionRequested.CMN_LookupTypeRef = 14
	LEFT JOIN CMN_LookupMaster LMResolution with(nolock) ON GRPR.ResolutionLkup=LMResolution.CMN_LookupMasterId And LMResolution.CMN_LookupTypeRef = 18
	LEFT JOIN CMN_LookupMaster LMDiscSource with(nolock) ON GQ.DiscrepancySourceLkup=LMDiscSource.CMN_LookupMasterId	And LMDiscSource.CMN_LookupTypeRef = 13
	LEFT JOIN CMN_LookupMaster LMSubmissionType with(nolock) ON GRPR.SubmissionTypeLkup=LMSubmissionType.CMN_LookupMasterId And LMSubmissionType.CMN_LookupTypeRef = 17
	LEFT JOIN CMN_LookupMaster LMGender with(nolock) ON GQ.MemberGenderLkup=LMGender.CMN_LookupMasterId And LMGender.CMN_LookupTypeRef = 21
	LEFT JOIN CMN_LookupMaster LMElectionType with(nolock) ON GRPR.ElectionTypeLkup=LMElectionType.CMN_LookupMasterId And LMElectionType.CMN_LookupTypeRef = 23
	LEFT JOIN CMN_LookupMaster LMCTranStatus with(nolock) ON GQ.CMSTransactionStatusLkup=LMCTranStatus.CMN_LookupMasterId And LMCTranStatus.CMN_LookupTypeRef = 55
	INNER JOIN ADM_UserMaster UMC with(nolock) ON GQ.CreatedByRef=UMC.ADM_UserMasterId
	INNER JOIN ADM_UserMaster UML with(nolock) ON GQ.LastUpdatedByRef=UML.ADM_UserMasterId
	INNER JOIN ADM_UserMaster UMSupervior with(nolock) ON GQ.RPRSupervisorOrRequesterRef=UMSupervior.ADM_UserMasterId
	LEFT JOIN ADM_UserMaster UMLock with(nolock) ON GQ.LockedByRef=UMLock.ADM_UserMasterId
	LEFT JOIN ADM_UserMaster UMAssign with(nolock) ON GQ.AssignedToRef=UMAssign.ADM_UserMasterId
	LEFT JOIN ADM_UserMaster UMPended with(nolock) ON GQ.PendedbyRef=UMPended.ADM_UserMasterId
		
	Where
	GQ.GEN_QueueId=@WorkItemId 
	AND (GQ.MemberCurrentHICN = @CurrentHICN OR GQ.EligGPSCurrentHICN = @CurrentHICN OR GQ.EligMMRCurrentHICN = @CurrentHICN OR GQ.[MemberMedicareId] = @CurrentHICN)
	AND GQ.IsActive=1
	AND (@IsUnlock IS NULL OR @IsUnlock = 0 OR (@IsUnlock = 1 AND GQ.LockedByRef is not null AND GQ.UTCLockedOn < DATEADD(hh,-1,GETUTCDATE())))	
	AND (@IsReAssign IS NULL OR @IsReAssign = 0 OR (@IsReAssign = 1 AND GQ.LockedByRef is null AND ((GQ.AssignedToRef IS NOT NULL AND GQ.MostRecentWorkQueueLkup = 10074) OR (GQ.PendedbyRef IS NOT NULL AND GQ.MostRecentWorkQueueLkup = 10081))))	
	AND (@IsRestricted = 1 OR (@IsRestricted = 0 AND (GQ.IsRestricted = 0 OR GQ.IsRestricted IS NULL)))

	SELECT DISTINCT COUNT(*) AS TotalRecords
    ,COUNT(CASE WHEN (IsRestricted=1)  THEN 1 END) AS RestrictedRecords
	,COUNT(CASE WHEN (IsRestricted=0 OR IsRestricted IS NULL)  THEN 1 END) AS UnRestrictedRecords
	From GEN_Queue GQ with(nolock)
	LEFT JOIN GEN_RPRActions GRPR with(nolock) ON GQ.GEN_QueueId=GRPR.GEN_QueueRef
	LEFT JOIN CMN_RecordsLocked RL with(nolock) ON RL.CaseId=GQ.GEN_QueueId AND RL.ScreenLkup = 37010 AND RL.IsActive=1
	Where
	GQ.GEN_QueueId=@WorkItemId 
	AND (GQ.MemberCurrentHICN = @CurrentHICN OR GQ.EligGPSCurrentHICN = @CurrentHICN OR GQ.EligMMRCurrentHICN = @CurrentHICN OR GQ.[MemberMedicareId] = @CurrentHICN)
	AND GQ.IsActive=1
	AND (@IsUnlock IS NULL OR @IsUnlock = 0 OR (@IsUnlock = 1 AND GQ.LockedByRef is not null AND GQ.UTCLockedOn < DATEADD(hh,-1,GETUTCDATE())))	
	AND (@IsReAssign IS NULL OR @IsReAssign = 0 OR (@IsReAssign = 1 AND GQ.LockedByRef is null AND ((GQ.AssignedToRef IS NOT NULL AND GQ.MostRecentWorkQueueLkup = 10074) OR (GQ.PendedbyRef IS NOT NULL AND GQ.MostRecentWorkQueueLkup = 10081))))	
End
ELSE IF(@IsBothDiscCatAndCaseIdSelected = 1) 	
Begin
Select DISTINCT TOP (@TopCount)
	GEN_QueueId as WorkItemID,
	[dbo].[GetAge](GQ.[GEN_QueueId]) AS Aging,
	GQ.MemberSCCCode as MemberSCCCode,
	GQ.MemberID as MemberID,
	GQ.MemberMedicareId as MemberCurrentHICN,
	GQ.GPSHouseholdID as GPSHouseholdID,
	GQ.MemberFirstName as MemberFirstName,
	GQ.MemberMiddleName as MemberMiddleName,
	GQ.MemberLastName as MemberLastName,
	LMContractId.LookupValue as MemberContractID,
	GQ.MemberDOB as MemberDOB,
	LMPBPId.LookupValue as MemberPBP,
	LMLOBId.LookupValue as MemberLOB,
	LMGender.LookupValue as MemberGender,
	LMAction.LookupValue as MostRecentAction,
	GQ.MemberMedicareId as CurrentHICN,
	NULL as GPSHICN,
	NULL as MMRHICN,
	LMWorkBasket.LookupValue as BusinessSegment,
	GQ.BusinessSegmentLkup, 
	LMDiscrepancy.LookupValue as DiscrepancyCategory,
	GQ.DiscrepancyCategoryLkup, 
	LMDiscType.LookupValue as DiscrepancyType,
	GQ.MostRecentStatusLkup,
	LMStatus.LookupValue as MostRecentStatus,	
	GQ.MostRecentWorkQueueLkup,
	LMQueue.LookupValue as MostRecentQueue,
	LMQueueType.GroupingLookupMasterRef as QueueProgressTypeLkup,
	LMQueueProgType.LookupValue as QueueProgressType,
	GQ.DiscrepancyStartDate as DiscrepancyStartDate,
	GQ.DiscrepancyEndDate as DiscrepancyEndDate,
	NULL as Reason,
	LMResolution.LookupValue as Resolution,
	NULL as ReferencedEligibilityCaseIndicator,
	NULL as MMRPBP,
	NULL as GPSIndividualID,
	LMDiscSource.LookupValue as DiscrepancySource,
	LMSubmissionType.LookupValue as SubmissionType,
	GQ.RPRCTMMember as CTMMember,
	GQ.RPREGHPMember as EGHPMember,
	GQ.RPRRequestedEffectiveDate as RequestedEffectiveDate,
	GQ.RPRActionRequestedLkup as RPRActionRequestedLkup,
	LMActionRequested.LookupValue as ActionRequested,
	LMElectionType.LookupValue as ElectionType,
	GRPR.PotentialSubmissionDate as PotentialSubmissionDate,
	GRPR.RPCSubmissionDate as RPCSubmissionDate,
	GRPR.FDRReceivedDate as FDRReceivedDate,
	GRPR.FDRCodeReceived as FDRCodeReceived,
	UMC.FullName as RPRRequestor,
	GQ.ComplianceStartDate as ComplianceStartDate,
	NULL as AdjustedComplianceStartDate,
	GQ.UTCCreatedOn,
	GQ.CreatedByRef,
	UMC.FullName as CreatedBy,
	GQ.UTCLastUpdatedOn,
	GQ.LastUpdatedByRef,
	UML.FullName as LastUpdatedBy,
	GQ.LockedByRef,
	GQ.UTCLockedOn,
	UMLock.FullName as LockedBy,
	GQ.AssignedToRef,
	GQ.UTCAssignedOn,
	UMAssign.FullName as AssignedTo,
	GQ.PendedbyRef,
	GQ.UTCPendedOn,
	UMPended.FullName as PendedBy,
	NULL as OOALetterStatusLkup,
	NULL as OOALetterStatus,
	GQ.CMSTransactionStatusLkup,
	LMCTranStatus.LookupValue as CMSTransactionStatus
	From GEN_Queue GQ with(nolock)
	LEFT JOIN GEN_RPRActions GRPR with(nolock) ON GQ.GEN_QueueId=GRPR.GEN_QueueRef 
	LEFT JOIN CMN_LookupMaster LMWorkBasket with(nolock) ON GQ.BusinessSegmentLkup=LMWorkBasket.CMN_LookupMasterId And LMWorkBasket.CMN_LookupTypeRef = 1
	LEFT JOIN CMN_LookupMaster LMDiscrepancy with(nolock) ON GQ.DiscrepancyCategoryLkup=LMDiscrepancy.CMN_LookupMasterId And LMDiscrepancy.CMN_LookupTypeRef = 6
	LEFT JOIN CMN_LookupMaster LMDiscType with(nolock) ON GQ.DiscrepancyTypeLkup=LMDiscType.CMN_LookupMasterId And LMDiscType.CMN_LookupTypeRef = 7
	LEFT JOIN CMN_RecordsLocked RL with(nolock) ON RL.CaseId=GQ.GEN_QueueId AND RL.ScreenLkup = 37010 AND RL.IsActive=1
	LEFT JOIN CMN_LookupMaster LMAction with(nolock) ON GQ.MostRecentActionLkup=LMAction.CMN_LookupMasterId And LMAction.CMN_LookupTypeRef = 28
	LEFT JOIN CMN_LookupMaster LMStatus with(nolock) ON GQ.MostRecentStatusLkup=LMStatus.CMN_LookupMasterId And LMStatus.CMN_LookupTypeRef = 20
	LEFT JOIN CMN_LookupMaster LMQueue with(nolock) ON GQ.MostRecentWorkQueueLkup=LMQueue.CMN_LookupMasterId And LMQueue.CMN_LookupTypeRef = 10
	LEFT JOIN CMN_LookupMasterCorrelations LMQueueType with(nolock) ON GQ.MostRecentWorkQueueLkup=LMQueueType.CMN_LookupMasterChildRef AND LMQueueType.CMN_LookupTypeCorrelationsRef=3
	LEFT JOIN CMN_LookupMaster LMQueueProgType with(nolock) ON LMQueueType.GroupingLookupMasterRef=LMQueueProgType.CMN_LookupMasterId AND LMQueueProgType.CMN_LookupTypeRef = 9
	LEFT JOIN CMN_LookupMaster LMContractId with(nolock) ON GQ.MemberContractIDLkup=LMContractId.CMN_LookupMasterId And LMContractId.CMN_LookupTypeRef = 11
	LEFT JOIN CMN_LookupMaster LMPBPId with(nolock) ON GQ.MemberPBPLkup=LMPBPId.CMN_LookupMasterId And LMPBPId.CMN_LookupTypeRef = 12
	LEFT JOIN CMN_LookupMaster LMLOBId with(nolock) ON GQ.MemberLOBLkup=LMLOBId.CMN_LookupMasterId And LMLOBId.CMN_LookupTypeRef = 31
	LEFT JOIN CMN_LookupMaster LMActionRequested with(nolock) ON GQ.RPRActionRequestedLkup=LMActionRequested.CMN_LookupMasterId And LMActionRequested.CMN_LookupTypeRef = 14
	LEFT JOIN CMN_LookupMaster LMResolution with(nolock) ON GRPR.ResolutionLkup=LMResolution.CMN_LookupMasterId And LMResolution.CMN_LookupTypeRef = 18
	LEFT JOIN CMN_LookupMaster LMDiscSource with(nolock) ON GQ.DiscrepancySourceLkup=LMDiscSource.CMN_LookupMasterId	And LMDiscSource.CMN_LookupTypeRef = 13
	LEFT JOIN CMN_LookupMaster LMSubmissionType with(nolock) ON GRPR.SubmissionTypeLkup=LMSubmissionType.CMN_LookupMasterId And LMSubmissionType.CMN_LookupTypeRef = 17
	LEFT JOIN CMN_LookupMaster LMGender with(nolock) ON GQ.MemberGenderLkup=LMGender.CMN_LookupMasterId And LMGender.CMN_LookupTypeRef = 21
	LEFT JOIN CMN_LookupMaster LMElectionType with(nolock) ON GRPR.ElectionTypeLkup=LMElectionType.CMN_LookupMasterId And LMElectionType.CMN_LookupTypeRef = 23
	LEFT JOIN CMN_LookupMaster LMCTranStatus with(nolock) ON GQ.CMSTransactionStatusLkup=LMCTranStatus.CMN_LookupMasterId And LMCTranStatus.CMN_LookupTypeRef = 55
	INNER JOIN ADM_UserMaster UMC with(nolock) ON GQ.CreatedByRef=UMC.ADM_UserMasterId
	INNER JOIN ADM_UserMaster UML with(nolock) ON GQ.LastUpdatedByRef=UML.ADM_UserMasterId
	INNER JOIN ADM_UserMaster UMSupervior with(nolock) ON GQ.RPRSupervisorOrRequesterRef=UMSupervior.ADM_UserMasterId
	LEFT JOIN ADM_UserMaster UMLock with(nolock) ON GQ.LockedByRef=UMLock.ADM_UserMasterId
	LEFT JOIN ADM_UserMaster UMAssign with(nolock) ON GQ.AssignedToRef=UMAssign.ADM_UserMasterId
	LEFT JOIN ADM_UserMaster UMPended with(nolock) ON GQ.PendedbyRef=UMPended.ADM_UserMasterId
		
	Where
	GQ.DiscrepancyCategoryLkup=@DiscrepancyCategoryLkup
	AND GQ.GEN_QueueId=@WorkItemId
	AND GQ.IsActive=1
	AND (@IsUnlock IS NULL OR @IsUnlock = 0 OR (@IsUnlock = 1 AND GQ.LockedByRef is not null AND GQ.UTCLockedOn < DATEADD(hh,-1,GETUTCDATE())))	
	AND (@IsReAssign IS NULL OR @IsReAssign = 0 OR (@IsReAssign = 1 AND GQ.LockedByRef is null AND ((GQ.AssignedToRef IS NOT NULL AND GQ.MostRecentWorkQueueLkup = 10074) OR (GQ.PendedbyRef IS NOT NULL AND GQ.MostRecentWorkQueueLkup = 10081))))	
	AND (@IsRestricted = 1 OR (@IsRestricted = 0 AND (GQ.IsRestricted = 0 OR GQ.IsRestricted IS NULL)))

	SELECT DISTINCT COUNT(*) AS TotalRecords
    ,COUNT(CASE WHEN (IsRestricted=1)  THEN 1 END) AS RestrictedRecords
	,COUNT(CASE WHEN (IsRestricted=0 OR IsRestricted IS NULL)  THEN 1 END) AS UnRestrictedRecords
	From GEN_Queue GQ with(nolock)
	LEFT JOIN GEN_RPRActions GRPR with(nolock) ON GQ.GEN_QueueId=GRPR.GEN_QueueRef
	LEFT JOIN CMN_RecordsLocked RL with(nolock) ON RL.CaseId=GQ.GEN_QueueId AND RL.ScreenLkup = 37010 AND RL.IsActive=1
	Where
	GQ.DiscrepancyCategoryLkup=@DiscrepancyCategoryLkup
	AND GQ.GEN_QueueId=@WorkItemId
	AND GQ.IsActive=1
	AND (@IsUnlock IS NULL OR @IsUnlock = 0 OR (@IsUnlock = 1 AND GQ.LockedByRef is not null AND GQ.UTCLockedOn < DATEADD(hh,-1,GETUTCDATE())))	
	AND (@IsReAssign IS NULL OR @IsReAssign = 0 OR (@IsReAssign = 1 AND GQ.LockedByRef is null AND ((GQ.AssignedToRef IS NOT NULL AND GQ.MostRecentWorkQueueLkup = 10074) OR (GQ.PendedbyRef IS NOT NULL AND GQ.MostRecentWorkQueueLkup = 10081))))	
End
ELSE IF(@IsBothDiscCatAndMedicareIdSelected =1) 	
Begin
Select DISTINCT TOP (@TopCount)
	GEN_QueueId as WorkItemID,
	[dbo].[GetAge](GQ.[GEN_QueueId]) AS Aging,
	GQ.MemberSCCCode as MemberSCCCode,
	GQ.MemberID as MemberID,
	GQ.MemberMedicareId as MemberCurrentHICN,
	GQ.GPSHouseholdID as GPSHouseholdID,
	GQ.MemberFirstName as MemberFirstName,
	GQ.MemberMiddleName as MemberMiddleName,
	GQ.MemberLastName as MemberLastName,
	LMContractId.LookupValue as MemberContractID,
	GQ.MemberDOB as MemberDOB,
	LMPBPId.LookupValue as MemberPBP,
	LMLOBId.LookupValue as MemberLOB,
	LMGender.LookupValue as MemberGender,
	LMAction.LookupValue as MostRecentAction,
	GQ.MemberMedicareId as CurrentHICN,
	NULL as GPSHICN,
	NULL as MMRHICN,
	LMWorkBasket.LookupValue as BusinessSegment,
	GQ.BusinessSegmentLkup, 
	LMDiscrepancy.LookupValue as DiscrepancyCategory,
	GQ.DiscrepancyCategoryLkup, 
	LMDiscType.LookupValue as DiscrepancyType,
	GQ.MostRecentStatusLkup,
	LMStatus.LookupValue as MostRecentStatus,	
	GQ.MostRecentWorkQueueLkup,
	LMQueue.LookupValue as MostRecentQueue,
	LMQueueType.GroupingLookupMasterRef as QueueProgressTypeLkup,
	LMQueueProgType.LookupValue as QueueProgressType,
	GQ.DiscrepancyStartDate as DiscrepancyStartDate,
	GQ.DiscrepancyEndDate as DiscrepancyEndDate,
	NULL as Reason,
	LMResolution.LookupValue as Resolution,
	NULL as ReferencedEligibilityCaseIndicator,
	NULL as MMRPBP,
	NULL as GPSIndividualID,
	LMDiscSource.LookupValue as DiscrepancySource,
	LMSubmissionType.LookupValue as SubmissionType,
	GQ.RPRCTMMember as CTMMember,
	GQ.RPREGHPMember as EGHPMember,
	GQ.RPRRequestedEffectiveDate as RequestedEffectiveDate,
	GQ.RPRActionRequestedLkup as RPRActionRequestedLkup,
	LMActionRequested.LookupValue as ActionRequested,
	LMElectionType.LookupValue as ElectionType,
	GRPR.PotentialSubmissionDate as PotentialSubmissionDate,
	GRPR.RPCSubmissionDate as RPCSubmissionDate,
	GRPR.FDRReceivedDate as FDRReceivedDate,
	GRPR.FDRCodeReceived as FDRCodeReceived,
	UMC.FullName as RPRRequestor,
	GQ.ComplianceStartDate as ComplianceStartDate,
	NULL as AdjustedComplianceStartDate,
	GQ.UTCCreatedOn,
	GQ.CreatedByRef,
	UMC.FullName as CreatedBy,
	GQ.UTCLastUpdatedOn,
	GQ.LastUpdatedByRef,
	UML.FullName as LastUpdatedBy,
	GQ.LockedByRef,
	GQ.UTCLockedOn,
	UMLock.FullName as LockedBy,
	GQ.AssignedToRef,
	GQ.UTCAssignedOn,
	UMAssign.FullName as AssignedTo,
	GQ.PendedbyRef,
	GQ.UTCPendedOn,
	UMPended.FullName as PendedBy,
	NULL as OOALetterStatusLkup,
	NULL as OOALetterStatus,
	GQ.CMSTransactionStatusLkup,
	LMCTranStatus.LookupValue as CMSTransactionStatus
	From GEN_Queue GQ with(nolock)
	LEFT JOIN GEN_RPRActions GRPR with(nolock) ON GQ.GEN_QueueId=GRPR.GEN_QueueRef 
	LEFT JOIN CMN_LookupMaster LMWorkBasket with(nolock) ON GQ.BusinessSegmentLkup=LMWorkBasket.CMN_LookupMasterId And LMWorkBasket.CMN_LookupTypeRef = 1
	LEFT JOIN CMN_LookupMaster LMDiscrepancy with(nolock) ON GQ.DiscrepancyCategoryLkup=LMDiscrepancy.CMN_LookupMasterId And LMDiscrepancy.CMN_LookupTypeRef = 6
	LEFT JOIN CMN_LookupMaster LMDiscType with(nolock) ON GQ.DiscrepancyTypeLkup=LMDiscType.CMN_LookupMasterId And LMDiscType.CMN_LookupTypeRef = 7
	LEFT JOIN CMN_RecordsLocked RL with(nolock) ON RL.CaseId=GQ.GEN_QueueId AND RL.ScreenLkup = 37010 AND RL.IsActive=1
	LEFT JOIN CMN_LookupMaster LMAction with(nolock) ON GQ.MostRecentActionLkup=LMAction.CMN_LookupMasterId And LMAction.CMN_LookupTypeRef = 28
	LEFT JOIN CMN_LookupMaster LMStatus with(nolock) ON GQ.MostRecentStatusLkup=LMStatus.CMN_LookupMasterId And LMStatus.CMN_LookupTypeRef = 20
	LEFT JOIN CMN_LookupMaster LMQueue with(nolock) ON GQ.MostRecentWorkQueueLkup=LMQueue.CMN_LookupMasterId And LMQueue.CMN_LookupTypeRef = 10
	LEFT JOIN CMN_LookupMasterCorrelations LMQueueType with(nolock) ON GQ.MostRecentWorkQueueLkup=LMQueueType.CMN_LookupMasterChildRef AND LMQueueType.CMN_LookupTypeCorrelationsRef=3
	LEFT JOIN CMN_LookupMaster LMQueueProgType with(nolock) ON LMQueueType.GroupingLookupMasterRef=LMQueueProgType.CMN_LookupMasterId AND LMQueueProgType.CMN_LookupTypeRef = 9
	LEFT JOIN CMN_LookupMaster LMContractId with(nolock) ON GQ.MemberContractIDLkup=LMContractId.CMN_LookupMasterId And LMContractId.CMN_LookupTypeRef = 11
	LEFT JOIN CMN_LookupMaster LMPBPId with(nolock) ON GQ.MemberPBPLkup=LMPBPId.CMN_LookupMasterId And LMPBPId.CMN_LookupTypeRef = 12
	LEFT JOIN CMN_LookupMaster LMLOBId with(nolock) ON GQ.MemberLOBLkup=LMLOBId.CMN_LookupMasterId And LMLOBId.CMN_LookupTypeRef = 31
	LEFT JOIN CMN_LookupMaster LMActionRequested with(nolock) ON GQ.RPRActionRequestedLkup=LMActionRequested.CMN_LookupMasterId And LMActionRequested.CMN_LookupTypeRef = 14
	LEFT JOIN CMN_LookupMaster LMResolution with(nolock) ON GRPR.ResolutionLkup=LMResolution.CMN_LookupMasterId And LMResolution.CMN_LookupTypeRef = 18
	LEFT JOIN CMN_LookupMaster LMDiscSource with(nolock) ON GQ.DiscrepancySourceLkup=LMDiscSource.CMN_LookupMasterId	And LMDiscSource.CMN_LookupTypeRef = 13
	LEFT JOIN CMN_LookupMaster LMSubmissionType with(nolock) ON GRPR.SubmissionTypeLkup=LMSubmissionType.CMN_LookupMasterId And LMSubmissionType.CMN_LookupTypeRef = 17
	LEFT JOIN CMN_LookupMaster LMGender with(nolock) ON GQ.MemberGenderLkup=LMGender.CMN_LookupMasterId And LMGender.CMN_LookupTypeRef = 21
	LEFT JOIN CMN_LookupMaster LMElectionType with(nolock) ON GRPR.ElectionTypeLkup=LMElectionType.CMN_LookupMasterId And LMElectionType.CMN_LookupTypeRef = 23
	LEFT JOIN CMN_LookupMaster LMCTranStatus with(nolock) ON GQ.CMSTransactionStatusLkup=LMCTranStatus.CMN_LookupMasterId And LMCTranStatus.CMN_LookupTypeRef = 55
	INNER JOIN ADM_UserMaster UMC with(nolock) ON GQ.CreatedByRef=UMC.ADM_UserMasterId
	INNER JOIN ADM_UserMaster UML with(nolock) ON GQ.LastUpdatedByRef=UML.ADM_UserMasterId
	INNER JOIN ADM_UserMaster UMSupervior with(nolock) ON GQ.RPRSupervisorOrRequesterRef=UMSupervior.ADM_UserMasterId
	LEFT JOIN ADM_UserMaster UMLock with(nolock) ON GQ.LockedByRef=UMLock.ADM_UserMasterId
	LEFT JOIN ADM_UserMaster UMAssign with(nolock) ON GQ.AssignedToRef=UMAssign.ADM_UserMasterId
	LEFT JOIN ADM_UserMaster UMPended with(nolock) ON GQ.PendedbyRef=UMPended.ADM_UserMasterId
		
	Where
	GQ.DiscrepancyCategoryLkup=@DiscrepancyCategoryLkup
	AND (GQ.MemberCurrentHICN = @CurrentHICN OR GQ.EligGPSCurrentHICN = @CurrentHICN OR GQ.EligMMRCurrentHICN = @CurrentHICN  OR GQ.[MemberMedicareId] = @CurrentHICN)
	AND GQ.IsActive=1
	AND (@IsUnlock IS NULL OR @IsUnlock = 0 OR (@IsUnlock = 1 AND GQ.LockedByRef is not null AND GQ.UTCLockedOn < DATEADD(hh,-1,GETUTCDATE())))	
	AND (@IsReAssign IS NULL OR @IsReAssign = 0 OR (@IsReAssign = 1 AND GQ.LockedByRef is null AND ((GQ.AssignedToRef IS NOT NULL AND GQ.MostRecentWorkQueueLkup = 10074) OR (GQ.PendedbyRef IS NOT NULL AND GQ.MostRecentWorkQueueLkup = 10081))))
	AND (@IsRestricted = 1 OR (@IsRestricted = 0 AND (GQ.IsRestricted = 0 OR GQ.IsRestricted IS NULL)))

	SELECT DISTINCT COUNT(*) AS TotalRecords
    ,COUNT(CASE WHEN (IsRestricted=1)  THEN 1 END) AS RestrictedRecords
	,COUNT(CASE WHEN (IsRestricted=0 OR IsRestricted IS NULL)  THEN 1 END) AS UnRestrictedRecords
	From GEN_Queue GQ with(nolock)
	LEFT JOIN GEN_RPRActions GRPR with(nolock) ON GQ.GEN_QueueId=GRPR.GEN_QueueRef
	LEFT JOIN CMN_RecordsLocked RL with(nolock) ON RL.CaseId=GQ.GEN_QueueId AND RL.ScreenLkup = 37010 AND RL.IsActive=1
	Where
	GQ.DiscrepancyCategoryLkup=@DiscrepancyCategoryLkup
	AND (GQ.MemberCurrentHICN = @CurrentHICN OR GQ.EligGPSCurrentHICN = @CurrentHICN OR GQ.EligMMRCurrentHICN = @CurrentHICN  OR GQ.[MemberMedicareId] = @CurrentHICN)
	AND GQ.IsActive=1
	AND (@IsUnlock IS NULL OR @IsUnlock = 0 OR (@IsUnlock = 1 AND GQ.LockedByRef is not null AND GQ.UTCLockedOn < DATEADD(hh,-1,GETUTCDATE())))	
	AND (@IsReAssign IS NULL OR @IsReAssign = 0 OR (@IsReAssign = 1 AND GQ.LockedByRef is null AND ((GQ.AssignedToRef IS NOT NULL AND GQ.MostRecentWorkQueueLkup = 10074) OR (GQ.PendedbyRef IS NOT NULL AND GQ.MostRecentWorkQueueLkup = 10081))))
		
End
ELSE IF(@IsDiscCatAndCaseIdAndMedicareIdSelected = 1) 	
Begin
Select DISTINCT TOP (@TopCount)
	GEN_QueueId as WorkItemID,
	[dbo].[GetAge](GQ.[GEN_QueueId]) AS Aging,
	GQ.MemberSCCCode as MemberSCCCode,
	GQ.MemberID as MemberID,
	GQ.MemberMedicareId as MemberCurrentHICN,
	GQ.GPSHouseholdID as GPSHouseholdID,
	GQ.MemberFirstName as MemberFirstName,
	GQ.MemberMiddleName as MemberMiddleName,
	GQ.MemberLastName as MemberLastName,
	LMContractId.LookupValue as MemberContractID,
	GQ.MemberDOB as MemberDOB,
	LMPBPId.LookupValue as MemberPBP,
	LMLOBId.LookupValue as MemberLOB,
	LMGender.LookupValue as MemberGender,
	LMAction.LookupValue as MostRecentAction,
	GQ.MemberMedicareId as CurrentHICN,
	NULL as GPSHICN,
	NULL as MMRHICN,
	LMWorkBasket.LookupValue as BusinessSegment,
	GQ.BusinessSegmentLkup, 
	LMDiscrepancy.LookupValue as DiscrepancyCategory,
	GQ.DiscrepancyCategoryLkup, 
	LMDiscType.LookupValue as DiscrepancyType,
	GQ.MostRecentStatusLkup,
	LMStatus.LookupValue as MostRecentStatus,	
	GQ.MostRecentWorkQueueLkup,
	LMQueue.LookupValue as MostRecentQueue,
	LMQueueType.GroupingLookupMasterRef as QueueProgressTypeLkup,
	LMQueueProgType.LookupValue as QueueProgressType,
	GQ.DiscrepancyStartDate as DiscrepancyStartDate,
	GQ.DiscrepancyEndDate as DiscrepancyEndDate,
	NULL as Reason,
	LMResolution.LookupValue as Resolution,
	NULL as ReferencedEligibilityCaseIndicator,
	NULL as MMRPBP,
	NULL as GPSIndividualID,
	LMDiscSource.LookupValue as DiscrepancySource,
	LMSubmissionType.LookupValue as SubmissionType,
	GQ.RPRCTMMember as CTMMember,
	GQ.RPREGHPMember as EGHPMember,
	GQ.RPRRequestedEffectiveDate as RequestedEffectiveDate,
	GQ.RPRActionRequestedLkup as RPRActionRequestedLkup,
	LMActionRequested.LookupValue as ActionRequested,
	LMElectionType.LookupValue as ElectionType,
	GRPR.PotentialSubmissionDate as PotentialSubmissionDate,
	GRPR.RPCSubmissionDate as RPCSubmissionDate,
	GRPR.FDRReceivedDate as FDRReceivedDate,
	GRPR.FDRCodeReceived as FDRCodeReceived,
	UMC.FullName as RPRRequestor,
	GQ.ComplianceStartDate as ComplianceStartDate,
	NULL as AdjustedComplianceStartDate,
	GQ.UTCCreatedOn,
	GQ.CreatedByRef,
	UMC.FullName as CreatedBy,
	GQ.UTCLastUpdatedOn,
	GQ.LastUpdatedByRef,
	UML.FullName as LastUpdatedBy,
	GQ.LockedByRef,
	GQ.UTCLockedOn,
	UMLock.FullName as LockedBy,
	GQ.AssignedToRef,
	GQ.UTCAssignedOn,
	UMAssign.FullName as AssignedTo,
	GQ.PendedbyRef,
	GQ.UTCPendedOn,
	UMPended.FullName as PendedBy,
	NULL as OOALetterStatusLkup,
	NULL as OOALetterStatus,
	GQ.CMSTransactionStatusLkup,
	LMCTranStatus.LookupValue as CMSTransactionStatus
	From GEN_Queue GQ with(nolock)
	LEFT JOIN GEN_RPRActions GRPR with(nolock) ON GQ.GEN_QueueId=GRPR.GEN_QueueRef 
	LEFT JOIN CMN_LookupMaster LMWorkBasket with(nolock) ON GQ.BusinessSegmentLkup=LMWorkBasket.CMN_LookupMasterId And LMWorkBasket.CMN_LookupTypeRef = 1
	LEFT JOIN CMN_LookupMaster LMDiscrepancy with(nolock) ON GQ.DiscrepancyCategoryLkup=LMDiscrepancy.CMN_LookupMasterId And LMDiscrepancy.CMN_LookupTypeRef = 6
	LEFT JOIN CMN_LookupMaster LMDiscType with(nolock) ON GQ.DiscrepancyTypeLkup=LMDiscType.CMN_LookupMasterId And LMDiscType.CMN_LookupTypeRef = 7
	LEFT JOIN CMN_RecordsLocked RL with(nolock) ON RL.CaseId=GQ.GEN_QueueId AND RL.ScreenLkup = 37010 AND RL.IsActive=1
	LEFT JOIN CMN_LookupMaster LMAction with(nolock) ON GQ.MostRecentActionLkup=LMAction.CMN_LookupMasterId And LMAction.CMN_LookupTypeRef = 28
	LEFT JOIN CMN_LookupMaster LMStatus with(nolock) ON GQ.MostRecentStatusLkup=LMStatus.CMN_LookupMasterId And LMStatus.CMN_LookupTypeRef = 20
	LEFT JOIN CMN_LookupMaster LMQueue with(nolock) ON GQ.MostRecentWorkQueueLkup=LMQueue.CMN_LookupMasterId And LMQueue.CMN_LookupTypeRef = 10
	LEFT JOIN CMN_LookupMasterCorrelations LMQueueType with(nolock) ON GQ.MostRecentWorkQueueLkup=LMQueueType.CMN_LookupMasterChildRef AND LMQueueType.CMN_LookupTypeCorrelationsRef=3
	LEFT JOIN CMN_LookupMaster LMQueueProgType with(nolock) ON LMQueueType.GroupingLookupMasterRef=LMQueueProgType.CMN_LookupMasterId AND LMQueueProgType.CMN_LookupTypeRef = 9
	LEFT JOIN CMN_LookupMaster LMContractId with(nolock) ON GQ.MemberContractIDLkup=LMContractId.CMN_LookupMasterId And LMContractId.CMN_LookupTypeRef = 11
	LEFT JOIN CMN_LookupMaster LMPBPId with(nolock) ON GQ.MemberPBPLkup=LMPBPId.CMN_LookupMasterId And LMPBPId.CMN_LookupTypeRef = 12
	LEFT JOIN CMN_LookupMaster LMLOBId with(nolock) ON GQ.MemberLOBLkup=LMLOBId.CMN_LookupMasterId And LMLOBId.CMN_LookupTypeRef = 31
	LEFT JOIN CMN_LookupMaster LMActionRequested with(nolock) ON GQ.RPRActionRequestedLkup=LMActionRequested.CMN_LookupMasterId And LMActionRequested.CMN_LookupTypeRef = 14
	LEFT JOIN CMN_LookupMaster LMResolution with(nolock) ON GRPR.ResolutionLkup=LMResolution.CMN_LookupMasterId And LMResolution.CMN_LookupTypeRef = 18
	LEFT JOIN CMN_LookupMaster LMDiscSource with(nolock) ON GQ.DiscrepancySourceLkup=LMDiscSource.CMN_LookupMasterId	And LMDiscSource.CMN_LookupTypeRef = 13
	LEFT JOIN CMN_LookupMaster LMSubmissionType with(nolock) ON GRPR.SubmissionTypeLkup=LMSubmissionType.CMN_LookupMasterId And LMSubmissionType.CMN_LookupTypeRef = 17
	LEFT JOIN CMN_LookupMaster LMGender with(nolock) ON GQ.MemberGenderLkup=LMGender.CMN_LookupMasterId And LMGender.CMN_LookupTypeRef = 21
	LEFT JOIN CMN_LookupMaster LMElectionType with(nolock) ON GRPR.ElectionTypeLkup=LMElectionType.CMN_LookupMasterId And LMElectionType.CMN_LookupTypeRef = 23
	LEFT JOIN CMN_LookupMaster LMCTranStatus with(nolock) ON GQ.CMSTransactionStatusLkup=LMCTranStatus.CMN_LookupMasterId And LMCTranStatus.CMN_LookupTypeRef = 55
	INNER JOIN ADM_UserMaster UMC with(nolock) ON GQ.CreatedByRef=UMC.ADM_UserMasterId
	INNER JOIN ADM_UserMaster UML with(nolock) ON GQ.LastUpdatedByRef=UML.ADM_UserMasterId
	INNER JOIN ADM_UserMaster UMSupervior with(nolock) ON GQ.RPRSupervisorOrRequesterRef=UMSupervior.ADM_UserMasterId
	LEFT JOIN ADM_UserMaster UMLock with(nolock) ON GQ.LockedByRef=UMLock.ADM_UserMasterId
	LEFT JOIN ADM_UserMaster UMAssign with(nolock) ON GQ.AssignedToRef=UMAssign.ADM_UserMasterId
	LEFT JOIN ADM_UserMaster UMPended with(nolock) ON GQ.PendedbyRef=UMPended.ADM_UserMasterId
		
	Where
	GQ.GEN_QueueId=@WorkItemId
	AND GQ.DiscrepancyCategoryLkup=@DiscrepancyCategoryLkup
	AND (GQ.MemberCurrentHICN = @CurrentHICN OR GQ.EligGPSCurrentHICN = @CurrentHICN OR GQ.EligMMRCurrentHICN = @CurrentHICN  OR GQ.[MemberMedicareId] = @CurrentHICN)
	AND GQ.IsActive=1
	AND (@IsUnlock IS NULL OR @IsUnlock = 0 OR (@IsUnlock = 1 AND GQ.LockedByRef is not null AND GQ.UTCLockedOn < DATEADD(hh,-1,GETUTCDATE())))	
	AND (@IsReAssign IS NULL OR @IsReAssign = 0 OR (@IsReAssign = 1 AND GQ.LockedByRef is null AND ((GQ.AssignedToRef IS NOT NULL AND GQ.MostRecentWorkQueueLkup = 10074) OR (GQ.PendedbyRef IS NOT NULL AND GQ.MostRecentWorkQueueLkup = 10081))))	
	AND (@IsRestricted = 1 OR (@IsRestricted = 0 AND (GQ.IsRestricted = 0 OR GQ.IsRestricted IS NULL)))

	SELECT DISTINCT COUNT(*) AS TotalRecords
    ,COUNT(CASE WHEN (IsRestricted=1)  THEN 1 END) AS RestrictedRecords
	,COUNT(CASE WHEN (IsRestricted=0 OR IsRestricted IS NULL)  THEN 1 END) AS UnRestrictedRecords
	From GEN_Queue GQ with(nolock)
	LEFT JOIN GEN_RPRActions GRPR with(nolock) ON GQ.GEN_QueueId=GRPR.GEN_QueueRef
	LEFT JOIN CMN_RecordsLocked RL with(nolock) ON RL.CaseId=GQ.GEN_QueueId AND RL.ScreenLkup = 37010 AND RL.IsActive=1
	Where
	GQ.GEN_QueueId=@WorkItemId
	AND GQ.DiscrepancyCategoryLkup=@DiscrepancyCategoryLkup
	AND (GQ.MemberCurrentHICN = @CurrentHICN OR GQ.EligGPSCurrentHICN = @CurrentHICN OR GQ.EligMMRCurrentHICN = @CurrentHICN  OR GQ.[MemberMedicareId] = @CurrentHICN)
	AND GQ.IsActive=1
	AND (@IsUnlock IS NULL OR @IsUnlock = 0 OR (@IsUnlock = 1 AND GQ.LockedByRef is not null AND GQ.UTCLockedOn < DATEADD(hh,-1,GETUTCDATE())))	
	AND (@IsReAssign IS NULL OR @IsReAssign = 0 OR (@IsReAssign = 1 AND GQ.LockedByRef is null AND ((GQ.AssignedToRef IS NOT NULL AND GQ.MostRecentWorkQueueLkup = 10074) OR (GQ.PendedbyRef IS NOT NULL AND GQ.MostRecentWorkQueueLkup = 10081))))	
		
End
ELSE IF(@IsDiscCatRPRAndCreatedDateSelected = 1) 	
Begin
Select DISTINCT TOP (@TopCount)
	GEN_QueueId as WorkItemID,
	[dbo].[GetAge](GQ.[GEN_QueueId]) AS Aging,
	GQ.MemberSCCCode as MemberSCCCode,
	GQ.MemberID as MemberID,
	GQ.MemberMedicareId as MemberCurrentHICN,
	GQ.GPSHouseholdID as GPSHouseholdID,
	GQ.MemberFirstName as MemberFirstName,
	GQ.MemberMiddleName as MemberMiddleName,
	GQ.MemberLastName as MemberLastName,
	LMContractId.LookupValue as MemberContractID,
	GQ.MemberDOB as MemberDOB,
	LMPBPId.LookupValue as MemberPBP,
	LMLOBId.LookupValue as MemberLOB,
	LMGender.LookupValue as MemberGender,
	LMAction.LookupValue as MostRecentAction,
	GQ.MemberMedicareId as CurrentHICN,
	NULL as GPSHICN,
	NULL as MMRHICN,
	LMWorkBasket.LookupValue as BusinessSegment,
	GQ.BusinessSegmentLkup, 
	LMDiscrepancy.LookupValue as DiscrepancyCategory,
	GQ.DiscrepancyCategoryLkup, 
	LMDiscType.LookupValue as DiscrepancyType,
	GQ.MostRecentStatusLkup,
	LMStatus.LookupValue as MostRecentStatus,	
	GQ.MostRecentWorkQueueLkup,
	LMQueue.LookupValue as MostRecentQueue,
	LMQueueType.GroupingLookupMasterRef as QueueProgressTypeLkup,
	LMQueueProgType.LookupValue as QueueProgressType,
	GQ.DiscrepancyStartDate as DiscrepancyStartDate,
	GQ.DiscrepancyEndDate as DiscrepancyEndDate,
	NULL as Reason,
	LMResolution.LookupValue as Resolution,
	NULL as ReferencedEligibilityCaseIndicator,
	NULL as MMRPBP,
	NULL as GPSIndividualID,
	LMDiscSource.LookupValue as DiscrepancySource,
	LMSubmissionType.LookupValue as SubmissionType,
	GQ.RPRCTMMember as CTMMember,
	GQ.RPREGHPMember as EGHPMember,
	GQ.RPRRequestedEffectiveDate as RequestedEffectiveDate,
	GQ.RPRActionRequestedLkup as RPRActionRequestedLkup,
	LMActionRequested.LookupValue as ActionRequested,
	LMElectionType.LookupValue as ElectionType,
	GRPR.PotentialSubmissionDate as PotentialSubmissionDate,
	GRPR.RPCSubmissionDate as RPCSubmissionDate,
	GRPR.FDRReceivedDate as FDRReceivedDate,
	GRPR.FDRCodeReceived as FDRCodeReceived,
	UMC.FullName as RPRRequestor,
	GQ.ComplianceStartDate as ComplianceStartDate,
	NULL as AdjustedComplianceStartDate,
	GQ.UTCCreatedOn,
	GQ.CreatedByRef,
	UMC.FullName as CreatedBy,
	GQ.UTCLastUpdatedOn,
	GQ.LastUpdatedByRef,
	UML.FullName as LastUpdatedBy,
	GQ.LockedByRef,
	GQ.UTCLockedOn,
	UMLock.FullName as LockedBy,
	GQ.AssignedToRef,
	GQ.UTCAssignedOn,
	UMAssign.FullName as AssignedTo,
	GQ.PendedbyRef,
	GQ.UTCPendedOn,
	UMPended.FullName as PendedBy,
	NULL as OOALetterStatusLkup,
	NULL as OOALetterStatus,
	GQ.CMSTransactionStatusLkup,
	LMCTranStatus.LookupValue as CMSTransactionStatus
	From GEN_Queue GQ with(nolock)
	LEFT JOIN GEN_RPRActions GRPR with(nolock) ON GQ.GEN_QueueId=GRPR.GEN_QueueRef 
	LEFT JOIN CMN_LookupMaster LMWorkBasket with(nolock) ON GQ.BusinessSegmentLkup=LMWorkBasket.CMN_LookupMasterId And LMWorkBasket.CMN_LookupTypeRef = 1
	LEFT JOIN CMN_LookupMaster LMDiscrepancy with(nolock) ON GQ.DiscrepancyCategoryLkup=LMDiscrepancy.CMN_LookupMasterId And LMDiscrepancy.CMN_LookupTypeRef = 6
	LEFT JOIN CMN_LookupMaster LMDiscType with(nolock) ON GQ.DiscrepancyTypeLkup=LMDiscType.CMN_LookupMasterId And LMDiscType.CMN_LookupTypeRef = 7
	LEFT JOIN CMN_RecordsLocked RL with(nolock) ON RL.CaseId=GQ.GEN_QueueId AND RL.ScreenLkup = 37010 AND RL.IsActive=1
	LEFT JOIN CMN_LookupMaster LMAction with(nolock) ON GQ.MostRecentActionLkup=LMAction.CMN_LookupMasterId And LMAction.CMN_LookupTypeRef = 28
	LEFT JOIN CMN_LookupMaster LMStatus with(nolock) ON GQ.MostRecentStatusLkup=LMStatus.CMN_LookupMasterId And LMStatus.CMN_LookupTypeRef = 20
	LEFT JOIN CMN_LookupMaster LMQueue with(nolock) ON GQ.MostRecentWorkQueueLkup=LMQueue.CMN_LookupMasterId And LMQueue.CMN_LookupTypeRef = 10
	LEFT JOIN CMN_LookupMasterCorrelations LMQueueType with(nolock) ON GQ.MostRecentWorkQueueLkup=LMQueueType.CMN_LookupMasterChildRef AND LMQueueType.CMN_LookupTypeCorrelationsRef=3
	LEFT JOIN CMN_LookupMaster LMQueueProgType with(nolock) ON LMQueueType.GroupingLookupMasterRef=LMQueueProgType.CMN_LookupMasterId AND LMQueueProgType.CMN_LookupTypeRef = 9
	LEFT JOIN CMN_LookupMaster LMContractId with(nolock) ON GQ.MemberContractIDLkup=LMContractId.CMN_LookupMasterId And LMContractId.CMN_LookupTypeRef = 11
	LEFT JOIN CMN_LookupMaster LMPBPId with(nolock) ON GQ.MemberPBPLkup=LMPBPId.CMN_LookupMasterId And LMPBPId.CMN_LookupTypeRef = 12
	LEFT JOIN CMN_LookupMaster LMLOBId with(nolock) ON GQ.MemberLOBLkup=LMLOBId.CMN_LookupMasterId And LMLOBId.CMN_LookupTypeRef = 31
	LEFT JOIN CMN_LookupMaster LMActionRequested with(nolock) ON GQ.RPRActionRequestedLkup=LMActionRequested.CMN_LookupMasterId And LMActionRequested.CMN_LookupTypeRef = 14
	LEFT JOIN CMN_LookupMaster LMResolution with(nolock) ON GRPR.ResolutionLkup=LMResolution.CMN_LookupMasterId And LMResolution.CMN_LookupTypeRef = 18
	LEFT JOIN CMN_LookupMaster LMDiscSource with(nolock) ON GQ.DiscrepancySourceLkup=LMDiscSource.CMN_LookupMasterId	And LMDiscSource.CMN_LookupTypeRef = 13
	LEFT JOIN CMN_LookupMaster LMSubmissionType with(nolock) ON GRPR.SubmissionTypeLkup=LMSubmissionType.CMN_LookupMasterId And LMSubmissionType.CMN_LookupTypeRef = 17
	LEFT JOIN CMN_LookupMaster LMGender with(nolock) ON GQ.MemberGenderLkup=LMGender.CMN_LookupMasterId And LMGender.CMN_LookupTypeRef = 21
	LEFT JOIN CMN_LookupMaster LMElectionType with(nolock) ON GRPR.ElectionTypeLkup=LMElectionType.CMN_LookupMasterId And LMElectionType.CMN_LookupTypeRef = 23
	LEFT JOIN CMN_LookupMaster LMCTranStatus with(nolock) ON GQ.CMSTransactionStatusLkup=LMCTranStatus.CMN_LookupMasterId And LMCTranStatus.CMN_LookupTypeRef = 55
	INNER JOIN ADM_UserMaster UMC with(nolock) ON GQ.CreatedByRef=UMC.ADM_UserMasterId
	INNER JOIN ADM_UserMaster UML with(nolock) ON GQ.LastUpdatedByRef=UML.ADM_UserMasterId
	INNER JOIN ADM_UserMaster UMSupervior with(nolock) ON GQ.RPRSupervisorOrRequesterRef=UMSupervior.ADM_UserMasterId
	LEFT JOIN ADM_UserMaster UMLock with(nolock) ON GQ.LockedByRef=UMLock.ADM_UserMasterId
	LEFT JOIN ADM_UserMaster UMAssign with(nolock) ON GQ.AssignedToRef=UMAssign.ADM_UserMasterId
	LEFT JOIN ADM_UserMaster UMPended with(nolock) ON GQ.PendedbyRef=UMPended.ADM_UserMasterId
		
	Where
	GQ.DiscrepancyCategoryLkup=@DiscrepancyCategoryLkup
	AND (@CaseCreationStartDateId Is Null OR GQ.UTCCreatedOnId>=@CaseCreationStartDateId)
	AND (@CaseCreationEndDateId Is Null OR GQ.UTCCreatedOnId<=@CaseCreationEndDateId)
	AND GQ.IsActive=1
	AND (@IsUnlock IS NULL OR @IsUnlock = 0 OR (@IsUnlock = 1 AND GQ.LockedByRef is not null AND GQ.UTCLockedOn < DATEADD(hh,-1,GETUTCDATE())))	
	AND (@IsReAssign IS NULL OR @IsReAssign = 0 OR (@IsReAssign = 1 AND GQ.LockedByRef is null AND ((GQ.AssignedToRef IS NOT NULL AND GQ.MostRecentWorkQueueLkup = 10074) OR (GQ.PendedbyRef IS NOT NULL AND GQ.MostRecentWorkQueueLkup = 10081))))	
	AND (@IsRestricted = 1 OR (@IsRestricted = 0 AND (GQ.IsRestricted = 0 OR GQ.IsRestricted IS NULL)))

	SELECT DISTINCT COUNT(*) AS TotalRecords
    ,COUNT(CASE WHEN (IsRestricted=1)  THEN 1 END) AS RestrictedRecords
	,COUNT(CASE WHEN (IsRestricted=0 OR IsRestricted IS NULL)  THEN 1 END) AS UnRestrictedRecords
	From GEN_Queue GQ with(nolock)
	LEFT JOIN GEN_RPRActions GRPR with(nolock) ON GQ.GEN_QueueId=GRPR.GEN_QueueRef
	LEFT JOIN CMN_RecordsLocked RL with(nolock) ON RL.CaseId=GQ.GEN_QueueId AND RL.ScreenLkup = 37010 AND RL.IsActive=1
	Where
	GQ.DiscrepancyCategoryLkup=@DiscrepancyCategoryLkup
	AND (@CaseCreationStartDateId Is Null OR GQ.UTCCreatedOnId>=@CaseCreationStartDateId)
	AND (@CaseCreationEndDateId Is Null OR GQ.UTCCreatedOnId<=@CaseCreationEndDateId)
	AND GQ.IsActive=1
	AND (@IsUnlock IS NULL OR @IsUnlock = 0 OR (@IsUnlock = 1 AND GQ.LockedByRef is not null AND GQ.UTCLockedOn < DATEADD(hh,-1,GETUTCDATE())))	
	AND (@IsReAssign IS NULL OR @IsReAssign = 0 OR (@IsReAssign = 1 AND GQ.LockedByRef is null AND ((GQ.AssignedToRef IS NOT NULL AND GQ.MostRecentWorkQueueLkup = 10074) OR (GQ.PendedbyRef IS NOT NULL AND GQ.MostRecentWorkQueueLkup = 10081))))	
		
End
ELSE IF(@IsDiscCatRPRAndDiscTypeAndCreatedDateSelected = 1) 	
Begin
Select DISTINCT TOP (@TopCount)
	GEN_QueueId as WorkItemID,
	[dbo].[GetAge](GQ.[GEN_QueueId]) AS Aging,
	GQ.MemberSCCCode as MemberSCCCode,
	GQ.MemberID as MemberID,
	GQ.MemberMedicareId as MemberCurrentHICN,
	GQ.GPSHouseholdID as GPSHouseholdID,
	GQ.MemberFirstName as MemberFirstName,
	GQ.MemberMiddleName as MemberMiddleName,
	GQ.MemberLastName as MemberLastName,
	LMContractId.LookupValue as MemberContractID,
	GQ.MemberDOB as MemberDOB,
	LMPBPId.LookupValue as MemberPBP,
	LMLOBId.LookupValue as MemberLOB,
	LMGender.LookupValue as MemberGender,
	LMAction.LookupValue as MostRecentAction,
	GQ.MemberMedicareId as CurrentHICN,
	NULL as GPSHICN,
	NULL as MMRHICN,
	LMWorkBasket.LookupValue as BusinessSegment,
	GQ.BusinessSegmentLkup, 
	LMDiscrepancy.LookupValue as DiscrepancyCategory,
	GQ.DiscrepancyCategoryLkup, 
	LMDiscType.LookupValue as DiscrepancyType,
	GQ.MostRecentStatusLkup,
	LMStatus.LookupValue as MostRecentStatus,	
	GQ.MostRecentWorkQueueLkup,
	LMQueue.LookupValue as MostRecentQueue,
	LMQueueType.GroupingLookupMasterRef as QueueProgressTypeLkup,
	LMQueueProgType.LookupValue as QueueProgressType,
	GQ.DiscrepancyStartDate as DiscrepancyStartDate,
	GQ.DiscrepancyEndDate as DiscrepancyEndDate,
	NULL as Reason,
	LMResolution.LookupValue as Resolution,
	NULL as ReferencedEligibilityCaseIndicator,
	NULL as MMRPBP,
	NULL as GPSIndividualID,
	LMDiscSource.LookupValue as DiscrepancySource,
	LMSubmissionType.LookupValue as SubmissionType,
	GQ.RPRCTMMember as CTMMember,
	GQ.RPREGHPMember as EGHPMember,
	GQ.RPRRequestedEffectiveDate as RequestedEffectiveDate,
	GQ.RPRActionRequestedLkup as RPRActionRequestedLkup,
	LMActionRequested.LookupValue as ActionRequested,
	LMElectionType.LookupValue as ElectionType,
	GRPR.PotentialSubmissionDate as PotentialSubmissionDate,
	GRPR.RPCSubmissionDate as RPCSubmissionDate,
	GRPR.FDRReceivedDate as FDRReceivedDate,
	GRPR.FDRCodeReceived as FDRCodeReceived,
	UMC.FullName as RPRRequestor,
	GQ.ComplianceStartDate as ComplianceStartDate,
	NULL as AdjustedComplianceStartDate,
	GQ.UTCCreatedOn,
	GQ.CreatedByRef,
	UMC.FullName as CreatedBy,
	GQ.UTCLastUpdatedOn,
	GQ.LastUpdatedByRef,
	UML.FullName as LastUpdatedBy,
	GQ.LockedByRef,
	GQ.UTCLockedOn,
	UMLock.FullName as LockedBy,
	GQ.AssignedToRef,
	GQ.UTCAssignedOn,
	UMAssign.FullName as AssignedTo,
	GQ.PendedbyRef,
	GQ.UTCPendedOn,
	UMPended.FullName as PendedBy,
	NULL as OOALetterStatusLkup,
	NULL as OOALetterStatus,
	GQ.CMSTransactionStatusLkup,
	LMCTranStatus.LookupValue as CMSTransactionStatus
	From GEN_Queue GQ with(nolock)
	LEFT JOIN GEN_RPRActions GRPR with(nolock) ON GQ.GEN_QueueId=GRPR.GEN_QueueRef 
	LEFT JOIN CMN_LookupMaster LMWorkBasket with(nolock) ON GQ.BusinessSegmentLkup=LMWorkBasket.CMN_LookupMasterId And LMWorkBasket.CMN_LookupTypeRef = 1
	LEFT JOIN CMN_LookupMaster LMDiscrepancy with(nolock) ON GQ.DiscrepancyCategoryLkup=LMDiscrepancy.CMN_LookupMasterId And LMDiscrepancy.CMN_LookupTypeRef = 6
	LEFT JOIN CMN_LookupMaster LMDiscType with(nolock) ON GQ.DiscrepancyTypeLkup=LMDiscType.CMN_LookupMasterId And LMDiscType.CMN_LookupTypeRef = 7
	LEFT JOIN CMN_RecordsLocked RL with(nolock) ON RL.CaseId=GQ.GEN_QueueId AND RL.ScreenLkup = 37010 AND RL.IsActive=1
	LEFT JOIN CMN_LookupMaster LMAction with(nolock) ON GQ.MostRecentActionLkup=LMAction.CMN_LookupMasterId And LMAction.CMN_LookupTypeRef = 28
	LEFT JOIN CMN_LookupMaster LMStatus with(nolock) ON GQ.MostRecentStatusLkup=LMStatus.CMN_LookupMasterId And LMStatus.CMN_LookupTypeRef = 20
	LEFT JOIN CMN_LookupMaster LMQueue with(nolock) ON GQ.MostRecentWorkQueueLkup=LMQueue.CMN_LookupMasterId And LMQueue.CMN_LookupTypeRef = 10
	LEFT JOIN CMN_LookupMasterCorrelations LMQueueType with(nolock) ON GQ.MostRecentWorkQueueLkup=LMQueueType.CMN_LookupMasterChildRef AND LMQueueType.CMN_LookupTypeCorrelationsRef=3
	LEFT JOIN CMN_LookupMaster LMQueueProgType with(nolock) ON LMQueueType.GroupingLookupMasterRef=LMQueueProgType.CMN_LookupMasterId AND LMQueueProgType.CMN_LookupTypeRef = 9
	LEFT JOIN CMN_LookupMaster LMContractId with(nolock) ON GQ.MemberContractIDLkup=LMContractId.CMN_LookupMasterId And LMContractId.CMN_LookupTypeRef = 11
	LEFT JOIN CMN_LookupMaster LMPBPId with(nolock) ON GQ.MemberPBPLkup=LMPBPId.CMN_LookupMasterId And LMPBPId.CMN_LookupTypeRef = 12
	LEFT JOIN CMN_LookupMaster LMLOBId with(nolock) ON GQ.MemberLOBLkup=LMLOBId.CMN_LookupMasterId And LMLOBId.CMN_LookupTypeRef = 31
	LEFT JOIN CMN_LookupMaster LMActionRequested with(nolock) ON GQ.RPRActionRequestedLkup=LMActionRequested.CMN_LookupMasterId And LMActionRequested.CMN_LookupTypeRef = 14
	LEFT JOIN CMN_LookupMaster LMResolution with(nolock) ON GRPR.ResolutionLkup=LMResolution.CMN_LookupMasterId And LMResolution.CMN_LookupTypeRef = 18
	LEFT JOIN CMN_LookupMaster LMDiscSource with(nolock) ON GQ.DiscrepancySourceLkup=LMDiscSource.CMN_LookupMasterId	And LMDiscSource.CMN_LookupTypeRef = 13
	LEFT JOIN CMN_LookupMaster LMSubmissionType with(nolock) ON GRPR.SubmissionTypeLkup=LMSubmissionType.CMN_LookupMasterId And LMSubmissionType.CMN_LookupTypeRef = 17
	LEFT JOIN CMN_LookupMaster LMGender with(nolock) ON GQ.MemberGenderLkup=LMGender.CMN_LookupMasterId And LMGender.CMN_LookupTypeRef = 21
	LEFT JOIN CMN_LookupMaster LMElectionType with(nolock) ON GRPR.ElectionTypeLkup=LMElectionType.CMN_LookupMasterId And LMElectionType.CMN_LookupTypeRef = 23
	LEFT JOIN CMN_LookupMaster LMCTranStatus with(nolock) ON GQ.CMSTransactionStatusLkup=LMCTranStatus.CMN_LookupMasterId And LMCTranStatus.CMN_LookupTypeRef = 55
	INNER JOIN ADM_UserMaster UMC with(nolock) ON GQ.CreatedByRef=UMC.ADM_UserMasterId
	INNER JOIN ADM_UserMaster UML with(nolock) ON GQ.LastUpdatedByRef=UML.ADM_UserMasterId
	INNER JOIN ADM_UserMaster UMSupervior with(nolock) ON GQ.RPRSupervisorOrRequesterRef=UMSupervior.ADM_UserMasterId
	LEFT JOIN ADM_UserMaster UMLock with(nolock) ON GQ.LockedByRef=UMLock.ADM_UserMasterId
	LEFT JOIN ADM_UserMaster UMAssign with(nolock) ON GQ.AssignedToRef=UMAssign.ADM_UserMasterId
	LEFT JOIN ADM_UserMaster UMPended with(nolock) ON GQ.PendedbyRef=UMPended.ADM_UserMasterId
	
	Where
	GQ.DiscrepancyCategoryLkup=@DiscrepancyCategoryLkup
	AND (@DiscrepancyTypeLkup Is Null OR GQ.DiscrepancyTypeLkup=@DiscrepancyTypeLkup)
	AND (@CaseCreationStartDateId Is Null OR GQ.UTCCreatedOnId>=@CaseCreationStartDateId)
	AND (@CaseCreationEndDateId Is Null OR GQ.UTCCreatedOnId<=@CaseCreationEndDateId)
	AND GQ.IsActive=1
	AND (@IsUnlock IS NULL OR @IsUnlock = 0 OR (@IsUnlock = 1 AND GQ.LockedByRef is not null AND GQ.UTCLockedOn < DATEADD(hh,-1,GETUTCDATE())))	
	AND (@IsReAssign IS NULL OR @IsReAssign = 0 OR (@IsReAssign = 1 AND GQ.LockedByRef is null AND ((GQ.AssignedToRef IS NOT NULL AND GQ.MostRecentWorkQueueLkup = 10074) OR (GQ.PendedbyRef IS NOT NULL AND GQ.MostRecentWorkQueueLkup = 10081))))	
	AND (@IsRestricted = 1 OR (@IsRestricted = 0 AND (GQ.IsRestricted = 0 OR GQ.IsRestricted IS NULL)))

	SELECT DISTINCT COUNT(*) AS TotalRecords
    ,COUNT(CASE WHEN (IsRestricted=1)  THEN 1 END) AS RestrictedRecords
	,COUNT(CASE WHEN (IsRestricted=0 OR IsRestricted IS NULL)  THEN 1 END) AS UnRestrictedRecords
	From GEN_Queue GQ with(nolock)
	LEFT JOIN GEN_RPRActions GRPR with(nolock) ON GQ.GEN_QueueId=GRPR.GEN_QueueRef
	LEFT JOIN CMN_RecordsLocked RL with(nolock) ON RL.CaseId=GQ.GEN_QueueId AND RL.ScreenLkup = 37010 AND RL.IsActive=1
	Where
	GQ.DiscrepancyCategoryLkup=@DiscrepancyCategoryLkup
	AND (@DiscrepancyTypeLkup Is Null OR GQ.DiscrepancyTypeLkup=@DiscrepancyTypeLkup)
	AND (@CaseCreationStartDateId Is Null OR GQ.UTCCreatedOnId>=@CaseCreationStartDateId)
	AND (@CaseCreationEndDateId Is Null OR GQ.UTCCreatedOnId<=@CaseCreationEndDateId)
	AND GQ.IsActive=1
	AND (@IsUnlock IS NULL OR @IsUnlock = 0 OR (@IsUnlock = 1 AND GQ.LockedByRef is not null AND GQ.UTCLockedOn < DATEADD(hh,-1,GETUTCDATE())))	
	AND (@IsReAssign IS NULL OR @IsReAssign = 0 OR (@IsReAssign = 1 AND GQ.LockedByRef is null AND ((GQ.AssignedToRef IS NOT NULL AND GQ.MostRecentWorkQueueLkup = 10074) OR (GQ.PendedbyRef IS NOT NULL AND GQ.MostRecentWorkQueueLkup = 10081))))
		
End
Else
Begin
Select DISTINCT TOP (@TopCount)
	GEN_QueueId as WorkItemID,
	[dbo].[GetAge](GQ.[GEN_QueueId]) AS Aging,
	GQ.MemberSCCCode as MemberSCCCode,
	GQ.MemberID as MemberID,
	GQ.MemberMedicareId as MemberCurrentHICN,
	GQ.GPSHouseholdID as GPSHouseholdID,
	GQ.MemberFirstName as MemberFirstName,
	GQ.MemberMiddleName as MemberMiddleName,
	GQ.MemberLastName as MemberLastName,
	LMContractId.LookupValue as MemberContractID,
	GQ.MemberDOB as MemberDOB,
	LMPBPId.LookupValue as MemberPBP,
	LMLOBId.LookupValue as MemberLOB,
	LMGender.LookupValue as MemberGender,
	LMAction.LookupValue as MostRecentAction,
	GQ.MemberMedicareId as CurrentHICN,
	NULL as GPSHICN,
	NULL as MMRHICN,
	LMWorkBasket.LookupValue as BusinessSegment,
	GQ.BusinessSegmentLkup, 
	LMDiscrepancy.LookupValue as DiscrepancyCategory,
	GQ.DiscrepancyCategoryLkup, 
	LMDiscType.LookupValue as DiscrepancyType,
	GQ.MostRecentStatusLkup,
	LMStatus.LookupValue as MostRecentStatus,	
	GQ.MostRecentWorkQueueLkup,
	LMQueue.LookupValue as MostRecentQueue,
	LMQueueType.GroupingLookupMasterRef as QueueProgressTypeLkup,
	LMQueueProgType.LookupValue as QueueProgressType,
	GQ.DiscrepancyStartDate as DiscrepancyStartDate,
	GQ.DiscrepancyEndDate as DiscrepancyEndDate,
	NULL as Reason,
	LMResolution.LookupValue as Resolution,
	NULL as ReferencedEligibilityCaseIndicator,
	NULL as MMRPBP,
	NULL as GPSIndividualID,
	LMDiscSource.LookupValue as DiscrepancySource,
	LMSubmissionType.LookupValue as SubmissionType,
	GQ.RPRCTMMember as CTMMember,
	GQ.RPREGHPMember as EGHPMember,
	GQ.RPRRequestedEffectiveDate as RequestedEffectiveDate,
	GQ.RPRActionRequestedLkup as RPRActionRequestedLkup,
	LMActionRequested.LookupValue as ActionRequested,
	LMElectionType.LookupValue as ElectionType,
	GRPR.PotentialSubmissionDate as PotentialSubmissionDate,
	GRPR.RPCSubmissionDate as RPCSubmissionDate,
	GRPR.FDRReceivedDate as FDRReceivedDate,
	GRPR.FDRCodeReceived as FDRCodeReceived,
	UMC.FullName as RPRRequestor,
	GQ.ComplianceStartDate as ComplianceStartDate,
	NULL as AdjustedComplianceStartDate,
	GQ.UTCCreatedOn,
	GQ.CreatedByRef,
	UMC.FullName as CreatedBy,
	GQ.UTCLastUpdatedOn,
	GQ.LastUpdatedByRef,
	UML.FullName as LastUpdatedBy,
	GQ.LockedByRef,
	GQ.UTCLockedOn,
	UMLock.FullName as LockedBy,
	GQ.AssignedToRef,
	GQ.UTCAssignedOn,
	UMAssign.FullName as AssignedTo,
	GQ.PendedbyRef,
	GQ.UTCPendedOn,
	UMPended.FullName as PendedBy,
	NULL as OOALetterStatusLkup,
	NULL as OOALetterStatus,
	GQ.CMSTransactionStatusLkup,
	LMCTranStatus.LookupValue as CMSTransactionStatus
	From GEN_Queue GQ with(nolock)
	LEFT JOIN GEN_RPRActions GRPR with(nolock) ON GQ.GEN_QueueId=GRPR.GEN_QueueRef 
	LEFT JOIN CMN_LookupMaster LMWorkBasket with(nolock) ON GQ.BusinessSegmentLkup=LMWorkBasket.CMN_LookupMasterId And LMWorkBasket.CMN_LookupTypeRef = 1
	LEFT JOIN CMN_LookupMaster LMDiscrepancy with(nolock) ON GQ.DiscrepancyCategoryLkup=LMDiscrepancy.CMN_LookupMasterId And LMDiscrepancy.CMN_LookupTypeRef = 6
	LEFT JOIN CMN_LookupMaster LMDiscType with(nolock) ON GQ.DiscrepancyTypeLkup=LMDiscType.CMN_LookupMasterId And LMDiscType.CMN_LookupTypeRef = 7
	LEFT JOIN CMN_RecordsLocked RL with(nolock) ON RL.CaseId=GQ.GEN_QueueId AND RL.ScreenLkup = 37010 AND RL.IsActive=1
	LEFT JOIN CMN_LookupMaster LMAction with(nolock) ON GQ.MostRecentActionLkup=LMAction.CMN_LookupMasterId And LMAction.CMN_LookupTypeRef = 28
	LEFT JOIN CMN_LookupMaster LMStatus with(nolock) ON GQ.MostRecentStatusLkup=LMStatus.CMN_LookupMasterId And LMStatus.CMN_LookupTypeRef = 20
	LEFT JOIN CMN_LookupMaster LMQueue with(nolock) ON GQ.MostRecentWorkQueueLkup=LMQueue.CMN_LookupMasterId And LMQueue.CMN_LookupTypeRef = 10
	LEFT JOIN CMN_LookupMasterCorrelations LMQueueType with(nolock) ON GQ.MostRecentWorkQueueLkup=LMQueueType.CMN_LookupMasterChildRef AND LMQueueType.CMN_LookupTypeCorrelationsRef=3
	LEFT JOIN CMN_LookupMaster LMQueueProgType with(nolock) ON LMQueueType.GroupingLookupMasterRef=LMQueueProgType.CMN_LookupMasterId AND LMQueueProgType.CMN_LookupTypeRef = 9
	LEFT JOIN CMN_LookupMaster LMContractId with(nolock) ON GQ.MemberContractIDLkup=LMContractId.CMN_LookupMasterId And LMContractId.CMN_LookupTypeRef = 11
	LEFT JOIN CMN_LookupMaster LMPBPId with(nolock) ON GQ.MemberPBPLkup=LMPBPId.CMN_LookupMasterId And LMPBPId.CMN_LookupTypeRef = 12
	LEFT JOIN CMN_LookupMaster LMLOBId with(nolock) ON GQ.MemberLOBLkup=LMLOBId.CMN_LookupMasterId And LMLOBId.CMN_LookupTypeRef = 31
	LEFT JOIN CMN_LookupMaster LMActionRequested with(nolock) ON GQ.RPRActionRequestedLkup=LMActionRequested.CMN_LookupMasterId And LMActionRequested.CMN_LookupTypeRef = 14
	LEFT JOIN CMN_LookupMaster LMResolution with(nolock) ON GRPR.ResolutionLkup=LMResolution.CMN_LookupMasterId And LMResolution.CMN_LookupTypeRef = 18
	LEFT JOIN CMN_LookupMaster LMDiscSource with(nolock) ON GQ.DiscrepancySourceLkup=LMDiscSource.CMN_LookupMasterId	And LMDiscSource.CMN_LookupTypeRef = 13
	LEFT JOIN CMN_LookupMaster LMSubmissionType with(nolock) ON GRPR.SubmissionTypeLkup=LMSubmissionType.CMN_LookupMasterId And LMSubmissionType.CMN_LookupTypeRef = 17
	LEFT JOIN CMN_LookupMaster LMGender with(nolock) ON GQ.MemberGenderLkup=LMGender.CMN_LookupMasterId And LMGender.CMN_LookupTypeRef = 21
	LEFT JOIN CMN_LookupMaster LMElectionType with(nolock) ON GRPR.ElectionTypeLkup=LMElectionType.CMN_LookupMasterId And LMElectionType.CMN_LookupTypeRef = 23
	LEFT JOIN CMN_LookupMaster LMCTranStatus with(nolock) ON GQ.CMSTransactionStatusLkup=LMCTranStatus.CMN_LookupMasterId And LMCTranStatus.CMN_LookupTypeRef = 55
	INNER JOIN ADM_UserMaster UMC with(nolock) ON GQ.CreatedByRef=UMC.ADM_UserMasterId
	INNER JOIN ADM_UserMaster UML with(nolock) ON GQ.LastUpdatedByRef=UML.ADM_UserMasterId
	INNER JOIN ADM_UserMaster UMSupervior with(nolock) ON GQ.RPRSupervisorOrRequesterRef=UMSupervior.ADM_UserMasterId
	LEFT JOIN ADM_UserMaster UMLock with(nolock) ON GQ.LockedByRef=UMLock.ADM_UserMasterId
	LEFT JOIN ADM_UserMaster UMAssign with(nolock) ON GQ.AssignedToRef=UMAssign.ADM_UserMasterId
	LEFT JOIN ADM_UserMaster UMPended with(nolock) ON GQ.PendedbyRef=UMPended.ADM_UserMasterId
		
	Where
		(@WorkItemId Is Null OR GQ.GEN_QueueId=@WorkItemId)
	AND GQ.IsActive=1
	AND (GRPR.GEN_RPRActionsId IS NULL OR GRPR.IsActive=1)
	AND (@IsUnlock IS NULL OR @IsUnlock = 0 OR (@IsUnlock = 1 AND GQ.LockedByRef is not null AND GQ.UTCLockedOn < DATEADD(hh,-1,GETUTCDATE())))	
	AND (@IsReAssign IS NULL OR @IsReAssign = 0 OR (@IsReAssign = 1 AND GQ.LockedByRef is null AND ((GQ.AssignedToRef IS NOT NULL AND GQ.MostRecentWorkQueueLkup = 10074) OR (GQ.PendedbyRef IS NOT NULL AND GQ.MostRecentWorkQueueLkup = 10081))))
	AND (@IsMassUpdate IS NULL OR @IsMassUpdate =0 OR (@IsMassUpdate =1 AND GQ.LockedByRef is null AND GQ.UTCLockedOn IS NULL))
	AND (@BusinessSegmentLkup IS NULL OR GQ.BusinessSegmentLkup=@BusinessSegmentLkup)
	AND (@WorkBasketLkup IS NULL OR GQ.WorkBasketLkup=@WorkBasketLkup)
	AND (@DiscrepancyCategoryLkup Is Null OR GQ.DiscrepancyCategoryLkup=@DiscrepancyCategoryLkup)
	AND (@DiscrepancyTypeLkup Is Null OR GQ.DiscrepancyTypeLkup=@DiscrepancyTypeLkup)
	AND (@DiscrepancyTypeLkupNot Is Null OR GQ.DiscrepancyTypeLkup!=@DiscrepancyTypeLkupNot)
	AND (@DiscrepancySourceLkup Is Null OR GQ.DiscrepancySourceLkup=@DiscrepancySourceLkup)
	AND (@LOBLkup Is Null OR GQ.MemberLOBLkup=@LOBLkup )
	AND (@AssignedTo Is Null OR GQ.AssignedToRef=@AssignedTo)
	AND (@ActionRequested Is Null OR GQ.RPRActionRequestedLkup=@ActionRequested)
	AND (@EGHPMember Is Null OR GQ.RPREGHPMember=@EGHPMember)
	AND (@EmployerId Is Null OR GQ.RPREmployerID=@EmployerId)
	AND (@Queue Is Null OR GQ.MostRecentWorkQueueLkup=@Queue)
	AND (@GPSHouseholdId Is Null OR GQ.GPSHouseholdID=@GPSHouseholdId)
	AND (@CurrentHICN Is Null OR GQ.MemberCurrentHICN = @CurrentHICN OR GQ.EligGPSCurrentHICN = @CurrentHICN OR GQ.EligMMRCurrentHICN = @CurrentHICN  OR GQ.[MemberMedicareId] = @CurrentHICN)
	AND (@ContractIDLkup Is Null OR GQ.MemberContractIDLkup =@ContractIDLkup OR GQ.EligGPSContractIDLkup =@ContractIDLkup OR GQ.EligMMRContractIDLkup = @ContractIDLkup)
	AND (@PBPLkup Is Null OR GQ.MemberPBPLkup =@PBPLkup OR GQ.EligGPSPBPLkup =@PBPLkup OR GQ.EligMMRPBPLkup = @PBPLkup)
	AND (@Status Is Null OR GQ.MostRecentStatusLkup=@Status) AND (@StatusNot IS NULL OR GQ.MostRecentStatusLkup !=@StatusNot)
	AND (@CTMMember Is Null OR GQ.RPRCTMMember=@CTMMember)
	AND (@CTMNumber Is Null OR GQ.RPRCTMNumber=@CTMNumber)
	AND (@MemberSCCCode Is Null OR GQ.MemberSCCCode=@MemberSCCCode)
	AND (@FirstName  Is Null OR GQ.MemberFirstName like '%'+@FirstName+'%' )
	AND (@LastName  Is Null OR GQ.MemberLastName like '%'+@LastName+'%' )
	AND (@GenderLkup IS NULL OR GQ.MemberGenderLkup=@GenderLkup)
	AND (@DOBId Is Null OR GQ.MemberDOBId=@DOBId)
	AND (@DiscrepancyStartDateId Is Null OR GQ.DiscrepancyStartDateId>=@DiscrepancyStartDateId)
	AND (@DiscrepancyEndDateId Is Null OR GQ.DiscrepancyStartDateId<=@DiscrepancyEndDateId)
	AND (@ComplianceStartDateId  Is Null OR GQ.ComplianceStartDateId>=@ComplianceStartDateId)
	AND (@ComplianceEndDateId Is Null OR GQ.ComplianceStartDateId<=@ComplianceEndDateId )	
	AND (@CaseCreationStartDateId Is Null OR GQ.UTCCreatedOnId>=@CaseCreationStartDateId)
	AND (@CaseCreationEndDateId Is Null OR GQ.UTCCreatedOnId<=@CaseCreationEndDateId)
	AND (@CaseLastUpdatedStartDateId Is Null OR GQ.UTCLastUpdatedOnId>=@CaseLastUpdatedStartDateId)
	AND (@CaseLastUpdatedEndDateId Is Null OR GQ.UTCLastUpdatedOnId<=@CaseLastUpdatedEndDateId)
	AND (@CaseAgeFrom  Is Null OR Aging>=@CaseAgeFrom)
	AND (@CaseAgeTo Is Null OR Aging<=@CaseAgeTo)
	AND (@RequestedEffectiveStartDateId Is Null OR GQ.RPRRequestedEffectiveDateId>=@RequestedEffectiveStartDateId)
	AND (@RequestedEffectiveEndDateId Is Null OR GQ.RPRRequestedEffectiveDateId<=@RequestedEffectiveEndDateId)
	AND (@TaskBeingPerformedWhenThisDiscrepancyWasIdentified  Is Null OR GQ.RPRTaskPerformedLkup=@TaskBeingPerformedWhenThisDiscrepancyWasIdentified)
	AND (@SupervisiorofthePersonEnteringtheRequest Is Null OR GQ.RPRSupervisorOrRequesterRef=@SupervisiorofthePersonEnteringtheRequest)
	AND (@PendReason Is Null OR GRPR.PendReasonLkup=@PendReason)
	AND (@Resolution Is Null OR GRPR.ResolutionLkup=@Resolution)
	AND (@VerifiedRootCause Is Null OR GRPR.RootCauseLkup=@VerifiedRootCause)
	AND (@SubmissionTypeLkup Is Null OR GRPR.SubmissionTypeLkup=@SubmissionTypeLkup)
	AND (@FDRStatus  Is Null OR GRPR.FDRStatusLkup=@FDRStatus)
	AND (@LastUpdatedOperator Is Null OR GQ.LastUpdatedByRef=@LastUpdatedOperator)
	AND (@RPRRequestor Is Null OR GQ.CreatedByRef=@RPRRequestor)
    AND (@FDRCodeReceived Is Null OR GRPR.FDRCodeReceived=@FDRCodeReceived )
	AND (@RPCSubmissionStartDateId Is Null OR GRPR.RPCSubmissionDateId>=@RPCSubmissionStartDateId )
	AND (@RPCSubmissionEndDateId Is Null OR GRPR.RPCSubmissionDateId<=@RPCSubmissionEndDateId )
	AND (@CMSAccountManagerApprovalStartDateId  Is Null OR GRPR.CMSAccountManagerApprovalDateId>=@CMSAccountManagerApprovalStartDateId  )
	AND (@CMSAccountManagerApprovalEndDateId Is Null OR GRPR.CMSAccountManagerApprovalDateId<=@CMSAccountManagerApprovalEndDateId )
	AND (@FDRReceivedStartDateId Is Null OR GRPR.FDRReceivedDateId>=@FDRReceivedStartDateId )
	AND (@FDRReceivedStartDateId Is Null OR GRPR.FDRReceivedDateId<=@FDRReceivedStartDateId )
	AND (@AdjustedCreateStartDateId Is Null OR GRPR.AdjustedCreateDateId>=@AdjustedCreateStartDateId )
	AND (@AdjustedCreateEndDateId Is Null OR GRPR.AdjustedCreateDateId<=@AdjustedCreateEndDateId )
	AND (@PeerAuditCompletionStartDateId Is Null OR GQ.PeerAuditCompletedDateId >= @PeerAuditCompletionStartDateId)
	AND (@PeerAuditCompletionEndDateId Is Null OR GQ.PeerAuditCompletedDateId <= @PeerAuditCompletionEndDateId)
	AND (@IsRestricted = 1 OR (@IsRestricted = 0 AND (GQ.IsRestricted = 0 OR GQ.IsRestricted IS NULL)))

	SELECT DISTINCT COUNT(*) AS TotalRecords
    ,COUNT(CASE WHEN (IsRestricted=1)  THEN 1 END) AS RestrictedRecords
	,COUNT(CASE WHEN (IsRestricted=0 OR IsRestricted IS NULL)  THEN 1 END) AS UnRestrictedRecords
	From GEN_Queue GQ with(nolock)
	LEFT JOIN GEN_RPRActions GRPR with(nolock) ON GQ.GEN_QueueId=GRPR.GEN_QueueRef
	LEFT JOIN CMN_RecordsLocked RL with(nolock) ON RL.CaseId=GQ.GEN_QueueId AND RL.ScreenLkup = 37010 AND RL.IsActive=1
	Where
		(@WorkItemId Is Null OR GQ.GEN_QueueId=@WorkItemId)
	AND GQ.IsActive=1
	AND (GRPR.GEN_RPRActionsId IS NULL OR GRPR.IsActive=1)
	AND (@IsUnlock IS NULL OR @IsUnlock = 0 OR (@IsUnlock = 1 AND GQ.LockedByRef is not null AND GQ.UTCLockedOn < DATEADD(hh,-1,GETUTCDATE())))	
	AND (@IsReAssign IS NULL OR @IsReAssign = 0 OR (@IsReAssign = 1 AND GQ.LockedByRef is null AND ((GQ.AssignedToRef IS NOT NULL AND GQ.MostRecentWorkQueueLkup = 10074) OR (GQ.PendedbyRef IS NOT NULL AND GQ.MostRecentWorkQueueLkup = 10081))))
	AND (@IsMassUpdate IS NULL OR @IsMassUpdate =0 OR (@IsMassUpdate =1 AND GQ.LockedByRef is null AND GQ.UTCLockedOn IS NULL))
	AND (@BusinessSegmentLkup IS NULL OR GQ.BusinessSegmentLkup=@BusinessSegmentLkup)
	AND (@WorkBasketLkup IS NULL OR GQ.WorkBasketLkup=@WorkBasketLkup)
	AND (@DiscrepancyCategoryLkup Is Null OR GQ.DiscrepancyCategoryLkup=@DiscrepancyCategoryLkup)
	AND (@DiscrepancyTypeLkup Is Null OR GQ.DiscrepancyTypeLkup=@DiscrepancyTypeLkup)
	AND (@DiscrepancyTypeLkupNot Is Null OR GQ.DiscrepancyTypeLkup!=@DiscrepancyTypeLkupNot)
	AND (@DiscrepancySourceLkup Is Null OR GQ.DiscrepancySourceLkup=@DiscrepancySourceLkup)
	AND (@LOBLkup Is Null OR GQ.MemberLOBLkup=@LOBLkup )
	AND (@AssignedTo Is Null OR GQ.AssignedToRef=@AssignedTo)
	AND (@ActionRequested Is Null OR GQ.RPRActionRequestedLkup=@ActionRequested)
	AND (@EGHPMember Is Null OR GQ.RPREGHPMember=@EGHPMember)
	AND (@EmployerId Is Null OR GQ.RPREmployerID=@EmployerId)
	AND (@Queue Is Null OR GQ.MostRecentWorkQueueLkup=@Queue)
	AND (@GPSHouseholdId Is Null OR GQ.GPSHouseholdID=@GPSHouseholdId)
	AND (@CurrentHICN Is Null OR GQ.MemberCurrentHICN = @CurrentHICN OR GQ.EligGPSCurrentHICN = @CurrentHICN OR GQ.EligMMRCurrentHICN = @CurrentHICN  OR GQ.[MemberMedicareId] = @CurrentHICN)
	AND (@ContractIDLkup Is Null OR GQ.MemberContractIDLkup =@ContractIDLkup OR GQ.EligGPSContractIDLkup =@ContractIDLkup OR GQ.EligMMRContractIDLkup = @ContractIDLkup)
	AND (@PBPLkup Is Null OR GQ.MemberPBPLkup =@PBPLkup OR GQ.EligGPSPBPLkup =@PBPLkup OR GQ.EligMMRPBPLkup = @PBPLkup)
	AND (@Status Is Null OR GQ.MostRecentStatusLkup=@Status) AND (@StatusNot IS NULL OR GQ.MostRecentStatusLkup !=@StatusNot)
	AND (@CTMMember Is Null OR GQ.RPRCTMMember=@CTMMember)
	AND (@CTMNumber Is Null OR GQ.RPRCTMNumber=@CTMNumber)
	AND (@MemberSCCCode Is Null OR GQ.MemberSCCCode=@MemberSCCCode)
	AND (@FirstName  Is Null OR GQ.MemberFirstName like '%'+@FirstName+'%' )
	AND (@LastName  Is Null OR GQ.MemberLastName like '%'+@LastName+'%' )
	AND (@GenderLkup IS NULL OR GQ.MemberGenderLkup=@GenderLkup)
	AND (@DOBId Is Null OR GQ.MemberDOBId=@DOBId)
	AND (@DiscrepancyStartDateId Is Null OR GQ.DiscrepancyStartDateId>=@DiscrepancyStartDateId)
	AND (@DiscrepancyEndDateId Is Null OR GQ.DiscrepancyStartDateId<=@DiscrepancyEndDateId)
	AND (@ComplianceStartDateId  Is Null OR GQ.ComplianceStartDateId>=@ComplianceStartDateId)
	AND (@ComplianceEndDateId Is Null OR GQ.ComplianceStartDateId<=@ComplianceEndDateId )	
	AND (@CaseCreationStartDateId Is Null OR GQ.UTCCreatedOnId>=@CaseCreationStartDateId)
	AND (@CaseCreationEndDateId Is Null OR GQ.UTCCreatedOnId<=@CaseCreationEndDateId)
	AND (@CaseLastUpdatedStartDateId Is Null OR GQ.UTCLastUpdatedOnId>=@CaseLastUpdatedStartDateId)
	AND (@CaseLastUpdatedEndDateId Is Null OR GQ.UTCLastUpdatedOnId<=@CaseLastUpdatedEndDateId)
	AND (@CaseAgeFrom  Is Null OR Aging>=@CaseAgeFrom)
	AND (@CaseAgeTo Is Null OR Aging<=@CaseAgeTo)
	AND (@RequestedEffectiveStartDateId Is Null OR GQ.RPRRequestedEffectiveDateId>=@RequestedEffectiveStartDateId)
	AND (@RequestedEffectiveEndDateId Is Null OR GQ.RPRRequestedEffectiveDateId<=@RequestedEffectiveEndDateId)
	AND (@TaskBeingPerformedWhenThisDiscrepancyWasIdentified  Is Null OR GQ.RPRTaskPerformedLkup=@TaskBeingPerformedWhenThisDiscrepancyWasIdentified)
	AND (@SupervisiorofthePersonEnteringtheRequest Is Null OR GQ.RPRSupervisorOrRequesterRef=@SupervisiorofthePersonEnteringtheRequest)
	AND (@PendReason Is Null OR GRPR.PendReasonLkup=@PendReason)
	AND (@Resolution Is Null OR GRPR.ResolutionLkup=@Resolution)
	AND (@VerifiedRootCause Is Null OR GRPR.RootCauseLkup=@VerifiedRootCause)
	AND (@SubmissionTypeLkup Is Null OR GRPR.SubmissionTypeLkup=@SubmissionTypeLkup)
	AND (@FDRStatus  Is Null OR GRPR.FDRStatusLkup=@FDRStatus)
	AND (@LastUpdatedOperator Is Null OR GQ.LastUpdatedByRef=@LastUpdatedOperator)
	AND (@RPRRequestor Is Null OR GQ.CreatedByRef=@RPRRequestor)
    AND (@FDRCodeReceived Is Null OR GRPR.FDRCodeReceived=@FDRCodeReceived )
	AND (@RPCSubmissionStartDateId Is Null OR GRPR.RPCSubmissionDateId>=@RPCSubmissionStartDateId )
	AND (@RPCSubmissionEndDateId Is Null OR GRPR.RPCSubmissionDateId<=@RPCSubmissionEndDateId )
	AND (@CMSAccountManagerApprovalStartDateId  Is Null OR GRPR.CMSAccountManagerApprovalDateId>=@CMSAccountManagerApprovalStartDateId  )
	AND (@CMSAccountManagerApprovalEndDateId Is Null OR GRPR.CMSAccountManagerApprovalDateId<=@CMSAccountManagerApprovalEndDateId )
	AND (@FDRReceivedStartDateId Is Null OR GRPR.FDRReceivedDateId>=@FDRReceivedStartDateId )
	AND (@FDRReceivedStartDateId Is Null OR GRPR.FDRReceivedDateId<=@FDRReceivedStartDateId )
	AND (@AdjustedCreateStartDateId Is Null OR GRPR.AdjustedCreateDateId>=@AdjustedCreateStartDateId )
	AND (@AdjustedCreateEndDateId Is Null OR GRPR.AdjustedCreateDateId<=@AdjustedCreateEndDateId )
	AND (@PeerAuditCompletionStartDateId Is Null OR GQ.PeerAuditCompletedDateId >= @PeerAuditCompletionStartDateId)
	AND (@PeerAuditCompletionEndDateId Is Null OR GQ.PeerAuditCompletedDateId <= @PeerAuditCompletionEndDateId)
End
END

END TRY 

BEGIN CATCH

SET @ErrorMessage= ERROR_MESSAGE();

END CATCH 

END