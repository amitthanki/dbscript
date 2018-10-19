--GEN_Queue
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GEN_Queue]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[GEN_Queue](
		[GEN_QueueId] bigint IDENTITY(10001,1) NOT NULL,
		[BusinessSegmentLkup] bigint NOT NULL,
		[WorkBasketLkup] bigint NOT NULL,
		[DiscrepancyCategoryLkup] bigint NOT NULL,
		[DiscrepancyTypeLkup] bigint NOT NULL,
		[StartDate] datetime NULL,
		[StartDateId] bigint NULL,
		[EndDate] datetime NULL,
		[EndDateId] bigint NULL,
		[AssignedToRef] bigint NULL,
		[UTCAssignedOn] datetime NULL,
		[UTCAssignedOnId] bigint NULL,
		[UTCAssignedOnYear] int NULL,
		[UTCAssignedOnMonth] int NULL,
		[UTCAssignedOnDay] int NULL,
		[CSTAssignedOn] datetime NULL,
		[CSTAssignedOnId] bigint NULL,
		[CSTAssignedOnYear] int NULL,
		[CSTAssignedOnMonth] int NULL,
		[CSTAssignedOnDay] int NULL,
		[PreviousAssignedToRef] bigint NULL,
		[LockedByRef] bigint NULL,
		[UTCLockedOn] datetime NULL,
		[UTCLockedOnId] bigint NULL,
		[UTCLockedOnYear] int NULL,
		[UTCLockedOnMonth] int NULL,
		[UTCLockedOnDay] int NULL,
		[CSTLockedOn] datetime NULL,
		[CSTLockedOnId] bigint NULL,
		[CSTLockedOnYear] int NULL,
		[CSTLockedOnMonth] int NULL,
		[CSTLockedOnDay] int NULL,
		[MostRecentActionLkup] bigint NULL,
		[MostRecentWorkQueueLkup] bigint NULL,
		[MostRecentStatusLkup] bigint NULL,
		[PreviousWorkQueueLkup] bigint NULL,
		[PreviousAuditWorkQueueLkup] bigint NULL,
		[SourceSystemLkup] bigint NULL,
		[SourceSystemId] varchar(20) NULL,
		[DiscrepancySourceLkup] bigint NULL,
		[DiscrepancyReceiptDate] datetime NULL,
		[DiscrepancyReceiptDateId] bigint NULL,
		[ComplianceStartDate] datetime NULL,
		[ComplianceStartDateId] bigint NULL,
		[DisenrollmentDate] Datetime NULL,
		[IsExtendTrackingRequired] bit NULL,
		[Aging] as (datediff(dd,[ComplianceStartDate],getdate())),
		[DiscrepancyStartDate] datetime NULL,
		[DiscrepancyStartDateId] bigint NULL,
		[DiscrepancyEndDate] datetime NULL,
		[DiscrepancyEndDateId] bigint NULL,
		[MemberSCCCode] varchar(50) NULL,
		[PDPAutoEnrolleeInd] bit NULL,
		[ReferencedEligibilityCaseInd] bit NULL,
		[ReferencedSCCCaseInd] bit NULL,
		[FileTypeLkup] bigint NULL,
		[ODMDocID] varchar(20) NULL,
		[ODMAddressLink] VarChar(300) NULL,
		[UndeliveredAddress1] VarChar(100) NULL,
		[UndeliveredAddress2] VarChar(100) NULL,
		[UndeliveredCity] VarChar(50) NULL,
		[UndeliveredState] VarChar(2) NULL,
		[UndeliveredZip] VarChar(10) NULL,
		[COAOldAddress1] VarChar(100) NULL,
		[COAOldAddress2] VarChar(100) NULL,
		[COAOldCity] VarChar(50) NULL,
		[COAOldState] VarChar(2) NULL,
		[COAOldZip] VarChar(10) NULL,
		[COANewAddress1] VarChar(100) NULL,
		[COANewAddress2] VarChar(100) NULL,
		[COANewCity] VarChar(50) NULL,
		[COANewState] VarChar(2) NULL,
		[COANewZip] VarChar(10) NULL,
        [MemberID] varchar(20) NULL,
		[MemberCurrentHICN] varchar(20) NULL,
		[GPSHouseholdID] varchar(20) NULL,
		[MemberFirstName] varchar(35) NULL,
		[MemberMiddleName] varchar(35) NULL,
		[MemberLastName] varchar(35) NULL,
		[MemberContractIDLkup] bigint NULL,
		[MemberPBPLkup] bigint NULL,
		[MemberLOBLkup] bigint NULL,
		[MemberVerifiedState] varchar(5) NULL,
		[MemberVerifiedCountyCode] varchar(3) NULL,
		[MemberDOB] datetime NULL,
		[MemberDOBId] bigint NULL,
		[MemberGenderLkup] bigint NULL,
		[EligGPSContractIDLkup] bigint NULL,
		[EligGPSPBPLkup] bigint NULL,
		[EligGPSSCCCode] varchar(50) NULL,
		[EligGPSCurrentHICN] varchar(20) NULL,
		[EligGPSInsuredPlanEffectiveDate] datetime NULL,
		[EligGPSInsuredPlanEffectiveDateId] bigint NULL,
		[EligGPSInsuredPlanTermDate] datetime NULL,
		[EligGPSInsuredPlanTermDateId] bigint NULL,
		[EligGPSLOBLkup] bigint NULL,
		[EligGPSMemberDOB] datetime NULL,
		[EligGPSMemberDOBId] bigint NULL,
		[EligGPSGenderLkup] bigint NULL,
		[EligMMRContractIDLkup] bigint NULL,
		[EligMMRPBPLkup] bigint NULL,
		[EligMMRSCCCode] varchar(50) NULL,
		[EligMMRCurrentHICN] varchar(20) NULL,
		[EligMMRPaymentAdjustmentStartDate] datetime NULL,
		[EligMMRPaymentAdjustmentStartDateId] bigint NULL,
		[EligMMRPaymentAdjustmentEndDate] datetime NULL,
		[EligMMRPaymentAdjustmentEndDateId] bigint NULL,
		[EligMMRPaymentMonth] datetime NULL,
		[EligMMRDOB] datetime NULL,
		[EligMMRDOBId] bigint NULL,
		[EligMMRGenderLkup] bigint NULL,
		[EligOOAFlagLkup] bit NOT NULL default(0),
		[RPRRequestedEffectiveDate] datetime NULL,
		[RPRRequestedEffectiveDateId] bigint NULL,
		[RPRActionRequestedLkup] bigint NULL,
		[RPROtherActionRequested] varchar(50) NULL,
		[RPRSupervisorOrRequesterRef] bigint NULL,
		[RPRReasonforRequest] VARCHAR(2000) NULL,
		[RPRTaskPerformedLkup] bigint NULL,
		[RPROtherTaskPerformed] varchar(50) NULL,
		[RPRCTMMember] bit NULL default(NULL),
		[RPRCTMNumber] varchar(20) NULL,
		[RPREGHPMember] bit NULL default(NULL),
		[RPREmployerID] varchar(20) NULL,
		[RPRCategoryLkup] bigint NULL,
		[SCCRPRRequested] varchar(50) NULL,
		[SCCRPRRequestedZip] varchar(11) NULL,
		[SCCRPRRequstedSubmissionDate] datetime NULL,
		[SCCRPRRequstedSubmissionDateId] bigint NULL,
		[SCCRPREffectiveStartDate] datetime NULL,
		[SCCRPREffectiveStartDateId] bigint NULL,
		[SCCRPREffectiveEndDate] datetime NULL,
		[SCCRPREffectiveEndDateId] bigint NULL,
		[TRCLkup] bigint NULL,
		[MIIMReferenceId] varchar(10) NULL,
		[IsMARxAddressCompleted] bit NULL,
		[IsAddressScrubCompleted] bit NULL,
		[IsRestricted] bit NULL default(0),
		[OOALetterStatusLkup] bigint NULL,
		[CMSTransactionStatusLkup] bigint NULL,
		[IsCasePended] bit NOT NULL default(0),
		[PendedbyRef] bigint NULL,
		[UTCPendedOn] datetime NULL,
		[UTCPendedOnId] bigint NULL,
		[UTCPendedOnYear] int NULL,
		[UTCPendedOnMonth] int NULL,
		[UTCPendedOnDay] int NULL,
		[CSTPendedOn] datetime NULL,
		[CSTPendedOnId] bigint NULL,
		[CSTPendedOnYear] int NULL,
		[CSTPendedOnMonth] int NULL,
		[CSTPendedOnDay] int NULL,
		[IsCaseResolved] bit NOT NULL default(0),
		[ResolvedByRef] bigint NULL,
		[UTCResolvedOn] datetime NULL,
		[UTCResolvedOnId] bigint NULL,
		[UTCResolvedOnYear] int NULL,
		[UTCResolvedOnMonth] int NULL,
		[UTCResolvedOnDay] int NULL,
		[CSTResolvedOn] datetime NULL,
		[CSTResolvedOnId] bigint NULL,
		[CSTResolvedOnYear] int NULL,
		[CSTResolvedOnMonth] int NULL,
		[CSTResolvedOnDay] int NULL,
		[PeerAuditCompletedDate] datetime NULL,
		[PeerAuditCompletedDateId] bigint NULL,
		[IsParentCase] bit NOT NULL default(0),
		[IsChildCase] bit NOT NULL default(0),
		[ParentQueueRef] bigint NULL,
		[IsActive] bit NOT NULL default(1),
		[UTCCreatedOn] datetime NOT NULL default(getutcdate()),
		[UTCCreatedOnId] bigint NOT NULL,
		[UTCCreatedOnYear] int NOT NULL,
		[UTCCreatedOnMonth] int NOT NULL,
		[UTCCreatedOnDay] int NOT NULL,
		[CSTCreatedOn] datetime NOT NULL,
		[CSTCreatedOnId] bigint NOT NULL,
		[CSTCreatedOnYear] int NOT NULL,
		[CSTCreatedOnMonth] int NOT NULL,
		[CSTCreatedOnDay] int NOT NULL,
		[CreatedByRef] bigint NOT NULL,
		[UTCLastUpdatedOn] datetime NULL,
		[UTCLastUpdatedOnId] bigint NULL,
		[UTCLastUpdatedOnYear] int NULL,
		[UTCLastUpdatedOnMonth] int NULL,
		[UTCLastUpdatedOnDay] int NULL,
		[CSTLastUpdatedOn] datetime NULL,
		[CSTLastUpdatedOnId] bigint NULL,
		[CSTLastUpdatedOnYear] int NULL,
		[CSTLastUpdatedOnMonth] int NULL,
		[CSTLastUpdatedOnDay] int NULL,
		[LastUpdatedByRef] bigint NULL,
		CONSTRAINT [PK_GEN_Queue] PRIMARY KEY CLUSTERED ([GEN_QueueId] ASC)
	)
