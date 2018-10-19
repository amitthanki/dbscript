--ADM_AccessGroupReportCorrelation
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_ADM_AccessGroupReportCorrelation_ADM_AccessGroupMasterRef]') AND type in (N'F'))
BEGIN
 ALTER TABLE [dbo].[ADM_AccessGroupReportCorrelation]  WITH CHECK ADD  CONSTRAINT [FK_ADM_AccessGroupReportCorrelation_ADM_AccessGroupMasterRef] FOREIGN KEY([ADM_AccessGroupMasterRef])
 REFERENCES [dbo].[ADM_AccessGroupMaster]([ADM_AccessGroupMasterId])
 ALTER TABLE [dbo].[ADM_AccessGroupReportCorrelation] CHECK CONSTRAINT [FK_ADM_AccessGroupReportCorrelation_ADM_AccessGroupMasterRef]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_ADM_AccessGroupReportCorrelation_RPT_ReportsMasterRef]') AND type in (N'F'))
BEGIN
 ALTER TABLE [dbo].[ADM_AccessGroupReportCorrelation]  WITH CHECK ADD  CONSTRAINT [FK_ADM_AccessGroupReportCorrelation_RPT_ReportsMasterRef] FOREIGN KEY([RPT_ReportsMasterRef])
 REFERENCES [dbo].[RPT_ReportsMaster]([RPT_ReportsMasterId])
 ALTER TABLE [dbo].[ADM_AccessGroupReportCorrelation] CHECK CONSTRAINT [FK_ADM_AccessGroupReportCorrelation_RPT_ReportsMasterRef]
END
GO

--ADM_AccessGroupSkillsCorrelation
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_ADM_AccessGroupSkillsCorrelation_ADM_AccessGroupMasterRef]') AND type in (N'F'))
BEGIN
 ALTER TABLE [dbo].[ADM_AccessGroupSkillsCorrelation]  WITH CHECK ADD  CONSTRAINT [FK_ADM_AccessGroupSkillsCorrelation_ADM_AccessGroupMasterRef] FOREIGN KEY([ADM_AccessGroupMasterRef])
 REFERENCES [dbo].[ADM_AccessGroupMaster]([ADM_AccessGroupMasterId])
 ALTER TABLE [dbo].[ADM_AccessGroupSkillsCorrelation] CHECK CONSTRAINT [FK_ADM_AccessGroupSkillsCorrelation_ADM_AccessGroupMasterRef]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_ADM_AccessGroupSkillsCorrelation_ADM_SkillsMasterRef]') AND type in (N'F'))
BEGIN
 ALTER TABLE [dbo].[ADM_AccessGroupSkillsCorrelation]  WITH CHECK ADD  CONSTRAINT [FK_ADM_AccessGroupSkillsCorrelation_ADM_SkillsMasterRef] FOREIGN KEY([ADM_SkillsMasterRef])
 REFERENCES [dbo].[ADM_SkillsMaster]([ADM_SkillsMasterId])
 ALTER TABLE [dbo].[ADM_AccessGroupSkillsCorrelation] CHECK CONSTRAINT [FK_ADM_AccessGroupSkillsCorrelation_ADM_SkillsMasterRef]
END
GO

--ADM_AccessGroupUserCorrelation
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_ADM_AccessGroupUserCorrelation_ADM_AccessGroupMasterRef]') AND type in (N'F'))
BEGIN
 ALTER TABLE [dbo].[ADM_AccessGroupUserCorrelation]  WITH CHECK ADD  CONSTRAINT [FK_ADM_AccessGroupUserCorrelation_ADM_AccessGroupMasterRef] FOREIGN KEY([ADM_AccessGroupMasterRef])
 REFERENCES [dbo].[ADM_AccessGroupMaster]([ADM_AccessGroupMasterId])
 ALTER TABLE [dbo].[ADM_AccessGroupUserCorrelation] CHECK CONSTRAINT [FK_ADM_AccessGroupUserCorrelation_ADM_AccessGroupMasterRef]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_ADM_AccessGroupUserCorrelation_ADM_UserMasterRef]') AND type in (N'F'))
BEGIN
 ALTER TABLE [dbo].[ADM_AccessGroupUserCorrelation]  WITH CHECK ADD  CONSTRAINT [FK_ADM_AccessGroupUserCorrelation_ADM_UserMasterRef] FOREIGN KEY([ADM_UserMasterRef])
 REFERENCES [dbo].[ADM_UserMaster]([ADM_UserMasterId])
 ALTER TABLE [dbo].[ADM_AccessGroupUserCorrelation] CHECK CONSTRAINT [FK_ADM_AccessGroupUserCorrelation_ADM_UserMasterRef]
