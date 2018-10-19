IF NOT EXISTS (Select 1 from [dbo].[CMN_LookupType] where [CMN_LookupTypeId] = 1)
BEGIN
    INSERT INTO dbo.CMN_LookupType(CMN_LookupTypeId, LookupTypeDescription, IsActive, UTCCreatedOn, CreatedByRef, UTCLastUpdatedOn, LastUpdatedByRef)
    VALUES (1,'Business Segment', 1, GETUTCDATE(), 1, GETUTCDATE(), 1)

    INSERT INTO dbo.CMN_LookupTypeHistory(CMN_LookupTypeRef, LookupTypeDescription, IsActive, UTCCreatedOn, CreatedByRef, UTCLastUpdatedOn, LastUpdatedByRef, UTCHistoryCreatedOn, HistoryCreatedByRef,SaveAttempt)
    Select CMN_LookupTypeId, LookupTypeDescription, IsActive, UTCCreatedOn, CreatedByRef, UTCLastUpdatedOn, LastUpdatedByRef,GETUTCDATE(),1,0 From CMN_LookupType Where CMN_LookupTypeId = 1
END
GO

IF NOT EXISTS (Select 1 from [dbo].[CMN_LookupType] where [CMN_LookupTypeId] = 2)
BEGIN
    INSERT INTO dbo.CMN_LookupType(CMN_LookupTypeId, LookupTypeDescription, IsActive, UTCCreatedOn, CreatedByRef, UTCLastUpdatedOn, LastUpdatedByRef)
    VALUES (2,'Role', 1, GETUTCDATE(), 1, GETUTCDATE(), 1)

    INSERT INTO dbo.CMN_LookupTypeHistory(CMN_LookupTypeRef, LookupTypeDescription, IsActive, UTCCreatedOn, CreatedByRef, UTCLastUpdatedOn, LastUpdatedByRef, UTCHistoryCreatedOn, HistoryCreatedByRef,SaveAttempt)
    Select CMN_LookupTypeId, LookupTypeDescription, IsActive, UTCCreatedOn, CreatedByRef, UTCLastUpdatedOn, LastUpdatedByRef,GETUTCDATE(),1,0 From CMN_LookupType Where CMN_LookupTypeId = 2
END
GO

IF NOT EXISTS (Select 1 from [dbo].[CMN_LookupType] where [CMN_LookupTypeId] = 3)
BEGIN
    INSERT INTO dbo.CMN_LookupType(CMN_LookupTypeId, LookupTypeDescription, IsActive, UTCCreatedOn, CreatedByRef, UTCLastUpdatedOn, LastUpdatedByRef)
    VALUES (3,'Work Basket', 1, GETUTCDATE(), 1, GETUTCDATE(), 1)

    INSERT INTO dbo.CMN_LookupTypeHistory(CMN_LookupTypeRef, LookupTypeDescription, IsActive, UTCCreatedOn, CreatedByRef, UTCLastUpdatedOn, LastUpdatedByRef, UTCHistoryCreatedOn, HistoryCreatedByRef,SaveAttempt)
    Select CMN_LookupTypeId, LookupTypeDescription, IsActive, UTCCreatedOn, CreatedByRef, UTCLastUpdatedOn, LastUpdatedByRef,GETUTCDATE(),1,0 From CMN_LookupType Where CMN_LookupTypeId = 3
END
GO

IF NOT EXISTS (Select 1 from [dbo].[CMN_LookupType] where [CMN_LookupTypeId] = 4)
BEGIN
    INSERT INTO dbo.CMN_LookupType(CMN_LookupTypeId, LookupTypeDescription, IsActive, UTCCreatedOn, CreatedByRef, UTCLastUpdatedOn, LastUpdatedByRef)
    VALUES (4,'Timezone', 1, GETUTCDATE(), 1, GETUTCDATE(), 1)

    INSERT INTO dbo.CMN_LookupTypeHistory(CMN_LookupTypeRef, LookupTypeDescription, IsActive, UTCCreatedOn, CreatedByRef, UTCLastUpdatedOn, LastUpdatedByRef, UTCHistoryCreatedOn, HistoryCreatedByRef,SaveAttempt)
    Select CMN_LookupTypeId, LookupTypeDescription, IsActive, UTCCreatedOn, CreatedByRef, UTCLastUpdatedOn, LastUpdatedByRef,GETUTCDATE(),1,0 From CMN_LookupType Where CMN_LookupTypeId = 4
END
GO

IF NOT EXISTS (Select 1 from [dbo].[CMN_LookupType] where [CMN_LookupTypeId] = 5)
BEGIN
    INSERT INTO dbo.CMN_LookupType(CMN_LookupTypeId, LookupTypeDescription, IsActive, UTCCreatedOn, CreatedByRef, UTCLastUpdatedOn, LastUpdatedByRef)
    VALUES (5,'State', 1, GETUTCDATE(), 1, GETUTCDATE(), 1)

    INSERT INTO dbo.CMN_LookupTypeHistory(CMN_LookupTypeRef, LookupTypeDescription, IsActive, UTCCreatedOn, CreatedByRef, UTCLastUpdatedOn, LastUpdatedByRef, UTCHistoryCreatedOn, HistoryCreatedByRef,SaveAttempt)
    Select CMN_LookupTypeId, LookupTypeDescription, IsActive, UTCCreatedOn, CreatedByRef, UTCLastUpdatedOn, LastUpdatedByRef,GETUTCDATE(),1,0 From CMN_LookupType Where CMN_LookupTypeId = 5
END
GO

IF NOT EXISTS (Select 1 from [dbo].[CMN_LookupType] where [CMN_LookupTypeId] = 6)
BEGIN
    INSERT INTO dbo.CMN_LookupType(CMN_LookupTypeId, LookupTypeDescription, IsActive, UTCCreatedOn, CreatedByRef, UTCLastUpdatedOn, LastUpdatedByRef)
    VALUES (6,'Discrepancy Category', 1, GETUTCDATE(), 1, GETUTCDATE(), 1)

    INSERT INTO dbo.CMN_LookupTypeHistory(CMN_LookupTypeRef, LookupTypeDescription, IsActive, UTCCreatedOn, CreatedByRef, UTCLastUpdatedOn, LastUpdatedByRef, UTCHistoryCreatedOn, HistoryCreatedByRef,SaveAttempt)
    Select CMN_LookupTypeId, LookupTypeDescription, IsActive, UTCCreatedOn, CreatedByRef, UTCLastUpdatedOn, LastUpdatedByRef,GETUTCDATE(),1,0 From CMN_LookupType Where CMN_LookupTypeId = 6
END
GO

IF NOT EXISTS (Select 1 from [dbo].[CMN_LookupType] where [CMN_LookupTypeId] = 7)
BEGIN
    INSERT INTO dbo.CMN_LookupType(CMN_LookupTypeId, LookupTypeDescription, IsActive, UTCCreatedOn, CreatedByRef, UTCLastUpdatedOn, LastUpdatedByRef)
    VALUES (7,'Discrepancy Type', 1, GETUTCDATE(), 1, GETUTCDATE(), 1)

    INSERT INTO dbo.CMN_LookupTypeHistory(CMN_LookupTypeRef, LookupTypeDescription, IsActive, UTCCreatedOn, CreatedByRef, UTCLastUpdatedOn, LastUpdatedByRef, UTCHistoryCreatedOn, HistoryCreatedByRef,SaveAttempt)
    Select CMN_LookupTypeId, LookupTypeDescription, IsActive, UTCCreatedOn, CreatedByRef, UTCLastUpdatedOn, LastUpdatedByRef,GETUTCDATE(),1,0 From CMN_LookupType Where CMN_LookupTypeId = 7
END
GO

IF NOT EXISTS (Select 1 from [dbo].[CMN_LookupType] where [CMN_LookupTypeId] = 8)
BEGIN
    INSERT INTO dbo.CMN_LookupType(CMN_LookupTypeId, LookupTypeDescription, IsActive, UTCCreatedOn, CreatedByRef, UTCLastUpdatedOn, LastUpdatedByRef)
    VALUES (8,'Department', 1, GETUTCDATE(), 1, GETUTCDATE(), 1)

    INSERT INTO dbo.CMN_LookupTypeHistory(CMN_LookupTypeRef, LookupTypeDescription, IsActive, UTCCreatedOn, CreatedByRef, UTCLastUpdatedOn, LastUpdatedByRef, UTCHistoryCreatedOn, HistoryCreatedByRef,SaveAttempt)
    Select CMN_LookupTypeId, LookupTypeDescription, IsActive, UTCCreatedOn, CreatedByRef, UTCLastUpdatedOn, LastUpdatedByRef,GETUTCDATE(),1,0 From CMN_LookupType Where CMN_LookupTypeId = 8