End
GO


--GEN_OSTActions
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GEN_OSTActions]') AND type in (N'U'))
BEGIN
	CREATE TABLE [dbo].[GEN_OSTActions](
		[GEN_OSTActionsId] bigint IDENTITY(10001,1) NOT NULL,
		[GEN_QueueRef] bigint NOT NULL,
		[ActionLkup] bigint NULL,
		[LastName] varchar(35) NULL,
		[DateofBirth] datetime NULL,
		[ContractIDLkup] bigint NULL,
		[PBPLkup] bigint NULL,
		[ApplicationDate] datetime NULL,
		[EffectiveDate] datetime NULL,
		[EndDate] datetime NULL,
		[FirstLetterMailDate] datetime NULL,
		[FirstLetterMailDateId] bigint NULL,
		[SecondLetterMailDate] datetime NULL,
		[SecondLetterMailDateId] bigint NULL,
		[ResidentialDocumentationRequired] bit NULL default(NULL),
		[CountyAttestationRequired] bit NULL default(NULL),
		[PendReasonLkup] bigint NULL,
		[ContainsErrorsLkup] bigint NULL,
		[ResolutionLkup] bigint NULL,
		[Reason] varchar(20) NULL,
		[InitialAddressVerificationDate] datetime NULL,
		[InitialAddressVerificationDateId] bigint NULL,
		[MemberResponseVerificationDate] datetime NULL,
		[MemberResponseVerificationDateId] bigint NULL,
		[MemberVerifiedState] varchar(5) NULL,
		[SCCLetterMailDate] datetime NULL,
		[SCCLetterMailDateId] bigint NOT NULL,
		[AdjustedDiscrepancyReceiptDate] DATETIME NULL,
		[AdjustedDiscrepancyReceiptDateId] BIGINT NULL,
		[AdjustedComplianceStartDate] DATETIME NULL,
		[AdjustedComplianceStartDateId] BIGINT NULL,
		[PDPAutoEnrolleeInd] bit NULL,
		[MARxAddressResolutionLkup] BIGINT NULL,
		[AdjustedDisenrollmentDate] DATETIME NULL,
		[AdjustedDisenrollmentDateId] BIGINT NULL,
		[IsActive] bit NOT NULL default(1),
		[UTCCreatedOn] datetime NOT NULL default(getutcdate()),
		[CreatedByRef] bigint NOT NULL,
		[UTCLastUpdatedOn] datetime NULL,
		[LastUpdatedByRef] bigint NULL,
		CONSTRAINT [PK_GEN_OSTActions] PRIMARY KEY CLUSTERED ([GEN_OSTActionsId] ASC)
	)
End
GO


--GEN_EligibilityActions
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GEN_EligibilityActions]') AND type in (N'U'))
BEGIN
	CREATE TABLE [dbo].[GEN_EligibilityActions](
		[GEN_EligibilityActionsId] bigint IDENTITY(10001,1) NOT NULL,
		[GEN_QueueRef] bigint NOT NULL,
		[ActionLkup] bigint NULL,
		[HICN] varchar(20) NULL,
		[LastName] varchar(35) NULL,
		[DateofBirth] datetime NULL,
		[ContractIDLkup] bigint NULL,
		[PBPLkup] bigint NULL,
		[TransactionTypeCodeLkup] bigint NULL,
		[ApplicationDate] datetime NULL,
		[ElectionTypeLkup] bigint NULL,
		[EffectiveDate] datetime NULL,
		[ResolutionLkup] bigint NULL,
		[OtherResolution] varchar(35) NULL,
		[RootCauseLkup] bigint NULL,
		[OtherRootCause] VARCHAR(150) NULL,
		[EGHPIndicator] bit NOT NULL default(0),
		[PendReasonLkup] bigint NULL,
		[ContainsErrorsLkup] bigint NULL,
		[FirstLetterMailDate] datetime NULL,
		[FirstLetterMailDateId] bigint NULL,
		[SecondLetterMailDate] datetime NULL,
		[SecondLetterMailDateId] bigint NULL,
		[Reason] varchar(20) NULL,
		[InitialAddressVerificationDate] datetime NULL,
		[InitialAddressVerificationDateId] bigint NULL,
		[MemberResponseVerificationDate] datetime NULL,
		[MemberResponseVerificationDateId] bigint NULL,
		[MemberVerifiedStateLkup] bigint NULL,
		[IsActive] bit NOT NULL default(1),
		[UTCCreatedOn] datetime NOT NULL default(getutcdate()),
		[CreatedByRef] bigint NOT NULL,
		[UTCLastUpdatedOn] datetime NULL,
		[LastUpdatedByRef] bigint NULL,
		CONSTRAINT [PK_GEN_EligibilityActions] PRIMARY KEY CLUSTERED ([GEN_EligibilityActionsId] ASC)
	)
End
GO


