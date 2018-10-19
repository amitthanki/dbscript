--CMN_Department
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CMN_Department]') AND type in (N'U'))
BEGIN
	CREATE TABLE [dbo].[CMN_Department](
		[CMN_DepartmentId] bigint IDENTITY(1,1) NOT NULL,
		[LockedByRef] bigint NULL,
		[UTCLockedOn] datetime NULL,
		[ERSDepartmentName] varchar(500) NULL,
		[BusinessSegmentLkup] bigint NULL,
		[DepartmentLkup] bigint NULL,
		[EffectiveDate] datetime NULL,
		[InactivationDate] datetime NULL,
		[IsActive] bit NOT NULL default(1),
		[UTCCreatedOn] datetime NOT NULL default(getutcdate()),
		[CreatedByRef] bigint NOT NULL,
		[UTCLastUpdatedOn] datetime NULL,
		[LastUpdatedByRef] bigint NULL,
		CONSTRAINT [PK_CMN_Department] PRIMARY KEY CLUSTERED ([CMN_DepartmentId] ASC)
	)
End
GO


--CMN_LookupType
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CMN_LookupType]') AND type in (N'U'))
BEGIN
	CREATE TABLE [dbo].[CMN_LookupType](
		[CMN_LookupTypeId] Bigint  NOT NULL,
		[LockedByRef] bigint NULL,
		[UTCLockedOn] datetime NULL,
		[LookupTypeDescription] varchar(75) NULL,
		[IsActive] bit NOT NULL default(1),
		[UTCCreatedOn] datetime NOT NULL default(getutcdate()),
		[CreatedByRef] bigint NOT NULL,
		[UTCLastUpdatedOn] datetime NULL,
		[LastUpdatedByRef] bigint NULL,
		CONSTRAINT [PK_CMN_LookupType] PRIMARY KEY CLUSTERED ([CMN_LookupTypeId] ASC)
	)
End
GO


--CMN_LookupMaster
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CMN_LookupMaster]') AND type in (N'U'))
BEGIN
	CREATE TABLE [dbo].[CMN_LookupMaster](
		[CMN_LookupMasterId] Bigint  NOT NULL,
		[CMN_LookupTypeRef] Bigint NOT NULL,
		[LockedByRef] bigint NULL,
		[UTCLockedOn] datetime NULL,
		[LookupValue] varchar(200) NOT NULL,
		[LookupDescription] varchar(200) NULL,
		[LookupValue1] varchar(200) NULL,
		[LookupValue2] varchar(200) NULL,
		[DisplayOrder] bigint NULL,
		[IsActive] bit NOT NULL default(1),
		[UTCCreatedOn] datetime NOT NULL default(getutcdate()),
		[CreatedByRef] bigint NOT NULL,
		[UTCLastUpdatedOn] datetime NULL,
		[LastUpdatedByRef] bigint NULL,
		CONSTRAINT [PK_CMN_LookupMaster] PRIMARY KEY CLUSTERED ([CMN_LookupMasterId] ASC)
	)
End
GO


--CMN_LookupTypeCorrelations
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CMN_LookupTypeCorrelations]') AND type in (N'U'))
BEGIN
	CREATE TABLE [dbo].[CMN_LookupTypeCorrelations](
		[CMN_LookupTypeCorrelationsId] Bigint  NOT NULL,
		[CMN_LookupTypeParentRef] Bigint NOT NULL,
		[CMN_LookupTypeChildRef] Bigint NOT NULL,
		[GroupingLookupTypeRef] bigint NULL,
		[CorrelationDescription] varchar(1000) NULL,
		[LockedByRef] bigint NULL,
		[UTCLockedOn] datetime NULL,
		[IsActive] bit NOT NULL default(1),
		[UTCCreatedOn] datetime NOT NULL default(getutcdate()),
		[CreatedByRef] bigint NOT NULL,
		[UTCLastUpdatedOn] datetime NULL,
		[LastUpdatedByRef] bigint NULL,
		CONSTRAINT [PK_CMN_LookupTypeCorrelations] PRIMARY KEY CLUSTERED ([CMN_LookupTypeCorrelationsId] ASC)
	)
End
GO


--CMN_LookupMasterCorrelations
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CMN_LookupMasterCorrelations]') AND type in (N'U'))
BEGIN
	CREATE TABLE [dbo].[CMN_LookupMasterCorrelations](
		[CMN_LookupMasterCorrelationsId] Bigint  NOT NULL,
		[CMN_LookupTypeCorrelationsRef] Bigint NOT NULL,
		[CMN_LookupMasterParentRef] Bigint NOT NULL,
		[CMN_LookupMasterChildRef] Bigint NOT NULL,
		[GroupingLookupMasterRef] bigint NULL,
		[CorrelationDescription] varchar(1000) NULL,
		[DisplayOrder] bigint NULL,
		[IsActive] bit NOT NULL default(1),
		[UTCCreatedOn] datetime NOT NULL default(getutcdate()),
		[CreatedByRef] bigint NOT NULL,
		[UTCLastUpdatedOn] datetime NULL,
		[LastUpdatedByRef] bigint NULL,
		CONSTRAINT [PK_CMN_LookupMasterCorrelations] PRIMARY KEY CLUSTERED ([CMN_LookupMasterCorrelationsId] ASC)
	)
End
GO


--CMN_AppErrorLog
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CMN_AppErrorLog]') AND type in (N'U'))
BEGIN
	CREATE TABLE [dbo].[CMN_AppErrorLog](
		[CMN_AppErrorLogId] Bigint  IDENTITY(1,1) NOT NULL,
		[ADM_UserMasterRef] Bigint  NULL,
		[ErrorLocation] Varchar(100) NULL,
		[ErrorSourceLkup] bigint NULL,
		[ErrorMessage] varchar(500) NULL,
		[ErrorDescription] varchar(4000) NULL,
		[UTCErrorDateTime] datetime NULL,
		[UTCCreatedOn] datetime NOT NULL default(getutcdate()),
		CONSTRAINT [PK_CMN_AppErrorLog] PRIMARY KEY CLUSTERED ([CMN_AppErrorLogId] ASC)
	)
End
GO


--CMN_MenuMaster
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CMN_MenuMaster]') AND type in (N'U'))
BEGIN
	CREATE TABLE [dbo].[CMN_MenuMaster](
		[CMN_MenuMasterId] bigint IDENTITY(1,1) NOT NULL,
		[MenuName] varchar(50) NOT NULL,
		[MenuDescription] varchar(200) NULL,
		[Level1] varchar(50) NULL,
		[Level2] varchar(50) NULL,
		[Level3] varchar(50) NULL,
		[Level4] varchar(50) NULL,
		[MenuUrl] varchar(500) NULL,
		[DisplayOrder] int NOT NULL default(1),
		[IsActive] bit NOT NULL default(1),
		[UTCCreatedOn] datetime NOT NULL default(getutcdate()),
		[CreatedByRef] bigint NOT NULL,
		CONSTRAINT [PK_CMN_MenuMaster] PRIMARY KEY CLUSTERED ([CMN_MenuMasterId] ASC)
	)
End
GO


--CMN_DiscrepancyTypeMenuCorrelation
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CMN_DiscrepancyTypeMenuCorrelation]') AND type in (N'U'))
BEGIN
	CREATE TABLE [dbo].[CMN_DiscrepancyTypeMenuCorrelation](
		[CMN_DiscrepancyTypeMenuCorrelationId] bigint IDENTITY(1,1) NOT NULL,
		[CMN_MenuMasterRef] bigint NOT NULL,
		[DiscrepancyTypeLkup] bigint NOT NULL,
		[RoleLkup] bigint NOT NULL,
		[IsActive] bit NOT NULL default(1),
		[UTCCreatedOn] datetime NOT NULL default(getutcdate()),
		[CreatedByRef] bigint NOT NULL,
		CONSTRAINT [PK_CMN_DiscrepancyTypeMenuCorrelation] PRIMARY KEY CLUSTERED ([CMN_DiscrepancyTypeMenuCorrelationId] ASC)
	)
End
GO