END
GO

IF NOT EXISTS (Select 1 from [dbo].[CMN_LookupType] where [CMN_LookupTypeId] = 9)
BEGIN
    INSERT INTO dbo.CMN_LookupType(CMN_LookupTypeId, LookupTypeDescription, IsActive, UTCCreatedOn, CreatedByRef, UTCLastUpdatedOn, LastUpdatedByRef)
    VALUES (9,'Queue Progress Type', 1, GETUTCDATE(), 1, GETUTCDATE(), 1)

    INSERT INTO dbo.CMN_LookupTypeHistory(CMN_LookupTypeRef, LookupTypeDescription, IsActive, UTCCreatedOn, CreatedByRef, UTCLastUpdatedOn, LastUpdatedByRef, UTCHistoryCreatedOn, HistoryCreatedByRef,SaveAttempt)
    Select CMN_LookupTypeId, LookupTypeDescription, IsActive, UTCCreatedOn, CreatedByRef, UTCLastUpdatedOn, LastUpdatedByRef,GETUTCDATE(),1,0 From CMN_LookupType Where CMN_LookupTypeId = 9
END
GO

IF NOT EXISTS (Select 1 from [dbo].[CMN_LookupType] where [CMN_LookupTypeId] = 10)
BEGIN
    INSERT INTO dbo.CMN_LookupType(CMN_LookupTypeId, LookupTypeDescription, IsActive, UTCCreatedOn, CreatedByRef, UTCLastUpdatedOn, LastUpdatedByRef)
    VALUES (10,'Queue', 1, GETUTCDATE(), 1, GETUTCDATE(), 1)

    INSERT INTO dbo.CMN_LookupTypeHistory(CMN_LookupTypeRef, LookupTypeDescription, IsActive, UTCCreatedOn, CreatedByRef, UTCLastUpdatedOn, LastUpdatedByRef, UTCHistoryCreatedOn, HistoryCreatedByRef,SaveAttempt)
    Select CMN_LookupTypeId, LookupTypeDescription, IsActive, UTCCreatedOn, CreatedByRef, UTCLastUpdatedOn, LastUpdatedByRef,GETUTCDATE(),1,0 From CMN_LookupType Where CMN_LookupTypeId = 10
END
GO

IF NOT EXISTS (Select 1 from [dbo].[CMN_LookupType] where [CMN_LookupTypeId] = 11)
BEGIN
    INSERT INTO dbo.CMN_LookupType(CMN_LookupTypeId, LookupTypeDescription, IsActive, UTCCreatedOn, CreatedByRef, UTCLastUpdatedOn, LastUpdatedByRef)
    VALUES (11,'Contract', 1, GETUTCDATE(), 1, GETUTCDATE(), 1)

    INSERT INTO dbo.CMN_LookupTypeHistory(CMN_LookupTypeRef, LookupTypeDescription, IsActive, UTCCreatedOn, CreatedByRef, UTCLastUpdatedOn, LastUpdatedByRef, UTCHistoryCreatedOn, HistoryCreatedByRef,SaveAttempt)
    Select CMN_LookupTypeId, LookupTypeDescription, IsActive, UTCCreatedOn, CreatedByRef, UTCLastUpdatedOn, LastUpdatedByRef,GETUTCDATE(),1,0 From CMN_LookupType Where CMN_LookupTypeId = 11
END
GO

IF NOT EXISTS (Select 1 from [dbo].[CMN_LookupType] where [CMN_LookupTypeId] = 12)
BEGIN
    INSERT INTO dbo.CMN_LookupType(CMN_LookupTypeId, LookupTypeDescription, IsActive, UTCCreatedOn, CreatedByRef, UTCLastUpdatedOn, LastUpdatedByRef)
    VALUES (12,'PBP ID', 1, GETUTCDATE(), 1, GETUTCDATE(), 1)

    INSERT INTO dbo.CMN_LookupTypeHistory(CMN_LookupTypeRef, LookupTypeDescription, IsActive, UTCCreatedOn, CreatedByRef, UTCLastUpdatedOn, LastUpdatedByRef, UTCHistoryCreatedOn, HistoryCreatedByRef,SaveAttempt)
    Select CMN_LookupTypeId, LookupTypeDescription, IsActive, UTCCreatedOn, CreatedByRef, UTCLastUpdatedOn, LastUpdatedByRef,GETUTCDATE(),1,0 From CMN_LookupType Where CMN_LookupTypeId = 12
END
GO

IF NOT EXISTS (Select 1 from [dbo].[CMN_LookupType] where [CMN_LookupTypeId] = 13)
BEGIN
    INSERT INTO dbo.CMN_LookupType(CMN_LookupTypeId, LookupTypeDescription, IsActive, UTCCreatedOn, CreatedByRef, UTCLastUpdatedOn, LastUpdatedByRef)
    VALUES (13,'Discrepancy Source', 1, GETUTCDATE(), 1, GETUTCDATE(), 1)

    INSERT INTO dbo.CMN_LookupTypeHistory(CMN_LookupTypeRef, LookupTypeDescription, IsActive, UTCCreatedOn, CreatedByRef, UTCLastUpdatedOn, LastUpdatedByRef, UTCHistoryCreatedOn, HistoryCreatedByRef,SaveAttempt)
    Select CMN_LookupTypeId, LookupTypeDescription, IsActive, UTCCreatedOn, CreatedByRef, UTCLastUpdatedOn, LastUpdatedByRef,GETUTCDATE(),1,0 From CMN_LookupType Where CMN_LookupTypeId = 13
END
GO

IF NOT EXISTS (Select 1 from [dbo].[CMN_LookupType] where [CMN_LookupTypeId] = 14)
BEGIN
    INSERT INTO dbo.CMN_LookupType(CMN_LookupTypeId, LookupTypeDescription, IsActive, UTCCreatedOn, CreatedByRef, UTCLastUpdatedOn, LastUpdatedByRef)
    VALUES (14,'Action Requested', 1, GETUTCDATE(), 1, GETUTCDATE(), 1)

    INSERT INTO dbo.CMN_LookupTypeHistory(CMN_LookupTypeRef, LookupTypeDescription, IsActive, UTCCreatedOn, CreatedByRef, UTCLastUpdatedOn, LastUpdatedByRef, UTCHistoryCreatedOn, HistoryCreatedByRef,SaveAttempt)
    Select CMN_LookupTypeId, LookupTypeDescription, IsActive, UTCCreatedOn, CreatedByRef, UTCLastUpdatedOn, LastUpdatedByRef,GETUTCDATE(),1,0 From CMN_LookupType Where CMN_LookupTypeId = 14
END
GO

IF NOT EXISTS (Select 1 from [dbo].[CMN_LookupType] where [CMN_LookupTypeId] = 15)
BEGIN
    INSERT INTO dbo.CMN_LookupType(CMN_LookupTypeId, LookupTypeDescription, IsActive, UTCCreatedOn, CreatedByRef, UTCLastUpdatedOn, LastUpdatedByRef)
    VALUES (15,'Task being performed when this discrepancy was identified', 1, GETUTCDATE(), 1, GETUTCDATE(), 1)

    INSERT INTO dbo.CMN_LookupTypeHistory(CMN_LookupTypeRef, LookupTypeDescription, IsActive, UTCCreatedOn, CreatedByRef, UTCLastUpdatedOn, LastUpdatedByRef, UTCHistoryCreatedOn, HistoryCreatedByRef,SaveAttempt)
    Select CMN_LookupTypeId, LookupTypeDescription, IsActive, UTCCreatedOn, CreatedByRef, UTCLastUpdatedOn, LastUpdatedByRef,GETUTCDATE(),1,0 From CMN_LookupType Where CMN_LookupTypeId = 15
END
GO