--GEN_RPRActions
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GEN_RPRActions]') AND type in (N'U'))
BEGIN
	CREATE TABLE [dbo].[GEN_RPRActions](
		[GEN_RPRActionsId] bigint IDENTITY(10001,1) NOT NULL,
		[GEN_QueueRef] bigint NOT NULL,
		[ActionLkup] bigint NULL,
		[ResolutionLkup] bigint NULL,
		[RootCauseLkup] bigint NULL,
		[PendReasonLkup] bigint NULL,
		[AdjustedCreateDate] datetime NULL,
		[AdjustedCreateDateId] bigint NULL,
		[AdjustedCreateDateReasonLkup] bigint NULL,
		[OtherAdjustedCreateDateReason] varchar(35) NULL,
		[SubmissionTypeLkup] bigint NULL,
		[ContainsErrorsLkup] bigint NULL,
		[RPCSubmissionDate] datetime NULL,
		[RPCSubmissionDateId] bigint NULL,
		[CMSAccountManagerSubmissionDate] datetime NULL,
		[CMSAccountManagerApprovalDate] datetime NULL,
		[CMSAccountManagerApprovalDateId] bigint NULL,
		[FDRStatusLkup] bigint NULL,
		[OtherFDRStatus] varchar(35) NULL,
		[FDRReceivedDate] datetime NULL,
		[FDRReceivedDateId] bigint NULL,
		[FDRCodeReceived] varchar(50) NULL,
		[FDRDescription] varchar(500) NULL,
		[CMSProcessDate] datetime NULL,
		[TransactionType] varchar(50) NULL,
		[FDRRejectionTypeLkup] bigint NULL,
		[ElectionTypeLkup] bigint NULL,
		[LastName] varchar(35) NULL,
		[DateofBirth] datetime NULL,
		[ContractIDLkup] bigint NULL,
		[PBPLkup] bigint NULL,
		[ApplicationDate] datetime NULL,
		[EffectiveDate] datetime NULL,
		[EndDate] datetime NULL,
		[ActualSubmissionDate] datetime NULL,
		[ReasonSubmissionRejected] varchar(4000) NULL,
		[RequestedSCC] varchar(10) NULL,
		[RequestedZIP] varchar(10) NULL,
		[ResubmissionDate] datetime NULL,
		[PotentialSubmissionDate] datetime NULL,
		[PotentialSubmissionDateId] bigint NULL,
		[FDRPackageDate] datetime NULL,
		[FDRPackageDateId] bigint NULL,
		[FDRSubmissionCategoryLkup] bigint NULL,
		[TransactionTypeCodeLkup] BIGINT NULL,
		[ExplanationOfRootCauseLkup] BIGINT NULL,
		[VerifiedRootCauseLkup] BIGINT NULL,
		[PlanError] bit NULL,
		[IsActive] bit NOT NULL default(1),
		[UTCCreatedOn] datetime NOT NULL default(getutcdate()),
		[CreatedByRef] bigint NOT NULL,
		[UTCLastUpdatedOn] datetime NULL,
		[LastUpdatedByRef] bigint NULL,
		CONSTRAINT [PK_GEN_RPRActions] PRIMARY KEY CLUSTERED ([GEN_RPRActionsId] ASC)
	)
End
GO


--GEN_Comments
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GEN_Comments]') AND type in (N'U'))
BEGIN
	CREATE TABLE [dbo].[GEN_Comments](
		[GEN_CommentsId] bigint IDENTITY(10001,1) NOT NULL,
		[GEN_QueueRef] bigint NOT NULL,
		[SourceSystemLkup] bigint NULL,
		[Comments] varchar(4000) NOT NULL,
		[ActionLkup] bigint NOT NULL,
		[IsActive] bit NOT NULL default(1),
		[UTCCreatedOn] datetime NOT NULL default(getutcdate()),
		[CreatedByRef] bigint NOT NULL,
		[UTCLastUpdatedOn] datetime NULL,
		[LastUpdatedByRef] bigint NULL,
		CONSTRAINT [PK_GEN_Comments] PRIMARY KEY CLUSTERED ([GEN_CommentsId] ASC)
	)
End
GO


--GEN_Attachments
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GEN_Attachments]') AND type in (N'U'))
BEGIN
	CREATE TABLE [dbo].[GEN_Attachments](
		[GEN_AttachmentsId] bigint IDENTITY(10001,1) NOT NULL,
		[GEN_QueueRef] bigint NOT NULL,
		[UploadedFileName] varchar(200) NULL,
		[FileName] varchar(200) NULL,
		[FilePath] varchar(500) NULL,
		[GEN_DMSDataRef] bigint NULL,
		[IsActive] bit NOT NULL default(1),
		[UTCCreatedOn] datetime NOT NULL default(getutcdate()),
		[CreatedByRef] bigint NOT NULL,
		[UTCLastUpdatedOn] datetime NULL,
		[LastUpdatedByRef] bigint NULL,
		CONSTRAINT [PK_GEN_Attachments] PRIMARY KEY CLUSTERED ([GEN_AttachmentsId] ASC)
	)
End
GO


--GEN_DMSData
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GEN_DMSData]') AND type in (N'U'))
BEGIN
	CREATE TABLE [dbo].[GEN_DMSData](
		[GEN_DMSDataId] bigint IDENTITY(10001,1) NOT NULL,
		[GEN_QueueRef] bigint NOT NULL,
		[DMSDocId] varchar(20) NULL,
		[DMSFileName] varchar(200) NULL,
		[DMSFilePath] varchar(500) NULL,
		[DMSUrl] varchar(500) NULL,
		[IsActive] bit NOT NULL default(1),
		[UTCCreatedOn] datetime NOT NULL default(getutcdate()),
		[CreatedByRef] bigint NOT NULL,
		[UTCLastUpdatedOn] datetime NULL,
		[LastUpdatedByRef] bigint NULL,
		CONSTRAINT [PK_GEN_DMSData] PRIMARY KEY CLUSTERED ([GEN_DMSDataId] ASC)
	)
End
GO


--GEN_ManageCases
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GEN_ManageCases]') AND type in (N'U'))
BEGIN
	CREATE TABLE [dbo].[GEN_ManageCases](
		[GEN_ManageCasesId] bigint IDENTITY(10001,1) NOT NULL,
		[GEN_QueueRef] bigint NOT NULL,
		[ActionPerformedLkup] bigint NOT NULL,
		[CurrentUserRef] bigint NOT NULL,
		[CasesComments] varchar(4000) NULL,
		[ReAssignUserRef] bigint NULL,
		[IsActive] bit NOT NULL default(1),
		[UTCCreatedOn] datetime NOT NULL default(getutcdate()),
		[CreatedByRef] bigint NOT NULL,
		[UTCLastUpdatedOn] datetime NULL,
		[LastUpdatedByRef] bigint NULL,
		CONSTRAINT [PK_GEN_ManageCases] PRIMARY KEY CLUSTERED ([GEN_ManageCasesId] ASC)
	)
End
GO


--[GEN_AEGPSServiceTrace]
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GEN_AEGPSServiceTrace]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[GEN_AEGPSServiceTrace](
	[GEN_AEGPSServiceTraceId] [bigint] IDENTITY(10001,1) NOT NULL,
	[GEN_QueueRef] [bigint] NOT NULL,
	[WebServiceMethodLkup] [bigint] NULL,
	[RequestData] [varchar](4000) NULL,
	[ResponseData] [varchar](4000) NULL,
	[WebServiceMethodName] [varchar](1000) NOT NULL,
	[Statuslkup] [bigint] NOT NULL DEFAULT (46001),
	[IsActive] [bit] NOT NULL DEFAULT (1),
	[UTCCreatedOn] [datetime] NOT NULL DEFAULT (getutcdate()),
	[CreatedByRef] [bigint] NOT NULL,
	[UTCLastUpdatedOn] [datetime] NULL,
	[LastUpdatedByRef] [bigint] NULL
) ON [PRIMARY]
End
GO


--GEN_QueueWorkFlowCorrelation
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GEN_QueueWorkFlowCorrelation]') AND type in (N'U'))
BEGIN
	CREATE TABLE [dbo].[GEN_QueueWorkFlowCorrelation](
		[GEN_QueueWorkFlowCorrelationId] bigint IDENTITY(10001,1) NOT NULL,
		[GEN_QueueRef] bigint NOT NULL,
		[RoleLkup] bigint NOT NULL,
		[GEN_WorkFlowMasterRef] BIGINT NULL,
		[WorkBasketLkup] bigint NOT NULL,
		[DiscrepancyCategoryLkup] bigint NOT NULL,
		[PreviousActionLkup] bigint NULL,
		[PreviousWorkQueuesLkup] bigint NULL,
		[PreviousStatusLkup] bigint NULL,
		[CurrentActionLkup] bigint NULL,
		[CurrentWorkQueuesLkup] bigint NULL,
		[CurrentStatusLkup] bigint NULL,
		[IsActive] bit NOT NULL default(1),
		[UTCCreatedOn] datetime NOT NULL default(getutcdate()),
		[CreatedByRef] bigint NOT NULL,
		CONSTRAINT [PK_GEN_QueueWorkFlowCorrelation] PRIMARY KEY CLUSTERED ([GEN_QueueWorkFlowCorrelationId] ASC)
	)
