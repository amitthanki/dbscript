IF OBJECT_ID ('USP_APP_SEL_Case') IS NOT NULL 
DROP PROC [DBO].[USP_APP_SEL_Case]
GO

/****** Object:  StoredProcedure [dbo].[USP_APP_SEL_Case]    Script Date: 05/07/2017 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: Rakesh
-- Create date: 06/29/2017
-- Modified By: 
-- Modification Date: 
-- Description: Get values from GEN_QUEUE, GEN_OSTActions, GEN_EligibilityActions, GEN_RPRActions, GEN_QUEUEWorkFlowCorrelation,
-- GEN_Comments table in db while creating a new suspect case.
-- Eg.
-- Declare @ErrorMessage VARCHAR(2000)
-- Set @ErrorMessage=''
-- Exec [USP_APP_SEL_Case] @ErrorMessage = @ErrorMessage Output
-- =============================================
CREATE PROCEDURE [dbo].[USP_APP_SEL_Case]
@GEN_QueueId BIGINT=NULL,
@ErrorMessage VARCHAR(2000) OUT

AS
BEGIN  
	BEGIN TRY  
		DECLARE @BusinessSegmentLkup BIGINT
		DECLARE @WorkBasketLkup BIGINT
		DECLARE @DiscrepancyCategory BIGINT
		DECLARE @MemberCurrentHICN VARCHAR(20)
		DECLARE @MemberContractIDLkup BIGINT
		DECLARE @MemberPBPLkup BIGINT
		
		SELECT @BusinessSegmentLkup=[BusinessSegmentLkup], @WorkBasketLkup=[WorkBasketLkup], @MemberCurrentHICN=[MemberMedicareId], @MemberContractIDLkup=[MemberContractIDLkup], @MemberPBPLkup=[MemberPBPLkup] FROM [dbo].[GEN_Queue] WHERE [GEN_QueueId] = @GEN_QueueId
   ----Select record from GEN_Queue Table0
   		SELECT GQ.[GEN_QueueId],GQ.[BusinessSegmentLkup],LMBusinessSegment.LookupValue as BusinessSegment,GQ.[WorkBasketLkup],LMWorkBasket.LookupValue AS WorkBasket,GQ.[DiscrepancyCategoryLkup],LMDiscrepancyCategory.LookupValue AS DiscrepancyCategory,GQ.[DiscrepancyTypeLkup],LMDiscrepancyType.LookupValue AS DiscrepancyType,GQ.[StartDate],GQ.[EndDate]
			  ,GQ.[PreviousWorkQueueLkup],GQ.[PreviousAuditWorkQueueLkup],GQ.[AssignedToRef],UMAssignedTo.[FullName] AS AssignedTo,GQ.[UTCAssignedOn],GQ.[CSTAssignedOn],GQ.[LockedByRef],UMLockedBy.[FullName] AS LockedBy,GQ.[UTCLockedOn],GQ.[CSTLockedOn],GQ.[MostRecentActionLkup], LMMostRecentAction.LookupValue AS MostRecentAction ,GQ.[MostRecentWorkQueueLkup],LMMostRecentWorkQueue.LookupValue AS MostRecentWorkQueue,GQ.[MostRecentStatusLkup],LMMostRecentStatus.LookupValue AS MostRecentStatus
			  ,GQ.[SourceSystemLkup],LMSourceSystem.LookupValue AS SourceSystem,GQ.[SourceSystemId],GQ.[DiscrepancySourceLkup],LMDiscrepancySource.LookupValue AS DiscrepancySource,GQ.[DiscrepancyReceiptDate],GQ.[ComplianceStartDate],[dbo].[GetAge](GQ.[GEN_QueueId]) as Aging,GQ.[DiscrepancyStartDate],GQ.[DiscrepancyEndDate],GQ.[MemberSCCCode]
			  ,GQ.[MemberID],GQ.[MemberMedicareId] AS [MemberCurrentHICN],GQ.[GPSHouseholdID],GQ.[MemberFirstName],GQ.[MemberMiddleName],GQ.[MemberLastName],GQ.[MemberContractIDLkup],LMMemberContractID.LookupValue AS MemberContractID,GQ.[MemberPBPLkup],LMMemberPBP.LookupValue AS MemberPBP,GQ.[MemberLOBLkup],LMMemberLOB.LookupValue AS MemberLOB,GQ.[MemberVerifiedState],GQ.[MemberVerifiedCountyCode],GQ.[MemberDOB],GQ.[MemberGenderLkup],LMMemberGender.LookupValue AS MemberGender,GQ.[EligGPSContractIDLkup],LMEligGPSContractID.LookupValue AS EligGPSContractID,GQ.[EligGPSPBPLkup],LMEligGPSPBP.LookupValue AS EligGPSPBP,GQ.[EligGPSSCCCode],GQ.[EligGPSCurrentHICN],GQ.[EligGPSInsuredPlanEffectiveDate],GQ.[EligGPSInsuredPlanTermDate],GQ.[EligGPSLOBLkup],LMEligGPSLOB.LookupValue AS EligGPSLOB
			  ,GQ.[EligGPSMemberDOB],GQ.[EligGPSGenderLkup],LMEligGPSGender.LookupValue AS EligGPSGender,GQ.[EligMMRContractIDLkup],LMEligMMRContractID.LookupValue AS EligMMRContractID,GQ.[EligMMRPBPLkup],LMEligMMRPBP.LookupVAlue AS EligMMRPBP,GQ.[EligMMRSCCCode],GQ.[DisenrollmentDate]
			  ,GQ.[EligMMRCurrentHICN],GQ.[EligMMRPaymentAdjustmentStartDate],GQ.[EligMMRPaymentAdjustmentEndDate],GQ.[EligMMRPaymentMonth],GQ.[EligMMRDOB],GQ.[EligMMRGenderLkup],LMEligMMRGender.LookupValue AS EligMMRGender,GQ.[EligOOAFlagLkup],GQ.[RPRRequestedEffectiveDate],GQ.[RPRActionRequestedLkup],LMRPRActionRequested.LookupValue AS RPRActionRequested,GQ.[RPRSupervisorOrRequesterRef],UMSupervisorOrRequester.[FullName] RPRSupervisorOrRequester,GQ.[RPREmployerID],GQ.[RPRReasonforRequest],GQ.[RPRTaskPerformedLkup],LMRPRTaskPerformed.LookupValue AS RPRTaskPerformed,GQ.[RPRCTMMember]
			  ,GQ.[RPRCTMNumber],GQ.[RPREGHPMember],GQ.[SCCRPRRequested],GQ.[SCCRPRRequestedZip],GQ.[SCCRPRRequstedSubmissionDate],GQ.[SCCRPREffectiveStartDate],GQ.[SCCRPREffectiveEndDate],GQ.[IsCasePended],GQ.[PendedbyRef],UMPendedby.FullName AS Pendedby,GQ.[UTCPendedOn],GQ.[CSTPendedOn],GQ.[IsCaseResolved],GQ.[ResolvedByRef],UMResolvedBy.FullName AS ResolvedBy,GQ.[UTCResolvedOn],GQ.[CSTResolvedOn],GQ.[PeerAuditCompletedDate],GQ.[IsParentCase],GQ.[IsChildCase]
			  ,GQ.[ParentQueueRef],GQ.[IsActive],GQ.[UTCCreatedOn],GQ.[CSTCreatedOn],GQ.[CreatedByRef],UMCreatedBy.FullName AS CreatedBy,GQ.[UTCLastUpdatedOn],GQ.[CSTLastUpdatedOn],GQ.[LastUpdatedByRef],UMLastUpdatedBy.FullName AS LastUpdatedBy,GQ.[RPROtherActionRequested],GQ.[RPROtherTaskPerformed], GQ.[PreviousAssignedToRef],UMPreviousAssignedTo.[FullName] PreviousAssignedTo,GQ.[PDPAutoEnrolleeInd],GQ.[ReferencedEligibilityCaseInd]
              ,GQ.[ReferencedSCCCaseInd],GQ.[FileTypeLkup],LMFileType.LookupValue FileType,GQ.[ODMDocID],GQ.[ODMAddressLink],GQ.[UndeliveredAddress1]
              ,GQ.[UndeliveredAddress2],GQ.[UndeliveredCity],GQ.[UndeliveredState],GQ.[UndeliveredZip],GQ.[COAOldAddress1],GQ.[COAOldAddress2]
              ,GQ.[COAOldCity],GQ.[COAOldState],GQ.[COAOldZip],GQ.[COANewAddress1],GQ.[COANewAddress2],GQ.[COANewCity],GQ.[COANewState],GQ.[COANewZip],GQ.[OOALetterStatusLkup], LMOOALetterStatus.LookupValue As OOALetterStatus,GQ.[CMSTransactionStatusLkup],LMCMSTransactionStatus.LookupValue As CMSTransactionStatus,GQ.[RPRCategoryLkup],LMRPRCategory.LookupValue As RPRCategory,GQ.[IsRestricted]
			  ,DATEDIFF(day, GQ.[UTCCreatedOn] , getutcdate()) AS TurnAroundTime,GQ.[TRCLkup],LMTRC.LookupValue TransactionReplyCode
		 FROM [dbo].[GEN_Queue] GQ With(Nolock)
			LEFT JOIN [dbo].[CMN_LookupMaster] LMBusinessSegment With(Nolock) ON GQ.[BusinessSegmentLkup]=LMBusinessSegment.[CMN_LookupMasterId] AND LMBusinessSegment.CMN_LookupTypeRef=1 AND LMBusinessSegment.IsActive=1
			LEFT JOIN [dbo].[CMN_LookupMaster] LMWorkBasket With(Nolock) ON GQ.[WorkBasketLkup]=LMWorkBasket.[CMN_LookupMasterId] AND LMWorkBasket.CMN_LookupTypeRef=3 AND LMWorkBasket.IsActive=1
			LEFT JOIN [dbo].[CMN_LookupMaster] LMDiscrepancyCategory With(Nolock) ON GQ.[DiscrepancyCategoryLkup]=LMDiscrepancyCategory.[CMN_LookupMasterId] AND LMDiscrepancyCategory.CMN_LookupTypeRef=6 AND LMDiscrepancyCategory.IsActive=1
			LEFT JOIN [dbo].[CMN_LookupMaster] LMDiscrepancyType With(Nolock) ON GQ.[DiscrepancyTypeLkup]=LMDiscrepancyType.[CMN_LookupMasterId] AND LMDiscrepancyType.CMN_LookupTypeRef=7 AND LMDiscrepancyType.IsActive=1
			LEFT JOIN [dbo].[CMN_LookupMaster] LMMostRecentAction With(Nolock) ON GQ.[MostRecentActionLkup]=LMMostRecentAction.[CMN_LookupMasterId] AND LMMostRecentAction.CMN_LookupTypeRef=28 AND LMMostRecentAction.IsActive=1
			LEFT JOIN [dbo].[CMN_LookupMaster] LMMostRecentWorkQueue With(Nolock) ON GQ.[MostRecentWorkQueueLkup]=LMMostRecentWorkQueue.[CMN_LookupMasterId] AND LMMostRecentWorkQueue.CMN_LookupTypeRef=10 AND LMMostRecentWorkQueue.IsActive=1
			LEFT JOIN [dbo].[CMN_LookupMaster] LMMostRecentStatus With(Nolock) ON GQ.[MostRecentStatusLkup]=LMMostRecentStatus.[CMN_LookupMasterId] AND LMMostRecentStatus.CMN_LookupTypeRef=20 AND LMMostRecentStatus.IsActive=1
			LEFT JOIN [dbo].[CMN_LookupMaster] LMSourceSystem With(Nolock) ON GQ.[SourceSystemLkup]=LMSourceSystem.[CMN_LookupMasterId] AND LMSourceSystem.CMN_LookupTypeRef=38 AND LMSourceSystem.IsActive=1
			LEFT JOIN [dbo].[CMN_LookupMaster] LMDiscrepancySource With(Nolock) ON GQ.[DiscrepancySourceLkup]=LMDiscrepancySource.[CMN_LookupMasterId] AND LMDiscrepancySource.CMN_LookupTypeRef=13 AND LMDiscrepancySource.IsActive=1
			LEFT JOIN [dbo].[CMN_LookupMaster] LMMemberContractID With(Nolock) ON GQ.[MemberContractIDLkup]=LMMemberContractID.[CMN_LookupMasterId] AND LMMemberContractID.CMN_LookupTypeRef=11 AND LMMemberContractID.IsActive=1
			LEFT JOIN [dbo].[CMN_LookupMaster] LMMemberPBP With(Nolock) ON GQ.[MemberPBPLkup]=LMMemberPBP.[CMN_LookupMasterId] AND LMMemberPBP.CMN_LookupTypeRef=12 AND LMMemberPBP.IsActive=1
			LEFT JOIN [dbo].[CMN_LookupMaster] LMMemberLOB With(Nolock) ON GQ.[MemberLOBLkup]=LMMemberLOB.[CMN_LookupMasterId] AND LMMemberLOB.CMN_LookupTypeRef=31 AND LMMemberLOB.IsActive=1
			LEFT JOIN [dbo].[CMN_LookupMaster] LMMemberGender With(Nolock) ON GQ.[MemberGenderLkup]=LMMemberGender.[CMN_LookupMasterId] AND LMMemberGender.CMN_LookupTypeRef=21 AND LMMemberGender.IsActive=1
			LEFT JOIN [dbo].[CMN_LookupMaster] LMEligGPSContractID With(Nolock) ON GQ.[EligGPSContractIDLkup]=LMEligGPSContractID.[CMN_LookupMasterId] AND LMEligGPSContractID.CMN_LookupTypeRef=11 AND LMEligGPSContractID.IsActive=1
			LEFT JOIN [dbo].[CMN_LookupMaster] LMEligGPSPBP With(Nolock) ON GQ.[EligGPSPBPLkup]=LMEligGPSPBP.[CMN_LookupMasterId] AND LMEligGPSPBP.CMN_LookupTypeRef=12 AND LMEligGPSPBP.IsActive=1
			LEFT JOIN [dbo].[CMN_LookupMaster] LMEligGPSLOB With(Nolock) ON GQ.[EligGPSLOBLkup]=LMEligGPSLOB.[CMN_LookupMasterId] AND LMEligGPSLOB.CMN_LookupTypeRef=31 AND LMEligGPSLOB.IsActive=1
			LEFT JOIN [dbo].[CMN_LookupMaster] LMEligGPSGender With(Nolock) ON GQ.[EligGPSGenderLkup]=LMEligGPSGender.[CMN_LookupMasterId] AND LMEligGPSGender.CMN_LookupTypeRef=21 AND LMEligGPSGender.IsActive=1
			LEFT JOIN [dbo].[CMN_LookupMaster] LMEligMMRContractID With(Nolock) ON GQ.[EligMMRContractIDLkup]=LMEligMMRContractID.[CMN_LookupMasterId] AND LMEligMMRContractID.CMN_LookupTypeRef=11 AND LMEligMMRContractID.IsActive=1
			LEFT JOIN [dbo].[CMN_LookupMaster] LMEligMMRPBP With(Nolock) ON GQ.[EligMMRPBPLkup]=LMEligMMRPBP.[CMN_LookupMasterId] AND LMEligMMRPBP.CMN_LookupTypeRef=12 AND LMEligMMRPBP.IsActive=1
			LEFT JOIN [dbo].[CMN_LookupMaster] LMEligMMRGender With(Nolock) ON GQ.[EligMMRGenderLkup]=LMEligMMRGender.[CMN_LookupMasterId] AND LMEligMMRGender.CMN_LookupTypeRef=21 AND LMEligMMRGender.IsActive=1
			LEFT JOIN [dbo].[CMN_LookupMaster] LMRPRActionRequested With(Nolock) ON GQ.[RPRActionRequestedLkup]=LMRPRActionRequested.[CMN_LookupMasterId] AND LMRPRActionRequested.CMN_LookupTypeRef=14 AND LMRPRActionRequested.IsActive=1
			LEFT JOIN [dbo].[CMN_LookupMaster] LMRPRTaskPerformed With(Nolock) ON GQ.[RPRTaskPerformedLkup]=LMRPRTaskPerformed.[CMN_LookupMasterId] AND LMRPRTaskPerformed.CMN_LookupTypeRef=15 AND LMRPRTaskPerformed.IsActive=1
			LEFT JOIN [dbo].[CMN_LookupMaster] LMOOALetterStatus With(Nolock) ON GQ.[OOALetterStatusLkup]=LMOOALetterStatus.[CMN_LookupMasterId] AND LMOOALetterStatus.CMN_LookupTypeRef=53 AND LMOOALetterStatus.IsActive=1
			LEFT JOIN [dbo].[CMN_LookupMaster] LMCMSTransactionStatus With(Nolock) ON GQ.[CMSTransactionStatusLkup]=LMCMSTransactionStatus.[CMN_LookupMasterId] AND LMCMSTransactionStatus.CMN_LookupTypeRef=55 AND LMCMSTransactionStatus.IsActive=1
			LEFT JOIN [dbo].[CMN_LookupMaster] LMRPRCategory With(Nolock) ON GQ.[RPRCategoryLkup]=LMRPRCategory.[CMN_LookupMasterId] AND LMRPRCategory.CMN_LookupTypeRef=49 AND LMRPRCategory.IsActive=1
			LEFT JOIN [dbo].[ADM_UserMaster] UMAssignedTo  With(Nolock) ON GQ.[AssignedToRef]=UMAssignedTo.[ADM_UserMasterId] AND UMAssignedTo.IsActive=1
			LEFT JOIN [dbo].[CMN_LookupMaster] LMFileType  With(Nolock) ON GQ.[FileTypeLkup]=LMFileType.[CMN_LookupMasterId] AND LMFileType.IsActive=1
			LEFT JOIN [dbo].[ADM_UserMaster] UMLockedBy  With(Nolock) ON GQ.LockedByRef=UMLockedBy.[ADM_UserMasterId] AND UMLockedBy.IsActive=1
			LEFT JOIN [dbo].[ADM_UserMaster] UMPendedby  With(Nolock) ON GQ.PendedbyRef=UMPendedby.[ADM_UserMasterId] AND UMPendedby.IsActive=1
			LEFT JOIN [dbo].[ADM_UserMaster] UMCreatedBy  With(Nolock) ON GQ.CreatedByRef=UMCreatedBy.[ADM_UserMasterId] AND UMCreatedBy.IsActive=1
			LEFT JOIN [dbo].[ADM_UserMaster] UMLastUpdatedBy  With(Nolock) ON GQ.LastUpdatedByRef=UMLastUpdatedBy.[ADM_UserMasterId] AND UMLastUpdatedBy.IsActive=1
			LEFT JOIN [dbo].[ADM_UserMaster] UMResolvedBy  With(Nolock) ON GQ.ResolvedByRef=UMResolvedBy.[ADM_UserMasterId] AND UMResolvedBy.IsActive=1
			LEFT JOIN [dbo].[ADM_UserMaster] UMPreviousAssignedTo  With(Nolock) ON GQ.[PreviousAssignedToRef]=UMPreviousAssignedTo.[ADM_UserMasterId] AND UMPreviousAssignedTo.IsActive=1
			LEFT JOIN [dbo].[ADM_UserMaster] UMSupervisorOrRequester With(Nolock) ON GQ.[RPRSupervisorOrRequesterRef]=UMSupervisorOrRequester.[ADM_UserMasterId] AND UMSupervisorOrRequester.IsActive=1
			LEFT JOIN [dbo].[CMN_LookupMaster] LMTRC  With(Nolock) ON GQ.[TRCLkup]= LMTRC.[CMN_LookupMasterId] AND LMTRC.IsActive=1
	    WHERE GQ.[GEN_QueueId] =@GEN_QueueId


	--Select record from GEN_OSTActions Table1 
	IF(@WorkBasketLkup = 3001) --- 3001 = OST
	BEGIN
		   SELECT GQACT.[GEN_QueueRef],GQACT.[ActionLkup],LMAction.LookupValue AS [Action],GQACT.[LastName],GQACT.[DateofBirth],GQACT.[ContractIDLkup],LMContractID.LookupValue AS ContractID,GQACT.[PBPLkup],LMPBP.LookupValue AS PBP,GQACT.[ApplicationDate],GQACT.[EffectiveDate],
		  		  GQACT.[EndDate],GQACT.[FirstLetterMailDate],GQACT.[SecondLetterMailDate],GQACT.[ResidentialDocumentationRequired],GQACT.[CountyAttestationRequired],
				  GQACT.[PendReasonLkup],LMPendReason.LookupValue AS PendReason,GQACT.[ContainsErrorsLkup],GQACT.[ResolutionLkup],LMResolution.LookupValue AS Resolution,GQACT.[Reason],GQACT.[InitialAddressVerificationDate],
				  GQACT.[MemberResponseVerificationDate],GQACT.[MemberVerifiedState],GQACT.[SCCLetterMailDate],GQACT.[AdjustedDiscrepancyReceiptDate],GQACT.[AdjustedComplianceStartDate],
				  GQACT.[MARxAddressResolutionLkup],GQACT.[PDPAutoEnrolleeInd],GQACT.[IsActive],GQACT.[UTCCreatedOn],GQACT.[CreatedByRef],UMCreatedBy.FullName AS CreatedBy,
				  GQACT.[UTCLastUpdatedOn],GQACT.[LastUpdatedByRef],UMLastUpdatedBy.FullName AS LastUpdatedBy,GQACT.PDPAutoEnrolleeInd,GQACT.[AdjustedDisenrollmentDate],GQACT.MARxAddressResolutionLkup,LMMarxAdd.LookupValue AS MARxAddressResolution
			 FROM [dbo].[GEN_OSTActions] GQACT With(Nolock)
		LEFT JOIN [dbo].[CMN_LookupMaster] LMAction With(Nolock) ON GQACT.[ActionLkup] = LMAction.[CMN_LookupMasterId] AND LMAction.CMN_LookupTypeRef=28 AND LMAction.IsActive=1 
		LEFT JOIN [dbo].[CMN_LookupMaster] LMContractID With(Nolock) ON GQACT.[ContractIDLkup] = LMContractID.[CMN_LookupMasterId] AND LMContractID.CMN_LookupTypeRef=11 AND LMContractID.IsActive=1 
		LEFT JOIN [dbo].[CMN_LookupMaster] LMPBP With(Nolock) ON GQACT.[PBPLkup] = LMPBP.[CMN_LookupMasterId] AND LMPBP.CMN_LookupTypeRef=12 AND LMPBP.IsActive=1
		LEFT JOIN [dbo].[CMN_LookupMaster] LMPendReason With(Nolock) ON GQACT.[PendReasonLkup] = LMPendReason.[CMN_LookupMasterId] AND LMPendReason.CMN_LookupTypeRef=30 AND LMPendReason.IsActive=1
		LEFT JOIN [dbo].[CMN_LookupMaster] LMResolution With(Nolock) ON GQACT.[ResolutionLkup] = LMResolution.[CMN_LookupMasterId] AND LMResolution.CMN_LookupTypeRef=18 AND LMResolution.IsActive=1
		LEFT JOIN [dbo].[CMN_LookupMaster] LMMarxAdd With(Nolock) ON GQACT.[MARxAddressResolutionLkup] = LMMarxAdd.[CMN_LookupMasterId] AND LMMarxAdd.CMN_LookupTypeRef=58 AND LMMarxAdd.IsActive=1
		LEFT JOIN [dbo].[ADM_UserMaster] UMCreatedBy  With(Nolock) ON GQACT.CreatedByRef=UMCreatedBy.[ADM_UserMasterId] AND UMCreatedBy.IsActive=1
		LEFT JOIN [dbo].[ADM_UserMaster] UMLastUpdatedBy  With(Nolock) ON GQACT.LastUpdatedByRef=UMLastUpdatedBy.[ADM_UserMasterId] AND UMLastUpdatedBy.IsActive=1
			WHERE GQACT.[GEN_QueueRef] =@GEN_QueueId
	END
	--Select record from GEN_EligibilityActions Table1 
	IF(@WorkBasketLkup = 3002) --- 3002 = Eligibility
	BEGIN
		   SELECT GENElig.[GEN_QueueRef],GENElig.[ActionLkup],LMAction.LookupValue AS [Action],GENElig.[HICN],
				GENElig.[LastName],GENElig.[DateofBirth],GENElig.[ContractIDLkup],LMContractID.LookupValue AS ContractID,GENElig.[PBPLkup],LMPBP.LookupValue AS PBP,GENElig.[ApplicationDate],GENElig.[EffectiveDate],
				GENElig.[ResolutionLkup],LMResolution.LookupValue AS Resolution,GENElig.[OtherResolution],GENElig.[RootCauseLkup],LMRootCause.LookupValue AS RootCause,GENElig.[PendReasonLkup],LMPendReason.LookupValue AS PendReason,
				GENElig.[EGHPIndicator],GENElig.[TransactionTypeCodeLkup],LMTTC.LookupValue AS TransactionTypeCode,GENElig.[ElectionTypeLkup],LMET.LookupValue AS ElectionType,GENElig.[Reason],
				GENElig.[ContainsErrorsLkup],GENElig.[OtherRootCause],GENElig.[IsActive],GENElig.[UTCCreatedOn],GENElig.[CreatedByRef],UMCreatedBy.FullName AS CreatedBy,
				GENElig.[UTCLastUpdatedOn],GENElig.[LastUpdatedByRef],UMLastUpdatedBy.FullName AS LastUpdatedBy
		   FROM [dbo].[GEN_EligibilityActions] GENElig With(Nolock)
	  LEFT JOIN dbo.[CMN_LookupMaster] LMAction With(Nolock) ON GENElig.[ActionLkup] = LMAction.[CMN_LookupMasterId] AND LMAction.CMN_LookupTypeRef=28 AND LMAction.IsActive=1 
	  LEFT JOIN dbo.[CMN_LookupMaster] LMContractID With(Nolock) ON GENElig.[ContractIDLkup] = LMContractID.[CMN_LookupMasterId] AND LMContractID.CMN_LookupTypeRef=11 AND LMAction.IsActive=1 
	  LEFT JOIN dbo.[CMN_LookupMaster] LMPBP With(Nolock) ON GENElig.[PBPLkup] = LMPBP.[CMN_LookupMasterId] AND LMPBP.CMN_LookupTypeRef=12 AND LMPBP.IsActive=1
	  LEFT JOIN dbo.[CMN_LookupMaster] LMResolution With(Nolock) ON GENElig.ResolutionLkup=LMResolution.[CMN_LookupMasterId] AND LMResolution.CMN_LookupTypeRef=18 AND LMResolution.IsActive=1 
	  LEFT JOIN dbo.[CMN_LookupMaster] LMRootCause With(Nolock) ON GENElig.RootCauseLkup=LMRootCause.[CMN_LookupMasterId] AND LMRootCause.CMN_LookupTypeRef=24 AND LMRootCause.IsActive=1 
	  LEFT JOIN dbo.[CMN_LookupMaster] LMPendReason	With(Nolock) ON GENElig.PendReasonLkup=LMPendReason.[CMN_LookupMasterId] AND LMPendReason.CMN_LookupTypeRef=30 AND LMPendReason.IsActive=1 
	  LEFT JOIN dbo.[CMN_LookupMaster] LMMemberVerifiedState With(Nolock) ON GENElig.[MemberVerifiedStateLkup] = LMMemberVerifiedState.[CMN_LookupMasterId] AND LMMemberVerifiedState.CMN_LookupTypeRef=5 AND LMMemberVerifiedState.IsActive=1
	  LEFT JOIN dbo.[CMN_LookupMaster] LMTTC With(Nolock) ON GENElig.TransactionTypeCodeLkup=LMTTC.[CMN_LookupMasterId] AND LMTTC.CMN_LookupTypeRef=29 AND LMTTC.IsActive=1
	  LEFT JOIN dbo.[CMN_LookupMaster] LMET With(Nolock) ON GENElig.ElectionTypeLkup=LMET.[CMN_LookupMasterId] AND LMET.CMN_LookupTypeRef=23 AND LMET.IsActive=1
	  LEFT JOIN dbo.[ADM_UserMaster] UMCreatedBy  With(Nolock) ON GENElig.CreatedByRef=UMCreatedBy.[ADM_UserMasterId] AND UMCreatedBy.IsActive=1
	  LEFT JOIN dbo.[ADM_UserMaster] UMLastUpdatedBy  With(Nolock) ON GENElig.LastUpdatedByRef=UMLastUpdatedBy.[ADM_UserMasterId] AND UMLastUpdatedBy.IsActive=1
		  WHERE GENElig.[GEN_QueueRef] = @GEN_QueueId
	END
	--Select record from GEN_RPRActions Table1 
	IF(@WorkBasketLkup = 3003) --- 3003 = RPR
	BEGIN
		  SELECT GENRPR.[GEN_QueueRef],GENRPR.[ActionLkup],LMAction.LookupValue AS [Action],GENRPR.[ResolutionLkup],LMResolution.LookupValue AS Resolution,GENRPR.[RootCauseLkup],LMRootCause.LookupValue AS RootCause,GENRPR.[PendReasonLkup],LMPendReason.LookupValue AS PendReason
				,GENRPR.[AdjustedCreateDate],GENRPR.[AdjustedCreateDateReasonLkup],LMAdjustedCreateDateReason.LookupValue AS AdjustedCreateDateReason,GENRPR.[OtherAdjustedCreateDateReason],GENRPR.[SubmissionTypeLkup],LMSubmissionType.LookupValue AS SubmissionType,GENRPR.[ContainsErrorsLkup]
				,GENRPR.[RPCSubmissionDate],GENRPR.[CMSAccountManagerSubmissionDate],GENRPR.[CMSAccountManagerApprovalDate],GENRPR.[FDRStatusLkup],LMFDRStatus.LookupValue AS FDRStatus,GENRPR.[OtherFDRStatus],GENRPR.[FDRReceivedDate],GENRPR.[FDRCodeReceived],GENRPR.[FDRDescription]
				,GENRPR.[CMSProcessDate],GENRPR.[TransactionType],GENRPR.[FDRRejectionTypeLkup],LMFDRRejectionType.LookupValue AS FDRRejectionType,GENRPR.[ElectionTypeLkup],LMET.LookupValue AS ElectionType,GENRPR.[LastName],GENRPR.[DateofBirth],GENRPR.[ContractIDLkup],LMContractID.LookupValue AS ContractID,GENRPR.[PBPLkup],LMPBP.LookupValue AS PBP,GENRPR.[ApplicationDate]
				,GENRPR.[EffectiveDate],GENRPR.[EndDate],GENRPR.[ActualSubmissionDate],GENRPR.[ReasonSubmissionRejected],GENRPR.[RequestedSCC],GENRPR.[RequestedZIP],GENRPR.[ResubmissionDate],GENRPR.[PotentialSubmissionDate],GENRPR.[IsActive],GENRPR.[FDRPackageDate],GENRPR.[FDRSubmissionCategoryLkup],LMFSC.LookupValue AS FDRSubmissionCategory
				,GENRPR.[TransactionTypeCodeLkup],LMTTC.LookupValue AS TransactionTypeCode,GENRPR.[ExplanationOfRootCauseLkup],LMERC.LookupValue AS ExplanationOfRootCause,GENRPR.[VerifiedRootCauseLkup],LMVRC.LookupValue AS VerifiedRootCause,GENRPR.[PlanError]
				,GENRPR.[UTCCreatedOn],GENRPR.[CreatedByRef],UMCreatedBy.FullName AS CreatedBy,GENRPR.[UTCLastUpdatedOn],GENRPR.[LastUpdatedByRef],UMLastUpdatedBy.FullName AS LastUpdatedBy
		   FROM [dbo].[GEN_RPRActions] GENRPR With(Nolock)
	  LEFT JOIN dbo.[CMN_LookupMaster] LMAction With(Nolock) ON GENRPR.[ActionLkup] = LMAction.[CMN_LookupMasterId] AND LMAction.CMN_LookupTypeRef=28 AND LMAction.IsActive=1 
	  LEFT JOIN dbo.[CMN_LookupMaster] LMResolution With(Nolock) ON GENRPR.ResolutionLkup=LMResolution.[CMN_LookupMasterId] AND LMResolution.CMN_LookupTypeRef=18 AND LMResolution.IsActive=1 
	  LEFT JOIN dbo.[CMN_LookupMaster] LMRootCause With(Nolock) ON GENRPR.RootCauseLkup=LMRootCause.[CMN_LookupMasterId] AND LMRootCause.CMN_LookupTypeRef=24 AND LMRootCause.IsActive=1 
	  LEFT JOIN dbo.[CMN_LookupMaster] LMPendReason	With(Nolock) ON GENRPR.PendReasonLkup=LMPendReason.[CMN_LookupMasterId] AND LMPendReason.CMN_LookupTypeRef=30 AND LMPendReason.IsActive=1 
	  LEFT JOIN dbo.[CMN_LookupMaster] LMAdjustedCreateDateReason  With(Nolock) ON GENRPR.AdjustedCreateDateReasonLkup=LMAdjustedCreateDateReason.[CMN_LookupMasterId] AND LMAdjustedCreateDateReason.CMN_LookupTypeRef=32 AND LMAdjustedCreateDateReason.IsActive=1 
	  LEFT JOIN dbo.[CMN_LookupMaster] LMSubmissionType With(Nolock) ON GENRPR.SubmissionTypeLkup=LMSubmissionType.[CMN_LookupMasterId] AND LMSubmissionType.CMN_LookupTypeRef=17 AND LMSubmissionType.IsActive=1
	  LEFT JOIN dbo.[CMN_LookupMaster] LMFDRStatus With(Nolock) ON GENRPR.FDRStatusLkup=LMFDRStatus.[CMN_LookupMasterId] AND LMFDRStatus.CMN_LookupTypeRef=26 AND LMFDRStatus.IsActive=1 
	  LEFT JOIN dbo.[CMN_LookupMaster] LMFDRRejectionType With(Nolock) ON GENRPR.FDRRejectionTypeLkup=LMFDRRejectionType.[CMN_LookupMasterId] AND LMFDRRejectionType.CMN_LookupTypeRef=27 AND LMFDRRejectionType.IsActive=1 
	  LEFT JOIN dbo.[CMN_LookupMaster] LMContractID With(Nolock) ON GENRPR.ContractIDLkup=LMContractID.[CMN_LookupMasterId] AND LMContractID.CMN_LookupTypeRef=11 AND LMContractID.IsActive=1 	
	  LEFT JOIN dbo.[CMN_LookupMaster] LMPBP With(Nolock) ON GENRPR.PBPLkup=LMPBP.[CMN_LookupMasterId] AND LMPBP.CMN_LookupTypeRef=12 AND LMPBP.IsActive=1 
	  LEFT JOIN dbo.[CMN_LookupMaster] LMET With(Nolock) ON GENRPR.ElectionTypeLkup=LMET.[CMN_LookupMasterId] AND LMET.CMN_LookupTypeRef=23 AND LMET.IsActive=1
	  LEFT JOIN dbo.[CMN_LookupMaster] LMFSC With(Nolock) ON GENRPR.FDRSubmissionCategoryLkup=LMFSC.[CMN_LookupMasterId] AND LMFSC.CMN_LookupTypeRef=50 AND LMFSC.IsActive=1
	  LEFT JOIN dbo.[CMN_LookupMaster] LMTTC With(Nolock) ON GENRPR.TransactionTypeCodeLkup=LMTTC.[CMN_LookupMasterId] AND LMTTC.CMN_LookupTypeRef=29 AND LMTTC.IsActive=1
	  LEFT JOIN dbo.[CMN_LookupMaster] LMERC With(Nolock) ON GENRPR.ExplanationOfRootCauseLkup=LMERC.[CMN_LookupMasterId] AND LMERC.CMN_LookupTypeRef=25 AND LMERC.IsActive=1
	  LEFT JOIN dbo.[CMN_LookupMaster] LMVRC With(Nolock) ON GENRPR.VerifiedRootCauseLkup=LMVRC.[CMN_LookupMasterId] AND LMVRC.CMN_LookupTypeRef=57 AND LMVRC.IsActive=1
      LEFT JOIN [dbo].[ADM_UserMaster] UMCreatedBy  With(Nolock) ON GENRPR.CreatedByRef=UMCreatedBy.[ADM_UserMasterId] AND UMCreatedBy.IsActive=1
	  LEFT JOIN [dbo].[ADM_UserMaster] UMLastUpdatedBy  With(Nolock) ON GENRPR.LastUpdatedByRef=UMLastUpdatedBy.[ADM_UserMasterId] AND UMLastUpdatedBy.IsActive=1
		  WHERE GENRPR.[GEN_QueueRef] = @GEN_QueueId
	END
    --Select referenced records from GEN_Queue Table2
	;WITH childcte AS (
		  SELECT Gen_QueueId,ParentQueueRef
			FROM GEN_Queue
		   WHERE GEN_QueueID = @Gen_QueueId and IsActive=1
		  UNION all
		  SELECT d.Gen_QueueId, d.ParentQueueRef
			FROM GEN_Queue d
		JOIN childcte on d.Gen_QueueId = childcte.ParentQueueRef
	), parentcte AS (
		 SELECT Gen_QueueId,ParentQueueRef
		   FROM GEN_Queue
		  WHERE GEN_QueueID = @Gen_QueueId and IsActive=1
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

		SELECT GQ.[GEN_QueueId],GQ.[BusinessSegmentLkup],LMBusinessSegment.LookupValue as BusinessSegment,GQ.[WorkBasketLkup],LMWorkBasket.LookupValue AS WorkBasket,GQ.[DiscrepancyTypeLkup],LMDiscrepancyType.LookupValue AS DiscrepancyType,GQ.[DiscrepancyStartDate],GQ.[DiscrepancySourceLkup],LMDiscrepancySource.LookupValue AS DiscrepancySource
			,GQ.[DiscrepancyCategoryLkup],LMDiscrepancyCategory.LookupValue AS DiscrepancyCategory,GQ.GPSHouseholdID,GQ.[MemberMedicareId] as MemberCurrentHICN,GQ.[MemberContractIDLkup],LMContract.LookupValue AS MemberContract,GQ.[MemberPBPLkup],LMPBP.LookupValue AS MemberPBP,GQ.[IsParentCase],GQ.[IsChildCase],GQ.[ParentQueueRef],GQ.[MostRecentWorkQueueLkup],LMMostRecentWorkQueue.LookupValue as MostRecentWorkQueue,GQ.[MostRecentStatusLkup],LMMostRecentStatus.LookupValue as MostRecentStatus
			,GQACT.[FirstLetterMailDate],GQACT.[SecondLetterMailDate],GQ.CreatedByRef,UMCreatedBy.FullName AS CreatedBy, GQ.UTCCreatedOn, GQ.LastUpdatedByRef,UMLastUpdatedBy.FullName AS LastUpdatedBy, GQ.UTCLastUpdatedOn
		FROM [dbo].[GEN_Queue] GQ With(Nolock)
	  INNER JOIN #RefferenceCasesID RC ON RC.[GEN_QueueId] = GQ.[GEN_QueueId] AND GQ.IsActive=1
	  LEFT JOIN [dbo].[GEN_OSTActions] GQACT With(Nolock) ON GQACT.[GEN_QueueRef] = GQ.[GEN_QueueId]
	  LEFT JOIN [dbo].[CMN_LookupMaster] LMBusinessSegment  With(Nolock) ON GQ.[BusinessSegmentLkup]=LMBusinessSegment.[CMN_LookupMasterId] AND LMBusinessSegment.CMN_LookupTypeRef=1 AND LMBusinessSegment.IsActive=1
      LEFT JOIN [dbo].[CMN_LookupMaster] LMWorkBasket  With(Nolock) ON GQ.[WorkBasketLkup]=LMWorkBasket.[CMN_LookupMasterId] AND LMWorkBasket.CMN_LookupTypeRef=3 AND LMWorkBasket.IsActive=1
	  LEFT JOIN [dbo].[CMN_LookupMaster] LMDiscrepancyCategory With(Nolock) ON GQ.[DiscrepancyCategoryLkup]=LMDiscrepancyCategory.[CMN_LookupMasterId] AND LMDiscrepancyCategory.CMN_LookupTypeRef=6 AND LMDiscrepancyCategory.IsActive=1
	  LEFT JOIN [dbo].[CMN_LookupMaster] LMDiscrepancyType With(Nolock) ON GQ.[DiscrepancyTypeLkup]=LMDiscrepancyType.[CMN_LookupMasterId] AND LMDiscrepancyType.CMN_LookupTypeRef=7 AND LMDiscrepancyType.IsActive=1
	  LEFT JOIN [dbo].[CMN_LookupMaster] LMDiscrepancySource With(Nolock) ON GQ.[DiscrepancySourceLkup]=LMDiscrepancySource.[CMN_LookupMasterId] AND LMDiscrepancySource.CMN_LookupTypeRef=13 AND LMDiscrepancySource.IsActive=1
	  LEFT JOIN [dbo].[CMN_LookupMaster] LMMostRecentWorkQueue With(Nolock) ON GQ.[MostRecentWorkQueueLkup]=LMMostRecentWorkQueue.[CMN_LookupMasterId] AND LMMostRecentWorkQueue.CMN_LookupTypeRef=10 AND LMMostRecentWorkQueue.IsActive=1
	  LEFT JOIN [dbo].[CMN_LookupMaster] LMMostRecentStatus With(Nolock) ON GQ.[MostRecentStatusLkup]=LMMostRecentStatus.[CMN_LookupMasterId] AND LMMostRecentStatus.CMN_LookupTypeRef=20 AND LMMostRecentStatus.IsActive=1
	  LEFT JOIN [dbo].[CMN_LookupMaster] LMContract With(Nolock) ON GQ.[MemberContractIDLkup]=LMContract.[CMN_LookupMasterId] AND LMContract.CMN_LookupTypeRef=11 AND LMContract.IsActive=1
	  LEFT JOIN [dbo].[CMN_LookupMaster] LMPBP With(Nolock) ON GQ.[MemberPBPLkup]=LMPBP.[CMN_LookupMasterId] AND LMPBP.CMN_LookupTypeRef=12 AND LMPBP.IsActive=1
	  LEFT JOIN [dbo].[ADM_UserMaster] UMCreatedBy  With(Nolock) ON GQ.CreatedByRef=UMCreatedBy.[ADM_UserMasterId] AND UMCreatedBy.IsActive=1
	  LEFT JOIN [dbo].[ADM_UserMaster] UMLastUpdatedBy  With(Nolock) ON GQ.LastUpdatedByRef=UMLastUpdatedBy.[ADM_UserMasterId] AND UMLastUpdatedBy.IsActive=1
	  WHERE GQ.Gen_QueueId != @Gen_QueueId

	  UNION

		SELECT GQ.[GEN_QueueId],GQ.[BusinessSegmentLkup],LMBusinessSegment.LookupValue as BusinessSegment,GQ.[WorkBasketLkup],LMWorkBasket.LookupValue AS WorkBasket,GQ.[DiscrepancyTypeLkup],LMDiscrepancyType.LookupValue AS DiscrepancyType,GQ.[DiscrepancyStartDate],GQ.[DiscrepancySourceLkup],LMDiscrepancySource.LookupValue AS DiscrepancySource
			   ,GQ.[DiscrepancyCategoryLkup],LMDiscrepancyCategory.LookupValue AS DiscrepancyCategory,GQ.GPSHouseholdID,GQ.[MemberMedicareId] as MemberCurrentHICN,GQ.[MemberContractIDLkup],LMContract.LookupValue AS MemberContract,GQ.[MemberPBPLkup],LMPBP.LookupValue AS MemberPBP,GQ.[IsParentCase],GQ.[IsChildCase],GQ.[ParentQueueRef],GQ.[MostRecentWorkQueueLkup],LMMostRecentWorkQueue.LookupValue as MostRecentWorkQueue,GQ.[MostRecentStatusLkup],LMMostRecentStatus.LookupValue as MostRecentStatus
			   ,GQACT.[FirstLetterMailDate],GQACT.[SecondLetterMailDate],GQ.CreatedByRef,UMCreatedBy.FullName AS CreatedBy, GQ.UTCCreatedOn, GQ.LastUpdatedByRef,UMLastUpdatedBy.FullName AS LastUpdatedBy, GQ.UTCLastUpdatedOn
		   FROM [dbo].[GEN_Queue] GQ With(Nolock)
	  LEFT JOIN [dbo].[GEN_OSTActions] GQACT With(Nolock) ON GQACT.[GEN_QueueRef] = GQ.[GEN_QueueId] AND GQ.IsActive=1
	  LEFT JOIN [dbo].[CMN_LookupMaster] LMBusinessSegment With(Nolock) ON GQ.[BusinessSegmentLkup]=LMBusinessSegment.[CMN_LookupMasterId] AND LMBusinessSegment.CMN_LookupTypeRef=1 AND LMBusinessSegment.IsActive=1
      LEFT JOIN [dbo].[CMN_LookupMaster] LMWorkBasket  With(Nolock) ON GQ.[WorkBasketLkup]=LMWorkBasket.[CMN_LookupMasterId] AND LMWorkBasket.CMN_LookupTypeRef=3 AND LMWorkBasket.IsActive=1
	  LEFT JOIN [dbo].[CMN_LookupMaster] LMDiscrepancyCategory With(Nolock) ON GQ.[DiscrepancyCategoryLkup]=LMDiscrepancyCategory.[CMN_LookupMasterId] AND LMDiscrepancyCategory.CMN_LookupTypeRef=6 AND LMDiscrepancyCategory.IsActive=1
	  LEFT JOIN [dbo].[CMN_LookupMaster] LMDiscrepancyType With(Nolock) ON GQ.[DiscrepancyTypeLkup]=LMDiscrepancyType.[CMN_LookupMasterId] AND LMDiscrepancyType.CMN_LookupTypeRef=7 AND LMDiscrepancyType.IsActive=1
	  LEFT JOIN [dbo].[CMN_LookupMaster] LMDiscrepancySource With(Nolock) ON GQ.[DiscrepancySourceLkup]=LMDiscrepancySource.[CMN_LookupMasterId] AND LMDiscrepancySource.CMN_LookupTypeRef=13 AND LMDiscrepancySource.IsActive=1
	  LEFT JOIN [dbo].[CMN_LookupMaster] LMMostRecentWorkQueue With(Nolock) ON GQ.[MostRecentWorkQueueLkup]=LMMostRecentWorkQueue.[CMN_LookupMasterId] AND LMMostRecentWorkQueue.CMN_LookupTypeRef=10 AND LMMostRecentWorkQueue.IsActive=1
	  LEFT JOIN [dbo].[CMN_LookupMaster] LMMostRecentStatus With(Nolock) ON GQ.[MostRecentStatusLkup]=LMMostRecentStatus.[CMN_LookupMasterId] AND LMMostRecentStatus.CMN_LookupTypeRef=20 AND LMMostRecentStatus.IsActive=1
	  LEFT JOIN [dbo].[CMN_LookupMaster] LMContract With(Nolock) ON GQ.[MemberContractIDLkup]=LMContract.[CMN_LookupMasterId] AND LMContract.CMN_LookupTypeRef=11 AND LMContract.IsActive=1
	  LEFT JOIN [dbo].[CMN_LookupMaster] LMPBP With(Nolock) ON GQ.[MemberPBPLkup]=LMPBP.[CMN_LookupMasterId] AND LMPBP.CMN_LookupTypeRef=12 AND LMPBP.IsActive=1	  
	  LEFT JOIN [dbo].[ADM_UserMaster] UMCreatedBy  With(Nolock) ON GQ.CreatedByRef=UMCreatedBy.[ADM_UserMasterId] AND UMCreatedBy.IsActive=1
	  LEFT JOIN [dbo].[ADM_UserMaster] UMLastUpdatedBy  With(Nolock) ON GQ.LastUpdatedByRef=UMLastUpdatedBy.[ADM_UserMasterId] AND UMLastUpdatedBy.IsActive=1
		WHERE GQ.Gen_QueueId != @Gen_QueueId AND GQ.[BusinessSegmentLkup]=@BusinessSegmentLkup AND GQ.[WorkBasketLkup]=@WorkBasketLkup AND GQ.[MostRecentStatusLkup] != 20003 AND (GQ.[MemberCurrentHICN]=@MemberCurrentHICN OR GQ.[MemberMedicareId]=@MemberCurrentHICN) AND GQ.[MemberContractIDLkup]=@MemberContractIDLkup AND GQ.[MemberPBPLkup]=@MemberPBPLkup AND GQ.[IsActive]=1

    -- Select records from Comments Table3
	   SELECT GCOMT.[GEN_QueueRef],GCOMT.[Comments],GCOMT.[ActionLkup],LMAction.LookupValue AS Action,GCOMT.[IsActive],GCOMT.[UTCCreatedOn],GCOMT.[CreatedByRef],UMCreatedBy.FullName AS CreatedBy
			 ,GCOMT.[UTCLastUpdatedOn],GCOMT.[LastUpdatedByRef],UMLastUpdatedBy.FullName AS LastUpdatedBy,[SourceSystemLkup],LMCommentsSystem.LookupValue AS SourceSystem
		FROM [dbo].[GEN_Comments] GCOMT With(Nolock)
	LEFT JOIN dbo.[CMN_LookupMaster] LMAction With(Nolock) ON GCOMT.[ActionLkup] = LMAction.[CMN_LookupMasterId] AND LMAction.CMN_LookupTypeRef=28 AND LMAction.IsActive=1 
	LEFT JOIN [dbo].[ADM_UserMaster] UMCreatedBy  With(Nolock) ON GCOMT.CreatedByRef=UMCreatedBy.[ADM_UserMasterId] AND UMCreatedBy.IsActive=1
	LEFT JOIN [dbo].[ADM_UserMaster] UMLastUpdatedBy  With(Nolock) ON GCOMT.LastUpdatedByRef=UMLastUpdatedBy.[ADM_UserMasterId] AND UMLastUpdatedBy.IsActive=1
	LEFT JOIN dbo.[CMN_LookupMaster] LMCommentsSystem With(Nolock) ON GCOMT.[SourceSystemLkup] = LMCommentsSystem.[CMN_LookupMasterId] AND LMCommentsSystem.CMN_LookupTypeRef=38 AND LMCommentsSystem.IsActive=1 
		WHERE GCOMT.[GEN_QueueRef] = @GEN_QueueId AND GCOMT.[IsActive] = 1	 
		
	-- Select records from Attachemnts Table4
	  SELECT Row_Number() Over (Order By GA.[GEN_AttachmentsId] asc) AS SLNO, GA.[GEN_AttachmentsId],GA.[GEN_QueueRef],GA.[UploadedFileName],GA.[FileName],GA.[FilePath],GA.[GEN_DMSDataRef],GA.[IsActive],GA.[UTCCreatedOn],GA.[CreatedByRef],GA.[UTCLastUpdatedOn],GA.[LastUpdatedByRef],UMCreatedBy.FullName AS CreatedBy,UMLastUpdatedBy.FullName AS LastUpdatedBy
	    FROM [dbo].[GEN_Attachments] GA With(Nolock) 
		LEFT JOIN [dbo].[ADM_UserMaster] UMCreatedBy  With(Nolock) ON GA.CreatedByRef=UMCreatedBy.[ADM_UserMasterId] AND UMCreatedBy.IsActive=1
		LEFT JOIN [dbo].[ADM_UserMaster] UMLastUpdatedBy  With(Nolock) ON GA.LastUpdatedByRef=UMLastUpdatedBy.[ADM_UserMasterId] AND UMLastUpdatedBy.IsActive=1
	   WHERE [GEN_QueueRef] = @GEN_QueueId AND GA.[IsActive] = 1

	-- Select records from Manage cases Table5
		SELECT [GEN_QueueRef],[ActionPerformedLkup],[CurrentUserRef],[CasesComments],[ReAssignUserRef],[IsActive],[UTCCreatedOn],[CreatedByRef],
			   [UTCLastUpdatedOn],[LastUpdatedByRef]
		FROM [dbo].[GEN_ManageCases]
		WHERE [GEN_QueueRef] = @GEN_QueueId 
		
     -- Select records from Gen_Queue Workflow correlation Table6
		SELECT GQWC.[GEN_QueueRef],GQWC.[RoleLkup],LMRole.LookupValue AS Role,GQWC.[WorkBasketLkup],LMWorkBasket.LookupValue AS WorkBasket
			   ,GQWC.[DiscrepancyCategoryLkup] AS DiscripancyCategoryLkup,LMDiscripancyCategory.LookupValue AS DiscripancyCategory,GQWC.[PreviousActionLkup]
			   ,LMPreviousAction.LookupValue AS PreviousAction,GQWC.[PreviousWorkQueuesLkup],LMPreviousWorkQueues.LookupValue AS PreviousWorkQueues
			   ,GQWC.[PreviousStatusLkup],LMPreviousStatus.LookupValue AS PreviousStatus,GQWC.[CurrentActionLkup],LMCurrentAction.LookupValue AS CurrentAction
			   ,GQWC.[CurrentWorkQueuesLkup],LMCurrentWorkQueues.LookupValue AS CurrentWorkQueues,GQWC.[CurrentStatusLkup],LMCurrentStatus.LookupValue AS CurrentStatus
			   ,GQWC.[IsActive],GQWC.[UTCCreatedOn],GQWC.[CreatedByRef],UMCreatedBy.FullName AS CreatedBy
		   FROM [dbo].[GEN_QueueWorkFlowCorrelation] GQWC With(Nolock)
	  INNER JOIN dbo.[GEN_Queue] GQ With(Nolock) ON GQ.GEN_QueueId = GQWC.GEN_QueueRef AND GQ.IsActive=1
	  LEFT JOIN dbo.[CMN_LookupMaster] LMRole With(Nolock) ON GQWC.RoleLkup=LMRole.[CMN_LookupMasterId] AND LMRole.CMN_LookupTypeRef=2 AND LMRole.IsActive=1
	  LEFT JOIN dbo.[CMN_LookupMaster] LMWorkBasket With(Nolock) ON GQWC.WorkBasketLkup=LMWorkBasket.[CMN_LookupMasterId] AND LMWorkBasket.CMN_LookupTypeRef=3 AND LMWorkBasket.IsActive=1
	  LEFT JOIN dbo.[CMN_LookupMaster] LMDiscripancyCategory With(Nolock) ON GQWC.DiscrepancyCategoryLkup=LMDiscripancyCategory.[CMN_LookupMasterId] AND LMDiscripancyCategory.CMN_LookupTypeRef=6 AND LMDiscripancyCategory.IsActive=1
	  LEFT JOIN dbo.[CMN_LookupMaster] LMPreviousAction With(Nolock) ON GQWC.PreviousActionLkup=LMPreviousAction.[CMN_LookupMasterId] AND LMPreviousAction.CMN_LookupTypeRef=28 AND LMPreviousAction.IsActive=1
	  LEFT JOIN dbo.[CMN_LookupMaster] LMPreviousWorkQueues With(Nolock) ON GQWC.PreviousWorkQueuesLkup=LMPreviousWorkQueues.[CMN_LookupMasterId] AND LMPreviousWorkQueues.CMN_LookupTypeRef=10 AND LMPreviousWorkQueues.IsActive=1
	  LEFT JOIN dbo.[CMN_LookupMaster] LMPreviousStatus With(Nolock) ON GQWC.PreviousStatusLkup=LMPreviousStatus.[CMN_LookupMasterId] AND LMPreviousStatus.CMN_LookupTypeRef=20 AND LMPreviousStatus.IsActive=1
	  LEFT JOIN dbo.[CMN_LookupMaster] LMCurrentAction With(Nolock) ON GQWC.CurrentActionLkup=LMCurrentAction.[CMN_LookupMasterId] AND LMCurrentAction.CMN_LookupTypeRef=28 AND LMCurrentAction.IsActive=1
	  LEFT JOIN dbo.[CMN_LookupMaster] LMCurrentWorkQueues With(Nolock) ON GQWC.CurrentWorkQueuesLkup=LMCurrentWorkQueues.[CMN_LookupMasterId] AND LMCurrentWorkQueues.CMN_LookupTypeRef=10 AND LMCurrentWorkQueues.IsActive=1
	  LEFT JOIN dbo.[CMN_LookupMaster] LMCurrentStatus With(Nolock) ON GQWC.CurrentStatusLkup=LMCurrentStatus.[CMN_LookupMasterId] AND LMCurrentStatus.CMN_LookupTypeRef=20 AND LMCurrentStatus.IsActive=1
	  LEFT JOIN [dbo].[ADM_UserMaster] UMCreatedBy  With(Nolock) ON GQWC.CreatedByRef=UMCreatedBy.[ADM_UserMasterId] AND UMCreatedBy.IsActive=1
		  WHERE GQWC.[GEN_QueueRef] = @GEN_QueueId

    END TRY
	BEGIN CATCH
		SET @ErrorMessage= ERROR_MESSAGE();
	END CATCH  
END