END
GO

--ADM_AlertDetails

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_ADM_AlertDetails_CMN_DepartmentRef]') AND type in (N'F'))
BEGIN
 ALTER TABLE [dbo].[ADM_AlertDetails]  WITH CHECK ADD  CONSTRAINT [FK_ADM_AlertDetails_CMN_DepartmentRef] FOREIGN KEY([CMN_DepartmentRef])
 REFERENCES [dbo].[CMN_Department]([CMN_DepartmentId])
 ALTER TABLE [dbo].[ADM_AlertDetails] CHECK CONSTRAINT [FK_ADM_AlertDetails_CMN_DepartmentRef]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_ADM_AlertDetails_ADM_UserMasterRef]') AND type in (N'F'))
BEGIN
 ALTER TABLE [dbo].[ADM_AlertDetails]  WITH CHECK ADD  CONSTRAINT [FK_ADM_AlertDetails_ADM_UserMasterRef] FOREIGN KEY([ADM_UserMasterRef])
 REFERENCES [dbo].[ADM_UserMaster]([ADM_UserMasterId])
 ALTER TABLE [dbo].[ADM_AlertDetails] CHECK CONSTRAINT [FK_ADM_AlertDetails_ADM_UserMasterRef]
END
GO

--ADM_ResourceDetails

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_ADM_ResourceDetails_CMN_DepartmentRef]') AND type in (N'F'))
BEGIN
 ALTER TABLE [dbo].[ADM_ResourceDetails]  WITH CHECK ADD  CONSTRAINT [FK_ADM_ResourceDetails_CMN_DepartmentRef] FOREIGN KEY([CMN_DepartmentRef])
 REFERENCES [dbo].[CMN_Department]([CMN_DepartmentId])
 ALTER TABLE [dbo].[ADM_ResourceDetails] CHECK CONSTRAINT [FK_ADM_ResourceDetails_CMN_DepartmentRef]
END
GO

--ADM_SkillsMaster
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_ADM_SkillsMaster_CMN_DepartmentRef]') AND type in (N'F'))
BEGIN
 ALTER TABLE [dbo].[ADM_SkillsMaster]  WITH CHECK ADD  CONSTRAINT [FK_ADM_SkillsMaster_CMN_DepartmentRef] FOREIGN KEY([CMN_DepartmentRef])
 REFERENCES [dbo].[CMN_Department]([CMN_DepartmentId])
 ALTER TABLE [dbo].[ADM_SkillsMaster] CHECK CONSTRAINT [FK_ADM_SkillsMaster_CMN_DepartmentRef]
END
GO

--ADM_SkillWorkQueuesCorrelation
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_ADM_SkillWorkQueuesCorrelation_ADM_SkillsMasterRef]') AND type in (N'F'))
BEGIN
 ALTER TABLE [dbo].[ADM_SkillWorkQueuesCorrelation]  WITH CHECK ADD  CONSTRAINT [FK_ADM_SkillWorkQueuesCorrelation_ADM_SkillsMasterRef] FOREIGN KEY([ADM_SkillsMasterRef])
 REFERENCES [dbo].[ADM_SkillsMaster]([ADM_SkillsMasterId])
 ALTER TABLE [dbo].[ADM_SkillWorkQueuesCorrelation] CHECK CONSTRAINT [FK_ADM_SkillWorkQueuesCorrelation_ADM_SkillsMasterRef]
END
GO

--ADM_UserPreference
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_ADM_UserPreference_ADM_UserMasterRef]') AND type in (N'F'))
BEGIN
 ALTER TABLE [dbo].[ADM_UserPreference]  WITH CHECK ADD  CONSTRAINT [FK_ADM_UserPreference_ADM_UserMasterRef] FOREIGN KEY([ADM_UserMasterRef])
 REFERENCES [dbo].[ADM_UserMaster]([ADM_UserMasterId])
 ALTER TABLE [dbo].[ADM_UserPreference] CHECK CONSTRAINT [FK_ADM_UserPreference_ADM_UserMasterRef]
END
GO

--ADM_UserSession
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_ADM_UserSession_ADM_UserMasterRef]') AND type in (N'F'))
BEGIN
 ALTER TABLE [dbo].[ADM_UserSession]  WITH CHECK ADD  CONSTRAINT [FK_ADM_UserSession_ADM_UserMasterRef] FOREIGN KEY([ADM_UserMasterRef])
 REFERENCES [dbo].[ADM_UserMaster]([ADM_UserMasterId])
 ALTER TABLE [dbo].[ADM_UserSession] CHECK CONSTRAINT [FK_ADM_UserSession_ADM_UserMasterRef]