--MGR_ConfigMaster
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MGR_ConfigMaster]') AND type in (N'U'))
BEGIN
	CREATE TABLE [dbo].[MGR_ConfigMaster](
		[MGR_ConfigMasterId] bigint IDENTITY(1,1) NOT NULL,
		[LockedByRef] bigint NULL,
		[UTCLockedOn] datetime NULL,
		[ConfigName] varchar(500) NULL,
		[ConfigValue] varchar(2000) NULL,
		[Version] bigint NULL default(1),
		[StartDate] datetime NULL,
		[EndDate] datetime NULL,
		[IsActive] bit NOT NULL default(1),
		[UTCCreatedOn] datetime NOT NULL default(getutcdate()),
		[CreatedByRef] bigint NOT NULL,
		[UTCLastUpdatedOn] datetime NULL,
		[LastUpdatedByRef] bigint NULL,
		CONSTRAINT [PK_MGR_ConfigMaster] PRIMARY KEY CLUSTERED ([MGR_ConfigMasterId] ASC)
	)
End
GO


--ADM_AlertDetails
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ADM_AlertDetails]') AND type in (N'U'))
BEGIN
	CREATE TABLE [dbo].[ADM_AlertDetails](
		[ADM_AlertDetailsId] bigint IDENTITY(1,1) NOT NULL,
		[LockedByRef] bigint NULL,
		[UTCLockedOn] datetime NULL,
		[AlertTitle] varchar(250) NOT NULL,
		[AlertDescription] varchar(5000) NULL,
		[AlertPublishedDate] datetime NULL,
		[AlertEffectiveDate] datetime NULL,
		[AlertInactivationDate] datetime NULL,
		[AlertCriticalityLkup] bigint NULL,
		[SendAlertToLkup] bigint NULL,
		[CMN_DepartmentRef] bigint NULL,
		[ADM_UserMasterRef] bigint NULL,
		[IsActive] bit NOT NULL default(1),
		[UTCCreatedOn] DateTime NOT NULL default(getutcdate()),
		[CreatedByRef] bigint NOT NULL,
		[UTCLastUpdatedOn] DateTime NOT NULL,
		[LastUpdatedByRef] bigint NOT NULL,
		CONSTRAINT [PK_ADM_AlertDetails] PRIMARY KEY CLUSTERED ([ADM_AlertDetailsId] ASC)
	)
End
GO


--ADM_AlertsRead
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ADM_AlertsRead]') AND type in (N'U'))
BEGIN
	CREATE TABLE [dbo].[ADM_AlertsRead](
		[CMN_AlertsReadId] bigint IDENTITY(1,1) NOT NULL,
		[ADM_AlertDetailsRef] bigint NOT NULL,
		[ADM_UserMasterRef] bigint NOT NULL,
		[IsActive] bit NOT NULL default(1),
		[UTCCreatedOn] datetime NOT NULL default(getutcdate()),
		[CreatedByRef] bigint NOT NULL,
		CONSTRAINT [PK_ADM_AlertsRead] PRIMARY KEY CLUSTERED ([CMN_AlertsReadId] ASC)
	)
End
GO


--ADM_ResourceDetails
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ADM_ResourceDetails]') AND type in (N'U'))
BEGIN
	CREATE TABLE [dbo].[ADM_ResourceDetails](
		[ADM_ResourceDetailsId] bigint IDENTITY(1,1) NOT NULL,
		[LockedByRef] bigint NULL,
		[UTCLockedOn] datetime NULL,
		[ResourceName] varchar(50) NOT NULL,
		[ResourceDescription] varchar(5000) NULL,
		[ResourceLinkLocation] varchar(500) NULL,
		[ResourceEffectiveDate] datetime NULL,
		[ResourceInactivationDate] datetime NULL,
		[CMN_DepartmentRef] bigint NULL,
		[IsActive] bit NOT NULL default(1),
		[UTCCreatedOn] DateTime NOT NULL default(getutcdate()),
		[CreatedByRef] bigint NOT NULL,
		[UTCLastUpdatedOn] DateTime NOT NULL,
		[LastUpdatedByRef] bigint NOT NULL,
		CONSTRAINT [PK_ADM_ResourceDetails] PRIMARY KEY CLUSTERED ([ADM_ResourceDetailsId] ASC)
	)
End
GO


--RPT_ReportsMaster
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RPT_ReportsMaster]') AND type in (N'U'))
BEGIN
	CREATE TABLE [dbo].[RPT_ReportsMaster](
		[RPT_ReportsMasterId] Bigint  IDENTITY(1,1) NOT NULL,
		[ReportName] Varchar(250) NOT NULL,
		[ReportServer] Varchar(100) NULL,
		[ReportURL] Varchar(1000) NULL,
		[ReportsCategoryLkup] Bigint  NOT NULL,
		[ViewInUI] bit NOT NULL default(0),
		[IsActive] bit NOT NULL default(1),
		[UTCCreatedOn] datetime NOT NULL default(getutcdate()),
		[CreatedByRef] bigint NOT NULL,
		CONSTRAINT [PK_RPT_ReportsMaster] PRIMARY KEY CLUSTERED ([RPT_ReportsMasterId] ASC)
	)
End
GO


--ADM_UserMaster
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ADM_UserMaster]') AND type in (N'U'))
BEGIN
	CREATE TABLE [dbo].[ADM_UserMaster](
		[ADM_UserMasterId] bigint IDENTITY(1000,1) NOT NULL,
		[LockedByRef] bigint NULL,
		[UTCLockedOn] datetime NULL,
		[Title] bigint NULL,
		[FirstName] varchar(100) NULL,
		[LastName] varchar(100) NULL,
		[FullName] varchar(250) NULL,
		[SystemFullName] varchar(250) NULL,
		[MSID] varchar(100) NOT NULL,
		[Email] varchar(100) NOT NULL,
		[IsManager] bit NOT NULL default(0),
		[ManagerId] bigint NULL,
		[LocationLkup] bigint NULL,
		[NonUserLkup] bigint NULL,
		[StartDate] datetime NOT NULL,
		[EndDate] datetime NOT NULL,
		[SpecialistTitle] varchar(50) NULL,
		[SpecialistPhone] varchar(12) NULL,
		[SpecialistFax] varchar(12) NULL,
		[SpecialistHours] varchar(12) NULL,
		[SpecialistTimeZone] bigint NULL,
		[UserAddressLine1] varchar(100) NULL,
		[UserAddressLine2] varchar(100) NULL,
		[UserCity] varchar(50) NULL,
		[UserStateLkup] bigint NULL,
		[UserZip] varchar(10) NULL,
		[IsActive] bit NOT NULL default(1),
		[UTCCreatedOn] datetime NOT NULL default(getutcdate()),
		[CreatedByRef] bigint NOT NULL,
		[CreatedByRoleLkup] BIGINT NULL,
		[UTCLastUpdatedOn] datetime NULL,
		[LastUpdatedByRef] bigint NULL,
		[LastUpdatedByRoleLkup] BIGINT NULL,
		CONSTRAINT [PK_ADM_UserMaster] PRIMARY KEY CLUSTERED ([ADM_UserMasterId] ASC)
	)
End
GO


--ADM_UserPreference
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ADM_UserPreference]') AND type in (N'U'))
BEGIN
	CREATE TABLE [dbo].[ADM_UserPreference](
		[ADM_UserPreferenceId] bigint IDENTITY(1,1) NOT NULL,
		[ADM_UserMasterRef] bigint NOT NULL,
		[ShowAlerts] bit NOT NULL default(0),
		[ShowResources] bit NOT NULL default(0),
		[BusinessSegmentLkup] bigint NULL,
		[RoleLkup] bigint NULL,
		[TimezoneLkup] bigint NULL,
		[WorkBasketLkup] bigint NULL,
		[ShowOSTSummary] bit NOT NULL default(0),
		[ShowEligibilitySummary] bit NOT NULL default(0),
		[ShowRPRSummary] bit NOT NULL default(0),
		[IsActive] bit NOT NULL default(1),
		[UTCCreatedOn] datetime NOT NULL default(getutcdate()),
		[CreatedByRef] bigint NOT NULL,
		[UTCLastUpdatedOn] datetime NULL,
		[LastUpdatedByRef] bigint NULL,
		CONSTRAINT [PK_ADM_UserPreference] PRIMARY KEY CLUSTERED ([ADM_UserPreferenceId] ASC)
	)
End
GO


