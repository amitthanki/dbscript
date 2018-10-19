
--ADM_AccessGroupMaster
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_LockedByRef_ADM_AccessGroupMaster' AND OBJECT_ID=OBJECT_ID('ADM_AccessGroupMaster'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_LockedByRef_ADM_AccessGroupMaster on ADM_AccessGroupMaster(LockedByRef)
END 
GO
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_AccessGroupName_ADM_AccessGroupMaster' AND OBJECT_ID=OBJECT_ID('ADM_AccessGroupMaster'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_AccessGroupName_ADM_AccessGroupMaster on ADM_AccessGroupMaster(AccessGroupName)
END 
GO
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_CreatedByRef_ADM_AccessGroupMaster' AND OBJECT_ID=OBJECT_ID('ADM_AccessGroupMaster'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_CreatedByRef_ADM_AccessGroupMaster on ADM_AccessGroupMaster(CreatedByRef)
END 
GO
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_LastUpdatedByRef_ADM_AccessGroupMaster' AND OBJECT_ID=OBJECT_ID('ADM_AccessGroupMaster'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_LastUpdatedByRef_ADM_AccessGroupMaster on ADM_AccessGroupMaster(LastUpdatedByRef)
END 
GO
--ADM_AccessGroupReportCorrelation
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_RPT_ReportsMasterRef_ADM_AccessGroupReportCorrelation' AND OBJECT_ID=OBJECT_ID('ADM_AccessGroupReportCorrelation'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_RPT_ReportsMasterRef_ADM_AccessGroupReportCorrelation on ADM_AccessGroupReportCorrelation(RPT_ReportsMasterRef)
END 
GO
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_CreatedByRef_ADM_AccessGroupReportCorrelation' AND OBJECT_ID=OBJECT_ID('ADM_AccessGroupReportCorrelation'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_CreatedByRef_ADM_AccessGroupReportCorrelation on ADM_AccessGroupReportCorrelation(CreatedByRef)
END 
GO
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_LastUpdatedByRef_ADM_AccessGroupReportCorrelation' AND OBJECT_ID=OBJECT_ID('ADM_AccessGroupReportCorrelation'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_LastUpdatedByRef_ADM_AccessGroupReportCorrelation on ADM_AccessGroupReportCorrelation(LastUpdatedByRef)
END 
GO
--ADM_AccessGroupSkillsCorrelation
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_ADM_AccessGroupMasterRef_ADM_AccessGroupSkillsCorrelation' AND OBJECT_ID=OBJECT_ID('ADM_AccessGroupSkillsCorrelation'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_ADM_AccessGroupMasterRef_ADM_AccessGroupSkillsCorrelation on ADM_AccessGroupSkillsCorrelation(ADM_AccessGroupMasterRef)
END 
GO
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_ADM_SkillsMasterRef_ADM_AccessGroupSkillsCorrelation' AND OBJECT_ID=OBJECT_ID('ADM_AccessGroupSkillsCorrelation'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_ADM_SkillsMasterRef_ADM_AccessGroupSkillsCorrelation on ADM_AccessGroupSkillsCorrelation(ADM_SkillsMasterRef)
END 
GO
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_CreatedByRef_ADM_AccessGroupSkillsCorrelation' AND OBJECT_ID=OBJECT_ID('ADM_AccessGroupSkillsCorrelation'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_CreatedByRef_ADM_AccessGroupSkillsCorrelation on ADM_AccessGroupSkillsCorrelation(CreatedByRef)
END 
GO
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_LastUpdatedByRef_ADM_AccessGroupSkillsCorrelation' AND OBJECT_ID=OBJECT_ID('ADM_AccessGroupSkillsCorrelation'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_LastUpdatedByRef_ADM_AccessGroupSkillsCorrelation on ADM_AccessGroupSkillsCorrelation(LastUpdatedByRef)
END 
GO
--ADM_AccessGroupUserCorrelation
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_ADM_AccessGroupMasterRef_ADM_AccessGroupUserCorrelation' AND OBJECT_ID=OBJECT_ID('ADM_AccessGroupUserCorrelation'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_ADM_AccessGroupMasterRef_ADM_AccessGroupUserCorrelation on ADM_AccessGroupUserCorrelation(ADM_AccessGroupMasterRef)
END 
GO
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_ADM_UserMasterRef_ADM_AccessGroupUserCorrelation' AND OBJECT_ID=OBJECT_ID('ADM_AccessGroupUserCorrelation'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_ADM_UserMasterRef_ADM_AccessGroupUserCorrelation on ADM_AccessGroupUserCorrelation(ADM_UserMasterRef)
END 
GO
--ADM_AccessGroupUserCorrelationHistory
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_ADM_AccessGroupUserCorrelationRef_ADM_AccessGroupUserCorrelationHistory' AND OBJECT_ID=OBJECT_ID('ADM_AccessGroupUserCorrelationHistory'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_ADM_AccessGroupUserCorrelationRef_ADM_AccessGroupUserCorrelationHistory on ADM_AccessGroupUserCorrelationHistory(ADM_AccessGroupUserCorrelationRef)
END 
GO
--ADM_AlertDetails
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_LockedByRef_ADM_AlertDetails' AND OBJECT_ID=OBJECT_ID('ADM_AlertDetails'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_LockedByRef_ADM_AlertDetails on ADM_AlertDetails(LockedByRef)
END 
GO
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_AlertTitle_ADM_AlertDetails' AND OBJECT_ID=OBJECT_ID('ADM_AlertDetails'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_AlertTitle_ADM_AlertDetails on ADM_AlertDetails(AlertTitle)
END 
GO
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_AlertEffectiveDate_ADM_AlertDetails' AND OBJECT_ID=OBJECT_ID('ADM_AlertDetails'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_AlertEffectiveDate_ADM_AlertDetails on ADM_AlertDetails(AlertEffectiveDate)
END 
GO
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_AlertInactivationDate_ADM_AlertDetails' AND OBJECT_ID=OBJECT_ID('ADM_AlertDetails'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_AlertInactivationDate_ADM_AlertDetails on ADM_AlertDetails(AlertInactivationDate)
END 
GO
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_AlertCriticalityLkup_ADM_AlertDetails' AND OBJECT_ID=OBJECT_ID('ADM_AlertDetails'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_AlertCriticalityLkup_ADM_AlertDetails on ADM_AlertDetails(AlertCriticalityLkup)
END 
GO
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_SendAlertToLkup_ADM_AlertDetails' AND OBJECT_ID=OBJECT_ID('ADM_AlertDetails'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_SendAlertToLkup_ADM_AlertDetails on ADM_AlertDetails(SendAlertToLkup)
END 
GO
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_CMN_DepartmentRef_ADM_AlertDetails' AND OBJECT_ID=OBJECT_ID('ADM_AlertDetails'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_CMN_DepartmentRef_ADM_AlertDetails on ADM_AlertDetails(CMN_DepartmentRef)
END 
GO
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_ADM_UserMasterRef_ADM_AlertDetails' AND OBJECT_ID=OBJECT_ID('ADM_AlertDetails'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_ADM_UserMasterRef_ADM_AlertDetails on ADM_AlertDetails(ADM_UserMasterRef)
END 
GO
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_CreatedByRef_ADM_AlertDetails' AND OBJECT_ID=OBJECT_ID('ADM_AlertDetails'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_CreatedByRef_ADM_AlertDetails on ADM_AlertDetails(CreatedByRef)
END 
GO
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_LastUpdatedByRef_ADM_AlertDetails' AND OBJECT_ID=OBJECT_ID('ADM_AlertDetails'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_LastUpdatedByRef_ADM_AlertDetails on ADM_AlertDetails(LastUpdatedByRef)
END 
GO
--ADM_AlertDetailsHistory
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_ADM_AlertDetailsRef_ADM_AlertDetailsHistory' AND OBJECT_ID=OBJECT_ID('ADM_AlertDetailsHistory'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_ADM_AlertDetailsRef_ADM_AlertDetailsHistory on ADM_AlertDetailsHistory(ADM_AlertDetailsRef)
END 
GO
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_LockedByRef_ADM_AlertDetailsHistory' AND OBJECT_ID=OBJECT_ID('ADM_AlertDetailsHistory'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_LockedByRef_ADM_AlertDetailsHistory on ADM_AlertDetailsHistory(LockedByRef)
END 
GO
--ADM_ResourceDetails
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_LockedByRef_ADM_ResourceDetails' AND OBJECT_ID=OBJECT_ID('ADM_ResourceDetails'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_LockedByRef_ADM_ResourceDetails on ADM_ResourceDetails(LockedByRef)
END 
GO
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_ResourceName_ADM_ResourceDetails' AND OBJECT_ID=OBJECT_ID('ADM_ResourceDetails'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_ResourceName_ADM_ResourceDetails on ADM_ResourceDetails(ResourceName)
END 
GO
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_ResourceLinkLocation_ADM_ResourceDetails' AND OBJECT_ID=OBJECT_ID('ADM_ResourceDetails'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_ResourceLinkLocation_ADM_ResourceDetails on ADM_ResourceDetails(ResourceLinkLocation)
END 
GO
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_ResourceEffectiveDate_ADM_ResourceDetails' AND OBJECT_ID=OBJECT_ID('ADM_ResourceDetails'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_ResourceEffectiveDate_ADM_ResourceDetails on ADM_ResourceDetails(ResourceEffectiveDate)
END 
GO
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_ResourceInactivationDate_ADM_ResourceDetails' AND OBJECT_ID=OBJECT_ID('ADM_ResourceDetails'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_ResourceInactivationDate_ADM_ResourceDetails on ADM_ResourceDetails(ResourceInactivationDate)
END 
GO
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_CMN_DepartmentRef_ADM_ResourceDetails' AND OBJECT_ID=OBJECT_ID('ADM_ResourceDetails'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_CMN_DepartmentRef_ADM_ResourceDetails on ADM_ResourceDetails(CMN_DepartmentRef)
END 
GO
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_CreatedByRef_ADM_ResourceDetails' AND OBJECT_ID=OBJECT_ID('ADM_ResourceDetails'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_CreatedByRef_ADM_ResourceDetails on ADM_ResourceDetails(CreatedByRef)
END 
GO
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_LastUpdatedByRef_ADM_ResourceDetails' AND OBJECT_ID=OBJECT_ID('ADM_ResourceDetails'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_LastUpdatedByRef_ADM_ResourceDetails on ADM_ResourceDetails(LastUpdatedByRef)
END 
GO
--ADM_ResourceDetailsHistory
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_ADM_ResourceDetailsRef_ADM_ResourceDetailsHistory' AND OBJECT_ID=OBJECT_ID('ADM_ResourceDetailsHistory'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_ADM_ResourceDetailsRef_ADM_ResourceDetailsHistory on ADM_ResourceDetailsHistory(ADM_ResourceDetailsRef)
END 
GO
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_LastUpdatedByRef_ADM_ResourceDetailsHistory' AND OBJECT_ID=OBJECT_ID('ADM_ResourceDetailsHistory'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_LastUpdatedByRef_ADM_ResourceDetailsHistory on ADM_ResourceDetailsHistory(LastUpdatedByRef)
END 
GO
--ADM_SkillsMaster
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_LockedByRef_ADM_SkillsMaster' AND OBJECT_ID=OBJECT_ID('ADM_SkillsMaster'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_LockedByRef_ADM_SkillsMaster on ADM_SkillsMaster(LockedByRef)
END 
GO
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_SkillsName_ADM_SkillsMaster' AND OBJECT_ID=OBJECT_ID('ADM_SkillsMaster'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_SkillsName_ADM_SkillsMaster on ADM_SkillsMaster(SkillsName)
END 
GO
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_RoleLkup_ADM_SkillsMaster' AND OBJECT_ID=OBJECT_ID('ADM_SkillsMaster'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_RoleLkup_ADM_SkillsMaster on ADM_SkillsMaster(RoleLkup)
END 
GO
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_BusinessSegmentLkup_ADM_SkillsMaster' AND OBJECT_ID=OBJECT_ID('ADM_SkillsMaster'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_BusinessSegmentLkup_ADM_SkillsMaster on ADM_SkillsMaster(BusinessSegmentLkup)
END 
GO
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_CMN_DepartmentRef_ADM_SkillsMaster' AND OBJECT_ID=OBJECT_ID('ADM_SkillsMaster'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_CMN_DepartmentRef_ADM_SkillsMaster on ADM_SkillsMaster(CMN_DepartmentRef)
END 
GO
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_WorkBasketLkup_ADM_SkillsMaster' AND OBJECT_ID=OBJECT_ID('ADM_SkillsMaster'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_WorkBasketLkup_ADM_SkillsMaster on ADM_SkillsMaster(WorkBasketLkup)
END 
GO
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_CreatedByRef_ADM_SkillsMaster' AND OBJECT_ID=OBJECT_ID('ADM_SkillsMaster'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_CreatedByRef_ADM_SkillsMaster on ADM_SkillsMaster(CreatedByRef)
END 
GO
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_LastUpdatedByRef_ADM_SkillsMaster' AND OBJECT_ID=OBJECT_ID('ADM_SkillsMaster'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_LastUpdatedByRef_ADM_SkillsMaster on ADM_SkillsMaster(LastUpdatedByRef)
END 
GO
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_DiscrepancyCategoryLkup_ADM_SkillsMaster' AND OBJECT_ID=OBJECT_ID('ADM_SkillsMaster'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_DiscrepancyCategoryLkup_ADM_SkillsMaster on ADM_SkillsMaster(DiscrepancyCategoryLkup)
END 
GO
--ADM_SkillsMasterHistory
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_ADM_SkillsMasterRef_ADM_SkillsMasterHistory' AND OBJECT_ID=OBJECT_ID('ADM_SkillsMasterHistory'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_ADM_SkillsMasterRef_ADM_SkillsMasterHistory on ADM_SkillsMasterHistory(ADM_SkillsMasterRef)
END 
GO
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_LastUpdatedByRef_ADM_SkillsMasterHistory' AND OBJECT_ID=OBJECT_ID('ADM_SkillsMasterHistory'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_LastUpdatedByRef_ADM_SkillsMasterHistory on ADM_SkillsMasterHistory(LastUpdatedByRef)
END 
GO
--ADM_SkillWorkQueuesCorrelation
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_ADM_SkillsMasterRef_ADM_SkillWorkQueuesCorrelation' AND OBJECT_ID=OBJECT_ID('ADM_SkillWorkQueuesCorrelation'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_ADM_SkillsMasterRef_ADM_SkillWorkQueuesCorrelation on ADM_SkillWorkQueuesCorrelation(ADM_SkillsMasterRef)
END 
GO
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_WorkQueuesLkup_ADM_SkillWorkQueuesCorrelation' AND OBJECT_ID=OBJECT_ID('ADM_SkillWorkQueuesCorrelation'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_WorkQueuesLkup_ADM_SkillWorkQueuesCorrelation on ADM_SkillWorkQueuesCorrelation(WorkQueuesLkup)
END 
GO
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_CreatedByRef_ADM_SkillWorkQueuesCorrelation' AND OBJECT_ID=OBJECT_ID('ADM_SkillWorkQueuesCorrelation'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_CreatedByRef_ADM_SkillWorkQueuesCorrelation on ADM_SkillWorkQueuesCorrelation(CreatedByRef)
END 
GO
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_LastUpdatedByRef_ADM_SkillWorkQueuesCorrelation' AND OBJECT_ID=OBJECT_ID('ADM_SkillWorkQueuesCorrelation'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_LastUpdatedByRef_ADM_SkillWorkQueuesCorrelation on ADM_SkillWorkQueuesCorrelation(LastUpdatedByRef)
END 
GO
--ADM_UserMaster
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_FullName_ADM_UserMaster' AND OBJECT_ID=OBJECT_ID('ADM_UserMaster'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_FullName_ADM_UserMaster on ADM_UserMaster(FullName)
END 
GO
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_MSID_ADM_UserMaster' AND OBJECT_ID=OBJECT_ID('ADM_UserMaster'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_MSID_ADM_UserMaster on ADM_UserMaster(MSID)
END 
GO
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_Email_ADM_UserMaster' AND OBJECT_ID=OBJECT_ID('ADM_UserMaster'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_Email_ADM_UserMaster on ADM_UserMaster(Email)
END 
GO
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_IsManager_ADM_UserMaster' AND OBJECT_ID=OBJECT_ID('ADM_UserMaster'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_IsManager_ADM_UserMaster on ADM_UserMaster(IsManager)
END 
GO
--ADM_UserPreference
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_ADM_UserMasterRef_ADM_UserPreference' AND OBJECT_ID=OBJECT_ID('ADM_UserPreference'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_ADM_UserMasterRef_ADM_UserPreference on ADM_UserPreference(ADM_UserMasterRef)
END 
GO
--CMN_Department
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_LockedByRef_CMN_Department' AND OBJECT_ID=OBJECT_ID('CMN_Department'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_LockedByRef_CMN_Department on CMN_Department(LockedByRef)
END 
GO
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_ERSDepartmentName_CMN_Department' AND OBJECT_ID=OBJECT_ID('CMN_Department'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_ERSDepartmentName_CMN_Department on CMN_Department(ERSDepartmentName)
END 
GO
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_BusinessSegmentLkup_CMN_Department' AND OBJECT_ID=OBJECT_ID('CMN_Department'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_BusinessSegmentLkup_CMN_Department on CMN_Department(BusinessSegmentLkup)
END 
GO
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_DepartmentLkup_CMN_Department' AND OBJECT_ID=OBJECT_ID('CMN_Department'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_DepartmentLkup_CMN_Department on CMN_Department(DepartmentLkup)
END 
GO
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_CreatedByRef_CMN_Department' AND OBJECT_ID=OBJECT_ID('CMN_Department'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_CreatedByRef_CMN_Department on CMN_Department(CreatedByRef)
END 
GO
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_LastUpdatedByRef_CMN_Department' AND OBJECT_ID=OBJECT_ID('CMN_Department'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_LastUpdatedByRef_CMN_Department on CMN_Department(LastUpdatedByRef)
END 
GO
--CMN_DepartmentHistory
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_CMN_DepartmentRef_CMN_DepartmentHistory' AND OBJECT_ID=OBJECT_ID('CMN_DepartmentHistory'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_CMN_DepartmentRef_CMN_DepartmentHistory on CMN_DepartmentHistory(CMN_DepartmentRef)
END 
GO
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_LockedByRef_CMN_DepartmentHistory' AND OBJECT_ID=OBJECT_ID('CMN_DepartmentHistory'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_LockedByRef_CMN_DepartmentHistory on CMN_DepartmentHistory(LockedByRef)
END 
GO
--CMN_LookupMaster
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_CMN_LookupTypeRef_CMN_LookupMaster' AND OBJECT_ID=OBJECT_ID('CMN_LookupMaster'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_CMN_LookupTypeRef_CMN_LookupMaster on CMN_LookupMaster(CMN_LookupTypeRef)
END 
GO
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_CreatedByRef_CMN_LookupMaster' AND OBJECT_ID=OBJECT_ID('CMN_LookupMaster'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_CreatedByRef_CMN_LookupMaster on CMN_LookupMaster(CreatedByRef)
END 
GO
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_LastUpdatedByRef_CMN_LookupMaster' AND OBJECT_ID=OBJECT_ID('CMN_LookupMaster'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_LastUpdatedByRef_CMN_LookupMaster on CMN_LookupMaster(LastUpdatedByRef)
END 
GO
--CMN_LookupMasterCorrelations
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_CMN_LookupTypeCorrelationsRef_CMN_LookupMasterCorrelations' AND OBJECT_ID=OBJECT_ID('CMN_LookupMasterCorrelations'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_CMN_LookupTypeCorrelationsRef_CMN_LookupMasterCorrelations on CMN_LookupMasterCorrelations(CMN_LookupTypeCorrelationsRef)
END 
GO
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_CMN_LookupMasterChildRef_CMN_LookupMasterCorrelations' AND OBJECT_ID=OBJECT_ID('CMN_LookupMasterCorrelations'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_CMN_LookupMasterChildRef_CMN_LookupMasterCorrelations on CMN_LookupMasterCorrelations(CMN_LookupMasterChildRef)
END 
GO
--CMN_LookupMasterCorrelationsHistory
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_CMN_LookupMasterCorrelationsRef_CMN_LookupMasterCorrelationsHistory' AND OBJECT_ID=OBJECT_ID('CMN_LookupMasterCorrelationsHistory'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_CMN_LookupMasterCorrelationsRef_CMN_LookupMasterCorrelationsHistory on CMN_LookupMasterCorrelationsHistory(CMN_LookupMasterCorrelationsRef)
END 
GO
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_LastUpdatedByRef_CMN_LookupMasterCorrelationsHistory' AND OBJECT_ID=OBJECT_ID('CMN_LookupMasterCorrelationsHistory'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_LastUpdatedByRef_CMN_LookupMasterCorrelationsHistory on CMN_LookupMasterCorrelationsHistory(LastUpdatedByRef)
END 
GO
--CMN_LookupMasterHistory
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_CMN_LookupMasterRef_CMN_LookupMasterHistory' AND OBJECT_ID=OBJECT_ID('CMN_LookupMasterHistory'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_CMN_LookupMasterRef_CMN_LookupMasterHistory on CMN_LookupMasterHistory(CMN_LookupMasterRef)
END 
GO
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_LastUpdatedByRef_CMN_LookupMasterHistory' AND OBJECT_ID=OBJECT_ID('CMN_LookupMasterHistory'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_LastUpdatedByRef_CMN_LookupMasterHistory on CMN_LookupMasterHistory(LastUpdatedByRef)
END 
GO
--CMN_LookupType
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_LockedByRef_CMN_LookupType' AND OBJECT_ID=OBJECT_ID('CMN_LookupType'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_LockedByRef_CMN_LookupType on CMN_LookupType(LockedByRef)
END 
GO
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_LookupTypeDescription_CMN_LookupType' AND OBJECT_ID=OBJECT_ID('CMN_LookupType'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_LookupTypeDescription_CMN_LookupType on CMN_LookupType(LookupTypeDescription)
END 
GO
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_CreatedByRef_CMN_LookupType' AND OBJECT_ID=OBJECT_ID('CMN_LookupType'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_CreatedByRef_CMN_LookupType on CMN_LookupType(CreatedByRef)
END 
GO
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_LastUpdatedByRef_CMN_LookupType' AND OBJECT_ID=OBJECT_ID('CMN_LookupType'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_LastUpdatedByRef_CMN_LookupType on CMN_LookupType(LastUpdatedByRef)
END 
GO
--CMN_LookupTypeCorrelations
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_CMN_LookupTypeParentRef_CMN_LookupTypeCorrelations' AND OBJECT_ID=OBJECT_ID('CMN_LookupTypeCorrelations'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_CMN_LookupTypeParentRef_CMN_LookupTypeCorrelations on CMN_LookupTypeCorrelations(CMN_LookupTypeParentRef)
END 
GO
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_CMN_LookupTypeChildRef_CMN_LookupTypeCorrelations' AND OBJECT_ID=OBJECT_ID('CMN_LookupTypeCorrelations'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_CMN_LookupTypeChildRef_CMN_LookupTypeCorrelations on CMN_LookupTypeCorrelations(CMN_LookupTypeChildRef)
END 
GO
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_GroupingLookupTypeRef_CMN_LookupTypeCorrelations' AND OBJECT_ID=OBJECT_ID('CMN_LookupTypeCorrelations'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_GroupingLookupTypeRef_CMN_LookupTypeCorrelations on CMN_LookupTypeCorrelations(GroupingLookupTypeRef)
END 
GO
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_LockedByRef_CMN_LookupTypeCorrelations' AND OBJECT_ID=OBJECT_ID('CMN_LookupTypeCorrelations'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_LockedByRef_CMN_LookupTypeCorrelations on CMN_LookupTypeCorrelations(LockedByRef)
END 
GO
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_CreatedByRef_CMN_LookupTypeCorrelations' AND OBJECT_ID=OBJECT_ID('CMN_LookupTypeCorrelations'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_CreatedByRef_CMN_LookupTypeCorrelations on CMN_LookupTypeCorrelations(CreatedByRef)
END 
GO
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_LastUpdatedByRef_CMN_LookupTypeCorrelations' AND OBJECT_ID=OBJECT_ID('CMN_LookupTypeCorrelations'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_LastUpdatedByRef_CMN_LookupTypeCorrelations on CMN_LookupTypeCorrelations(LastUpdatedByRef)
END 
GO
--CMN_LookupTypeCorrelationsHistory
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_CMN_LookupTypeCorrelationsRef_CMN_LookupTypeCorrelationsHistory' AND OBJECT_ID=OBJECT_ID('CMN_LookupTypeCorrelationsHistory'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_CMN_LookupTypeCorrelationsRef_CMN_LookupTypeCorrelationsHistory on CMN_LookupTypeCorrelationsHistory(CMN_LookupTypeCorrelationsRef)
END 
GO
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_LastUpdatedByRef_CMN_LookupTypeCorrelationsHistory' AND OBJECT_ID=OBJECT_ID('CMN_LookupTypeCorrelationsHistory'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_LastUpdatedByRef_CMN_LookupTypeCorrelationsHistory on CMN_LookupTypeCorrelationsHistory(LastUpdatedByRef)
END 
GO
--CMN_LookupTypeHistory
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_CMN_LookupTypeRef_CMN_LookupTypeHistory' AND OBJECT_ID=OBJECT_ID('CMN_LookupTypeHistory'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_CMN_LookupTypeRef_CMN_LookupTypeHistory on CMN_LookupTypeHistory(CMN_LookupTypeRef)
END 
GO
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_LastUpdatedByRef_CMN_LookupTypeHistory' AND OBJECT_ID=OBJECT_ID('CMN_LookupTypeHistory'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_LastUpdatedByRef_CMN_LookupTypeHistory on CMN_LookupTypeHistory(LastUpdatedByRef)
END 
GO
--CMN_RecordsLocked
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_CaseId_CMN_RecordsLocked' AND OBJECT_ID=OBJECT_ID('CMN_RecordsLocked'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_CaseId_CMN_RecordsLocked on CMN_RecordsLocked(CaseId)
END 
GO
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_CreatedByRef_CMN_RecordsLocked' AND OBJECT_ID=OBJECT_ID('CMN_RecordsLocked'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_CreatedByRef_CMN_RecordsLocked on CMN_RecordsLocked(CreatedByRef)
END 
GO
--GEN_Attachments
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_GEN_QueueRef_GEN_Attachments' AND OBJECT_ID=OBJECT_ID('GEN_Attachments'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_GEN_QueueRef_GEN_Attachments on GEN_Attachments(GEN_QueueRef)
END 
GO
--GEN_BulkImport
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_WorkBasketLkup_GEN_BulkImport' AND OBJECT_ID=OBJECT_ID('GEN_BulkImport'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_WorkBasketLkup_GEN_BulkImport on GEN_BulkImport(WorkBasketLkup)
END 
GO
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_DiscrepancyCategoryLkup_GEN_BulkImport' AND OBJECT_ID=OBJECT_ID('GEN_BulkImport'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_DiscrepancyCategoryLkup_GEN_BulkImport on GEN_BulkImport(DiscrepancyCategoryLkup)
END 
GO
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_ExcelStatusLkup_GEN_BulkImport' AND OBJECT_ID=OBJECT_ID('GEN_BulkImport'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_ExcelStatusLkup_GEN_BulkImport on GEN_BulkImport(ExcelStatusLkup)
END 
GO
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_ImportStatusLkup_GEN_BulkImport' AND OBJECT_ID=OBJECT_ID('GEN_BulkImport'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_ImportStatusLkup_GEN_BulkImport on GEN_BulkImport(ImportStatusLkup)
END 
GO
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_UTCCreatedOn_GEN_BulkImport' AND OBJECT_ID=OBJECT_ID('GEN_BulkImport'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_UTCCreatedOn_GEN_BulkImport on GEN_BulkImport(UTCCreatedOn)
END 
GO
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_CreatedByRef_GEN_BulkImport' AND OBJECT_ID=OBJECT_ID('GEN_BulkImport'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_CreatedByRef_GEN_BulkImport on GEN_BulkImport(CreatedByRef)
END 
GO
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_LastUpdatedByRef_GEN_BulkImport' AND OBJECT_ID=OBJECT_ID('GEN_BulkImport'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_LastUpdatedByRef_GEN_BulkImport on GEN_BulkImport(LastUpdatedByRef)
END 
GO
--GEN_Comments
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_GEN_QueueRef_GEN_Comments' AND OBJECT_ID=OBJECT_ID('GEN_Comments'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_GEN_QueueRef_GEN_Comments on GEN_Comments(GEN_QueueRef)
END 
GO
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_ActionLkup_GEN_Comments' AND OBJECT_ID=OBJECT_ID('GEN_Comments'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_ActionLkup_GEN_Comments on GEN_Comments(ActionLkup)
END 
GO
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_CreatedByRef_GEN_Comments' AND OBJECT_ID=OBJECT_ID('GEN_Comments'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_CreatedByRef_GEN_Comments on GEN_Comments(CreatedByRef)
END 
GO
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_LastUpdatedByRef_GEN_Comments' AND OBJECT_ID=OBJECT_ID('GEN_Comments'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_LastUpdatedByRef_GEN_Comments on GEN_Comments(LastUpdatedByRef)
END 
GO
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_SourceSystemLkup_GEN_Comments' AND OBJECT_ID=OBJECT_ID('GEN_Comments'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_SourceSystemLkup_GEN_Comments on GEN_Comments(SourceSystemLkup)
END 
GO
--GEN_EligibilityActions
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_GEN_QueueRef_GEN_EligibilityActions' AND OBJECT_ID=OBJECT_ID('GEN_EligibilityActions'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_GEN_QueueRef_GEN_EligibilityActions on GEN_EligibilityActions(GEN_QueueRef)
END 
GO
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_ContractIDLkup_GEN_EligibilityActions' AND OBJECT_ID=OBJECT_ID('GEN_EligibilityActions'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_ContractIDLkup_GEN_EligibilityActions on GEN_EligibilityActions(ContractIDLkup)
END 
GO
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_PBPLkup_GEN_EligibilityActions' AND OBJECT_ID=OBJECT_ID('GEN_EligibilityActions'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_PBPLkup_GEN_EligibilityActions on GEN_EligibilityActions(PBPLkup)
END 
GO
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_TransactionTypeCodeLkup_GEN_EligibilityActions' AND OBJECT_ID=OBJECT_ID('GEN_EligibilityActions'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_TransactionTypeCodeLkup_GEN_EligibilityActions on GEN_EligibilityActions(TransactionTypeCodeLkup)
END 
GO
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_ElectionTypeLkup_GEN_EligibilityActions' AND OBJECT_ID=OBJECT_ID('GEN_EligibilityActions'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_ElectionTypeLkup_GEN_EligibilityActions on GEN_EligibilityActions(ElectionTypeLkup)
END 
GO
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_ResolutionLkup_GEN_EligibilityActions' AND OBJECT_ID=OBJECT_ID('GEN_EligibilityActions'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_ResolutionLkup_GEN_EligibilityActions on GEN_EligibilityActions(ResolutionLkup)
END 
GO
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_RootCauseLkup_GEN_EligibilityActions' AND OBJECT_ID=OBJECT_ID('GEN_EligibilityActions'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_RootCauseLkup_GEN_EligibilityActions on GEN_EligibilityActions(RootCauseLkup)
END 
GO
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_PendReasonLkup_GEN_EligibilityActions' AND OBJECT_ID=OBJECT_ID('GEN_EligibilityActions'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_PendReasonLkup_GEN_EligibilityActions on GEN_EligibilityActions(PendReasonLkup)
END 
GO
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_CreatedByRef_GEN_EligibilityActions' AND OBJECT_ID=OBJECT_ID('GEN_EligibilityActions'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_CreatedByRef_GEN_EligibilityActions on GEN_EligibilityActions(CreatedByRef)
END 
GO
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_LastUpdatedByRef_GEN_EligibilityActions' AND OBJECT_ID=OBJECT_ID('GEN_EligibilityActions'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_LastUpdatedByRef_GEN_EligibilityActions on GEN_EligibilityActions(LastUpdatedByRef)
END 
GO
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_ContainsErrorsLkup_GEN_EligibilityActions' AND OBJECT_ID=OBJECT_ID('GEN_EligibilityActions'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_ContainsErrorsLkup_GEN_EligibilityActions on GEN_EligibilityActions(ContainsErrorsLkup)
END 
GO
--GEN_FDRBulkImport
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_LockedByRef_GEN_FDRBulkImport' AND OBJECT_ID=OBJECT_ID('GEN_FDRBulkImport'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_LockedByRef_GEN_FDRBulkImport on GEN_FDRBulkImport(LockedByRef)
END 
GO
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_ImportStatusLkup_GEN_FDRBulkImport' AND OBJECT_ID=OBJECT_ID('GEN_FDRBulkImport'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_ImportStatusLkup_GEN_FDRBulkImport on GEN_FDRBulkImport(ImportStatusLkup)
END 
GO
--GEN_FDRStaging
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_GEN_FDRBulkImportRef_GEN_FDRStaging' AND OBJECT_ID=OBJECT_ID('GEN_FDRStaging'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_GEN_FDRBulkImportRef_GEN_FDRStaging on GEN_FDRStaging(GEN_FDRBulkImportRef)
END 
GO
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_HIC_GEN_FDRStaging' AND OBJECT_ID=OBJECT_ID('GEN_FDRStaging'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_HIC_GEN_FDRStaging on GEN_FDRStaging(HIC)
END 
GO
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_IsInvalid_GEN_FDRStaging' AND OBJECT_ID=OBJECT_ID('GEN_FDRStaging'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_IsInvalid_GEN_FDRStaging on GEN_FDRStaging(IsInvalid)
END 
GO
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_IsProcessed_GEN_FDRStaging' AND OBJECT_ID=OBJECT_ID('GEN_FDRStaging'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_IsProcessed_GEN_FDRStaging on GEN_FDRStaging(IsProcessed)
END 
GO
--GEN_ManageCases
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_GEN_QueueRef_GEN_ManageCases' AND OBJECT_ID=OBJECT_ID('GEN_ManageCases'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_GEN_QueueRef_GEN_ManageCases on GEN_ManageCases(GEN_QueueRef)
END 
GO
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_CurrentUserRef_GEN_ManageCases' AND OBJECT_ID=OBJECT_ID('GEN_ManageCases'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_CurrentUserRef_GEN_ManageCases on GEN_ManageCases(CurrentUserRef)
END 
GO
--GEN_OSTActions
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_GEN_QueueRef_GEN_OSTActions' AND OBJECT_ID=OBJECT_ID('GEN_OSTActions'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_GEN_QueueRef_GEN_OSTActions on GEN_OSTActions(GEN_QueueRef)
END 
GO
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_ContractIDLkup_GEN_OSTActions' AND OBJECT_ID=OBJECT_ID('GEN_OSTActions'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_ContractIDLkup_GEN_OSTActions on GEN_OSTActions(ContractIDLkup)
END 
GO
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_PBPLkup_GEN_OSTActions' AND OBJECT_ID=OBJECT_ID('GEN_OSTActions'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_PBPLkup_GEN_OSTActions on GEN_OSTActions(PBPLkup)
END 
GO
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_PendReasonLkup_GEN_OSTActions' AND OBJECT_ID=OBJECT_ID('GEN_OSTActions'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_PendReasonLkup_GEN_OSTActions on GEN_OSTActions(PendReasonLkup)
END 
GO
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_ResolutionLkup_GEN_OSTActions' AND OBJECT_ID=OBJECT_ID('GEN_OSTActions'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_ResolutionLkup_GEN_OSTActions on GEN_OSTActions(ResolutionLkup)
END 
GO
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_CreatedByRef_GEN_OSTActions' AND OBJECT_ID=OBJECT_ID('GEN_OSTActions'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_CreatedByRef_GEN_OSTActions on GEN_OSTActions(CreatedByRef)
END 
GO
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_LastUpdatedByRef_GEN_OSTActions' AND OBJECT_ID=OBJECT_ID('GEN_OSTActions'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_LastUpdatedByRef_GEN_OSTActions on GEN_OSTActions(LastUpdatedByRef)
END 
GO
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_FirstLetterMailDateId_GEN_OSTActions' AND OBJECT_ID=OBJECT_ID('GEN_OSTActions'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_FirstLetterMailDateId_GEN_OSTActions on GEN_OSTActions(FirstLetterMailDateId)
END 
GO
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_SecondLetterMailDateId_GEN_OSTActions' AND OBJECT_ID=OBJECT_ID('GEN_OSTActions'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_SecondLetterMailDateId_GEN_OSTActions on GEN_OSTActions(SecondLetterMailDateId)
END 
GO
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_MemberResponseVerificationDateId_GEN_OSTActions' AND OBJECT_ID=OBJECT_ID('GEN_OSTActions'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_MemberResponseVerificationDateId_GEN_OSTActions on GEN_OSTActions(MemberResponseVerificationDateId)
END 
GO
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_ContainsErrorsLkup_GEN_OSTActions' AND OBJECT_ID=OBJECT_ID('GEN_OSTActions'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_ContainsErrorsLkup_GEN_OSTActions on GEN_OSTActions(ContainsErrorsLkup)
END 
GO