IF NOT EXISTS (Select 1 from [dbo].[CMN_LookupType] where [CMN_LookupTypeId] = 16)
BEGIN
    INSERT INTO dbo.CMN_LookupType(CMN_LookupTypeId, LookupTypeDescription, IsActive, UTCCreatedOn, CreatedByRef, UTCLastUpdatedOn, LastUpdatedByRef)
    VALUES (16,'YesNo', 1, GETUTCDATE(), 1, GETUTCDATE(), 1)

    INSERT INTO dbo.CMN_LookupTypeHistory(CMN_LookupTypeRef, LookupTypeDescription, IsActive, UTCCreatedOn, CreatedByRef, UTCLastUpdatedOn, LastUpdatedByRef, UTCHistoryCreatedOn, HistoryCreatedByRef,SaveAttempt)
    Select CMN_LookupTypeId, LookupTypeDescription, IsActive, UTCCreatedOn, CreatedByRef, UTCLastUpdatedOn, LastUpdatedByRef,GETUTCDATE(),1,0 From CMN_LookupType Where CMN_LookupTypeId = 16
END
GO

IF NOT EXISTS (Select 1 from [dbo].[CMN_LookupType] where [CMN_LookupTypeId] = 17)
BEGIN
    INSERT INTO dbo.CMN_LookupType(CMN_LookupTypeId, LookupTypeDescription, IsActive, UTCCreatedOn, CreatedByRef, UTCLastUpdatedOn, LastUpdatedByRef)
    VALUES (17,'Submission Type', 1, GETUTCDATE(), 1, GETUTCDATE(), 1)

    INSERT INTO dbo.CMN_LookupTypeHistory(CMN_LookupTypeRef, LookupTypeDescription, IsActive, UTCCreatedOn, CreatedByRef, UTCLastUpdatedOn, LastUpdatedByRef, UTCHistoryCreatedOn, HistoryCreatedByRef,SaveAttempt)
    Select CMN_LookupTypeId, LookupTypeDescription, IsActive, UTCCreatedOn, CreatedByRef, UTCLastUpdatedOn, LastUpdatedByRef,GETUTCDATE(),1,0 From CMN_LookupType Where CMN_LookupTypeId = 17
END
GO

IF NOT EXISTS (Select 1 from [dbo].[CMN_LookupType] where [CMN_LookupTypeId] = 18)
BEGIN
    INSERT INTO dbo.CMN_LookupType(CMN_LookupTypeId, LookupTypeDescription, IsActive, UTCCreatedOn, CreatedByRef, UTCLastUpdatedOn, LastUpdatedByRef)
    VALUES (18,'Resolution', 1, GETUTCDATE(), 1, GETUTCDATE(), 1)

    INSERT INTO dbo.CMN_LookupTypeHistory(CMN_LookupTypeRef, LookupTypeDescription, IsActive, UTCCreatedOn, CreatedByRef, UTCLastUpdatedOn, LastUpdatedByRef, UTCHistoryCreatedOn, HistoryCreatedByRef,SaveAttempt)
    Select CMN_LookupTypeId, LookupTypeDescription, IsActive, UTCCreatedOn, CreatedByRef, UTCLastUpdatedOn, LastUpdatedByRef,GETUTCDATE(),1,0 From CMN_LookupType Where CMN_LookupTypeId = 18
END
GO

IF NOT EXISTS (Select 1 from [dbo].[CMN_LookupType] where [CMN_LookupTypeId] = 19)
BEGIN
    INSERT INTO dbo.CMN_LookupType(CMN_LookupTypeId, LookupTypeDescription, IsActive, UTCCreatedOn, CreatedByRef, UTCLastUpdatedOn, LastUpdatedByRef)
    VALUES (19,'Reason for Request', 1, GETUTCDATE(), 1, GETUTCDATE(), 1)

    INSERT INTO dbo.CMN_LookupTypeHistory(CMN_LookupTypeRef, LookupTypeDescription, IsActive, UTCCreatedOn, CreatedByRef, UTCLastUpdatedOn, LastUpdatedByRef, UTCHistoryCreatedOn, HistoryCreatedByRef,SaveAttempt)
    Select CMN_LookupTypeId, LookupTypeDescription, IsActive, UTCCreatedOn, CreatedByRef, UTCLastUpdatedOn, LastUpdatedByRef,GETUTCDATE(),1,0 From CMN_LookupType Where CMN_LookupTypeId = 19
END
GO

IF NOT EXISTS (Select 1 from [dbo].[CMN_LookupType] where [CMN_LookupTypeId] = 20)
BEGIN
    INSERT INTO dbo.CMN_LookupType(CMN_LookupTypeId, LookupTypeDescription, IsActive, UTCCreatedOn, CreatedByRef, UTCLastUpdatedOn, LastUpdatedByRef)
    VALUES (20,'Status', 1, GETUTCDATE(), 1, GETUTCDATE(), 1)

    INSERT INTO dbo.CMN_LookupTypeHistory(CMN_LookupTypeRef, LookupTypeDescription, IsActive, UTCCreatedOn, CreatedByRef, UTCLastUpdatedOn, LastUpdatedByRef, UTCHistoryCreatedOn, HistoryCreatedByRef,SaveAttempt)
    Select CMN_LookupTypeId, LookupTypeDescription, IsActive, UTCCreatedOn, CreatedByRef, UTCLastUpdatedOn, LastUpdatedByRef,GETUTCDATE(),1,0 From CMN_LookupType Where CMN_LookupTypeId = 20
END
GO

IF NOT EXISTS (Select 1 from [dbo].[CMN_LookupType] where [CMN_LookupTypeId] = 21)
BEGIN
    INSERT INTO dbo.CMN_LookupType(CMN_LookupTypeId, LookupTypeDescription, IsActive, UTCCreatedOn, CreatedByRef, UTCLastUpdatedOn, LastUpdatedByRef)
    VALUES (21,'Gender', 1, GETUTCDATE(), 1, GETUTCDATE(), 1)

    INSERT INTO dbo.CMN_LookupTypeHistory(CMN_LookupTypeRef, LookupTypeDescription, IsActive, UTCCreatedOn, CreatedByRef, UTCLastUpdatedOn, LastUpdatedByRef, UTCHistoryCreatedOn, HistoryCreatedByRef,SaveAttempt)
    Select CMN_LookupTypeId, LookupTypeDescription, IsActive, UTCCreatedOn, CreatedByRef, UTCLastUpdatedOn, LastUpdatedByRef,GETUTCDATE(),1,0 From CMN_LookupType Where CMN_LookupTypeId = 21
END
GO

IF NOT EXISTS (Select 1 from [dbo].[CMN_LookupType] where [CMN_LookupTypeId] = 22)
BEGIN
    INSERT INTO dbo.CMN_LookupType(CMN_LookupTypeId, LookupTypeDescription, IsActive, UTCCreatedOn, CreatedByRef, UTCLastUpdatedOn, LastUpdatedByRef)
    VALUES (22,'Transaction Reply Code', 1, GETUTCDATE(), 1, GETUTCDATE(), 1)

    INSERT INTO dbo.CMN_LookupTypeHistory(CMN_LookupTypeRef, LookupTypeDescription, IsActive, UTCCreatedOn, CreatedByRef, UTCLastUpdatedOn, LastUpdatedByRef, UTCHistoryCreatedOn, HistoryCreatedByRef,SaveAttempt)
    Select CMN_LookupTypeId, LookupTypeDescription, IsActive, UTCCreatedOn, CreatedByRef, UTCLastUpdatedOn, LastUpdatedByRef,GETUTCDATE(),1,0 From CMN_LookupType Where CMN_LookupTypeId = 22
END
GO

IF NOT EXISTS (Select 1 from [dbo].[CMN_LookupType] where [CMN_LookupTypeId] = 23)
BEGIN
    INSERT INTO dbo.CMN_LookupType(CMN_LookupTypeId, LookupTypeDescription, IsActive, UTCCreatedOn, CreatedByRef, UTCLastUpdatedOn, LastUpdatedByRef)
    VALUES (23,'Election Type', 1, GETUTCDATE(), 1, GETUTCDATE(), 1)

    INSERT INTO dbo.CMN_LookupTypeHistory(CMN_LookupTypeRef, LookupTypeDescription, IsActive, UTCCreatedOn, CreatedByRef, UTCLastUpdatedOn, LastUpdatedByRef, UTCHistoryCreatedOn, HistoryCreatedByRef,SaveAttempt)
    Select CMN_LookupTypeId, LookupTypeDescription, IsActive, UTCCreatedOn, CreatedByRef, UTCLastUpdatedOn, LastUpdatedByRef,GETUTCDATE(),1,0 From CMN_LookupType Where CMN_LookupTypeId = 23
END
GO