--ADM_UserSession
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ADM_UserSession]') AND type in (N'U'))
BEGIN
	CREATE TABLE [dbo].[ADM_UserSession](
       [ADM_UserSessionId] [bigint] IDENTITY(100,1) NOT NULL,
       [ADM_UserMasterRef] [bigint] NOT NULL,
       [LoginTime] [datetime] NULL,
       [LogoffTime] [datetime] NULL,
       [LastActivity] [datetime] NOT NULL,
       [IsActive] [bit] NOT NULL,
       [UTCCreatedOn] [datetime] NOT NULL,
       [CreatedByRef] [bigint] NOT NULL,
       [UTCLastUpdatedOn] [datetime] NULL,
       [LastUpdatedByRef] [bigint] NULL,
	CONSTRAINT [PK_ADM_UserSession] PRIMARY KEY CLUSTERED 
	(
		   [ADM_UserSessionId] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY]
	ALTER TABLE [dbo].[ADM_UserSession] ADD  DEFAULT ((1)) FOR [IsActive]
	ALTER TABLE [dbo].[ADM_UserSession] ADD  DEFAULT (getutcdate()) FOR [UTCCreatedOn]
End
GO


--ADM_SkillsMaster
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ADM_SkillsMaster]') AND type in (N'U'))
BEGIN
	CREATE TABLE [dbo].[ADM_SkillsMaster](
		[ADM_SkillsMasterId] bigint IDENTITY(1,1) NOT NULL,
		[LockedByRef] bigint NULL,
		[UTCLockedOn] datetime NULL,
		[SkillsName] varchar(200) NOT NULL,
		[RoleLkup] bigint NOT NULL,
		[BusinessSegmentLkup] bigint NOT NULL,
		[CMN_DepartmentRef] bigint NOT NULL,
		[WorkBasketLkup] bigint NOT NULL,
		[DiscrepancyCategoryLkup] bigint NOT NULL,
		[IsActive] bit NOT NULL default(1),
		[UTCCreatedOn] datetime NOT NULL default(getutcdate()),
		[CreatedByRef] bigint NOT NULL,
		[UTCLastUpdatedOn] datetime NULL,
		[LastUpdatedByRef] bigint NULL,
		CONSTRAINT [PK_ADM_SkillsMaster] PRIMARY KEY CLUSTERED ([ADM_SkillsMasterId] ASC)
	)
End
GO


--ADM_SkillWorkQueuesCorrelation
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ADM_SkillWorkQueuesCorrelation]') AND type in (N'U'))
BEGIN
	CREATE TABLE [dbo].[ADM_SkillWorkQueuesCorrelation](
		[ADM_SkillWorkQueuesCorrelationId] bigint IDENTITY(1,1) NOT NULL,
		[ADM_SkillsMasterRef] bigint NOT NULL,		
		[WorkQueuesLkup] bigint NOT NULL,
		[IsActive] bit NOT NULL default(1),
		[UTCCreatedOn] datetime NOT NULL default(getutcdate()),
		[CreatedByRef] bigint NOT NULL,
		[UTCLastUpdatedOn] datetime NULL,
		[LastUpdatedByRef] bigint NULL,
		CONSTRAINT [PK_ADM_SkillWorkQueuesCorrelation] PRIMARY KEY CLUSTERED ([ADM_SkillWorkQueuesCorrelationId] ASC)
	)
End
GO


--ADM_AccessGroupMaster
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ADM_AccessGroupMaster]') AND type in (N'U'))
BEGIN
	CREATE TABLE [dbo].[ADM_AccessGroupMaster](
		[ADM_AccessGroupMasterId] bigint IDENTITY(1,1) NOT NULL,
		[LockedByRef] bigint NULL,
		[UTCLockedOn] datetime NULL,
		[AccessGroupName] varchar(200) NOT NULL,
		[AccessGroupDescription] varchar(500) NULL,
		[RoleLkup] bigint NOT NULL,
		[WorkBasketLkup] bigint NOT NULL,
		[IsActive] bit NOT NULL default(1),
		[UTCCreatedOn] datetime NOT NULL default(getutcdate()),
		[CreatedByRef] bigint NOT NULL,
		[UTCLastUpdatedOn] datetime NULL,
		[LastUpdatedByRef] bigint NULL,
		CONSTRAINT [PK_ADM_AccessGroupMaster] PRIMARY KEY CLUSTERED ([ADM_AccessGroupMasterId] ASC)
	)
End
GO


--ADM_AccessGroupSkillsCorrelation
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ADM_AccessGroupSkillsCorrelation]') AND type in (N'U'))
BEGIN
	CREATE TABLE [dbo].[ADM_AccessGroupSkillsCorrelation](
		[ADM_AccessGroupSkillsCorrelationId] bigint IDENTITY(1,1) NOT NULL,
		[ADM_AccessGroupMasterRef] bigint NOT NULL,
		[ADM_SkillsMasterRef] bigint NOT NULL,
		[CanCreate] bit NOT NULL default(0),
		[CanModify] bit NOT NULL default(0),
		[CanSearch] bit NOT NULL default(0),
		[CanView] bit NOT NULL,
		[CanMassUpdate] bit NOT NULL,
		[CanHistory] bit NOT NULL default(0),
		[CanReassign] bit NOT NULL default(0),
		[CanUnlock] bit NOT NULL default(0),
		[CanUpload] bit NOT NULL default(0),
		[CanClone] bit NOT NULL default(0),
		[CanReopen] bit NOT NULL default(0),
		[IsActive] bit NOT NULL default(1),
		[UTCCreatedOn] datetime NOT NULL default(getutcdate()),
		[CreatedByRef] bigint NOT NULL,
		[UTCLastUpdatedOn] datetime NULL,
		[LastUpdatedByRef] bigint NULL,
		CONSTRAINT [PK_ADM_AccessGroupSkillsCorrelation] PRIMARY KEY CLUSTERED ([ADM_AccessGroupSkillsCorrelationId] ASC)
	)
End
GO


--ADM_AccessGroupReportCorrelation
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ADM_AccessGroupReportCorrelation]') AND type in (N'U'))
BEGIN
	CREATE TABLE [dbo].[ADM_AccessGroupReportCorrelation](
		[ADM_AccessGroupReportCorrelationId] bigint IDENTITY(1,1) NOT NULL,
		[ADM_AccessGroupMasterRef] bigint NOT NULL,
		[RPT_ReportsMasterRef] bigint NOT NULL,
		[IsActive] bit NOT NULL default(1),
		[UTCCreatedOn] datetime NOT NULL default(getutcdate()),
		[CreatedByRef] bigint NOT NULL,
		[UTCLastUpdatedOn] datetime NULL,
		[LastUpdatedByRef] bigint NULL,
		CONSTRAINT [PK_ADM_AccessGroupReportCorrelation] PRIMARY KEY CLUSTERED ([ADM_AccessGroupReportCorrelationId] ASC)
	)
End
GO


--ADM_AccessGroupUserCorrelation
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ADM_AccessGroupUserCorrelation]') AND type in (N'U'))
BEGIN
	CREATE TABLE [dbo].[ADM_AccessGroupUserCorrelation](
		[ADM_AccessGroupUserCorrelationId] bigint IDENTITY(1,1) NOT NULL,
		[ADM_AccessGroupMasterRef] bigint NOT NULL,
		[ADM_UserMasterRef] bigint NOT NULL,
		[IsActive] bit NOT NULL default(1),
		[UTCCreatedOn] datetime NOT NULL default(getutcdate()),
		[CreatedByRef] bigint NOT NULL,
		[CreatedByRoleLkup] bigint NULL,
		[UTCLastUpdatedOn] datetime NULL,
		[LastUpdatedByRef] bigint NULL,
		[LastUpdatedByRoleLkup] bigint NULL,
		CONSTRAINT [PK_ADM_AccessGroupUserCorrelation] PRIMARY KEY CLUSTERED ([ADM_AccessGroupUserCorrelationId] ASC)
	)
End
GO


--CMN_TableSequenceCounts
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CMN_TableSequenceCounts]') AND type in (N'U'))
BEGIN
	CREATE TABLE [dbo].[CMN_TableSequenceCounts](
		[CMN_TableSequenceCountsId] bigint  NOT NULL,
		[Sequence] bigint NOT NULL,
		[SequenceDescription] varchar(100) NULL,
		CONSTRAINT [PK_CMN_TableSequenceCounts] PRIMARY KEY CLUSTERED ([CMN_TableSequenceCountsId] ASC)
	)
