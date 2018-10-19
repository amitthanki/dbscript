IF NOT EXISTS (Select 1 From CMN_TableSequenceCounts Where CMN_TableSequenceCountsId = 1)
BEGIN
	INSERT INTO [dbo].[CMN_TableSequenceCounts] ([CMN_TableSequenceCountsId],[Sequence],[SequenceDescription])
	VALUES (1,1,'SaveAttempt Sequence')
END
GO

--------------------------------------------------------------------------------------

SET IDENTITY_INSERT [dbo].[ADM_UserMaster] ON

INSERT INTO [dbo].[ADM_UserMaster]
           ([ADM_UserMasterId],[LockedByRef],[UTCLockedOn],[Title],[FirstName],[LastName],[FullName],[SystemFullName],[MSID],[Email],[ManagerId],[LocationLkup],[NonUserLkup],[StartDate]
           ,[EndDate],[SpecialistTitle],[SpecialistPhone],[SpecialistFax],[SpecialistHours],[SpecialistTimeZone],[UserAddressLine1],[UserAddressLine2],[UserCity]
           ,[UserStateLkup],[UserZip],[IsActive],[UTCCreatedOn],[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef])
     VALUES
           (1,NULL,NULL,0,NULL,NULL,'Admin',NULL,'Admin','XLHI-App-Data-Support-Distribution@xlhealth.com',0,0,0,GETUTCDATE(),DateAdd(yy,30,GETUTCDATE())
           ,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,GETUTCDATE(),1,GETUTCDATE(),1)
GO

INSERT INTO [dbo].[ADM_UserMaster]
           ([ADM_UserMasterId],[LockedByRef],[UTCLockedOn],[Title],[FirstName],[LastName],[FullName],[SystemFullName],[MSID],[Email],[ManagerId],[LocationLkup],[NonUserLkup],[StartDate]
           ,[EndDate],[SpecialistTitle],[SpecialistPhone],[SpecialistFax],[SpecialistHours],[SpecialistTimeZone],[UserAddressLine1],[UserAddressLine2],[UserCity]
           ,[UserStateLkup],[UserZip],[IsActive],[UTCCreatedOn],[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef])
     VALUES
           (2,NULL,NULL,0,NULL,NULL,'ERSAppAdmin',NULL,'ERSAppAdmin','XLHI-App-Data-Support-Distribution@xlhealth.com',0,0,0,GETUTCDATE(),DateAdd(yy,30,GETUTCDATE())
           ,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,GETUTCDATE(),1,GETUTCDATE(),1)
GO

INSERT INTO [dbo].[ADM_UserMaster]
           ([ADM_UserMasterId],[LockedByRef],[UTCLockedOn],[Title],[FirstName],[LastName],[FullName],[SystemFullName],[MSID],[Email],[ManagerId],[LocationLkup],[NonUserLkup],[StartDate]
           ,[EndDate],[SpecialistTitle],[SpecialistPhone],[SpecialistFax],[SpecialistHours],[SpecialistTimeZone],[UserAddressLine1],[UserAddressLine2],[UserCity]
           ,[UserStateLkup],[UserZip],[IsActive],[UTCCreatedOn],[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef])
     VALUES
           (3,NULL,NULL,0,NULL,NULL,'SSIS Admin',NULL,'SSIS Admin','XLHI-App-Data-Support-Distribution@xlhealth.com',0,0,0,GETUTCDATE(),DateAdd(yy,30,GETUTCDATE())
           ,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,GETUTCDATE(),1,GETUTCDATE(),1)
GO

INSERT INTO [dbo].[ADM_UserMaster]
           ([ADM_UserMasterId],[LockedByRef],[UTCLockedOn],[Title],[FirstName],[LastName],[FullName],[SystemFullName],[MSID],[Email],[ManagerId],[LocationLkup],[NonUserLkup],[StartDate]
           ,[EndDate],[SpecialistTitle],[SpecialistPhone],[SpecialistFax],[SpecialistHours],[SpecialistTimeZone],[UserAddressLine1],[UserAddressLine2],[UserCity]
           ,[UserStateLkup],[UserZip],[IsActive],[UTCCreatedOn],[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef])
     VALUES
           (4,NULL,NULL,0,NULL,NULL,'AEGPS service',NULL,'AEGPS service','XLHI-App-Data-Support-Distribution@xlhealth.com',0,0,0,GETUTCDATE(),DateAdd(yy,30,GETUTCDATE())
           ,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,GETUTCDATE(),1,GETUTCDATE(),1)
GO

INSERT INTO [dbo].[ADM_UserMaster]
           ([ADM_UserMasterId],[LockedByRef],[UTCLockedOn],[Title],[FirstName],[LastName],[FullName],[SystemFullName],[MSID],[Email],[ManagerId],[LocationLkup],[NonUserLkup],[StartDate]
           ,[EndDate],[SpecialistTitle],[SpecialistPhone],[SpecialistFax],[SpecialistHours],[SpecialistTimeZone],[UserAddressLine1],[UserAddressLine2],[UserCity]
           ,[UserStateLkup],[UserZip],[IsActive],[UTCCreatedOn],[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef])
     VALUES
           (5,NULL,NULL,0,NULL,NULL,'AEMQ service',NULL,'AEMQ service','XLHI-App-Data-Support-Distribution@xlhealth.com',0,0,0,GETUTCDATE(),DateAdd(yy,30,GETUTCDATE())
           ,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,GETUTCDATE(),1,GETUTCDATE(),1)
GO

INSERT INTO [dbo].[ADM_UserMaster]
           ([ADM_UserMasterId],[LockedByRef],[UTCLockedOn],[Title],[FirstName],[LastName],[FullName],[SystemFullName],[MSID],[Email],[ManagerId],[LocationLkup],[NonUserLkup],[StartDate]
           ,[EndDate],[SpecialistTitle],[SpecialistPhone],[SpecialistFax],[SpecialistHours],[SpecialistTimeZone],[UserAddressLine1],[UserAddressLine2],[UserCity]
           ,[UserStateLkup],[UserZip],[IsActive],[UTCCreatedOn],[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef])
     VALUES
           (7,NULL,NULL,0,NULL,NULL,'MIIM Server',NULL,'y41_ers_nonprod','XLHI-App-Data-Support-Distribution@xlhealth.com',0,0,0,GETUTCDATE(),DateAdd(yy,30,GETUTCDATE())
           ,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,GETUTCDATE(),1,GETUTCDATE(),1)
GO

--INSERT INTO [dbo].[ADM_UserMaster]
--           ([ADM_UserMasterId],[LockedByRef],[UTCLockedOn],[Title],[FirstName],[LastName],[FullName],[SystemFullName],[MSID],[Email],[ManagerId],[LocationLkup],[NonUserLkup],[StartDate]
--           ,[EndDate],[SpecialistTitle],[SpecialistPhone],[SpecialistFax],[SpecialistHours],[SpecialistTimeZone],[UserAddressLine1],[UserAddressLine2],[UserCity]
--           ,[UserStateLkup],[UserZip],[IsActive],[UTCCreatedOn],[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef])
--     VALUES
--           (8,NULL,NULL,0,NULL,NULL,'System Admin','APSED4456','APSED4456','XLHI-App-Data-Support-Distribution@xlhealth.com',0,0,0,GETUTCDATE(),DateAdd(yy,30,GETUTCDATE())
--           ,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,GETUTCDATE(),1,GETUTCDATE(),1)
--GO

--INSERT INTO [dbo].[ADM_UserMaster]
--           ([ADM_UserMasterId],[LockedByRef],[UTCLockedOn],[Title],[FirstName],[LastName],[FullName],[SystemFullName],[MSID],[Email],[ManagerId],[LocationLkup],[NonUserLkup],[StartDate]
--           ,[EndDate],[SpecialistTitle],[SpecialistPhone],[SpecialistFax],[SpecialistHours],[SpecialistTimeZone],[UserAddressLine1],[UserAddressLine2],[UserCity]
--           ,[UserStateLkup],[UserZip],[IsActive],[UTCCreatedOn],[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef])
--     VALUES
--           (9,NULL,NULL,0,NULL,NULL,'System Admin','APSET3414','APSET3414','XLHI-App-Data-Support-Distribution@xlhealth.com',0,0,0,GETUTCDATE(),DateAdd(yy,30,GETUTCDATE())
--           ,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,GETUTCDATE(),1,GETUTCDATE(),1)
--GO

--INSERT INTO [dbo].[ADM_UserMaster]
--           ([ADM_UserMasterId],[LockedByRef],[UTCLockedOn],[Title],[FirstName],[LastName],[FullName],[SystemFullName],[MSID],[Email],[ManagerId],[LocationLkup],[NonUserLkup],[StartDate]
--           ,[EndDate],[SpecialistTitle],[SpecialistPhone],[SpecialistFax],[SpecialistHours],[SpecialistTimeZone],[UserAddressLine1],[UserAddressLine2],[UserCity]
--           ,[UserStateLkup],[UserZip],[IsActive],[UTCCreatedOn],[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef])
--     VALUES
--           (10,NULL,NULL,0,NULL,NULL,'System Admin','APSES5085','APSES5085','XLHI-App-Data-Support-Distribution@xlhealth.com',0,0,0,GETUTCDATE(),DateAdd(yy,30,GETUTCDATE())
--           ,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,GETUTCDATE(),1,GETUTCDATE(),1)
--GO