IF NOT EXISTS (Select 1 from [dbo].[CMN_LookupType] where [CMN_LookupTypeId] = 24)
BEGIN
    INSERT INTO dbo.CMN_LookupType(CMN_LookupTypeId, LookupTypeDescription, IsActive, UTCCreatedOn, CreatedByRef, UTCLastUpdatedOn, LastUpdatedByRef)
    VALUES (24,'Root Cause', 1, GETUTCDATE(), 1, GETUTCDATE(), 1)

    INSERT INTO dbo.CMN_LookupTypeHistory(CMN_LookupTypeRef, LookupTypeDescription, IsActive, UTCCreatedOn, CreatedByRef, UTCLastUpdatedOn, LastUpdatedByRef, UTCHistoryCreatedOn, HistoryCreatedByRef,SaveAttempt)
    Select CMN_LookupTypeId, LookupTypeDescription, IsActive, UTCCreatedOn, CreatedByRef, UTCLastUpdatedOn, LastUpdatedByRef,GETUTCDATE(),1,0 From CMN_LookupType Where CMN_LookupTypeId = 24
END
GO

IF NOT EXISTS (Select 1 from [dbo].[CMN_LookupType] where [CMN_LookupTypeId] = 25)
BEGIN
    INSERT INTO dbo.CMN_LookupType(CMN_LookupTypeId, LookupTypeDescription, IsActive, UTCCreatedOn, CreatedByRef, UTCLastUpdatedOn, LastUpdatedByRef)
    VALUES (25,'Explanation of the Root Cause', 1, GETUTCDATE(), 1, GETUTCDATE(), 1)

    INSERT INTO dbo.CMN_LookupTypeHistory(CMN_LookupTypeRef, LookupTypeDescription, IsActive, UTCCreatedOn, CreatedByRef, UTCLastUpdatedOn, LastUpdatedByRef, UTCHistoryCreatedOn, HistoryCreatedByRef,SaveAttempt)
    Select CMN_LookupTypeId, LookupTypeDescription, IsActive, UTCCreatedOn, CreatedByRef, UTCLastUpdatedOn, LastUpdatedByRef,GETUTCDATE(),1,0 From CMN_LookupType Where CMN_LookupTypeId = 25
END
GO

IF NOT EXISTS (Select 1 from [dbo].[CMN_LookupType] where [CMN_LookupTypeId] = 26)
BEGIN
    INSERT INTO dbo.CMN_LookupType(CMN_LookupTypeId, LookupTypeDescription, IsActive, UTCCreatedOn, CreatedByRef, UTCLastUpdatedOn, LastUpdatedByRef)
    VALUES (26,'FDR Status', 1, GETUTCDATE(), 1, GETUTCDATE(), 1)

    INSERT INTO dbo.CMN_LookupTypeHistory(CMN_LookupTypeRef, LookupTypeDescription, IsActive, UTCCreatedOn, CreatedByRef, UTCLastUpdatedOn, LastUpdatedByRef, UTCHistoryCreatedOn, HistoryCreatedByRef,SaveAttempt)
    Select CMN_LookupTypeId, LookupTypeDescription, IsActive, UTCCreatedOn, CreatedByRef, UTCLastUpdatedOn, LastUpdatedByRef,GETUTCDATE(),1,0 From CMN_LookupType Where CMN_LookupTypeId = 26
END
GO

IF NOT EXISTS (Select 1 from [dbo].[CMN_LookupType] where [CMN_LookupTypeId] = 27)
BEGIN
    INSERT INTO dbo.CMN_LookupType(CMN_LookupTypeId, LookupTypeDescription, IsActive, UTCCreatedOn, CreatedByRef, UTCLastUpdatedOn, LastUpdatedByRef)
    VALUES (27,'FDR Rejection Type', 1, GETUTCDATE(), 1, GETUTCDATE(), 1)

    INSERT INTO dbo.CMN_LookupTypeHistory(CMN_LookupTypeRef, LookupTypeDescription, IsActive, UTCCreatedOn, CreatedByRef, UTCLastUpdatedOn, LastUpdatedByRef, UTCHistoryCreatedOn, HistoryCreatedByRef,SaveAttempt)
    Select CMN_LookupTypeId, LookupTypeDescription, IsActive, UTCCreatedOn, CreatedByRef, UTCLastUpdatedOn, LastUpdatedByRef,GETUTCDATE(),1,0 From CMN_LookupType Where CMN_LookupTypeId = 27
END
GO

IF NOT EXISTS (Select 1 from [dbo].[CMN_LookupType] where [CMN_LookupTypeId] = 28)
BEGIN
    INSERT INTO dbo.CMN_LookupType(CMN_LookupTypeId, LookupTypeDescription, IsActive, UTCCreatedOn, CreatedByRef, UTCLastUpdatedOn, LastUpdatedByRef)
    VALUES (28,'Action', 1, GETUTCDATE(), 1, GETUTCDATE(), 1)

    INSERT INTO dbo.CMN_LookupTypeHistory(CMN_LookupTypeRef, LookupTypeDescription, IsActive, UTCCreatedOn, CreatedByRef, UTCLastUpdatedOn, LastUpdatedByRef, UTCHistoryCreatedOn, HistoryCreatedByRef,SaveAttempt)
    Select CMN_LookupTypeId, LookupTypeDescription, IsActive, UTCCreatedOn, CreatedByRef, UTCLastUpdatedOn, LastUpdatedByRef,GETUTCDATE(),1,0 From CMN_LookupType Where CMN_LookupTypeId = 28
END
GO

IF NOT EXISTS (Select 1 from [dbo].[CMN_LookupType] where [CMN_LookupTypeId] = 29)
BEGIN
    INSERT INTO dbo.CMN_LookupType(CMN_LookupTypeId, LookupTypeDescription, IsActive, UTCCreatedOn, CreatedByRef, UTCLastUpdatedOn, LastUpdatedByRef)
    VALUES (29,'Transaction Type Code', 1, GETUTCDATE(), 1, GETUTCDATE(), 1)

    INSERT INTO dbo.CMN_LookupTypeHistory(CMN_LookupTypeRef, LookupTypeDescription, IsActive, UTCCreatedOn, CreatedByRef, UTCLastUpdatedOn, LastUpdatedByRef, UTCHistoryCreatedOn, HistoryCreatedByRef,SaveAttempt)
    Select CMN_LookupTypeId, LookupTypeDescription, IsActive, UTCCreatedOn, CreatedByRef, UTCLastUpdatedOn, LastUpdatedByRef,GETUTCDATE(),1,0 From CMN_LookupType Where CMN_LookupTypeId = 29
END
GO

IF NOT EXISTS (Select 1 from [dbo].[CMN_LookupType] where [CMN_LookupTypeId] = 30)
BEGIN
    INSERT INTO dbo.CMN_LookupType(CMN_LookupTypeId, LookupTypeDescription, IsActive, UTCCreatedOn, CreatedByRef, UTCLastUpdatedOn, LastUpdatedByRef)
    VALUES (30,'Pend Reason', 1, GETUTCDATE(), 1, GETUTCDATE(), 1)

    INSERT INTO dbo.CMN_LookupTypeHistory(CMN_LookupTypeRef, LookupTypeDescription, IsActive, UTCCreatedOn, CreatedByRef, UTCLastUpdatedOn, LastUpdatedByRef, UTCHistoryCreatedOn, HistoryCreatedByRef,SaveAttempt)
    Select CMN_LookupTypeId, LookupTypeDescription, IsActive, UTCCreatedOn, CreatedByRef, UTCLastUpdatedOn, LastUpdatedByRef,GETUTCDATE(),1,0 From CMN_LookupType Where CMN_LookupTypeId = 30
END
GO

IF NOT EXISTS (Select 1 from [dbo].[CMN_LookupType] where [CMN_LookupTypeId] = 31)
BEGIN
    INSERT INTO dbo.CMN_LookupType(CMN_LookupTypeId, LookupTypeDescription, IsActive, UTCCreatedOn, CreatedByRef, UTCLastUpdatedOn, LastUpdatedByRef)
    VALUES (31,'LOB', 1, GETUTCDATE(), 1, GETUTCDATE(), 1)

    INSERT INTO dbo.CMN_LookupTypeHistory(CMN_LookupTypeRef, LookupTypeDescription, IsActive, UTCCreatedOn, CreatedByRef, UTCLastUpdatedOn, LastUpdatedByRef, UTCHistoryCreatedOn, HistoryCreatedByRef,SaveAttempt)
    Select CMN_LookupTypeId, LookupTypeDescription, IsActive, UTCCreatedOn, CreatedByRef, UTCLastUpdatedOn, LastUpdatedByRef,GETUTCDATE(),1,0 From CMN_LookupType Where CMN_LookupTypeId = 31