End
GO


--CMN_RecordsLocked
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CMN_RecordsLocked]') AND type in (N'U'))
BEGIN
	CREATE TABLE [dbo].[CMN_RecordsLocked](
		[CMN_RecordsLockedId] bigint IDENTITY(1,1) NOT NULL,
		[ScreenLkup] bigint NOT NULL,
		[CaseId] bigint NOT NULL,
		[StartTime] datetime NOT NULL,
		[EndTime] datetime NULL,
		[Guid] char(40) NULL,
		[IsActive] bit NOT NULL default(1),
		[UTCCreatedOn] datetime NOT NULL default(getutcdate()),
		[CreatedByRef] bigint NOT NULL,
		[UTCLastUpdatedOn] datetime NULL,
		[LastUpdatedByRef] bigint NULL,
		CONSTRAINT [PK_CMN_RecordsLocked] PRIMARY KEY CLUSTERED ([CMN_RecordsLockedId] ASC)
	)
End
GO

------------------------------------------------------------------------------------------------------------------

--CMN_DepartmentHistory
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CMN_DepartmentHistory]') AND type in (N'U'))
BEGIN
	CREATE TABLE [dbo].[CMN_DepartmentHistory](
		[CMN_DepartmentHistoryId] bigint IDENTITY(1,1) NOT NULL,
		[CMN_DepartmentRef] bigint NOT NULL,
		[LockedByRef] bigint NULL,
		[UTCLockedOn] datetime NULL,
		[ERSDepartmentName] varchar(500) NULL,
		[BusinessSegmentLkup] bigint NULL,
		[DepartmentLkup] bigint NULL,
		[EffectiveDate] datetime NULL,
		[InactivationDate] datetime NULL,
		[IsActive] bit NOT NULL,
		[UTCCreatedOn] datetime NOT NULL,
		[CreatedByRef] bigint NOT NULL,
		[UTCLastUpdatedOn] datetime NULL,
		[LastUpdatedByRef] bigint NULL,
		[UTCHistoryCreatedOn] datetime NOT NULL default(getutcdate()),
		[HistoryCreatedByRef] bigint NOT NULL,
		[SaveAttempt] bigint NOT NULL,
		CONSTRAINT [PK_CMN_DepartmentHistory] PRIMARY KEY CLUSTERED ([CMN_DepartmentHistoryId] ASC)
	)
End
GO


--CMN_LookupTypeHistory
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CMN_LookupTypeHistory]') AND type in (N'U'))
BEGIN
	CREATE TABLE [dbo].[CMN_LookupTypeHistory](
		[CMN_LookupTypeHistoryId] bigint IDENTITY(1,1) NOT NULL,
		[CMN_LookupTypeRef] Bigint NOT NULL,
		[LockedByRef] bigint NULL,
		[UTCLockedOn] datetime NULL,
		[LookupTypeDescription] varchar(75) NULL,
		[IsActive] bit NOT NULL,
		[UTCCreatedOn] datetime NOT NULL,
		[CreatedByRef] bigint NOT NULL,
		[UTCLastUpdatedOn] datetime NULL,
		[LastUpdatedByRef] bigint NULL,
		[UTCHistoryCreatedOn] datetime NOT NULL default(getutcdate()),
		[HistoryCreatedByRef] bigint NOT NULL,
		[SaveAttempt] bigint NOT NULL,
		CONSTRAINT [PK_CMN_LookupTypeHistory] PRIMARY KEY CLUSTERED ([CMN_LookupTypeHistoryId] ASC)
	)
End
GO


--CMN_LookupMasterHistory
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CMN_LookupMasterHistory]') AND type in (N'U'))
BEGIN
	CREATE TABLE [dbo].[CMN_LookupMasterHistory](
		[CMN_LookupMasterHistoryId] bigint IDENTITY(1,1) NOT NULL,
		[CMN_LookupMasterRef] Bigint NOT NULL,
		[CMN_LookupTypeRef] Bigint NOT NULL,
		[LockedByRef] bigint NULL,
		[UTCLockedOn] datetime NULL,
		[LookupValue] varchar(200) NOT NULL,
		[LookupDescription] varchar(200) NULL,
		[LookupValue1] varchar(200) NULL,
		[LookupValue2] varchar(200) NULL,
		[DisplayOrder] bigint NULL,
		[IsActive] bit NOT NULL,
		[UTCCreatedOn] datetime NOT NULL,
		[CreatedByRef] bigint NOT NULL,
		[UTCLastUpdatedOn] datetime NULL,
		[LastUpdatedByRef] bigint NULL,
		[UTCHistoryCreatedOn] datetime NOT NULL default(getutcdate()),
		[HistoryCreatedByRef] bigint NOT NULL,
		[SaveAttempt] bigint NOT NULL,
		CONSTRAINT [PK_CMN_LookupMasterHistory] PRIMARY KEY CLUSTERED ([CMN_LookupMasterHistoryId] ASC)
	)
End
GO


--CMN_LookupTypeCorrelationsHistory
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CMN_LookupTypeCorrelationsHistory]') AND type in (N'U'))
BEGIN
	CREATE TABLE [dbo].[CMN_LookupTypeCorrelationsHistory](
		[CMN_LookupTypeCorrelationsHistoryId] Bigint IDENTITY(1,1) NOT NULL,
		[CMN_LookupTypeCorrelationsRef] bigint NOT NULL,
		[CMN_LookupTypeParentRef] Bigint NOT NULL,
		[CMN_LookupTypeChildRef] Bigint NOT NULL,
		[GroupingLookupTypeRef] bigint NULL,
		[CorrelationDescription] varchar(1000) NULL,
		[LockedByRef] bigint NULL,
		[UTCLockedOn] datetime NULL,
		[IsActive] bit NOT NULL,
		[UTCCreatedOn] datetime NOT NULL,
		[CreatedByRef] bigint NOT NULL,
		[UTCLastUpdatedOn] datetime NULL,
		[LastUpdatedByRef] bigint NULL,
		[UTCHistoryCreatedOn] datetime NOT NULL default(getutcdate()),
		[HistoryCreatedByRef] bigint NOT NULL,
		[SaveAttempt] bigint NOT NULL,
		CONSTRAINT [PK_CMN_LookupTypeCorrelationsHistory] PRIMARY KEY CLUSTERED ([CMN_LookupTypeCorrelationsHistoryId] ASC)
	)
End
GO


--CMN_LookupMasterCorrelationsHistory
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CMN_LookupMasterCorrelationsHistory]') AND type in (N'U'))
BEGIN
	CREATE TABLE [dbo].[CMN_LookupMasterCorrelationsHistory](
		[CMN_LookupMasterCorrelationsHistoryId] Bigint IDENTITY(1,1) NOT NULL,
		[CMN_LookupMasterCorrelationsRef] bigint NOT NULL,
		[CMN_LookupTypeCorrelationsRef] Bigint NOT NULL,
		[CMN_LookupMasterParentRef] Bigint NOT NULL,
		[CMN_LookupMasterChildRef] Bigint NOT NULL,
		[GroupingLookupMasterRef] bigint NULL,
		[CorrelationDescription] varchar(1000) NULL,
		[DisplayOrder] bigint NULL,
		[IsActive] bit NOT NULL,
		[UTCCreatedOn] datetime NOT NULL,
		[CreatedByRef] bigint NOT NULL,
		[UTCLastUpdatedOn] datetime NULL,
		[LastUpdatedByRef] bigint NULL,
		[UTCHistoryCreatedOn] datetime NOT NULL default(getutcdate()),
		[HistoryCreatedByRef] bigint NOT NULL,
		[SaveAttempt] bigint NOT NULL,
		CONSTRAINT [PK_CMN_LookupMasterCorrelationsHistory] PRIMARY KEY CLUSTERED ([CMN_LookupMasterCorrelationsHistoryId] ASC)
	)