End
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GEN_WorkFlowMaster]') AND type in (N'U'))
BEGIN
	CREATE TABLE [dbo].[GEN_WorkFlowMaster](
		[GEN_WorkFlowMasterId] bigint IDENTITY(1,1) NOT NULL,
		[WorkBasketLkup] bigint NOT NULL,
		[DiscrepancyCategoryLkup] bigint NOT NULL,
		[CurrentWorkQueueLkup] bigint NULL,
		[CurrentActionLkup] bigint NULL,
		[NextWorkQueueLkup] bigint NULL,
		[NextStatusLkup] bigint NULL,
		[IsActive] bit NOT NULL default(1),
		[UTCCreatedOn] datetime NOT NULL default(getutcdate()),
		[CreatedByRef] bigint NOT NULL default(1),
		CONSTRAINT [PK_GEN_WorkFlowMasterI] PRIMARY KEY CLUSTERED ([GEN_WorkFlowMasterId] ASC)
	)
End
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GEN_BulkImportExcelTemplateMaster]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[GEN_BulkImportExcelTemplateMaster](
	[GEN_BulkImportExcelTemplateMasterId]	BIGINT	IDENTITY(1,1) NOT NULL,
	[WorkBasketLkup]	BIGINT NULL,
	[DiscrepancyCategoryLkup]	BIGINT NULL,
	[ExcelTemplateName]	VARCHAR(250) NULL,
	[ExcelTemplateDescription]	VARCHAR(250) NULL,
	[SheetName]	VARCHAR(250) NULL,
	[StartRow]	INT NULL,
	[StartColumn]	INT NULL,
	[ExcelDirectoryPath]	VARCHAR(2000) NULL,
	[IsActive] 	BIT NULL,
	[CustomValidationSP]	VARCHAR(250) NULL,
	[StagingTableName]	VARCHAR(250) NULL,
	[StagingInsertSPName]	VARCHAR(250) NULL,
	[StagingUpdateSPName]	VARCHAR(250) NULL,
	[StagingInsertTVPName]	VARCHAR(250) NULL,
	[StagingUpdateTVPName]	VARCHAR(250) NULL,
	[UTCCreatedOn] 	DATETIME NULL,
	[CreatedByRef]	BIGINT NULL,
	[UTCLastUpdatedOn] 	DATETIME NULL,
	[LastUpdatedByRef]	BIGINT NULL,
	CONSTRAINT [PK_GEN_BulkImportExcelTemplateMaster] PRIMARY KEY CLUSTERED ([GEN_BulkImportExcelTemplateMasterId] ASC)
)
END
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GEN_BulkImportColumnsMapping]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[GEN_BulkImportColumnsMapping](
[GEN_BulkImportColumnsMappingId] 	BIGINT	IDENTITY(1,1) NOT NULL,
[GEN_BulkImportColumnsMappingParentRef]	BIGINT NULL,
[GEN_BulkImportExcelTemplateMasterRef]	BIGINT NULL,
[ColumnTypeLkup]	BIGINT NULL,
[DBColumnName]	VARCHAR(250) NULL,
[ColumnDisplayName]	VARCHAR(250) NULL,
[MaxLength]	INT NULL,
[ColumnSequence]	INT NULL,
[ControlTypeLkup]	BIGINT NULL,
[ControlLkupValue]	BIGINT NULL,
[IsUniqueKey] 	BIT NULL,
[IsActive] 	BIT NULL,
[UTCCreatedOn] 	DATETIME NULL,
[CreatedByRef] 	BIGINT NULL,
[UTCLastUpdatedOn] 	DATETIME NULL,
[LastUpdatedByRef] 	BIGINT NULL,
CONSTRAINT [PK_GEN_BulkImportColumnsMapping] PRIMARY KEY CLUSTERED ([GEN_BulkImportColumnsMappingId] ASC)
)
END
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GEN_BulkImport]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[GEN_BulkImport](
[GEN_BulkImportId] BIGINT	IDENTITY(10001,1) NOT NULL,
[WorkBasketLkup]	BIGINT NULL,
[DiscrepancyCategoryLkup]	BIGINT NULL,
[GEN_BulkImportExcelTemplateMasterRef]	BIGINT NULL,
[LockedByRef]	BIGINT NULL,
[UTCLockedOn] 	DATETIME NULL,
[ExcelFileName] 	VARCHAR(250) NULL,
[DuplicateFileName]	VARCHAR(250) NULL,
[ExcelFilelPath]	VARCHAR(2000) NULL,
[TotalRecordsCount] 	INT NULL,
[ValidRecordsCount]	INT NULL,
[InvalidRecordsCount] 	INT NULL,
[DuplicateRecordCount]	INT NULL,
[ErrorDescription] 	VARCHAR(2000) NULL,
[ExcelStatusLkup] 	BIGINT NULL,
[ImportStatusLkup] 	BIGINT NULL,
[CMN_AppErrorLogRef] 	BIGINT NULL,
[IsActive] 	BIT NULL,
[UTCCreatedOn] 	DATETIME NULL,
[CreatedByRef]	BIGINT NULL,
[UTCLastUpdatedOn] 	DATETIME NULL,
[LastUpdatedByRef]	BIGINT NULL,
CONSTRAINT [PK_GEN_BulkImport] PRIMARY KEY CLUSTERED ([GEN_BulkImportId] ASC)
)
END
GO

---------------------------------------------------------------------------------------------------------------------------

--GEN_QueueHistory
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GEN_QueueHistory]') AND type in (N'U'))
BEGIN
	