END
GO

--CMN_AppErrorLog
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_CMN_AppErrorLog_ADM_UserMasterRef]') AND type in (N'F'))
BEGIN
 ALTER TABLE [dbo].[CMN_AppErrorLog]  WITH CHECK ADD  CONSTRAINT [FK_CMN_AppErrorLog_ADM_UserMasterRef] FOREIGN KEY([ADM_UserMasterRef])
 REFERENCES [dbo].[ADM_UserMaster]([ADM_UserMasterId])
 ALTER TABLE [dbo].[CMN_AppErrorLog] CHECK CONSTRAINT [FK_CMN_AppErrorLog_ADM_UserMasterRef]
END
GO
--CMN_BackgroundProcessDetails
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_CMN_BackgroundProcessDetails_CMN_BackgroundProcessMasterRef]') AND type in (N'F'))
BEGIN
 ALTER TABLE [dbo].[CMN_BackgroundProcessDetails]  WITH CHECK ADD  CONSTRAINT [FK_CMN_BackgroundProcessDetails_CMN_BackgroundProcessMasterRef] FOREIGN KEY([CMN_BackgroundProcessMasterRef])
 REFERENCES [dbo].[CMN_BackgroundProcessMaster]([CMN_BackgroundProcessMasterId])
 ALTER TABLE [dbo].[CMN_BackgroundProcessDetails] CHECK CONSTRAINT [FK_CMN_BackgroundProcessDetails_CMN_BackgroundProcessMasterRef]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_CMN_BackgroundProcessDetails_GEN_QueueRef]') AND type in (N'F'))
BEGIN
 ALTER TABLE [dbo].[CMN_BackgroundProcessDetails]  WITH CHECK ADD  CONSTRAINT [FK_CMN_BackgroundProcessDetails_GEN_QueueRef] FOREIGN KEY([GEN_QueueRef])
 REFERENCES [dbo].[GEN_Queue]([GEN_QueueId])
 ALTER TABLE [dbo].[CMN_BackgroundProcessDetails] CHECK CONSTRAINT [FK_CMN_BackgroundProcessDetails_GEN_QueueRef]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_CMN_BackgroundProcessDetails_GEN_BulkImportRef]') AND type in (N'F'))
BEGIN
 ALTER TABLE [dbo].[CMN_BackgroundProcessDetails]  WITH CHECK ADD  CONSTRAINT [FK_CMN_BackgroundProcessDetails_GEN_BulkImportRef] FOREIGN KEY([GEN_BulkImportRef])
 REFERENCES [dbo].[GEN_BulkImport]([GEN_BulkImportId])
 ALTER TABLE [dbo].[CMN_BackgroundProcessDetails] CHECK CONSTRAINT [FK_CMN_BackgroundProcessDetails_GEN_BulkImportRef]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_CMN_BackgroundProcessDetails_GEN_FDRUploadStagingRef]') AND type in (N'F'))
BEGIN
 ALTER TABLE [dbo].[CMN_BackgroundProcessDetails]  WITH CHECK ADD  CONSTRAINT [FK_CMN_BackgroundProcessDetails_GEN_FDRUploadStagingRef] FOREIGN KEY([GEN_FDRUploadStagingRef])
 REFERENCES [dbo].[GEN_FDRStaging]([GEN_FDRStagingId])
 ALTER TABLE [dbo].[CMN_BackgroundProcessDetails] CHECK CONSTRAINT [FK_CMN_BackgroundProcessDetails_GEN_FDRUploadStagingRef]
END
GO
--CMN_DiscrepancyTypeMenuCorrelation
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_CMN_DiscrepancyTypeMenuCorrelation_CMN_MenuMasterRef]') AND type in (N'F'))
BEGIN
 ALTER TABLE [dbo].[CMN_DiscrepancyTypeMenuCorrelation]  WITH CHECK ADD  CONSTRAINT [FK_CMN_DiscrepancyTypeMenuCorrelation_CMN_MenuMasterRef] FOREIGN KEY([CMN_MenuMasterRef])
 REFERENCES [dbo].[CMN_MenuMaster]([CMN_MenuMasterId])
 ALTER TABLE [dbo].[CMN_DiscrepancyTypeMenuCorrelation] CHECK CONSTRAINT [FK_CMN_DiscrepancyTypeMenuCorrelation_CMN_MenuMasterRef]
END
GO