END
GO

IF NOT EXISTS (Select 1 from [dbo].[CMN_LookupType] where [CMN_LookupTypeId] = 32)
BEGIN
    INSERT INTO dbo.CMN_LookupType(CMN_LookupTypeId, LookupTypeDescription, IsActive, UTCCreatedOn, CreatedByRef, UTCLastUpdatedOn, LastUpdatedByRef)
    VALUES (32,'Adjusted Create Date Reason', 1, GETUTCDATE(), 1, GETUTCDATE(), 1)

    INSERT INTO dbo.CMN_LookupTypeHistory(CMN_LookupTypeRef, LookupTypeDescription, IsActive, UTCCreatedOn, CreatedByRef, UTCLastUpdatedOn, LastUpdatedByRef, UTCHistoryCreatedOn, HistoryCreatedByRef,SaveAttempt)
    Select CMN_LookupTypeId, LookupTypeDescription, IsActive, UTCCreatedOn, CreatedByRef, UTCLastUpdatedOn, LastUpdatedByRef,GETUTCDATE(),1,0 From CMN_LookupType Where CMN_LookupTypeId = 32
END
GO

IF NOT EXISTS (Select 1 from [dbo].[CMN_LookupType] where [CMN_LookupTypeId] = 33)
BEGIN
    INSERT INTO dbo.CMN_LookupType(CMN_LookupTypeId, LookupTypeDescription, IsActive, UTCCreatedOn, CreatedByRef, UTCLastUpdatedOn, LastUpdatedByRef)
    VALUES (33,'Location', 1, GETUTCDATE(), 1, GETUTCDATE(), 1)

    INSERT INTO dbo.CMN_LookupTypeHistory(CMN_LookupTypeRef, LookupTypeDescription, IsActive, UTCCreatedOn, CreatedByRef, UTCLastUpdatedOn, LastUpdatedByRef, UTCHistoryCreatedOn, HistoryCreatedByRef,SaveAttempt)
    Select CMN_LookupTypeId, LookupTypeDescription, IsActive, UTCCreatedOn, CreatedByRef, UTCLastUpdatedOn, LastUpdatedByRef,GETUTCDATE(),1,0 From CMN_LookupType Where CMN_LookupTypeId = 33
END
GO

IF NOT EXISTS (Select 1 from [dbo].[CMN_LookupType] where [CMN_LookupTypeId] = 34)
BEGIN
    INSERT INTO dbo.CMN_LookupType(CMN_LookupTypeId, LookupTypeDescription, IsActive, UTCCreatedOn, CreatedByRef, UTCLastUpdatedOn, LastUpdatedByRef)
    VALUES (34,'Salutation', 1, GETUTCDATE(), 1, GETUTCDATE(), 1)

    INSERT INTO dbo.CMN_LookupTypeHistory(CMN_LookupTypeRef, LookupTypeDescription, IsActive, UTCCreatedOn, CreatedByRef, UTCLastUpdatedOn, LastUpdatedByRef, UTCHistoryCreatedOn, HistoryCreatedByRef,SaveAttempt)
    Select CMN_LookupTypeId, LookupTypeDescription, IsActive, UTCCreatedOn, CreatedByRef, UTCLastUpdatedOn, LastUpdatedByRef,GETUTCDATE(),1,0 From CMN_LookupType Where CMN_LookupTypeId = 34
END
GO

IF NOT EXISTS (Select 1 from [dbo].[CMN_LookupType] where [CMN_LookupTypeId] = 35)
BEGIN
    INSERT INTO dbo.CMN_LookupType(CMN_LookupTypeId, LookupTypeDescription, IsActive, UTCCreatedOn, CreatedByRef, UTCLastUpdatedOn, LastUpdatedByRef)
    VALUES (35,'Send Alert To', 1, GETUTCDATE(), 1, GETUTCDATE(), 1)

    INSERT INTO dbo.CMN_LookupTypeHistory(CMN_LookupTypeRef, LookupTypeDescription, IsActive, UTCCreatedOn, CreatedByRef, UTCLastUpdatedOn, LastUpdatedByRef, UTCHistoryCreatedOn, HistoryCreatedByRef,SaveAttempt)
    Select CMN_LookupTypeId, LookupTypeDescription, IsActive, UTCCreatedOn, CreatedByRef, UTCLastUpdatedOn, LastUpdatedByRef,GETUTCDATE(),1,0 From CMN_LookupType Where CMN_LookupTypeId = 35
END
GO

IF NOT EXISTS (Select 1 from [dbo].[CMN_LookupType] where [CMN_LookupTypeId] = 36)
BEGIN
    INSERT INTO dbo.CMN_LookupType(CMN_LookupTypeId, LookupTypeDescription, IsActive, UTCCreatedOn, CreatedByRef, UTCLastUpdatedOn, LastUpdatedByRef)
    VALUES (36,'Alert Criticality', 1, GETUTCDATE(), 1, GETUTCDATE(), 1)

    INSERT INTO dbo.CMN_LookupTypeHistory(CMN_LookupTypeRef, LookupTypeDescription, IsActive, UTCCreatedOn, CreatedByRef, UTCLastUpdatedOn, LastUpdatedByRef, UTCHistoryCreatedOn, HistoryCreatedByRef,SaveAttempt)
    Select CMN_LookupTypeId, LookupTypeDescription, IsActive, UTCCreatedOn, CreatedByRef, UTCLastUpdatedOn, LastUpdatedByRef,GETUTCDATE(),1,0 From CMN_LookupType Where CMN_LookupTypeId = 36
END
GO

IF NOT EXISTS (Select 1 from [dbo].[CMN_LookupType] where [CMN_LookupTypeId] = 37)
BEGIN
    INSERT INTO dbo.CMN_LookupType(CMN_LookupTypeId, LookupTypeDescription, IsActive, UTCCreatedOn, CreatedByRef, UTCLastUpdatedOn, LastUpdatedByRef)
    VALUES (37,'DBMaster Tables', 1, GETUTCDATE(), 1, GETUTCDATE(), 1)

    INSERT INTO dbo.CMN_LookupTypeHistory(CMN_LookupTypeRef, LookupTypeDescription, IsActive, UTCCreatedOn, CreatedByRef, UTCLastUpdatedOn, LastUpdatedByRef, UTCHistoryCreatedOn, HistoryCreatedByRef,SaveAttempt)
    Select CMN_LookupTypeId, LookupTypeDescription, IsActive, UTCCreatedOn, CreatedByRef, UTCLastUpdatedOn, LastUpdatedByRef,GETUTCDATE(),1,0 From CMN_LookupType Where CMN_LookupTypeId = 37
END
GO

IF NOT EXISTS (Select * from [dbo].[CMN_LookupType] where [CMN_LookupTypeId] = 38)
BEGIN
    INSERT INTO dbo.CMN_LookupType(CMN_LookupTypeId, LookupTypeDescription, IsActive, UTCCreatedOn, CreatedByRef, UTCLastUpdatedOn, LastUpdatedByRef)
    VALUES (38,'Source System', 1, GETUTCDATE(), 1, GETUTCDATE(), 1)

    INSERT INTO dbo.CMN_LookupTypeHistory(CMN_LookupTypeRef, LookupTypeDescription, IsActive, UTCCreatedOn, CreatedByRef, UTCLastUpdatedOn, LastUpdatedByRef, UTCHistoryCreatedOn, HistoryCreatedByRef,SaveAttempt)
    Select CMN_LookupTypeId, LookupTypeDescription, IsActive, UTCCreatedOn, CreatedByRef, UTCLastUpdatedOn, LastUpdatedByRef,GETUTCDATE(),1,0 From CMN_LookupType Where CMN_LookupTypeId = 38
END
GO