INSERT INTO [dbo].[ADM_UserMaster]
           ([ADM_UserMasterId],[LockedByRef],[UTCLockedOn],[Title],[FirstName],[LastName],[FullName],[SystemFullName],[MSID],[Email],[ManagerId],[LocationLkup],[NonUserLkup],[StartDate]
           ,[EndDate],[SpecialistTitle],[SpecialistPhone],[SpecialistFax],[SpecialistHours],[SpecialistTimeZone],[UserAddressLine1],[UserAddressLine2],[UserCity]
           ,[UserStateLkup],[UserZip],[IsActive],[UTCCreatedOn],[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef])
     VALUES
           (8,NULL,NULL,0,NULL,NULL,'System Admin','APSEP02144','APSEP02144','XLHI-App-Data-Support-Distribution@xlhealth.com',0,0,0,GETUTCDATE(),DateAdd(yy,30,GETUTCDATE())
           ,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,GETUTCDATE(),1,GETUTCDATE(),1)
GO

INSERT INTO [dbo].[ADM_UserMaster]
           ([ADM_UserMasterId],[LockedByRef],[UTCLockedOn],[Title],[FirstName],[LastName],[FullName],[SystemFullName],[MSID],[Email],[ManagerId],[LocationLkup],[NonUserLkup],[StartDate]
           ,[EndDate],[SpecialistTitle],[SpecialistPhone],[SpecialistFax],[SpecialistHours],[SpecialistTimeZone],[UserAddressLine1],[UserAddressLine2],[UserCity]
           ,[UserStateLkup],[UserZip],[IsActive],[UTCCreatedOn],[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef])
     VALUES
           (9,NULL,NULL,0,NULL,NULL,'System Admin','APSEP02149','APSEP02149','XLHI-App-Data-Support-Distribution@xlhealth.com',0,0,0,GETUTCDATE(),DateAdd(yy,30,GETUTCDATE())
           ,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,GETUTCDATE(),1,GETUTCDATE(),1)
GO

INSERT INTO [dbo].[ADM_UserMaster]
           ([ADM_UserMasterId],[LockedByRef],[UTCLockedOn],[Title],[FirstName],[LastName],[FullName],[SystemFullName],[MSID],[Email],[ManagerId],[LocationLkup],[NonUserLkup],[StartDate]
           ,[EndDate],[SpecialistTitle],[SpecialistPhone],[SpecialistFax],[SpecialistHours],[SpecialistTimeZone],[UserAddressLine1],[UserAddressLine2],[UserCity]
           ,[UserStateLkup],[UserZip],[IsActive],[UTCCreatedOn],[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef])
     VALUES
           (10,NULL,NULL,0,NULL,NULL,'SSIS Admin',NULL,'ERN Migration','XLHI-App-Data-Support-Distribution@xlhealth.com',0,0,0,GETUTCDATE(),DateAdd(yy,30,GETUTCDATE())
           ,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,GETUTCDATE(),1,GETUTCDATE(),1)
GO

INSERT INTO [dbo].[ADM_UserMaster]
           ([ADM_UserMasterId],[LockedByRef],[UTCLockedOn],[Title],[FirstName],[LastName],[FullName],[SystemFullName],[MSID],[Email],[ManagerId],[LocationLkup],[NonUserLkup],[StartDate]
           ,[EndDate],[SpecialistTitle],[SpecialistPhone],[SpecialistFax],[SpecialistHours],[SpecialistTimeZone],[UserAddressLine1],[UserAddressLine2],[UserCity]
           ,[UserStateLkup],[UserZip],[IsActive],[UTCCreatedOn],[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef])
     VALUES
           (11,NULL,NULL,0,NULL,NULL,'SSIS Admin',NULL,'OOA Incremental Data Load','XLHI-App-Data-Support-Distribution@xlhealth.com',0,0,0,GETUTCDATE(),DateAdd(yy,30,GETUTCDATE())
           ,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,GETUTCDATE(),1,GETUTCDATE(),1)
GO

INSERT INTO [dbo].[ADM_UserMaster]
           ([ADM_UserMasterId],[LockedByRef],[UTCLockedOn],[Title],[FirstName],[LastName],[FullName],[SystemFullName],[MSID],[Email],[ManagerId],[LocationLkup],[NonUserLkup],[StartDate]
           ,[EndDate],[SpecialistTitle],[SpecialistPhone],[SpecialistFax],[SpecialistHours],[SpecialistTimeZone],[UserAddressLine1],[UserAddressLine2],[UserCity]
           ,[UserStateLkup],[UserZip],[IsActive],[UTCCreatedOn],[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef])
     VALUES
           (12,NULL,NULL,0,NULL,NULL,'SSIS Admin',NULL,'SCC Incremental Data Load','XLHI-App-Data-Support-Distribution@xlhealth.com',0,0,0,GETUTCDATE(),DateAdd(yy,30,GETUTCDATE())
           ,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,GETUTCDATE(),1,GETUTCDATE(),1)
GO

INSERT INTO [dbo].[ADM_UserMaster]
           ([ADM_UserMasterId],[LockedByRef],[UTCLockedOn],[Title],[FirstName],[LastName],[FullName],[SystemFullName],[MSID],[Email],[ManagerId],[LocationLkup],[NonUserLkup],[StartDate]
           ,[EndDate],[SpecialistTitle],[SpecialistPhone],[SpecialistFax],[SpecialistHours],[SpecialistTimeZone],[UserAddressLine1],[UserAddressLine2],[UserCity]
           ,[UserStateLkup],[UserZip],[IsActive],[UTCCreatedOn],[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef])
     VALUES
           (13,NULL,NULL,0,NULL,NULL,'SSIS Admin',NULL,'Eligibility Incremental Data Load','XLHI-App-Data-Support-Distribution@xlhealth.com',0,0,0,GETUTCDATE(),DateAdd(yy,30,GETUTCDATE())
           ,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,GETUTCDATE(),1,GETUTCDATE(),1)
GO

INSERT INTO [dbo].[ADM_UserMaster]
           ([ADM_UserMasterId],[LockedByRef],[UTCLockedOn],[Title],[FirstName],[LastName],[FullName],[SystemFullName],[MSID],[Email],[ManagerId],[LocationLkup],[NonUserLkup],[StartDate]
           ,[EndDate],[SpecialistTitle],[SpecialistPhone],[SpecialistFax],[SpecialistHours],[SpecialistTimeZone],[UserAddressLine1],[UserAddressLine2],[UserCity]
           ,[UserStateLkup],[UserZip],[IsActive],[UTCCreatedOn],[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef])
     VALUES
           (14,NULL,NULL,0,NULL,NULL,'SSIS Admin',NULL,'DOB Gender Incremental Data Load','XLHI-App-Data-Support-Distribution@xlhealth.com',0,0,0,GETUTCDATE(),DateAdd(yy,30,GETUTCDATE())
           ,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,GETUTCDATE(),1,GETUTCDATE(),1)
GO

INSERT INTO [dbo].[ADM_UserMaster]
           ([ADM_UserMasterId],[LockedByRef],[UTCLockedOn],[Title],[FirstName],[LastName],[FullName],[SystemFullName],[MSID],[Email],[ManagerId],[LocationLkup],[NonUserLkup],[StartDate]
           ,[EndDate],[SpecialistTitle],[SpecialistPhone],[SpecialistFax],[SpecialistHours],[SpecialistTimeZone],[UserAddressLine1],[UserAddressLine2],[UserCity]
           ,[UserStateLkup],[UserZip],[IsActive],[UTCCreatedOn],[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef])
     VALUES
           (15,NULL,NULL,0,NULL,NULL,'SSIS Admin',NULL,'Bulk File Upload','XLHI-App-Data-Support-Distribution@xlhealth.com',0,0,0,GETUTCDATE(),DateAdd(yy,30,GETUTCDATE())
           ,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,GETUTCDATE(),1,GETUTCDATE(),1)
GO

INSERT INTO [dbo].[ADM_UserMaster]
           ([ADM_UserMasterId],[LockedByRef],[UTCLockedOn],[Title],[FirstName],[LastName],[FullName],[SystemFullName],[MSID],[Email],[ManagerId],[LocationLkup],[NonUserLkup],[StartDate]
           ,[EndDate],[SpecialistTitle],[SpecialistPhone],[SpecialistFax],[SpecialistHours],[SpecialistTimeZone],[UserAddressLine1],[UserAddressLine2],[UserCity]
           ,[UserStateLkup],[UserZip],[IsActive],[UTCCreatedOn],[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef])
     VALUES
           (16,NULL,NULL,0,NULL,NULL,'System : TRRBulkUpload',NULL,'System : TRRBulkUpload','XLHI-App-Data-Support-Distribution@xlhealth.com',0,0,0,GETUTCDATE(),DateAdd(yy,30,GETUTCDATE())
           ,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,GETUTCDATE(),1,GETUTCDATE(),1)
GO

INSERT INTO [dbo].[ADM_UserMaster]
           ([ADM_UserMasterId],[LockedByRef],[UTCLockedOn],[Title],[FirstName],[LastName],[FullName],[SystemFullName],[MSID],[Email],[ManagerId],[LocationLkup],[NonUserLkup],[StartDate]
           ,[EndDate],[SpecialistTitle],[SpecialistPhone],[SpecialistFax],[SpecialistHours],[SpecialistTimeZone],[UserAddressLine1],[UserAddressLine2],[UserCity]
           ,[UserStateLkup],[UserZip],[IsActive],[UTCCreatedOn],[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef])
     VALUES
           (17,NULL,NULL,0,NULL,NULL,'System : GPS WQ',NULL,'System : GPS WQ','XLHI-App-Data-Support-Distribution@xlhealth.com',0,0,0,GETUTCDATE(),DateAdd(yy,30,GETUTCDATE())
           ,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,GETUTCDATE(),1,GETUTCDATE(),1)
