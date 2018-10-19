use ers
---DEV
SET IDENTITY_INSERT [dbo].[RPT_ReportsMaster] ON

IF NOT EXISTS (SELECT * FROM [dbo].[RPT_ReportsMaster] WHERE RPT_ReportsMasterId=01 )
BEGIN
	INSERT INTO [dbo].[RPT_ReportsMaster]([RPT_ReportsMasterId],[ReportName],[ReportServer],[ReportURL],[ReportsCategoryLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[ViewInUI])
	VALUES (01,N'ERS Home Page Summary Report',N'dbsed3561',N'https://rrtreportsdev.uhc.com/ReportServer/Pages/ReportViewer.aspx?%2fERS_Everyone%2frpt_ERS_01_HomePage&rs:Command=Render',42002,1,getutcdate(),1,1)

END
GO

IF NOT EXISTS (SELECT * FROM [dbo].[RPT_ReportsMaster] WHERE RPT_ReportsMasterId=02 )
BEGIN
	INSERT INTO [dbo].[RPT_ReportsMaster]([RPT_ReportsMasterId],[ReportName],[ReportServer],[ReportURL],[ReportsCategoryLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[ViewInUI])
	VALUES (02,N'ERS Error Log Report',N'dbsed3561',N'https://rrtreportsdev.uhc.com/ReportServer/Pages/ReportViewer.aspx?%2fERS_Everyone%2frpt_ERS_02_ErrorLog&rs:Command=Render',42002,1,getutcdate(),1,1)

END
GO
IF NOT EXISTS (SELECT * FROM [dbo].[RPT_ReportsMaster] WHERE RPT_ReportsMasterId=03 )
BEGIN
	INSERT INTO [dbo].[RPT_ReportsMaster]([RPT_ReportsMasterId],[ReportName],[ReportServer],[ReportURL],[ReportsCategoryLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[ViewInUI])
	VALUES (03,N'ERS Locked Records Report',N'dbsed3561',N'https://rrtreportsdev.uhc.com/ReportServer/Pages/ReportViewer.aspx?%2fERS_Everyone%2frpt_ERS_03_LockedRecords&rs:Command=Render',42002,1,getutcdate(),1,1)

END
GO

IF NOT EXISTS (SELECT * FROM [dbo].[RPT_ReportsMaster] WHERE RPT_ReportsMasterId=04 )
BEGIN
	INSERT INTO [dbo].[RPT_ReportsMaster]([RPT_ReportsMasterId],[ReportName],[ReportServer],[ReportURL],[ReportsCategoryLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[ViewInUI])
	VALUES (04,N'ERS Alerts Field Change Logging Report',N'dbsed3561',N'https://rrtreportsdev.uhc.com/ReportServer/Pages/ReportViewer.aspx?%2fERS_Everyone%2frpt_ERS_04_Alerts_Field_Change_Logging_Report&rs:Command=Render',42002,1,getutcdate(),1,0)

END
GO

IF NOT EXISTS (SELECT * FROM [dbo].[RPT_ReportsMaster] WHERE RPT_ReportsMasterId=05 )
BEGIN
	INSERT INTO [dbo].[RPT_ReportsMaster]([RPT_ReportsMasterId],[ReportName],[ReportServer],[ReportURL],[ReportsCategoryLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[ViewInUI])
	VALUES (05,N'ERS Skills Field Change Logging Report',N'dbsed3561',N'https://rrtreportsdev.uhc.com/ReportServer/Pages/ReportViewer.aspx?%2fERS_Everyone%2frpt_ERS_05_Skills_Field_Change_Logging_Report&rs:Command=Render',42002,1,getutcdate(),1,0)

END
GO


IF NOT EXISTS (SELECT * FROM [dbo].[RPT_ReportsMaster] WHERE RPT_ReportsMasterId=06 )
BEGIN
	INSERT INTO [dbo].[RPT_ReportsMaster]([RPT_ReportsMasterId],[ReportName],[ReportServer],[ReportURL],[ReportsCategoryLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[ViewInUI])
	VALUES (06,N'ERS User Admin Field Change Logging Report',N'dbsed3561',N'https://rrtreportsdev.uhc.com/ReportServer/Pages/ReportViewer.aspx?%2fERS_Everyone%2frpt_ERS_06_UserAdmin_Field_Change_Logging_Report&rs:Command=Render',42001,1,getutcdate(),1,0)

END
GO

IF NOT EXISTS (SELECT * FROM [dbo].[RPT_ReportsMaster] WHERE RPT_ReportsMasterId=07 )
BEGIN
	INSERT INTO [dbo].[RPT_ReportsMaster]([RPT_ReportsMasterId],[ReportName],[ReportServer],[ReportURL],[ReportsCategoryLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[ViewInUI])
	VALUES (07,N'ERS Department Field Change Logging Report',N'dbsed3561',N'https://rrtreportsdev.uhc.com/ReportServer/Pages/ReportViewer.aspx?%2fERS_Everyone%2frpt_ERS_07_Department_Field_Change_Logging_Report&rs:Command=Render',42001,1,getutcdate(),1,0)

END
GO

IF NOT EXISTS (SELECT * FROM [dbo].[RPT_ReportsMaster] WHERE RPT_ReportsMasterId=08 )
BEGIN
	INSERT INTO [dbo].[RPT_ReportsMaster]([RPT_ReportsMasterId],[ReportName],[ReportServer],[ReportURL],[ReportsCategoryLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[ViewInUI])
	VALUES (08,N'ERS Lookup Field Change Logging Report',N'dbsed3561',N'https://rrtreportsdev.uhc.com/ReportServer/Pages/ReportViewer.aspx?%2fERS_Everyone%2frpt_ERS_08_Lookup_Field_Change_Logging_Report&rs:Command=Render',42001,1,getutcdate(),1,0)

END
GO

IF NOT EXISTS (SELECT * FROM [dbo].[RPT_ReportsMaster] WHERE RPT_ReportsMasterId=09 )
BEGIN
	INSERT INTO [dbo].[RPT_ReportsMaster]([RPT_ReportsMasterId],[ReportName],[ReportServer],[ReportURL],[ReportsCategoryLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[ViewInUI])
	VALUES (09,N'ERS Lookup Correlation Field Change Logging Report',N'dbsed3561',N'https://rrtreportsdev.uhc.com/ReportServer/Pages/ReportViewer.aspx?%2fERS_Everyone%2frpt_ERS_09_LookupCorrelation_Field_Change_Logging_Report&rs:Command=Render',42001,1,getutcdate(),1,0)

END
GO

IF NOT EXISTS (SELECT * FROM [dbo].[RPT_ReportsMaster] WHERE RPT_ReportsMasterId=10 )
BEGIN
	INSERT INTO [dbo].[RPT_ReportsMaster]([RPT_ReportsMasterId],[ReportName],[ReportServer],[ReportURL],[ReportsCategoryLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[ViewInUI])
	VALUES (10,N'ERS Resource Field Change Logging Report',N'dbsed3561',N'https://rrtreportsdev.uhc.com/ReportServer/Pages/ReportViewer.aspx?%2fERS_Everyone%2frpt_ERS_10_Resource_Field_Change_Logging_Report&rs:Command=Render',42001,1,getutcdate(),1,0)

END
GO

IF NOT EXISTS (SELECT * FROM [dbo].[RPT_ReportsMaster] WHERE RPT_ReportsMasterId=11 )
BEGIN
	INSERT INTO [dbo].[RPT_ReportsMaster]([RPT_ReportsMasterId],[ReportName],[ReportServer],[ReportURL],[ReportsCategoryLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[ViewInUI])
	VALUES (11,N'ERS Config Field Change Logging Report',N'dbsed3561',N'https://rrtreportsdev.uhc.com/ReportServer/Pages/ReportViewer.aspx?%2fERS_Everyone%2frpt_ERS_11_Config_Field_Change_Logging_Report&rs:Command=Render',42001,1,getutcdate(),1,0)

END
GO

IF NOT EXISTS (SELECT * FROM [dbo].[RPT_ReportsMaster] WHERE RPT_ReportsMasterId=12 )
BEGIN
	INSERT INTO [dbo].[RPT_ReportsMaster]([RPT_ReportsMasterId],[ReportName],[ReportServer],[ReportURL],[ReportsCategoryLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[ViewInUI])
	VALUES (12,N'ERS Access Group Field Change Logging Report',N'dbsed3561',N'https://rrtreportsdev.uhc.com/ReportServer/Pages/ReportViewer.aspx?%2fERS_Everyone%2frpt_ERS_12_AccessGroup_Field_Change_Logging_Report&rs:Command=Render',42001,1,getutcdate(),1,0)

END
GO

IF NOT EXISTS (SELECT * FROM [dbo].[RPT_ReportsMaster] WHERE RPT_ReportsMasterId=13 )
BEGIN
	INSERT INTO [dbo].[RPT_ReportsMaster]([RPT_ReportsMasterId],[ReportName],[ReportServer],[ReportURL],[ReportsCategoryLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[ViewInUI])
	VALUES (13,N'ERS Common Field Change Logging Report',N'dbsed3561',N'https://rrtreportsdev.uhc.com/ReportServer/Pages/ReportViewer.aspx?%2fERS_Everyone%2frpt_ERS_13_Queue_Field_Change_Logging_Report&rs:Command=Render',42001,1,getutcdate(),1,0)

END
GO

IF NOT EXISTS (SELECT * FROM [dbo].[RPT_ReportsMaster] WHERE RPT_ReportsMasterId=14 )
BEGIN
	INSERT INTO [dbo].[RPT_ReportsMaster]([RPT_ReportsMasterId],[ReportName],[ReportServer],[ReportURL],[ReportsCategoryLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[ViewInUI])
	VALUES (14,N'MTD Peer Audit Quality Report',N'dbsed3561',N'https://rrtreportsdev.uhc.com/ReportServer/Pages/ReportViewer.aspx?%2fERS_Everyone%2frpt_ERS_14_MTD_Peer_Audit_Quality_Summary_Report&rs:Command=Render',42001,1,getutcdate(),1,1)
END
GO

IF NOT EXISTS (SELECT * FROM [dbo].[RPT_ReportsMaster] WHERE RPT_ReportsMasterId=15 )
BEGIN
	INSERT INTO [dbo].[RPT_ReportsMaster]([RPT_ReportsMasterId],[ReportName],[ReportServer],[ReportURL],[ReportsCategoryLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[ViewInUI])
	VALUES (15,N'Background Process Monitor Report',N'dbsed3561',N'https://rrtreportsdev.uhc.com/ReportServer/Pages/ReportViewer.aspx?%2fERS_Everyone%2frpt_ERS_15_BGProcessMonitorSummary_Report&rs:Command=Render',42001,1,getutcdate(),1,1)
END
GO


IF NOT EXISTS (SELECT * FROM [dbo].[RPT_ReportsMaster] WHERE RPT_ReportsMasterId=16 )
BEGIN
	INSERT INTO [dbo].[RPT_ReportsMaster]([RPT_ReportsMasterId],[ReportName],[ReportServer],[ReportURL],[ReportsCategoryLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[ViewInUI])
	VALUES (16,N'Daily Dashboard Report',N'dbsed3561',N'https://rrtreportsdev.uhc.com/ReportServer/Pages/ReportViewer.aspx?%2fERS_Everyone%2frpt_ERS_16_Daily_Dashboard_Summary_Report&rs:Command=Render',42001,1,getutcdate(),1,1)
END
GO

IF NOT EXISTS (SELECT * FROM [dbo].[RPT_ReportsMaster] WHERE RPT_ReportsMasterId=17 )
BEGIN
	INSERT INTO [dbo].[RPT_ReportsMaster]([RPT_ReportsMasterId],[ReportName],[ReportServer],[ReportURL],[ReportsCategoryLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[ViewInUI])
	VALUES (17,N'Pended Report',N'dbsed3561',N'https://rrtreportsdev.uhc.com/ReportServer/Pages/ReportViewer.aspx?%2fERS_Everyone%2frpt_ERS_17_Pended_Report_Summary&rs:Command=Render',42001,1,getutcdate(),1,1)
END
GO

IF NOT EXISTS (SELECT * FROM [dbo].[RPT_ReportsMaster] WHERE RPT_ReportsMasterId=18 )
BEGIN
	INSERT INTO [dbo].[RPT_ReportsMaster]([RPT_ReportsMasterId],[ReportName],[ReportServer],[ReportURL],[ReportsCategoryLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[ViewInUI])
	VALUES (18,N'Monthly Metrics Report',N'dbsed3561',N'https://rrtreportsdev.uhc.com/ReportServer/Pages/ReportViewer.aspx?%2fERS_Everyone%2frpt_ERS_18_Monthly_Metrics_Summary_Report&rs:Command=Render',42001,1,getutcdate(),1,1)
END
GO
IF NOT EXISTS (SELECT * FROM [dbo].[RPT_ReportsMaster] WHERE RPT_ReportsMasterId=19 )
BEGIN
	INSERT INTO [dbo].[RPT_ReportsMaster]([RPT_ReportsMasterId],[ReportName],[ReportServer],[ReportURL],[ReportsCategoryLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[ViewInUI])
	VALUES (19,N'OOA Tracking Report',N'dbsed3561',N'https://rrtreportsdev.uhc.com/ReportServer/Pages/ReportViewer.aspx?%2fERS_Everyone%2frpt_ERS_19_OOA_Tracking_Report_Summary&rs:Command=Render',42001,1,getutcdate(),1,1)
END
GO

IF NOT EXISTS (SELECT * FROM [dbo].[RPT_ReportsMaster] WHERE RPT_ReportsMasterId=20 )
BEGIN
	INSERT INTO [dbo].[RPT_ReportsMaster]([RPT_ReportsMasterId],[ReportName],[ReportServer],[ReportURL],[ReportsCategoryLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[ViewInUI])
	VALUES (20,N'RPR Submission Report',N'dbsed3561',N'https://rrtreportsdev.uhc.com/ReportServer/Pages/ReportViewer.aspx?%2fERS_Everyone%2frpt_ERS_20_RPR_Submission_Report_Summary&rs:Command=Render',42001,1,getutcdate(),1,1)
END
GO

IF NOT EXISTS (SELECT * FROM [dbo].[RPT_ReportsMaster] WHERE RPT_ReportsMasterId=21 )
BEGIN
	INSERT INTO [dbo].[RPT_ReportsMaster]([RPT_ReportsMasterId],[ReportName],[ReportServer],[ReportURL],[ReportsCategoryLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[ViewInUI])
	VALUES (21,N'Web Service Monitoring Report',N'dbsed3561',N'https://rrtreportsdev.uhc.com/ReportServer/Pages/ReportViewer.aspx?%2fERS_Everyone%2frpt_ERS_21_WebService_Monitoring_Summary_Report&rs:Command=Render',42001,1,getutcdate(),1,1)
END
GO


IF NOT EXISTS (SELECT * FROM [dbo].[RPT_ReportsMaster] WHERE RPT_ReportsMasterId=22 )
BEGIN
	INSERT INTO [dbo].[RPT_ReportsMaster]([RPT_ReportsMasterId],[ReportName],[ReportServer],[ReportURL],[ReportsCategoryLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[ViewInUI])
	VALUES (22,N'Queue Detail Report',N'dbsed3561',N'https://rrtreportsdev.uhc.com/ReportServer/Pages/ReportViewer.aspx?%2fERS_Everyone%2frpt_ERS_22_Queue_Details_Report&rs:Command=Render',42001,1,getutcdate(),1,0)
END
GO

IF NOT EXISTS (SELECT * FROM [dbo].[RPT_ReportsMaster] WHERE RPT_ReportsMasterId=23 )
BEGIN
	INSERT INTO [dbo].[RPT_ReportsMaster]([RPT_ReportsMasterId],[ReportName],[ReportServer],[ReportURL],[ReportsCategoryLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[ViewInUI])
	VALUES (23,N'MQ Processing Report',N'dbsed3561',N'https://rrtreportsdev.uhc.com/ReportServer/Pages/ReportViewer.aspx?%2fERS_Everyone%2frpt_ERS_23_MQ_Records_Processing_Summary_Report&rs:Command=Render',42001,1,getutcdate(),1,1)
END
GO

IF NOT EXISTS (SELECT * FROM [dbo].[RPT_ReportsMaster] WHERE RPT_ReportsMasterId=24 )
BEGIN
	INSERT INTO [dbo].[RPT_ReportsMaster]([RPT_ReportsMasterId],[ReportName],[ReportServer],[ReportURL],[ReportsCategoryLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[ViewInUI])
	VALUES (24,N'OOA Reports',N'dbsed3561',N'https://rrtssrs2014prod.uhc.com/Reports/Pages/Report.aspx?ItemPath=%2fOOA%2fRPT_UHC_OOA_SAS_Auto_Process',42001,1,getutcdate(),1,1)
END
GO
IF NOT EXISTS (SELECT * FROM [dbo].[RPT_ReportsMaster] WHERE RPT_ReportsMasterId=25 )
BEGIN
	INSERT INTO [dbo].[RPT_ReportsMaster]([RPT_ReportsMasterId],[ReportName],[ReportServer],[ReportURL],[ReportsCategoryLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[ViewInUI])
	VALUES (25,N'Mass Update Report',N'dbsed3561',N'https://rrtreportsdev.uhc.com/ReportServer/Pages/ReportViewer.aspx?%2fERS_Everyone%2fERS_Everyone%2frpt_ERS_24_MassUpdate_Summary_Report&rs:Command=Render',42001,1,getutcdate(),1,1)
END
GO

IF NOT EXISTS (SELECT * FROM [dbo].[RPT_ReportsMaster] WHERE RPT_ReportsMasterId=26 )
BEGIN
	INSERT INTO [dbo].[RPT_ReportsMaster]([RPT_ReportsMasterId],[ReportName],[ReportServer],[ReportURL],[ReportsCategoryLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[ViewInUI])
	VALUES (26,N'ERS Queue Search Report',N'dbsed3561',N'https://rrtreportsdev.uhc.com/ReportServer/Pages/ReportViewer.aspx?%2fERS_Everyone%2frpt_ERS_26_Queue_Searh_Detail_Report&rs:Command=Render',42001,1,getutcdate(),1,0)
END
GO

IF NOT EXISTS (SELECT * FROM [dbo].[RPT_ReportsMaster] WHERE RPT_ReportsMasterId=27 )
BEGIN
	INSERT INTO [dbo].[RPT_ReportsMaster]([RPT_ReportsMasterId],[ReportName],[ReportServer],[ReportURL],[ReportsCategoryLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[ViewInUI])
	VALUES (27,N'ERS Bulk Upload Report',N'dbsed3561',N'https://rrtreportsdev.uhc.com/ReportServer/Pages/ReportViewer.aspx?%2fERS_Everyone%2frpt_ERS_25_Bulk_Upload_Summary_Report&rs:Command=Render',42001,1,getutcdate(),1,1)
END
GO

IF NOT EXISTS (SELECT * FROM [dbo].[RPT_ReportsMaster] WHERE RPT_ReportsMasterId=28 )
BEGIN
	INSERT INTO [dbo].[RPT_ReportsMaster]([RPT_ReportsMasterId],[ReportName],[ReportServer],[ReportURL],[ReportsCategoryLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[ViewInUI])
	VALUES (28,N'RPR Plan Error Report',N'dbsed3561',N'https://rrtreportsdev.uhc.com/ReportServer/Pages/ReportViewer.aspx?%2fERS_Everyone%2frpt_ERS_27_ERS_RPRPlanError_Summary_Report&rs:Command=Render',42001,1,getutcdate(),1,1)
END
GO

IF NOT EXISTS (SELECT * FROM [dbo].[RPT_ReportsMaster] WHERE RPT_ReportsMasterId=29 )
BEGIN
	INSERT INTO [dbo].[RPT_ReportsMaster]([RPT_ReportsMasterId],[ReportName],[ReportServer],[ReportURL],[ReportsCategoryLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[ViewInUI])
	VALUES (29,N'OOA Control Report',N'dbsed3561',N'https://rrtssrs2014prod.uhc.com/Reports/Pages/Report.aspx?ItemPath=%2fERS_BI_DATA%2fUHC_ERS_CONTROL_RPT',42001,1,getutcdate(),1,1)
END
GO

IF NOT EXISTS (SELECT * FROM [dbo].[RPT_ReportsMaster] WHERE RPT_ReportsMasterId=30 )
BEGIN
	INSERT INTO [dbo].[RPT_ReportsMaster]([RPT_ReportsMasterId],[ReportName],[ReportServer],[ReportURL],[ReportsCategoryLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[ViewInUI])
	VALUES (30,N'OOA Dashboard Report',N'dbsed3561',N'https://rrtssrs2014prod.uhc.com/Reports/Pages/Report.aspx?ItemPath=%2fOOA%2fRPT_UHG_OOA_DashBoard',42001,1,getutcdate(),1,1)
END
GO

SET IDENTITY_INSERT [dbo].[RPT_ReportsMaster] OFF

---TEST
--SET IDENTITY_INSERT [dbo].[RPT_ReportsMaster] ON

--IF NOT EXISTS (SELECT * FROM [dbo].[RPT_ReportsMaster] WHERE RPT_ReportsMasterId=01 )
--BEGIN
--     INSERT INTO [dbo].[RPT_ReportsMaster]([RPT_ReportsMasterId],[ReportName],[ReportServer],[ReportURL],[ReportsCategoryLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[ViewInUI])
--     VALUES (01,N'ERS Home Page Summary Report',N'dbset1611',N'https://rrtreportstest.uhc.com/ReportServer/Pages/ReportViewer.aspx?%2fERS_Everyone%2frpt_ERS_01_HomePage&rs:Command=Render',42002,1,getutcdate(),1,1)

--END
--GO

--IF NOT EXISTS (SELECT * FROM [dbo].[RPT_ReportsMaster] WHERE RPT_ReportsMasterId=02 )
--BEGIN
--     INSERT INTO [dbo].[RPT_ReportsMaster]([RPT_ReportsMasterId],[ReportName],[ReportServer],[ReportURL],[ReportsCategoryLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[ViewInUI])
--     VALUES (02,N'ERS Error Log Report',N'dbset1611',N'https://rrtreportstest.uhc.com/ReportServer/Pages/ReportViewer.aspx?%2fERS_Everyone%2frpt_ERS_02_ErrorLog&rs:Command=Render',42002,1,getutcdate(),1,1)

--END
--GO
--IF NOT EXISTS (SELECT * FROM [dbo].[RPT_ReportsMaster] WHERE RPT_ReportsMasterId=03 )
--BEGIN
--     INSERT INTO [dbo].[RPT_ReportsMaster]([RPT_ReportsMasterId],[ReportName],[ReportServer],[ReportURL],[ReportsCategoryLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[ViewInUI])
--     VALUES (03,N'ERS Locked Records Report',N'dbset1611',N'https://rrtreportstest.uhc.com/ReportServer/Pages/ReportViewer.aspx?%2fERS_Everyone%2frpt_ERS_03_LockedRecords&rs:Command=Render',42002,1,getutcdate(),1,1)

--END
--GO

--IF NOT EXISTS (SELECT * FROM [dbo].[RPT_ReportsMaster] WHERE RPT_ReportsMasterId=04 )
--BEGIN
--     INSERT INTO [dbo].[RPT_ReportsMaster]([RPT_ReportsMasterId],[ReportName],[ReportServer],[ReportURL],[ReportsCategoryLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[ViewInUI])
--     VALUES (04,N'ERS Alerts Field Change Logging Report',N'dbset1611',N'https://rrtreportstest.uhc.com/ReportServer/Pages/ReportViewer.aspx?%2fERS_Everyone%2frpt_ERS_04_Alerts_Field_Change_Logging_Report&rs:Command=Render',42002,1,getutcdate(),1,0)

--END
--GO

--IF NOT EXISTS (SELECT * FROM [dbo].[RPT_ReportsMaster] WHERE RPT_ReportsMasterId=05 )
--BEGIN
--     INSERT INTO [dbo].[RPT_ReportsMaster]([RPT_ReportsMasterId],[ReportName],[ReportServer],[ReportURL],[ReportsCategoryLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[ViewInUI])
--     VALUES (05,N'ERS Skills Field Change Logging Report',N'dbset1611',N'https://rrtreportstest.uhc.com/ReportServer/Pages/ReportViewer.aspx?%2fERS_Everyone%2frpt_ERS_05_Skills_Field_Change_Logging_Report&rs:Command=Render',42002,1,getutcdate(),1,0)

--END
--GO

--IF NOT EXISTS (SELECT * FROM [dbo].[RPT_ReportsMaster] WHERE RPT_ReportsMasterId=06 )
--BEGIN
--     INSERT INTO [dbo].[RPT_ReportsMaster]([RPT_ReportsMasterId],[ReportName],[ReportServer],[ReportURL],[ReportsCategoryLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[ViewInUI])
--     VALUES (06,N'ERS User Admin Field Change Logging Report',N'dbset1611',N'https://rrtreportstest.uhc.com/ReportServer/Pages/ReportViewer.aspx?%2fERS_Everyone%2frpt_ERS_06_UserAdmin_Field_Change_Logging_Report&rs:Command=Render',42001,1,getutcdate(),1,0)

--END
--GO

--IF NOT EXISTS (SELECT * FROM [dbo].[RPT_ReportsMaster] WHERE RPT_ReportsMasterId=07 )
--BEGIN
--     INSERT INTO [dbo].[RPT_ReportsMaster]([RPT_ReportsMasterId],[ReportName],[ReportServer],[ReportURL],[ReportsCategoryLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[ViewInUI])
--     VALUES (07,N'ERS Department Field Change Logging Report',N'dbset1611',N'https://rrtreportstest.uhc.com/ReportServer/Pages/ReportViewer.aspx?%2fERS_Everyone%2frpt_ERS_07_Department_Field_Change_Logging_Report&rs:Command=Render',42001,1,getutcdate(),1,0)

--END
--GO

--IF NOT EXISTS (SELECT * FROM [dbo].[RPT_ReportsMaster] WHERE RPT_ReportsMasterId=08 )
--BEGIN
--     INSERT INTO [dbo].[RPT_ReportsMaster]([RPT_ReportsMasterId],[ReportName],[ReportServer],[ReportURL],[ReportsCategoryLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[ViewInUI])
--     VALUES (08,N'ERS Lookup Field Change Logging Report',N'dbset1611',N'https://rrtreportstest.uhc.com/ReportServer/Pages/ReportViewer.aspx?%2fERS_Everyone%2frpt_ERS_08_Lookup_Field_Change_Logging_Report&rs:Command=Render',42001,1,getutcdate(),1,0)

--END
--GO

--IF NOT EXISTS (SELECT * FROM [dbo].[RPT_ReportsMaster] WHERE RPT_ReportsMasterId=09 )
--BEGIN
--     INSERT INTO [dbo].[RPT_ReportsMaster]([RPT_ReportsMasterId],[ReportName],[ReportServer],[ReportURL],[ReportsCategoryLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[ViewInUI])
--     VALUES (09,N'ERS Lookup Correlation Field Change Logging Report',N'dbset1611',N'https://rrtreportstest.uhc.com/ReportServer/Pages/ReportViewer.aspx?%2fERS_Everyone%2frpt_ERS_09_LookupCorrelation_Field_Change_Logging_Report&rs:Command=Render',42001,1,getutcdate(),1,0)

--END
--GO

--IF NOT EXISTS (SELECT * FROM [dbo].[RPT_ReportsMaster] WHERE RPT_ReportsMasterId=10 )
--BEGIN
--     INSERT INTO [dbo].[RPT_ReportsMaster]([RPT_ReportsMasterId],[ReportName],[ReportServer],[ReportURL],[ReportsCategoryLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[ViewInUI])
--     VALUES (10,N'ERS Resource Field Change Logging Report',N'dbset1611',N'https://rrtreportstest.uhc.com/ReportServer/Pages/ReportViewer.aspx?%2fERS_Everyone%2frpt_ERS_10_Resource_Field_Change_Logging_Report&rs:Command=Render',42001,1,getutcdate(),1,0)

--END
--GO

--IF NOT EXISTS (SELECT * FROM [dbo].[RPT_ReportsMaster] WHERE RPT_ReportsMasterId=11 )
--BEGIN
--     INSERT INTO [dbo].[RPT_ReportsMaster]([RPT_ReportsMasterId],[ReportName],[ReportServer],[ReportURL],[ReportsCategoryLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[ViewInUI])
--     VALUES (11,N'ERS Config Field Change Logging Report',N'dbset1611',N'https://rrtreportstest.uhc.com/ReportServer/Pages/ReportViewer.aspx?%2fERS_Everyone%2frpt_ERS_11_Config_Field_Change_Logging_Report&rs:Command=Render',42001,1,getutcdate(),1,0)

--END
--GO


--IF NOT EXISTS (SELECT * FROM [dbo].[RPT_ReportsMaster] WHERE RPT_ReportsMasterId=12 )
--BEGIN
--     INSERT INTO [dbo].[RPT_ReportsMaster]([RPT_ReportsMasterId],[ReportName],[ReportServer],[ReportURL],[ReportsCategoryLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[ViewInUI])
--     VALUES (12,N'ERS Access Group Field Change Logging Report',N'dbset1611',N'https://rrtreportstest.uhc.com/ReportServer/Pages/ReportViewer.aspx?%2fERS_Everyone%2frpt_ERS_12_AccessGroup_Field_Change_Logging_Report&rs:Command=Render',42001,1,getutcdate(),1,0)

--END
--GO

--IF NOT EXISTS (SELECT * FROM [dbo].[RPT_ReportsMaster] WHERE RPT_ReportsMasterId=13 )
--BEGIN
--     INSERT INTO [dbo].[RPT_ReportsMaster]([RPT_ReportsMasterId],[ReportName],[ReportServer],[ReportURL],[ReportsCategoryLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[ViewInUI])
--     VALUES (13,N'ERS Common Field Change Logging Report',N'dbset1611',N'https://rrtreportstest.uhc.com/ReportServer/Pages/ReportViewer.aspx?%2fERS_Everyone%2frpt_ERS_13_Queue_Field_Change_Logging_Report&rs:Command=Render',42001,1,getutcdate(),1,0)

--END
--GO

--IF NOT EXISTS (SELECT * FROM [dbo].[RPT_ReportsMaster] WHERE RPT_ReportsMasterId=14 )
--BEGIN
--     INSERT INTO [dbo].[RPT_ReportsMaster]([RPT_ReportsMasterId],[ReportName],[ReportServer],[ReportURL],[ReportsCategoryLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[ViewInUI])
--     VALUES (14,N'MTD Peer Audit Quality Report',N'dbset1611',N'https://rrtreportstest.uhc.com/ReportServer/Pages/ReportViewer.aspx?%2fERS_Everyone%2frpt_ERS_14_MTD_Peer_Audit_Quality_Summary_Report&rs:Command=Render',42001,1,getutcdate(),1,1)
--END
--GO

--IF NOT EXISTS (SELECT * FROM [dbo].[RPT_ReportsMaster] WHERE RPT_ReportsMasterId=15 )
--BEGIN
--     INSERT INTO [dbo].[RPT_ReportsMaster]([RPT_ReportsMasterId],[ReportName],[ReportServer],[ReportURL],[ReportsCategoryLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[ViewInUI])
--     VALUES (15,N'Background Process Monitor Report',N'dbset1611',N'https://rrtreportstest.uhc.com/ReportServer/Pages/ReportViewer.aspx?%2fERS_Everyone%2frpt_ERS_15_BGProcessMonitorSummary_Report&rs:Command=Render',42001,1,getutcdate(),1,1)
--END
--GO


--IF NOT EXISTS (SELECT * FROM [dbo].[RPT_ReportsMaster] WHERE RPT_ReportsMasterId=16 )
--BEGIN
--     INSERT INTO [dbo].[RPT_ReportsMaster]([RPT_ReportsMasterId],[ReportName],[ReportServer],[ReportURL],[ReportsCategoryLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[ViewInUI])
--     VALUES (16,N'Daily Dashboard Report',N'dbset1611',N'https://rrtreportstest.uhc.com/ReportServer/Pages/ReportViewer.aspx?%2fERS_Everyone%2frpt_ERS_16_Daily_Dashboard_Summary_Report&rs:Command=Render',42001,1,getutcdate(),1,1)
--END
--GO

--IF NOT EXISTS (SELECT * FROM [dbo].[RPT_ReportsMaster] WHERE RPT_ReportsMasterId=17 )
--BEGIN
--     INSERT INTO [dbo].[RPT_ReportsMaster]([RPT_ReportsMasterId],[ReportName],[ReportServer],[ReportURL],[ReportsCategoryLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[ViewInUI])
--     VALUES (17,N'Pending Report',N'dbset1611',N'https://rrtreportstest.uhc.com/ReportServer/Pages/ReportViewer.aspx?%2fERS_Everyone%2frpt_ERS_17_Pended_Report_Summary&rs:Command=Render',42001,1,getutcdate(),1,1)
--END
--GO


--IF NOT EXISTS (SELECT * FROM [dbo].[RPT_ReportsMaster] WHERE RPT_ReportsMasterId=18 )
--BEGIN
--     INSERT INTO [dbo].[RPT_ReportsMaster]([RPT_ReportsMasterId],[ReportName],[ReportServer],[ReportURL],[ReportsCategoryLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[ViewInUI])
--     VALUES (18,N'Monthly Metrics Report',N'dbset1611',N'https://rrtreportstest.uhc.com/ReportServer/Pages/ReportViewer.aspx?%2fERS_Everyone%2frpt_ERS_18_Monthly_Metrics_Summary_Report&rs:Command=Render',42001,1,getutcdate(),1,1)
--END
--GO

--IF NOT EXISTS (SELECT * FROM [dbo].[RPT_ReportsMaster] WHERE RPT_ReportsMasterId=19 )
--BEGIN
--     INSERT INTO [dbo].[RPT_ReportsMaster]([RPT_ReportsMasterId],[ReportName],[ReportServer],[ReportURL],[ReportsCategoryLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[ViewInUI])
--     VALUES (19,N'OOA Tracking Report',N'dbset1611',N'https://rrtreportstest.uhc.com/ReportServer/Pages/ReportViewer.aspx?%2fERS_Everyone%2frpt_ERS_19_OOA_Tracking_Report_Summary&rs:Command=Render',42001,1,getutcdate(),1,1)
--END
--GO

--IF NOT EXISTS (SELECT * FROM [dbo].[RPT_ReportsMaster] WHERE RPT_ReportsMasterId=20 )
--BEGIN
--     INSERT INTO [dbo].[RPT_ReportsMaster]([RPT_ReportsMasterId],[ReportName],[ReportServer],[ReportURL],[ReportsCategoryLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[ViewInUI])
--     VALUES (20,N'RPR Submission Report',N'dbset1611',N'https://rrtreportstest.uhc.com/ReportServer/Pages/ReportViewer.aspx?%2fERS_Everyone%2frpt_ERS_20_RPR_Submission_Report_Summary&rs:Command=Render',42001,1,getutcdate(),1,1)
--END
--GO


--IF NOT EXISTS (SELECT * FROM [dbo].[RPT_ReportsMaster] WHERE RPT_ReportsMasterId=21 )
--BEGIN
--       INSERT INTO [dbo].[RPT_ReportsMaster]([RPT_ReportsMasterId],[ReportName],[ReportServer],[ReportURL],[ReportsCategoryLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[ViewInUI])
--       VALUES (21,N'Web Service Monitoring Report',N'dbset1611',N'https://rrtreportstest.uhc.com/ReportServer/Pages/ReportViewer.aspx?%2fERS_Everyone%2frpt_ERS_21_WebService_Monitoring_Summary_Report&rs:Command=Render',42001,1,getutcdate(),1,1)
--END
--GO


--IF NOT EXISTS (SELECT * FROM [dbo].[RPT_ReportsMaster] WHERE RPT_ReportsMasterId=22 )
--BEGIN
--     INSERT INTO [dbo].[RPT_ReportsMaster]([RPT_ReportsMasterId],[ReportName],[ReportServer],[ReportURL],[ReportsCategoryLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[ViewInUI])
--     VALUES (22,N'Queue Detail Report',N'dbset1611',N'https://rrtreportstest.uhc.com/ReportServer/Pages/ReportViewer.aspx?%2fERS_Everyone%2frpt_ERS_22_Queue_Details_Report&rs:Command=Render',42001,1,getutcdate(),1,0)
--END
--GO

--IF NOT EXISTS (SELECT * FROM [dbo].[RPT_ReportsMaster] WHERE RPT_ReportsMasterId=23 )
--BEGIN
--	INSERT INTO [dbo].[RPT_ReportsMaster]([RPT_ReportsMasterId],[ReportName],[ReportServer],[ReportURL],[ReportsCategoryLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[ViewInUI])
--	VALUES (23,N'MQ Processing Report',N'dbset1611',N'https://rrtreportstest.uhc.com/ReportServer/Pages/ReportViewer.aspx?%2fERS_Everyone%2frpt_ERS_23_MQ_Records_Processing_Summary_Report&rs:Command=Render',42001,1,getutcdate(),1,1)
--END
--GO

--IF NOT EXISTS (SELECT * FROM [dbo].[RPT_ReportsMaster] WHERE RPT_ReportsMasterId=24 )
--BEGIN
--	INSERT INTO [dbo].[RPT_ReportsMaster]([RPT_ReportsMasterId],[ReportName],[ReportServer],[ReportURL],[ReportsCategoryLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[ViewInUI])
--	VALUES (24,N'OOA Reports',N'dbset1611',N'https://rrtssrs2014prod.uhc.com/Reports/Pages/Report.aspx?ItemPath=%2fOOA%2fRPT_UHC_OOA_SAS_Auto_Process',42001,1,getutcdate(),1,1)
--END
--GO
--IF NOT EXISTS (SELECT * FROM [dbo].[RPT_ReportsMaster] WHERE RPT_ReportsMasterId=25 )
--BEGIN
--	INSERT INTO [dbo].[RPT_ReportsMaster]([RPT_ReportsMasterId],[ReportName],[ReportServer],[ReportURL],[ReportsCategoryLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[ViewInUI])
--	VALUES (25,N'Mass Update Report',N'dbset1611',N'https://rrtreportstest.uhc.com/ReportServer/Pages/ReportViewer.aspx?%2fERS_Everyone%2fERS_Everyone%2frpt_ERS_24_MassUpdate_Summary_Report&rs:Command=Render',42001,1,getutcdate(),1,1)
--END
--GO


--IF NOT EXISTS (SELECT * FROM [dbo].[RPT_ReportsMaster] WHERE RPT_ReportsMasterId=26 )
--BEGIN
--	INSERT INTO [dbo].[RPT_ReportsMaster]([RPT_ReportsMasterId],[ReportName],[ReportServer],[ReportURL],[ReportsCategoryLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[ViewInUI])
--	VALUES (26,N'ERS Queue Search Report',N'dbset1611',N'https://rrtreportstest.uhc.com/ReportServer/Pages/ReportViewer.aspx?%2fERS_Everyone%2frpt_ERS_26_Queue_Searh_Detail_Report&rs:Command=Render',42001,1,getutcdate(),1,0)
--END
--GO
--IF NOT EXISTS (SELECT * FROM [dbo].[RPT_ReportsMaster] WHERE RPT_ReportsMasterId=27 )
--BEGIN
--	INSERT INTO [dbo].[RPT_ReportsMaster]([RPT_ReportsMasterId],[ReportName],[ReportServer],[ReportURL],[ReportsCategoryLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[ViewInUI])
--	VALUES (27,N'ERS Bulk Upload Report',N'dbset1611',N'https://rrtreportstest.uhc.com/ReportServer/Pages/ReportViewer.aspx?%2fERS_Everyone%2frpt_ERS_25_Bulk_Upload_Summary_Report&rs:Command=Render',42001,1,getutcdate(),1,0)
--END
--GO

--IF NOT EXISTS (SELECT * FROM [dbo].[RPT_ReportsMaster] WHERE RPT_ReportsMasterId=28 )
--BEGIN
--	INSERT INTO [dbo].[RPT_ReportsMaster]([RPT_ReportsMasterId],[ReportName],[ReportServer],[ReportURL],[ReportsCategoryLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[ViewInUI])
--	VALUES (28,N'RPR Plan Error Report',N'dbset1611',N'https://rrtreportstest.uhc.com/ReportServer/Pages/ReportViewer.aspx?%2fERS_Everyone%2frpt_ERS_27_ERS_RPRPlanError_Summary_Report&rs:Command=Render',42001,1,getutcdate(),1,1)
--END
--GO

--IF NOT EXISTS (SELECT * FROM [dbo].[RPT_ReportsMaster] WHERE RPT_ReportsMasterId=29 )
--BEGIN
--	INSERT INTO [dbo].[RPT_ReportsMaster]([RPT_ReportsMasterId],[ReportName],[ReportServer],[ReportURL],[ReportsCategoryLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[ViewInUI])
--	VALUES (29,N'OOA Control Report',N'dbset1611',N'https://rrtssrs2014prod.uhc.com/Reports/Pages/Report.aspx?ItemPath=%2fERS_BI_DATA%2fUHC_ERS_CONTROL_RPT',42001,1,getutcdate(),1,1)
--END
--GO

--IF NOT EXISTS (SELECT * FROM [dbo].[RPT_ReportsMaster] WHERE RPT_ReportsMasterId=30 )
--BEGIN
--	INSERT INTO [dbo].[RPT_ReportsMaster]([RPT_ReportsMasterId],[ReportName],[ReportServer],[ReportURL],[ReportsCategoryLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[ViewInUI])
--	VALUES (30,N'OOA Dashboard Report',N'dbset1611',N'https://rrtssrs2014prod.uhc.com/Reports/Pages/Report.aspx?ItemPath=%2fOOA%2fRPT_UHG_OOA_DashBoard',42001,1,getutcdate(),1,1)
--END
--GO

--SET IDENTITY_INSERT [dbo].[RPT_ReportsMaster] OFF


------------ Stage

--SET IDENTITY_INSERT [dbo].[RPT_ReportsMaster] ON

--IF NOT EXISTS (SELECT * FROM [dbo].[RPT_ReportsMaster] WHERE RPT_ReportsMasterId=01 )
--BEGIN
--     INSERT INTO [dbo].[RPT_ReportsMaster]([RPT_ReportsMasterId],[ReportName],[ReportServer],[ReportURL],[ReportsCategoryLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[ViewInUI])
--     VALUES (01,N'ERS Home Page Summary Report',N'DBSES2416',N'https://rrtreportsstage.uhc.com/ReportServer/Pages/ReportViewer.aspx?%2fERS_Everyone%2frpt_ERS_01_HomePage&rs:Command=Render',42002,1,getutcdate(),1,1)

--END
--GO

--IF NOT EXISTS (SELECT * FROM [dbo].[RPT_ReportsMaster] WHERE RPT_ReportsMasterId=02 )
--BEGIN
--     INSERT INTO [dbo].[RPT_ReportsMaster]([RPT_ReportsMasterId],[ReportName],[ReportServer],[ReportURL],[ReportsCategoryLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[ViewInUI])
--     VALUES (02,N'ERS Error Log Report',N'DBSES2416',N'https://rrtreportsstage.uhc.com/ReportServer/Pages/ReportViewer.aspx?%2fERS_Everyone%2frpt_ERS_02_ErrorLog&rs:Command=Render',42002,1,getutcdate(),1,1)

--END
--GO
--IF NOT EXISTS (SELECT * FROM [dbo].[RPT_ReportsMaster] WHERE RPT_ReportsMasterId=03 )
--BEGIN
--     INSERT INTO [dbo].[RPT_ReportsMaster]([RPT_ReportsMasterId],[ReportName],[ReportServer],[ReportURL],[ReportsCategoryLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[ViewInUI])
--     VALUES (03,N'ERS Locked Records Report',N'DBSES2416',N'https://rrtreportsstage.uhc.com/ReportServer/Pages/ReportViewer.aspx?%2fERS_Everyone%2frpt_ERS_03_LockedRecords&rs:Command=Render',42002,1,getutcdate(),1,1)

--END
--GO

--IF NOT EXISTS (SELECT * FROM [dbo].[RPT_ReportsMaster] WHERE RPT_ReportsMasterId=04 )
--BEGIN
--     INSERT INTO [dbo].[RPT_ReportsMaster]([RPT_ReportsMasterId],[ReportName],[ReportServer],[ReportURL],[ReportsCategoryLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[ViewInUI])
--     VALUES (04,N'ERS Alerts Field Change Logging Report',N'DBSES2416',N'https://rrtreportsstage.uhc.com/ReportServer/Pages/ReportViewer.aspx?%2fERS_Everyone%2frpt_ERS_04_Alerts_Field_Change_Logging_Report&rs:Command=Render',42002,1,getutcdate(),1,0)

--END
--GO

--IF NOT EXISTS (SELECT * FROM [dbo].[RPT_ReportsMaster] WHERE RPT_ReportsMasterId=05 )
--BEGIN
--     INSERT INTO [dbo].[RPT_ReportsMaster]([RPT_ReportsMasterId],[ReportName],[ReportServer],[ReportURL],[ReportsCategoryLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[ViewInUI])
--     VALUES (05,N'ERS Skills Field Change Logging Report',N'DBSES2416',N'https://rrtreportsstage.uhc.com/ReportServer/Pages/ReportViewer.aspx?%2fERS_Everyone%2frpt_ERS_05_Skills_Field_Change_Logging_Report&rs:Command=Render',42002,1,getutcdate(),1,0)

--END
--GO


--IF NOT EXISTS (SELECT * FROM [dbo].[RPT_ReportsMaster] WHERE RPT_ReportsMasterId=06 )
--BEGIN
--     INSERT INTO [dbo].[RPT_ReportsMaster]([RPT_ReportsMasterId],[ReportName],[ReportServer],[ReportURL],[ReportsCategoryLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[ViewInUI])
--     VALUES (06,N'ERS User Admin Field Change Logging Report',N'DBSES2416',N'https://rrtreportsstage.uhc.com/ReportServer/Pages/ReportViewer.aspx?%2fERS_Everyone%2frpt_ERS_06_UserAdmin_Field_Change_Logging_Report&rs:Command=Render',42001,1,getutcdate(),1,0)

--END
--GO

--IF NOT EXISTS (SELECT * FROM [dbo].[RPT_ReportsMaster] WHERE RPT_ReportsMasterId=07 )
--BEGIN
--     INSERT INTO [dbo].[RPT_ReportsMaster]([RPT_ReportsMasterId],[ReportName],[ReportServer],[ReportURL],[ReportsCategoryLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[ViewInUI])
--     VALUES (07,N'ERS Department Field Change Logging Report',N'DBSES2416',N'https://rrtreportsstage.uhc.com/ReportServer/Pages/ReportViewer.aspx?%2fERS_Everyone%2frpt_ERS_07_Department_Field_Change_Logging_Report&rs:Command=Render',42001,1,getutcdate(),1,0)

--END
--GO

--IF NOT EXISTS (SELECT * FROM [dbo].[RPT_ReportsMaster] WHERE RPT_ReportsMasterId=08 )
--BEGIN
--     INSERT INTO [dbo].[RPT_ReportsMaster]([RPT_ReportsMasterId],[ReportName],[ReportServer],[ReportURL],[ReportsCategoryLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[ViewInUI])
--     VALUES (08,N'ERS Lookup Field Change Logging Report',N'DBSES2416',N'https://rrtreportsstage.uhc.com/ReportServer/Pages/ReportViewer.aspx?%2fERS_Everyone%2frpt_ERS_08_Lookup_Field_Change_Logging_Report&rs:Command=Render',42001,1,getutcdate(),1,0)

--END
--GO

--IF NOT EXISTS (SELECT * FROM [dbo].[RPT_ReportsMaster] WHERE RPT_ReportsMasterId=09 )
--BEGIN
--     INSERT INTO [dbo].[RPT_ReportsMaster]([RPT_ReportsMasterId],[ReportName],[ReportServer],[ReportURL],[ReportsCategoryLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[ViewInUI])
--     VALUES (09,N'ERS Lookup Correlation Field Change Logging Report',N'DBSES2416',N'https://rrtreportsstage.uhc.com/ReportServer/Pages/ReportViewer.aspx?%2fERS_Everyone%2frpt_ERS_09_LookupCorrelation_Field_Change_Logging_Report&rs:Command=Render',42001,1,getutcdate(),1,0)

--END
--GO

--IF NOT EXISTS (SELECT * FROM [dbo].[RPT_ReportsMaster] WHERE RPT_ReportsMasterId=10 )
--BEGIN
--     INSERT INTO [dbo].[RPT_ReportsMaster]([RPT_ReportsMasterId],[ReportName],[ReportServer],[ReportURL],[ReportsCategoryLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[ViewInUI])
--     VALUES (10,N'ERS Resource Field Change Logging Report',N'DBSES2416',N'https://rrtreportsstage.uhc.com/ReportServer/Pages/ReportViewer.aspx?%2fERS_Everyone%2frpt_ERS_10_Resource_Field_Change_Logging_Report&rs:Command=Render',42001,1,getutcdate(),1,0)

--END
--GO

--IF NOT EXISTS (SELECT * FROM [dbo].[RPT_ReportsMaster] WHERE RPT_ReportsMasterId=11 )
--BEGIN
--     INSERT INTO [dbo].[RPT_ReportsMaster]([RPT_ReportsMasterId],[ReportName],[ReportServer],[ReportURL],[ReportsCategoryLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[ViewInUI])
--     VALUES (11,N'ERS Config Field Change Logging Report',N'DBSES2416',N'https://rrtreportsstage.uhc.com/ReportServer/Pages/ReportViewer.aspx?%2fERS_Everyone%2frpt_ERS_11_Config_Field_Change_Logging_Report&rs:Command=Render',42001,1,getutcdate(),1,0)

--END
--GO

--IF NOT EXISTS (SELECT * FROM [dbo].[RPT_ReportsMaster] WHERE RPT_ReportsMasterId=12 )
--BEGIN
--     INSERT INTO [dbo].[RPT_ReportsMaster]([RPT_ReportsMasterId],[ReportName],[ReportServer],[ReportURL],[ReportsCategoryLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[ViewInUI])
--     VALUES (12,N'ERS Access Group Field Change Logging Report',N'DBSES2416',N'https://rrtreportsstage.uhc.com/ReportServer/Pages/ReportViewer.aspx?%2fERS_Everyone%2frpt_ERS_12_AccessGroup_Field_Change_Logging_Report&rs:Command=Render',42001,1,getutcdate(),1,0)

--END
--GO

--IF NOT EXISTS (SELECT * FROM [dbo].[RPT_ReportsMaster] WHERE RPT_ReportsMasterId=13 )
--BEGIN
--     INSERT INTO [dbo].[RPT_ReportsMaster]([RPT_ReportsMasterId],[ReportName],[ReportServer],[ReportURL],[ReportsCategoryLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[ViewInUI])
--     VALUES (13,N'ERS Common Field Change Logging Report',N'DBSES2416',N'https://rrtreportsstage.uhc.com/ReportServer/Pages/ReportViewer.aspx?%2fERS_Everyone%2frpt_ERS_13_Queue_Field_Change_Logging_Report&rs:Command=Render',42001,1,getutcdate(),1,0)

--END
--GO

--IF NOT EXISTS (SELECT * FROM [dbo].[RPT_ReportsMaster] WHERE RPT_ReportsMasterId=14 )
--BEGIN
--     INSERT INTO [dbo].[RPT_ReportsMaster]([RPT_ReportsMasterId],[ReportName],[ReportServer],[ReportURL],[ReportsCategoryLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[ViewInUI])
--     VALUES (14,N'MTD Peer Audit Quality Report',N'DBSES2416',N'https://rrtreportsstage.uhc.com/ReportServer/Pages/ReportViewer.aspx?%2fERS_Everyone%2frpt_ERS_14_MTD_Peer_Audit_Quality_Summary_Report&rs:Command=Render',42001,1,getutcdate(),1,1)
--END
--GO

--IF NOT EXISTS (SELECT * FROM [dbo].[RPT_ReportsMaster] WHERE RPT_ReportsMasterId=15 )
--BEGIN
--     INSERT INTO [dbo].[RPT_ReportsMaster]([RPT_ReportsMasterId],[ReportName],[ReportServer],[ReportURL],[ReportsCategoryLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[ViewInUI])
--     VALUES (15,N'Background Process Monitor Report',N'DBSES2416',N'https://rrtreportsstage.uhc.com/ReportServer/Pages/ReportViewer.aspx?%2fERS_Everyone%2frpt_ERS_15_BGProcessMonitorSummary_Report&rs:Command=Render',42001,1,getutcdate(),1,1)
--END
--GO

--IF NOT EXISTS (SELECT * FROM [dbo].[RPT_ReportsMaster] WHERE RPT_ReportsMasterId=16 )
--BEGIN
--     INSERT INTO [dbo].[RPT_ReportsMaster]([RPT_ReportsMasterId],[ReportName],[ReportServer],[ReportURL],[ReportsCategoryLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[ViewInUI])
--     VALUES (16,N'Daily Dashboard Report',N'DBSES2416',N'https://rrtreportsstage.uhc.com/ReportServer/Pages/ReportViewer.aspx?%2fERS_Everyone%2frpt_ERS_16_Daily_Dashboard_Summary_Report&rs:Command=Render',42001,1,getutcdate(),1,1)
--END
--GO

--IF NOT EXISTS (SELECT * FROM [dbo].[RPT_ReportsMaster] WHERE RPT_ReportsMasterId=17 )
--BEGIN
--     INSERT INTO [dbo].[RPT_ReportsMaster]([RPT_ReportsMasterId],[ReportName],[ReportServer],[ReportURL],[ReportsCategoryLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[ViewInUI])
--     VALUES (17,N'Pended Report',N'DBSES2416',N'https://rrtreportsstage.uhc.com/ReportServer/Pages/ReportViewer.aspx?%2fERS_Everyone%2frpt_ERS_17_Pended_Report_Summary&rs:Command=Render',42001,1,getutcdate(),1,1)
--END
--GO

--IF NOT EXISTS (SELECT * FROM [dbo].[RPT_ReportsMaster] WHERE RPT_ReportsMasterId=18 )
--BEGIN
--     INSERT INTO [dbo].[RPT_ReportsMaster]([RPT_ReportsMasterId],[ReportName],[ReportServer],[ReportURL],[ReportsCategoryLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[ViewInUI])
--     VALUES (18,N'Monthly Metrics Report',N'DBSES2416',N'https://rrtreportsstage.uhc.com/ReportServer/Pages/ReportViewer.aspx?%2fERS_Everyone%2frpt_ERS_18_Monthly_Metrics_Summary_Report&rs:Command=Render',42001,1,getutcdate(),1,1)
--END
--GO
--IF NOT EXISTS (SELECT * FROM [dbo].[RPT_ReportsMaster] WHERE RPT_ReportsMasterId=19 )
--BEGIN
--     INSERT INTO [dbo].[RPT_ReportsMaster]([RPT_ReportsMasterId],[ReportName],[ReportServer],[ReportURL],[ReportsCategoryLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[ViewInUI])
--     VALUES (19,N'OOA Tracking Report',N'DBSES2416',N'https://rrtreportsstage.uhc.com/ReportServer/Pages/ReportViewer.aspx?%2fERS_Everyone%2frpt_ERS_19_OOA_Tracking_Report_Summary&rs:Command=Render',42001,1,getutcdate(),1,1)
--END
--GO

--IF NOT EXISTS (SELECT * FROM [dbo].[RPT_ReportsMaster] WHERE RPT_ReportsMasterId=20 )
--BEGIN
--     INSERT INTO [dbo].[RPT_ReportsMaster]([RPT_ReportsMasterId],[ReportName],[ReportServer],[ReportURL],[ReportsCategoryLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[ViewInUI])
--     VALUES (20,N'RPR Submission Report',N'DBSES2416',N'https://rrtreportsstage.uhc.com/ReportServer/Pages/ReportViewer.aspx?%2fERS_Everyone%2frpt_ERS_20_RPR_Submission_Report_Summary&rs:Command=Render',42001,1,getutcdate(),1,1)
--END
--GO

--IF NOT EXISTS (SELECT * FROM [dbo].[RPT_ReportsMaster] WHERE RPT_ReportsMasterId=21 )
--BEGIN
--       INSERT INTO [dbo].[RPT_ReportsMaster]([RPT_ReportsMasterId],[ReportName],[ReportServer],[ReportURL],[ReportsCategoryLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[ViewInUI])
--       VALUES (21,N'Web Service Monitoring Report',N'DBSES2416',N'https://rrtreportsstage.uhc.com/ReportServer/Pages/ReportViewer.aspx?%2fERS_Everyone%2frpt_ERS_21_WebService_Monitoring_Summary_Report&rs:Command=Render',42001,1,getutcdate(),1,1)
--END
--GO

--IF NOT EXISTS (SELECT * FROM [dbo].[RPT_ReportsMaster] WHERE RPT_ReportsMasterId=22 )
--BEGIN
--     INSERT INTO [dbo].[RPT_ReportsMaster]([RPT_ReportsMasterId],[ReportName],[ReportServer],[ReportURL],[ReportsCategoryLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[ViewInUI])
--     VALUES (22,N'Queue Detail Report',N'DBSES2416',N'https://rrtreportsstage.uhc.com/ReportServer/Pages/ReportViewer.aspx?%2fERS_Everyone%2frpt_ERS_22_Queue_Details_Report&rs:Command=Render',42001,1,getutcdate(),1,0)
--END
--GO

--IF NOT EXISTS (SELECT * FROM [dbo].[RPT_ReportsMaster] WHERE RPT_ReportsMasterId=23 )
--BEGIN
--	INSERT INTO [dbo].[RPT_ReportsMaster]([RPT_ReportsMasterId],[ReportName],[ReportServer],[ReportURL],[ReportsCategoryLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[ViewInUI])
--	VALUES (23,N'MQ Processing Report',N'DBSES2416',N'https://rrtreportsstage.uhc.com/ReportServer/Pages/ReportViewer.aspx?%2fERS_Everyone%2frpt_ERS_23_MQ_Records_Processing_Summary_Report&rs:Command=Render',42001,1,getutcdate(),1,1)
--END
--GO

--IF NOT EXISTS (SELECT * FROM [dbo].[RPT_ReportsMaster] WHERE RPT_ReportsMasterId=24 )
--BEGIN
--	INSERT INTO [dbo].[RPT_ReportsMaster]([RPT_ReportsMasterId],[ReportName],[ReportServer],[ReportURL],[ReportsCategoryLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[ViewInUI])
--	VALUES (24,N'OOA Reports',N'DBSES2416',N'https://rrtssrs2014prod.uhc.com/Reports/Pages/Report.aspx?ItemPath=%2fOOA%2fRPT_UHC_OOA_SAS_Auto_Process',42001,1,getutcdate(),1,1)
--END
--GO
--IF NOT EXISTS (SELECT * FROM [dbo].[RPT_ReportsMaster] WHERE RPT_ReportsMasterId=25 )
--BEGIN
--	INSERT INTO [dbo].[RPT_ReportsMaster]([RPT_ReportsMasterId],[ReportName],[ReportServer],[ReportURL],[ReportsCategoryLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[ViewInUI])
--	VALUES (25,N'Mass Update Report',N'DBSES2416',N'https://rrtreportsstage.uhc.com/ReportServer/Pages/ReportViewer.aspx?%2fERS_Everyone%2fERS_Everyone%2frpt_ERS_24_MassUpdate_Summary_Report&rs:Command=Render',42001,1,getutcdate(),1,1)
--END
--GO

--IF NOT EXISTS (SELECT * FROM [dbo].[RPT_ReportsMaster] WHERE RPT_ReportsMasterId=26 )
--BEGIN
--	INSERT INTO [dbo].[RPT_ReportsMaster]([RPT_ReportsMasterId],[ReportName],[ReportServer],[ReportURL],[ReportsCategoryLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[ViewInUI])
--	VALUES (26,N'ERS Queue Search Report',N'DBSES2416',N'https://rrtreportsstage.uhc.com/ReportServer/Pages/ReportViewer.aspx?%2fERS_Everyone%2frpt_ERS_26_Queue_Searh_Detail_Report&rs:Command=Render',42001,1,getutcdate(),1,0)
--END
--GO

--IF NOT EXISTS (SELECT * FROM [dbo].[RPT_ReportsMaster] WHERE RPT_ReportsMasterId=27 )
--BEGIN
--	INSERT INTO [dbo].[RPT_ReportsMaster]([RPT_ReportsMasterId],[ReportName],[ReportServer],[ReportURL],[ReportsCategoryLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[ViewInUI])
--	VALUES (27,N'ERS Bulk Upload Report',N'DBSES2416',N'https://rrtreportsstage.uhc.com/ReportServer/Pages/ReportViewer.aspx?%2fERS_Everyone%2frpt_ERS_25_Bulk_Upload_Summary_Report&rs:Command=Render',42001,1,getutcdate(),1,1)
--END
--GO

--IF NOT EXISTS (SELECT * FROM [dbo].[RPT_ReportsMaster] WHERE RPT_ReportsMasterId=28 )
--BEGIN
--	INSERT INTO [dbo].[RPT_ReportsMaster]([RPT_ReportsMasterId],[ReportName],[ReportServer],[ReportURL],[ReportsCategoryLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[ViewInUI])
--	VALUES (28,N'RPR Plan Error Report',N'DBSES2416',N'https://rrtreportsstage.uhc.com/ReportServer/Pages/ReportViewer.aspx?%2fERS_Everyone%2frpt_ERS_27_ERS_RPRPlanError_Summary_Report&rs:Command=Render',42001,1,getutcdate(),1,1)
--END
--GO

--IF NOT EXISTS (SELECT * FROM [dbo].[RPT_ReportsMaster] WHERE RPT_ReportsMasterId=29 )
--BEGIN
--	INSERT INTO [dbo].[RPT_ReportsMaster]([RPT_ReportsMasterId],[ReportName],[ReportServer],[ReportURL],[ReportsCategoryLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[ViewInUI])
--	VALUES (29,N'OOA Control Report',N'DBSES2416',N'https://rrtssrs2014prod.uhc.com/Reports/Pages/Report.aspx?ItemPath=%2fERS_BI_DATA%2fUHC_ERS_CONTROL_RPT',42001,1,getutcdate(),1,1)
--END
--GO

--IF NOT EXISTS (SELECT * FROM [dbo].[RPT_ReportsMaster] WHERE RPT_ReportsMasterId=30 )
--BEGIN
--	INSERT INTO [dbo].[RPT_ReportsMaster]([RPT_ReportsMasterId],[ReportName],[ReportServer],[ReportURL],[ReportsCategoryLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[ViewInUI])
--	VALUES (30,N'OOA Dashboard Report',N'DBSES2416',N'https://rrtssrs2014prod.uhc.com/Reports/Pages/Report.aspx?ItemPath=%2fOOA%2fRPT_UHG_OOA_DashBoard',42001,1,getutcdate(),1,1)
--END
--GO

--SET IDENTITY_INSERT [dbo].[RPT_ReportsMaster] OFF

------------ Prod

--SET IDENTITY_INSERT [dbo].[RPT_ReportsMaster] ON

--IF NOT EXISTS (SELECT * FROM [dbo].[RPT_ReportsMaster] WHERE RPT_ReportsMasterId=01 )
--BEGIN
--     INSERT INTO [dbo].[RPT_ReportsMaster]([RPT_ReportsMasterId],[ReportName],[ReportServer],[ReportURL],[ReportsCategoryLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[ViewInUI])
--     VALUES (01,N'ERS Home Page Summary Report',N'dbsep4085cls',N'https://rrtreportsprod.uhc.com/ReportServer/Pages/ReportViewer.aspx?%2fERS_Everyone%2frpt_ERS_01_HomePage&rs:Command=Render',42002,1,getutcdate(),1,1)

--END
--GO

--IF NOT EXISTS (SELECT * FROM [dbo].[RPT_ReportsMaster] WHERE RPT_ReportsMasterId=02 )
--BEGIN
--     INSERT INTO [dbo].[RPT_ReportsMaster]([RPT_ReportsMasterId],[ReportName],[ReportServer],[ReportURL],[ReportsCategoryLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[ViewInUI])
--     VALUES (02,N'ERS Error Log Report',N'dbsep4085cls',N'https://rrtreportsprod.uhc.com/ReportServer/Pages/ReportViewer.aspx?%2fERS_Everyone%2frpt_ERS_02_ErrorLog&rs:Command=Render',42002,1,getutcdate(),1,1)

--END
--GO
--IF NOT EXISTS (SELECT * FROM [dbo].[RPT_ReportsMaster] WHERE RPT_ReportsMasterId=03 )
--BEGIN
--     INSERT INTO [dbo].[RPT_ReportsMaster]([RPT_ReportsMasterId],[ReportName],[ReportServer],[ReportURL],[ReportsCategoryLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[ViewInUI])
--     VALUES (03,N'ERS Locked Records Report',N'dbsep4085cls',N'https://rrtreportsprod.uhc.com/ReportServer/Pages/ReportViewer.aspx?%2fERS_Everyone%2frpt_ERS_03_LockedRecords&rs:Command=Render',42002,1,getutcdate(),1,1)

--END
--GO

--IF NOT EXISTS (SELECT * FROM [dbo].[RPT_ReportsMaster] WHERE RPT_ReportsMasterId=04 )
--BEGIN
--     INSERT INTO [dbo].[RPT_ReportsMaster]([RPT_ReportsMasterId],[ReportName],[ReportServer],[ReportURL],[ReportsCategoryLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[ViewInUI])
--     VALUES (04,N'ERS Alerts Field Change Logging Report',N'dbsep4085cls',N'https://rrtreportsprod.uhc.com/ReportServer/Pages/ReportViewer.aspx?%2fERS_Everyone%2frpt_ERS_04_Alerts_Field_Change_Logging_Report&rs:Command=Render',42002,1,getutcdate(),1,0)

--END
--GO

--IF NOT EXISTS (SELECT * FROM [dbo].[RPT_ReportsMaster] WHERE RPT_ReportsMasterId=05 )
--BEGIN
--     INSERT INTO [dbo].[RPT_ReportsMaster]([RPT_ReportsMasterId],[ReportName],[ReportServer],[ReportURL],[ReportsCategoryLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[ViewInUI])
--     VALUES (05,N'ERS Skills Field Change Logging Report',N'dbsep4085cls',N'https://rrtreportsprod.uhc.com/ReportServer/Pages/ReportViewer.aspx?%2fERS_Everyone%2frpt_ERS_05_Skills_Field_Change_Logging_Report&rs:Command=Render',42002,1,getutcdate(),1,0)

--END
--GO


--IF NOT EXISTS (SELECT * FROM [dbo].[RPT_ReportsMaster] WHERE RPT_ReportsMasterId=06 )
--BEGIN
--     INSERT INTO [dbo].[RPT_ReportsMaster]([RPT_ReportsMasterId],[ReportName],[ReportServer],[ReportURL],[ReportsCategoryLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[ViewInUI])
--     VALUES (06,N'ERS User Admin Field Change Logging Report',N'dbsep4085cls',N'https://rrtreportsprod.uhc.com/ReportServer/Pages/ReportViewer.aspx?%2fERS_Everyone%2frpt_ERS_06_UserAdmin_Field_Change_Logging_Report&rs:Command=Render',42001,1,getutcdate(),1,0)

--END
--GO

--IF NOT EXISTS (SELECT * FROM [dbo].[RPT_ReportsMaster] WHERE RPT_ReportsMasterId=07 )
--BEGIN
--     INSERT INTO [dbo].[RPT_ReportsMaster]([RPT_ReportsMasterId],[ReportName],[ReportServer],[ReportURL],[ReportsCategoryLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[ViewInUI])
--     VALUES (07,N'ERS Department Field Change Logging Report',N'dbsep4085cls',N'https://rrtreportsprod.uhc.com/ReportServer/Pages/ReportViewer.aspx?%2fERS_Everyone%2frpt_ERS_07_Department_Field_Change_Logging_Report&rs:Command=Render',42001,1,getutcdate(),1,0)

--END
--GO

--IF NOT EXISTS (SELECT * FROM [dbo].[RPT_ReportsMaster] WHERE RPT_ReportsMasterId=08 )
--BEGIN
--     INSERT INTO [dbo].[RPT_ReportsMaster]([RPT_ReportsMasterId],[ReportName],[ReportServer],[ReportURL],[ReportsCategoryLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[ViewInUI])
--     VALUES (08,N'ERS Lookup Field Change Logging Report',N'dbsep4085cls',N'https://rrtreportsprod.uhc.com/ReportServer/Pages/ReportViewer.aspx?%2fERS_Everyone%2frpt_ERS_08_Lookup_Field_Change_Logging_Report&rs:Command=Render',42001,1,getutcdate(),1,0)

--END
--GO

--IF NOT EXISTS (SELECT * FROM [dbo].[RPT_ReportsMaster] WHERE RPT_ReportsMasterId=09 )
--BEGIN
--     INSERT INTO [dbo].[RPT_ReportsMaster]([RPT_ReportsMasterId],[ReportName],[ReportServer],[ReportURL],[ReportsCategoryLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[ViewInUI])
--     VALUES (09,N'ERS Lookup Correlation Field Change Logging Report',N'dbsep4085cls',N'https://rrtreportsprod.uhc.com/ReportServer/Pages/ReportViewer.aspx?%2fERS_Everyone%2frpt_ERS_09_LookupCorrelation_Field_Change_Logging_Report&rs:Command=Render',42001,1,getutcdate(),1,0)

--END
--GO

--IF NOT EXISTS (SELECT * FROM [dbo].[RPT_ReportsMaster] WHERE RPT_ReportsMasterId=10 )
--BEGIN
--     INSERT INTO [dbo].[RPT_ReportsMaster]([RPT_ReportsMasterId],[ReportName],[ReportServer],[ReportURL],[ReportsCategoryLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[ViewInUI])
--     VALUES (10,N'ERS Resource Field Change Logging Report',N'dbsep4085cls',N'https://rrtreportsprod.uhc.com/ReportServer/Pages/ReportViewer.aspx?%2fERS_Everyone%2frpt_ERS_10_Resource_Field_Change_Logging_Report&rs:Command=Render',42001,1,getutcdate(),1,0)

--END
--GO

--IF NOT EXISTS (SELECT * FROM [dbo].[RPT_ReportsMaster] WHERE RPT_ReportsMasterId=11 )
--BEGIN
--     INSERT INTO [dbo].[RPT_ReportsMaster]([RPT_ReportsMasterId],[ReportName],[ReportServer],[ReportURL],[ReportsCategoryLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[ViewInUI])
--     VALUES (11,N'ERS Config Field Change Logging Report',N'dbsep4085cls',N'https://rrtreportsprod.uhc.com/ReportServer/Pages/ReportViewer.aspx?%2fERS_Everyone%2frpt_ERS_11_Config_Field_Change_Logging_Report&rs:Command=Render',42001,1,getutcdate(),1,0)

--END
--GO

--IF NOT EXISTS (SELECT * FROM [dbo].[RPT_ReportsMaster] WHERE RPT_ReportsMasterId=12 )
--BEGIN
--     INSERT INTO [dbo].[RPT_ReportsMaster]([RPT_ReportsMasterId],[ReportName],[ReportServer],[ReportURL],[ReportsCategoryLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[ViewInUI])
--     VALUES (12,N'ERS Access Group Field Change Logging Report',N'dbsep4085cls',N'https://rrtreportsprod.uhc.com/ReportServer/Pages/ReportViewer.aspx?%2fERS_Everyone%2frpt_ERS_12_AccessGroup_Field_Change_Logging_Report&rs:Command=Render',42001,1,getutcdate(),1,0)

--END
--GO

--IF NOT EXISTS (SELECT * FROM [dbo].[RPT_ReportsMaster] WHERE RPT_ReportsMasterId=13 )
--BEGIN
--     INSERT INTO [dbo].[RPT_ReportsMaster]([RPT_ReportsMasterId],[ReportName],[ReportServer],[ReportURL],[ReportsCategoryLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[ViewInUI])
--     VALUES (13,N'ERS Common Field Change Logging Report',N'dbsep4085cls',N'https://rrtreportsprod.uhc.com/ReportServer/Pages/ReportViewer.aspx?%2fERS_Everyone%2frpt_ERS_13_Queue_Field_Change_Logging_Report&rs:Command=Render',42001,1,getutcdate(),1,0)

--END
--GO

--IF NOT EXISTS (SELECT * FROM [dbo].[RPT_ReportsMaster] WHERE RPT_ReportsMasterId=14 )
--BEGIN
--     INSERT INTO [dbo].[RPT_ReportsMaster]([RPT_ReportsMasterId],[ReportName],[ReportServer],[ReportURL],[ReportsCategoryLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[ViewInUI])
--     VALUES (14,N'MTD Peer Audit Quality Report',N'dbsep4085cls',N'https://rrtreportsprod.uhc.com/ReportServer/Pages/ReportViewer.aspx?%2fERS_Everyone%2frpt_ERS_14_MTD_Peer_Audit_Quality_Summary_Report&rs:Command=Render',42001,1,getutcdate(),1,1)
--END
--GO

--IF NOT EXISTS (SELECT * FROM [dbo].[RPT_ReportsMaster] WHERE RPT_ReportsMasterId=15 )
--BEGIN
--     INSERT INTO [dbo].[RPT_ReportsMaster]([RPT_ReportsMasterId],[ReportName],[ReportServer],[ReportURL],[ReportsCategoryLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[ViewInUI])
--     VALUES (15,N'Background Process Monitor Report',N'dbsep4085cls',N'https://rrtreportsprod.uhc.com/ReportServer/Pages/ReportViewer.aspx?%2fERS_Everyone%2frpt_ERS_15_BGProcessMonitorSummary_Report&rs:Command=Render',42001,1,getutcdate(),1,1)
--END
--GO

--IF NOT EXISTS (SELECT * FROM [dbo].[RPT_ReportsMaster] WHERE RPT_ReportsMasterId=16 )
--BEGIN
--     INSERT INTO [dbo].[RPT_ReportsMaster]([RPT_ReportsMasterId],[ReportName],[ReportServer],[ReportURL],[ReportsCategoryLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[ViewInUI])
--     VALUES (16,N'Daily Dashboard Report',N'dbsep4085cls',N'https://rrtreportsprod.uhc.com/ReportServer/Pages/ReportViewer.aspx?%2fERS_Everyone%2frpt_ERS_16_Daily_Dashboard_Summary_Report&rs:Command=Render',42001,1,getutcdate(),1,1)
--END
--GO

--IF NOT EXISTS (SELECT * FROM [dbo].[RPT_ReportsMaster] WHERE RPT_ReportsMasterId=17 )
--BEGIN
--     INSERT INTO [dbo].[RPT_ReportsMaster]([RPT_ReportsMasterId],[ReportName],[ReportServer],[ReportURL],[ReportsCategoryLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[ViewInUI])
--     VALUES (17,N'Pended Report',N'dbsep4085cls',N'https://rrtreportsprod.uhc.com/ReportServer/Pages/ReportViewer.aspx?%2fERS_Everyone%2frpt_ERS_17_Pended_Report_Summary&rs:Command=Render',42001,1,getutcdate(),1,1)
--END
--GO

--IF NOT EXISTS (SELECT * FROM [dbo].[RPT_ReportsMaster] WHERE RPT_ReportsMasterId=18 )
--BEGIN
--     INSERT INTO [dbo].[RPT_ReportsMaster]([RPT_ReportsMasterId],[ReportName],[ReportServer],[ReportURL],[ReportsCategoryLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[ViewInUI])
--     VALUES (18,N'Monthly Metrics Report',N'dbsep4085cls',N'https://rrtreportsprod.uhc.com/ReportServer/Pages/ReportViewer.aspx?%2fERS_Everyone%2frpt_ERS_18_Monthly_Metrics_Summary_Report&rs:Command=Render',42001,1,getutcdate(),1,1)
--END
--GO
--IF NOT EXISTS (SELECT * FROM [dbo].[RPT_ReportsMaster] WHERE RPT_ReportsMasterId=19 )
--BEGIN
--     INSERT INTO [dbo].[RPT_ReportsMaster]([RPT_ReportsMasterId],[ReportName],[ReportServer],[ReportURL],[ReportsCategoryLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[ViewInUI])
--     VALUES (19,N'OOA Tracking Report',N'dbsep4085cls',N'https://rrtreportsprod.uhc.com/ReportServer/Pages/ReportViewer.aspx?%2fERS_Everyone%2frpt_ERS_19_OOA_Tracking_Report_Summary&rs:Command=Render',42001,1,getutcdate(),1,1)
--END
--GO

--IF NOT EXISTS (SELECT * FROM [dbo].[RPT_ReportsMaster] WHERE RPT_ReportsMasterId=20 )
--BEGIN
--     INSERT INTO [dbo].[RPT_ReportsMaster]([RPT_ReportsMasterId],[ReportName],[ReportServer],[ReportURL],[ReportsCategoryLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[ViewInUI])
--     VALUES (20,N'RPR Submission Report',N'dbsep4085cls',N'https://rrtreportsprod.uhc.com/ReportServer/Pages/ReportViewer.aspx?%2fERS_Everyone%2frpt_ERS_20_RPR_Submission_Report_Summary&rs:Command=Render',42001,1,getutcdate(),1,1)
--END
--GO

--IF NOT EXISTS (SELECT * FROM [dbo].[RPT_ReportsMaster] WHERE RPT_ReportsMasterId=21 )
--BEGIN
--       INSERT INTO [dbo].[RPT_ReportsMaster]([RPT_ReportsMasterId],[ReportName],[ReportServer],[ReportURL],[ReportsCategoryLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[ViewInUI])
--       VALUES (21,N'Web Service Monitoring Report',N'dbsep4085cls',N'https://rrtreportsprod.uhc.com/ReportServer/Pages/ReportViewer.aspx?%2fERS_Everyone%2frpt_ERS_21_WebService_Monitoring_Summary_Report&rs:Command=Render',42001,1,getutcdate(),1,1)
--END
--GO

--IF NOT EXISTS (SELECT * FROM [dbo].[RPT_ReportsMaster] WHERE RPT_ReportsMasterId=22 )
--BEGIN
--     INSERT INTO [dbo].[RPT_ReportsMaster]([RPT_ReportsMasterId],[ReportName],[ReportServer],[ReportURL],[ReportsCategoryLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[ViewInUI])
--     VALUES (22,N'Queue Detail Report',N'dbsep4085cls',N'https://rrtreportsprod.uhc.com/ReportServer/Pages/ReportViewer.aspx?%2fERS_Everyone%2frpt_ERS_22_Queue_Details_Report&rs:Command=Render',42001,1,getutcdate(),1,0)
--END
--GO

--IF NOT EXISTS (SELECT * FROM [dbo].[RPT_ReportsMaster] WHERE RPT_ReportsMasterId=23 )
--BEGIN
--	INSERT INTO [dbo].[RPT_ReportsMaster]([RPT_ReportsMasterId],[ReportName],[ReportServer],[ReportURL],[ReportsCategoryLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[ViewInUI])
--	VALUES (23,N'MQ Processing Report',N'dbsep4085cls',N'https://rrtreportsprod.uhc.com/ReportServer/Pages/ReportViewer.aspx?%2fERS_Everyone%2frpt_ERS_23_MQ_Records_Processing_Summary_Report&rs:Command=Render',42001,1,getutcdate(),1,1)
--END
--GO

--IF NOT EXISTS (SELECT * FROM [dbo].[RPT_ReportsMaster] WHERE RPT_ReportsMasterId=24 )
--BEGIN
--	INSERT INTO [dbo].[RPT_ReportsMaster]([RPT_ReportsMasterId],[ReportName],[ReportServer],[ReportURL],[ReportsCategoryLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[ViewInUI])
--	VALUES (24,N'OOA Reports',N'dbsep4085cls',N'https://rrtssrs2014prod.uhc.com/Reports/Pages/Report.aspx?ItemPath=%2fOOA%2fRPT_UHC_OOA_SAS_Auto_Process',42001,1,getutcdate(),1,1)
--END
--GO
--IF NOT EXISTS (SELECT * FROM [dbo].[RPT_ReportsMaster] WHERE RPT_ReportsMasterId=25 )
--BEGIN
--	INSERT INTO [dbo].[RPT_ReportsMaster]([RPT_ReportsMasterId],[ReportName],[ReportServer],[ReportURL],[ReportsCategoryLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[ViewInUI])
--	VALUES (25,N'Mass Update Report',N'dbsep4085cls',N'https://rrtreportsprod.uhc.com/ReportServer/Pages/ReportViewer.aspx?%2fERS_Everyone%2frpt_ERS_24_MassUpdate_Summary_Report&rs:Command=Render',42001,1,getutcdate(),1,1)
--END
--GO

--IF NOT EXISTS (SELECT * FROM [dbo].[RPT_ReportsMaster] WHERE RPT_ReportsMasterId=26 )
--BEGIN
--	INSERT INTO [dbo].[RPT_ReportsMaster]([RPT_ReportsMasterId],[ReportName],[ReportServer],[ReportURL],[ReportsCategoryLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[ViewInUI])
--	VALUES (26,N'ERS Queue Search Report',N'dbsep4085cls',N'https://rrtreportsprod.uhc.com/ReportServer/Pages/ReportViewer.aspx?%2fERS_Everyone%2frpt_ERS_26_Queue_Searh_Detail_Report&rs:Command=Render',42001,1,getutcdate(),1,0)
--END
--GO

--IF NOT EXISTS (SELECT * FROM [dbo].[RPT_ReportsMaster] WHERE RPT_ReportsMasterId=27 )
--BEGIN
--	INSERT INTO [dbo].[RPT_ReportsMaster]([RPT_ReportsMasterId],[ReportName],[ReportServer],[ReportURL],[ReportsCategoryLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[ViewInUI])
--	VALUES (27,N'ERS Bulk Upload Report',N'dbsep4085cls',N'https://rrtreportsprod.uhc.com/ReportServer/Pages/ReportViewer.aspx?%2fERS_Everyone%2frpt_ERS_25_Bulk_Upload_Summary_Report&rs:Command=Render',42001,1,getutcdate(),1,1)
--END
--GO

--IF NOT EXISTS (SELECT * FROM [dbo].[RPT_ReportsMaster] WHERE RPT_ReportsMasterId=28 )
--BEGIN
--	INSERT INTO [dbo].[RPT_ReportsMaster]([RPT_ReportsMasterId],[ReportName],[ReportServer],[ReportURL],[ReportsCategoryLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[ViewInUI])
--	VALUES (28,N'RPR Plan Error Report',N'dbsep4085cls',N'https://rrtreportsprod.uhc.com/ReportServer/Pages/ReportViewer.aspx?%2fERS_Everyone%2frpt_ERS_27_ERS_RPRPlanError_Summary_Report&rs:Command=Render',42001,1,getutcdate(),1,1)
--END
--GO

--IF NOT EXISTS (SELECT * FROM [dbo].[RPT_ReportsMaster] WHERE RPT_ReportsMasterId=29 )
--BEGIN
--	INSERT INTO [dbo].[RPT_ReportsMaster]([RPT_ReportsMasterId],[ReportName],[ReportServer],[ReportURL],[ReportsCategoryLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[ViewInUI])
--	VALUES (29,N'OOA Control Report',N'dbsep4085cls',N'https://rrtssrs2014prod.uhc.com/Reports/Pages/Report.aspx?ItemPath=%2fERS_BI_DATA%2fUHC_ERS_CONTROL_RPT',42001,1,getutcdate(),1,1)
--END
--GO

--IF NOT EXISTS (SELECT * FROM [dbo].[RPT_ReportsMaster] WHERE RPT_ReportsMasterId=30 )
--BEGIN
--	INSERT INTO [dbo].[RPT_ReportsMaster]([RPT_ReportsMasterId],[ReportName],[ReportServer],[ReportURL],[ReportsCategoryLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[ViewInUI])
--	VALUES (30,N'OOA Dashboard Report',N'dbsep4085cls',N'https://rrtssrs2014prod.uhc.com/Reports/Pages/Report.aspx?ItemPath=%2fOOA%2fRPT_UHG_OOA_DashBoard',42001,1,getutcdate(),1,1)
--END
--GO

--SET IDENTITY_INSERT [dbo].[RPT_ReportsMaster] OFF
