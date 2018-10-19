IF OBJECT_ID ('USP_UPD_TRC155_Macro') IS NOT NULL 
BEGIN
	DROP PROC [dbo].[USP_UPD_TRC155_Macro]
END
GO
/****** Object:  StoredProcedure [dbo].[USP_UPD_TRC155_Macro]    Script Date: 8/10/2017 11:51:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:Amit Thanki
-- Create date: 01/29/2018
-- Modified By: 
-- Modification Date: 
-- Description: Update OOA Action Based on Queue for Macro.
-- =============================================
CREATE PROCEDURE [dbo].[USP_UPD_TRC155_Macro]
@GEN_QueueId bigint,
@Status Varchar(50),
@ErrorMessage VARCHAR(2000) OUT
As
BEGIN 
	 DECLARE @CurrentUser BigInt
	 Set  @CurrentUser = 23
	 DECLARE @CurrentUTCDate datetime
	 Set @CurrentUTCDate = getutcDate()
	 DECLARE @PreviousActionLkup bigint
     DECLARE @PreviousWorkQueueLkup bigint
	 DECLARE @ActionLkup bigint	
	 DECLARE @MostRecentQueueLkup bigint
	 Declare @ChildQueueRef BIGINT = NULL
	
    BEGIN TRY	         
             BEGIN TRAN  
			          Select @PreviousWorkQueueLkup = MostRecentWorkQueueLkup, @PreviousActionLkup = MostRecentActionLkup  from Gen_Queue  WITH(NOLOCK) Where GEN_QueueId =  @GEN_QueueId;  
					  IF (@Status = 'Completed')
                      BEGIN
					  Set    @ActionLkup = 28068  --No OOA LTR/Pending NOT
					  Set    @MostRecentQueueLkup = 10036   --- --- TRR - Completed
					  Update GEN_OSTActions 
					  Set    ActionLkup        = @ActionLkup,
						     [UTCLastUpdatedOn]=@CurrentUTCDate,
                             [LastUpdatedByRef]=@CurrentUser
					  Where  GEN_QueueRef = @GEN_QueueId 
					  Update GEN_Queue 
					  Set    IsTRC155MacroProcessed  = 1
							 ,TRC155MacroStatusLkup = 59001
							 ,TRC155MacroUpdatedOn = @CurrentUTCDate
							 ,TRC155MacroUpdatedByRef = @CurrentUser
						     ,MostRecentWorkQueueLkup = @MostRecentQueueLkup --- Queue - TRR - Completed,	
							 ,MostRecentStatusLkup   = 20003
							 ,MostRecentActionLkup    = @ActionLkup
							 ,[UTCLastUpdatedOn]= @CurrentUTCDate
							 ,[UTCLastUpdatedOnId]= FORMAT(@CurrentUTCDate, 'yyyyMMdd')
							 ,[UTCLastUpdatedOnYear]= FORMAT(@CurrentUTCDate, 'yyyy')
							 ,[UTCLastUpdatedOnMonth]= FORMAT(@CurrentUTCDate, 'MM')
							 ,[UTCLastUpdatedOnDay]= FORMAT(@CurrentUTCDate, 'dd')
							 ,[CSTLastUpdatedOn]= DATEADD(hh, -6, @CurrentUTCDate)
							 ,[CSTLastUpdatedOnId]= FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'yyyyMMdd')
							 ,[CSTLastUpdatedOnYear]= FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'yyyy')
							 ,[CSTLastUpdatedOnMonth]= FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'MM')
							 ,[CSTLastUpdatedOnDay]= FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'dd')
							 ,[LastUpdatedByRef] = @CurrentUser
					  Where  GEN_QueueId = @GEN_QueueId
		--- Insert record into Manage cases
					      INSERT INTO [dbo].[GEN_ManageCases]([GEN_QueueRef],[ActionPerformedLkup],[CurrentUserRef],[CasesComments],[ReAssignUserRef],[IsActive],[UTCCreatedOn],[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef])											 
						  VALUES
					 			(@GEN_QueueId,@ActionLkup,@CurrentUser,'TRC 155 Macro Processed',@CurrentUser,1,@CurrentUTCDate,@CurrentUser,@CurrentUTCDate,@CurrentUser)
		--- Insert record into Comments table						
				         INSERT INTO [dbo].[GEN_Comments] ([GEN_QueueRef],[Comments],[ActionLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef],[SourceSystemLkup])											 
				         VALUES
							(@GEN_QueueId,'TRC 155 Macro Processed',@ActionLkup,1,@CurrentUTCDate,@CurrentUser,@CurrentUTCDate ,@CurrentUser,38006)
							
		--- Insert record into Gen_Queue Workflow correlation
                           INSERT INTO [dbo].[GEN_QueueWorkFlowCorrelation]([GEN_QueueRef],[RoleLkup],[WorkBasketLkup],[DiscrepancyCategoryLkup],[PreviousActionLkup],[PreviousWorkQueuesLkup],
                                                                            [PreviousStatusLkup],[CurrentActionLkup],[CurrentWorkQueuesLkup],[CurrentStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
                            VALUES
							      (@GEN_QueueId,2001,3001,6001,@PreviousActionLkup,@PreviousWorkQueueLkup,20002,@ActionLkup,@MostRecentQueueLkup,20003,1,@CurrentUTCDate,@CurrentUser)

          --------------------Create OOA Case---------------------
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
									,3001 --[WorkBasketLkup]
									,6001 --[DiscrepancyCategoryLkup]
									,7003 --[DiscrepancyTypeLkup] -- Incarcerated
									,28032 --[MostRecentActionLkup] -- Action - Save 
									,10007 --[MostRecentWorkQueueLkup] New Case
									,20001 -- Status - NEW --[MostRecentStatusLkup]
									,NULL --[PreviousWorkQueueLkup]
									,NULL --[PreviousAuditWorkQueueLkup]
									,38006 --[SourceSystemLkup]
									,NULL --[SourceSystemId]
									,13001 --[DiscrepancySourceLkup] ----TRR
									,DiscrepancyReceiptDate --[DiscrepancyReceiptDate]
									,DiscrepancyReceiptDateId --[DiscrepancyReceiptDateId]
									,CONVERT(date,GetDate()) --[ComplianceStartDate]
									,FORMAT(GetDate() , 'yyyyMMdd') --[ComplianceStartDateId]
									,DisenrollmentDate --[DisenrollmentDate]
									,null --[DiscrepancyStartDate]
									,null --[DiscrepancyStartDateId]
									,NULL --[DiscrepancyEndDate]
									,NULL --[DiscrepancyEndDateId]
									,MemberSCCCode --[MemberSCCCode]
									,PDPAutoEnrolleeInd --[PDPAutoEnrolleeInd]
									,ReferencedEligibilityCaseInd --[ReferencedEligibilityCaseInd]
									,ReferencedSCCCaseInd --[ReferencedSCCCaseInd]
									,FileTypeLkup  --[FileTypeLkup]
									,ODMDocID  --[ODMDocID]
									,ODMAddressLink  --[ODMAddressLink]
									,UndeliveredAddress1  --[UndeliveredAddress1]
									,UndeliveredAddress2  --[UndeliveredAddress2]
									,UndeliveredCity  --[UndeliveredCity]
									,UndeliveredState  --[UndeliveredState]
									,UndeliveredZip  --[UndeliveredZip]
									,COAOldAddress1  --[COAOldAddress1]
									,COAOldAddress2  --[COAOldAddress2]
									,COAOldCity  --[COAOldCity]
									,COAOldState  --[COAOldState]
									,COAOldZip  --[COAOldZip]
									,COANewAddress1  --[COANewAddress1]
									,COANewAddress2  --[COANewAddress2]
									,COANewCity  --[COANewCity]
									,COANewState  --[COANewState]
									,COANewZip  --[COANewZip]
									,NULL  --[OOALetterStatusLkup]
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
									,EligOOAFlagLkup --[EligOOAFlagLkup]
									,NULL --[RPRRequestedEffectiveDate]
									,NULL --[RPRRequestedEffectiveDateId]
									,NULL --[RPRActionRequestedLkup]
									,NULL --[RPROtherActionRequested]
									,NULL --[RPRSupervisorOrRequesterRef]
									,NULL --[RPRReasonforRequest]
									,NULL --[RPRTaskPerformedLkup]
									,NULL --[RPROtherTaskPerformed]
									,0 --[RPRCTMMember]
									,NULL --[RPRCTMNumber]
									,0    --[RPREGHPMember]
									,NULL --[RPREmployerID]
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
									,@CurrentUTCDate --[UTCCreatedOn]
									,FORMAT(@CurrentUTCDate, 'yyyyMMdd') --[UTCCreatedOnId]
									,FORMAT(@CurrentUTCDate, 'yyyy') --[UTCCreatedOnYear]
									,FORMAT(@CurrentUTCDate, 'MM') --[UTCCreatedOnMonth]
									,FORMAT(@CurrentUTCDate, 'dd') --[UTCCreatedOnDay]
									,DATEADD(hh, -6, @CurrentUTCDate) --[CSTCreatedOn]
									,FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'yyyyMMdd') --[CSTCreatedOnId]
									,FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'yyyy') --[CSTCreatedOnYear]
									,FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'MM') --[CSTCreatedOnMonth]
									,FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'dd') --[CSTCreatedOnDay]
									,@CurrentUser --[CreatedByRef]
									,@CurrentUTCDate --[UTCLastUpdatedOn]
									,FORMAT(@CurrentUTCDate, 'yyyyMMdd') --[UTCLastUpdatedOnId]
									,FORMAT(@CurrentUTCDate, 'yyyy') --[UTCLastUpdatedOnYear]
									,FORMAT(@CurrentUTCDate, 'MM') --[UTCLastUpdatedOnMonth]
									,FORMAT(@CurrentUTCDate, 'dd') --[UTCLastUpdatedOnDay]
									,DATEADD(hh, -6, @CurrentUTCDate) --[CSTLastUpdatedOn]
									,FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'yyyyMMdd') --[CSTLastUpdatedOnId]
									,FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'yyyy') --[CSTLastUpdatedOnYear]
									,FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'MM') --[CSTLastUpdatedOnMonth]
									,FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'dd') --[CSTLastUpdatedOnDay]
									,@CurrentUser --[LastUpdatedByRef]
									,TRCLkup
									,MemberMedicareId
									FROM [dbo].Gen_Queue where GEN_QueueId=@GEN_QueueId

				            SELECT @ChildQueueRef = Scope_Identity()							

							--- Insert record into Manage cases
							INSERT INTO [dbo].[GEN_ManageCases]([GEN_QueueRef],[ActionPerformedLkup],[CurrentUserRef],[CasesComments],[ReAssignUserRef],[IsActive],[UTCCreatedOn],
											[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef])
							VALUES(@ChildQueueRef,@ActionLkup,@CurrentUser,NULL,NULL,1,@CurrentUTCDate,@CurrentUser,@CurrentUTCDate,@CurrentUser)

							INSERT INTO [dbo].[GEN_Comments] ([GEN_QueueRef],[Comments],[ActionLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef],[SourceSystemLkup])											 
				            VALUES
							(@ChildQueueRef,'Macro TRC 155 Macro Processed',@ActionLkup,1,@CurrentUTCDate,@CurrentUser,@CurrentUTCDate,@CurrentUser,38006 ) 
								
							--- Insert record into Gen_Queue Workflow correlation
							INSERT INTO [dbo].[GEN_QueueWorkFlowCorrelation]
							           ([GEN_QueueRef],[RoleLkup],[WorkBasketLkup],[DiscrepancyCategoryLkup],[PreviousActionLkup],[PreviousWorkQueuesLkup],
								       [PreviousStatusLkup],[CurrentActionLkup],[CurrentWorkQueuesLkup],[CurrentStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
							VALUES
							           (@ChildQueueRef,2001,3001,6001,NULL,NULL,NULL,28032,10007,20001,1,@CurrentUTCDate,@CurrentUser)	
								
								-----------------------Update Records in Gen_Queue with Most Recent Queue Pending -NOT and action No OOA LTR/Pending NOT
						  Update GEN_Queue 
							 Set    
								  MostRecentWorkQueueLkup = 10013 --- Queue - Pending – NOT ,	
								 ,MostRecentStatusLkup   = 20002
								 ,MostRecentActionLkup    = @ActionLkup  ---- No OOA LTR/Pending NOT
								 ,[UTCLastUpdatedOn]= @CurrentUTCDate
								 ,[UTCLastUpdatedOnId]= FORMAT(@CurrentUTCDate, 'yyyyMMdd')
								 ,[UTCLastUpdatedOnYear]= FORMAT(@CurrentUTCDate, 'yyyy')
								 ,[UTCLastUpdatedOnMonth]= FORMAT(@CurrentUTCDate, 'MM')
								 ,[UTCLastUpdatedOnDay]= FORMAT(@CurrentUTCDate, 'dd')
								 ,[CSTLastUpdatedOn]= DATEADD(hh, -6, @CurrentUTCDate)
								 ,[CSTLastUpdatedOnId]= FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'yyyyMMdd')
								 ,[CSTLastUpdatedOnYear]= FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'yyyy')
								 ,[CSTLastUpdatedOnMonth]= FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'MM')
								 ,[CSTLastUpdatedOnDay]= FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'dd')
								 ,[LastUpdatedByRef] = @CurrentUser
					  Where  GEN_QueueId = @ChildQueueRef

					     IF NOT EXISTS(SELECT TOP 1 * FROM [dbo].[GEN_OSTActions] WHERE [GEN_QueueRef]=@ChildQueueRef)
					BEGIN
						----------------insert into OST Actions and Update First Letter Mail Date.
							INSERT INTO [dbo].[GEN_OSTActions]
							([GEN_QueueRef],[ActionLkup],[LastName],[DateofBirth],[ContractIDLkup],[PBPLkup],[ApplicationDate],[EffectiveDate],
							[EndDate],[FirstLetterMailDate],[FirstLetterMailDateId],[SecondLetterMailDate],[SecondLetterMailDateId],[ResidentialDocumentationRequired],[CountyAttestationRequired],
							[PendReasonLkup],[ContainsErrorsLkup],[ResolutionLkup],[Reason],[InitialAddressVerificationDate],[InitialAddressVerificationDateId],
							[MemberResponseVerificationDate],[MemberVerifiedState],[SCCLetterMailDate],[SCCLetterMailDateId],
							[AdjustedComplianceStartDate],[AdjustedComplianceStartDateId],[AdjustedDiscrepancyReceiptDate],[AdjustedDiscrepancyReceiptDateId],[MARxAddressResolutionLkup],[PDPAutoEnrolleeInd],
							[AdjustedDisenrollmentDate],[AdjustedDisenrollmentDateId],[IsActive],[UTCCreatedOn],[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef])
					VALUES  (@ChildQueueRef,@ActionLkup,null,null,null,null,null,null,null,Convert(date,@CurrentUTCDate),FORMAT(@CurrentUTCDate, 'yyyyMMdd'),null,null,null,null,null,null,null,null,null,null,
							null,null,null,null,null,null,null,null,null,null,null,null,1,@CurrentUTCDate,@CurrentUser,@CurrentUTCDate,@CurrentUser)
					END
				ELSE
					BEGIN
				   Update   GEN_OSTActions 
					  Set   ActionLkup        = @ActionLkup, ----No OOA LTR/Pending NOT
						    [UTCLastUpdatedOn]=@CurrentUTCDate,
                            [LastUpdatedByRef]=@CurrentUser
					  Where GEN_QueueRef = @ChildQueueRef 
					END	
					--- Insert record into Manage cases
				  INSERT INTO [dbo].[GEN_ManageCases]([GEN_QueueRef],[ActionPerformedLkup],[CurrentUserRef],[CasesComments],[ReAssignUserRef],[IsActive],[UTCCreatedOn],
											[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef])
				 VALUES(@ChildQueueRef,@ActionLkup,@CurrentUser,NULL,NULL,1,@CurrentUTCDate,@CurrentUser,@CurrentUTCDate,@CurrentUser)
				
				--- Insert record into Gen_Queue Workflow correlation
				INSERT INTO [dbo].[GEN_QueueWorkFlowCorrelation]
				([GEN_QueueRef],[RoleLkup],[WorkBasketLkup],[DiscrepancyCategoryLkup],[PreviousActionLkup],[PreviousWorkQueuesLkup],
					[PreviousStatusLkup],[CurrentActionLkup],[CurrentWorkQueuesLkup],[CurrentStatusLkup],[IsActive],[UTCCreatedOn],
					[CreatedByRef])
				VALUES(@ChildQueueRef,2001,3001,6001,28032,10007,20001,
					@ActionLkup,10013,20002,1,@CurrentUTCDate,@CurrentUser)	
					END
					ELSE
					BEGIN
					Set   @ActionLkup = 28078    -----TRC 155 Macro Failed
					Set   @MostRecentQueueLkup = 10039   --- --- Fallout TRC 155
					Update GEN_OSTActions 
				    Set    ActionLkup        =@ActionLkup,
						   [UTCLastUpdatedOn]=@CurrentUTCDate,
                           [LastUpdatedByRef]=@CurrentUser
					Where  GEN_QueueRef = @GEN_QueueId 
				   Update   GEN_Queue 
				   set      MostRecentActionLkup = @ActionLkup
				           ,MostRecentWorkQueueLkup = @MostRecentQueueLkup
						   ,TRC155MacroStatusLkup = 59002
						   ,IsTRC155MacroProcessed  = 1
						   ,TRC155MacroUpdatedOn = @CurrentUTCDate
						   ,TRC155MacroUpdatedByRef = @CurrentUser
						   ,[UTCLastUpdatedOn]   = @CurrentUTCDate
						   ,[UTCLastUpdatedOnId]= FORMAT(@CurrentUTCDate, 'yyyyMMdd')
						   ,[UTCLastUpdatedOnYear]= FORMAT(@CurrentUTCDate, 'yyyy')
						   ,[UTCLastUpdatedOnMonth]= FORMAT(@CurrentUTCDate, 'MM')
						   ,[UTCLastUpdatedOnDay]= FORMAT(@CurrentUTCDate, 'dd')
						   ,[CSTLastUpdatedOn]= DATEADD(hh, -6, @CurrentUTCDate)
						   ,[CSTLastUpdatedOnId]= FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'yyyyMMdd')
						   ,[CSTLastUpdatedOnYear]= FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'yyyy')
						   ,[CSTLastUpdatedOnMonth]= FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'MM')
						   ,[CSTLastUpdatedOnDay]= FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'dd')
						   ,[LastUpdatedByRef] = @CurrentUser
					Where  GEN_QueueId = @GEN_QueueId
					INSERT INTO [dbo].[GEN_Comments] ([GEN_QueueRef],[Comments],[ActionLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef],[SourceSystemLkup])											 
				    VALUES
							(@GEN_QueueId,'Macro unable to complete, refer to TRC 155 Macro Processed report for further details',@ActionLkup,1,@CurrentUTCDate,@CurrentUser,@CurrentUTCDate,@CurrentUser,38006) 
							
		          --- Insert record into Manage cases
					INSERT INTO [dbo].[GEN_ManageCases]([GEN_QueueRef],[ActionPerformedLkup],[CurrentUserRef],[CasesComments],[ReAssignUserRef],[IsActive],[UTCCreatedOn],[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef])											 
					VALUES
							(@GEN_QueueId,@ActionLkup,@CurrentUser,'Macro unable to complete, refer to TRC 155 Macro Processed report for further details',@CurrentUser,1,@CurrentUTCDate,@CurrentUser,@CurrentUTCDate,@CurrentUser)
							
         --- Insert record into Gen_Queue Workflow correlation
                           INSERT INTO [dbo].[GEN_QueueWorkFlowCorrelation]([GEN_QueueRef],[RoleLkup],[WorkBasketLkup],[DiscrepancyCategoryLkup],[PreviousActionLkup],[PreviousWorkQueuesLkup],
                                                                            [PreviousStatusLkup],[CurrentActionLkup],[CurrentWorkQueuesLkup],[CurrentStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
                            VALUES
							 (@GEN_QueueId,2001,3001,6001,@PreviousActionLkup,@PreviousWorkQueueLkup,20002,@ActionLkup,@PreviousWorkQueueLkup,20002,1,@CurrentUTCDate,@CurrentUser)
					  END	
              COMMIT TRAN
       END TRY
BEGIN CATCH
       Rollback TRAN
	   INSERT INTO [dbo].[CMN_AppErrorLog](ADM_UserMasterRef,[ErrorLocation],[ErrorSourceLkup],[ErrorMessage],[ErrorDescription],[UTCErrorDateTime],[UTCCreatedOn])
		VALUES( @CurrentUser,'[dbo].[USP_UPD_TRC155_Macro]',null,ERROR_NUMBER(),ERROR_MESSAGE(),GETUTCDATE(),GETUTCDATE())
        SET @ErrorMessage = Error_Message();
END CATCH     
END