GO

INSERT INTO [dbo].[ADM_UserMaster]
           ([ADM_UserMasterId],[LockedByRef],[UTCLockedOn],[Title],[FirstName],[LastName],[FullName],[SystemFullName],[MSID],[Email],[ManagerId],[LocationLkup],[NonUserLkup],[StartDate]
           ,[EndDate],[SpecialistTitle],[SpecialistPhone],[SpecialistFax],[SpecialistHours],[SpecialistTimeZone],[UserAddressLine1],[UserAddressLine2],[UserCity]
           ,[UserStateLkup],[UserZip],[IsActive],[UTCCreatedOn],[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef])
     VALUES
           (18,NULL,NULL,0,NULL,NULL,'LH7U05CG6033CGN',NULL,'LH7U05CG6033CGN','XLHI-App-Data-Support-Distribution@xlhealth.com',0,0,0,GETUTCDATE(),DateAdd(yy,30,GETUTCDATE())
           ,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,GETUTCDATE(),1,GETUTCDATE(),1)
GO

INSERT INTO [dbo].[ADM_UserMaster]
           ([ADM_UserMasterId],[LockedByRef],[UTCLockedOn],[Title],[FirstName],[LastName],[FullName],[SystemFullName],[MSID],[Email],[ManagerId],[LocationLkup],[NonUserLkup],[StartDate]
           ,[EndDate],[SpecialistTitle],[SpecialistPhone],[SpecialistFax],[SpecialistHours],[SpecialistTimeZone],[UserAddressLine1],[UserAddressLine2],[UserCity]
           ,[UserStateLkup],[UserZip],[IsActive],[UTCCreatedOn],[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef])
     VALUES
           (19,NULL,NULL,0,NULL,NULL,'LH7U05CG6033CHV',NULL,'LH7U05CG6033CHV','XLHI-App-Data-Support-Distribution@xlhealth.com',0,0,0,GETUTCDATE(),DateAdd(yy,30,GETUTCDATE())
           ,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,GETUTCDATE(),1,GETUTCDATE(),1)
GO

INSERT INTO [dbo].[ADM_UserMaster]
           ([ADM_UserMasterId],[LockedByRef],[UTCLockedOn],[Title],[FirstName],[LastName],[FullName],[SystemFullName],[MSID],[Email],[ManagerId],[LocationLkup],[NonUserLkup],[StartDate]
           ,[EndDate],[SpecialistTitle],[SpecialistPhone],[SpecialistFax],[SpecialistHours],[SpecialistTimeZone],[UserAddressLine1],[UserAddressLine2],[UserCity]
           ,[UserStateLkup],[UserZip],[IsActive],[UTCCreatedOn],[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef])
     VALUES
           (20,NULL,NULL,0,NULL,NULL,'LH7U05CG6033CJ0',NULL,'LH7U05CG6033CJ0','XLHI-App-Data-Support-Distribution@xlhealth.com',0,0,0,GETUTCDATE(),DateAdd(yy,30,GETUTCDATE())
           ,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,GETUTCDATE(),1,GETUTCDATE(),1)
GO

INSERT INTO [dbo].[ADM_UserMaster]
           ([ADM_UserMasterId],[LockedByRef],[UTCLockedOn],[Title],[FirstName],[LastName],[FullName],[SystemFullName],[MSID],[Email],[ManagerId],[LocationLkup],[NonUserLkup],[StartDate]
           ,[EndDate],[SpecialistTitle],[SpecialistPhone],[SpecialistFax],[SpecialistHours],[SpecialistTimeZone],[UserAddressLine1],[UserAddressLine2],[UserCity]
           ,[UserStateLkup],[UserZip],[IsActive],[UTCCreatedOn],[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef])
     VALUES
           (21,NULL,NULL,0,NULL,NULL,'LH7U05CG5111QND',NULL,'LH7U05CG5111QND','XLHI-App-Data-Support-Distribution@xlhealth.com',0,0,0,GETUTCDATE(),DateAdd(yy,30,GETUTCDATE())
           ,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,GETUTCDATE(),1,GETUTCDATE(),1)
GO

INSERT INTO [dbo].[ADM_UserMaster]
           ([ADM_UserMasterId],[LockedByRef],[UTCLockedOn],[Title],[FirstName],[LastName],[FullName],[SystemFullName],[MSID],[Email],[ManagerId],[LocationLkup],[NonUserLkup],[StartDate]
           ,[EndDate],[SpecialistTitle],[SpecialistPhone],[SpecialistFax],[SpecialistHours],[SpecialistTimeZone],[UserAddressLine1],[UserAddressLine2],[UserCity]
           ,[UserStateLkup],[UserZip],[IsActive],[UTCCreatedOn],[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef])
     VALUES
           (22,NULL,NULL,0,NULL,NULL,'SSIS Admin',NULL,'SISS Admin Holding Queue','XLHI-App-Data-Support-Distribution@xlhealth.com',0,0,0,GETUTCDATE(),DateAdd(yy,30,GETUTCDATE())
           ,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,GETUTCDATE(),1,GETUTCDATE(),1)
GO

INSERT INTO [dbo].[ADM_UserMaster]
           ([ADM_UserMasterId],[LockedByRef],[UTCLockedOn],[Title],[FirstName],[LastName],[FullName],[SystemFullName],[MSID],[Email],[ManagerId],[LocationLkup],[NonUserLkup],[StartDate]
           ,[EndDate],[SpecialistTitle],[SpecialistPhone],[SpecialistFax],[SpecialistHours],[SpecialistTimeZone],[UserAddressLine1],[UserAddressLine2],[UserCity]
           ,[UserStateLkup],[UserZip],[IsActive],[UTCCreatedOn],[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef])
     VALUES
           (23,NULL,NULL,0,NULL,NULL,'SSIS Admin',NULL,'SISS Admin Macro','XLHI-App-Data-Support-Distribution@xlhealth.com',0,0,0,GETUTCDATE(),DateAdd(yy,30,GETUTCDATE())
           ,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,GETUTCDATE(),1,GETUTCDATE(),1)
GO

--INSERT INTO [dbo].[ADM_UserMaster]
--           ([ADM_UserMasterId],[LockedByRef],[UTCLockedOn],[Title],[FirstName],[LastName],[FullName],[SystemFullName],[MSID],[Email],[ManagerId],[LocationLkup],[NonUserLkup],[StartDate]
--           ,[EndDate],[SpecialistTitle],[SpecialistPhone],[SpecialistFax],[SpecialistHours],[SpecialistTimeZone],[UserAddressLine1],[UserAddressLine2],[UserCity]
--           ,[UserStateLkup],[UserZip],[IsActive],[UTCCreatedOn],[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef])
--     VALUES
--           (tobeprovided,NULL,NULL,0,NULL,NULL,'System Admin','APSEP02144','APSEP02144','XLHI-App-Data-Support-Distribution@xlhealth.com',0,0,0,GETUTCDATE(),DateAdd(yy,30,GETUTCDATE())
--           ,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,GETUTCDATE(),1,GETUTCDATE(),1)
--GO

--INSERT INTO [dbo].[ADM_UserMaster]
--           ([ADM_UserMasterId],[LockedByRef],[UTCLockedOn],[Title],[FirstName],[LastName],[FullName],[SystemFullName],[MSID],[Email],[ManagerId],[LocationLkup],[NonUserLkup],[StartDate]
--           ,[EndDate],[SpecialistTitle],[SpecialistPhone],[SpecialistFax],[SpecialistHours],[SpecialistTimeZone],[UserAddressLine1],[UserAddressLine2],[UserCity]
--           ,[UserStateLkup],[UserZip],[IsActive],[UTCCreatedOn],[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef])
--     VALUES
--           (tobeprovided,NULL,NULL,0,NULL,NULL,'System Admin','APSEP02149','APSEP02149','XLHI-App-Data-Support-Distribution@xlhealth.com',0,0,0,GETUTCDATE(),DateAdd(yy,30,GETUTCDATE())
--           ,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,GETUTCDATE(),1,GETUTCDATE(),1)
--GO

INSERT INTO [dbo].[ADM_UserMaster]
           ([ADM_UserMasterId],[LockedByRef],[UTCLockedOn],[Title],[FirstName],[LastName],[FullName],[SystemFullName],[MSID],[Email],[ManagerId],[LocationLkup],[NonUserLkup],[StartDate]
           ,[EndDate],[SpecialistTitle],[SpecialistPhone],[SpecialistFax],[SpecialistHours],[SpecialistTimeZone],[UserAddressLine1],[UserAddressLine2],[UserCity]
           ,[UserStateLkup],[UserZip],[IsActive],[UTCCreatedOn],[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef])
     VALUES
           (24,NULL,NULL,0,NULL,NULL,'Monitor',NULL,'sqlmon','XLHI-App-Data-Support-Distribution@xlhealth.com',0,0,0,GETUTCDATE(),DateAdd(yy,30,GETUTCDATE())
           ,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,GETUTCDATE(),1,GETUTCDATE(),1)