End
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CMN_BackgroundProcessMaster]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[CMN_BackgroundProcessMaster](
        [CMN_BackgroundProcessMasterId] bigint IDENTITY(1,1) NOT NULL,
		[BackgroundProcessTypeLkup] bigint NOT NULL,
		[UTCStartDate] datetime NULL,
		[TotalDuration] bigint NULL,
		[UTCEndDate] datetime NULL,
		[TotalRecordProcessed] bigint NULL,
		[BGPStatusLkup] bigint NULL,
		[IsActive] bit NULL,
		[UTCCreatedOn] datetime NOT NULL,
		[CreatedByRef] bigint NOT NULL,
		[UTCLastUpdatedOn] datetime NULL,
		[LastUpdatedByRef] bigint NULL,
        CONSTRAINT [PK_CMN_BackgroundProcessMaster] PRIMARY KEY CLUSTERED ([CMN_BackgroundProcessMasterId] ASC)
       )
END
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CMN_BackgroundProcessDetails]') AND type in (N'U'))
BEGIN
  CREATE TABLE [dbo].[CMN_BackgroundProcessDetails](
        [CMN_BackgroundProcessDetailsId] bigint IDENTITY(1,1) NOT NULL,
		[CMN_BackgroundProcessMasterRef] bigint  NULL,
		[GEN_QueueRef] bigint NULL,
		[GEN_BulkImportRef] bigint NULL,
		[GEN_FDRUploadStagingRef] bigint NULL,
		[UploadFileName] varchar(2000) NULL,
		[BGPRecordStatusLkup] bigint NULL,
		[FailureReason] varchar(2000) NULL,
		[IsActive] bit NULL,
		[UTCCreatedOn] datetime NULL
        CONSTRAINT [PK_CMN_BackgroundProcessDetails] PRIMARY KEY CLUSTERED ([CMN_BackgroundProcessDetailsId] ASC)
       )
END
GO

--MGR_ConfigMasterHistory
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MGR_ConfigMasterHistory]') AND type in (N'U'))
BEGIN
	CREATE TABLE [dbo].[MGR_ConfigMasterHistory](
		[MGR_ConfigMasterHistoryId] bigint IDENTITY(1,1) NOT NULL,
		[MGR_ConfigMasterRef] bigint NOT NULL,
		[LockedByRef] bigint NULL,
		[UTCLockedOn] datetime NULL,
		[ConfigName] varchar(500) NULL,
		[ConfigValue] varchar(2000) NULL,
		[Version] bigint NULL,
		[StartDate] datetime NULL,
		[EndDate] datetime NULL,
		[IsActive] bit NOT NULL,
		[UTCCreatedOn] datetime NOT NULL,
		[CreatedByRef] bigint NOT NULL,
		[UTCLastUpdatedOn] datetime NULL,
		[LastUpdatedByRef] bigint NULL,
		[UTCHistoryCreatedOn] datetime NOT NULL default(getutcdate()),
		[HistoryCreatedByRef] bigint NOT NULL,
		[SaveAttempt] bigint NOT NULL,
		CONSTRAINT [PK_MGR_ConfigMasterHistory] PRIMARY KEY CLUSTERED ([MGR_ConfigMasterHistoryId] ASC)
	)
End
GO


--ADM_AlertDetailsHistory
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ADM_AlertDetailsHistory]') AND type in (N'U'))
BEGIN
	CREATE TABLE [dbo].[ADM_AlertDetailsHistory](
		[ADM_AlertDetailsHistoryId] bigint IDENTITY(1,1) NOT NULL,
		[ADM_AlertDetailsRef] bigint NOT NULL,
		[LockedByRef] bigint NULL,
		[UTCLockedOn] datetime NULL,
		[AlertTitle] varchar(250) NOT NULL,
		[AlertDescription] varchar(5000) NULL,
		[AlertPublishedDate] datetime NULL,
		[AlertEffectiveDate] datetime NULL,
		[AlertInactivationDate] datetime NULL,
		[AlertCriticalityLkup] bigint NULL,
		[SendAlertToLkup] bigint NULL,
		[CMN_DepartmentRef] bigint NULL,
		[ADM_UserMasterRef] bigint NULL,
		[IsActive] bit NOT NULL,
		[UTCCreatedOn] DateTime NOT NULL,
		[CreatedByRef] bigint NOT NULL,
		[UTCLastUpdatedOn] DateTime NOT NULL,
		[LastUpdatedByRef] bigint NOT NULL,
		[UTCHistoryCreatedOn] datetime NOT NULL default(getutcdate()),
		[HistoryCreatedByRef] bigint NOT NULL,
		[SaveAttempt] bigint NOT NULL,
		CONSTRAINT [PK_ADM_AlertDetailsHistory] PRIMARY KEY CLUSTERED ([ADM_AlertDetailsHistoryId] ASC)
	)
End
GO


--ADM_ResourceDetailsHistory
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ADM_ResourceDetailsHistory]') AND type in (N'U'))
BEGIN
	CREATE TABLE [dbo].[ADM_ResourceDetailsHistory](
		[ADM_ResourceDetailsHistoryId] bigint IDENTITY(1,1) NOT NULL,
		[ADM_ResourceDetailsRef] bigint NOT NULL,
		[LockedByRef] bigint NULL,
		[UTCLockedOn] datetime NULL,
		[ResourceName] varchar(50) NOT NULL,
		[ResourceDescription] varchar(5000) NULL,
		[ResourceLinkLocation] varchar(500) NULL,
		[ResourceEffectiveDate] datetime NULL,
		[ResourceInactivationDate] datetime NULL,
		[CMN_DepartmentRef] bigint NULL,
		[IsActive] bit NOT NULL,
		[UTCCreatedOn] DateTime NOT NULL,
		[CreatedByRef] bigint NOT NULL,
		[UTCLastUpdatedOn] DateTime NOT NULL,
		[LastUpdatedByRef] bigint NOT NULL,
		[UTCHistoryCreatedOn] datetime NOT NULL default(getutcdate()),
		[HistoryCreatedByRef] bigint NOT NULL,
		[SaveAttempt] bigint NOT NULL,
		CONSTRAINT [PK_ADM_ResourceDetailsHistory] PRIMARY KEY CLUSTERED ([ADM_ResourceDetailsHistoryId] ASC)
	)
End
GO


--ADM_UserMasterHistory
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ADM_UserMasterHistory]') AND type in (N'U'))
BEGIN
	CREATE TABLE [dbo].[ADM_UserMasterHistory](
		[ADM_UserMasterHistoryId] bigint IDENTITY(1,1) NOT NULL,
		[ADM_UserMasterRef] bigint NOT NULL,
		[LockedByRef] bigint NULL,
		[UTCLockedOn] datetime NULL,
		[Title] bigint NULL,
		[FirstName] varchar(100) NULL,
		[LastName] varchar(100) NULL,
		[FullName] varchar(250) NULL,
		[SystemFullName] varchar(250) NULL,
		[MSID] varchar(100) NOT NULL,
		[Email] varchar(100) NOT NULL,
		[IsManager] bit NOT NULL,
		[ManagerId] bigint NULL,
		[LocationLkup] bigint NULL,
		[NonUserLkup] bigint NULL,
		[StartDate] datetime NOT NULL,
		[EndDate] datetime NOT NULL,
		[SpecialistTitle] varchar(50) NULL,
		[SpecialistPhone] varchar(12) NULL,
		[SpecialistFax] varchar(12) NULL,
		[SpecialistHours] varchar(12) NULL,
		[SpecialistTimeZone] bigint NULL,
		[UserAddressLine1] varchar(100) NULL,
		[UserAddressLine2] varchar(100) NULL,
		[UserCity] varchar(50) NULL,
		[UserStateLkup] bigint NULL,
		[UserZip] varchar(10) NULL,
		[IsActive] bit NULL,
		[UTCCreatedOn] datetime NOT NULL,
		[CreatedByRef] bigint NOT NULL,
		[CreatedByRoleLkup] BIGINT NULL,
		[UTCLastUpdatedOn] datetime NULL,
		[LastUpdatedByRef] bigint NULL,
		[LastUpdatedByRoleLkup] BIGINT NULL,
		[UTCHistoryCreatedOn] datetime NOT NULL default(getutcdate()),
		[HistoryCreatedByRef] bigint NOT NULL,
		[HistoryCreatedByRoleLkup] BIGINT NULL,
		[SaveAttempt] bigint NOT NULL,
		CONSTRAINT [PK_ADM_UserMasterHistory] PRIMARY KEY CLUSTERED ([ADM_UserMasterHistoryId] ASC)
	)