IF NOT EXISTS (Select * from [dbo].[CMN_LookupType] where [CMN_LookupTypeId] = 39)
BEGIN
    INSERT INTO dbo.CMN_LookupType(CMN_LookupTypeId, LookupTypeDescription, IsActive, UTCCreatedOn, CreatedByRef, UTCLastUpdatedOn, LastUpdatedByRef)
    VALUES (39,'User Escalation Reason', 1, GETUTCDATE(), 1, GETUTCDATE(), 1)

    INSERT INTO dbo.CMN_LookupTypeHistory(CMN_LookupTypeRef, LookupTypeDescription, IsActive, UTCCreatedOn, CreatedByRef, UTCLastUpdatedOn, LastUpdatedByRef, UTCHistoryCreatedOn, HistoryCreatedByRef,SaveAttempt)
    Select CMN_LookupTypeId, LookupTypeDescription, IsActive, UTCCreatedOn, CreatedByRef, UTCLastUpdatedOn, LastUpdatedByRef,GETUTCDATE(),1,0 From CMN_LookupType Where CMN_LookupTypeId = 39
END
GO

IF NOT EXISTS (Select * from [dbo].[CMN_LookupType] where [CMN_LookupTypeId] = 40)
BEGIN
    INSERT INTO dbo.CMN_LookupType(CMN_LookupTypeId, LookupTypeDescription, IsActive, UTCCreatedOn, CreatedByRef, UTCLastUpdatedOn, LastUpdatedByRef)
    VALUES (40,'File Type', 1, GETUTCDATE(), 1, GETUTCDATE(), 1)

    INSERT INTO dbo.CMN_LookupTypeHistory(CMN_LookupTypeRef, LookupTypeDescription, IsActive, UTCCreatedOn, CreatedByRef, UTCLastUpdatedOn, LastUpdatedByRef, UTCHistoryCreatedOn, HistoryCreatedByRef,SaveAttempt)
    Select CMN_LookupTypeId, LookupTypeDescription, IsActive, UTCCreatedOn, CreatedByRef, UTCLastUpdatedOn, LastUpdatedByRef,GETUTCDATE(),1,0 From CMN_LookupType Where CMN_LookupTypeId = 40
END
GO

IF NOT EXISTS (Select * from [dbo].[CMN_LookupType] where [CMN_LookupTypeId] = 41)
BEGIN
    INSERT INTO dbo.CMN_LookupType(CMN_LookupTypeId, LookupTypeDescription, IsActive, UTCCreatedOn, CreatedByRef, UTCLastUpdatedOn, LastUpdatedByRef)
    VALUES (41,'Import Status', 1, GETUTCDATE(), 1, GETUTCDATE(), 1)

    INSERT INTO dbo.CMN_LookupTypeHistory(CMN_LookupTypeRef, LookupTypeDescription, IsActive, UTCCreatedOn, CreatedByRef, UTCLastUpdatedOn, LastUpdatedByRef, UTCHistoryCreatedOn, HistoryCreatedByRef,SaveAttempt)
    Select CMN_LookupTypeId, LookupTypeDescription, IsActive, UTCCreatedOn, CreatedByRef, UTCLastUpdatedOn, LastUpdatedByRef,GETUTCDATE(),1,0 From CMN_LookupType Where CMN_LookupTypeId = 41
END
GO

IF NOT EXISTS (SELECT * FROM dbo.CMN_LookupType WHERE CMN_LookupTypeId=42 )
BEGIN
	INSERT dbo.CMN_LookupType(CMN_LookupTypeId,LookupTypeDescription,IsActive,UTCCreatedOn,CreatedByRef,UTCLastUpdatedOn,LastUpdatedByRef)
	VALUES (42,N'Report Category',1,GETUTCDATE(),1,GETUTCDATE(),1)

    INSERT dbo.CMN_LookupTypeHistory(CMN_LookupTypeRef,LookupTypeDescription,IsActive,UTCCreatedOn,CreatedByRef,UTCLastUpdatedOn,LastUpdatedByRef,UTCHistoryCreatedOn,HistoryCreatedByRef,SaveAttempt,LockedByRef,UTCLockedOn)
    Select CMN_LookupTypeId,LookupTypeDescription,IsActive,UTCCreatedOn,CreatedByRef,UTCLastUpdatedOn,LastUpdatedByRef,GETUTCDATE(),1,0,NULL,NULL From CMN_LookupType Where CMN_LookupTypeId = 42
END
GO

IF NOT EXISTS (SELECT * FROM dbo.CMN_LookupType WHERE CMN_LookupTypeId=43 )
BEGIN
	INSERT dbo.CMN_LookupType(CMN_LookupTypeId,LookupTypeDescription,IsActive,UTCCreatedOn,CreatedByRef,UTCLastUpdatedOn,LastUpdatedByRef)
	VALUES (43,N'Transaction Type',1,GETUTCDATE(),1,GETUTCDATE(),1)

    INSERT dbo.CMN_LookupTypeHistory(CMN_LookupTypeRef,LookupTypeDescription,IsActive,UTCCreatedOn,CreatedByRef,UTCLastUpdatedOn,LastUpdatedByRef,UTCHistoryCreatedOn,HistoryCreatedByRef,SaveAttempt,LockedByRef,UTCLockedOn)
    Select CMN_LookupTypeId,LookupTypeDescription,IsActive,UTCCreatedOn,CreatedByRef,UTCLastUpdatedOn,LastUpdatedByRef,GETUTCDATE(),1,0,NULL,NULL From CMN_LookupType Where CMN_LookupTypeId = 43
END
GO


IF NOT EXISTS (SELECT * FROM dbo.CMN_LookupType WHERE CMN_LookupTypeId=44 )
BEGIN
	INSERT dbo.CMN_LookupType(CMN_LookupTypeId,LookupTypeDescription,IsActive,UTCCreatedOn,CreatedByRef,UTCLastUpdatedOn,LastUpdatedByRef)
	VALUES (44,N'Background Process Type',1,GETUTCDATE(),1,GETUTCDATE(),1)

    INSERT dbo.CMN_LookupTypeHistory(CMN_LookupTypeRef,LookupTypeDescription,IsActive,UTCCreatedOn,CreatedByRef,UTCLastUpdatedOn,LastUpdatedByRef,UTCHistoryCreatedOn,HistoryCreatedByRef,SaveAttempt,LockedByRef,UTCLockedOn)
    Select CMN_LookupTypeId,LookupTypeDescription,IsActive,UTCCreatedOn,CreatedByRef,UTCLastUpdatedOn,LastUpdatedByRef,GETUTCDATE(),1,0,NULL,NULL From CMN_LookupType Where CMN_LookupTypeId = 44
END
GO

IF NOT EXISTS (SELECT * FROM dbo.CMN_LookupType WHERE CMN_LookupTypeId=45 )
BEGIN
	INSERT dbo.CMN_LookupType(CMN_LookupTypeId,LookupTypeDescription,IsActive,UTCCreatedOn,CreatedByRef,UTCLastUpdatedOn,LastUpdatedByRef)
	VALUES (45,N'Error Module Name',1,GETUTCDATE(),1,GETUTCDATE(),1)

    INSERT dbo.CMN_LookupTypeHistory(CMN_LookupTypeRef,LookupTypeDescription,IsActive,UTCCreatedOn,CreatedByRef,UTCLastUpdatedOn,LastUpdatedByRef,UTCHistoryCreatedOn,HistoryCreatedByRef,SaveAttempt,LockedByRef,UTCLockedOn)
    Select CMN_LookupTypeId,LookupTypeDescription,IsActive,UTCCreatedOn,CreatedByRef,UTCLastUpdatedOn,LastUpdatedByRef,GETUTCDATE(),1,0,NULL,NULL From CMN_LookupType Where CMN_LookupTypeId = 45
END
GO

IF NOT EXISTS (SELECT * FROM dbo.CMN_LookupType WHERE CMN_LookupTypeId=46 )
BEGIN
    INSERT dbo.CMN_LookupType(CMN_LookupTypeId,LookupTypeDescription,IsActive,UTCCreatedOn,CreatedByRef,UTCLastUpdatedOn,LastUpdatedByRef)
    VALUES (46,N'WebService Status',1,GETUTCDATE(),1,GETUTCDATE(),1)

    INSERT dbo.CMN_LookupTypeHistory(CMN_LookupTypeRef,LookupTypeDescription,IsActive,UTCCreatedOn,CreatedByRef,UTCLastUpdatedOn,LastUpdatedByRef,UTCHistoryCreatedOn,HistoryCreatedByRef,SaveAttempt,LockedByRef,UTCLockedOn)
    Select CMN_LookupTypeId,LookupTypeDescription,IsActive,UTCCreatedOn,CreatedByRef,UTCLastUpdatedOn,LastUpdatedByRef,GETUTCDATE(),1,0,NULL,NULL From CMN_LookupType Where CMN_LookupTypeId = 46
END
GO

