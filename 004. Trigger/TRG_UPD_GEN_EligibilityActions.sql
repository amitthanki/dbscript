IF OBJECT_ID ('TRG_UPD_GEN_EligibilityActions') IS NOT NULL 
BEGIN
	DROP TRIGGER  [dbo].[TRG_UPD_GEN_EligibilityActions]
END
GO
/****** Object:  Trigger [dbo].[TRG_UPD_GEN_EligibilityActions]    Script Date: 8/2/2017 3:16:59 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE TRIGGER [dbo].[TRG_UPD_GEN_EligibilityActions]
  ON [dbo].[GEN_EligibilityActions]
  AFTER UPDATE
  AS


INSERT INTO [dbo].[GEN_EligibilityActionsHistory]
           ([GEN_EligibilityActionsRef]
           ,[GEN_QueueRef]
           ,[ActionLkup]
           ,[HICN]
           ,[LastName]
           ,[DateofBirth]
           ,[ContractIDLkup]
           ,[PBPLkup]
           ,[TransactionTypeCodeLkup]
           ,[ApplicationDate]
           ,[ElectionTypeLkup]
           ,[EffectiveDate]
           ,[ResolutionLkup]
           ,[RootCauseLkup]
           ,[EGHPIndicator]
           ,[PendReasonLkup]
           ,[ContainsErrorsLkup]
           ,[IsActive]
           ,[UTCCreatedOn]
           ,[CreatedByRef]
           ,[UTCLastUpdatedOn]
           ,[LastUpdatedByRef]
           ,[UTCHistoryCreatedOn]
           ,[HistoryCreatedByRef]
           ,[GEN_ManageCasesRef]
           ,[FirstLetterMailDate]
           ,[FirstLetterMailDateId]
           ,[SecondLetterMailDate]
           ,[SecondLetterMailDateId]
           ,[Reason]
           ,[InitialAddressVerificationDate]
           ,[InitialAddressVerificationDateId]
           ,[MemberResponseVerificationDate]
           ,[MemberResponseVerificationDateId]
           ,[MemberVerifiedStateLkup]
           ,[OtherResolution]
		   ,[OtherRootCause])
     SELECT
			
			GEN_EligibilityActionsId
			,GEN_QueueRef
			,ActionLkup
			,HICN
			,LastName
			,DateofBirth
			,ContractIDLkup
			,PBPLkup
			,TransactionTypeCodeLkup
			,ApplicationDate
			,ElectionTypeLkup
			,EffectiveDate
			,ResolutionLkup
			,RootCauseLkup
			,EGHPIndicator
			,PendReasonLkup
			,ContainsErrorsLkup
			,IsActive
			,UTCCreatedOn
			,CreatedByRef
			,UTCLastUpdatedOn
			,LastUpdatedByRef
			,GETUTCDATE()
			,LastUpdatedByRef
			,0
			,FirstLetterMailDate
			,FirstLetterMailDateId
			,SecondLetterMailDate
			,SecondLetterMailDateId
			,Reason
			,InitialAddressVerificationDate
			,InitialAddressVerificationDateId
			,MemberResponseVerificationDate
			,MemberResponseVerificationDateId
			,MemberVerifiedStateLkup
			,OtherResolution
			,OtherRootCause
			FROM INSERTED

GO