--GEN_Attachments
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_GEN_Attachments_GEN_QueueRef]') AND type in (N'F'))
BEGIN
 ALTER TABLE [dbo].[GEN_Attachments]  WITH CHECK ADD  CONSTRAINT [FK_GEN_Attachments_GEN_QueueRef] FOREIGN KEY([GEN_QueueRef])
 REFERENCES [dbo].[GEN_Queue]([GEN_QueueId])
 ALTER TABLE [dbo].[GEN_Attachments] CHECK CONSTRAINT [FK_GEN_Attachments_GEN_QueueRef]
END
GO
--GEN_BulkImport
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_GEN_BulkImport_GEN_BulkImportExcelTemplateMasterRef]') AND type in (N'F'))
BEGIN
 ALTER TABLE [dbo].[GEN_BulkImport]  WITH CHECK ADD  CONSTRAINT [FK_GEN_BulkImport_GEN_BulkImportExcelTemplateMasterRef] FOREIGN KEY([GEN_BulkImportExcelTemplateMasterRef])
 REFERENCES [dbo].[GEN_BulkImportExcelTemplateMaster]([GEN_BulkImportExcelTemplateMasterId])
 ALTER TABLE [dbo].[GEN_BulkImport] CHECK CONSTRAINT [FK_GEN_BulkImport_GEN_BulkImportExcelTemplateMasterRef]
END
GO
--GEN_BulkImportColumnsMapping
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_GEN_BulkImportColumnsMapping_GEN_BulkImportColumnsMappingParentRef]') AND type in (N'F'))
BEGIN
 ALTER TABLE [dbo].[GEN_BulkImportColumnsMapping]  WITH CHECK ADD  CONSTRAINT [FK_GEN_BulkImportColumnsMapping_GEN_BulkImportColumnsMappingParentRef] FOREIGN KEY([GEN_BulkImportColumnsMappingParentRef])
 REFERENCES [dbo].[GEN_BulkImportColumnsMapping]([GEN_BulkImportColumnsMappingId])
 ALTER TABLE [dbo].[GEN_BulkImportColumnsMapping] CHECK CONSTRAINT [FK_GEN_BulkImportColumnsMapping_GEN_BulkImportColumnsMappingParentRef]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_GEN_BulkImportColumnsMapping_GEN_BulkImportExcelTemplateMasterRef]') AND type in (N'F'))
BEGIN
 ALTER TABLE [dbo].[GEN_BulkImportColumnsMapping]  WITH CHECK ADD  CONSTRAINT [FK_GEN_BulkImportColumnsMapping_GEN_BulkImportExcelTemplateMasterRef] FOREIGN KEY([GEN_BulkImportExcelTemplateMasterRef])
 REFERENCES [dbo].[GEN_BulkImportExcelTemplateMaster]([GEN_BulkImportExcelTemplateMasterId])
 ALTER TABLE [dbo].[GEN_BulkImportColumnsMapping] CHECK CONSTRAINT [FK_GEN_BulkImportColumnsMapping_GEN_BulkImportExcelTemplateMasterRef]
END
GO
--GEN_Comments
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_GEN_Comments_GEN_QueueRef]') AND type in (N'F'))
BEGIN
 ALTER TABLE [dbo].[GEN_Comments]  WITH CHECK ADD  CONSTRAINT [FK_GEN_Comments_GEN_QueueRef] FOREIGN KEY([GEN_QueueRef])
 REFERENCES [dbo].[GEN_Queue]([GEN_QueueId])
 ALTER TABLE [dbo].[GEN_Comments] CHECK CONSTRAINT [FK_GEN_Comments_GEN_QueueRef]
END
GO
--GEN_DMSData
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_GEN_DMSData_GEN_QueueRef]') AND type in (N'F'))
BEGIN
 ALTER TABLE [dbo].[GEN_DMSData]  WITH CHECK ADD  CONSTRAINT [FK_GEN_DMSData_GEN_QueueRef] FOREIGN KEY([GEN_QueueRef])
 REFERENCES [dbo].[GEN_Queue]([GEN_QueueId])
 ALTER TABLE [dbo].[GEN_DMSData] CHECK CONSTRAINT [FK_GEN_DMSData_GEN_QueueRef]
END
GO
--GEN_EligibilityActions
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_GEN_EligibilityActions_GEN_QueueRef]') AND type in (N'F'))
BEGIN
 ALTER TABLE [dbo].[GEN_EligibilityActions]  WITH CHECK ADD  CONSTRAINT [FK_GEN_EligibilityActions_GEN_QueueRef] FOREIGN KEY([GEN_QueueRef])
 REFERENCES [dbo].[GEN_Queue]([GEN_QueueId])
 ALTER TABLE [dbo].[GEN_EligibilityActions] CHECK CONSTRAINT [FK_GEN_EligibilityActions_GEN_QueueRef]