End
GO


--ADM_UserPreferenceHistory
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ADM_UserPreferenceHistory]') AND type in (N'U'))
BEGIN
	CREATE TABLE [dbo].[ADM_UserPreferenceHistory](
		[ADM_UserPreferenceHistoryId] bigint IDENTITY(1,1) NOT NULL,
		[ADM_UserPreferenceRef] bigint NOT NULL,
		[ADM_UserMasterRef] bigint NOT NULL,
		[ShowAlerts] bit NOT NULL,
		[ShowResources] bit NOT NULL,
		[BusinessSegmentLkup] bigint NULL,
		[RoleLkup] bigint NULL,
		[TimezoneLkup] bigint NULL,
		[WorkBasketLkup] bigint NULL,
		[ShowOSTSummary] bit NOT NULL,
		[ShowEligibilitySummary] bit NOT NULL,
		[ShowRPRSummary] bit NOT NULL,
		[IsActive] bit NOT NULL,
		[UTCCreatedOn] datetime NOT NULL,
		[CreatedByRef] bigint NOT NULL,
		[UTCLastUpdatedOn] datetime NULL,
		[LastUpdatedByRef] bigint NULL,
		[UTCHistoryCreatedOn] datetime NOT NULL default(getutcdate()),
		[HistoryCreatedByRef] bigint NOT NULL,
		[SaveAttempt] bigint NOT NULL,
		CONSTRAINT [PK_ADM_UserPreferenceHistory] PRIMARY KEY CLUSTERED ([ADM_UserPreferenceHistoryId] ASC)
	)
End
GO


--ADM_SkillsMasterHistory
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ADM_SkillsMasterHistory]') AND type in (N'U'))
BEGIN
	CREATE TABLE [dbo].[ADM_SkillsMasterHistory](
		[ADM_SkillsMasterHistoryId] bigint IDENTITY(1,1) NOT NULL,
		[ADM_SkillsMasterRef] bigint NOT NULL,
		[LockedByRef] bigint NULL,
		[UTCLockedOn] datetime NULL,
		[SkillsName] varchar(200) NOT NULL,
		[RoleLkup] bigint NOT NULL,
		[BusinessSegmentLkup] bigint NOT NULL,
		[CMN_DepartmentRef] bigint NOT NULL,
		[WorkBasketLkup] bigint NOT NULL,
		[DiscrepancyCategoryLkup] bigint NOT NULL,
		[IsActive] bit NOT NULL,
		[UTCCreatedOn] datetime NOT NULL,
		[CreatedByRef] bigint NOT NULL,
		[UTCLastUpdatedOn] datetime NULL,
		[LastUpdatedByRef] bigint NULL,
		[UTCHistoryCreatedOn] datetime NOT NULL default(getutcdate()),
		[HistoryCreatedByRef] bigint NOT NULL,
		[SaveAttempt] bigint NOT NULL,
		CONSTRAINT [PK_ADM_SkillsMasterHistory] PRIMARY KEY CLUSTERED ([ADM_SkillsMasterHistoryId] ASC)
	)
End
GO


--ADM_SkillWorkQueuesCorrelationHistory
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ADM_SkillWorkQueuesCorrelationHistory]') AND type in (N'U'))
BEGIN
	CREATE TABLE [dbo].[ADM_SkillWorkQueuesCorrelationHistory](
		[ADM_SkillWorkQueuesCorrelationHistoryId] bigint IDENTITY(1,1) NOT NULL,
		[ADM_SkillWorkQueuesCorrelationRef] bigint NOT NULL,
		[ADM_SkillsMasterRef] bigint NOT NULL,		
		[WorkQueuesLkup] bigint NOT NULL,
		[IsActive] bit NOT NULL,
		[UTCCreatedOn] datetime NOT NULL,
		[CreatedByRef] bigint NOT NULL,
		[UTCLastUpdatedOn] datetime NULL,
		[LastUpdatedByRef] bigint NULL,
		[UTCHistoryCreatedOn] datetime NOT NULL default(getutcdate()),
		[HistoryCreatedByRef] bigint NOT NULL,
		[SaveAttempt] bigint NOT NULL,
		CONSTRAINT [PK_ADM_SkillWorkQueuesCorrelationHistory] PRIMARY KEY CLUSTERED ([ADM_SkillWorkQueuesCorrelationHistoryId] ASC)
	)
End
GO


--ADM_AccessGroupMasterHistory
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ADM_AccessGroupMasterHistory]') AND type in (N'U'))
BEGIN
	CREATE TABLE [dbo].[ADM_AccessGroupMasterHistory](
		[ADM_AccessGroupMasterHistoryId] bigint IDENTITY(1,1) NOT NULL,
		[ADM_AccessGroupMasterRef] bigint NOT NULL,
		[LockedByRef] bigint NULL,
		[UTCLockedOn] datetime NULL,
		[AccessGroupName] varchar(200) NOT NULL,
		[AccessGroupDescription] varchar(500) NULL,
		[RoleLkup] bigint NOT NULL,
		[WorkBasketLkup] bigint NOT NULL,
		[IsActive] bit NOT NULL,
		[UTCCreatedOn] datetime NOT NULL,
		[CreatedByRef] bigint NOT NULL,
		[UTCLastUpdatedOn] datetime NULL,
		[LastUpdatedByRef] bigint NULL,
		[UTCHistoryCreatedOn] datetime NOT NULL default(getutcdate()),
		[HistoryCreatedByRef] bigint NOT NULL,
		[SaveAttempt] bigint NOT NULL,
		CONSTRAINT [PK_ADM_AccessGroupMasterHistory] PRIMARY KEY CLUSTERED ([ADM_AccessGroupMasterHistoryId] ASC)
	)
End
GO


--ADM_AccessGroupSkillsCorrelationHistory
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ADM_AccessGroupSkillsCorrelationHistory]') AND type in (N'U'))
BEGIN
	CREATE TABLE [dbo].[ADM_AccessGroupSkillsCorrelationHistory](
		[ADM_AccessGroupSkillsCorrelationHistoryId] bigint IDENTITY(1,1) NOT NULL,
		[ADM_AccessGroupSkillsCorrelationRef] bigint NOT NULL,
		[ADM_AccessGroupMasterRef] bigint NOT NULL,
		[ADM_SkillsMasterRef] bigint NOT NULL,
		[CanCreate] bit NOT NULL default(0),
		[CanModify] bit NOT NULL default(0),
		[CanSearch] bit NOT NULL default(0),
		[CanView] bit NOT NULL,
		[CanMassUpdate] bit NOT NULL,
		[CanHistory] bit NOT NULL default(0),
		[CanReassign] bit NOT NULL default(0),
		[CanUnlock] bit NOT NULL default(0),
		[CanUpload] bit NOT NULL default(0),
		[CanClone] bit NOT NULL default(0),
		[CanReopen] bit NOT NULL default(0),
		[IsActive] bit NOT NULL,
		[UTCCreatedOn] datetime NOT NULL,
		[CreatedByRef] bigint NOT NULL,
		[UTCLastUpdatedOn] datetime NULL,
		[LastUpdatedByRef] bigint NULL,
		[UTCHistoryCreatedOn] datetime NOT NULL default(getutcdate()),
		[HistoryCreatedByRef] bigint NOT NULL,
		[SaveAttempt] bigint NOT NULL,
		CONSTRAINT [PK_ADM_AccessGroupSkillsCorrelationHistory] PRIMARY KEY CLUSTERED ([ADM_AccessGroupSkillsCorrelationHistoryId] ASC)
	)
End
GO


--ADM_AccessGroupReportCorrelationHistory
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ADM_AccessGroupReportCorrelationHistory]') AND type in (N'U'))
BEGIN
	CREATE TABLE [dbo].[ADM_AccessGroupReportCorrelationHistory](
		[ADM_AccessGroupReportCorrelationHistoryId] bigint IDENTITY(1,1) NOT NULL,
		[ADM_AccessGroupReportCorrelationRef] bigint NOT NULL,
		[ADM_AccessGroupMasterRef] bigint NOT NULL,
		[RPT_ReportsMasterRef] bigint NOT NULL,
		[IsActive] bit NOT NULL,
		[UTCCreatedOn] datetime NOT NULL,
		[CreatedByRef] bigint NOT NULL,
		[UTCLastUpdatedOn] datetime NULL,
		[LastUpdatedByRef] bigint NULL,
		[UTCHistoryCreatedOn] datetime NOT NULL default(getutcdate()),
		[HistoryCreatedByRef] bigint NOT NULL,
		[SaveAttempt] bigint NOT NULL,
		CONSTRAINT [PK_ADM_AccessGroupReportCorrelationHistory] PRIMARY KEY CLUSTERED ([ADM_AccessGroupReportCorrelationHistoryId] ASC)
	)