CREATE TABLE [dbo].[GEN_QueueHistory](
		[GEN_QueueHistoryId] bigint IDENTITY(10001,1) NOT NULL,
		[GEN_QueueRef] bigint NOT NULL,
		[BusinessSegmentLkup] bigint NOT NULL,
 		[WorkBasketLkup] bigint NOT NULL,
		[DiscrepancyCategoryLkup] bigint NOT NULL,
		[DiscrepancyTypeLkup] bigint NOT NULL,
		[StartDate] datetime NULL,
		[StartDateId] bigint NULL,
		[EndDate] datetime NULL,
		[EndDateId] bigint NULL,
		[AssignedToRef] bigint NULL,
		[UTCAssignedOn] datetime NULL,
		[UTCAssignedOnId] bigint NULL,
		[UTCAssignedOnYear] int NULL,
		[UTCAssignedOnMonth] int NULL,
		[UTCAssignedOnDay] int NULL,
		[CSTAssignedOn] datetime NULL,
		[CSTAssignedOnId] bigint NULL,
		[CSTAssignedOnYear] int NULL,
		[CSTAssignedOnMonth] int NULL,
		[CSTAssignedOnDay] int NULL,
		[PreviousAssignedToRef] bigint NULL,
		[LockedByRef] bigint NULL,
		[UTCLockedOn] datetime NULL,
		[UTCLockedOnId] bigint NULL,
		[UTCLockedOnYear] int NULL,
		[UTCLockedOnMonth] int NULL,
		[UTCLockedOnDay] int NULL,
		[CSTLockedOn] datetime NULL,
		[CSTLockedOnId] bigint NULL,
		[CSTLockedOnYear] int NULL,
		[CSTLockedOnMonth] int NULL,
		[CSTLockedOnDay] int NULL,
		[MostRecentActionLkup] bigint NULL,
		[MostRecentWorkQueueLkup] bigint NULL,
		[MostRecentStatusLkup] bigint NULL,
		[PreviousWorkQueueLkup] bigint NULL,
		[PreviousAuditWorkQueueLkup] bigint NULL,
		[SourceSystemLkup] bigint NULL,
		[SourceSystemId] varchar(20) NULL,
		[DiscrepancySourceLkup] bigint NULL,
		[DiscrepancyReceiptDate] datetime NULL,
		[DiscrepancyReceiptDateId] bigint NULL,
		[ComplianceStartDate] datetime NULL,
		[ComplianceStartDateId] bigint NULL,
		[DisenrollmentDate] Datetime NULL,
		[IsExtendTrackingRequired] bit NULL,
		[Aging] bigint NULL,
		[DiscrepancyStartDate] datetime NULL,
		[DiscrepancyStartDateId] bigint NULL,
		[DiscrepancyEndDate] datetime NULL,
		[DiscrepancyEndDateId] bigint NULL,
		[MemberSCCCode] varchar(50) NULL,
		[PDPAutoEnrolleeInd] bit NULL,
		[ReferencedEligibilityCaseInd] bit NULL,
		[ReferencedSCCCaseInd] bit NULL,
		[FileTypeLkup] bigint NULL,
		[ODMDocID] varchar(20) NULL,
		[ODMAddressLink] VarChar(300) NULL,
		[UndeliveredAddress1] VarChar(100) NULL,
		[UndeliveredAddress2] VarChar(100) NULL,
		[UndeliveredCity] VarChar(50) NULL,
		[UndeliveredState] VarChar(2) NULL,
		[UndeliveredZip] VarChar(10) NULL,
		[COAOldAddress1] VarChar(100) NULL,
		[COAOldAddress2] VarChar(100) NULL,
		[COAOldCity] VarChar(50) NULL,
		[COAOldState] VarChar(2) NULL,
		[COAOldZip] VarChar(10) NULL,
		[COANewAddress1] VarChar(100) NULL,
		[COANewAddress2] VarChar(100) NULL,
		[COANewCity] VarChar(50) NULL,
		[COANewState] VarChar(2) NULL,
		[COANewZip] VarChar(10) NULL,
        [MemberID] varchar(20) NULL,
		[MemberCurrentHICN] varchar(20) NULL,
		[GPSHouseholdID] varchar(20) NULL,
		[MemberFirstName] varchar(35) NULL,
		[MemberMiddleName] varchar(35) NULL,
		[MemberLastName] varchar(35) NULL,
		[MemberContractIDLkup] bigint NULL,
		[MemberPBPLkup] bigint NULL,
		[MemberLOBLkup] bigint NULL,
		[MemberVerifiedState] varchar(5) NULL,
		[MemberVerifiedCountyCode] varchar(3) NULL,
		[MemberDOB] datetime NULL,
		[MemberDOBId] bigint NULL,
		[MemberGenderLkup] bigint NULL,
		[EligGPSContractIDLkup] bigint NULL,
		[EligGPSPBPLkup] bigint NULL,
		[EligGPSSCCCode] varchar(50) NULL,
		[EligGPSCurrentHICN] varchar(20) NULL,
		[EligGPSInsuredPlanEffectiveDate] datetime NULL,
		[EligGPSInsuredPlanEffectiveDateId] bigint NULL,
		[EligGPSInsuredPlanTermDate] datetime NULL,
		[EligGPSInsuredPlanTermDateId] bigint NULL,
		[EligGPSLOBLkup] bigint NULL,
		[EligGPSMemberDOB] datetime NULL,
		[EligGPSMemberDOBId] bigint NULL,
		[EligGPSGenderLkup] bigint NULL,
		[EligMMRContractIDLkup] bigint NULL,
		[EligMMRPBPLkup] bigint NULL,
		[EligMMRSCCCode] varchar(50) NULL,
		[EligMMRCurrentHICN] varchar(20) NULL,
		[EligMMRPaymentAdjustmentStartDate] datetime NULL,
		[EligMMRPaymentAdjustmentStartDateId] bigint NULL,
		[EligMMRPaymentAdjustmentEndDate] datetime NULL,
		[EligMMRPaymentAdjustmentEndDateId] bigint NULL,
		[EligMMRPaymentMonth] datetime NULL,
		[EligMMRDOB] datetime NULL,
		[EligMMRDOBId] bigint NULL,
		[EligMMRGenderLkup] bigint NULL,
		[EligOOAFlagLkup] bit NOT NULL default(0),
		[RPRRequestedEffectiveDate] datetime NULL,
		[RPRRequestedEffectiveDateId] bigint NULL,
		[RPRActionRequestedLkup] bigint NULL,
		[RPROtherActionRequested] varchar(50) NULL,
		[RPRSupervisorOrRequesterRef] bigint NULL,
		[RPRReasonforRequest] VARCHAR(2000) NULL,
		[RPRTaskPerformedLkup] bigint NULL,
		[RPROtherTaskPerformed] varchar(50) NULL,
		[RPRCTMMember] bit NULL,
		[RPRCTMNumber] varchar(20) NULL,
		[RPREGHPMember] bit NULL,
		[RPREmployerID] varchar(20) NULL,
		[RPRCategoryLkup] bigint NULL,
		[SCCRPRRequested] varchar(50) NULL,
		[SCCRPRRequestedZip] varchar(11) NULL,
		[SCCRPRRequstedSubmissionDate] datetime NULL,
		[SCCRPRRequstedSubmissionDateId] bigint NULL,
		[SCCRPREffectiveStartDate] datetime NULL,
		[SCCRPREffectiveStartDateId] bigint NULL,
		[SCCRPREffectiveEndDate] datetime NULL,
		[SCCRPREffectiveEndDateId] bigint NULL,
		[TRCLkup] bigint NULL,
		[MIIMReferenceId] varchar(10) NULL,
		[IsMARxAddressCompleted] bit NULL,
		[IsAddressScrubCompleted] bit NULL,
		[IsRestricted] bit NULL default(0),
		[OOALetterStatusLkup] bigint NULL,
		[IsCasePended] bit NOT NULL default(0),
		[PendedbyRef] bigint NULL,
		[UTCPendedOn] datetime NULL,
		[UTCPendedOnId] bigint NULL,
		[UTCPendedOnYear] int NULL,
		[UTCPendedOnMonth] int NULL,
		[UTCPendedOnDay] int NULL,
		[CSTPendedOn] datetime NULL,
		[CSTPendedOnId] bigint NULL,
		[CSTPendedOnYear] int NULL,
		[CSTPendedOnMonth] int NULL,
		[CSTPendedOnDay] int NULL,
		[IsCaseResolved] bit NOT NULL default(0),
		[ResolvedByRef] bigint NULL,
		[UTCResolvedOn] datetime NULL,
		[UTCResolvedOnId] bigint NULL,
		[UTCResolvedOnYear] int NULL,
		[UTCResolvedOnMonth] int NULL,
		[UTCResolvedOnDay] int NULL,
		[CSTResolvedOn] datetime NULL,
		[CSTResolvedOnId] bigint NULL,
		[CSTResolvedOnYear] int NULL,
		[CSTResolvedOnMonth] int NULL,
		[CSTResolvedOnDay] int NULL,
		[PeerAuditCompletedDate] datetime NULL,
		[PeerAuditCompletedDateId] bigint NULL,
		[IsParentCase] bit NOT NULL default(0),
		[IsChildCase] bit NOT NULL default(0),
		[ParentQueueRef] bigint NULL,
		[IsActive] bit NOT NULL default(1),
		[UTCCreatedOn] datetime NOT NULL default(getutcdate()),
		[UTCCreatedOnId] bigint NOT NULL,
		[UTCCreatedOnYear] int NOT NULL,
		[UTCCreatedOnMonth] int NOT NULL,
		[UTCCreatedOnDay] int NOT NULL,
		[CSTCreatedOn] datetime NOT NULL,
		[CSTCreatedOnId] bigint NOT NULL,
		[CSTCreatedOnYear] int NOT NULL,
		[CSTCreatedOnMonth] int NOT NULL,
		[CSTCreatedOnDay] int NOT NULL,
		[CreatedByRef] bigint NOT NULL,
		[UTCLastUpdatedOn] datetime NULL,
		[UTCLastUpdatedOnId] bigint NULL,
		[UTCLastUpdatedOnYear] int NULL,
		[UTCLastUpdatedOnMonth] int NULL,
		[UTCLastUpdatedOnDay] int NULL,
		[CSTLastUpdatedOn] datetime NULL,
		[CSTLastUpdatedOnId] bigint NULL,
		[CSTLastUpdatedOnYear] int NULL,
		[CSTLastUpdatedOnMonth] int NULL,
		[CSTLastUpdatedOnDay] int NULL,
		[LastUpdatedByRef] bigint NULL,
		[UTCHistoryCreatedOn] datetime NOT NULL default(getutcdate()),
		[HistoryCreatedByRef] bigint NOT NULL,
		[GEN_ManageCasesRef] bigint NOT NULL,
		CONSTRAINT [PK_GEN_QueueHistory] PRIMARY KEY CLUSTERED ([GEN_QueueHistoryId] ASC)
	)

End
GO


