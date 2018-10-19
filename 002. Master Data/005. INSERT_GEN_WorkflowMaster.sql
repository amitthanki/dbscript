
SET IDENTITY_INSERT GEN_WorkFlowMaster ON

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 1)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (1,3001,6001,10007,28017,10015,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 2)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (2,3001,6001,10007,28015,10013,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 3)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (3,3001,6001,10007,28007,10010,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 4)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (4,3001,6001,10007,28018,10011,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 5)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (5,3001,6001,10007,28002,10004,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 6)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (6,3001,6001,10007,28001,10007,NULL,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 7)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (7,3001,6001,10006,28017,10015,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 8)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (8,3001,6001,10006,28015,10013,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 9)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (9,3001,6001,10006,28007,10010,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 10)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (10,3001,6001,10006,28018,10011,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 11)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (11,3001,6001,10006,28002,10004,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 12)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (12,3001,6001,10006,28001,10006,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 13)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (13,3001,6001,10009,28014,10012,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 14)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (14,3001,6001,10009,28007,10010,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 15)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (15,3001,6001,10009,28002,10004,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 16)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (16,3001,6001,10009,28001,10009,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 17)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (17,3001,6001,10008,28003,10012,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 18)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (18,3001,6001,10008,28007,10010,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 19)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (19,3001,6001,10008,28002,10004,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 20)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (20,3001,6001,10008,28001,10008,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 21)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (21,3001,6001,10013,28008,10013,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 22)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (22,3001,6001,10013,28007,10010,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 23)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (23,3001,6001,10013,28002,10004,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 24)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (24,3001,6001,10013,28001,10013,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 25)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (25,3001,6001,10012,28008,10012,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 26)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (26,3001,6001,10012,28007,10010,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 27)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (27,3001,6001,10012,28002,10004,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 28)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (28,3001,6001,10012,28001,10012,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 29)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (29,3001,6001,10011,28006,NULL,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 30)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (30,3001,6001,10011,28007,10010,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 31)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (31,3001,6001,10011,28002,10004,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 32)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (32,3001,6001,10011,28001,10011,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 33)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (33,3001,6001,10014,NULL,10015,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 34)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (34,3001,6001,10015,28049,10002,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 35)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (35,3001,6001,10015,28050,10004,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 36)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (36,3001,6001,10013,NULL,10009,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 37)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (37,3001,6001,10012,28052,10005,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 38)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (38,3001,6001,10005,NULL,10001,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 39)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (39,3001,6001,10001,NULL,10012,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 40)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (40,3001,6001,10012,28056,10008,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 41)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (41,3001,6002,10022,28017,10032,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 42)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (42,3001,6002,10022,28015,10019,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 43)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (43,3001,6002,10022,28007,10025,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 44)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (44,3001,6002,10022,28018,10026,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 45)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (45,3001,6002,10022,28002,10019,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 46)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (46,3001,6002,10022,28001,10022,NULL,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 47)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (47,3001,6002,10022,28016,10019,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 48)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (48,3001,6002,10022,28026,10019,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 49)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (49,3001,6002,10022,28012,10029,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 50)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (50,3001,6002,10021,28017,10032,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 51)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (51,3001,6002,10021,28015,10019,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 52)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (52,3001,6002,10021,28007,10025,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 53)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (53,3001,6002,10021,28018,10026,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 54)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (54,3001,6002,10021,28002,10019,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 55)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (55,3001,6002,10021,28001,10021,NULL,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 56)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (56,3001,6002,10021,28016,10019,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 57)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (57,3001,6002,10021,28026,10019,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 58)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (58,3001,6002,10021,28012,10029,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 59)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (59,3001,6002,10024,28014,10027,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 60)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (60,3001,6002,10024,28007,10025,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 61)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (61,3001,6002,10024,28002,10019,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 62)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (62,3001,6002,10024,28001,10024,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 63)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (63,3001,6002,10023,28003,10027,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 64)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (64,3001,6002,10023,28007,10025,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 65)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (65,3001,6002,10023,28002,10019,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 66)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (66,3001,6002,10023,28001,10023,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 67)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (67,3001,6002,10028,28008,10028,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 68)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (68,3001,6002,10028,28007,10025,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 69)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (69,3001,6002,10028,28002,10019,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 70)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (70,3001,6002,10028,28001,10028,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 71)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (71,3001,6002,10027,28008,10027,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 72)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (72,3001,6002,10027,28007,10025,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 73)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (73,3001,6002,10027,28002,10019,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 74)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (74,3001,6002,10027,28001,10027,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 75)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (75,3001,6002,10026,28006,NULL,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 76)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (76,3001,6002,10026,28007,10025,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 77)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (77,3001,6002,10026,28002,10019,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 78)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (78,3001,6002,10026,28001,10026,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 79)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (79,3001,6002,10031,NULL,10032,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 80)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (80,3001,6002,10032,28049,10017,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 81)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (81,3001,6002,10032,28050,10019,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 82)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (82,3001,6002,10028,NULL,10024,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 83)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (83,3001,6002,10027,28052,10020,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 84)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (84,3001,6002,10020,NULL,10016,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 85)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (85,3001,6002,10016,NULL,10027,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 86)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (86,3001,6002,10027,28056,10023,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 87)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (87,3001,6003,10042,28006,NULL,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 88)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (88,3001,6003,10042,28007,10090,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 89)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (89,3001,6003,10042,28002,10036,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 90)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (90,3001,6003,10042,28001,10042,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 91)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (91,3001,6003,10042,28015,10036,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 92)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (92,3001,6003,10033,28043,10043,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 93)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (93,3001,6003,10033,28029,10036,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 94)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (94,3001,6003,10033,28026,10036,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 95)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (95,3001,6003,10033,28017,10049,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 96)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (96,3001,6003,10033,28012,10091,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 97)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (97,3001,6003,10033,28007,10090,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 98)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (98,3001,6003,10033,28018,10042,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 99)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (99,3001,6003,10033,28002,10036,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 100)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (100,3001,6003,10033,28001,10033,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 101)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (101,3001,6003,10033,28015,10036,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 102)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (102,3001,6003,10034,28026,10036,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 103)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (103,3001,6003,10034,28042,10049,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 104)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (104,3001,6003,10034,28017,10049,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 105)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (105,3001,6003,10034,28012,10091,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 106)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (106,3001,6003,10034,28007,10090,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 107)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (107,3001,6003,10034,28018,10042,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 108)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (108,3001,6003,10034,28002,10036,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 109)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (109,3001,6003,10034,28001,10034,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 110)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (110,3001,6003,10034,28015,10036,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 111)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (111,3001,6003,10037,28017,10049,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 112)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (112,3001,6003,10037,28007,10090,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 113)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (113,3001,6003,10037,28018,10042,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 114)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (114,3001,6003,10037,28002,10036,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 115)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (115,3001,6003,10037,28001,10037,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 116)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (116,3001,6003,10037,28015,10036,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 117)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (117,3001,6003,10046,28026,10036,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 118)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (118,3001,6003,10046,28042,10049,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 119)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (119,3001,6003,10046,28017,10049,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 120)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (120,3001,6003,10046,28012,10091,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 121)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (121,3001,6003,10046,28007,10090,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 122)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (122,3001,6003,10046,28018,10042,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 123)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (123,3001,6003,10046,28002,10036,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 124)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (124,3001,6003,10046,28001,10046,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 125)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (125,3001,6003,10046,28015,10036,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 126)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (126,3001,6003,10048,28026,10036,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 127)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (127,3001,6003,10048,28042,10049,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 128)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (128,3001,6003,10048,28017,10049,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 129)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (129,3001,6003,10048,28012,10091,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 130)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (130,3001,6003,10048,28007,10090,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 131)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (131,3001,6003,10048,28018,10042,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 132)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (132,3001,6003,10048,28002,10036,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 133)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (133,3001,6003,10048,28001,10048,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 134)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (134,3001,6003,10048,28015,10036,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 135)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (135,3001,6003,10045,28007,10090,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 136)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (136,3001,6003,10045,28018,10042,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 137)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (137,3001,6003,10045,28002,10036,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 138)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (138,3001,6003,10045,28001,10045,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 139)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (139,3001,6003,10045,28015,10036,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 140)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (140,3001,6003,10047,28007,10090,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 141)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (141,3001,6003,10047,28018,10042,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 142)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (142,3001,6003,10047,28002,10036,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 143)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (143,3001,6003,10047,28001,10047,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 144)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (144,3001,6003,10047,28015,10036,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 145)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (145,3001,6003,10043,NULL,10049,NULL,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 146)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (146,3001,6003,10049,NULL,NULL,NULL,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 147)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (147,3001,6003,10049,NULL,NULL,NULL,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 148)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (148,3002,6004,10054,28025,10058,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 149)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (149,3002,6004,10054,28027,10053,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 150)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (150,3002,6004,10054,28007,10055,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 151)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (151,3002,6004,10054,28018,10056,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 152)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (152,3002,6004,10054,28028,10053,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 153)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (153,3002,6004,10054,28002,10053,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 154)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (154,3002,6004,10054,28001,10054,NULL,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 155)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (155,3002,6004,10056,28006,10054,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 156)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (156,3002,6004,10056,28001,10056,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 157)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (157,3002,6004,10056,28007,10055,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 158)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (158,3002,6004,10057,NULL,10058,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 159)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (159,3002,6004,10058,28049,10051,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 160)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (160,3002,6004,10058,28050,10053,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 161)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (161,3002,6005,10060,28007,10061,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 162)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (162,3002,6005,10060,28018,10062,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 163)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (163,3002,6005,10060,28072,10059,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 164)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (164,3002,6005,10060,28001,10060,NULL,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 165)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (165,3002,6005,10060,28026,10059,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 166)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (166,3002,6005,10062,28006,10060,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 167)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (167,3002,6005,10062,28007,10061,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 168)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (168,3002,6005,10062,28072,10059,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 169)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (169,3002,6005,10062,28001,10062,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 170)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (170,3002,6005,10062,28026,10059,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 171)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (171,3002,6006,10064,28007,10065,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 172)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (172,3002,6006,10064,28018,10066,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 173)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (173,3002,6006,10064,28072,10063,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 174)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (174,3002,6006,10064,28001,10064,NULL,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 175)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (175,3002,6006,10064,28026,10063,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 176)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (176,3002,6006,10066,28006,10064,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 177)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (177,3002,6006,10066,28007,10065,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 178)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (178,3002,6006,10066,28072,10063,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 179)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (179,3002,6006,10066,28001,10066,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 180)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (180,3002,6006,10066,28026,10063,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 181)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (181,3003,6007,10076,28018,10073,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 182)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (182,3003,6007,10076,28027,10069,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 183)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (183,3003,6007,10076,28007,10081,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 184)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (184,3003,6007,10076,28002,10069,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 185)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (185,3003,6007,10076,28001,10076,NULL,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 186)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (186,3003,6007,10077,28018,10073,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 187)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (187,3003,6007,10077,28027,10069,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 188)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (188,3003,6007,10077,28007,10081,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 189)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (189,3003,6007,10077,28002,10069,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 190)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (190,3003,6007,10077,28001,10077,NULL,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 191)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (191,3003,6007,10074,28018,10073,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 192)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (192,3003,6007,10074,28027,10069,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 193)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (193,3003,6007,10074,28007,10081,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 194)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (194,3003,6007,10074,28002,10069,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 195)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (195,3003,6007,10074,28001,10074,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 196)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (196,3003,6007,10073,28006,NULL,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 197)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (197,3003,6007,10073,28027,10069,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 198)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (198,3003,6007,10073,28007,10081,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 199)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (199,3003,6007,10073,28002,10069,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 200)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (200,3003,6007,10073,28001,10073,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 201)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (201,3003,6007,10079,28019,10071,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 202)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (202,3003,6007,10079,28027,10069,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 203)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (203,3003,6007,10079,28007,10081,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 204)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (204,3003,6007,10079,28002,10069,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 205)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (205,3003,6007,10079,28001,10079,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 206)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (206,3003,6007,10080,28021,10067,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 207)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (207,3003,6007,10080,28027,10069,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 208)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (208,3003,6007,10080,28007,10081,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 209)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (209,3003,6007,10080,28002,10069,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 210)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (210,3003,6007,10080,28001,10080,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 211)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (211,3003,6007,10067,28019,10071,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 212)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (212,3003,6007,10067,28010,10075,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 213)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (213,3003,6007,10067,28027,10069,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 214)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (214,3003,6007,10067,28007,10081,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 215)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (215,3003,6007,10067,28002,10069,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 216)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (216,3003,6007,10067,28001,10067,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 217)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (217,3003,6007,10071,28010,10075,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 218)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (218,3003,6007,10071,28027,10069,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 219)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (219,3003,6007,10071,28007,10081,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 220)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (220,3003,6007,10071,28002,10069,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 221)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (221,3003,6007,10071,28001,10071,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 222)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (222,3003,6007,10071,28004,10069,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 223)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (223,3003,6007,10075,28023,10078,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 224)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (224,3003,6007,10075,28027,10069,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 225)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (225,3003,6007,10075,28007,10081,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 226)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (226,3003,6007,10075,28002,10069,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 227)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (227,3003,6007,10075,28001,10075,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 228)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (228,3003,6007,10087,28027,10069,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 229)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (229,3003,6007,10087,28007,10081,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 230)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (230,3003,6007,10087,28002,10069,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 231)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (231,3003,6007,10087,28001,10087,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 232)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (232,3003,6007,10087,28044,10071,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 233)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (233,3003,6007,10070,28013,10085,20001,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 234)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (234,3003,6007,10070,28007,10081,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 235)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (235,3003,6007,10070,28001,10070,NULL,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 236)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (236,3003,6007,10070,28011,10069,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 237)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (237,3003,6007,10072,28005,10085,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 238)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (238,3003,6007,10072,28007,10081,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 239)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (239,3003,6007,10072,28001,10072,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 240)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (240,3003,6007,10072,28011,10069,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 241)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (241,3003,6007,10085,28020,10082,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 242)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (242,3003,6007,10085,28007,10081,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 243)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (243,3003,6007,10085,28001,10085,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 244)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (244,3003,6007,10085,28011,10069,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 245)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (245,3003,6007,10084,28007,10081,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 246)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (246,3003,6007,10084,28001,10084,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 247)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (247,3003,6007,10084,28011,10069,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 248)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (248,3003,6007,10084,28045,10082,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 249)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (249,3003,6007,10082,28004,10069,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 250)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (250,3003,6007,10082,28024,10086,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 251)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (251,3003,6007,10082,28007,10081,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 252)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (252,3003,6007,10082,28001,10082,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 253)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (253,3003,6007,10082,28011,10069,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 254)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (254,3003,6007,10082,28009,10083,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 255)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (255,3003,6007,10082,28041,10082,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 256)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (256,3003,6007,10086,28024,10086,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 257)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (257,3003,6007,10086,28022,10086,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 258)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (258,3003,6007,10086,28007,10081,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 259)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (259,3003,6007,10086,28001,10086,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 260)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (260,3003,6007,10086,28011,10069,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 261)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (261,3001,6001,10005,28046,10012,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 262)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (262,3001,6001,10005,28007,10010,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 263)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (263,3001,6001,10005,28002,10004,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 264)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (264,3001,6001,10005,28001,10005,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 265)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (265,3001,6001,10001,28047,10012,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 266)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (266,3001,6001,10001,28007,10010,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 267)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (267,3001,6001,10001,28002,10004,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 268)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (268,3001,6001,10001,28001,10001,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 269)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (269,3001,6002,10020,28046,10027,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 270)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (270,3001,6002,10020,28007,10025,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 271)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (271,3001,6002,10020,28002,10019,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 272)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (272,3001,6002,10020,28001,10020,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 273)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (273,3001,6002,10016,28047,10027,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 274)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (274,3001,6002,10016,28007,10025,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 275)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (275,3001,6002,10016,28002,10019,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 276)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (276,3001,6002,10016,28001,10016,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 277)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (277,3001,6003,10103,28014,10104,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 278)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (278,3001,6003,10103,28007,10090,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 279)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (279,3001,6003,10103,28002,10036,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 280)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (280,3001,6003,10103,28001,10103,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 281)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (281,3001,6003,10102,28003,10104,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 282)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (282,3001,6003,10102,28007,10090,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 283)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (283,3001,6003,10102,28002,10036,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 284)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (284,3001,6003,10102,28001,10102,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 285)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (285,3001,6003,10041,28008,10041,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 286)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (286,3001,6003,10041,28007,10090,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 287)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (287,3001,6003,10041,28002,10036,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 288)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (288,3001,6003,10041,28001,10041,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 289)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (289,3001,6003,10104,28008,10104,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 290)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (290,3001,6003,10104,28007,10090,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 291)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (291,3001,6003,10104,28002,10036,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 292)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (292,3001,6003,10104,28001,10104,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 293)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (293,3001,6003,10040,28046,10104,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 294)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (294,3001,6003,10040,28007,10090,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 295)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (295,3001,6003,10040,28002,10036,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 296)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (296,3001,6003,10040,28001,10040,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 297)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (297,3001,6003,10100,28047,10104,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 298)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (298,3001,6003,10100,28007,10090,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 299)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (299,3001,6003,10100,28002,10036,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 300)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (300,3001,6003,10100,28001,10100,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 301)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (301,3001,6001,10094,28001,10094,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 302)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (302,3001,6001,10094,28002,10004,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 303)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (303,3001,6001,10094,28007,10010,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 304)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (304,3001,6001,10094,28018,10011,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 305)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (305,3001,6002,10095,28001,10095,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 306)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (306,3001,6002,10095,28002,10019,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 307)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (307,3001,6002,10095,28007,10025,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 308)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (308,3001,6002,10095,28018,10026,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 309)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (309,3001,6003,10096,28001,10096,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 310)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (310,3001,6003,10096,28002,10036,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 311)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (311,3001,6003,10096,28007,10090,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 312)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (312,3001,6003,10096,28018,10042,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 313)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (313,3002,6004,10097,28001,10097,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 314)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (314,3002,6004,10097,28002,10053,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 315)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (315,3002,6004,10097,28007,10055,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 316)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (316,3002,6004,10097,28018,10056,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 317)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (317,3002,6005,10099,28001,10099,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 318)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (318,3002,6005,10099,28072,10059,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 319)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (319,3002,6005,10099,28007,10061,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 320)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (320,3002,6005,10099,28018,10062,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 321)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (321,3002,6006,10098,28001,10098,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 322)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (322,3002,6006,10098,28072,10063,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 323)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (323,3002,6006,10098,28007,10065,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 324)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (324,3002,6006,10098,28018,10066,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 325)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (325,3002,6004,10056,28001,10056,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 326)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (326,3002,6004,10056,28007,10055,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 327)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (327,3002,6004,10054,28054,10105,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 328)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (328,3002,6004,10054,28055,10053,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 329)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (329,3001,6001,10013,28051,10009,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 330)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (330,3001,6002,10028,28051,10024,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 331)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (331,3001,6003,10041,28051,10103,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 332)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (332,3001,6003,10104,28056,10102,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 333)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (333,3001,6003,10104,28052,10040,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 334)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (334,3001,6001,10012,28053,10001,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 335)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (335,3001,6002,10027,28053,10016,20002,1,GETUTCDATE(),1)
END
GO
IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 336)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (336,3001,6001,10004,28057,10004,20003,1,GETUTCDATE(),1)
END
GO
IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 337)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (337,3001,6001,10004,28058,10004,20003,1,GETUTCDATE(),1)
END
GO
IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 338)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (338,3001,6002,10019,28057,10019,20003,1,GETUTCDATE(),1)
END
GO
IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 339)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (339,3001,6002,10019,28058,10019,20003,1,GETUTCDATE(),1)
END
GO
IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 340)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (340,3001,6003,10036,28057,10036,20003,1,GETUTCDATE(),1)
END
GO
IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 341)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (341,3001,6003,10036,28058,10036,20003,1,GETUTCDATE(),1)
END
GO
IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 342)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (342,3002,6004,10053,28057,10053,20003,1,GETUTCDATE(),1)
END
GO
IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 343)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (343,3002,6004,10053,28058,10053,20003,1,GETUTCDATE(),1)
END
GO
IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 344)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (344,3002,6005,10059,28057,10059,20003,1,GETUTCDATE(),1)
END
GO
IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 345)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (345,3002,6005,10059,28058,10059,20003,1,GETUTCDATE(),1)
END
GO
IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 346)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (346,3002,6006,10063,28057,10063,20003,1,GETUTCDATE(),1)
END
GO
IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 347)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (347,3002,6006,10063,28058,10063,20003,1,GETUTCDATE(),1)
END
GO
IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 348)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (348,3003,6007,10069,28057,10069,20003,1,GETUTCDATE(),1)
END
GO
IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 349)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (349,3003,6007,10069,28058,10069,20003,1,GETUTCDATE(),1)
END
GO
IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 350)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (350,3002,6004,10052,28001,10052,NULL,1,GETUTCDATE(),1)
END
GO
IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 351)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (351,3002,6004,10052,28007,10055,NULL,1,GETUTCDATE(),1)
END
GO
IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 352)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (352,3002,6004,10052,28025,10058,NULL,1,GETUTCDATE(),1)
END
GO
IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 353)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (353,3002,6004,10052,28018,10056,NULL,1,GETUTCDATE(),1)
END
GO
IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 354)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (354,3002,6004,10052,28027,10053,NULL,1,GETUTCDATE(),1)
END
GO
IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 355)
BEGIN
	INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
	VALUES (355,3002,6004,10054,28065,10053,20003,1,GETUTCDATE(),1)