End
GO


--ADM_AccessGroupUserCorrelationHistory
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ADM_AccessGroupUserCorrelationHistory]') AND type in (N'U'))
BEGIN
	CREATE TABLE [dbo].[ADM_AccessGroupUserCorrelationHistory](
		[ADM_AccessGroupUserCorrelationHistoryId] bigint IDENTITY(1,1) NOT NULL,
		[ADM_AccessGroupUserCorrelationRef] bigint NOT NULL,
		[ADM_AccessGroupMasterRef] bigint NOT NULL,
		[ADM_UserMasterRef] bigint NOT NULL,
		[IsActive] bit NOT NULL,
		[UTCCreatedOn] datetime NOT NULL,
		[CreatedByRef] bigint NOT NULL,
		[CreatedByRoleLkup] bigint NULL,
		[UTCLastUpdatedOn] datetime NULL,
		[LastUpdatedByRef] bigint NULL,
		[LastUpdatedByRoleLkup] bigint NULL,
		[UTCHistoryCreatedOn] datetime NOT NULL default(getutcdate()),
		[HistoryCreatedByRef] bigint NOT NULL,
		[HistoryCreatedByRoleLkup] bigint NULL,
		[SaveAttempt] bigint NOT NULL,
		CONSTRAINT [PK_ADM_AccessGroupUserCorrelationHistory] PRIMARY KEY CLUSTERED ([ADM_AccessGroupUserCorrelationHistoryId] ASC)
	)