--GEN_OSTActionsHistory
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GEN_OSTActionsHistory]') AND type in (N'U'))
BEGIN
	CREATE TABLE [dbo].[GEN_OSTActionsHistory](
		[GEN_OSTActionsHistoryId] bigint IDENTITY(10001,1) NOT NULL,
		[GEN_OSTActionsRef] bigint NOT NULL,
		[GEN_QueueRef] bigint NOT NULL,
		[ActionLkup] bigint NULL,
		[LastName] varchar(35) NULL,
		[DateofBirth] datetime NULL,
		[ContractIDLkup] bigint NULL,
		[PBPLkup] bigint NULL,
		[ApplicationDate] datetime NULL,
		[EffectiveDate] datetime NULL,
		[EndDate] datetime NULL,
		[FirstLetterMailDate] datetime NULL,
		[FirstLetterMailDateId] bigint NULL,		
		[SecondLetterMailDate] datetime NULL,
		[SecondLetterMailDateId] bigint NULL,
		[ResidentialDocumentationRequired] bit NULL,
		[CountyAttestationRequired] bit NULL,
		[PendReasonLkup] bigint NULL,
		[ContainsErrorsLkup] bigint NULL,
		[ResolutionLkup] bigint NULL,
		[Reason] varchar(20) NULL,
		[InitialAddressVerificationDate] datetime NULL,
		[InitialAddressVerificationDateId] bigint NULL,
		[MemberResponseVerificationDate] datetime NULL,
		[MemberResponseVerificationDateId] bigint NULL,
		[MemberVerifiedState] varchar(5) NULL,
		[SCCLetterMailDate] datetime NULL,
		[SCCLetterMailDateId] bigint NOT NULL,
		[AdjustedDiscrepancyReceiptDate] DATETIME NULL,
		[AdjustedDiscrepancyReceiptDateId] BIGINT NULL,
		[AdjustedComplianceStartDate] DATETIME NULL,
		[AdjustedComplianceStartDateId] BIGINT NULL,
		[PDPAutoEnrolleeInd] bit NULL,
		[MARxAddressResolutionLkup] BIGINT NULL,
		[AdjustedDisenrollmentDate] DATETIME NULL,
		[AdjustedDisenrollmentDateId] BIGINT NULL,
		[IsActive] bit NOT NULL,
		[UTCCreatedOn] datetime NOT NULL,
		[CreatedByRef] bigint NOT NULL,
		[UTCLastUpdatedOn] datetime NULL,
		[LastUpdatedByRef] bigint NULL,
		[UTCHistoryCreatedOn] datetime NOT NULL default(getutcdate()),
		[HistoryCreatedByRef] bigint NOT NULL,
		[GEN_ManageCasesRef] bigint NOT NULL,
		CONSTRAINT [PK_GEN_OSTActionsHistory] PRIMARY KEY CLUSTERED ([GEN_OSTActionsHistoryId] ASC)
	)
End
GO


--GEN_EligibilityActionsHistory
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GEN_EligibilityActionsHistory]') AND type in (N'U'))
BEGIN
	CREATE TABLE [dbo].[GEN_EligibilityActionsHistory](
		[GEN_EligibilityActionsHistoryId] bigint IDENTITY(10001,1) NOT NULL,
		[GEN_EligibilityActionsRef] bigint NOT NULL,
		[GEN_QueueRef] bigint NOT NULL,
		[ActionLkup] bigint NULL,
		[HICN] varchar(20) NULL,
		[LastName] varchar(35) NULL,
		[DateofBirth] datetime NULL,
		[ContractIDLkup] bigint NULL,
		[PBPLkup] bigint NULL,
		[TransactionTypeCodeLkup] bigint NULL,
		[ApplicationDate] datetime NULL,
		[ElectionTypeLkup] bigint NULL,
		[EffectiveDate] datetime NULL,
		[ResolutionLkup] bigint NULL,
		[OtherResolution] varchar(35) NULL,
		[RootCauseLkup] bigint NULL,
		[OtherRootCause] VARCHAR(150) NULL,
		[EGHPIndicator] bit NOT NULL,
		[PendReasonLkup] bigint NULL,
		[ContainsErrorsLkup] bigint NULL,
		[FirstLetterMailDate] datetime NULL,
		[FirstLetterMailDateId] bigint NULL,
		[SecondLetterMailDate] datetime NULL,
		[SecondLetterMailDateId] bigint NULL,
		[Reason] varchar(20) NULL,
		[InitialAddressVerificationDate] datetime NULL,
		[InitialAddressVerificationDateId] bigint NULL,
		[MemberResponseVerificationDate] datetime NULL,
		[MemberResponseVerificationDateId] bigint NULL,
		[MemberVerifiedStateLkup] bigint NULL,
		[IsActive] bit NOT NULL,
		[UTCCreatedOn] datetime NOT NULL,
		[CreatedByRef] bigint NOT NULL,
		[UTCLastUpdatedOn] datetime NULL,
		[LastUpdatedByRef] bigint NULL,
		[UTCHistoryCreatedOn] datetime NOT NULL default(getutcdate()),
		[HistoryCreatedByRef] bigint NOT NULL,
		[GEN_ManageCasesRef] bigint NOT NULL,
		CONSTRAINT [PK_GEN_EligibilityActionsHistory] PRIMARY KEY CLUSTERED ([GEN_EligibilityActionsHistoryId] ASC)
	)
End
GO


--GEN_RPRActionsHistory
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GEN_RPRActionsHistory]') AND type in (N'U'))
BEGIN
	CREATE TABLE [dbo].[GEN_RPRActionsHistory](
		[GEN_RPRActionsHistoryId] bigint IDENTITY(10001,1) NOT NULL,
		[GEN_RPRActionsRef] bigint NOT NULL,
		[GEN_QueueRef] bigint NOT NULL,
		[ActionLkup] bigint NULL,
		[ResolutionLkup] bigint NULL,
		[RootCauseLkup] bigint NULL,
		[PendReasonLkup] bigint NULL,
		[AdjustedCreateDate] datetime NULL,
		[AdjustedCreateDateId] bigint NULL,
		[AdjustedCreateDateReasonLkup] bigint NULL,
		[OtherAdjustedCreateDateReason] varchar(35) NULL,
		[SubmissionTypeLkup] bigint NULL,
		[ContainsErrorsLkup] bigint NULL,
		[RPCSubmissionDate] datetime NULL,
		[RPCSubmissionDateId] bigint NULL,
		[CMSAccountManagerSubmissionDate] datetime NULL,
		[CMSAccountManagerApprovalDate] datetime NULL,
		[CMSAccountManagerApprovalDateId] bigint NULL,
		[FDRStatusLkup] bigint NULL,
		[OtherFDRStatus] varchar(35) NULL,
		[FDRReceivedDate] datetime NULL,
		[FDRReceivedDateId] bigint NULL,
		[FDRCodeReceived] varchar(50) NULL,
		[FDRDescription] varchar(500) NULL,
		[CMSProcessDate] datetime NULL,
		[TransactionType] varchar(50) NULL,
		[FDRRejectionTypeLkup] bigint NULL,
		[ElectionTypeLkup] bigint NULL,
		[LastName] varchar(35) NULL,
		[DateofBirth] datetime NULL,
		[ContractIDLkup] bigint NULL,
		[PBPLkup] bigint NULL,
		[ApplicationDate] datetime NULL,
		[EffectiveDate] datetime NULL,
		[EndDate] datetime NULL,
		[ActualSubmissionDate] datetime NULL,
		[ReasonSubmissionRejected] varchar(4000) NULL,
		[RequestedSCC] varchar(10) NULL,
		[RequestedZIP] varchar(10) NULL,
		[ResubmissionDate] datetime NULL,
		[PotentialSubmissionDate] datetime NULL,
		[PotentialSubmissionDateId] bigint NULL,
		[FDRPackageDate] datetime NULL,
		[FDRPackageDateId] bigint NULL,
		[FDRSubmissionCategoryLkup] bigint NULL,
		[TransactionTypeCodeLkup] BIGINT NULL,
		[ExplanationOfRootCauseLkup] BIGINT NULL,
		[VerifiedRootCauseLkup] BIGINT NULL,
		[PlanError] bit NULL,
		[IsActive] bit NOT NULL,
		[UTCCreatedOn] datetime NOT NULL,
		[CreatedByRef] bigint NOT NULL,
		[UTCLastUpdatedOn] datetime NULL,
		[LastUpdatedByRef] bigint NULL,
		[UTCHistoryCreatedOn] datetime NOT NULL default(getutcdate()),
		[HistoryCreatedByRef] bigint NOT NULL,
		[GEN_ManageCasesRef] bigint NOT NULL,
		CONSTRAINT [PK_GEN_RPRActionsHistory] PRIMARY KEY CLUSTERED ([GEN_RPRActionsHistoryId] ASC)
	)
