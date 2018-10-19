
------------------------- DEV -----------------------------------
IF NOT EXISTS (SELECT * FROM dbo.MGR_ConfigMaster WHERE ConfigName='FDRSubmissionCategory2' )
BEGIN
	INSERT [dbo].[MGR_ConfigMaster] ([LockedByRef], [UTCLockedOn], [ConfigName], [ConfigValue], [Version], [StartDate], [EndDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
	VALUES (NULL, NULL, N'FDRSubmissionCategory2', N'\\nasv0012\webapp_dev\ERS\Docs\FDRSubmission\UnProcessed\Category 2\|\\nasv0012\webapp_dev\ERS\Help\FDRSubmissionTemplate\|FDRSubmissionTemplate.xlsx|\\nasv0012\webapp_dev\ERS\Docs\FDRSubmission\Processed\Category 2\|RPC_Submission_Spreadsheet.xlsx|2|2', 1, GETUTCDATE(), DATEADD(YY,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
END
GO

IF NOT EXISTS (SELECT * FROM dbo.MGR_ConfigMaster WHERE ConfigName='FDRSubmissionCategory2CTM' )
BEGIN
	INSERT [dbo].[MGR_ConfigMaster] ([LockedByRef], [UTCLockedOn], [ConfigName], [ConfigValue], [Version], [StartDate], [EndDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
	VALUES (NULL, NULL, N'FDRSubmissionCategory2CTM', N'\\nasv0012\webapp_dev\ERS\Docs\FDRSubmission\UnProcessed\CTM\|\\nasv0012\webapp_dev\ERS\Help\FDRSubmissionTemplate\|FDRSubmissionTemplate.xlsx|\\nasv0012\webapp_dev\ERS\Docs\FDRSubmission\Processed\CTM\|RPC_Submission_Spreadsheet.xlsx|1|1', 1, GETUTCDATE(), DATEADD(YY,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
END
GO

IF NOT EXISTS (SELECT * FROM dbo.MGR_ConfigMaster WHERE ConfigName='FDRSubmissionCategory3' )
BEGIN
	INSERT [dbo].[MGR_ConfigMaster] ([LockedByRef], [UTCLockedOn], [ConfigName], [ConfigValue], [Version], [StartDate], [EndDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
	VALUES (NULL, NULL, N'FDRSubmissionCategory3', N'\\nasv0012\webapp_dev\ERS\Docs\FDRSubmission\UnProcessed\Category 3\|\\nasv0012\webapp_dev\ERS\Help\FDRSubmissionTemplate\|FDRSubmissionTemplate.xlsx|\\nasv0012\webapp_dev\ERS\Docs\FDRSubmission\Processed\Category 3\|RPC_Submission_Spreadsheet.xlsx|7|1', 1, GETUTCDATE(), DATEADD(YY,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
END
GO

IF NOT EXISTS (SELECT * FROM dbo.MGR_ConfigMaster WHERE ConfigName='FDRSubmissionReSubmission' )
BEGIN
	INSERT [dbo].[MGR_ConfigMaster] ([LockedByRef], [UTCLockedOn], [ConfigName], [ConfigValue], [Version], [StartDate], [EndDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
	VALUES (NULL, NULL, N'FDRSubmissionReSubmission', N'\\nasv0012\webapp_dev\ERS\Docs\FDRSubmission\UnProcessed\Resubmission\|\\nasv0012\webapp_dev\ERS\Help\FDRSubmissionTemplate\|FDRSubmissionTemplate.xlsx|\\nasv0012\webapp_dev\ERS\Docs\FDRSubmission\Processed\Resubmission\|RPC_Resubmission_Spreadsheet.xlsx|1|1', 1, GETUTCDATE(), DATEADD(YY,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
END
GO

IF NOT EXISTS (SELECT * FROM dbo.MGR_ConfigMaster WHERE ConfigName='FDRSubmissionSCC' )
BEGIN
	INSERT [dbo].[MGR_ConfigMaster] ([LockedByRef], [UTCLockedOn], [ConfigName], [ConfigValue], [Version], [StartDate], [EndDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
	VALUES (NULL, NULL, N'FDRSubmissionSCC', N'\\nasv0012\webapp_dev\ERS\Docs\FDRSubmission\UnProcessed\SCC\|\\nasv0012\webapp_dev\ERS\Help\FDRSubmissionTemplate\|SCCFDRSubmissionTemplate.xlsx|\\nasv0012\webapp_dev\ERS\Docs\FDRSubmission\Processed\SCC\|RPC_SCC_Spreadsheet.xlsx|1|1', 1, GETUTCDATE(), DATEADD(YY,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
END
GO

IF NOT EXISTS (SELECT * FROM dbo.MGR_ConfigMaster WHERE ConfigName='FDRSubmissionStartRowsForSheet' )
BEGIN
	INSERT [dbo].[MGR_ConfigMaster] ([LockedByRef], [UTCLockedOn], [ConfigName], [ConfigValue], [Version], [StartDate], [EndDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
	VALUES (NULL, NULL, N'FDRSubmissionStartRowsForSheet', N'4|4|4|4', 1, GETUTCDATE(), DATEADD(YY,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
END
GO

IF NOT EXISTS (SELECT * FROM dbo.MGR_ConfigMaster WHERE ConfigName='SCCFDRSubmissionStartRowsForSheet' )
BEGIN
	INSERT [dbo].[MGR_ConfigMaster] ([LockedByRef], [UTCLockedOn], [ConfigName], [ConfigValue], [Version], [StartDate], [EndDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
	VALUES (NULL, NULL, N'SCCFDRSubmissionStartRowsForSheet', N'4', 1, GETUTCDATE(), DATEADD(YY,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
END
GO

IF NOT EXISTS (SELECT * FROM dbo.MGR_ConfigMaster WHERE ConfigName='FDRSourcePath' )
BEGIN
	INSERT [dbo].[MGR_ConfigMaster] ([LockedByRef], [UTCLockedOn], [ConfigName], [ConfigValue], [Version], [StartDate], [EndDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
	VALUES (NULL, NULL, N'FDRSourcePath', N'\\nasv0012\webapp_dev\ERS\Docs\FDRUpload\Source', 1, GETUTCDATE(), DATEADD(YY,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
END
GO

IF NOT EXISTS (SELECT * FROM dbo.MGR_ConfigMaster WHERE ConfigName='FDRTempFolder' )
BEGIN
	INSERT [dbo].[MGR_ConfigMaster] ([LockedByRef], [UTCLockedOn], [ConfigName], [ConfigValue], [Version], [StartDate], [EndDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
	VALUES (NULL, NULL, N'FDRTempFolder', N'\\nasv0012\webapp_dev\ERS\Temp', 1, GETUTCDATE(), DATEADD(YY,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
END
GO

IF NOT EXISTS (SELECT * FROM dbo.MGR_ConfigMaster WHERE ConfigName='FDRTargetPath' )
BEGIN
	INSERT [dbo].[MGR_ConfigMaster] ([LockedByRef], [UTCLockedOn], [ConfigName], [ConfigValue], [Version], [StartDate], [EndDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
	VALUES (NULL, NULL, N'FDRTargetPath', N'\\nasv0012\webapp_dev\ERS\Docs\FDRUpload\Target', 1, GETUTCDATE(), DATEADD(YY,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
END
GO

IF NOT EXISTS (SELECT * FROM dbo.MGR_ConfigMaster WHERE ConfigName='FDRErrorFolder' )
BEGIN
	INSERT [dbo].[MGR_ConfigMaster] ([LockedByRef], [UTCLockedOn], [ConfigName], [ConfigValue], [Version], [StartDate], [EndDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
	VALUES (NULL, NULL, N'FDRErrorFolder', N'\\nasv0012\webapp_dev\ERS\Docs\FDRUpload\Source\ErrorFile', 1, GETUTCDATE(), DATEADD(YY,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
END
GO

IF NOT EXISTS (SELECT * FROM dbo.MGR_ConfigMaster WHERE ConfigName='FDRAlreadyProcessed' )
BEGIN
	INSERT [dbo].[MGR_ConfigMaster] ([LockedByRef], [UTCLockedOn], [ConfigName], [ConfigValue], [Version], [StartDate], [EndDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
	VALUES (NULL, NULL, N'FDRAlreadyProcessed', N'\\nasv0012\webapp_dev\ERS\Docs\FDRUpload\Source\AlreadyProcessed', 1, GETUTCDATE(), DATEADD(YY,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
END
GO

IF NOT EXISTS (SELECT * FROM dbo.MGR_ConfigMaster WHERE ConfigName='FDRErrorLog' )
BEGIN
	INSERT [dbo].[MGR_ConfigMaster] ([LockedByRef], [UTCLockedOn], [ConfigName], [ConfigValue], [Version], [StartDate], [EndDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
	VALUES (NULL, NULL, N'FDRErrorLog', N'\\nasv0012\webapp_dev\ERS\Docs\FDRUpload\Source\ErrorLog', 1, GETUTCDATE(), DATEADD(YY,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
END
GO
IF NOT EXISTS (SELECT * FROM dbo.MGR_ConfigMaster WHERE ConfigName='BulkUploadFileFormats' )
BEGIN
	INSERT [dbo].[MGR_ConfigMaster] ([LockedByRef], [UTCLockedOn], [ConfigName], [ConfigValue], [Version], [StartDate], [EndDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
	VALUES (NULL, NULL, N'BulkUploadFileFormats', N',csv,', 1, GETUTCDATE(), DATEADD(YY,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
END
GO
IF NOT EXISTS (SELECT * FROM dbo.MGR_ConfigMaster WHERE ConfigName='AttchmentFileFormat' )
BEGIN
	INSERT [dbo].[MGR_ConfigMaster] ([LockedByRef], [UTCLockedOn], [ConfigName], [ConfigValue], [Version], [StartDate], [EndDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
	VALUES (NULL, NULL, N'AttchmentFileFormat', N',pdf,', 1, GETUTCDATE(), DATEADD(YY,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
END
GO
IF NOT EXISTS (SELECT * FROM dbo.MGR_ConfigMaster WHERE ConfigName='BulkUploadFilePath' )
BEGIN
	INSERT [dbo].[MGR_ConfigMaster] ([LockedByRef], [UTCLockedOn], [ConfigName], [ConfigValue], [Version], [StartDate], [EndDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
	VALUES (NULL, NULL, N'BulkUploadFilePath', N'\\nasv0012\webapp_dev\ERS\Docs\BulkUpload\', 1, GETUTCDATE(), DATEADD(YY,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
END
GO
IF NOT EXISTS (SELECT * FROM dbo.MGR_ConfigMaster WHERE ConfigName='webServerTempPath' )
BEGIN
	INSERT [dbo].[MGR_ConfigMaster] ([LockedByRef], [UTCLockedOn], [ConfigName], [ConfigValue], [Version], [StartDate], [EndDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
	VALUES (NULL, NULL, N'webServerTempPath', N'\\nasv0012\webapp_dev\ERS\Temp\', 1, GETUTCDATE(), DATEADD(YY,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
END
GO
IF NOT EXISTS (SELECT * FROM dbo.MGR_ConfigMaster WHERE ConfigName='AttchmentFilePath' )
BEGIN
	INSERT [dbo].[MGR_ConfigMaster] ([LockedByRef], [UTCLockedOn], [ConfigName], [ConfigValue], [Version], [StartDate], [EndDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
	VALUES (NULL, NULL, N'AttchmentFilePath', N'\\nasv0012\webapp_dev\ERS\Docs\Attachments\', 1, GETUTCDATE(), DATEADD(YY,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
END
GO
IF NOT EXISTS (SELECT * FROM dbo.MGR_ConfigMaster WHERE ConfigName='AutoUnlockRecordHours' )
BEGIN
	INSERT [dbo].[MGR_ConfigMaster] ([LockedByRef], [UTCLockedOn], [ConfigName], [ConfigValue], [Version], [StartDate], [EndDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
	VALUES (NULL, NULL, N'AutoUnlockRecordHours', N'2', 1, GETUTCDATE(), DATEADD(YY,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
END
GO
IF NOT EXISTS (SELECT * FROM dbo.MGR_ConfigMaster WHERE ConfigName='MQNonSecureChannel' )
BEGIN
	INSERT [dbo].[MGR_ConfigMaster] ([LockedByRef], [UTCLockedOn], [ConfigName], [ConfigValue], [Version], [StartDate], [EndDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
	VALUES (NULL, NULL, N'MQNonSecureChannel', N'ERSUATCLNT', 1, GETUTCDATE(), DATEADD(YY,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
END
GO
IF NOT EXISTS (SELECT * FROM dbo.MGR_ConfigMaster WHERE ConfigName='MQSecureChannel' )
BEGIN
	INSERT [dbo].[MGR_ConfigMaster] ([LockedByRef], [UTCLockedOn], [ConfigName], [ConfigValue], [Version], [StartDate], [EndDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
	VALUES (NULL, NULL, N'MQSecureChannel', N'ERSUAT_SECCLNT', 1, GETUTCDATE(), DATEADD(YY,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
END
GO
IF NOT EXISTS (SELECT * FROM dbo.MGR_ConfigMaster WHERE ConfigName='MQHost' )
BEGIN
	INSERT [dbo].[MGR_ConfigMaster] ([LockedByRef], [UTCLockedOn], [ConfigName], [ConfigValue], [Version], [StartDate], [EndDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
	VALUES (NULL, NULL, N'MQHost', N'quesvc8e5', 1, GETUTCDATE(), DATEADD(YY,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
END
GO
IF NOT EXISTS (SELECT * FROM dbo.MGR_ConfigMaster WHERE ConfigName='MQPort' )
BEGIN
	INSERT [dbo].[MGR_ConfigMaster] ([LockedByRef], [UTCLockedOn], [ConfigName], [ConfigValue], [Version], [StartDate], [EndDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
	VALUES (NULL, NULL, N'MQPort', N'2246', 1, GETUTCDATE(), DATEADD(YY,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
END
GO
IF NOT EXISTS (SELECT * FROM dbo.MGR_ConfigMaster WHERE ConfigName='QueueManager' )
BEGIN
	INSERT [dbo].[MGR_ConfigMaster] ([LockedByRef], [UTCLockedOn], [ConfigName], [ConfigValue], [Version], [StartDate], [EndDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
	VALUES (NULL, NULL, N'QueueManager', N'WMQS29', 1, GETUTCDATE(), DATEADD(YY,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
END
GO
IF NOT EXISTS (SELECT * FROM dbo.MGR_ConfigMaster WHERE ConfigName='GetQueueName' )
BEGIN
	INSERT [dbo].[MGR_ConfigMaster] ([LockedByRef], [UTCLockedOn], [ConfigName], [ConfigValue], [Version], [StartDate], [EndDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
	VALUES (NULL, NULL, N'GetQueueName', N'ERS.UAT.OVAWESB_BATCH_DATA', 1, GETUTCDATE(), DATEADD(YY,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
END
GO
IF NOT EXISTS (SELECT * FROM dbo.MGR_ConfigMaster WHERE ConfigName='IsMQSecureConnection' )
BEGIN
	INSERT [dbo].[MGR_ConfigMaster] ([LockedByRef], [UTCLockedOn], [ConfigName], [ConfigValue], [Version], [StartDate], [EndDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
	VALUES (NULL, NULL, N'IsMQSecureConnection', N'true', 1, GETUTCDATE(), DATEADD(YY,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
END
GO
IF NOT EXISTS (SELECT * FROM dbo.MGR_ConfigMaster WHERE ConfigName='GetTopicName' )
BEGIN
	INSERT [dbo].[MGR_ConfigMaster] ([LockedByRef], [UTCLockedOn], [ConfigName], [ConfigValue], [Version], [StartDate], [EndDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
	VALUES (NULL, NULL, N'GetTopicName', N'uhg_sq/ovations/elg_recon', 1, GETUTCDATE(), DATEADD(YY,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
END
GO
IF NOT EXISTS (SELECT * FROM dbo.MGR_ConfigMaster WHERE ConfigName='MQmsgsToRead' )
BEGIN
	INSERT [dbo].[MGR_ConfigMaster] ([LockedByRef], [UTCLockedOn], [ConfigName], [ConfigValue], [Version], [StartDate], [EndDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
	VALUES (NULL, NULL, N'MQmsgsToRead', N'20', 1, GETUTCDATE(), DATEADD(YY,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
END
GO
IF NOT EXISTS (SELECT * FROM dbo.MGR_ConfigMaster WHERE ConfigName='NoOfGridRows' )
BEGIN
	INSERT [dbo].[MGR_ConfigMaster] ([LockedByRef], [UTCLockedOn], [ConfigName], [ConfigValue], [Version], [StartDate], [EndDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
	VALUES (NULL, NULL, N'NoOfGridRows', N'100', 1, GETUTCDATE(), DATEADD(YY,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
END
GO
IF NOT EXISTS (SELECT * FROM dbo.MGR_ConfigMaster WHERE ConfigName='MQSecureChannelUser' )
BEGIN
	INSERT [dbo].[MGR_ConfigMaster] ([LockedByRef], [UTCLockedOn], [ConfigName], [ConfigValue], [Version], [StartDate], [EndDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
	VALUES (NULL, NULL, N'MQSecureChannelUser', N'ersmqnp', 1, GETUTCDATE(), DATEADD(YY,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
END
GO
IF NOT EXISTS (SELECT * FROM dbo.MGR_ConfigMaster WHERE ConfigName='MQSecureChannelPwd' )
BEGIN
	INSERT [dbo].[MGR_ConfigMaster] ([LockedByRef], [UTCLockedOn], [ConfigName], [ConfigValue], [Version], [StartDate], [EndDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
	VALUES (NULL, NULL, N'MQSecureChannelPwd', N'4BgdiVw5', 1, GETUTCDATE(), DATEADD(YY,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
END
GO
IF NOT EXISTS (SELECT * FROM dbo.MGR_ConfigMaster WHERE ConfigName='GetSubscriptionName' )
BEGIN
	INSERT [dbo].[MGR_ConfigMaster] ([LockedByRef], [UTCLockedOn], [ConfigName], [ConfigValue], [Version], [StartDate], [EndDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
	VALUES (NULL, NULL, N'GetSubscriptionName', N'DurableSubscriptionName5', 1, GETUTCDATE(), DATEADD(YY,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
END
GO
IF NOT EXISTS (SELECT * FROM dbo.MGR_ConfigMaster WHERE ConfigName='GetSearchRangeInDays' )
BEGIN
	INSERT [dbo].[MGR_ConfigMaster] ([LockedByRef], [UTCLockedOn], [ConfigName], [ConfigValue], [Version], [StartDate], [EndDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
	VALUES (NULL, NULL, N'GetSearchRangeInDays', N'90', 1, GETUTCDATE(), DATEADD(YY,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
END
GO

IF NOT EXISTS (SELECT * FROM dbo.MGR_ConfigMaster WHERE ConfigName='EGHPExclusionFileName' )
BEGIN
	INSERT [dbo].[MGR_ConfigMaster] ([LockedByRef], [UTCLockedOn], [ConfigName], [ConfigValue], [Version], [StartDate], [EndDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
	VALUES (NULL, NULL, N'EGHPExclusionFileName', N'\\uec00003\billing&enrollment\GRIDS\EGHP\OOA-EGHP-Exclusions\OOA-PDP-Exclusions.xlsx', 1, GETUTCDATE(), DATEADD(YY,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
END
GO

------------------------- TEST ----------------------------------
--IF NOT EXISTS (SELECT * FROM dbo.MGR_ConfigMaster WHERE ConfigName='FDRSubmissionCategory2' )
--BEGIN
--	INSERT [dbo].[MGR_ConfigMaster] ([LockedByRef], [UTCLockedOn], [ConfigName], [ConfigValue], [Version], [StartDate], [EndDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
--	VALUES (NULL, NULL, N'FDRSubmissionCategory2', N'\\nasv0014\WebApp_test\ERS\Docs\FDRSubmission\UnProcessed\Category 2\|\\nasv0014\WebApp_test\ERS\Help\FDRSubmissionTemplate\|FDRSubmissionTemplate.xlsx|\\nasv0014\WebApp_test\ERS\Docs\FDRSubmission\Processed\Category 2\|RPC_Submission_Spreadsheet.xlsx|2|2', 1, GETUTCDATE(), DATEADD(YY,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
--END
--GO

--IF NOT EXISTS (SELECT * FROM dbo.MGR_ConfigMaster WHERE ConfigName='FDRSubmissionCategory2CTM' )
--BEGIN
--	INSERT [dbo].[MGR_ConfigMaster] ([LockedByRef], [UTCLockedOn], [ConfigName], [ConfigValue], [Version], [StartDate], [EndDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
--	VALUES (NULL, NULL, N'FDRSubmissionCategory2CTM', N'\\nasv0014\WebApp_test\ERS\Docs\FDRSubmission\UnProcessed\CTM\|\\nasv0014\WebApp_test\ERS\Help\FDRSubmissionTemplate\|FDRSubmissionTemplate.xlsx|\\nasv0014\WebApp_test\ERS\Docs\FDRSubmission\Processed\CTM\|RPC_Submission_Spreadsheet.xlsx|1|1', 1, GETUTCDATE(), DATEADD(YY,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
--END
--GO

--IF NOT EXISTS (SELECT * FROM dbo.MGR_ConfigMaster WHERE ConfigName='FDRSubmissionCategory3' )
--BEGIN
--	INSERT [dbo].[MGR_ConfigMaster] ([LockedByRef], [UTCLockedOn], [ConfigName], [ConfigValue], [Version], [StartDate], [EndDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
--	VALUES (NULL, NULL, N'FDRSubmissionCategory3', N'\\nasv0014\WebApp_test\ERS\Docs\FDRSubmission\UnProcessed\Category 3\|\\nasv0014\WebApp_test\ERS\Help\FDRSubmissionTemplate\|FDRSubmissionTemplate.xlsx|\\nasv0014\WebApp_test\ERS\Docs\FDRSubmission\Processed\Category 3\|RPC_Submission_Spreadsheet.xlsx|7|1', 1, GETUTCDATE(), DATEADD(YY,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
--END
--GO

--IF NOT EXISTS (SELECT * FROM dbo.MGR_ConfigMaster WHERE ConfigName='FDRSubmissionReSubmission' )
--BEGIN
--	INSERT [dbo].[MGR_ConfigMaster] ([LockedByRef], [UTCLockedOn], [ConfigName], [ConfigValue], [Version], [StartDate], [EndDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
--	VALUES (NULL, NULL, N'FDRSubmissionReSubmission', N'\\nasv0014\WebApp_test\ERS\Docs\FDRSubmission\UnProcessed\Resubmission\|\\nasv0014\WebApp_test\ERS\Help\FDRSubmissionTemplate\|FDRSubmissionTemplate.xlsx|\\nasv0014\WebApp_test\ERS\Docs\FDRSubmission\Processed\Resubmission\|RPC_Resubmission_Spreadsheet.xlsx|1|1', 1, GETUTCDATE(), DATEADD(YY,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
--END
--GO

--IF NOT EXISTS (SELECT * FROM dbo.MGR_ConfigMaster WHERE ConfigName='FDRSubmissionSCC' )
--BEGIN
--	INSERT [dbo].[MGR_ConfigMaster] ([LockedByRef], [UTCLockedOn], [ConfigName], [ConfigValue], [Version], [StartDate], [EndDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
--	VALUES (NULL, NULL, N'FDRSubmissionSCC', N'\\nasv0014\webapp_test\ERS\Docs\FDRSubmission\UnProcessed\SCC\|\\nasv0014\webapp_test\ERS\Help\FDRSubmissionTemplate\|SCCFDRSubmissionTemplate.xlsx|\\nasv0014\webapp_test\ERS\Docs\FDRSubmission\Processed\SCC\|RPC_SCC_Spreadsheet.xlsx|1|1', 1, GETUTCDATE(), DATEADD(YY,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
--END
--GO

--IF NOT EXISTS (SELECT * FROM dbo.MGR_ConfigMaster WHERE ConfigName='FDRSubmissionStartRowsForSheet' )
--BEGIN
--	INSERT [dbo].[MGR_ConfigMaster] ([LockedByRef], [UTCLockedOn], [ConfigName], [ConfigValue], [Version], [StartDate], [EndDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
--	VALUES (NULL, NULL, N'FDRSubmissionStartRowsForSheet', N'4|4|4|4', 1, GETUTCDATE(), DATEADD(YY,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
--END
--GO

--IF NOT EXISTS (SELECT * FROM dbo.MGR_ConfigMaster WHERE ConfigName='SCCFDRSubmissionStartRowsForSheet' )
--BEGIN
--	INSERT [dbo].[MGR_ConfigMaster] ([LockedByRef], [UTCLockedOn], [ConfigName], [ConfigValue], [Version], [StartDate], [EndDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
--	VALUES (NULL, NULL, N'SCCFDRSubmissionStartRowsForSheet', N'4', 1, GETUTCDATE(), DATEADD(YY,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
--END
--GO

--IF NOT EXISTS (SELECT * FROM dbo.MGR_ConfigMaster WHERE ConfigName='FDRSourcePath' )
--BEGIN
--	INSERT [dbo].[MGR_ConfigMaster] ([LockedByRef], [UTCLockedOn], [ConfigName], [ConfigValue], [Version], [StartDate], [EndDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
--	VALUES (NULL, NULL, N'FDRSourcePath', N'\\nasv0014\WebApp_test\ERS\Docs\FDRUpload\Source', 1, GETUTCDATE(), DATEADD(YY,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
--END
--GO

--IF NOT EXISTS (SELECT * FROM dbo.MGR_ConfigMaster WHERE ConfigName='FDRTempFolder' )
--BEGIN
--	INSERT [dbo].[MGR_ConfigMaster] ([LockedByRef], [UTCLockedOn], [ConfigName], [ConfigValue], [Version], [StartDate], [EndDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
--	VALUES (NULL, NULL, N'FDRTempFolder', N'\\nasv0014\WebApp_test\ERS\Temp', 1, GETUTCDATE(), DATEADD(YY,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
--END
--GO

--IF NOT EXISTS (SELECT * FROM dbo.MGR_ConfigMaster WHERE ConfigName='FDRTargetPath' )
--BEGIN
--	INSERT [dbo].[MGR_ConfigMaster] ([LockedByRef], [UTCLockedOn], [ConfigName], [ConfigValue], [Version], [StartDate], [EndDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
--	VALUES (NULL, NULL, N'FDRTargetPath', N'\\nasv0014\WebApp_test\ERS\Docs\FDRUpload\Target', 1, GETUTCDATE(), DATEADD(YY,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
--END
--GO

--IF NOT EXISTS (SELECT * FROM dbo.MGR_ConfigMaster WHERE ConfigName='FDRErrorFolder' )
--BEGIN
--	INSERT [dbo].[MGR_ConfigMaster] ([LockedByRef], [UTCLockedOn], [ConfigName], [ConfigValue], [Version], [StartDate], [EndDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
--	VALUES (NULL, NULL, N'FDRErrorFolder', N'\\nasv0014\WebApp_test\ERS\Docs\FDRUpload\Source\ErrorFile', 1, GETUTCDATE(), DATEADD(YY,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
--END
--GO

--IF NOT EXISTS (SELECT * FROM dbo.MGR_ConfigMaster WHERE ConfigName='FDRAlreadyProcessed' )
--BEGIN
--	INSERT [dbo].[MGR_ConfigMaster] ([LockedByRef], [UTCLockedOn], [ConfigName], [ConfigValue], [Version], [StartDate], [EndDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
--	VALUES (NULL, NULL, N'FDRAlreadyProcessed', N'\\nasv0014\WebApp_test\ERS\Docs\FDRUpload\Source\AlreadyProcessed', 1, GETUTCDATE(), DATEADD(YY,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
--END
--GO

--IF NOT EXISTS (SELECT * FROM dbo.MGR_ConfigMaster WHERE ConfigName='FDRErrorLog' )
--BEGIN
--	INSERT [dbo].[MGR_ConfigMaster] ([LockedByRef], [UTCLockedOn], [ConfigName], [ConfigValue], [Version], [StartDate], [EndDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
--	VALUES (NULL, NULL, N'FDRErrorLog', N'\\nasv0014\WebApp_test\ERS\Docs\FDRUpload\Source\ErrorLog', 1, GETUTCDATE(), DATEADD(YY,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
--END
--GO
--IF NOT EXISTS (SELECT * FROM dbo.MGR_ConfigMaster WHERE ConfigName='BulkUploadFileFormats' )
--BEGIN
--	INSERT [dbo].[MGR_ConfigMaster] ([LockedByRef], [UTCLockedOn], [ConfigName], [ConfigValue], [Version], [StartDate], [EndDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
--	VALUES (NULL, NULL, N'BulkUploadFileFormats', N',csv,', 1, GETUTCDATE(), DATEADD(YY,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
--END
--GO
--IF NOT EXISTS (SELECT * FROM dbo.MGR_ConfigMaster WHERE ConfigName='AttchmentFileFormat' )
--BEGIN
--	INSERT [dbo].[MGR_ConfigMaster] ([LockedByRef], [UTCLockedOn], [ConfigName], [ConfigValue], [Version], [StartDate], [EndDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
--	VALUES (NULL, NULL, N'AttchmentFileFormat', N',pdf,', 1, GETUTCDATE(), DATEADD(YY,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
--END
--GO
--IF NOT EXISTS (SELECT * FROM dbo.MGR_ConfigMaster WHERE ConfigName='BulkUploadFilePath' )
--BEGIN
--	INSERT [dbo].[MGR_ConfigMaster] ([LockedByRef], [UTCLockedOn], [ConfigName], [ConfigValue], [Version], [StartDate], [EndDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
--	VALUES (NULL, NULL, N'BulkUploadFilePath', N'\\nasv0014\webapp_test\ERS\Docs\BulkUpload\', 1, GETUTCDATE(), DATEADD(YY,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
--END
--GO
--IF NOT EXISTS (SELECT * FROM dbo.MGR_ConfigMaster WHERE ConfigName='webServerTempPath' )
--BEGIN
--	INSERT [dbo].[MGR_ConfigMaster] ([LockedByRef], [UTCLockedOn], [ConfigName], [ConfigValue], [Version], [StartDate], [EndDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
--	VALUES (NULL, NULL, N'webServerTempPath', N'\\nasv0014\webapp_test\ERS\Temp\', 1, GETUTCDATE(), DATEADD(YY,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
--END
--GO
--IF NOT EXISTS (SELECT * FROM dbo.MGR_ConfigMaster WHERE ConfigName='AttchmentFilePath' )
--BEGIN
--	INSERT [dbo].[MGR_ConfigMaster] ([LockedByRef], [UTCLockedOn], [ConfigName], [ConfigValue], [Version], [StartDate], [EndDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
--	VALUES (NULL, NULL, N'AttchmentFilePath', N'\\nasv0014\webapp_test\ERS\Docs\Attachments\', 1, GETUTCDATE(), DATEADD(YY,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
--END
--GO
--IF NOT EXISTS (SELECT * FROM dbo.MGR_ConfigMaster WHERE ConfigName='AutoUnlockRecordHours' )
--BEGIN
--	INSERT [dbo].[MGR_ConfigMaster] ([LockedByRef], [UTCLockedOn], [ConfigName], [ConfigValue], [Version], [StartDate], [EndDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
--	VALUES (NULL, NULL, N'AutoUnlockRecordHours', N'2', 1, GETUTCDATE(), DATEADD(YY,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
--END
--GO
--IF NOT EXISTS (SELECT * FROM dbo.MGR_ConfigMaster WHERE ConfigName='MQNonSecureChannel' )
--BEGIN
--	INSERT [dbo].[MGR_ConfigMaster] ([LockedByRef], [UTCLockedOn], [ConfigName], [ConfigValue], [Version], [StartDate], [EndDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
--	VALUES (NULL, NULL, N'MQNonSecureChannel', N'ERSUATCLNT', 1, GETUTCDATE(), DATEADD(YY,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
--END
--GO
--IF NOT EXISTS (SELECT * FROM dbo.MGR_ConfigMaster WHERE ConfigName='MQSecureChannel' )
--BEGIN
--	INSERT [dbo].[MGR_ConfigMaster] ([LockedByRef], [UTCLockedOn], [ConfigName], [ConfigValue], [Version], [StartDate], [EndDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
--	VALUES (NULL, NULL, N'MQSecureChannel', N'ERSUAT_SECCLNT', 1, GETUTCDATE(), DATEADD(YY,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
--END
--GO
--IF NOT EXISTS (SELECT * FROM dbo.MGR_ConfigMaster WHERE ConfigName='MQHost' )
--BEGIN
--	INSERT [dbo].[MGR_ConfigMaster] ([LockedByRef], [UTCLockedOn], [ConfigName], [ConfigValue], [Version], [StartDate], [EndDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
--	VALUES (NULL, NULL, N'MQHost', N'quesvc8e5', 1, GETUTCDATE(), DATEADD(YY,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
--END
--GO
--IF NOT EXISTS (SELECT * FROM dbo.MGR_ConfigMaster WHERE ConfigName='MQPort' )
--BEGIN
--	INSERT [dbo].[MGR_ConfigMaster] ([LockedByRef], [UTCLockedOn], [ConfigName], [ConfigValue], [Version], [StartDate], [EndDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
--	VALUES (NULL, NULL, N'MQPort', N'2246', 1, GETUTCDATE(), DATEADD(YY,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
--END
--GO
--IF NOT EXISTS (SELECT * FROM dbo.MGR_ConfigMaster WHERE ConfigName='QueueManager' )
--BEGIN
--	INSERT [dbo].[MGR_ConfigMaster] ([LockedByRef], [UTCLockedOn], [ConfigName], [ConfigValue], [Version], [StartDate], [EndDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
--	VALUES (NULL, NULL, N'QueueManager', N'WMQS29', 1, GETUTCDATE(), DATEADD(YY,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
--END
--GO
--IF NOT EXISTS (SELECT * FROM dbo.MGR_ConfigMaster WHERE ConfigName='GetQueueName' )
--BEGIN
--	INSERT [dbo].[MGR_ConfigMaster] ([LockedByRef], [UTCLockedOn], [ConfigName], [ConfigValue], [Version], [StartDate], [EndDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
--	VALUES (NULL, NULL, N'GetQueueName', N'ERS.UAT.OVAWESB_BATCH_DATA', 1, GETUTCDATE(), DATEADD(YY,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
--END
--GO
--IF NOT EXISTS (SELECT * FROM dbo.MGR_ConfigMaster WHERE ConfigName='IsMQSecureConnection' )
--BEGIN
--	INSERT [dbo].[MGR_ConfigMaster] ([LockedByRef], [UTCLockedOn], [ConfigName], [ConfigValue], [Version], [StartDate], [EndDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
--	VALUES (NULL, NULL, N'IsMQSecureConnection', N'false', 1, GETUTCDATE(), DATEADD(YY,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
--END
--GO
--IF NOT EXISTS (SELECT * FROM dbo.MGR_ConfigMaster WHERE ConfigName='GetTopicName' )
--BEGIN
--	INSERT [dbo].[MGR_ConfigMaster] ([LockedByRef], [UTCLockedOn], [ConfigName], [ConfigValue], [Version], [StartDate], [EndDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
--	VALUES (NULL, NULL, N'GetTopicName', N'uhg_sq/ovations/elg_recon', 1, GETUTCDATE(), DATEADD(YY,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
--END
--GO
--IF NOT EXISTS (SELECT * FROM dbo.MGR_ConfigMaster WHERE ConfigName='MQmsgsToRead' )
--BEGIN
--	INSERT [dbo].[MGR_ConfigMaster] ([LockedByRef], [UTCLockedOn], [ConfigName], [ConfigValue], [Version], [StartDate], [EndDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
--	VALUES (NULL, NULL, N'MQmsgsToRead', N'20', 1, GETUTCDATE(), DATEADD(YY,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
--END
--GO
--IF NOT EXISTS (SELECT * FROM dbo.MGR_ConfigMaster WHERE ConfigName='NoOfGridRows' )
--BEGIN
--	INSERT [dbo].[MGR_ConfigMaster] ([LockedByRef], [UTCLockedOn], [ConfigName], [ConfigValue], [Version], [StartDate], [EndDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
--	VALUES (NULL, NULL, N'NoOfGridRows', N'100', 1, GETUTCDATE(), DATEADD(YY,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
--END
--GO
--IF NOT EXISTS (SELECT * FROM dbo.MGR_ConfigMaster WHERE ConfigName='GetSubscriptionName' )
--BEGIN
--	INSERT [dbo].[MGR_ConfigMaster] ([LockedByRef], [UTCLockedOn], [ConfigName], [ConfigValue], [Version], [StartDate], [EndDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
--	VALUES (NULL, NULL, N'GetSubscriptionName', N'DurableSubscriptionName5', 1, GETUTCDATE(), DATEADD(YY,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
--END
--GO
--IF NOT EXISTS (SELECT * FROM dbo.MGR_ConfigMaster WHERE ConfigName='GetSearchRangeInDays' )
--BEGIN
--	INSERT [dbo].[MGR_ConfigMaster] ([LockedByRef], [UTCLockedOn], [ConfigName], [ConfigValue], [Version], [StartDate], [EndDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
--	VALUES (NULL, NULL, N'GetSearchRangeInDays', N'90', 1, GETUTCDATE(), DATEADD(YY,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
--END
--GO
--IF NOT EXISTS (SELECT * FROM dbo.MGR_ConfigMaster WHERE ConfigName='EGHPExclusionFileName' )
--BEGIN
--	INSERT [dbo].[MGR_ConfigMaster] ([LockedByRef], [UTCLockedOn], [ConfigName], [ConfigValue], [Version], [StartDate], [EndDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
--	VALUES (NULL, NULL, N'EGHPExclusionFileName', N'\\uec00003\billing&enrollment\GRIDS\EGHP\OOA-EGHP-Exclusions\OOA-PDP-Exclusions.xlsx', 1, GETUTCDATE(), DATEADD(YY,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
--END
--GO
------------------------- STAGE ----------------------------------
--IF NOT EXISTS (SELECT * FROM dbo.MGR_ConfigMaster WHERE ConfigName='FDRSubmissionCategory2' )
--BEGIN
--	INSERT [dbo].[MGR_ConfigMaster] ([LockedByRef], [UTCLockedOn], [ConfigName], [ConfigValue], [Version], [StartDate], [EndDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
--	VALUES (NULL, NULL, N'FDRSubmissionCategory2', N'\\nasv0052\webapp_stage\ERS\Docs\FDRSubmission\UnProcessed\Category 2\|\\nasv0052\webapp_stage\ERS\Help\FDRSubmissionTemplate\|FDRSubmissionTemplate.xlsx|\\nasv0052\webapp_stage\ERS\Docs\FDRSubmission\Processed\Category 2\|RPC_Submission_Spreadsheet.xlsx|2|2', 1, GETUTCDATE(), DATEADD(YY,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
--END
--GO

--IF NOT EXISTS (SELECT * FROM dbo.MGR_ConfigMaster WHERE ConfigName='FDRSubmissionCategory2CTM' )
--BEGIN
--	INSERT [dbo].[MGR_ConfigMaster] ([LockedByRef], [UTCLockedOn], [ConfigName], [ConfigValue], [Version], [StartDate], [EndDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
--	VALUES (NULL, NULL, N'FDRSubmissionCategory2CTM', N'\\nasv0052\webapp_stage\ERS\Docs\FDRSubmission\UnProcessed\CTM\|\\nasv0052\webapp_stage\ERS\Help\FDRSubmissionTemplate\|FDRSubmissionTemplate.xlsx|\\nasv0052\webapp_stage\ERS\Docs\FDRSubmission\Processed\CTM\|RPC_Submission_Spreadsheet.xlsx|1|1', 1, GETUTCDATE(), DATEADD(YY,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
--END
--GO

--IF NOT EXISTS (SELECT * FROM dbo.MGR_ConfigMaster WHERE ConfigName='FDRSubmissionCategory3' )
--BEGIN
--	INSERT [dbo].[MGR_ConfigMaster] ([LockedByRef], [UTCLockedOn], [ConfigName], [ConfigValue], [Version], [StartDate], [EndDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
--	VALUES (NULL, NULL, N'FDRSubmissionCategory3', N'\\nasv0052\webapp_stage\ERS\Docs\FDRSubmission\UnProcessed\Category 3\|\\nasv0052\webapp_stage\ERS\Help\FDRSubmissionTemplate\|FDRSubmissionTemplate.xlsx|\\nasv0052\webapp_stage\ERS\Docs\FDRSubmission\Processed\Category 3\|RPC_Submission_Spreadsheet.xlsx|7|1', 1, GETUTCDATE(), DATEADD(YY,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
--END
--GO

--IF NOT EXISTS (SELECT * FROM dbo.MGR_ConfigMaster WHERE ConfigName='FDRSubmissionReSubmission' )
--BEGIN
--	INSERT [dbo].[MGR_ConfigMaster] ([LockedByRef], [UTCLockedOn], [ConfigName], [ConfigValue], [Version], [StartDate], [EndDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
--	VALUES (NULL, NULL, N'FDRSubmissionReSubmission', N'\\nasv0052\webapp_stage\ERS\Docs\FDRSubmission\UnProcessed\Resubmission\|\\nasv0052\webapp_stage\ERS\Help\FDRSubmissionTemplate\|FDRSubmissionTemplate.xlsx|\\nasv0052\webapp_stage\ERS\Docs\FDRSubmission\Processed\Resubmission\|RPC_Resubmission_Spreadsheet.xlsx|1|1', 1, GETUTCDATE(), DATEADD(YY,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
--END
--GO

--IF NOT EXISTS (SELECT * FROM dbo.MGR_ConfigMaster WHERE ConfigName='FDRSubmissionSCC' )
--BEGIN
--	INSERT [dbo].[MGR_ConfigMaster] ([LockedByRef], [UTCLockedOn], [ConfigName], [ConfigValue], [Version], [StartDate], [EndDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
--	VALUES (NULL, NULL, N'FDRSubmissionSCC', N'\\nasv0052\webapp_stage\ERS\Docs\FDRSubmission\UnProcessed\SCC\|\\nasv0052\webapp_stage\ERS\Help\FDRSubmissionTemplate\|SCCFDRSubmissionTemplate.xlsx|\\nasv0052\webapp_stage\ERS\Docs\FDRSubmission\Processed\SCC\|RPC_SCC_Spreadsheet.xlsx|1|1', 1, GETUTCDATE(), DATEADD(YY,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
--END
--GO

--IF NOT EXISTS (SELECT * FROM dbo.MGR_ConfigMaster WHERE ConfigName='FDRSubmissionStartRowsForSheet' )
--BEGIN
--	INSERT [dbo].[MGR_ConfigMaster] ([LockedByRef], [UTCLockedOn], [ConfigName], [ConfigValue], [Version], [StartDate], [EndDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
--	VALUES (NULL, NULL, N'FDRSubmissionStartRowsForSheet', N'4|4|4|4', 1, GETUTCDATE(), DATEADD(YY,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
--END
--GO

--IF NOT EXISTS (SELECT * FROM dbo.MGR_ConfigMaster WHERE ConfigName='SCCFDRSubmissionStartRowsForSheet' )
--BEGIN
--	INSERT [dbo].[MGR_ConfigMaster] ([LockedByRef], [UTCLockedOn], [ConfigName], [ConfigValue], [Version], [StartDate], [EndDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
--	VALUES (NULL, NULL, N'SCCFDRSubmissionStartRowsForSheet', N'4', 1, GETUTCDATE(), DATEADD(YY,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
--END
--GO

--IF NOT EXISTS (SELECT * FROM dbo.MGR_ConfigMaster WHERE ConfigName='FDRSourcePath' )
--BEGIN
--	INSERT [dbo].[MGR_ConfigMaster] ([LockedByRef], [UTCLockedOn], [ConfigName], [ConfigValue], [Version], [StartDate], [EndDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
--	VALUES (NULL, NULL, N'FDRSourcePath', N'\\nasv0052\webapp_stage\ERS\Docs\FDRUpload\Source', 1, GETUTCDATE(), DATEADD(YY,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
--END
--GO

--IF NOT EXISTS (SELECT * FROM dbo.MGR_ConfigMaster WHERE ConfigName='FDRTempFolder' )
--BEGIN
--	INSERT [dbo].[MGR_ConfigMaster] ([LockedByRef], [UTCLockedOn], [ConfigName], [ConfigValue], [Version], [StartDate], [EndDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
--	VALUES (NULL, NULL, N'FDRTempFolder', N'\\nasv0052\webapp_stage\ERS\Temp', 1, GETUTCDATE(), DATEADD(YY,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
--END
--GO

--IF NOT EXISTS (SELECT * FROM dbo.MGR_ConfigMaster WHERE ConfigName='FDRTargetPath' )
--BEGIN
--	INSERT [dbo].[MGR_ConfigMaster] ([LockedByRef], [UTCLockedOn], [ConfigName], [ConfigValue], [Version], [StartDate], [EndDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
--	VALUES (NULL, NULL, N'FDRTargetPath', N'\\nasv0052\webapp_stage\ERS\Docs\FDRUpload\Target', 1, GETUTCDATE(), DATEADD(YY,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
--END
--GO

--IF NOT EXISTS (SELECT * FROM dbo.MGR_ConfigMaster WHERE ConfigName='FDRErrorFolder' )
--BEGIN
--	INSERT [dbo].[MGR_ConfigMaster] ([LockedByRef], [UTCLockedOn], [ConfigName], [ConfigValue], [Version], [StartDate], [EndDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
--	VALUES (NULL, NULL, N'FDRErrorFolder', N'\\nasv0052\webapp_stage\ERS\Docs\FDRUpload\Source\ErrorFile', 1, GETUTCDATE(), DATEADD(YY,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
--END
--GO

--IF NOT EXISTS (SELECT * FROM dbo.MGR_ConfigMaster WHERE ConfigName='FDRAlreadyProcessed' )
--BEGIN
--	INSERT [dbo].[MGR_ConfigMaster] ([LockedByRef], [UTCLockedOn], [ConfigName], [ConfigValue], [Version], [StartDate], [EndDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
--	VALUES (NULL, NULL, N'FDRAlreadyProcessed', N'\\nasv0052\webapp_stage\ERS\Docs\FDRUpload\Source\AlreadyProcessed', 1, GETUTCDATE(), DATEADD(YY,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
--END
--GO

--IF NOT EXISTS (SELECT * FROM dbo.MGR_ConfigMaster WHERE ConfigName='FDRErrorLog' )
--BEGIN
--	INSERT [dbo].[MGR_ConfigMaster] ([LockedByRef], [UTCLockedOn], [ConfigName], [ConfigValue], [Version], [StartDate], [EndDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
--	VALUES (NULL, NULL, N'FDRErrorLog', N'\\nasv0052\webapp_stage\ERS\Docs\FDRUpload\Source\ErrorLog', 1, GETUTCDATE(), DATEADD(YY,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
--END
--GO
--IF NOT EXISTS (SELECT * FROM dbo.MGR_ConfigMaster WHERE ConfigName='BulkUploadFileFormats' )
--BEGIN
--	INSERT [dbo].[MGR_ConfigMaster] ([LockedByRef], [UTCLockedOn], [ConfigName], [ConfigValue], [Version], [StartDate], [EndDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
--	VALUES (NULL, NULL, N'BulkUploadFileFormats', N',csv,', 1, GETUTCDATE(), DATEADD(YY,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
--END
--GO
--IF NOT EXISTS (SELECT * FROM dbo.MGR_ConfigMaster WHERE ConfigName='AttchmentFileFormat' )
--BEGIN
--	INSERT [dbo].[MGR_ConfigMaster] ([LockedByRef], [UTCLockedOn], [ConfigName], [ConfigValue], [Version], [StartDate], [EndDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
--	VALUES (NULL, NULL, N'AttchmentFileFormat', N',pdf,', 1, GETUTCDATE(), DATEADD(YY,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
--END
--GO
--IF NOT EXISTS (SELECT * FROM dbo.MGR_ConfigMaster WHERE ConfigName='BulkUploadFilePath' )
--BEGIN
--	INSERT [dbo].[MGR_ConfigMaster] ([LockedByRef], [UTCLockedOn], [ConfigName], [ConfigValue], [Version], [StartDate], [EndDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
--	VALUES (NULL, NULL, N'BulkUploadFilePath', N'\\nasv0052\webapp_stage\ERS\Docs\BulkUpload\', 1, GETUTCDATE(), DATEADD(YY,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
--END
--GO
--IF NOT EXISTS (SELECT * FROM dbo.MGR_ConfigMaster WHERE ConfigName='webServerTempPath' )
--BEGIN
--	INSERT [dbo].[MGR_ConfigMaster] ([LockedByRef], [UTCLockedOn], [ConfigName], [ConfigValue], [Version], [StartDate], [EndDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
--	VALUES (NULL, NULL, N'webServerTempPath', N'\\nasv0052\webapp_stage\ERS\Temp\', 1, GETUTCDATE(), DATEADD(YY,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
--END
--GO
--IF NOT EXISTS (SELECT * FROM dbo.MGR_ConfigMaster WHERE ConfigName='AttchmentFilePath' )
--BEGIN
--	INSERT [dbo].[MGR_ConfigMaster] ([LockedByRef], [UTCLockedOn], [ConfigName], [ConfigValue], [Version], [StartDate], [EndDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
--	VALUES (NULL, NULL, N'AttchmentFilePath', N'\\nasv0052\webapp_stage\ERS\Docs\Attachments\', 1, GETUTCDATE(), DATEADD(YY,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
--END
--GO
--IF NOT EXISTS (SELECT * FROM dbo.MGR_ConfigMaster WHERE ConfigName='AutoUnlockRecordHours' )
--BEGIN
--	INSERT [dbo].[MGR_ConfigMaster] ([LockedByRef], [UTCLockedOn], [ConfigName], [ConfigValue], [Version], [StartDate], [EndDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
--	VALUES (NULL, NULL, N'AutoUnlockRecordHours', N'2', 1, GETUTCDATE(), DATEADD(YY,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
--END
--GO
--IF NOT EXISTS (SELECT * FROM dbo.MGR_ConfigMaster WHERE ConfigName='MQNonSecureChannel' )
--BEGIN
--	INSERT [dbo].[MGR_ConfigMaster] ([LockedByRef], [UTCLockedOn], [ConfigName], [ConfigValue], [Version], [StartDate], [EndDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
--	VALUES (NULL, NULL, N'MQNonSecureChannel', N'ERSUATCLNT', 1, GETUTCDATE(), DATEADD(YY,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
--END
--GO
--IF NOT EXISTS (SELECT * FROM dbo.MGR_ConfigMaster WHERE ConfigName='MQSecureChannel' )
--BEGIN
--	INSERT [dbo].[MGR_ConfigMaster] ([LockedByRef], [UTCLockedOn], [ConfigName], [ConfigValue], [Version], [StartDate], [EndDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
--	VALUES (NULL, NULL, N'MQSecureChannel', N'ERSUAT_SECCLNT', 1, GETUTCDATE(), DATEADD(YY,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
--END
--GO
--IF NOT EXISTS (SELECT * FROM dbo.MGR_ConfigMaster WHERE ConfigName='MQHost' )
--BEGIN
--	INSERT [dbo].[MGR_ConfigMaster] ([LockedByRef], [UTCLockedOn], [ConfigName], [ConfigValue], [Version], [StartDate], [EndDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
--	VALUES (NULL, NULL, N'MQHost', N'quesvc8e5', 1, GETUTCDATE(), DATEADD(YY,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
--END
--GO
--IF NOT EXISTS (SELECT * FROM dbo.MGR_ConfigMaster WHERE ConfigName='MQPort' )
--BEGIN
--	INSERT [dbo].[MGR_ConfigMaster] ([LockedByRef], [UTCLockedOn], [ConfigName], [ConfigValue], [Version], [StartDate], [EndDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
--	VALUES (NULL, NULL, N'MQPort', N'2246', 1, GETUTCDATE(), DATEADD(YY,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
--END
--GO
--IF NOT EXISTS (SELECT * FROM dbo.MGR_ConfigMaster WHERE ConfigName='QueueManager' )
--BEGIN
--	INSERT [dbo].[MGR_ConfigMaster] ([LockedByRef], [UTCLockedOn], [ConfigName], [ConfigValue], [Version], [StartDate], [EndDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
--	VALUES (NULL, NULL, N'QueueManager', N'WMQS29', 1, GETUTCDATE(), DATEADD(YY,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
--END
--GO
--IF NOT EXISTS (SELECT * FROM dbo.MGR_ConfigMaster WHERE ConfigName='GetQueueName' )
--BEGIN
--	INSERT [dbo].[MGR_ConfigMaster] ([LockedByRef], [UTCLockedOn], [ConfigName], [ConfigValue], [Version], [StartDate], [EndDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
--	VALUES (NULL, NULL, N'GetQueueName', N'ERS.UAT.OVAWESB_BATCH_DATA', 1, GETUTCDATE(), DATEADD(YY,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
--END
--GO
--IF NOT EXISTS (SELECT * FROM dbo.MGR_ConfigMaster WHERE ConfigName='IsMQSecureConnection' )
--BEGIN
--	INSERT [dbo].[MGR_ConfigMaster] ([LockedByRef], [UTCLockedOn], [ConfigName], [ConfigValue], [Version], [StartDate], [EndDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
--	VALUES (NULL, NULL, N'IsMQSecureConnection', N'true', 1, GETUTCDATE(), DATEADD(YY,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
--END
--GO
--IF NOT EXISTS (SELECT * FROM dbo.MGR_ConfigMaster WHERE ConfigName='GetTopicName' )
--BEGIN
--	INSERT [dbo].[MGR_ConfigMaster] ([LockedByRef], [UTCLockedOn], [ConfigName], [ConfigValue], [Version], [StartDate], [EndDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
--	VALUES (NULL, NULL, N'GetTopicName', N'uhg_sq/ovations/elg_recon', 1, GETUTCDATE(), DATEADD(YY,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
--END
--GO
--IF NOT EXISTS (SELECT * FROM dbo.MGR_ConfigMaster WHERE ConfigName='MQmsgsToRead' )
--BEGIN
--	INSERT [dbo].[MGR_ConfigMaster] ([LockedByRef], [UTCLockedOn], [ConfigName], [ConfigValue], [Version], [StartDate], [EndDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
--	VALUES (NULL, NULL, N'MQmsgsToRead', N'20', 1, GETUTCDATE(), DATEADD(YY,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
--END
--GO
--IF NOT EXISTS (SELECT * FROM dbo.MGR_ConfigMaster WHERE ConfigName='NoOfGridRows' )
--BEGIN
--	INSERT [dbo].[MGR_ConfigMaster] ([LockedByRef], [UTCLockedOn], [ConfigName], [ConfigValue], [Version], [StartDate], [EndDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
--	VALUES (NULL, NULL, N'NoOfGridRows', N'100', 1, GETUTCDATE(), DATEADD(YY,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
--END
--GO
--IF NOT EXISTS (SELECT * FROM dbo.MGR_ConfigMaster WHERE ConfigName='MQSecureChannelUser' )
--BEGIN
--	INSERT [dbo].[MGR_ConfigMaster] ([LockedByRef], [UTCLockedOn], [ConfigName], [ConfigValue], [Version], [StartDate], [EndDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
--	VALUES (NULL, NULL, N'MQSecureChannelUser', N'ersmqnp', 1, GETUTCDATE(), DATEADD(YY,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
--END
--GO
--IF NOT EXISTS (SELECT * FROM dbo.MGR_ConfigMaster WHERE ConfigName='MQSecureChannelPwd' )
--BEGIN
--	INSERT [dbo].[MGR_ConfigMaster] ([LockedByRef], [UTCLockedOn], [ConfigName], [ConfigValue], [Version], [StartDate], [EndDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
--	VALUES (NULL, NULL, N'MQSecureChannelPwd', N'4BgdiVw5', 1, GETUTCDATE(), DATEADD(YY,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
--END
--GO
--IF NOT EXISTS (SELECT * FROM dbo.MGR_ConfigMaster WHERE ConfigName='GetSubscriptionName' )
--BEGIN
--	INSERT [dbo].[MGR_ConfigMaster] ([LockedByRef], [UTCLockedOn], [ConfigName], [ConfigValue], [Version], [StartDate], [EndDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
--	VALUES (NULL, NULL, N'GetSubscriptionName', N'DurableSubscriptionName5', 1, GETUTCDATE(), DATEADD(YY,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
--END
--GO
--IF NOT EXISTS (SELECT * FROM dbo.MGR_ConfigMaster WHERE ConfigName='GetSearchRangeInDays' )
--BEGIN
--	INSERT [dbo].[MGR_ConfigMaster] ([LockedByRef], [UTCLockedOn], [ConfigName], [ConfigValue], [Version], [StartDate], [EndDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
--	VALUES (NULL, NULL, N'GetSearchRangeInDays', N'90', 1, GETUTCDATE(), DATEADD(YY,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
--END
--GO
--IF NOT EXISTS (SELECT * FROM dbo.MGR_ConfigMaster WHERE ConfigName='EGHPExclusionFileName' )
--BEGIN
--	INSERT [dbo].[MGR_ConfigMaster] ([LockedByRef], [UTCLockedOn], [ConfigName], [ConfigValue], [Version], [StartDate], [EndDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
--	VALUES (NULL, NULL, N'EGHPExclusionFileName', N'\\uec00003\billing&enrollment\GRIDS\EGHP\OOA-EGHP-Exclusions\OOA-PDP-Exclusions.xlsx', 1, GETUTCDATE(), DATEADD(YY,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
--END
--GO

------------------------- PRODUCTION ----------------------------------


--IF NOT EXISTS (SELECT * FROM dbo.MGR_ConfigMaster WHERE ConfigName='FDRSubmissionCategory2' )
--BEGIN
--	INSERT [dbo].[MGR_ConfigMaster] ([LockedByRef], [UTCLockedOn], [ConfigName], [ConfigValue], [Version], [StartDate], [EndDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
--	VALUES (NULL, NULL, N'FDRSubmissionCategory2', N'\\nasv0200\webapp_prod\ERS\Docs\FDRSubmission\UnProcessed\Category 2\|\\nasv0200\webapp_prod\ERS\Help\FDRSubmissionTemplate\|FDRSubmissionTemplate.xlsx|\\nasv0200\webapp_prod\ERS\Docs\FDRSubmission\Processed\Category 2\|RPC_Submission_Spreadsheet.xlsx|2|2', 1, GETUTCDATE(), DATEADD(YY,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
--END
--GO

--IF NOT EXISTS (SELECT * FROM dbo.MGR_ConfigMaster WHERE ConfigName='FDRSubmissionCategory2CTM' )
--BEGIN
--	INSERT [dbo].[MGR_ConfigMaster] ([LockedByRef], [UTCLockedOn], [ConfigName], [ConfigValue], [Version], [StartDate], [EndDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
--	VALUES (NULL, NULL, N'FDRSubmissionCategory2CTM', N'\\nasv0200\webapp_prod\ERS\Docs\FDRSubmission\UnProcessed\CTM\|\\nasv0200\webapp_prod\ERS\Help\FDRSubmissionTemplate\|FDRSubmissionTemplate.xlsx|\\nasv0200\webapp_prod\ERS\Docs\FDRSubmission\Processed\CTM\|RPC_Submission_Spreadsheet.xlsx|1|1', 1, GETUTCDATE(), DATEADD(YY,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
--END
--GO

--IF NOT EXISTS (SELECT * FROM dbo.MGR_ConfigMaster WHERE ConfigName='FDRSubmissionCategory3' )
--BEGIN
--	INSERT [dbo].[MGR_ConfigMaster] ([LockedByRef], [UTCLockedOn], [ConfigName], [ConfigValue], [Version], [StartDate], [EndDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
--	VALUES (NULL, NULL, N'FDRSubmissionCategory3', N'\\nasv0200\webapp_prod\ERS\Docs\FDRSubmission\UnProcessed\Category 3\|\\nasv0200\webapp_prod\ERS\Help\FDRSubmissionTemplate\|FDRSubmissionTemplate.xlsx|\\nasv0200\webapp_prod\ERS\Docs\FDRSubmission\Processed\Category 3\|RPC_Submission_Spreadsheet.xlsx|7|1', 1, GETUTCDATE(), DATEADD(YY,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
--END
--GO

--IF NOT EXISTS (SELECT * FROM dbo.MGR_ConfigMaster WHERE ConfigName='FDRSubmissionReSubmission' )
--BEGIN
--	INSERT [dbo].[MGR_ConfigMaster] ([LockedByRef], [UTCLockedOn], [ConfigName], [ConfigValue], [Version], [StartDate], [EndDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
--	VALUES (NULL, NULL, N'FDRSubmissionReSubmission', N'\\nasv0200\webapp_prod\ERS\Docs\FDRSubmission\UnProcessed\Resubmission\|\\nasv0200\webapp_prod\ERS\Help\FDRSubmissionTemplate\|FDRSubmissionTemplate.xlsx|\\nasv0200\webapp_prod\ERS\Docs\FDRSubmission\Processed\Resubmission\|RPC_Resubmission_Spreadsheet.xlsx|1|1', 1, GETUTCDATE(), DATEADD(YY,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
--END
--GO

--IF NOT EXISTS (SELECT * FROM dbo.MGR_ConfigMaster WHERE ConfigName='FDRSubmissionSCC' )
--BEGIN
--	INSERT [dbo].[MGR_ConfigMaster] ([LockedByRef], [UTCLockedOn], [ConfigName], [ConfigValue], [Version], [StartDate], [EndDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
--	VALUES (NULL, NULL, N'FDRSubmissionSCC', N'\\nasv0200\webapp_prod\ERS\Docs\FDRSubmission\UnProcessed\SCC\|\\nasv0200\webapp_prod\ERS\Help\FDRSubmissionTemplate\|SCCFDRSubmissionTemplate.xlsx|\\nasv0200\webapp_prod\ERS\Docs\FDRSubmission\Processed\SCC\|RPC_SCC_Spreadsheet.xlsx|1|1', 1, GETUTCDATE(), DATEADD(YY,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
--END
--GO

--IF NOT EXISTS (SELECT * FROM dbo.MGR_ConfigMaster WHERE ConfigName='FDRSubmissionStartRowsForSheet' )
--BEGIN
--	INSERT [dbo].[MGR_ConfigMaster] ([LockedByRef], [UTCLockedOn], [ConfigName], [ConfigValue], [Version], [StartDate], [EndDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
--	VALUES (NULL, NULL, N'FDRSubmissionStartRowsForSheet', N'4|4|4|4', 1, GETUTCDATE(), DATEADD(YY,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
--END
--GO

--IF NOT EXISTS (SELECT * FROM dbo.MGR_ConfigMaster WHERE ConfigName='SCCFDRSubmissionStartRowsForSheet' )
--BEGIN
--	INSERT [dbo].[MGR_ConfigMaster] ([LockedByRef], [UTCLockedOn], [ConfigName], [ConfigValue], [Version], [StartDate], [EndDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
--	VALUES (NULL, NULL, N'SCCFDRSubmissionStartRowsForSheet', N'4', 1, GETUTCDATE(), DATEADD(YY,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
--END
--GO

--IF NOT EXISTS (SELECT * FROM dbo.MGR_ConfigMaster WHERE ConfigName='FDRSourcePath' )
--BEGIN
--	INSERT [dbo].[MGR_ConfigMaster] ([LockedByRef], [UTCLockedOn], [ConfigName], [ConfigValue], [Version], [StartDate], [EndDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
--	VALUES (NULL, NULL, N'FDRSourcePath', N'\\nasv0200\webapp_prod\ERS\Docs\FDRUpload\Source', 1, GETUTCDATE(), DATEADD(YY,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
--END
--GO

--IF NOT EXISTS (SELECT * FROM dbo.MGR_ConfigMaster WHERE ConfigName='FDRTempFolder' )
--BEGIN
--	INSERT [dbo].[MGR_ConfigMaster] ([LockedByRef], [UTCLockedOn], [ConfigName], [ConfigValue], [Version], [StartDate], [EndDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
--	VALUES (NULL, NULL, N'FDRTempFolder', N'\\nasv0200\webapp_prod\ERS\Temp', 1, GETUTCDATE(), DATEADD(YY,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
--END
--GO

--IF NOT EXISTS (SELECT * FROM dbo.MGR_ConfigMaster WHERE ConfigName='FDRTargetPath' )
--BEGIN
--	INSERT [dbo].[MGR_ConfigMaster] ([LockedByRef], [UTCLockedOn], [ConfigName], [ConfigValue], [Version], [StartDate], [EndDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
--	VALUES (NULL, NULL, N'FDRTargetPath', N'\\nasv0200\webapp_prod\ERS\Docs\FDRUpload\Target', 1, GETUTCDATE(), DATEADD(YY,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
--END
--GO

--IF NOT EXISTS (SELECT * FROM dbo.MGR_ConfigMaster WHERE ConfigName='FDRErrorFolder' )
--BEGIN
--	INSERT [dbo].[MGR_ConfigMaster] ([LockedByRef], [UTCLockedOn], [ConfigName], [ConfigValue], [Version], [StartDate], [EndDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
--	VALUES (NULL, NULL, N'FDRErrorFolder', N'\\nasv0200\webapp_prod\ERS\Docs\FDRUpload\Source\ErrorFile', 1, GETUTCDATE(), DATEADD(YY,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
--END
--GO

--IF NOT EXISTS (SELECT * FROM dbo.MGR_ConfigMaster WHERE ConfigName='FDRAlreadyProcessed' )
--BEGIN
--	INSERT [dbo].[MGR_ConfigMaster] ([LockedByRef], [UTCLockedOn], [ConfigName], [ConfigValue], [Version], [StartDate], [EndDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
--	VALUES (NULL, NULL, N'FDRAlreadyProcessed', N'\\nasv0200\webapp_prod\ERS\Docs\FDRUpload\Source\AlreadyProcessed', 1, GETUTCDATE(), DATEADD(YY,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
--END
--GO

--IF NOT EXISTS (SELECT * FROM dbo.MGR_ConfigMaster WHERE ConfigName='FDRErrorLog' )
--BEGIN
--	INSERT [dbo].[MGR_ConfigMaster] ([LockedByRef], [UTCLockedOn], [ConfigName], [ConfigValue], [Version], [StartDate], [EndDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
--	VALUES (NULL, NULL, N'FDRErrorLog', N'\\nasv0200\webapp_prod\ERS\Docs\FDRUpload\Source\ErrorLog', 1, GETUTCDATE(), DATEADD(YY,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
--END
--GO
--IF NOT EXISTS (SELECT * FROM dbo.MGR_ConfigMaster WHERE ConfigName='BulkUploadFileFormats' )
--BEGIN
--	INSERT [dbo].[MGR_ConfigMaster] ([LockedByRef], [UTCLockedOn], [ConfigName], [ConfigValue], [Version], [StartDate], [EndDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
--	VALUES (NULL, NULL, N'BulkUploadFileFormats', N',csv,', 1, GETUTCDATE(), DATEADD(YY,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
--END
--GO
--IF NOT EXISTS (SELECT * FROM dbo.MGR_ConfigMaster WHERE ConfigName='AttchmentFileFormat' )
--BEGIN
--	INSERT [dbo].[MGR_ConfigMaster] ([LockedByRef], [UTCLockedOn], [ConfigName], [ConfigValue], [Version], [StartDate], [EndDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
--	VALUES (NULL, NULL, N'AttchmentFileFormat', N',pdf,', 1, GETUTCDATE(), DATEADD(YY,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
--END
--GO
--IF NOT EXISTS (SELECT * FROM dbo.MGR_ConfigMaster WHERE ConfigName='BulkUploadFilePath' )
--BEGIN
--	INSERT [dbo].[MGR_ConfigMaster] ([LockedByRef], [UTCLockedOn], [ConfigName], [ConfigValue], [Version], [StartDate], [EndDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
--	VALUES (NULL, NULL, N'BulkUploadFilePath', N'\\nasv0200\webapp_prod\ERS\Docs\BulkUpload\', 1, GETUTCDATE(), DATEADD(YY,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
--END
--GO
--IF NOT EXISTS (SELECT * FROM dbo.MGR_ConfigMaster WHERE ConfigName='webServerTempPath' )
--BEGIN
--	INSERT [dbo].[MGR_ConfigMaster] ([LockedByRef], [UTCLockedOn], [ConfigName], [ConfigValue], [Version], [StartDate], [EndDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
--	VALUES (NULL, NULL, N'webServerTempPath', N'\\nasv0200\webapp_prod\ERS\Temp\', 1, GETUTCDATE(), DATEADD(YY,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
--END
--GO
--IF NOT EXISTS (SELECT * FROM dbo.MGR_ConfigMaster WHERE ConfigName='AttchmentFilePath' )
--BEGIN
--	INSERT [dbo].[MGR_ConfigMaster] ([LockedByRef], [UTCLockedOn], [ConfigName], [ConfigValue], [Version], [StartDate], [EndDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
--	VALUES (NULL, NULL, N'AttchmentFilePath', N'\\nasv0200\webapp_prod\ERS\Docs\Attachments\', 1, GETUTCDATE(), DATEADD(YY,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
--END
--GO
--IF NOT EXISTS (SELECT * FROM dbo.MGR_ConfigMaster WHERE ConfigName='AutoUnlockRecordHours' )
--BEGIN
--	INSERT [dbo].[MGR_ConfigMaster] ([LockedByRef], [UTCLockedOn], [ConfigName], [ConfigValue], [Version], [StartDate], [EndDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
--	VALUES (NULL, NULL, N'AutoUnlockRecordHours', N'2', 1, GETUTCDATE(), DATEADD(YY,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
--END
--GO
--IF NOT EXISTS (SELECT * FROM dbo.MGR_ConfigMaster WHERE ConfigName='MQNonSecureChannel' )
--BEGIN
--	INSERT [dbo].[MGR_ConfigMaster] ([LockedByRef], [UTCLockedOn], [ConfigName], [ConfigValue], [Version], [StartDate], [EndDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
--	VALUES (NULL, NULL, N'MQNonSecureChannel', N'ERSCLNT', 1, GETUTCDATE(), DATEADD(YY,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
--END
--GO
--IF NOT EXISTS (SELECT * FROM dbo.MGR_ConfigMaster WHERE ConfigName='MQSecureChannel' )
--BEGIN
--	INSERT [dbo].[MGR_ConfigMaster] ([LockedByRef], [UTCLockedOn], [ConfigName], [ConfigValue], [Version], [StartDate], [EndDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
--	VALUES (NULL, NULL, N'MQSecureChannel', N'ERS_SECCLNT', 1, GETUTCDATE(), DATEADD(YY,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
--END
--GO
--IF NOT EXISTS (SELECT * FROM dbo.MGR_ConfigMaster WHERE ConfigName='MQHost' )
--BEGIN
--	INSERT [dbo].[MGR_ConfigMaster] ([LockedByRef], [UTCLockedOn], [ConfigName], [ConfigValue], [Version], [StartDate], [EndDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
--	VALUES (NULL, NULL, N'MQHost', N'quesvc086', 1, GETUTCDATE(), DATEADD(YY,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
--END
--GO
--IF NOT EXISTS (SELECT * FROM dbo.MGR_ConfigMaster WHERE ConfigName='MQPort' )
--BEGIN
--	INSERT [dbo].[MGR_ConfigMaster] ([LockedByRef], [UTCLockedOn], [ConfigName], [ConfigValue], [Version], [StartDate], [EndDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
--	VALUES (NULL, NULL, N'MQPort', N'1956', 1, GETUTCDATE(), DATEADD(YY,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
--END
--GO
--IF NOT EXISTS (SELECT * FROM dbo.MGR_ConfigMaster WHERE ConfigName='QueueManager' )
--BEGIN
--	INSERT [dbo].[MGR_ConfigMaster] ([LockedByRef], [UTCLockedOn], [ConfigName], [ConfigValue], [Version], [StartDate], [EndDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
--	VALUES (NULL, NULL, N'QueueManager', N'WMQPD33', 1, GETUTCDATE(), DATEADD(YY,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
--END
--GO
--IF NOT EXISTS (SELECT * FROM dbo.MGR_ConfigMaster WHERE ConfigName='GetQueueName' )
--BEGIN
--	INSERT [dbo].[MGR_ConfigMaster] ([LockedByRef], [UTCLockedOn], [ConfigName], [ConfigValue], [Version], [StartDate], [EndDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
--	VALUES (NULL, NULL, N'GetQueueName', N'ERS.OVAWESB_BATCH_DATA', 1, GETUTCDATE(), DATEADD(YY,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
--END
--GO
--IF NOT EXISTS (SELECT * FROM dbo.MGR_ConfigMaster WHERE ConfigName='IsMQSecureConnection' )
--BEGIN
--	INSERT [dbo].[MGR_ConfigMaster] ([LockedByRef], [UTCLockedOn], [ConfigName], [ConfigValue], [Version], [StartDate], [EndDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
--	VALUES (NULL, NULL, N'IsMQSecureConnection', N'true', 1, GETUTCDATE(), DATEADD(YY,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
--END
--GO
--IF NOT EXISTS (SELECT * FROM dbo.MGR_ConfigMaster WHERE ConfigName='GetTopicName' )
--BEGIN
--	INSERT [dbo].[MGR_ConfigMaster] ([LockedByRef], [UTCLockedOn], [ConfigName], [ConfigValue], [Version], [StartDate], [EndDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
--	VALUES (NULL, NULL, N'GetTopicName', N'uhg_pq/ovations/elg_recon', 1, GETUTCDATE(), DATEADD(YY,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
--END
--GO
--IF NOT EXISTS (SELECT * FROM dbo.MGR_ConfigMaster WHERE ConfigName='MQmsgsToRead' )
--BEGIN
--	INSERT [dbo].[MGR_ConfigMaster] ([LockedByRef], [UTCLockedOn], [ConfigName], [ConfigValue], [Version], [StartDate], [EndDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
--	VALUES (NULL, NULL, N'MQmsgsToRead', N'1', 1, GETUTCDATE(), DATEADD(YY,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
--END
--GO
--IF NOT EXISTS (SELECT * FROM dbo.MGR_ConfigMaster WHERE ConfigName='NoOfGridRows' )
--BEGIN
--	INSERT [dbo].[MGR_ConfigMaster] ([LockedByRef], [UTCLockedOn], [ConfigName], [ConfigValue], [Version], [StartDate], [EndDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
--	VALUES (NULL, NULL, N'NoOfGridRows', N'100', 1, GETUTCDATE(), DATEADD(YY,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
--END
--GO
--IF NOT EXISTS (SELECT * FROM dbo.MGR_ConfigMaster WHERE ConfigName='MQSecureChannelUser' )
--BEGIN
--	INSERT [dbo].[MGR_ConfigMaster] ([LockedByRef], [UTCLockedOn], [ConfigName], [ConfigValue], [Version], [StartDate], [EndDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
--	VALUES (NULL, NULL, N'MQSecureChannelUser', N'ersmqp', 1, GETUTCDATE(), DATEADD(YY,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
--END
--GO
--IF NOT EXISTS (SELECT * FROM dbo.MGR_ConfigMaster WHERE ConfigName='MQSecureChannelPwd' )
--BEGIN
--	INSERT [dbo].[MGR_ConfigMaster] ([LockedByRef], [UTCLockedOn], [ConfigName], [ConfigValue], [Version], [StartDate], [EndDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
--	VALUES (NULL, NULL, N'MQSecureChannelPwd', N'rz9QM3EK', 1, GETUTCDATE(), DATEADD(YY,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
--END
--GO
--IF NOT EXISTS (SELECT * FROM dbo.MGR_ConfigMaster WHERE ConfigName='GetSubscriptionName' )
--BEGIN
--	INSERT [dbo].[MGR_ConfigMaster] ([LockedByRef], [UTCLockedOn], [ConfigName], [ConfigValue], [Version], [StartDate], [EndDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
--	VALUES (NULL, NULL, N'GetSubscriptionName', N'NewDurableSubscription', 1, GETUTCDATE(), DATEADD(YY,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
--END
--GO
--IF NOT EXISTS (SELECT * FROM dbo.MGR_ConfigMaster WHERE ConfigName='GetSearchRangeInDays' )
--BEGIN
--	INSERT [dbo].[MGR_ConfigMaster] ([LockedByRef], [UTCLockedOn], [ConfigName], [ConfigValue], [Version], [StartDate], [EndDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
--	VALUES (NULL, NULL, N'GetSearchRangeInDays', N'90', 1, GETUTCDATE(), DATEADD(YY,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
--END
--GO
--IF NOT EXISTS (SELECT * FROM dbo.MGR_ConfigMaster WHERE ConfigName='EGHPExclusionFileName' )
--BEGIN
--	INSERT [dbo].[MGR_ConfigMaster] ([LockedByRef], [UTCLockedOn], [ConfigName], [ConfigValue], [Version], [StartDate], [EndDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
--	VALUES (NULL, NULL, N'EGHPExclusionFileName', N'\\uec00003\billing&enrollment\GRIDS\EGHP\OOA-EGHP-Exclusions\OOA-PDP-Exclusions.xlsx', 1, GETUTCDATE(), DATEADD(YY,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
--END
--GO