GO

INSERT INTO [dbo].[ADM_UserMaster]
           ([ADM_UserMasterId],[LockedByRef],[UTCLockedOn],[Title],[FirstName],[LastName],[FullName],[SystemFullName],[MSID],[Email],[ManagerId],[LocationLkup],[NonUserLkup],[StartDate]
           ,[EndDate],[SpecialistTitle],[SpecialistPhone],[SpecialistFax],[SpecialistHours],[SpecialistTimeZone],[UserAddressLine1],[UserAddressLine2],[UserCity]
           ,[UserStateLkup],[UserZip],[IsActive],[UTCCreatedOn],[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef])
     VALUES
           (25,NULL,NULL,0,NULL,NULL,'Monitor',NULL,'svcerswebappprd','XLHI-App-Data-Support-Distribution@xlhealth.com',0,0,0,GETUTCDATE(),DateAdd(yy,30,GETUTCDATE())
           ,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,GETUTCDATE(),1,GETUTCDATE(),1)
GO


INSERT [dbo].[ADM_UserMaster] ([ADM_UserMasterId], [LockedByRef], [UTCLockedOn], [Title], [FirstName], [LastName], [FullName], [SystemFullName], [MSID], [Email], [ManagerId], [LocationLkup], [NonUserLkup], [StartDate], [EndDate], [SpecialistTitle], [SpecialistPhone], [SpecialistFax], [SpecialistHours], [SpecialistTimeZone], [UserAddressLine1], [UserAddressLine2], [UserCity], [UserStateLkup], [UserZip], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef], [IsManager], [CreatedByRoleLkup], [LastUpdatedByRoleLkup]) 
VALUES (1000, NULL, NULL, 34001, N'Rakesh', N'Hosagoudar', N'Rakesh Hosagoudar', NULL, N'rhosagou', N'rakesh.h@uhc.com', NULL, NULL, NULL, GETUTCDATE(), DateAdd(yy,50,GETUTCDATE()), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, GETUTCDATE(), 1, GETUTCDATE(), 1, 0, NULL, NULL)
Go
INSERT [dbo].[ADM_UserMaster] ([ADM_UserMasterId], [LockedByRef], [UTCLockedOn], [Title], [FirstName], [LastName], [FullName], [SystemFullName], [MSID], [Email], [ManagerId], [LocationLkup], [NonUserLkup], [StartDate], [EndDate], [SpecialistTitle], [SpecialistPhone], [SpecialistFax], [SpecialistHours], [SpecialistTimeZone], [UserAddressLine1], [UserAddressLine2], [UserCity], [UserStateLkup], [UserZip], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef], [IsManager], [CreatedByRoleLkup], [LastUpdatedByRoleLkup]) 
VALUES (1001, NULL, NULL, 34001, N'Sourabha', N'Barik', N'Sourabha Ranjan Barik', NULL, N'sbarik1', N'sourabha.barik@uhc.com', NULL, NULL, NULL, GETUTCDATE(), DateAdd(yy,50,GETUTCDATE()), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, GETUTCDATE(), 1, GETUTCDATE(), 1, 0, NULL, NULL)
GO

SET IDENTITY_INSERT [dbo].[ADM_UserMaster] OFF

-------------------------------------------------------------------------------------------


SET IDENTITY_INSERT [dbo].[CMN_Department] ON 