End
GO


--GEN_AttachmentsHistory
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GEN_AttachmentsHistory]') AND type in (N'U'))
BEGIN
	CREATE TABLE [dbo].[GEN_AttachmentsHistory](
		[GEN_AttachmentsHistoryId] bigint IDENTITY(10001,1) NOT NULL,
		[GEN_AttachmentsRef] bigint NOT NULL,
		[GEN_QueueRef] bigint NOT NULL,
		[UploadedFileName] varchar(200) NULL,
		[FileName] varchar(200) NULL,
		[FilePath] varchar(500) NULL,
		[GEN_DMSDataRef] bigint NULL,
		[IsActive] bit NOT NULL,
		[UTCCreatedOn] datetime NOT NULL,
		[CreatedByRef] bigint NOT NULL,
		[UTCLastUpdatedOn] datetime NULL,
		[LastUpdatedByRef] bigint NULL,
		[UTCHistoryCreatedOn] datetime NOT NULL default(getutcdate()),
		[HistoryCreatedByRef] bigint NOT NULL,
		[GEN_ManageCasesRef] bigint NOT NULL,
		CONSTRAINT [PK_GEN_AttachmentsHistory] PRIMARY KEY CLUSTERED ([GEN_AttachmentsHistoryId] ASC)
	)
End
GO


--GEN_DMSDataHistory
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GEN_DMSDataHistory]') AND type in (N'U'))
BEGIN
	CREATE TABLE [dbo].[GEN_DMSDataHistory](
		[GEN_DMSDataHistoryId] bigint IDENTITY(10001,1) NOT NULL,
		[GEN_DMSDataRef] bigint NOT NULL,
		[GEN_QueueRef] bigint NOT NULL,
		[DMSDocId] varchar(20) NULL,
		[DMSFileName] varchar(200) NULL,
		[DMSFilePath] varchar(500) NULL,
		[DMSUrl] varchar(500) NULL,
		[IsActive] bit NOT NULL,
		[UTCCreatedOn] datetime NOT NULL,
		[CreatedByRef] bigint NOT NULL,
		[UTCLastUpdatedOn] datetime NULL,
		[LastUpdatedByRef] bigint NULL,
		[UTCHistoryCreatedOn] datetime NOT NULL default(getutcdate()),
		[HistoryCreatedByRef] bigint NOT NULL,
		[GEN_ManageCasesRef] bigint NOT NULL,
		CONSTRAINT [PK_GEN_DMSDataHistory] PRIMARY KEY CLUSTERED ([GEN_DMSDataHistoryId] ASC)
	)
End
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GEN_AEGPSServiceTraceHistory]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[GEN_AEGPSServiceTraceHistory](
	[GEN_AEGPSServiceTraceHistoryId] [bigint] IDENTITY(10001,1) NOT NULL,
	[GEN_AEGPSServiceTraceRef] [bigint] NOT NULL,
	[GEN_QueueRef] [bigint] NOT NULL,
	[WebServiceMethodLkup] [bigint] NULL,
	[RequestData] [varchar](4000) NULL,
	[ResponseData] [varchar](4000) NULL,
	[WebServiceMethodName] [varchar](1000) NOT NULL,
	[Statuslkup] [bigint] NOT NULL DEFAULT (46001),
	[IsActive] [bit] NOT NULL DEFAULT (1),
	[UTCCreatedOn] [datetime] NOT NULL DEFAULT (getutcdate()),
	[CreatedByRef] [bigint] NOT NULL,
	[UTCLastUpdatedOn] [datetime] NULL,
	[LastUpdatedByRef] [bigint] NULL,
	[UTCHistoryCreatedOn] datetime NOT NULL default(getutcdate()),
	[HistoryCreatedByRef] bigint NOT NULL,
	[GEN_ManageCasesRef] bigint NOT NULL,
	CONSTRAINT [PK_GEN_AEGPSServiceTraceHistory] PRIMARY KEY CLUSTERED ([GEN_AEGPSServiceTraceHistoryId] ASC)
)
End
GO


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GEN_BulkImportExcelTemplateMasterHistory]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[GEN_BulkImportExcelTemplateMasterHistory](
	[GEN_BulkImportExcelTemplateMasterHistoryId] BIGINT	IDENTITY(1,1) NOT NULL,
	[GEN_BulkImportExcelTemplateMasterRef] BIGINT NOT NULL,
	[WorkBasketLkup]	BIGINT NULL,
	[DiscrepancyCategoryLkup]	BIGINT NULL,
	[ExcelTemplateName]	VARCHAR(250) NULL,
	[ExcelTemplateDescription]	VARCHAR(250) NULL,
	[SheetName]	VARCHAR(250) NULL,
	[StartRow]	INT NULL,
	[StartColumn]	INT NULL,
	[ExcelDirectoryPath]	VARCHAR(2000) NULL,
	[IsActive] 	BIT NULL,
	[CustomValidationSP]	VARCHAR(250) NULL,
	[StagingTableName]	VARCHAR(250) NULL,
	[StagingInsertSPName]	VARCHAR(250) NULL,
	[StagingUpdateSPName]	VARCHAR(250) NULL,
	[StagingInsertTVPName]	VARCHAR(250) NULL,
	[StagingUpdateTVPName]	VARCHAR(250) NULL,
	[UTCCreatedOn] 	DATETIME NULL,
	[CreatedByRef]	BIGINT NULL,
	[UTCLastUpdatedOn] 	DATETIME NULL,
	[LastUpdatedByRef]	BIGINT NULL,
	[UTCHistoryCreatedOn] DATETIME NOT NULL default(getutcdate()),
	[HistoryCreatedByRef] BIGINT NOT NULL,
	CONSTRAINT [PK_GEN_BulkImportExcelTemplateMasterHistory] PRIMARY KEY CLUSTERED ([GEN_BulkImportExcelTemplateMasterHistoryId] ASC)
)
END
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GEN_BulkImportColumnsMappingHistory]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[GEN_BulkImportColumnsMappingHistory](
[GEN_BulkImportColumnsMappingHistoryId]	BIGINT	IDENTITY(1,1) NOT NULL,
[GEN_BulkImportColumnsMappingRef] BIGINT NOT NULL,
[GEN_BulkImportColumnsMappingParentRef]	BIGINT NULL,
[GEN_BulkImportExcelTemplateMasterRef]	BIGINT NULL,
[ColumnTypeLkup]	BIGINT NULL,
[DBColumnName]	VARCHAR(250) NULL,
[ColumnDisplayName]	VARCHAR(250) NULL,
[MaxLength]	INT NULL,
[ColumnSequence]	INT NULL,
[ControlTypeLkup]	BIGINT NULL,
[ControlLkupValue]	BIGINT NULL,
[IsUniqueKey] 	BIT NULL,
[IsActive] 	BIT NULL,
[UTCCreatedOn] 	DATETIME NULL,
[CreatedByRef] 	BIGINT NULL,
[UTCLastUpdatedOn] 	DATETIME NULL,
[LastUpdatedByRef] 	BIGINT NULL,
[UTCHistoryCreatedOn] DATETIME NOT NULL default(getutcdate()),
[HistoryCreatedByRef] BIGINT NOT NULL,
CONSTRAINT [PK_GEN_BulkImportColumnsMappingHistory] PRIMARY KEY CLUSTERED ([GEN_BulkImportColumnsMappingHistoryId] ASC)
)
END
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GEN_BulkImportHistory]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[GEN_BulkImportHistory](
[GEN_BulkImportHistoryId] BIGINT IDENTITY(10001,1) NOT NULL,
[GEN_BulkImportRef] BIGINT NOT NULL,
[WorkBasketLkup]	BIGINT NULL,
[DiscrepancyCategoryLkup]	BIGINT NULL,
[GEN_BulkImportExcelTemplateMasterRef]	BIGINT NULL,
[LockedByRef]	BIGINT NULL,
[UTCLockedOn] 	DATETIME NULL,
[ExcelFileName] 	VARCHAR(250) NULL,
[DuplicateFileName]	VARCHAR(250) NULL,
[ExcelFilelPath]	VARCHAR(2000) NULL,
[TotalRecordsCount] 	INT NULL,
[ValidRecordsCount]	INT NULL,
[InvalidRecordsCount] 	INT NULL,
[DuplicateRecordCount]	INT NULL,
[ErrorDescription] 	VARCHAR(2000) NULL,
[ExcelStatusLkup] 	BIGINT NULL,
[ImportStatusLkup] 	BIGINT NULL,
[CMN_AppErrorLogRef] 	BIGINT NULL,
[IsActive] 	BIT NULL,
[UTCCreatedOn] 	DATETIME NULL,
[CreatedByRef]	BIGINT NULL,
[UTCLastUpdatedOn] 	DATETIME NULL,
[LastUpdatedByRef]	BIGINT NULL,
[UTCHistoryCreatedOn] DATETIME NOT NULL default(getutcdate()),
[HistoryCreatedByRef] BIGINT NOT NULL,
CONSTRAINT [PK_GEN_BulkImportHistory] PRIMARY KEY CLUSTERED ([GEN_BulkImportHistoryId] ASC)
)
END
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GEN_FDRBulkImport]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[GEN_FDRBulkImport](
				   [GEN_FDRBulkImportId] bigint IDENTITY(10001,1) NOT NULL,
				   [LockedByRef] bigint null,
	               [UTCLockedOn] datetime null,
				   [SubmissionId] varchar(500)  NULL,
				   [ContractNumberLkup] bigint NULL,
				   [TransactionTypeLkup] bigint NULL,
				   [ExcelFileName] varchar(2000) NULL,
				   [ExcelFilelPath] varchar(2000) NULL,
				   [TotalRecordsCount] bigint NULL,
				   [ValidRecordCount]  bigint NULL,
				   [InvalidRecordsCount] bigint NULL,
				   [DuplicateRecordCount] bigint NULL,
				   [ErrorDescription] varchar(2000) NULL,
				   [ImportStatusLkup] bigint NULL,
				   [IsActive] bit NULL,
				   [UTCCreatedOn] datetime NULL
              CONSTRAINT [PK_GEN_FDRBulkImport] PRIMARY KEY CLUSTERED ([GEN_FDRBulkImportId] ASC)
       )
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GEN_FDRStaging]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[GEN_FDRStaging](
				   [GEN_FDRStagingId] bigint IDENTITY(10001,1) NOT NULL,
				   [GEN_FDRBulkImportRef] bigint NOT NULL,
				   [HIC] varchar(1000) NULL,
				   [Last Name] varchar(1000) NULL,
				   [First Name] varchar(1000) NULL,
				   [Requested Start Date] varchar(1000) NULL,
				   [Requested End Date] varchar(1000) NULL,
				   [Requested CMS Segment] varchar(1000) NULL,
				   [Requested PBP] varchar(1000) NULL,
				   [Requested Election Period]varchar(1000) NULL,
				   [Application Receipt Date] varchar(1000) NULL,
				   [Received Date] varchar(1000) NULL,
				   [CMS Process Date] varchar(1000) NULL,
				   [Disposition Code] varchar(1000) NULL,
				   [Disposition Code Description] varchar(1000) NULL,
				   [Requested SCC] varchar(1000) NULL,
				   [Requested ZIP] varchar(1000) NULL,
				   [IsDuplicate] bit NOT NULL default(0),
				   [IsInvalid] bit NOT NULL default(0),
				   [IsProcessed] bit NOT NULL default(0),
				   [CustomErrorDescription] varchar(2000) NULL,
				   [IsActive] bit NOT NULL default(1),
				  [UTCCreatedOn] datetime NOT NULL default(GETUTCDATE())
			CONSTRAINT [PK_GEN_FDRStaging] PRIMARY KEY CLUSTERED ([GEN_FDRStagingId] ASC)
			)