IF NOT EXISTS (SELECT * FROM dbo.CMN_LookupType WHERE CMN_LookupTypeId=47 )
BEGIN
    INSERT dbo.CMN_LookupType(CMN_LookupTypeId,LookupTypeDescription,IsActive,UTCCreatedOn,CreatedByRef,UTCLastUpdatedOn,LastUpdatedByRef)
    VALUES (47,N'WebService Method',1,GETUTCDATE(),1,GETUTCDATE(),1)

    INSERT dbo.CMN_LookupTypeHistory(CMN_LookupTypeRef,LookupTypeDescription,IsActive,UTCCreatedOn,CreatedByRef,UTCLastUpdatedOn,LastUpdatedByRef,UTCHistoryCreatedOn,HistoryCreatedByRef,SaveAttempt,LockedByRef,UTCLockedOn)
    Select CMN_LookupTypeId,LookupTypeDescription,IsActive,UTCCreatedOn,CreatedByRef,UTCLastUpdatedOn,LastUpdatedByRef,GETUTCDATE(),1,0,NULL,NULL From CMN_LookupType Where CMN_LookupTypeId = 47
END
GO
IF NOT EXISTS (SELECT * FROM dbo.CMN_LookupType WHERE CMN_LookupTypeId=48 )
BEGIN
    INSERT dbo.CMN_LookupType(CMN_LookupTypeId,LookupTypeDescription,IsActive,UTCCreatedOn,CreatedByRef,UTCLastUpdatedOn,LastUpdatedByRef)
    VALUES (48,N'Reopen Action',1,GETUTCDATE(),1,GETUTCDATE(),1)

    INSERT dbo.CMN_LookupTypeHistory(CMN_LookupTypeRef,LookupTypeDescription,IsActive,UTCCreatedOn,CreatedByRef,UTCLastUpdatedOn,LastUpdatedByRef,UTCHistoryCreatedOn,HistoryCreatedByRef,SaveAttempt,LockedByRef,UTCLockedOn)
    Select CMN_LookupTypeId,LookupTypeDescription,IsActive,UTCCreatedOn,CreatedByRef,UTCLastUpdatedOn,LastUpdatedByRef,GETUTCDATE(),1,0,NULL,NULL From CMN_LookupType Where CMN_LookupTypeId = 48
END
GO

IF NOT EXISTS (SELECT * FROM dbo.CMN_LookupType WHERE CMN_LookupTypeId=49 )
BEGIN
    INSERT dbo.CMN_LookupType(CMN_LookupTypeId,LookupTypeDescription,IsActive,UTCCreatedOn,CreatedByRef,UTCLastUpdatedOn,LastUpdatedByRef)
    VALUES (49,N'RPR Category',1,GETUTCDATE(),1,GETUTCDATE(),1)

    INSERT dbo.CMN_LookupTypeHistory(CMN_LookupTypeRef,LookupTypeDescription,IsActive,UTCCreatedOn,CreatedByRef,UTCLastUpdatedOn,LastUpdatedByRef,UTCHistoryCreatedOn,HistoryCreatedByRef,SaveAttempt,LockedByRef,UTCLockedOn)
    Select CMN_LookupTypeId,LookupTypeDescription,IsActive,UTCCreatedOn,CreatedByRef,UTCLastUpdatedOn,LastUpdatedByRef,GETUTCDATE(),1,0,NULL,NULL From CMN_LookupType Where CMN_LookupTypeId = 49
END
GO

IF NOT EXISTS (SELECT * FROM dbo.CMN_LookupType WHERE CMN_LookupTypeId=50 )
BEGIN
    INSERT dbo.CMN_LookupType(CMN_LookupTypeId,LookupTypeDescription,IsActive,UTCCreatedOn,CreatedByRef,UTCLastUpdatedOn,LastUpdatedByRef)
    VALUES (50,N'FDR Submission Category',1,GETUTCDATE(),1,GETUTCDATE(),1)

    INSERT dbo.CMN_LookupTypeHistory(CMN_LookupTypeRef,LookupTypeDescription,IsActive,UTCCreatedOn,CreatedByRef,UTCLastUpdatedOn,LastUpdatedByRef,UTCHistoryCreatedOn,HistoryCreatedByRef,SaveAttempt,LockedByRef,UTCLockedOn)
    Select CMN_LookupTypeId,LookupTypeDescription,IsActive,UTCCreatedOn,CreatedByRef,UTCLastUpdatedOn,LastUpdatedByRef,GETUTCDATE(),1,0,NULL,NULL From CMN_LookupType Where CMN_LookupTypeId = 50
END
GO

IF NOT EXISTS (SELECT * FROM dbo.CMN_LookupType WHERE CMN_LookupTypeId=51 )
BEGIN
    INSERT dbo.CMN_LookupType(CMN_LookupTypeId,LookupTypeDescription,IsActive,UTCCreatedOn,CreatedByRef,UTCLastUpdatedOn,LastUpdatedByRef)
    VALUES (51,N'MIIMStatus',1,GETUTCDATE(),1,GETUTCDATE(),1)

    INSERT dbo.CMN_LookupTypeHistory(CMN_LookupTypeRef,LookupTypeDescription,IsActive,UTCCreatedOn,CreatedByRef,UTCLastUpdatedOn,LastUpdatedByRef,UTCHistoryCreatedOn,HistoryCreatedByRef,SaveAttempt,LockedByRef,UTCLockedOn)
    Select CMN_LookupTypeId,LookupTypeDescription,IsActive,UTCCreatedOn,CreatedByRef,UTCLastUpdatedOn,LastUpdatedByRef,GETUTCDATE(),1,0,NULL,NULL From CMN_LookupType Where CMN_LookupTypeId = 51
END
GO

IF NOT EXISTS (SELECT * FROM dbo.CMN_LookupType WHERE CMN_LookupTypeId=52 )
BEGIN
    INSERT dbo.CMN_LookupType(CMN_LookupTypeId,LookupTypeDescription,IsActive,UTCCreatedOn,CreatedByRef,UTCLastUpdatedOn,LastUpdatedByRef)
    VALUES (52,N'MIIM Service Method',1,GETUTCDATE(),1,GETUTCDATE(),1)

    INSERT dbo.CMN_LookupTypeHistory(CMN_LookupTypeRef,LookupTypeDescription,IsActive,UTCCreatedOn,CreatedByRef,UTCLastUpdatedOn,LastUpdatedByRef,UTCHistoryCreatedOn,HistoryCreatedByRef,SaveAttempt,LockedByRef,UTCLockedOn)
    Select CMN_LookupTypeId,LookupTypeDescription,IsActive,UTCCreatedOn,CreatedByRef,UTCLastUpdatedOn,LastUpdatedByRef,GETUTCDATE(),1,0,NULL,NULL From CMN_LookupType Where CMN_LookupTypeId = 52
END
GO

IF NOT EXISTS (SELECT * FROM dbo.CMN_LookupType WHERE CMN_LookupTypeId=53 )
BEGIN
    INSERT dbo.CMN_LookupType(CMN_LookupTypeId,LookupTypeDescription,IsActive,UTCCreatedOn,CreatedByRef,UTCLastUpdatedOn,LastUpdatedByRef)
    VALUES (53,N'OOA Letter Status',1,GETUTCDATE(),1,GETUTCDATE(),1)

    INSERT dbo.CMN_LookupTypeHistory(CMN_LookupTypeRef,LookupTypeDescription,IsActive,UTCCreatedOn,CreatedByRef,UTCLastUpdatedOn,LastUpdatedByRef,UTCHistoryCreatedOn,HistoryCreatedByRef,SaveAttempt,LockedByRef,UTCLockedOn)
    Select CMN_LookupTypeId,LookupTypeDescription,IsActive,UTCCreatedOn,CreatedByRef,UTCLastUpdatedOn,LastUpdatedByRef,GETUTCDATE(),1,0,NULL,NULL From CMN_LookupType Where CMN_LookupTypeId = 53
END
GO

