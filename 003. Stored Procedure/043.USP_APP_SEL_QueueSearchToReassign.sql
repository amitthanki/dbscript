IF OBJECT_ID ('USP_APP_SEL_QueueSearchToReassign') IS NOT NULL 
DROP PROC [DBO].[USP_APP_SEL_QueueSearchToReassign]
GO

/****** Object:  StoredProcedure [dbo].[USP_APP_SEL_QueueSearchToReassign]    Script Date: 05/07/2017 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- =============================================
-- Author: Venkatasubramanyam
-- Create date: 17/07/2017
-- Description: Get assigned Records(OST,Eligibility, RPR) to reassign to ther user.
-- Eg.
 --Declare @ErrorMessage VARCHAR(2000)
 --Set @ErrorMessage=''
 --Exec [USP_APP_SEL_QueueSearchToReassign] ,@WorkItemId=1,@ErrorMessage = @ErrorMessage Output
-- =============================================
Create PROCEDURE [dbo].[USP_APP_SEL_QueueSearchToReassign]
@WorkItemId BIGINT=NULL,
@BusinessSegmentLkup BIGINT=NULL,
@WorkBasketLkup BIGINT=NULL,
@DiscrepancyCategoryLkup BIGINT=NULL,    
@DiscrepancyTypeLkup BIGINT=NULL,        
@DiscrepancySourceLkup BIGINT=NULL,       
@LOBLkup BIGINT=NULL,    
@CaseAgeFrom BIGINT=NULL,    
@CaseAgeTo BIGINT=NULL,    
@LastUpdatedOperator BIGINT=NULL,    
@AssignedTo BIGINT=NULL,    
@ActionRequested BIGINT=NULL,    
@SupervisiorofthePersonEnteringtheRequest BIGINT=NULL,    
@EGHPMember BIGINT=NULL,    
@EmployerId BIGINT=NULL,    
@FDRStatus BIGINT=NULL,    
@VerifiedRootCause BIGINT=NULL,    
@TaskBeingPerformedWhenThisDiscrepancyWasIdentified BIGINT=NULL,    
@SubmissionTypeLkup BIGINT=NULL,    
@PendReason BIGINT=NULL,    
@Resolution BIGINT=NULL,    
@RPRRequestor BIGINT=NULL,    
@Queue BIGINT=NULL,    
@Status BIGINT=NULL,    
@GenderLkup BIGINT=NULL,    
@CurrentHICN VARCHAR(100)=NULL,
@CTMNumber VARCHAR(100)=NULL,
@CTMMember VARCHAR(100)=NULL,
@MemberSCCCode VARCHAR(100)=NULL,
@FirstName VARCHAR(100)=NULL,
@LastName VARCHAR(100)=NULL,
@ContractNumer VARCHAR(100)=NULL,
@PBP VARCHAR(100)=NULL,
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
@ErrorMessage varchar(2000) OUTPUT
as

BEGIN  

BEGIN TRY 

IF @PageType IS NOT NULL AND @PageType=3001--OST
BEGIN
Select DISTINCT TOP 500 
	GEN_QueueId as WorkItemID,
	UMLocked.FullName as LockedBy,
	GQ.UTCLockedOn as UTCLockedOn,
	UM.FullName as CreatedBy,
	GQ.UTCCreatedOn as UTCCreatedOn,
	GQ.UTCLastUpdatedOn as UTCLastUpdatedOn,
	UMLastUpdate.FullName as LastUpdatedBy,
	UMAssigned.FullName as AssignedTo,
	DATEDIFF(DAY,GQ.DiscrepancyStartDate,GETUTCDATE()) AS Urgency,
	LMAction.LookupValue as Status,
	GQ.MemberCurrentHICN as CurrentHICN,
	GQ.EligGPSCurrentHICN as GPSHICN,
	GQ.EligMMRCurrentHICN as MMRHICN,
	UM.FirstName as FirstName,
	LMDiscrepancy.LookupValue as DiscrepancyCategory,
	LMDiscrepancy.CMN_LookupMasterId as DiscrepancyCategoryLkup, 
	GQ.StartDate as DiscrepancyStartDate,
	GQ.EndDate as DiscrepancyEndDate,
	GOST.Reason as Reason,
	LMResolution.LookupValue as Resolution,
	LMLOB.LookupValue as LineofBusiness,
	NULL as ReferencedEligibilityCaseIndicator,
	LMMMRPBP.LookupValue as MMRPBP,
	NULL as GPSIndividualID,
	LMDiscSource.LookupValue as DiscrepancySource,
	NULL as NTID,
	NULL as SubmissionType,
	UMCTMMember.FullName as CTMMember,
	UMEGHPMember.FullName as EGHPMember,
	GQ.RPRRequestedEffectiveDate as RequestedEffectiveDate,
	LMActionRequested.LookupValue as ActionRequested,
	NULL as PotentialSubmissionDate,
	NULL as RPCSubmissionDate,
	NULL as FDRReceivedDate,
	NULL as FDRCodeReceived,
	NULL as FDRStatus,
	NULL as RPRRequestor
	From GEN_Queue GQ with(nolock)
	JOIN ADM_UserMaster UM with(nolock) ON GQ.CreatedByRef=UM.ADM_UserMasterId
	LEFT JOIN ADM_UserMaster UMLocked with(nolock) ON GQ.LockedByRef=UMLocked.ADM_UserMasterId
	LEFT JOIN ADM_UserMaster UMLastUpdate with(nolock) ON GQ.LastUpdatedByRef=UMLastUpdate.ADM_UserMasterId
	JOIN ADM_UserMaster UMAssigned with(nolock) ON GQ.AssignedToRef=UMAssigned.ADM_UserMasterId
	JOIN GEN_OSTActions GOST with(nolock) ON GQ.GEN_QueueId=GOST.GEN_QueueRef
	LEFT JOIN CMN_LookupMaster LMAction with(nolock)ON GOST.ActionLkup=LMAction.CMN_LookupMasterId And LMAction.CMN_LookupTypeRef = 28
	LEFT JOIN CMN_LookupMaster LMDiscrepancy with(nolock) ON GQ.DiscrepancyCategoryLkup=LMDiscrepancy.CMN_LookupMasterId And LMDiscrepancy.CMN_LookupTypeRef = 6
	LEFT JOIN CMN_LookupMaster LMResolution with(nolock) ON GOST.ResolutionLkup=LMResolution.CMN_LookupMasterId And LMResolution.CMN_LookupTypeRef = 18
	LEFT JOIN CMN_LookupMaster LMLOB with(nolock) ON GQ.MemberLOBLkup=LMLOB.CMN_LookupMasterId And LMLOB.CMN_LookupTypeRef = 31
	LEFT JOIN CMN_LookupMaster LMMMRPBP with(nolock) ON GQ.EligMMRPBPLkup=LMMMRPBP.CMN_LookupMasterId 
	LEFT JOIN CMN_LookupMaster LMDiscSource with(nolock) ON GQ.DiscrepancySourceLkup=LMDiscSource.CMN_LookupMasterId And LMDiscSource.CMN_LookupTypeRef = 13
	LEFT JOIN ADM_UserMaster UMCTMMember with(nolock) ON GQ.RPRCTMMember=UMCTMMember.ADM_UserMasterId
	LEFT JOIN ADM_UserMaster UMEGHPMember with(nolock) ON GQ.RPREGHPMember=UMEGHPMember.ADM_UserMasterId
	LEFT JOIN CMN_LookupMaster LMActionRequested with(nolock) ON GQ.RPRActionRequestedLkup=LMActionRequested.CMN_LookupMasterId And LMActionRequested.CMN_LookupTypeRef = 14
	Where
	(@WorkItemId Is Null OR GQ.GEN_QueueId=@WorkItemId)
	AND GQ.IsActive=1
	AND GQ.AssignedToRef is not null
	AND (@BusinessSegmentLkup IS NULL OR GQ.BusinessSegmentLkup=@BusinessSegmentLkup)
	AND (@DiscrepancyCategoryLkup Is Null OR GQ.DiscrepancyCategoryLkup=@DiscrepancyCategoryLkup)
	AND (@DiscrepancyTypeLkup Is Null OR GQ.DiscrepancyTypeLkup=@DiscrepancyTypeLkup)
	AND (@DiscrepancySourceLkup Is Null OR GQ.DiscrepancySourceLkup=@DiscrepancySourceLkup)
	AND (@LOBLkup Is Null OR GQ.MemberLOBLkup=@LOBLkup )
	AND (@AssignedTo Is Null OR GQ.AssignedToRef=@AssignedTo)
	AND (@ActionRequested Is Null OR GQ.RPRActionRequestedLkup=@ActionRequested)
	AND (@EGHPMember Is Null OR GQ.RPREGHPMember=@EGHPMember)
	AND (@EmployerId Is Null OR GQ.RPREmployerID=@EmployerId)
	AND (@Queue Is Null OR GQ.MostRecentWorkQueueLkup=@Queue)
	AND ((@CurrentHICN Is Null OR GQ.MemberCurrentHICN = @CurrentHICN)OR(@CurrentHICN Is Null OR GQ.EligGPSCurrentHICN = @CurrentHICN)OR(@CurrentHICN Is Null OR GQ.EligMMRCurrentHICN = @CurrentHICN))
	AND (@Status Is Null OR GQ.MostRecentStatusLkup=@Status)
	AND (@CTMMember Is Null OR GQ.RPRCTMMember=@CTMMember)
	AND (@CTMNumber Is Null OR GQ.RPRCTMNumber=@CTMNumber)
	AND (@MemberSCCCode Is Null OR GQ.MemberSCCCode=@MemberSCCCode)
	AND (@FirstName  Is Null OR GQ.MemberFirstName=@FirstName )
	AND (@LastName  Is Null OR GQ.MemberLastName=@LastName )
	AND (@DiscrepancyStartDateId Is Null OR GQ.DiscrepancyStartDateId>=@DiscrepancyStartDateId)
	AND (@DiscrepancyEndDateId Is Null OR GQ.DiscrepancyEndDateId<=@DiscrepancyEndDateId)
	AND (@ComplianceStartDateId  Is Null OR GQ.ComplianceStartDateId>=@ComplianceStartDateId)
	AND (@CaseCreationStartDateId Is Null OR GQ.StartDate>=@CaseCreationStartDateId)
	AND (@CaseCreationEndDateId Is Null OR GQ.EndDate<=@CaseCreationEndDateId)
	AND (@CaseAgeFrom  Is Null OR GQ.Aging>=@CaseAgeFrom)
	AND (@CaseAgeTo Is Null OR GQ.Aging<=@CaseAgeTo)
	AND (@RequestedEffectiveStartDateId Is Null OR GQ.RPRRequestedEffectiveDateId>=@RequestedEffectiveStartDateId)
	AND (@RequestedEffectiveEndDateId Is Null OR GQ.RPRRequestedEffectiveDateId<=@RequestedEffectiveEndDateId)
	AND (@SupervisiorofthePersonEnteringtheRequest Is Null OR UM.ADM_UserMasterId=(SELECT ADM_UserMasterId FROM ADM_UserMaster WHERE ManagerId=@SupervisiorofthePersonEnteringtheRequest))
	AND (@PendReason Is Null OR GOST.PendReasonLkup=@PendReason)
	AND (@Resolution Is Null OR GOST.ResolutionLkup=@Resolution)	
	AND (@LastUpdatedOperator Is Null OR GOST.LastUpdatedByRef=@LastUpdatedOperator)
	AND (@FirstLetterMailStartDateId Is Null OR GOST.FirstLetterMailDateId>=@FirstLetterMailStartDateId )
	AND (@FirstLetterMailEndDateId Is Null OR GOST.FirstLetterMailDateId<=@FirstLetterMailEndDateId )
	AND (@SecondLetterMailStartDateId Is Null OR GOST.SecondLetterMailDateId>=@SecondLetterMailStartDateId )
	AND (@SecondLetterMailEndDateId Is Null OR  GOST.SecondLetterMailDateId<=@SecondLetterMailEndDateId)
	AND (@MemberResponseVerificationStartDateId Is Null OR GOST.MemberResponseVerificationDateId>=@MemberResponseVerificationStartDateId )
	AND (@MemberResponseVerificationEndDateId Is Null OR  GOST.MemberResponseVerificationDateId<=@MemberResponseVerificationEndDateId )
	
		
	
	--AND (@ComplianceEndDateId Is Null OR GQ.@ComplianceEndDateId )	
	--AND (@PeerAuditCompletionStartDateId Is Null OR GQ.@PeerAuditCompletionStartDateId )
	--AND (@PeerAuditCompletionEndDateId Is Null OR GQ.@PeerAuditCompletionEndDateId )

	
END
ELSE IF @PageType IS NOT NULL AND @PageType=3002--Eligibility
BEGIN
Select DISTINCT TOP 500 
	GEN_QueueId as WorkItemID,
	UMLocked.FullName as LockedBy,
	GQ.UTCLockedOn as UTCLockedOn,
	UM.FullName as CreatedBy,
	GQ.UTCCreatedOn as UTCCreatedOn,
	GQ.UTCLastUpdatedOn as UTCLastUpdatedOn,
	UMLastUpdate.FullName as LastUpdatedBy,
	UMAssigned.FullName as AssignedTo,
	DATEDIFF(DAY,GQ.DiscrepancyStartDate,GETUTCDATE()) AS Urgency,
	LMAction.LookupValue as Status,
	GQ.MemberCurrentHICN as CurrentHICN,
	GQ.EligGPSCurrentHICN as GPSHICN,
	GQ.EligMMRCurrentHICN as MMRHICN,
	UM.FirstName as FirstName,
	LMDiscrepancy.LookupValue as DiscrepancyCategory,
	LMDiscrepancy.CMN_LookupMasterId as DiscrepancyCategoryLkup, 
	GQ.StartDate as DiscrepancyStartDate,
	GQ.EndDate as DiscrepancyEndDate,
	GEligibility.Reason as Reason,
	LMResolution.LookupValue as Resolution,
	LMLOB.LookupValue as LineofBusiness,
	NULL as ReferencedEligibilityCaseIndicator,
	LMMMRPBP.LookupValue as MMRPBP,
	NULL as GPSIndividualID,
	LMDiscSource.LookupValue as DiscrepancySource,
	NULL as NTID,
	NULL as SubmissionType,
	UMCTMMember.FullName as CTMMember,
	UMEGHPMember.FullName as EGHPMember,
	GQ.RPRRequestedEffectiveDate as RequestedEffectiveDate,
	LMActionRequested.LookupValue as ActionRequested,
	NULL as PotentialSubmissionDate,
	NULL as RPCSubmissionDate,
	NULL as FDRReceivedDate,
	NULL as FDRCodeReceived,
	NULL as FDRStatus,
	NULL as RPRRequestor
	From GEN_Queue GQ with(nolock)
	JOIN ADM_UserMaster UM with(nolock) ON GQ.CreatedByRef=UM.ADM_UserMasterId
	LEFT JOIN ADM_UserMaster UMLocked with(nolock) ON GQ.LockedByRef=UMLocked.ADM_UserMasterId
	LEFT JOIN ADM_UserMaster UMLastUpdate with(nolock) ON GQ.LastUpdatedByRef=UMLastUpdate.ADM_UserMasterId
	JOIN ADM_UserMaster UMAssigned with(nolock) ON GQ.AssignedToRef=UMAssigned.ADM_UserMasterId
	JOIN GEN_EligibilityActions GEligibility with(nolock) ON GQ.GEN_QueueId=GEligibility.GEN_QueueRef
	LEFT JOIN CMN_LookupMaster LMAction with(nolock) ON GEligibility.ActionLkup=LMAction.CMN_LookupMasterId And LMAction.CMN_LookupTypeRef = 28
	LEFT JOIN CMN_LookupMaster LMDiscrepancy with(nolock) ON GQ.DiscrepancyCategoryLkup=LMDiscrepancy.CMN_LookupMasterId And LMDiscrepancy.CMN_LookupTypeRef = 6
	LEFT JOIN CMN_LookupMaster LMResolution with(nolock) ON GEligibility.ResolutionLkup=LMResolution.CMN_LookupMasterId And LMResolution.CMN_LookupTypeRef = 18
	LEFT JOIN CMN_LookupMaster LMLOB with(nolock) ON GQ.MemberLOBLkup=LMLOB.CMN_LookupMasterId And LMLOB.CMN_LookupTypeRef = 31
	LEFT JOIN CMN_LookupMaster LMMMRPBP with(nolock) ON GQ.EligMMRPBPLkup=LMMMRPBP.CMN_LookupMasterId
	LEFT JOIN CMN_LookupMaster LMDiscSource with(nolock) ON GQ.DiscrepancySourceLkup=LMDiscSource.CMN_LookupMasterId And LMDiscSource.CMN_LookupTypeRef = 13
	LEFT JOIN ADM_UserMaster UMCTMMember with(nolock) ON GQ.RPRCTMMember=UMCTMMember.ADM_UserMasterId
	LEFT JOIN ADM_UserMaster UMEGHPMember with(nolock) ON GQ.RPREGHPMember=UMEGHPMember.ADM_UserMasterId
	LEFT JOIN CMN_LookupMaster LMActionRequested with(nolock) ON GQ.RPRActionRequestedLkup=LMActionRequested.CMN_LookupMasterId And LMActionRequested.CMN_LookupTypeRef = 14
	Where
		(@WorkItemId Is Null OR GQ.GEN_QueueId=@WorkItemId)
	AND GQ.IsActive=1
	AND GQ.AssignedToRef is not null
	AND (@BusinessSegmentLkup IS NULL OR GQ.BusinessSegmentLkup=@BusinessSegmentLkup)
	AND (@DiscrepancyCategoryLkup Is Null OR GQ.DiscrepancyCategoryLkup=@DiscrepancyCategoryLkup)
	AND (@DiscrepancyTypeLkup Is Null OR GQ.DiscrepancyTypeLkup=@DiscrepancyTypeLkup)
	AND (@DiscrepancySourceLkup Is Null OR GQ.DiscrepancySourceLkup=@DiscrepancySourceLkup)
	AND (@LOBLkup Is Null OR GQ.MemberLOBLkup=@LOBLkup )
	AND (@AssignedTo Is Null OR GQ.AssignedToRef=@AssignedTo)
	AND (@ActionRequested Is Null OR GQ.RPRActionRequestedLkup=@ActionRequested)
	AND (@EGHPMember Is Null OR GQ.RPREGHPMember=@EGHPMember)
	AND (@EmployerId Is Null OR GQ.RPREmployerID=@EmployerId)
	AND (@Queue Is Null OR GQ.MostRecentWorkQueueLkup=@Queue)
	AND ((@CurrentHICN Is Null OR GQ.MemberCurrentHICN = @CurrentHICN)OR(@CurrentHICN Is Null OR GQ.EligGPSCurrentHICN = @CurrentHICN)OR(@CurrentHICN Is Null OR GQ.EligMMRCurrentHICN = @CurrentHICN))
	AND (@Status Is Null OR GQ.MostRecentStatusLkup=@Status)
	AND (@CTMMember Is Null OR GQ.RPRCTMMember=@CTMMember)
	AND (@CTMNumber Is Null OR GQ.RPRCTMNumber=@CTMNumber)
	AND (@MemberSCCCode Is Null OR GQ.MemberSCCCode=@MemberSCCCode)
	AND (@FirstName  Is Null OR GQ.MemberFirstName=@FirstName )
	AND (@LastName  Is Null OR GQ.MemberLastName=@LastName )
	AND (@DiscrepancyStartDateId Is Null OR GQ.DiscrepancyStartDateId>=@DiscrepancyStartDateId)
	AND (@DiscrepancyEndDateId Is Null OR GQ.DiscrepancyEndDateId<=@DiscrepancyEndDateId)
	AND (@ComplianceStartDateId  Is Null OR GQ.ComplianceStartDateId>=@ComplianceStartDateId)
	AND (@CaseCreationStartDateId Is Null OR GQ.StartDate>=@CaseCreationStartDateId)
	AND (@CaseCreationEndDateId Is Null OR GQ.EndDate<=@CaseCreationEndDateId)
	AND (@CaseAgeFrom  Is Null OR GQ.Aging>=@CaseAgeFrom)
	AND (@CaseAgeTo Is Null OR GQ.Aging<=@CaseAgeTo)
	AND (@RequestedEffectiveStartDateId Is Null OR GQ.RPRRequestedEffectiveDateId>=@RequestedEffectiveStartDateId)
	AND (@RequestedEffectiveEndDateId Is Null OR GQ.RPRRequestedEffectiveDateId<=@RequestedEffectiveEndDateId)
	AND (@TaskBeingPerformedWhenThisDiscrepancyWasIdentified  Is Null OR GQ.RPRTaskPerformedLkup=@TaskBeingPerformedWhenThisDiscrepancyWasIdentified)
	AND (@SupervisiorofthePersonEnteringtheRequest Is Null OR UM.ADM_UserMasterId=(SELECT ADM_UserMasterId FROM ADM_UserMaster WHERE ManagerId=@SupervisiorofthePersonEnteringtheRequest))
	AND (@PendReason Is Null OR GEligibility.PendReasonLkup=@PendReason)
	AND (@Resolution Is Null OR GEligibility.ResolutionLkup=@Resolution)
	AND (@VerifiedRootCause Is Null OR GEligibility.RootCauseLkup=@VerifiedRootCause)
	AND (@LastUpdatedOperator Is Null OR GEligibility.LastUpdatedByRef=@LastUpdatedOperator)
	AND (@FirstLetterMailStartDateId Is Null OR GEligibility.FirstLetterMailDateId>=@FirstLetterMailStartDateId )
	AND (@FirstLetterMailEndDateId Is Null OR GEligibility.FirstLetterMailDateId<=@FirstLetterMailEndDateId )
	AND (@SecondLetterMailStartDateId Is Null OR GEligibility.SecondLetterMailDateId>=@SecondLetterMailStartDateId )
	AND (@SecondLetterMailEndDateId Is Null OR  GEligibility.SecondLetterMailDateId<=@SecondLetterMailEndDateId)
	AND (@MemberResponseVerificationStartDateId Is Null OR GEligibility.MemberResponseVerificationDateId>=@MemberResponseVerificationStartDateId )
	AND (@MemberResponseVerificationEndDateId Is Null OR  GEligibility.MemberResponseVerificationDateId<=@MemberResponseVerificationEndDateId )
END
ELSE IF @PageType IS NOT NULL AND @PageType=3003--RPR[dbo].[GEN_RPRActions]
BEGIN
Select DISTINCT TOP 500 
	GEN_QueueId as WorkItemID,
	UMLocked.FullName as LockedBy,
	GQ.UTCLockedOn as UTCLockedOn,
	UM.FullName as CreatedBy,
	GQ.UTCCreatedOn as UTCCreatedOn,
	GQ.UTCLastUpdatedOn as UTCLastUpdatedOn,
	UMLastUpdate.FullName as LastUpdatedBy,
	UMAssigned.FullName as AssignedTo,
	DATEDIFF(DAY,GQ.DiscrepancyStartDate,GETUTCDATE()) AS Urgency,
	LMAction.LookupValue as Status,
	GQ.MemberCurrentHICN as CurrentHICN,
	GQ.EligGPSCurrentHICN as GPSHICN,
	GQ.EligMMRCurrentHICN as MMRHICN,
	UM.FirstName as FirstName,
	LMDiscrepancy.LookupValue as DiscrepancyCategory,
	LMDiscrepancy.CMN_LookupMasterId as DiscrepancyCategoryLkup, 
	GQ.StartDate as DiscrepancyStartDate,
	GQ.EndDate as DiscrepancyEndDate,
	NULL as Reason,
	LMResolution.LookupValue as Resolution,
	LMLOB.LookupValue as LineofBusiness,
	NULL as ReferencedEligibilityCaseIndicator,
	LMMMRPBP.LookupValue as MMRPBP,
	NULL as GPSIndividualID,
	LMDiscSource.LookupValue as DiscrepancySource,
	NULL as NTID,
	LMSubmissionType.LookupValue as SubmissionType,
	UMCTMMember.FullName as CTMMember,
	UMEGHPMember.FullName as EGHPMember,
	GQ.RPRRequestedEffectiveDate as RequestedEffectiveDate,
	LMActionRequested.LookupValue as ActionRequested,
	NULL as PotentialSubmissionDate,
	GRPR.RPCSubmissionDate as RPCSubmissionDate,
	GRPR.FDRReceivedDate as FDRReceivedDate,
	GRPR.FDRCodeReceived as FDRCodeReceived,
	GRPR.FDRCodeReceived as FDRCodeReceived,
	NULL as RPRRequestor
	From GEN_Queue GQ with(nolock)
	JOIN ADM_UserMaster UM with(nolock) ON GQ.CreatedByRef=UM.ADM_UserMasterId
	LEFT JOIN ADM_UserMaster UMLocked with(nolock) ON GQ.LockedByRef=UMLocked.ADM_UserMasterId
	LEFT JOIN ADM_UserMaster UMLastUpdate with(nolock) ON GQ.LastUpdatedByRef=UMLastUpdate.ADM_UserMasterId
	JOIN ADM_UserMaster UMAssigned with(nolock) ON GQ.AssignedToRef=UMAssigned.ADM_UserMasterId
	JOIN GEN_RPRActions GRPR with(nolock) ON GQ.GEN_QueueId=GRPR.GEN_QueueRef
	LEFT JOIN CMN_LookupMaster LMAction with(nolock) ON GRPR.ActionLkup=LMAction.CMN_LookupMasterId And LMAction.CMN_LookupTypeRef = 28
	LEFT JOIN CMN_LookupMaster LMDiscrepancy with(nolock) ON GQ.DiscrepancyCategoryLkup=LMDiscrepancy.CMN_LookupMasterId And LMDiscrepancy.CMN_LookupTypeRef = 6
	LEFT JOIN CMN_LookupMaster LMResolution with(nolock) ON GRPR.ResolutionLkup=LMResolution.CMN_LookupMasterId And LMResolution.CMN_LookupTypeRef = 18
	LEFT JOIN CMN_LookupMaster LMLOB with(nolock) ON GQ.MemberLOBLkup=LMLOB.CMN_LookupMasterId And LMLOB.CMN_LookupTypeRef = 31
	LEFT JOIN CMN_LookupMaster LMMMRPBP with(nolock) ON GQ.EligMMRPBPLkup=LMMMRPBP.CMN_LookupMasterId
	LEFT JOIN CMN_LookupMaster LMDiscSource with(nolock) ON GQ.DiscrepancySourceLkup=LMDiscSource.CMN_LookupMasterId And LMDiscSource.CMN_LookupTypeRef = 13
	LEFT JOIN ADM_UserMaster UMCTMMember with(nolock) ON GQ.RPRCTMMember=UMCTMMember.ADM_UserMasterId
	LEFT JOIN ADM_UserMaster UMEGHPMember with(nolock) ON GQ.RPREGHPMember=UMEGHPMember.ADM_UserMasterId
	LEFT JOIN CMN_LookupMaster LMActionRequested with(nolock) ON GQ.RPRActionRequestedLkup=LMActionRequested.CMN_LookupMasterId And LMActionRequested.CMN_LookupTypeRef = 14
	LEFT JOIN CMN_LookupMaster LMSubmissionType with(nolock) ON GRPR.SubmissionTypeLkup=LMSubmissionType.CMN_LookupMasterId And LMSubmissionType.CMN_LookupTypeRef = 17
	Where
		(@WorkItemId Is Null OR GQ.GEN_QueueId=@WorkItemId)
	AND GQ.IsActive=1
	AND GQ.AssignedToRef is not null
	AND (@BusinessSegmentLkup IS NULL OR GQ.BusinessSegmentLkup=@BusinessSegmentLkup)
	AND (@DiscrepancyCategoryLkup Is Null OR GQ.DiscrepancyCategoryLkup=@DiscrepancyCategoryLkup)
	AND (@DiscrepancyTypeLkup Is Null OR GQ.DiscrepancyTypeLkup=@DiscrepancyTypeLkup)
	AND (@DiscrepancySourceLkup Is Null OR GQ.DiscrepancySourceLkup=@DiscrepancySourceLkup)
	AND (@LOBLkup Is Null OR GQ.MemberLOBLkup=@LOBLkup )
	AND (@AssignedTo Is Null OR GQ.AssignedToRef=@AssignedTo)
	AND (@ActionRequested Is Null OR GQ.RPRActionRequestedLkup=@ActionRequested)
	AND (@EGHPMember Is Null OR GQ.RPREGHPMember=@EGHPMember)
	AND (@EmployerId Is Null OR GQ.RPREmployerID=@EmployerId)
	AND (@Queue Is Null OR GQ.MostRecentWorkQueueLkup=@Queue)
	AND ((@CurrentHICN Is Null OR GQ.MemberCurrentHICN = @CurrentHICN)OR(@CurrentHICN Is Null OR GQ.EligGPSCurrentHICN = @CurrentHICN)OR(@CurrentHICN Is Null OR GQ.EligMMRCurrentHICN = @CurrentHICN))
	AND (@Status Is Null OR GQ.MostRecentStatusLkup=@Status)
	AND (@CTMMember Is Null OR GQ.RPRCTMMember=@CTMMember)
	AND (@CTMNumber Is Null OR GQ.RPRCTMNumber=@CTMNumber)
	AND (@MemberSCCCode Is Null OR GQ.MemberSCCCode=@MemberSCCCode)
	AND (@FirstName  Is Null OR GQ.MemberFirstName=@FirstName )
	AND (@LastName  Is Null OR GQ.MemberLastName=@LastName )
	AND (@DiscrepancyStartDateId Is Null OR GQ.DiscrepancyStartDateId>=@DiscrepancyStartDateId)
	AND (@DiscrepancyEndDateId Is Null OR GQ.DiscrepancyEndDateId<=@DiscrepancyEndDateId)
	AND (@ComplianceStartDateId  Is Null OR GQ.ComplianceStartDateId>=@ComplianceStartDateId)
	AND (@CaseCreationStartDateId Is Null OR GQ.StartDate>=@CaseCreationStartDateId)
	AND (@CaseCreationEndDateId Is Null OR GQ.EndDate<=@CaseCreationEndDateId)
	AND (@CaseAgeFrom  Is Null OR GQ.Aging>=@CaseAgeFrom)
	AND (@CaseAgeTo Is Null OR GQ.Aging<=@CaseAgeTo)
	AND (@RequestedEffectiveStartDateId Is Null OR GQ.RPRRequestedEffectiveDateId>=@RequestedEffectiveStartDateId)
	AND (@RequestedEffectiveEndDateId Is Null OR GQ.RPRRequestedEffectiveDateId<=@RequestedEffectiveEndDateId)
	AND (@TaskBeingPerformedWhenThisDiscrepancyWasIdentified  Is Null OR GQ.RPRTaskPerformedLkup=@TaskBeingPerformedWhenThisDiscrepancyWasIdentified)
	AND (@SupervisiorofthePersonEnteringtheRequest Is Null OR UM.ADM_UserMasterId=(SELECT ADM_UserMasterId FROM ADM_UserMaster WHERE ManagerId=@SupervisiorofthePersonEnteringtheRequest))
	AND (@PendReason Is Null OR GRPR.PendReasonLkup=@PendReason)
	AND (@Resolution Is Null OR GRPR.ResolutionLkup=@Resolution)
	AND (@VerifiedRootCause Is Null OR GRPR.RootCauseLkup=@VerifiedRootCause)
	AND (@SubmissionTypeLkup Is Null OR GRPR.SubmissionTypeLkup=@SubmissionTypeLkup)
	AND (@FDRStatus  Is Null OR GRPR.FDRStatusLkup=@FDRStatus)
	AND (@LastUpdatedOperator Is Null OR GRPR.LastUpdatedByRef=@LastUpdatedOperator)
	AND (@RPRRequestor Is Null OR GRPR.CreatedByRef=@RPRRequestor)
    AND (@FDRCodeReceived Is Null OR GRPR.FDRCodeReceived=@FDRCodeReceived )
	AND (@RPCSubmissionStartDateId Is Null OR GRPR.RPCSubmissionDateId>=@RPCSubmissionStartDateId )
	AND (@RPCSubmissionEndDateId Is Null OR GRPR.RPCSubmissionDateId<=@RPCSubmissionEndDateId )
	AND (@CMSAccountManagerApprovalStartDateId  Is Null OR GRPR.CMSAccountManagerApprovalDateId>=@CMSAccountManagerApprovalStartDateId  )
	AND (@CMSAccountManagerApprovalEndDateId Is Null OR GRPR.CMSAccountManagerApprovalDateId<=@CMSAccountManagerApprovalEndDateId )
	AND (@FDRReceivedStartDateId Is Null OR GRPR.FDRReceivedDateId>=@FDRReceivedStartDateId )
	AND (@FDRReceivedStartDateId Is Null OR GRPR.FDRReceivedDateId<=@FDRReceivedStartDateId )
	AND (@AdjustedCreateStartDateId Is Null OR GRPR.AdjustedCreateDateId>=@AdjustedCreateStartDateId )
	AND (@AdjustedCreateEndDateId Is Null OR GRPR.AdjustedCreateDateId<=@AdjustedCreateEndDateId )
END

END TRY 

BEGIN CATCH

SET @ErrorMessage= ERROR_MESSAGE();

END CATCH 

END
GO