END
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MQTRRWorkQueueItems]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[MQTRRWorkQueueItems](
					[MQTRRWorkQueueItemId] [int] IDENTITY(1,1) NOT NULL,
					[WQTrackingNumber] [varchar](25) NOT NULL,
					[MQSourceTypeLkup] [bigint] NOT NULL default((54001)),--Default Source Is DataUpload
					[MemberID] [varchar](20) NULL,
					[IndividualID] [varchar](15) NULL,
					[HICN] [varchar](15) NULL,
					[HouseholdID] [varchar](64) NULL,
					[Contract] [varchar](10) NULL,
					[PBP] [varchar](10) NULL,
					[FirstName] [varchar](35) NULL,
					[MiddleName] [varchar](35) NULL,
					[LastName] [varchar](35) NULL,
					[DOB] [datetime] NULL,
					[SourceSystem] [varchar](50) NULL,
					[SCCCode] [varchar](50) NULL,
					[LOB] [varchar](30) NULL,
					[DisenrollementPeriod] [int] NULL,
					[TRC] [varchar](5) NULL,
					[TRCTypeCode] [varchar](5) NULL,
					[TimelineEffectiveDate] [datetime] NULL,
					[TRRFileReceiptDate] [datetime] NULL,
					[PlanTerminationDate] [datetime] NULL,
					[ReasonDescription] [varchar](50) NULL,
					[ERSCaseNumber] [bigint] NULL,
					[TRRRecordID] [varchar](20) NULL,
					[GPSProposedEffectiveDate] [datetime] NULL,
					[GPSPDPAutoEnroleeIndicator] [bit] NULL,
					[GPSApplicationStatus] [varchar](20),
					[GPSContract] [varchar](8) NULL,
					[GPSPBP] [varchar](5) NULL,
					[IsCurrentBatch] [bit] NOT NULL default(1),
					[IsProcessed] [bit] NOT NULL default(0),
					[UTCProcessedOn] [datetime] NULL,
					[ProcessedByRef] [bigint] NULL,
					[ProcessingErrorMessage] [varchar](200) NULL,
					[ProcessedGENQueueRef] [varchar](5000) NULL,
					[UTCCreatedOn] [datetime] NOT NULL default(getutcdate()),
					[CreatedByRef] [bigint] NULL,
					[UTCLastUpdatedOn] [datetime] NULL,
					[UpdatedByRef] [bigint] NULL,
					[IsRestricted] [BIT] NULL Default(0),
					[IsRestrictedProcessed] [BIT] NULL,
					[CMN_BackgroundProcessMasterRef] [varchar](5000) NULL,
					[EmployerId] [VARCHAR](20) NULL,
					[IsNationalEmployee] [BIT] NULL DEFAULT(0)
	CONSTRAINT [PK_MQTRRWorkQueueItemId] PRIMARY KEY CLUSTERED ([MQTRRWorkQueueItemId] ASC)
	)
End
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GEN_MIIMServiceTrace]') AND type in (N'U'))
BEGIN
	CREATE TABLE [dbo].[GEN_MIIMServiceTrace](
	[GEN_MIIMServiceTraceId] bigint IDENTITY(10001,1) NOT NULL,
	[WebServiceMethodLkup] bigint NULL,
	[WebServiceMethodName] varchar(1000) NULL,
	[TarceMethodLkup] varchar(4000) NULL,
	[RequestInputData] varchar(4000) NULL,
	[ResponseStatusMessage] varchar(4000) NULL,
	[IsActive] bit NOT NULL default(1),
	[UTCCreatedOn] datetime NOT NULL default(getutcdate()),
	[CreatedByRef] bigint NOT NULL,
	CONSTRAINT [PK_GEN_MIIMServiceTrace] PRIMARY KEY CLUSTERED ([GEN_MIIMServiceTraceId] ASC)
	)
End
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MQMessagesRecieved]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[MQMessagesRecieved](
	[MQMessagesRecievedId] [bigint] IDENTITY(1,1) NOT NULL,
	[CMN_BackgroundProcessMasterRef] [bigint] NULL,
	[MQSourceTypeLkup] [bigint] NULL,
	[MQMessage] [varchar](max) NULL,
	[IsProcessed] [bit] NOT NULL DEFAULT(0),
	[ProcessedResult] [varchar](max) NULL,
	[MQTRRWorkQueueItemRef] [bigint] NULL,
	[ProcessingFailReason] [varchar](1000) NULL,
	[UTCCreatedOn] [datetime] NOT NULL DEFAULT (getutcdate()),
	[CreatedByRef] [bigint] NULL,
	[UTCLastUpdatedOn] [datetime] NULL,
	[LastUpdatedByRef] [bigint] NULL,
    CONSTRAINT [PK_MQMessagesRecieved] PRIMARY KEY CLUSTERED (	[MQMessagesRecievedId] ASC)
	)
End
GO