IF NOT EXISTS (SELECT * FROM dbo.CMN_LookupType WHERE CMN_LookupTypeId=54 )
BEGIN
    INSERT dbo.CMN_LookupType(CMN_LookupTypeId,LookupTypeDescription,IsActive,UTCCreatedOn,CreatedByRef,UTCLastUpdatedOn,LastUpdatedByRef)
    VALUES (54,N'MQ Source Type',1,GETUTCDATE(),1,GETUTCDATE(),1)

    INSERT dbo.CMN_LookupTypeHistory(CMN_LookupTypeRef,LookupTypeDescription,IsActive,UTCCreatedOn,CreatedByRef,UTCLastUpdatedOn,LastUpdatedByRef,UTCHistoryCreatedOn,HistoryCreatedByRef,SaveAttempt,LockedByRef,UTCLockedOn)
    Select CMN_LookupTypeId,LookupTypeDescription,IsActive,UTCCreatedOn,CreatedByRef,UTCLastUpdatedOn,LastUpdatedByRef,GETUTCDATE(),1,0,NULL,NULL From CMN_LookupType Where CMN_LookupTypeId = 54
END
GO

IF NOT EXISTS (SELECT * FROM dbo.CMN_LookupType WHERE CMN_LookupTypeId=55 )
BEGIN
    INSERT dbo.CMN_LookupType(CMN_LookupTypeId,LookupTypeDescription,IsActive,UTCCreatedOn,CreatedByRef,UTCLastUpdatedOn,LastUpdatedByRef)
    VALUES (55,N'CMS Transaction Status',1,GETUTCDATE(),1,GETUTCDATE(),1)

    INSERT dbo.CMN_LookupTypeHistory(CMN_LookupTypeRef,LookupTypeDescription,IsActive,UTCCreatedOn,CreatedByRef,UTCLastUpdatedOn,LastUpdatedByRef,UTCHistoryCreatedOn,HistoryCreatedByRef,SaveAttempt,LockedByRef,UTCLockedOn)
    Select CMN_LookupTypeId,LookupTypeDescription,IsActive,UTCCreatedOn,CreatedByRef,UTCLastUpdatedOn,LastUpdatedByRef,GETUTCDATE(),1,0,NULL,NULL From CMN_LookupType Where CMN_LookupTypeId = 55
END
GO

IF NOT EXISTS (SELECT * FROM dbo.CMN_LookupType WHERE CMN_LookupTypeId=56 )
BEGIN
    INSERT dbo.CMN_LookupType(CMN_LookupTypeId,LookupTypeDescription,IsActive,UTCCreatedOn,CreatedByRef,UTCLastUpdatedOn,LastUpdatedByRef)
    VALUES (56,N'Background Process Status',1,GETUTCDATE(),1,GETUTCDATE(),1)

    INSERT dbo.CMN_LookupTypeHistory(CMN_LookupTypeRef,LookupTypeDescription,IsActive,UTCCreatedOn,CreatedByRef,UTCLastUpdatedOn,LastUpdatedByRef,UTCHistoryCreatedOn,HistoryCreatedByRef,SaveAttempt,LockedByRef,UTCLockedOn)
    Select CMN_LookupTypeId,LookupTypeDescription,IsActive,UTCCreatedOn,CreatedByRef,UTCLastUpdatedOn,LastUpdatedByRef,GETUTCDATE(),1,0,NULL,NULL From CMN_LookupType Where CMN_LookupTypeId = 56
END
GO
IF NOT EXISTS (SELECT * FROM dbo.CMN_LookupType WHERE CMN_LookupTypeId=57 )
BEGIN
    INSERT INTO dbo.CMN_LookupType(CMN_LookupTypeId, LookupTypeDescription, IsActive, UTCCreatedOn, CreatedByRef, UTCLastUpdatedOn, LastUpdatedByRef)
    VALUES (57,'Verified Root Cause', 1, GETUTCDATE(), 1, GETUTCDATE(), 1)

    INSERT INTO dbo.CMN_LookupTypeHistory(CMN_LookupTypeRef, LookupTypeDescription, IsActive, UTCCreatedOn, CreatedByRef, UTCLastUpdatedOn, LastUpdatedByRef, UTCHistoryCreatedOn, HistoryCreatedByRef,SaveAttempt)
    Select CMN_LookupTypeId, LookupTypeDescription, IsActive, UTCCreatedOn, CreatedByRef, UTCLastUpdatedOn, LastUpdatedByRef,GETUTCDATE(),1,0 From CMN_LookupType Where CMN_LookupTypeId = 57
END
GO
IF NOT EXISTS (SELECT * FROM dbo.CMN_LookupType WHERE CMN_LookupTypeId=58 )
BEGIN
    INSERT INTO dbo.CMN_LookupType(CMN_LookupTypeId, LookupTypeDescription, IsActive, UTCCreatedOn, CreatedByRef, UTCLastUpdatedOn, LastUpdatedByRef)
    VALUES (58,'MARx Address Completed', 1, GETUTCDATE(), 1, GETUTCDATE(), 1)

    INSERT INTO dbo.CMN_LookupTypeHistory(CMN_LookupTypeRef, LookupTypeDescription, IsActive, UTCCreatedOn, CreatedByRef, UTCLastUpdatedOn, LastUpdatedByRef, UTCHistoryCreatedOn, HistoryCreatedByRef,SaveAttempt)
    Select CMN_LookupTypeId, LookupTypeDescription, IsActive, UTCCreatedOn, CreatedByRef, UTCLastUpdatedOn, LastUpdatedByRef,GETUTCDATE(),1,0 From CMN_LookupType Where CMN_LookupTypeId = 58
END
GO

IF NOT EXISTS (SELECT * FROM dbo.CMN_LookupType WHERE CMN_LookupTypeId=59 )
BEGIN
    INSERT INTO dbo.CMN_LookupType(CMN_LookupTypeId, LookupTypeDescription, IsActive, UTCCreatedOn, CreatedByRef, UTCLastUpdatedOn, LastUpdatedByRef)
    VALUES (59,'Macro Status', 1, GETUTCDATE(), 1, GETUTCDATE(), 1)

    INSERT INTO dbo.CMN_LookupTypeHistory(CMN_LookupTypeRef, LookupTypeDescription, IsActive, UTCCreatedOn, CreatedByRef, UTCLastUpdatedOn, LastUpdatedByRef, UTCHistoryCreatedOn, HistoryCreatedByRef,SaveAttempt)
    Select CMN_LookupTypeId, LookupTypeDescription, IsActive, UTCCreatedOn, CreatedByRef, UTCLastUpdatedOn, LastUpdatedByRef,GETUTCDATE(),1,0 From CMN_LookupType Where CMN_LookupTypeId = 59
END
GO

IF NOT EXISTS (SELECT * FROM dbo.CMN_LookupType WHERE CMN_LookupTypeId=60 )
BEGIN
    INSERT INTO dbo.CMN_LookupType(CMN_LookupTypeId, LookupTypeDescription, IsActive, UTCCreatedOn, CreatedByRef, UTCLastUpdatedOn, LastUpdatedByRef)
    VALUES (60,'Onshore Only Employers', 1, GETUTCDATE(), 1, GETUTCDATE(), 1)

    INSERT INTO dbo.CMN_LookupTypeHistory(CMN_LookupTypeRef, LookupTypeDescription, IsActive, UTCCreatedOn, CreatedByRef, UTCLastUpdatedOn, LastUpdatedByRef, UTCHistoryCreatedOn, HistoryCreatedByRef,SaveAttempt)
    Select CMN_LookupTypeId, LookupTypeDescription, IsActive, UTCCreatedOn, CreatedByRef, UTCLastUpdatedOn, LastUpdatedByRef,GETUTCDATE(),1,0 From CMN_LookupType Where CMN_LookupTypeId = 60
END
GO

IF NOT EXISTS (SELECT * FROM dbo.CMN_LookupType WHERE CMN_LookupTypeId=61)
BEGIN
    INSERT INTO dbo.CMN_LookupType(CMN_LookupTypeId, LookupTypeDescription, IsActive, UTCCreatedOn, CreatedByRef, UTCLastUpdatedOn, LastUpdatedByRef)
    VALUES (61,'Macro Type', 1, GETUTCDATE(), 1, GETUTCDATE(), 1)

    INSERT INTO dbo.CMN_LookupTypeHistory(CMN_LookupTypeRef, LookupTypeDescription, IsActive, UTCCreatedOn, CreatedByRef, UTCLastUpdatedOn, LastUpdatedByRef, UTCHistoryCreatedOn, HistoryCreatedByRef,SaveAttempt)
    Select CMN_LookupTypeId, LookupTypeDescription, IsActive, UTCCreatedOn, CreatedByRef, UTCLastUpdatedOn, LastUpdatedByRef,GETUTCDATE(),1,0 From CMN_LookupType Where CMN_LookupTypeId = 61
END
GO