--GEN_QueueWorkFlowCorrelation
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_GEN_QueueRef_GEN_QueueWorkFlowCorrelation' AND OBJECT_ID=OBJECT_ID('GEN_QueueWorkFlowCorrelation'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_GEN_QueueRef_GEN_QueueWorkFlowCorrelation on GEN_QueueWorkFlowCorrelation(GEN_QueueRef)
END 
GO
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_RoleLkup_GEN_QueueWorkFlowCorrelation' AND OBJECT_ID=OBJECT_ID('GEN_QueueWorkFlowCorrelation'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_RoleLkup_GEN_QueueWorkFlowCorrelation on GEN_QueueWorkFlowCorrelation(RoleLkup)
END 
GO
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_WorkBasketLkup_GEN_QueueWorkFlowCorrelation' AND OBJECT_ID=OBJECT_ID('GEN_QueueWorkFlowCorrelation'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_WorkBasketLkup_GEN_QueueWorkFlowCorrelation on GEN_QueueWorkFlowCorrelation(WorkBasketLkup)
END 
GO
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_DiscrepancyCategoryLkup_GEN_QueueWorkFlowCorrelation' AND OBJECT_ID=OBJECT_ID('GEN_QueueWorkFlowCorrelation'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_DiscrepancyCategoryLkup_GEN_QueueWorkFlowCorrelation on GEN_QueueWorkFlowCorrelation(DiscrepancyCategoryLkup)
END 
GO
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_PreviousActionLkup_GEN_QueueWorkFlowCorrelation' AND OBJECT_ID=OBJECT_ID('GEN_QueueWorkFlowCorrelation'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_PreviousActionLkup_GEN_QueueWorkFlowCorrelation on GEN_QueueWorkFlowCorrelation(PreviousActionLkup)
END 
GO
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_PreviousWorkQueuesLkup_GEN_QueueWorkFlowCorrelation' AND OBJECT_ID=OBJECT_ID('GEN_QueueWorkFlowCorrelation'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_PreviousWorkQueuesLkup_GEN_QueueWorkFlowCorrelation on GEN_QueueWorkFlowCorrelation(PreviousWorkQueuesLkup)
END 
GO
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_PreviousStatusLkup_GEN_QueueWorkFlowCorrelation' AND OBJECT_ID=OBJECT_ID('GEN_QueueWorkFlowCorrelation'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_PreviousStatusLkup_GEN_QueueWorkFlowCorrelation on GEN_QueueWorkFlowCorrelation(PreviousStatusLkup)
END 
GO
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_CurrentActionLkup_GEN_QueueWorkFlowCorrelation' AND OBJECT_ID=OBJECT_ID('GEN_QueueWorkFlowCorrelation'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_CurrentActionLkup_GEN_QueueWorkFlowCorrelation on GEN_QueueWorkFlowCorrelation(CurrentActionLkup)
END 
GO
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_CurrentWorkQueuesLkup_GEN_QueueWorkFlowCorrelation' AND OBJECT_ID=OBJECT_ID('GEN_QueueWorkFlowCorrelation'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_CurrentWorkQueuesLkup_GEN_QueueWorkFlowCorrelation on GEN_QueueWorkFlowCorrelation(CurrentWorkQueuesLkup)
END 
GO
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_CurrentStatusLkup_GEN_QueueWorkFlowCorrelation' AND OBJECT_ID=OBJECT_ID('GEN_QueueWorkFlowCorrelation'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_CurrentStatusLkup_GEN_QueueWorkFlowCorrelation on GEN_QueueWorkFlowCorrelation(CurrentStatusLkup)
END 
GO
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_CreatedByRef_GEN_QueueWorkFlowCorrelation' AND OBJECT_ID=OBJECT_ID('GEN_QueueWorkFlowCorrelation'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_CreatedByRef_GEN_QueueWorkFlowCorrelation on GEN_QueueWorkFlowCorrelation(CreatedByRef)
END 
GO
--GEN_RPRActions
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_GEN_QueueRef_GEN_RPRActions' AND OBJECT_ID=OBJECT_ID('GEN_RPRActions'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_GEN_QueueRef_GEN_RPRActions on GEN_RPRActions(GEN_QueueRef)
END 
GO
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_ResolutionLkup_GEN_RPRActions' AND OBJECT_ID=OBJECT_ID('GEN_RPRActions'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_ResolutionLkup_GEN_RPRActions on GEN_RPRActions(ResolutionLkup)
END 
GO
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_RootCauseLkup_GEN_RPRActions' AND OBJECT_ID=OBJECT_ID('GEN_RPRActions'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_RootCauseLkup_GEN_RPRActions on GEN_RPRActions(RootCauseLkup)
END 
GO
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_PendReasonLkup_GEN_RPRActions' AND OBJECT_ID=OBJECT_ID('GEN_RPRActions'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_PendReasonLkup_GEN_RPRActions on GEN_RPRActions(PendReasonLkup)
END 
GO
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_AdjustedCreateDate_GEN_RPRActions' AND OBJECT_ID=OBJECT_ID('GEN_RPRActions'))
BEGIN 
	CREATE NONCLUSTERED INDEX ERS_IDX_AdjustedCreateDate_GEN_RPRActions on GEN_RPRActions(AdjustedCreateDate)
