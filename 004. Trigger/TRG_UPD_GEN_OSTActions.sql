IF OBJECT_ID ('TRG_UPD_GEN_OSTActions') IS NOT NULL 
BEGIN
	DROP TRIGGER  [dbo].[TRG_UPD_GEN_OSTActions]
END
GO
/****** Object:  Trigger [dbo].[TRG_UPD_GEN_OSTActions]    Script Date: 8/2/2017 3:09:30 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[TRG_UPD_GEN_OSTActions]
   ON [dbo].[GEN_OSTActions]
 AFTER UPDATE
  AS
INSERT INTO [dbo].[GEN_OSTActionsHistory]
           ([GEN_OSTActionsRef]
           ,[GEN_QueueRef]
           ,[ActionLkup]
           ,[LastName]
           ,[DateofBirth]
           ,[ContractIDLkup]
           ,[PBPLkup]
           ,[ApplicationDate]
           ,[EffectiveDate]
           ,[EndDate]
           ,[FirstLetterMailDate]
           ,[SecondLetterMailDate]
           ,[ResidentialDocumentationRequired]
           ,[CountyAttestationRequired]
           ,[PendReasonLkup]
           ,[ContainsErrorsLkup]
           ,[ResolutionLkup]
           ,[Reason]
           ,[InitialAddressVerificationDate]
           ,[MemberResponseVerificationDate]
           ,[SCCLetterMailDate]
           ,[IsActive]
           ,[UTCCreatedOn]
           ,[CreatedByRef]
           ,[UTCLastUpdatedOn]
           ,[LastUpdatedByRef]
           ,[UTCHistoryCreatedOn]
           ,[HistoryCreatedByRef]
           ,[GEN_ManageCasesRef]
           ,[FirstLetterMailDateId]
           ,[SecondLetterMailDateId]
           ,[InitialAddressVerificationDateId]
           ,[MemberResponseVerificationDateId]
           ,[MemberVerifiedState]
		   ,[SCCLetterMailDateId]
		   ,[AdjustedDiscrepancyReceiptDate]
		   ,[AdjustedDiscrepancyReceiptDateId]
		   ,[AdjustedComplianceStartDate]
		   ,[AdjustedComplianceStartDateId]
		   ,[PDPAutoEnrolleeInd]
		   ,[MARxAddressResolutionLkup]
		   ,[AdjustedDisenrollmentDate]
		   ,[AdjustedDisenrollmentDateId])
     SELECT
			 GEN_OSTActionsId
			,GEN_QueueRef
			,ActionLkup
			,LastName
			,DateofBirth
			,ContractIDLkup
			,PBPLkup
			,ApplicationDate
			,EffectiveDate
			,EndDate
			,FirstLetterMailDate
			,SecondLetterMailDate
			,ResidentialDocumentationRequired
			,CountyAttestationRequired
			,PendReasonLkup
			,ContainsErrorsLkup
			,ResolutionLkup
			,Reason
			,InitialAddressVerificationDate
			,MemberResponseVerificationDate
			,SCCLetterMailDate
			,IsActive
			,UTCCreatedOn
			,CreatedByRef
			,UTCLastUpdatedOn
			,LastUpdatedByRef
			,GETUTCDATE()
			,CreatedByRef
			,0
			,FirstLetterMailDateId
			,SecondLetterMailDateId
			,InitialAddressVerificationDateId
			,MemberResponseVerificationDateId
			,MemberVerifiedState
			,SCCLetterMailDateId
			,AdjustedDiscrepancyReceiptDate
			,AdjustedDiscrepancyReceiptDateId
			,AdjustedComplianceStartDate
			,AdjustedComplianceStartDateId
			,PDPAutoEnrolleeInd
			,MARxAddressResolutionLkup
			,AdjustedDisenrollmentDate
			,AdjustedDisenrollmentDateId
			FROM INSERTED

GO