INSERT [dbo].[CMN_Department] ([CMN_DepartmentId], [LockedByRef], [UTCLockedOn], [ERSDepartmentName], [BusinessSegmentLkup], [DepartmentLkup], [EffectiveDate], [InactivationDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
VALUES (1, NULL, NULL, N'M & R - Billing', 1001, 8002, GETUTCDATE(), DateAdd(yy,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
GO
INSERT [dbo].[CMN_Department] ([CMN_DepartmentId], [LockedByRef], [UTCLockedOn], [ERSDepartmentName], [BusinessSegmentLkup], [DepartmentLkup], [EffectiveDate], [InactivationDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
VALUES (2, NULL, NULL, N'PCP - Billing', 1003, 8002, GETUTCDATE(), DateAdd(yy,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
GO
INSERT [dbo].[CMN_Department] ([CMN_DepartmentId], [LockedByRef], [UTCLockedOn], [ERSDepartmentName], [BusinessSegmentLkup], [DepartmentLkup], [EffectiveDate], [InactivationDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
VALUES (3, NULL, NULL, N'M & R - Customer Service', 1001, 8004, GETUTCDATE(), DateAdd(yy,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
GO
INSERT [dbo].[CMN_Department] ([CMN_DepartmentId], [LockedByRef], [UTCLockedOn], [ERSDepartmentName], [BusinessSegmentLkup], [DepartmentLkup], [EffectiveDate], [InactivationDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
VALUES (4, NULL, NULL, N'PCP - Customer Service', 1003, 8004, GETUTCDATE(), DateAdd(yy,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
GO
INSERT [dbo].[CMN_Department] ([CMN_DepartmentId], [LockedByRef], [UTCLockedOn], [ERSDepartmentName], [BusinessSegmentLkup], [DepartmentLkup], [EffectiveDate], [InactivationDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
VALUES (5, NULL, NULL, N'PCP - Enrollment', 1003, 8001, GETUTCDATE(), DateAdd(yy,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
GO
INSERT [dbo].[CMN_Department] ([CMN_DepartmentId], [LockedByRef], [UTCLockedOn], [ERSDepartmentName], [BusinessSegmentLkup], [DepartmentLkup], [EffectiveDate], [InactivationDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
VALUES (6, NULL, NULL, N'C & S - Sales', 1002, 8003, GETUTCDATE(), DateAdd(yy,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
GO
INSERT [dbo].[CMN_Department] ([CMN_DepartmentId], [LockedByRef], [UTCLockedOn], [ERSDepartmentName], [BusinessSegmentLkup], [DepartmentLkup], [EffectiveDate], [InactivationDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
VALUES (7, NULL, NULL, N'C & S - Billing', 1002, 8002, GETUTCDATE(), DateAdd(yy,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
GO
INSERT [dbo].[CMN_Department] ([CMN_DepartmentId], [LockedByRef], [UTCLockedOn], [ERSDepartmentName], [BusinessSegmentLkup], [DepartmentLkup], [EffectiveDate], [InactivationDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
VALUES (8, NULL, NULL, N'M & R - Enrollment', 1001, 8001, GETUTCDATE(), DateAdd(yy,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
GO
INSERT [dbo].[CMN_Department] ([CMN_DepartmentId], [LockedByRef], [UTCLockedOn], [ERSDepartmentName], [BusinessSegmentLkup], [DepartmentLkup], [EffectiveDate], [InactivationDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
VALUES (9, NULL, NULL, N'M & R - Sales', 1001, 8003, GETUTCDATE(), DateAdd(yy,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
GO
INSERT [dbo].[CMN_Department] ([CMN_DepartmentId], [LockedByRef], [UTCLockedOn], [ERSDepartmentName], [BusinessSegmentLkup], [DepartmentLkup], [EffectiveDate], [InactivationDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
VALUES (10, NULL, NULL, N'C & S - Enrollment', 1002, 8001, GETUTCDATE(), DateAdd(yy,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
GO
INSERT [dbo].[CMN_Department] ([CMN_DepartmentId], [LockedByRef], [UTCLockedOn], [ERSDepartmentName], [BusinessSegmentLkup], [DepartmentLkup], [EffectiveDate], [InactivationDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
VALUES (11, NULL, NULL, N'PCP - Sales', 1003, 8003, GETUTCDATE(), DateAdd(yy,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
GO
INSERT [dbo].[CMN_Department] ([CMN_DepartmentId], [LockedByRef], [UTCLockedOn], [ERSDepartmentName], [BusinessSegmentLkup], [DepartmentLkup], [EffectiveDate], [InactivationDate], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
VALUES (12, NULL, NULL, N'C & S - Customer Service', 1002, 8004, GETUTCDATE(), DateAdd(yy,50,GETUTCDATE()), 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
GO

SET IDENTITY_INSERT [dbo].[CMN_Department] OFF

---------------------------------------------------------------


SET IDENTITY_INSERT [dbo].[ADM_SkillsMaster] ON

INSERT [dbo].[ADM_SkillsMaster] ([ADM_SkillsMasterId], [LockedByRef], [UTCLockedOn], [SkillsName], [RoleLkup], [BusinessSegmentLkup], [CMN_DepartmentRef], [WorkBasketLkup], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef], [DiscrepancyCategoryLkup]) 
VALUES (1, NULL, NULL, N'Admin M&R Enroll DOB', 2001, 1001, 8, 3002, 1, GETUTCDATE(), 1, GETUTCDATE(), 1, 6005)
GO
INSERT [dbo].[ADM_SkillsMaster] ([ADM_SkillsMasterId], [LockedByRef], [UTCLockedOn], [SkillsName], [RoleLkup], [BusinessSegmentLkup], [CMN_DepartmentRef], [WorkBasketLkup], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef], [DiscrepancyCategoryLkup]) 
VALUES (2, NULL, NULL, N'Admin M&R Enroll Eligibility GEN', 2001, 1001, 8, 3002, 1, GETUTCDATE(), 1, GETUTCDATE(), 1, 6006)
GO
INSERT [dbo].[ADM_SkillsMaster] ([ADM_SkillsMasterId], [LockedByRef], [UTCLockedOn], [SkillsName], [RoleLkup], [BusinessSegmentLkup], [CMN_DepartmentRef], [WorkBasketLkup], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef], [DiscrepancyCategoryLkup]) 
VALUES (3, NULL, NULL, N'Admin M&R Enroll Eligibility', 2001, 1001, 8, 3002, 1, GETUTCDATE(), 1, GETUTCDATE(), 1, 6004)
GO
INSERT [dbo].[ADM_SkillsMaster] ([ADM_SkillsMasterId], [LockedByRef], [UTCLockedOn], [SkillsName], [RoleLkup], [BusinessSegmentLkup], [CMN_DepartmentRef], [WorkBasketLkup], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef], [DiscrepancyCategoryLkup]) 
VALUES (4, NULL, NULL, N'Admin M&R Enroll OST OOA', 2001, 1001, 8, 3001, 1, GETUTCDATE(), 1, GETUTCDATE(), 1, 6001)
GO
INSERT [dbo].[ADM_SkillsMaster] ([ADM_SkillsMasterId], [LockedByRef], [UTCLockedOn], [SkillsName], [RoleLkup], [BusinessSegmentLkup], [CMN_DepartmentRef], [WorkBasketLkup], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef], [DiscrepancyCategoryLkup]) 
VALUES (5, NULL, NULL, N'Admin M&R Enroll OST SCC', 2001, 1001, 8, 3001, 1, GETUTCDATE(), 1, GETUTCDATE(), 1, 6002)
GO
INSERT [dbo].[ADM_SkillsMaster] ([ADM_SkillsMasterId], [LockedByRef], [UTCLockedOn], [SkillsName], [RoleLkup], [BusinessSegmentLkup], [CMN_DepartmentRef], [WorkBasketLkup], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef], [DiscrepancyCategoryLkup]) 
VALUES (6, NULL, NULL, N'Admin M&R Enroll OST TRR', 2001, 1001, 8, 3001, 1, GETUTCDATE(), 1, GETUTCDATE(), 1, 6003)
GO
INSERT [dbo].[ADM_SkillsMaster] ([ADM_SkillsMasterId], [LockedByRef], [UTCLockedOn], [SkillsName], [RoleLkup], [BusinessSegmentLkup], [CMN_DepartmentRef], [WorkBasketLkup], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef], [DiscrepancyCategoryLkup]) 
VALUES (7, NULL, NULL, N'Admin M&R Enroll RPR', 2001, 1001, 8, 3003, 1, GETUTCDATE(), 1, GETUTCDATE(), 1, 6007)
GO

SET IDENTITY_INSERT [dbo].[ADM_SkillsMaster] OFF

---------------------------------------------------------------

SET IDENTITY_INSERT [dbo].[ADM_AccessGroupMaster] ON

INSERT [dbo].[ADM_AccessGroupMaster] ([ADM_AccessGroupMasterId], [LockedByRef], [UTCLockedOn], [AccessGroupName], [AccessGroupDescription], [RoleLkup], [WorkBasketLkup], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) 
VALUES (1, NULL, NULL, N'AdminAccessGroup', N'test', 2001, 3002, 1, GETUTCDATE(), 1, GETUTCDATE(), 1)

SET IDENTITY_INSERT [dbo].[ADM_AccessGroupMaster] OFF

-------------------------------------------------------------------------------

SET IDENTITY_INSERT [dbo].[ADM_AccessGroupSkillsCorrelation] ON

INSERT [dbo].[ADM_AccessGroupSkillsCorrelation] ([ADM_AccessGroupSkillsCorrelationId], [ADM_AccessGroupMasterRef], [ADM_SkillsMasterRef], [CanCreate], [CanModify], [CanSearch], [CanView], [CanMassUpdate], [CanHistory], [CanReassign], [CanUnlock], [CanUpload], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef], [CanClone])
VALUES (1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, GETUTCDATE(), 1, GETUTCDATE(), 1, 1)
GO

INSERT [dbo].[ADM_AccessGroupSkillsCorrelation] ([ADM_AccessGroupSkillsCorrelationId], [ADM_AccessGroupMasterRef], [ADM_SkillsMasterRef], [CanCreate], [CanModify], [CanSearch], [CanView], [CanMassUpdate], [CanHistory], [CanReassign], [CanUnlock], [CanUpload], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef], [CanClone])
VALUES (2, 1, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, GETUTCDATE(), 1, GETUTCDATE(), 1, 1)
GO

INSERT [dbo].[ADM_AccessGroupSkillsCorrelation] ([ADM_AccessGroupSkillsCorrelationId], [ADM_AccessGroupMasterRef], [ADM_SkillsMasterRef], [CanCreate], [CanModify], [CanSearch], [CanView], [CanMassUpdate], [CanHistory], [CanReassign], [CanUnlock], [CanUpload], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef], [CanClone])
VALUES (3, 1, 3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, GETUTCDATE(), 1, GETUTCDATE(), 1, 1)
GO

INSERT [dbo].[ADM_AccessGroupSkillsCorrelation] ([ADM_AccessGroupSkillsCorrelationId], [ADM_AccessGroupMasterRef], [ADM_SkillsMasterRef], [CanCreate], [CanModify], [CanSearch], [CanView], [CanMassUpdate], [CanHistory], [CanReassign], [CanUnlock], [CanUpload], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef], [CanClone])
VALUES (4, 1, 4, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, GETUTCDATE(), 1, GETUTCDATE(), 1, 1)
GO

INSERT [dbo].[ADM_AccessGroupSkillsCorrelation] ([ADM_AccessGroupSkillsCorrelationId], [ADM_AccessGroupMasterRef], [ADM_SkillsMasterRef], [CanCreate], [CanModify], [CanSearch], [CanView], [CanMassUpdate], [CanHistory], [CanReassign], [CanUnlock], [CanUpload], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef], [CanClone])
VALUES (5, 1, 5, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, GETUTCDATE(), 1, GETUTCDATE(), 1, 1)
GO

INSERT [dbo].[ADM_AccessGroupSkillsCorrelation] ([ADM_AccessGroupSkillsCorrelationId], [ADM_AccessGroupMasterRef], [ADM_SkillsMasterRef], [CanCreate], [CanModify], [CanSearch], [CanView], [CanMassUpdate], [CanHistory], [CanReassign], [CanUnlock], [CanUpload], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef], [CanClone])
VALUES (6, 1, 6, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, GETUTCDATE(), 1, GETUTCDATE(), 1, 1)
GO

INSERT [dbo].[ADM_AccessGroupSkillsCorrelation] ([ADM_AccessGroupSkillsCorrelationId], [ADM_AccessGroupMasterRef], [ADM_SkillsMasterRef], [CanCreate], [CanModify], [CanSearch], [CanView], [CanMassUpdate], [CanHistory], [CanReassign], [CanUnlock], [CanUpload], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef], [CanClone])
VALUES (7, 1, 7, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, GETUTCDATE(), 1, GETUTCDATE(), 1, 1)
GO

SET IDENTITY_INSERT [dbo].[ADM_AccessGroupSkillsCorrelation] OFF

-------------------------------------------------------------------------------

SET IDENTITY_INSERT [dbo].[ADM_AccessGroupUserCorrelation] ON

INSERT [dbo].[ADM_AccessGroupUserCorrelation] ([ADM_AccessGroupUserCorrelationId], [ADM_AccessGroupMasterRef], [ADM_UserMasterRef], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef], [CreatedByRoleLkup], [LastUpdatedByRoleLkup]) 
VALUES (1, 1, 1000, 1, GETUTCDATE(), 1, GETUTCDATE(), 1, NULL, NULL)
GO

INSERT [dbo].[ADM_AccessGroupUserCorrelation] ([ADM_AccessGroupUserCorrelationId], [ADM_AccessGroupMasterRef], [ADM_UserMasterRef], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef], [CreatedByRoleLkup], [LastUpdatedByRoleLkup]) 
VALUES (2, 1, 1001, 1, GETUTCDATE(), 1, GETUTCDATE(), 1, NULL, NULL)
GO

SET IDENTITY_INSERT [dbo].[ADM_AccessGroupUserCorrelation] OFF

-------------------------------------------------------------------------------

SET IDENTITY_INSERT [dbo].[ADM_SkillWorkQueuesCorrelation] ON

INSERT [dbo].[ADM_SkillWorkQueuesCorrelation] ([ADM_SkillWorkQueuesCorrelationId], [ADM_SkillsMasterRef], [WorkQueuesLkup], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) VALUES (1, 1, 10059, 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
GO
INSERT [dbo].[ADM_SkillWorkQueuesCorrelation] ([ADM_SkillWorkQueuesCorrelationId], [ADM_SkillsMasterRef], [WorkQueuesLkup], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) VALUES (2, 1, 10060, 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
GO
INSERT [dbo].[ADM_SkillWorkQueuesCorrelation] ([ADM_SkillWorkQueuesCorrelationId], [ADM_SkillsMasterRef], [WorkQueuesLkup], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) VALUES (3, 1, 10061, 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
GO
INSERT [dbo].[ADM_SkillWorkQueuesCorrelation] ([ADM_SkillWorkQueuesCorrelationId], [ADM_SkillsMasterRef], [WorkQueuesLkup], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) VALUES (4, 1, 10062, 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
GO
INSERT [dbo].[ADM_SkillWorkQueuesCorrelation] ([ADM_SkillWorkQueuesCorrelationId], [ADM_SkillsMasterRef], [WorkQueuesLkup], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) VALUES (5, 2, 10063, 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
GO
INSERT [dbo].[ADM_SkillWorkQueuesCorrelation] ([ADM_SkillWorkQueuesCorrelationId], [ADM_SkillsMasterRef], [WorkQueuesLkup], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) VALUES (6, 2, 10064, 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
GO
INSERT [dbo].[ADM_SkillWorkQueuesCorrelation] ([ADM_SkillWorkQueuesCorrelationId], [ADM_SkillsMasterRef], [WorkQueuesLkup], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) VALUES (7, 2, 10065, 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
GO
INSERT [dbo].[ADM_SkillWorkQueuesCorrelation] ([ADM_SkillWorkQueuesCorrelationId], [ADM_SkillsMasterRef], [WorkQueuesLkup], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) VALUES (8, 2, 10066, 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
GO
INSERT [dbo].[ADM_SkillWorkQueuesCorrelation] ([ADM_SkillWorkQueuesCorrelationId], [ADM_SkillsMasterRef], [WorkQueuesLkup], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) VALUES (9, 3, 10051, 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
GO
INSERT [dbo].[ADM_SkillWorkQueuesCorrelation] ([ADM_SkillWorkQueuesCorrelationId], [ADM_SkillsMasterRef], [WorkQueuesLkup], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) VALUES (10, 3, 10052, 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
GO
INSERT [dbo].[ADM_SkillWorkQueuesCorrelation] ([ADM_SkillWorkQueuesCorrelationId], [ADM_SkillsMasterRef], [WorkQueuesLkup], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) VALUES (11, 3, 10053, 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
GO
INSERT [dbo].[ADM_SkillWorkQueuesCorrelation] ([ADM_SkillWorkQueuesCorrelationId], [ADM_SkillsMasterRef], [WorkQueuesLkup], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) VALUES (12, 3, 10054, 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
GO
INSERT [dbo].[ADM_SkillWorkQueuesCorrelation] ([ADM_SkillWorkQueuesCorrelationId], [ADM_SkillsMasterRef], [WorkQueuesLkup], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) VALUES (13, 3, 10055, 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
GO
INSERT [dbo].[ADM_SkillWorkQueuesCorrelation] ([ADM_SkillWorkQueuesCorrelationId], [ADM_SkillsMasterRef], [WorkQueuesLkup], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) VALUES (14, 3, 10056, 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
GO
INSERT [dbo].[ADM_SkillWorkQueuesCorrelation] ([ADM_SkillWorkQueuesCorrelationId], [ADM_SkillsMasterRef], [WorkQueuesLkup], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) VALUES (15, 3, 10057, 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
GO
INSERT [dbo].[ADM_SkillWorkQueuesCorrelation] ([ADM_SkillWorkQueuesCorrelationId], [ADM_SkillsMasterRef], [WorkQueuesLkup], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) VALUES (16, 3, 10058, 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
GO
INSERT [dbo].[ADM_SkillWorkQueuesCorrelation] ([ADM_SkillWorkQueuesCorrelationId], [ADM_SkillsMasterRef], [WorkQueuesLkup], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) VALUES (17, 4, 10001, 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
GO
INSERT [dbo].[ADM_SkillWorkQueuesCorrelation] ([ADM_SkillWorkQueuesCorrelationId], [ADM_SkillsMasterRef], [WorkQueuesLkup], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) VALUES (18, 4, 10003, 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
GO
INSERT [dbo].[ADM_SkillWorkQueuesCorrelation] ([ADM_SkillWorkQueuesCorrelationId], [ADM_SkillsMasterRef], [WorkQueuesLkup], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) VALUES (19, 4, 10004, 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
GO
INSERT [dbo].[ADM_SkillWorkQueuesCorrelation] ([ADM_SkillWorkQueuesCorrelationId], [ADM_SkillsMasterRef], [WorkQueuesLkup], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) VALUES (20, 4, 10005, 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
GO
INSERT [dbo].[ADM_SkillWorkQueuesCorrelation] ([ADM_SkillWorkQueuesCorrelationId], [ADM_SkillsMasterRef], [WorkQueuesLkup], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) VALUES (21, 4, 10006, 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
GO
INSERT [dbo].[ADM_SkillWorkQueuesCorrelation] ([ADM_SkillWorkQueuesCorrelationId], [ADM_SkillsMasterRef], [WorkQueuesLkup], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) VALUES (22, 4, 10007, 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
GO
INSERT [dbo].[ADM_SkillWorkQueuesCorrelation] ([ADM_SkillWorkQueuesCorrelationId], [ADM_SkillsMasterRef], [WorkQueuesLkup], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) VALUES (23, 4, 10008, 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
GO
INSERT [dbo].[ADM_SkillWorkQueuesCorrelation] ([ADM_SkillWorkQueuesCorrelationId], [ADM_SkillsMasterRef], [WorkQueuesLkup], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) VALUES (24, 4, 10009, 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
GO
INSERT [dbo].[ADM_SkillWorkQueuesCorrelation] ([ADM_SkillWorkQueuesCorrelationId], [ADM_SkillsMasterRef], [WorkQueuesLkup], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) VALUES (25, 4, 10010, 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
GO
INSERT [dbo].[ADM_SkillWorkQueuesCorrelation] ([ADM_SkillWorkQueuesCorrelationId], [ADM_SkillsMasterRef], [WorkQueuesLkup], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) VALUES (26, 4, 10011, 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
GO
INSERT [dbo].[ADM_SkillWorkQueuesCorrelation] ([ADM_SkillWorkQueuesCorrelationId], [ADM_SkillsMasterRef], [WorkQueuesLkup], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) VALUES (27, 4, 10012, 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
GO
INSERT [dbo].[ADM_SkillWorkQueuesCorrelation] ([ADM_SkillWorkQueuesCorrelationId], [ADM_SkillsMasterRef], [WorkQueuesLkup], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) VALUES (28, 4, 10013, 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
GO
INSERT [dbo].[ADM_SkillWorkQueuesCorrelation] ([ADM_SkillWorkQueuesCorrelationId], [ADM_SkillsMasterRef], [WorkQueuesLkup], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) VALUES (29, 4, 10014, 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
GO
INSERT [dbo].[ADM_SkillWorkQueuesCorrelation] ([ADM_SkillWorkQueuesCorrelationId], [ADM_SkillsMasterRef], [WorkQueuesLkup], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) VALUES (30, 4, 10015, 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
GO
INSERT [dbo].[ADM_SkillWorkQueuesCorrelation] ([ADM_SkillWorkQueuesCorrelationId], [ADM_SkillsMasterRef], [WorkQueuesLkup], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) VALUES (31, 5, 10016, 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
GO
INSERT [dbo].[ADM_SkillWorkQueuesCorrelation] ([ADM_SkillWorkQueuesCorrelationId], [ADM_SkillsMasterRef], [WorkQueuesLkup], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) VALUES (32, 5, 10018, 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
GO
INSERT [dbo].[ADM_SkillWorkQueuesCorrelation] ([ADM_SkillWorkQueuesCorrelationId], [ADM_SkillsMasterRef], [WorkQueuesLkup], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) VALUES (33, 5, 10019, 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
GO
INSERT [dbo].[ADM_SkillWorkQueuesCorrelation] ([ADM_SkillWorkQueuesCorrelationId], [ADM_SkillsMasterRef], [WorkQueuesLkup], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) VALUES (34, 5, 10020, 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
GO
INSERT [dbo].[ADM_SkillWorkQueuesCorrelation] ([ADM_SkillWorkQueuesCorrelationId], [ADM_SkillsMasterRef], [WorkQueuesLkup], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) VALUES (35, 5, 10021, 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
GO
INSERT [dbo].[ADM_SkillWorkQueuesCorrelation] ([ADM_SkillWorkQueuesCorrelationId], [ADM_SkillsMasterRef], [WorkQueuesLkup], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) VALUES (36, 5, 10022, 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
GO
INSERT [dbo].[ADM_SkillWorkQueuesCorrelation] ([ADM_SkillWorkQueuesCorrelationId], [ADM_SkillsMasterRef], [WorkQueuesLkup], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) VALUES (37, 5, 10023, 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
GO
INSERT [dbo].[ADM_SkillWorkQueuesCorrelation] ([ADM_SkillWorkQueuesCorrelationId], [ADM_SkillsMasterRef], [WorkQueuesLkup], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) VALUES (38, 5, 10024, 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
GO
INSERT [dbo].[ADM_SkillWorkQueuesCorrelation] ([ADM_SkillWorkQueuesCorrelationId], [ADM_SkillsMasterRef], [WorkQueuesLkup], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) VALUES (39, 5, 10025, 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
GO
INSERT [dbo].[ADM_SkillWorkQueuesCorrelation] ([ADM_SkillWorkQueuesCorrelationId], [ADM_SkillsMasterRef], [WorkQueuesLkup], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) VALUES (40, 5, 10026, 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
GO
INSERT [dbo].[ADM_SkillWorkQueuesCorrelation] ([ADM_SkillWorkQueuesCorrelationId], [ADM_SkillsMasterRef], [WorkQueuesLkup], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) VALUES (41, 5, 10027, 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
GO
INSERT [dbo].[ADM_SkillWorkQueuesCorrelation] ([ADM_SkillWorkQueuesCorrelationId], [ADM_SkillsMasterRef], [WorkQueuesLkup], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) VALUES (42, 5, 10028, 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
GO
INSERT [dbo].[ADM_SkillWorkQueuesCorrelation] ([ADM_SkillWorkQueuesCorrelationId], [ADM_SkillsMasterRef], [WorkQueuesLkup], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) VALUES (43, 5, 10029, 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
GO
INSERT [dbo].[ADM_SkillWorkQueuesCorrelation] ([ADM_SkillWorkQueuesCorrelationId], [ADM_SkillsMasterRef], [WorkQueuesLkup], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) VALUES (44, 5, 10030, 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
GO
INSERT [dbo].[ADM_SkillWorkQueuesCorrelation] ([ADM_SkillWorkQueuesCorrelationId], [ADM_SkillsMasterRef], [WorkQueuesLkup], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) VALUES (45, 5, 10031, 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
GO
INSERT [dbo].[ADM_SkillWorkQueuesCorrelation] ([ADM_SkillWorkQueuesCorrelationId], [ADM_SkillsMasterRef], [WorkQueuesLkup], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) VALUES (46, 5, 10032, 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
GO
INSERT [dbo].[ADM_SkillWorkQueuesCorrelation] ([ADM_SkillWorkQueuesCorrelationId], [ADM_SkillsMasterRef], [WorkQueuesLkup], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) VALUES (47, 6, 10033, 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
GO
INSERT [dbo].[ADM_SkillWorkQueuesCorrelation] ([ADM_SkillWorkQueuesCorrelationId], [ADM_SkillsMasterRef], [WorkQueuesLkup], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) VALUES (48, 6, 10034, 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
GO
INSERT [dbo].[ADM_SkillWorkQueuesCorrelation] ([ADM_SkillWorkQueuesCorrelationId], [ADM_SkillsMasterRef], [WorkQueuesLkup], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) VALUES (49, 6, 10036, 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
GO
INSERT [dbo].[ADM_SkillWorkQueuesCorrelation] ([ADM_SkillWorkQueuesCorrelationId], [ADM_SkillsMasterRef], [WorkQueuesLkup], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) VALUES (50, 6, 10037, 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
GO
INSERT [dbo].[ADM_SkillWorkQueuesCorrelation] ([ADM_SkillWorkQueuesCorrelationId], [ADM_SkillsMasterRef], [WorkQueuesLkup], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) VALUES (51, 6, 10038, 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
GO
INSERT [dbo].[ADM_SkillWorkQueuesCorrelation] ([ADM_SkillWorkQueuesCorrelationId], [ADM_SkillsMasterRef], [WorkQueuesLkup], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) VALUES (52, 6, 10039, 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
GO
INSERT [dbo].[ADM_SkillWorkQueuesCorrelation] ([ADM_SkillWorkQueuesCorrelationId], [ADM_SkillsMasterRef], [WorkQueuesLkup], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) VALUES (53, 6, 10040, 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
GO
INSERT [dbo].[ADM_SkillWorkQueuesCorrelation] ([ADM_SkillWorkQueuesCorrelationId], [ADM_SkillsMasterRef], [WorkQueuesLkup], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) VALUES (54, 6, 10041, 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
GO
INSERT [dbo].[ADM_SkillWorkQueuesCorrelation] ([ADM_SkillWorkQueuesCorrelationId], [ADM_SkillsMasterRef], [WorkQueuesLkup], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) VALUES (55, 6, 10042, 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
GO
INSERT [dbo].[ADM_SkillWorkQueuesCorrelation] ([ADM_SkillWorkQueuesCorrelationId], [ADM_SkillsMasterRef], [WorkQueuesLkup], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) VALUES (56, 6, 10043, 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
GO
INSERT [dbo].[ADM_SkillWorkQueuesCorrelation] ([ADM_SkillWorkQueuesCorrelationId], [ADM_SkillsMasterRef], [WorkQueuesLkup], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) VALUES (57, 6, 10044, 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
GO
INSERT [dbo].[ADM_SkillWorkQueuesCorrelation] ([ADM_SkillWorkQueuesCorrelationId], [ADM_SkillsMasterRef], [WorkQueuesLkup], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) VALUES (58, 6, 10045, 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
GO
INSERT [dbo].[ADM_SkillWorkQueuesCorrelation] ([ADM_SkillWorkQueuesCorrelationId], [ADM_SkillsMasterRef], [WorkQueuesLkup], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) VALUES (59, 6, 10046, 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
GO
INSERT [dbo].[ADM_SkillWorkQueuesCorrelation] ([ADM_SkillWorkQueuesCorrelationId], [ADM_SkillsMasterRef], [WorkQueuesLkup], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) VALUES (60, 6, 10047, 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
GO
INSERT [dbo].[ADM_SkillWorkQueuesCorrelation] ([ADM_SkillWorkQueuesCorrelationId], [ADM_SkillsMasterRef], [WorkQueuesLkup], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) VALUES (61, 6, 10048, 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
GO
INSERT [dbo].[ADM_SkillWorkQueuesCorrelation] ([ADM_SkillWorkQueuesCorrelationId], [ADM_SkillsMasterRef], [WorkQueuesLkup], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) VALUES (62, 6, 10049, 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
GO
INSERT [dbo].[ADM_SkillWorkQueuesCorrelation] ([ADM_SkillWorkQueuesCorrelationId], [ADM_SkillsMasterRef], [WorkQueuesLkup], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) VALUES (63, 6, 10050, 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
GO
INSERT [dbo].[ADM_SkillWorkQueuesCorrelation] ([ADM_SkillWorkQueuesCorrelationId], [ADM_SkillsMasterRef], [WorkQueuesLkup], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) VALUES (64, 7, 10067, 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
GO
INSERT [dbo].[ADM_SkillWorkQueuesCorrelation] ([ADM_SkillWorkQueuesCorrelationId], [ADM_SkillsMasterRef], [WorkQueuesLkup], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) VALUES (65, 7, 10068, 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
GO
INSERT [dbo].[ADM_SkillWorkQueuesCorrelation] ([ADM_SkillWorkQueuesCorrelationId], [ADM_SkillsMasterRef], [WorkQueuesLkup], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) VALUES (66, 7, 10069, 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
GO
INSERT [dbo].[ADM_SkillWorkQueuesCorrelation] ([ADM_SkillWorkQueuesCorrelationId], [ADM_SkillsMasterRef], [WorkQueuesLkup], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) VALUES (67, 7, 10070, 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
GO
INSERT [dbo].[ADM_SkillWorkQueuesCorrelation] ([ADM_SkillWorkQueuesCorrelationId], [ADM_SkillsMasterRef], [WorkQueuesLkup], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) VALUES (68, 7, 10073, 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
GO
INSERT [dbo].[ADM_SkillWorkQueuesCorrelation] ([ADM_SkillWorkQueuesCorrelationId], [ADM_SkillsMasterRef], [WorkQueuesLkup], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) VALUES (69, 7, 10074, 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
GO
INSERT [dbo].[ADM_SkillWorkQueuesCorrelation] ([ADM_SkillWorkQueuesCorrelationId], [ADM_SkillsMasterRef], [WorkQueuesLkup], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) VALUES (70, 7, 10081, 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
GO
INSERT [dbo].[ADM_SkillWorkQueuesCorrelation] ([ADM_SkillWorkQueuesCorrelationId], [ADM_SkillsMasterRef], [WorkQueuesLkup], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) VALUES (71, 7, 10071, 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
GO
INSERT [dbo].[ADM_SkillWorkQueuesCorrelation] ([ADM_SkillWorkQueuesCorrelationId], [ADM_SkillsMasterRef], [WorkQueuesLkup], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) VALUES (72, 7, 10072, 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
GO
INSERT [dbo].[ADM_SkillWorkQueuesCorrelation] ([ADM_SkillWorkQueuesCorrelationId], [ADM_SkillsMasterRef], [WorkQueuesLkup], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) VALUES (73, 7, 10075, 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
GO
INSERT [dbo].[ADM_SkillWorkQueuesCorrelation] ([ADM_SkillWorkQueuesCorrelationId], [ADM_SkillsMasterRef], [WorkQueuesLkup], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) VALUES (74, 7, 10076, 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
GO
INSERT [dbo].[ADM_SkillWorkQueuesCorrelation] ([ADM_SkillWorkQueuesCorrelationId], [ADM_SkillsMasterRef], [WorkQueuesLkup], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) VALUES (75, 7, 10077, 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
GO
INSERT [dbo].[ADM_SkillWorkQueuesCorrelation] ([ADM_SkillWorkQueuesCorrelationId], [ADM_SkillsMasterRef], [WorkQueuesLkup], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) VALUES (76, 7, 10078, 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
GO
INSERT [dbo].[ADM_SkillWorkQueuesCorrelation] ([ADM_SkillWorkQueuesCorrelationId], [ADM_SkillsMasterRef], [WorkQueuesLkup], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) VALUES (77, 7, 10082, 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
GO
INSERT [dbo].[ADM_SkillWorkQueuesCorrelation] ([ADM_SkillWorkQueuesCorrelationId], [ADM_SkillsMasterRef], [WorkQueuesLkup], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) VALUES (78, 7, 10083, 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
GO
INSERT [dbo].[ADM_SkillWorkQueuesCorrelation] ([ADM_SkillWorkQueuesCorrelationId], [ADM_SkillsMasterRef], [WorkQueuesLkup], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) VALUES (79, 7, 10084, 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
GO
INSERT [dbo].[ADM_SkillWorkQueuesCorrelation] ([ADM_SkillWorkQueuesCorrelationId], [ADM_SkillsMasterRef], [WorkQueuesLkup], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) VALUES (80, 7, 10085, 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
GO
INSERT [dbo].[ADM_SkillWorkQueuesCorrelation] ([ADM_SkillWorkQueuesCorrelationId], [ADM_SkillsMasterRef], [WorkQueuesLkup], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) VALUES (81, 7, 10086, 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
GO
INSERT [dbo].[ADM_SkillWorkQueuesCorrelation] ([ADM_SkillWorkQueuesCorrelationId], [ADM_SkillsMasterRef], [WorkQueuesLkup], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) VALUES (82, 7, 10087, 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
GO
INSERT [dbo].[ADM_SkillWorkQueuesCorrelation] ([ADM_SkillWorkQueuesCorrelationId], [ADM_SkillsMasterRef], [WorkQueuesLkup], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) VALUES (83, 7, 10079, 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
GO
INSERT [dbo].[ADM_SkillWorkQueuesCorrelation] ([ADM_SkillWorkQueuesCorrelationId], [ADM_SkillsMasterRef], [WorkQueuesLkup], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) VALUES (84, 7, 10080, 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
GO
INSERT [dbo].[ADM_SkillWorkQueuesCorrelation] ([ADM_SkillWorkQueuesCorrelationId], [ADM_SkillsMasterRef], [WorkQueuesLkup], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) VALUES (85, 7, 10088, 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
GO
INSERT [dbo].[ADM_SkillWorkQueuesCorrelation] ([ADM_SkillWorkQueuesCorrelationId], [ADM_SkillsMasterRef], [WorkQueuesLkup], [IsActive], [UTCCreatedOn], [CreatedByRef], [UTCLastUpdatedOn], [LastUpdatedByRef]) VALUES (86, 7, 10089, 1, GETUTCDATE(), 1, GETUTCDATE(), 1)
GO

SET IDENTITY_INSERT [dbo].[ADM_SkillWorkQueuesCorrelation] OFF

------------------------------------------------------------------

-----DEV
--SET IDENTITY_INSERT [dbo].[RPT_ReportsMaster] ON

--IF NOT EXISTS (SELECT * FROM [dbo].[RPT_ReportsMaster] WHERE RPT_ReportsMasterId=01 )
--BEGIN
--	INSERT INTO [dbo].[RPT_ReportsMaster]([RPT_ReportsMasterId],[ReportName],[ReportServer],[ReportURL],[ReportsCategoryLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[ViewInUI])
--	VALUES (01,N'ERS Home Page Summary Report',N'dbsed3561',N'https://rrtreportsdev.uhc.com/ReportServer/Pages/ReportViewer.aspx?%2fERS_Everyone%2frpt_ERS_01_HomePage&rs:Command=Render',42002,1,getutcdate(),1,1)

--END
--GO

--IF NOT EXISTS (SELECT * FROM [dbo].[RPT_ReportsMaster] WHERE RPT_ReportsMasterId=02 )
--BEGIN
--	INSERT INTO [dbo].[RPT_ReportsMaster]([RPT_ReportsMasterId],[ReportName],[ReportServer],[ReportURL],[ReportsCategoryLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[ViewInUI])
--	VALUES (02,N'ERS Error Log Report',N'dbsed3561',N'https://rrtreportsdev.uhc.com/ReportServer/Pages/ReportViewer.aspx?%2fERS_Everyone%2frpt_ERS_02_ErrorLog&rs:Command=Render',42002,1,getutcdate(),1,1)

--END
--GO
--IF NOT EXISTS (SELECT * FROM [dbo].[RPT_ReportsMaster] WHERE RPT_ReportsMasterId=03 )
--BEGIN
--	INSERT INTO [dbo].[RPT_ReportsMaster]([RPT_ReportsMasterId],[ReportName],[ReportServer],[ReportURL],[ReportsCategoryLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[ViewInUI])
--	VALUES (03,N'ERS Locked Records Report',N'dbsed3561',N'https://rrtreportsdev.uhc.com/ReportServer/Pages/ReportViewer.aspx?%2fERS_Everyone%2frpt_ERS_03_LockedRecords&rs:Command=Render',42002,1,getutcdate(),1,1)

--END
--GO

--IF NOT EXISTS (SELECT * FROM [dbo].[RPT_ReportsMaster] WHERE RPT_ReportsMasterId=04 )
--BEGIN
--	INSERT INTO [dbo].[RPT_ReportsMaster]([RPT_ReportsMasterId],[ReportName],[ReportServer],[ReportURL],[ReportsCategoryLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[ViewInUI])
--	VALUES (04,N'ERS Alerts Field Change Logging Report',N'dbsed3561',N'https://rrtreportsdev.uhc.com/ReportServer/Pages/ReportViewer.aspx?%2fERS_Everyone%2frpt_ERS_04_Alerts_Field_Change_Logging_Report&rs:Command=Render',42002,1,getutcdate(),1,0)

--END
--GO

--IF NOT EXISTS (SELECT * FROM [dbo].[RPT_ReportsMaster] WHERE RPT_ReportsMasterId=05 )
--BEGIN
--	INSERT INTO [dbo].[RPT_ReportsMaster]([RPT_ReportsMasterId],[ReportName],[ReportServer],[ReportURL],[ReportsCategoryLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[ViewInUI])
--	VALUES (05,N'ERS Skills Field Change Logging Report',N'dbsed3561',N'https://rrtreportsdev.uhc.com/ReportServer/Pages/ReportViewer.aspx?%2fERS_Everyone%2frpt_ERS_05_Skills_Field_Change_Logging_Report&rs:Command=Render',42002,1,getutcdate(),1,0)

--END
--GO


--SET IDENTITY_INSERT [dbo].[RPT_ReportsMaster] OFF


-----TEST
--SET IDENTITY_INSERT [dbo].[RPT_ReportsMaster] ON

--IF NOT EXISTS (SELECT * FROM [dbo].[RPT_ReportsMaster] WHERE RPT_ReportsMasterId=01 )
--BEGIN
--	INSERT INTO [dbo].[RPT_ReportsMaster]([RPT_ReportsMasterId],[ReportName],[ReportServer],[ReportURL],[ReportsCategoryLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[ViewInUI])
--	VALUES (01,N'ERS Home Page Summary Report',N'dbset1611',N'https://rrtreportstest.uhc.com/ReportServer/Pages/ReportViewer.aspx?%2fERS_Everyone%2frpt_ERS_01_HomePage&rs:Command=Render',42002,1,getutcdate(),1,1)

--END
--GO

--IF NOT EXISTS (SELECT * FROM [dbo].[RPT_ReportsMaster] WHERE RPT_ReportsMasterId=02 )
--BEGIN
--	INSERT INTO [dbo].[RPT_ReportsMaster]([RPT_ReportsMasterId],[ReportName],[ReportServer],[ReportURL],[ReportsCategoryLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[ViewInUI])
--	VALUES (02,N'ERS Error Log Report',N'dbset1611',N'https://rrtreportstest.uhc.com/ReportServer/Pages/ReportViewer.aspx?%2fERS_Everyone%2frpt_ERS_02_ErrorLog&rs:Command=Render',42002,1,getutcdate(),1,1)

--END
--GO
--IF NOT EXISTS (SELECT * FROM [dbo].[RPT_ReportsMaster] WHERE RPT_ReportsMasterId=03 )
--BEGIN
--	INSERT INTO [dbo].[RPT_ReportsMaster]([RPT_ReportsMasterId],[ReportName],[ReportServer],[ReportURL],[ReportsCategoryLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[ViewInUI])
--	VALUES (03,N'ERS Locked Records Report',N'dbset1611',N'https://rrtreportstest.uhc.com/ReportServer/Pages/ReportViewer.aspx?%2fERS_Everyone%2frpt_ERS_03_LockedRecords&rs:Command=Render',42002,1,getutcdate(),1,1)

--END
--GO

--IF NOT EXISTS (SELECT * FROM [dbo].[RPT_ReportsMaster] WHERE RPT_ReportsMasterId=04 )
--BEGIN
--	INSERT INTO [dbo].[RPT_ReportsMaster]([RPT_ReportsMasterId],[ReportName],[ReportServer],[ReportURL],[ReportsCategoryLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[ViewInUI])
--	VALUES (04,N'ERS Alerts Field Change Logging Report',N'dbset1611',N'https://rrtreportstest.uhc.com/ReportServer/Pages/ReportViewer.aspx?%2fERS_Everyone%2frpt_ERS_04_Alerts_Field_Change_Logging_Report&rs:Command=Render',42002,1,getutcdate(),1,0)

--END
--GO

--IF NOT EXISTS (SELECT * FROM [dbo].[RPT_ReportsMaster] WHERE RPT_ReportsMasterId=05 )
--BEGIN
--	INSERT INTO [dbo].[RPT_ReportsMaster]([RPT_ReportsMasterId],[ReportName],[ReportServer],[ReportURL],[ReportsCategoryLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[ViewInUI])
--	VALUES (05,N'ERS Skills Field Change Logging Report',N'dbset1611',N'https://rrtreportstest.uhc.com/ReportServer/Pages/ReportViewer.aspx?%2fERS_Everyone%2frpt_ERS_05_Skills_Field_Change_Logging_Report&rs:Command=Render',42002,1,getutcdate(),1,0)

--END
--GO

--SET IDENTITY_INSERT [dbo].[RPT_ReportsMaster] OFF