END 
GO
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_AdjustedCreateDateReasonLkup_GEN_RPRActions' AND OBJECT_ID=OBJECT_ID('GEN_RPRActions'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_AdjustedCreateDateReasonLkup_GEN_RPRActions on GEN_RPRActions(AdjustedCreateDateReasonLkup)
END 
GO
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_SubmissionTypeLkup_GEN_RPRActions' AND OBJECT_ID=OBJECT_ID('GEN_RPRActions'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_SubmissionTypeLkup_GEN_RPRActions on GEN_RPRActions(SubmissionTypeLkup)
END 
GO
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_FDRStatusLkup_GEN_RPRActions' AND OBJECT_ID=OBJECT_ID('GEN_RPRActions'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_FDRStatusLkup_GEN_RPRActions on GEN_RPRActions(FDRStatusLkup)
END 
GO
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_FDRCodeReceived_GEN_RPRActions' AND OBJECT_ID=OBJECT_ID('GEN_RPRActions'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_FDRCodeReceived_GEN_RPRActions on GEN_RPRActions(FDRCodeReceived)
END 
GO
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_FDRRejectionTypeLkup_GEN_RPRActions' AND OBJECT_ID=OBJECT_ID('GEN_RPRActions'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_FDRRejectionTypeLkup_GEN_RPRActions on GEN_RPRActions(FDRRejectionTypeLkup)
END 
GO
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_ContractIDLkup_GEN_RPRActions' AND OBJECT_ID=OBJECT_ID('GEN_RPRActions'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_ContractIDLkup_GEN_RPRActions on GEN_RPRActions(ContractIDLkup)
END 
GO
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_PBPLkup_GEN_RPRActions' AND OBJECT_ID=OBJECT_ID('GEN_RPRActions'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_PBPLkup_GEN_RPRActions on GEN_RPRActions(PBPLkup)
END 
GO
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_CreatedByRef_GEN_RPRActions' AND OBJECT_ID=OBJECT_ID('GEN_RPRActions'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_CreatedByRef_GEN_RPRActions on GEN_RPRActions(CreatedByRef)
END 
GO
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_LastUpdatedByRef_GEN_RPRActions' AND OBJECT_ID=OBJECT_ID('GEN_RPRActions'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_LastUpdatedByRef_GEN_RPRActions on GEN_RPRActions(LastUpdatedByRef)
END 
GO
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_ElectionTypeLkup_GEN_RPRActions' AND OBJECT_ID=OBJECT_ID('GEN_RPRActions'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_ElectionTypeLkup_GEN_RPRActions on GEN_RPRActions(ElectionTypeLkup)
END 
GO
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_AdjustedCreateDateId_GEN_RPRActions' AND OBJECT_ID=OBJECT_ID('GEN_RPRActions'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_AdjustedCreateDateId_GEN_RPRActions on GEN_RPRActions(AdjustedCreateDateId)
END 
GO
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_RPCSubmissionDateId_GEN_RPRActions' AND OBJECT_ID=OBJECT_ID('GEN_RPRActions'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_RPCSubmissionDateId_GEN_RPRActions on GEN_RPRActions(RPCSubmissionDateId)
END 
GO
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_CMSAccountManagerApprovalDateId_GEN_RPRActions' AND OBJECT_ID=OBJECT_ID('GEN_RPRActions'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_CMSAccountManagerApprovalDateId_GEN_RPRActions on GEN_RPRActions(CMSAccountManagerApprovalDateId)
END 
GO
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_FDRReceivedDateId_GEN_RPRActions' AND OBJECT_ID=OBJECT_ID('GEN_RPRActions'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_FDRReceivedDateId_GEN_RPRActions on GEN_RPRActions(FDRReceivedDateId)
END 
GO
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_ContainsErrorsLkup_GEN_RPRActions' AND OBJECT_ID=OBJECT_ID('GEN_RPRActions'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_ContainsErrorsLkup_GEN_RPRActions on GEN_RPRActions(ContainsErrorsLkup)
END 
GO
--GEN_WorkFlowMaster
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_CurrentWorkQueueLkup_GEN_WorkFlowMaster' AND OBJECT_ID=OBJECT_ID('GEN_WorkFlowMaster'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_CurrentWorkQueueLkup_GEN_WorkFlowMaster on GEN_WorkFlowMaster(CurrentWorkQueueLkup)
END 
GO
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_CurrentActionLkup_GEN_WorkFlowMaster' AND OBJECT_ID=OBJECT_ID('GEN_WorkFlowMaster'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_CurrentActionLkup_GEN_WorkFlowMaster on GEN_WorkFlowMaster(CurrentActionLkup)
END 
GO
--MGR_ConfigMaster
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_LockedByRef_MGR_ConfigMaster' AND OBJECT_ID=OBJECT_ID('MGR_ConfigMaster'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_LockedByRef_MGR_ConfigMaster on MGR_ConfigMaster(LockedByRef)
END 
GO
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_ConfigName_MGR_ConfigMaster' AND OBJECT_ID=OBJECT_ID('MGR_ConfigMaster'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_ConfigName_MGR_ConfigMaster on MGR_ConfigMaster(ConfigName)
END 
GO
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_CreatedByRef_MGR_ConfigMaster' AND OBJECT_ID=OBJECT_ID('MGR_ConfigMaster'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_CreatedByRef_MGR_ConfigMaster on MGR_ConfigMaster(CreatedByRef)
END 
GO
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_LastUpdatedByRef_MGR_ConfigMaster' AND OBJECT_ID=OBJECT_ID('MGR_ConfigMaster'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_LastUpdatedByRef_MGR_ConfigMaster on MGR_ConfigMaster(LastUpdatedByRef)
END 
GO
--MGR_ConfigMasterHistory
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_MGR_ConfigMasterRef_MGR_ConfigMasterHistory' AND OBJECT_ID=OBJECT_ID('MGR_ConfigMasterHistory'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_MGR_ConfigMasterRef_MGR_ConfigMasterHistory on MGR_ConfigMasterHistory(MGR_ConfigMasterRef)
END 
GO
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_LastUpdatedByRef_MGR_ConfigMasterHistory' AND OBJECT_ID=OBJECT_ID('MGR_ConfigMasterHistory'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_LastUpdatedByRef_MGR_ConfigMasterHistory on MGR_ConfigMasterHistory(LastUpdatedByRef)
END 
GO
--RPT_ReportsMaster
IF NOT EXISTS(SELECT 1 FROM SYS.indexes  WHERE NAME='ERS_IDX_ReportName_RPT_ReportsMaster' AND OBJECT_ID=OBJECT_ID('RPT_ReportsMaster'))
BEGIN 
CREATE NONCLUSTERED INDEX ERS_IDX_ReportName_RPT_ReportsMaster on RPT_ReportsMaster(ReportName)
END 
GO