END
GO
--GEN_FDRStaging
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_GEN_FDRStaging_GEN_FDRBulkImportRef]') AND type in (N'F'))
BEGIN
 ALTER TABLE [dbo].[GEN_FDRStaging]  WITH CHECK ADD  CONSTRAINT [FK_GEN_FDRStaging_GEN_FDRBulkImportRef] FOREIGN KEY([GEN_FDRBulkImportRef])
 REFERENCES [dbo].[GEN_FDRBulkImport]([GEN_FDRBulkImportId])
 ALTER TABLE [dbo].[GEN_FDRStaging] CHECK CONSTRAINT [FK_GEN_FDRStaging_GEN_FDRBulkImportRef]
END
GO
--GEN_ManageCases
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_GEN_ManageCases_GEN_QueueRef]') AND type in (N'F'))
BEGIN
 ALTER TABLE [dbo].[GEN_ManageCases]  WITH CHECK ADD  CONSTRAINT [FK_GEN_ManageCases_GEN_QueueRef] FOREIGN KEY([GEN_QueueRef])
 REFERENCES [dbo].[GEN_Queue]([GEN_QueueId])
 ALTER TABLE [dbo].[GEN_ManageCases] CHECK CONSTRAINT [FK_GEN_ManageCases_GEN_QueueRef]
END
GO
--GEN_OSTActions
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_GEN_OSTActions_GEN_QueueRef]') AND type in (N'F'))
BEGIN
 ALTER TABLE [dbo].[GEN_OSTActions]  WITH CHECK ADD  CONSTRAINT [FK_GEN_OSTActions_GEN_QueueRef] FOREIGN KEY([GEN_QueueRef])
 REFERENCES [dbo].[GEN_Queue]([GEN_QueueId])
 ALTER TABLE [dbo].[GEN_OSTActions] CHECK CONSTRAINT [FK_GEN_OSTActions_GEN_QueueRef]
END
GO
--GEN_Queue
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_GEN_Queue_ParentQueueRef]') AND type in (N'F'))
BEGIN
 ALTER TABLE [dbo].[GEN_Queue]  WITH CHECK ADD  CONSTRAINT [FK_GEN_Queue_ParentQueueRef] FOREIGN KEY([ParentQueueRef])
 REFERENCES [dbo].[GEN_Queue]([GEN_QueueId])
 ALTER TABLE [dbo].[GEN_Queue] CHECK CONSTRAINT [FK_GEN_Queue_ParentQueueRef]
END
GO
--GEN_QueueWorkFlowCorrelation
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_GEN_QueueWorkFlowCorrelation_GEN_QueueRef]') AND type in (N'F'))
BEGIN
 ALTER TABLE [dbo].[GEN_QueueWorkFlowCorrelation]  WITH CHECK ADD  CONSTRAINT [FK_GEN_QueueWorkFlowCorrelation_GEN_QueueRef] FOREIGN KEY([GEN_QueueRef])
 REFERENCES [dbo].[GEN_Queue]([GEN_QueueId])
 ALTER TABLE [dbo].[GEN_QueueWorkFlowCorrelation] CHECK CONSTRAINT [FK_GEN_QueueWorkFlowCorrelation_GEN_QueueRef]
END
GO
--GEN_RPRActions
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_GEN_RPRActions_GEN_QueueRef]') AND type in (N'F'))
BEGIN
 ALTER TABLE [dbo].[GEN_RPRActions]  WITH CHECK ADD  CONSTRAINT [FK_GEN_RPRActions_GEN_QueueRef] FOREIGN KEY([GEN_QueueRef])
 REFERENCES [dbo].[GEN_Queue]([GEN_QueueId])
 ALTER TABLE [dbo].[GEN_RPRActions] CHECK CONSTRAINT [FK_GEN_RPRActions_GEN_QueueRef]
END
GO
--MQTRRWorkQueueItems
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_MQTRRWorkQueueItems_CMN_BackgroundProcessMasterRef]') AND type in (N'F'))
BEGIN
 ALTER TABLE [dbo].[MQTRRWorkQueueItems]  WITH CHECK ADD  CONSTRAINT [FK_MQTRRWorkQueueItems_CMN_BackgroundProcessMasterRef] FOREIGN KEY([CMN_BackgroundProcessMasterRef])
 REFERENCES [dbo].[CMN_BackgroundProcessMaster]([CMN_BackgroundProcessMasterId])
 ALTER TABLE [dbo].[MQTRRWorkQueueItems] CHECK CONSTRAINT [FK_MQTRRWorkQueueItems_CMN_BackgroundProcessMasterRef]
END
GO