END
GO
IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 356)
BEGIN
	INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
	VALUES (356,3003,6007,10106,28066,10076,20002,1,GETUTCDATE(),1)
END
GO
IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 357)
BEGIN
	INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
	VALUES (357,3003,6007,10106,28067,10077,20002,1,GETUTCDATE(),1)
END
GO
IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 358)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (358,3001,6001,10007,28068,10013,20002,1,GETUTCDATE(),1)
END
GO
IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 359)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (359,3001,6001,10006,28068,10013,20002,1,GETUTCDATE(),1)
END
GO
IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 360)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (360,3001,6002,10022,28068,10019,20003,1,GETUTCDATE(),1)
END
GO
IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 361)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (361,3001,6002,10021,28068,10019,20003,1,GETUTCDATE(),1)
END
GO
IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 362)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (362,3001,6003,10042,28068,10036,20003,1,GETUTCDATE(),1)
END
GO
IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 363)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (363,3001,6003,10033,28068,10036,20003,1,GETUTCDATE(),1)
END
GO
IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 364)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (364,3001,6003,10034,28068,10036,20003,1,GETUTCDATE(),1)
END
GO
IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 365)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (365,3001,6003,10037,28068,10036,20003,1,GETUTCDATE(),1)
END
GO
IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 366)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (366,3001,6003,10046,28068,10036,20003,1,GETUTCDATE(),1)
END
GO
IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 367)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (367,3001,6003,10048,28068,10036,20003,1,GETUTCDATE(),1)
END
GO
IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 368)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (368,3001,6003,10045,28068,10036,20003,1,GETUTCDATE(),1)
END
GO
IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 369)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (369,3001,6003,10047,28068,10036,20003,1,GETUTCDATE(),1)
END
GO
IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 370)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (370,3001,6001,10006,28069,10013,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 371)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (371,3001,6001,10006,28070,10012,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 372)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (372,3001,6002,10021,28069,10028,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 373)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (373,3001,6002,10021,28070,10027,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 374)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (374,3001,6001,10012,28017,10015,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 375)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (375,3001,6001,10013,28017,10015,20002,1,GETUTCDATE(),1)
END
GO


IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 376)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (376,3003,6007,10072,28071,10072,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 377)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (377,3003,6007,10071,28071,10071,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 378)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (378,3003,6007,10087,28071,10087,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 379)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (379,3003,6007,10067,28071,10067,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 380)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (380,3003,6007,10080,28071,10080,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 381)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (381,3003,6007,10079,28071,10079,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 382)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (382,3003,6007,10077,28071,10077,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 383)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (383,3003,6007,10076,28071,10076,20002,1,GETUTCDATE(),1)
END
GO
IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 384)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (384,3001,6001,10007,28012,10107,20002,1,GETUTCDATE(),1)
END
GO
IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 385)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (385,3001,6001,10006,28012,10107,20002,1,GETUTCDATE(),1)
END
GO
IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 386)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (386,3001,6001,10001,28018,10011,20002,1,GETUTCDATE(),1)
END
GO
IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 387)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (387,3001,6001,10007,28074,10007,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 388)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (388,3001,6001,10006,28074,10006,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 389)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (389,3001,6001,10009,28074,10009,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 390)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (390,3001,6001,10008,28074,10008,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 391)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (391,3001,6001,10011,28074,10011,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 392)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (392,3001,6001,10094,28074,10094,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 393)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (393,3001,6001,10005,28074,10005,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 394)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (394,3001,6001,10001,28074,10001,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 395)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (395,3001,6001,10013,28074,10013,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 396)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (396,3001,6001,10012,28074,10012,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 397)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (397,3001,6003,10108,28026,10036,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 398)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (398,3001,6003,10108,28042,10049,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 399)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (399,3001,6003,10108,28017,10049,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 400)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (400,3001,6003,10108,28012,10091,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 401)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (401,3001,6003,10108,28007,10090,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 402)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (402,3001,6003,10108,28018,10042,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 403)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (403,3001,6003,10108,28002,10036,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 404)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (404,3001,6003,10108,28001,10046,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 405)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (405,3001,6003,10108,28015,10036,20003,1,GETUTCDATE(),1)
END
GO
IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 406)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (406,3001,6003,10108,28068,10036,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 407)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (407,3001,6001,10001,28017,10015,20002,1,GETUTCDATE(),1)
END
GO


IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 408)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (408,3001,6001,10012,28017,10015,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 409)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (409,3001,6001,10005,28017,10015,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 410)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (410,3001,6001,10008,28017,10015,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 411)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (411,3001,6001,10009,28017,10015,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 412)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (412,3001,6001,10009,28012,10107,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 413)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (413,3001,6001,10008,28012,10107,20002,1,GETUTCDATE(),1)
END
GO
IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 414)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (414,3001,6001,10005,28012,10107,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 415)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (415,3001,6001,10001,28012,10107,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 416)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (416,3001,6003,10047,28012,10091,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 417)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (417,3001,6003,10037,28012,10091,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 418)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (418,3001,6001,10014,28002,10004,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 419)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (419,3001,6001,10015,28002,10004,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 420)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (420,3001,6003,10043,28002,10036,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 421)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (421,3001,6003,10044,28002,10036,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 422)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (422,3001,6003,10049,28002,10036,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 423)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (423,3001,6002,10031,28002,10019,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 424)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (424,3001,6002,10032,28002,10019,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 425)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (425,3001,6003,10050,28002,10036,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 426)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (426,3003,6007,10109,28002,10069,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 427)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (427,3003,6007,10109,28066,10076,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 428)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (428,3003,6007,10109,28067,10077,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 429)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (429,3003,6007,10109,28007,10081,20002,1,GETUTCDATE(),1)
END
GO


IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 430)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (430,3003,6007,10110,28018,10073,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 431)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (431,3003,6007,10110,28027,10069,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 432)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (432,3003,6007,10110,28007,10081,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 433)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (433,3003,6007,10110,28002,10069,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 434)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (434,3003,6007,10110,28001,10110,NULL,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 435)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (435,3001,6003,10039,28007,10090,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 436)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (436,3001,6003,10039,28018,10042,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 437)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (437,3001,6003,10039,28002,10036,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 438)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (438,3001,6003,10039,28001,10047,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 439)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (439,3001,6003,10039,28015,10036,20003,1,GETUTCDATE(),1)
END
GO
IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 440)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (440,3001,6003,10039,28068,10036,20003,1,GETUTCDATE(),1)
END
GO
IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 441)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (441,3001,6003,10039,28012,10091,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 442)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (442,3001,6001,10014,28001,10014,NULL,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 443)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (443,3001,6001,10015,28001,10015,NULL,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 444)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (444,3001,6002,10031,28001,10031,NULL,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 445)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (445,3001,6002,10032,28001,10032,NULL,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 446)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (446,3001,6001,10013,28012,10107,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 447)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (447,3001,6001,10012,28012,10107,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 448)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (448,3001,6003,10033,28080,10036,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 449)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (449,3001,6003,10033,28081,10036,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 450)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (450,3001,6003,10033,28082,10036,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 451)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (451,3001,6003,10033,28083,10036,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 452)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (452,3001,6003,10034,28080,10036,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 453)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (453,3001,6003,10034,28081,10036,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 454)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (454,3001,6003,10034,28082,10036,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 455)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (455,3001,6003,10034,28083,10036,20003,1,GETUTCDATE(),1)
END
GO


IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 456)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (456,3001,6003,10046,28080,10036,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 457)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (457,3001,6003,10046,28081,10036,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 458)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (458,3001,6003,10046,28082,10036,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 459)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (459,3001,6003,10046,28083,10036,20003,1,GETUTCDATE(),1)
END
GO


IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 460)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (460,3001,6003,10108,28080,10036,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 461)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (461,3001,6003,10108,28081,10036,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 462)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (462,3001,6003,10108,28082,10036,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 463)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (463,3001,6003,10108,28083,10036,20003,1,GETUTCDATE(),1)
END
GO


IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 464)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (464,3001,6003,10047,28080,10036,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 465)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (465,3001,6003,10047,28081,10036,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 466)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (466,3001,6003,10047,28082,10036,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 467)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (467,3001,6003,10047,28083,10036,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 468)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (468,3001,6003,10048,28080,10036,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 469)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (469,3001,6003,10048,28081,10036,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 470)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (470,3001,6003,10048,28082,10036,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 471)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (471,3001,6003,10048,28083,10036,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 472)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (472,3001,6003,10039,28080,10036,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 473)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (473,3001,6003,10039,28081,10036,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 474)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (474,3001,6003,10039,28082,10036,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 475)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (475,3001,6003,10039,28083,10036,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 476)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (476,3001,6003,10037,28080,10036,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 477)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (477,3001,6003,10037,28081,10036,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 478)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (478,3001,6003,10037,28082,10036,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 479)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (479,3001,6003,10037,28083,10036,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 480)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (480,3001,6002,10032,28085,10022,20001,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 481)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (481,3001,6002,10022,28086,10111,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 482)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (482,3001,6002,10021,28086,10111,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 483)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (483,3001,6002,10111,28001,10111,NULL,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 484)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (484,3001,6002,10111,28002,10019,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 485)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (485,3001,6002,10111,28007,10025,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 486)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (486,3001,6002,10111,28012,10029,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 487)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (487,3001,6002,10111,28015,10019,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 488)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (488,3001,6002,10111,28016,10019,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 489)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (489,3001,6002,10111,28017,10032,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 490)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (490,3001,6002,10111,28018,10026,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 491)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (491,3001,6002,10111,28026,10019,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 492)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (492,3001,6002,10022,28087,10112,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 493)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (493,3001,6002,10021,28087,10112,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 494)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (494,3001,6002,10112,28001,10112,NULL,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 495)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (495,3001,6002,10112,28002,10019,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 496)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (496,3001,6002,10112,28007,10025,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 497)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (497,3001,6002,10112,28012,10029,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 498)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (498,3001,6002,10112,28015,10019,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 499)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (499,3001,6002,10112,28016,10019,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 500)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (500,3001,6002,10112,28017,10032,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 501)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (501,3001,6002,10112,28018,10026,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 502)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (502,3001,6002,10112,28026,10019,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 503)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (503,3001,6002,10113,28012,10029,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 504)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (504,3001,6002,10113,28001,10113,NULL,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 505)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (505,3001,6002,10113,28002,10019,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 506)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (506,3001,6002,10113,28007,10025,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 507)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (507,3001,6002,10113,28015,10019,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 508)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (508,3001,6002,10113,28016,10019,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 509)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (509,3001,6002,10113,28017,10032,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 510)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (510,3001,6002,10113,28018,10026,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 511)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (511,3001,6002,10113,28026,10019,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 512)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (512,3001,6001,10114,28001,10114,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 513)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (513,3001,6001,10114,28002,10004,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 514)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (514,3001,6001,10115,28001,10115,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 515)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (515,3001,6001,10115,28002,10004,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 516)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (516,3001,6002,10116,28001,10116,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 517)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (517,3001,6002,10116,28002,10019,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 518)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (518,3001,6003,10117,28001,10117,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 519)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (519,3001,6003,10117,28002,10036,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 520)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (520,3001,6003,10044,28042,10049,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 521)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (521,3001,6003,10043,28042,10049,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 522)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (522,3001,6001,10009,28008,10009,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 523)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (523,3001,6002,10112,28086,10111,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 524)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (524,3001,6002,10111,28087,10112,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 525)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (525,3001,6002,10113,28087,10112,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 526)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (526,3001,6001,10114,28012,10107,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 527)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (527,3001,6001,10114,28068,10013,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 528)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (528,3001,6001,10114,28015,10013,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 529)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (529,3001,6001,10114,28017,10015,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 530)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (530,3001,6001,10114,28008,10114,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 531)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (531,3001,6001,10115,28012,10107,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 532)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (532,3001,6001,10115,28068,10013,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 533)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (533,3001,6001,10115,28015,10013,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 534)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (534,3001,6001,10115,28017,10015,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 535)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (535,3001,6001,10115,28008,10115,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 536)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (536,3001,6002,10116,28015,10019,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 537)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (537,3001,6002,10116,28017,10032,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 538)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (538,3001,6002,10116,28087,10112,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 539)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (539,3001,6002,10116,28086,10111,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 540)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (540,3001,6002,10116,28026,10019,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 541)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (541,3001,6001,10012,28018,10011,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 542)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (542,3001,6001,10013,28018,10011,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 543)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (543,3003,6007,10106,28001,10106,20002,1,GETUTCDATE(),1)
END
GO
IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 544)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (544,3001,6002,10022,28088,10031,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 545)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (545,3001,6002,10031,28017,10032,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 546)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (546,3001,6001,10013,28068,10013,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 547)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (547,3001,6003,10033,28049,10092,20003,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 548)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (548,3001,6001,10115,28007,10010,20002,1,GETUTCDATE(),1)
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.GEN_WorkFlowMaster WHERE GEN_WorkFlowMasterId = 549)
BEGIN
    INSERT INTO [dbo].[GEN_WorkFlowMaster] ([GEN_WorkFlowMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[CurrentWorkQueueLkup],[CurrentActionLkup],[NextWorkQueueLkup],[NextStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef])
    VALUES (549,3001,6001,10115,28018,10011,20002,1,GETUTCDATE(),1)
END
GO

SET IDENTITY_INSERT GEN_WorkFlowMaster OFF