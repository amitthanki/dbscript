IF OBJECT_ID ('TRG_UPD_GEN_RPRAction') IS NOT NULL 
BEGIN
	DROP TRIGGER  [dbo].[TRG_UPD_GEN_RPRAction]
END
GO
/****** Object:  Trigger [dbo].[TRG_UPD_GEN_RPRAction]    Script Date: 8/2/2017 3:18:22 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[TRG_UPD_GEN_RPRAction]
   ON [dbo].[GEN_RPRActions]
 AFTER UPDATE
  AS

INSERT INTO [dbo].[GEN_RPRActionsHistory]
           ([GEN_RPRActionsRef]
           ,[GEN_QueueRef]
           ,[ActionLkup]
           ,[ResolutionLkup]
           ,[RootCauseLkup]
           ,[PendReasonLkup]
           ,[AdjustedCreateDate]
           ,[AdjustedCreateDateReasonLkup]
           ,[SubmissionTypeLkup]
           ,[ContainsErrorsLkup]
           ,[RPCSubmissionDate]
           ,[CMSAccountManagerSubmissionDate]
           ,[CMSAccountManagerApprovalDate]
           ,[FDRStatusLkup]
           ,[FDRReceivedDate]
           ,[FDRCodeReceived]
           ,[FDRDescription]
           ,[CMSProcessDate]
           ,[TransactionType]
           ,[FDRRejectionTypeLkup]
           ,[LastName]
           ,[DateofBirth]
           ,[ContractIDLkup]
           ,[PBPLkup]
           ,[ApplicationDate]
           ,[EffectiveDate]
           ,[EndDate]
           ,[ActualSubmissionDate]
           ,[ReasonSubmissionRejected]
           ,[RequestedSCC]
           ,[RequestedZIP]
           ,[ResubmissionDate]
           ,[IsActive]
           ,[UTCCreatedOn]
           ,[CreatedByRef]
           ,[UTCLastUpdatedOn]
           ,[LastUpdatedByRef]
           ,[UTCHistoryCreatedOn]
           ,[HistoryCreatedByRef]
           ,[GEN_ManageCasesRef]
           ,[OtherAdjustedCreateDateReason]
           ,[OtherFDRStatus]
           ,[ElectionTypeLkup]
           ,[AdjustedCreateDateId]
           ,[RPCSubmissionDateId]
           ,[CMSAccountManagerApprovalDateId]
           ,[FDRReceivedDateId]
           ,[PotentialSubmissionDate]
           ,[PotentialSubmissionDateId]
		   ,[FDRPackageDate]
		   ,[FDRPackageDateId]
		   ,[FDRSubmissionCategoryLkup]
		   ,[TransactionTypeCodeLkup]
		   ,[ExplanationOfRootCauseLkup]
		   ,[VerifiedRootCauseLkup]
		   ,[PlanError])
     SELECT
			 GEN_RPRActionsId
			,GEN_QueueRef
			,ActionLkup
			,ResolutionLkup
			,RootCauseLkup
			,PendReasonLkup
			,AdjustedCreateDate
			,AdjustedCreateDateReasonLkup
			,SubmissionTypeLkup
			,ContainsErrorsLkup
			,RPCSubmissionDate
			,CMSAccountManagerSubmissionDate
			,CMSAccountManagerApprovalDate
			,FDRStatusLkup
			,FDRReceivedDate
			,FDRCodeReceived
			,FDRDescription
			,CMSProcessDate
			,TransactionType
			,FDRRejectionTypeLkup
			,LastName
			,DateofBirth
			,ContractIDLkup
			,PBPLkup
			,ApplicationDate
			,EffectiveDate
			,EndDate
			,ActualSubmissionDate
			,ReasonSubmissionRejected
			,RequestedSCC
			,RequestedZIP
			,ResubmissionDate
			,IsActive
			,UTCCreatedOn
			,CreatedByRef
			,UTCLastUpdatedOn
			,LastUpdatedByRef
			,GETUTCDATE()
			,CreatedByRef
			,0
			,OtherAdjustedCreateDateReason
			,OtherFDRStatus
			,ElectionTypeLkup
			,AdjustedCreateDateId
			,RPCSubmissionDateId
			,CMSAccountManagerApprovalDateId
			,FDRReceivedDateId
			,PotentialSubmissionDate
			,PotentialSubmissionDateId 
			,FDRPackageDate
			,FDRPackageDateId
			,FDRSubmissionCategoryLkup
			,TransactionTypeCodeLkup
		    ,ExplanationOfRootCauseLkup
		    ,VerifiedRootCauseLkup
			,PlanError
			FROM INSERTED
GO