End
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TBL_UHC_OOA_MAPD_Grid]') AND type in (N'U'))
BEGIN
	CREATE TABLE [dbo].[TBL_UHC_OOA_MAPD_Grid](
		[SITE] [nvarchar](255) NULL,
		[Source_System] [nvarchar](255) NULL,
		[Contract_Year] [float] NULL,
		[Contract_Number] [nvarchar](255) NULL,
		[PBP] [nvarchar](255) NULL,
		[Corporate_Group_Number] [nvarchar](255) NULL,
		[Master_Group] [nvarchar](255) NULL,
		[Group_Number] [nvarchar](255) NULL,
		[Group_Name] [nvarchar](255) NULL,
		[Legal_Entity_Description] [nvarchar](255) NULL,
		[Market_Product_Name] [nvarchar](255) NULL,
		[G_I] [nvarchar](255) NULL,
		[ICyc] [nvarchar](255) NULL,
		[Business_Segment] [nvarchar](255) NULL,
		[BRAND] [nvarchar](255) NULL,
		[ProductType] [nvarchar](255) NULL,
		[SNP] [nvarchar](255) NULL,
		[SNP_Type] [nvarchar](255) NULL,
		[Location] [nvarchar](255) NULL,
		[Deluxe_Rider_Flag] [nvarchar](255) NULL,
		[Disproportional_Share_Flag] [nvarchar](255) NULL,
		[SPAP_Flag] [nvarchar](255) NULL,
		[Erickson_Flag] [nvarchar](255) NULL,
		[Region_Code] [nvarchar](255) NULL,
		[StateAbbreviation] [nvarchar](255) NULL,
		[CMS_State_Code] [nvarchar](255) NULL,
		[CMS_County_Code] [nvarchar](max) NULL,
		[CountyName] [nvarchar](max) NULL,
		[Drug_Coverage_Type] [nvarchar](255) NULL,
		[SubsidyLevel] [nvarchar](255) NULL,
		[Medical_Benefit_System_Code] [nvarchar](255) NULL,
		[Medical_Policy_System_Code] [nvarchar](255) NULL,
		[Medical_Legal_Entity] [nvarchar](255) NULL,
		[Medical_Financial_Product] [nvarchar](255) NULL,
		[Medical_Financial_Product2] [nvarchar](255) NULL,
		[Medical_Risk_Type] [nvarchar](255) NULL,
		[Medical_Panel] [nvarchar](255) NULL,
		[Medical_Premium] [money] NULL,
		[Medical_Effective_Date] [nvarchar](255) NULL,
		[Medical_Term_Date] [nvarchar](255) NULL,
		[DeluxeBenefit_System_Code] [nvarchar](255) NULL,
		[DeluxePolicy_System_Code] [nvarchar](255) NULL,
		[DeluxeLegal_Entity] [nvarchar](255) NULL,
		[DeluxeFinancial_Product] [nvarchar](255) NULL,
		[DeluxeRisk_Type] [nvarchar](255) NULL,
		[DeluxePanel] [nvarchar](255) NULL,
		[DeluxePremium] [nvarchar](255) NULL,
		[DeluxeEffective_Date] [nvarchar](255) NULL,
		[DeluxeTerm_Date] [nvarchar](255) NULL,
		[RxBenefit_System_Code] [nvarchar](255) NULL,
		[RxPolicy_System_Code] [nvarchar](255) NULL,
		[RxVendor_Name] [nvarchar](255) NULL,
		[RxLegal_Entity] [nvarchar](255) NULL,
		[RxFinancial_Product] [nvarchar](255) NULL,
		[RxRisk_Type] [nvarchar](255) NULL,
		[RxPanel] [nvarchar](255) NULL,
		[RxPremium] [money] NULL,
		[RxEffective_Date] [nvarchar](255) NULL,
		[RxTerm_Date] [nvarchar](255) NULL,
		[MHSABenefit_System_Code] [nvarchar](255) NULL,
		[MHSAPolicy_System_Code] [nvarchar](255) NULL,
		[MHSAVendor_Name] [nvarchar](255) NULL,
		[MHSALegal_Entity] [nvarchar](255) NULL,
		[MHSAFinancial_Product] [nvarchar](255) NULL,
		[MHSAFinancial_Product2] [nvarchar](255) NULL,
		[MHSARisk_Type] [nvarchar](255) NULL,
		[MHSAPanel] [nvarchar](255) NULL,
		[MHSAPremium] [nvarchar](255) NULL,
		[MHSAEffective_Date] [nvarchar](255) NULL,
		[MHSATerm_Date] [nvarchar](255) NULL,
		[DentalBenefit_System_Code] [nvarchar](255) NULL,
		[DentalPolicy_System_Code] [nvarchar](255) NULL,
		[DentalVendorName] [nvarchar](255) NULL,
		[DentalLegalEntity] [nvarchar](255) NULL,
		[DentalFinancial_Product] [nvarchar](255) NULL,
		[DentalRiskType] [nvarchar](255) NULL,
		[DentalPanel] [nvarchar](255) NULL,
		[DentalPremium] [money] NULL,
		[DentalEffective_Date] [nvarchar](255) NULL,
		[DentalTerm_Date] [nvarchar](255) NULL,
		[VisionBenefit_System_Code] [nvarchar](255) NULL,
		[VisionPolicy_System_Code] [nvarchar](255) NULL,
		[VisionVendor_Name] [nvarchar](255) NULL,
		[VisionLegal_Entity] [nvarchar](255) NULL,
		[VisionFinancial_Product] [nvarchar](255) NULL,
		[VisionRisk_Type] [nvarchar](255) NULL,
		[VisionPanel] [nvarchar](255) NULL,
		[VisionPremium] [nvarchar](255) NULL,
		[VisionEffective_Date] [nvarchar](255) NULL,
		[VisionTerm_Date] [nvarchar](255) NULL,
		[ATWBenefit_System_Code] [nvarchar](255) NULL,
		[ATWPolicy_System_Code] [nvarchar](255) NULL,
		[ATWVendor_Name] [nvarchar](255) NULL,
		[ATWRiskType] [nvarchar](255) NULL,
		[ATWEffectiveDate] [nvarchar](255) NULL,
		[ATWTerm_Date] [nvarchar](255) NULL,
		[RespiteBenefit_System_Code] [nvarchar](255) NULL,
		[RespitePolicy_System_Code] [nvarchar](255) NULL,
		[RespiteVendor_Name] [nvarchar](255) NULL,
		[RespiteRisk_Type] [nvarchar](255) NULL,
		[RespiteEffective_Date] [nvarchar](255) NULL,
		[RespiteTerm_Date] [nvarchar](255) NULL,
		[ChiroBenefit_System_Code] [nvarchar](255) NULL,
		[ChiroPolicy_System_Code] [nvarchar](255) NULL,
		[ChiroVendor_Name] [nvarchar](255) NULL,
		[ChiroRisk_Type] [nvarchar](255) NULL,
		[ChiroPremium] [nvarchar](255) NULL,
		[ChiroEffective_Date] [nvarchar](255) NULL,
		[ChiroTerm_Date] [nvarchar](255) NULL,
		[ACUBenefit_System_Code] [nvarchar](255) NULL,
		[ACUPolicy_System_Code] [nvarchar](255) NULL,
		[ACUVendor_Name] [nvarchar](255) NULL,
		[ACURisk_Type] [nvarchar](255) NULL,
		[ACUPremium] [nvarchar](255) NULL,
		[ACUEffective_Date] [nvarchar](255) NULL,
		[ACUTerm_Date] [nvarchar](255) NULL,
		[MassageBenefit_System_Code] [nvarchar](255) NULL,
		[MassagePolicy_System_Code] [nvarchar](255) NULL,
		[MassageVendor_Name] [nvarchar](255) NULL,
		[MassageRisk_Type] [nvarchar](255) NULL,
		[MassageEffective_Date] [nvarchar](255) NULL,
		[MassageTerm_Date] [nvarchar](255) NULL,
		[FitnessBenefit_System_Code] [nvarchar](255) NULL,
		[FitnessPolicy_System_Code] [nvarchar](255) NULL,
		[FitnessVendor_Name] [nvarchar](255) NULL,
		[FitnessRisk_Type] [nvarchar](255) NULL,
		[FitnessPremium] [money] NULL,
		[FitnessEffective_Date] [nvarchar](255) NULL,
		[FitnessTerm_Date] [nvarchar](255) NULL,
		[HearingBenefit_System_Code] [nvarchar](255) NULL,
		[HearingPolicy_System_Code] [nvarchar](255) NULL,
		[HearingVendor_Name] [nvarchar](255) NULL,
		[HearingRisk_Type] [nvarchar](255) NULL,
		[HearingPremium] [nvarchar](255) NULL,
		[HearingEffective_Date] [nvarchar](255) NULL,
		[HearingTerm_Date] [nvarchar](255) NULL,
		[PodiatryBenefit_System_Code] [nvarchar](255) NULL,
		[PodiatryPolicy_System_Code] [nvarchar](255) NULL,
		[PodiatryVendor_Name] [nvarchar](255) NULL,
		[PodiatryRisk_Type] [nvarchar](255) NULL,
		[PodiatryEffective_Date] [nvarchar](255) NULL,
		[PodiatryTerm_Date] [nvarchar](255) NULL,
		[Non-Emergency_TransportationBenefit_System_Code] [nvarchar](255) NULL,
		[Non-Emergency_TransportationPolicy_System_Code] [nvarchar](255) NULL,
		[Non-Emergency_TransportationVendor_Name] [nvarchar](255) NULL,
		[Non-Emergency_TransportationRisk_Type] [nvarchar](255) NULL,
		[Non-Emergency_TransportationPremium] [nvarchar](255) NULL,
		[Non-Emergency_TransportationEffective_Date] [nvarchar](255) NULL,
		[Non-Emergency_TransportationTerm_Date] [nvarchar](255) NULL,
		[PHBBenefit_System_Code] [nvarchar](255) NULL,
		[PHBPolicy_System_Code] [nvarchar](255) NULL,
		[PHBVendor_Name] [nvarchar](255) NULL,
		[PHBRisk_Type] [nvarchar](255) NULL,
		[PHBEffective_Date] [nvarchar](255) NULL,
		[PHBTerm_Date] [nvarchar](255) NULL,
		[Nurseline_Benefit_System_Code] [nvarchar](255) NULL,
		[Nurseline_Policy_System_Code] [nvarchar](255) NULL,
		[Nurseline_Vendor_Name] [nvarchar](255) NULL,
		[Nurseline_Risk_Type] [nvarchar](255) NULL,
		[Nurseline_Premium] [nvarchar](255) NULL,
		[Nurseline_Effective_Date] [nvarchar](255) NULL,
		[Nurseline_Term_Date] [nvarchar](255) NULL,
		[Care_Giver_Benefit_System_Code] [nvarchar](255) NULL,
		[Care_Giver_Policy_System_Code] [nvarchar](255) NULL,
		[Care_Giver_Vendor_Name] [nvarchar](255) NULL,
		[Care_Giver_Risk_Type] [nvarchar](255) NULL,
		[Care_Giver_Premium] [nvarchar](255) NULL,
		[Care_Giver_Effective_Date] [nvarchar](255) NULL,
		[Care_Giver_Term_Date] [nvarchar](255) NULL,
		[Wellness_Vendor_Name] [nvarchar](255) NULL,
		[Wellness_Effective_Date] [nvarchar](255) NULL,
		[Wellness_Term_Date] [nvarchar](255) NULL,
		[Nutrition_Vendor_Name] [nvarchar](255) NULL,
		[Nutrition_Effective_Date] [nvarchar](255) NULL,
		[Nutrition_Term_Date] [nvarchar](255) NULL,
		[Plus_Benefit_System_Code] [nvarchar](255) NULL,
		[Plus_Policy_System_Code] [nvarchar](255) NULL,
		[Plus_Vendor_Name] [nvarchar](255) NULL,
		[Plus_Risk_Type] [nvarchar](255) NULL,
		[Plus_Panel] [nvarchar](255) NULL,
		[Plus_Premium] [nvarchar](255) NULL,
		[Plus_Effective_Date] [nvarchar](255) NULL,
		[Plus_Term_Date] [nvarchar](255) NULL,
		[PeopleSoft_Business_Unit] [nvarchar](255) NULL,
		[PeopleSoft_Location] [nvarchar](255) NULL,
		[PeopleSoft_Product] [nvarchar](255) NULL,
		[PeopleSoft_Financial_Arrangement] [nvarchar](255) NULL,
		[Closed_to_New_Enrollment] [nvarchar](255) NULL,
		[Processing_Rules] [nvarchar](255) NULL,
		[Group_Effective_Date] [datetime] NULL,
		[Group_Term_Date] [datetime] NULL,
		[ChangeType] [nvarchar](255) NULL,
		[GPSEmployerID] [nvarchar](255) NULL,
		[GPSBranchID] [nvarchar](255) NULL,
		[PlanLongName] [nvarchar](255) NULL,
		[ISPCPRequired] [nvarchar](255) NULL,
		[Gatekeeper_Open_Access_Specialist_Self_Referral] [nvarchar](255) NULL,
		[Passport_Indicator] [nvarchar](255) NULL
	)
End
GO

--CMN_RecordsLockedHistory
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CMN_RecordsLockedHistory]') AND type in (N'U'))
BEGIN
	CREATE TABLE [dbo].[CMN_RecordsLockedHistory](
		[CMN_RecordsLockedHistoryId] bigint IDENTITY(1,1) NOT NULL,
		[CMN_RecordsLockedRef] bigint NOT NULL,
		[ScreenLkup] bigint NOT NULL,
		[CaseId] bigint NOT NULL,
		[StartTime] datetime NOT NULL,
		[EndTime] datetime NULL,
		[Guid] char(40) NULL,
		[IsActive] bit NOT NULL,
		[UTCCreatedOn] datetime NOT NULL,
		[CreatedByRef] bigint NOT NULL,
		[UTCLastUpdatedOn] datetime NULL,
		[LastUpdatedByRef] bigint NULL,
		[UTCHistoryCreatedOn] datetime NOT NULL default(getutcdate()),
		[HistoryCreatedByRef] bigint NOT NULL,
		CONSTRAINT [PK_CMN_RecordsLockedHistory] PRIMARY KEY CLUSTERED ([CMN_RecordsLockedHistoryId] ASC)
	)
End
GO

