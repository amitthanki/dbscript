IF NOT EXISTS (SELECT * FROM dbo.CMN_LookupTypeCorrelations WHERE CMN_LookupTypeCorrelationsId = 1)
BEGIN
    INSERT CMN_LookupTypeCorrelations (CMN_LookupTypeCorrelationsId,CMN_LookupTypeParentRef,CMN_LookupTypeChildRef,GroupingLookupTypeRef,CorrelationDescription,IsActive,UTCCreatedOn,CreatedByRef,UTCLastUpdatedOn,LastUpdatedByRef)
    VALUES (1,3,6,NULL,'Work Basket Vs Discrepancy Category', 1, GETUTCDATE(), 1, GETUTCDATE(), 1)

    INSERT CMN_LookupTypeCorrelationsHistory (CMN_LookupTypeCorrelationsRef,CMN_LookupTypeParentRef,CMN_LookupTypeChildRef,GroupingLookupTypeRef,CorrelationDescription,IsActive,UTCCreatedOn,CreatedByRef,UTCLastUpdatedOn,LastUpdatedByRef,UTCHistoryCreatedOn,HistoryCreatedByRef,SaveAttempt)
    Select CMN_LookupTypeCorrelationsId,CMN_LookupTypeParentRef,CMN_LookupTypeChildRef,GroupingLookupTypeRef,CorrelationDescription,IsActive,UTCCreatedOn,CreatedByRef,UTCLastUpdatedOn,LastUpdatedByRef,GETUTCDATE(),1,0 From CMN_LookupTypeCorrelations Where CMN_LookupTypeCorrelationsId = 1
END
GO

IF NOT EXISTS (SELECT * FROM dbo.CMN_LookupTypeCorrelations WHERE CMN_LookupTypeCorrelationsId = 2)
BEGIN
    INSERT CMN_LookupTypeCorrelations (CMN_LookupTypeCorrelationsId,CMN_LookupTypeParentRef,CMN_LookupTypeChildRef,GroupingLookupTypeRef,CorrelationDescription,IsActive,UTCCreatedOn,CreatedByRef,UTCLastUpdatedOn,LastUpdatedByRef)
    VALUES (2,6,7,NULL,'Discrepancy Category Vs Discrepancy Type', 1, GETUTCDATE(), 1, GETUTCDATE(), 1)

    INSERT CMN_LookupTypeCorrelationsHistory (CMN_LookupTypeCorrelationsRef,CMN_LookupTypeParentRef,CMN_LookupTypeChildRef,GroupingLookupTypeRef,CorrelationDescription,IsActive,UTCCreatedOn,CreatedByRef,UTCLastUpdatedOn,LastUpdatedByRef,UTCHistoryCreatedOn,HistoryCreatedByRef,SaveAttempt)
    Select CMN_LookupTypeCorrelationsId,CMN_LookupTypeParentRef,CMN_LookupTypeChildRef,GroupingLookupTypeRef,CorrelationDescription,IsActive,UTCCreatedOn,CreatedByRef,UTCLastUpdatedOn,LastUpdatedByRef,GETUTCDATE(),1,0 From CMN_LookupTypeCorrelations Where CMN_LookupTypeCorrelationsId = 2
END
GO

IF NOT EXISTS (SELECT * FROM dbo.CMN_LookupTypeCorrelations WHERE CMN_LookupTypeCorrelationsId = 3)
BEGIN
    INSERT CMN_LookupTypeCorrelations (CMN_LookupTypeCorrelationsId,CMN_LookupTypeParentRef,CMN_LookupTypeChildRef,GroupingLookupTypeRef,CorrelationDescription,IsActive,UTCCreatedOn,CreatedByRef,UTCLastUpdatedOn,LastUpdatedByRef)
    VALUES (3,6,10,NULL,'Discrepancy Category Vs Queue', 1, GETUTCDATE(), 1, GETUTCDATE(), 1)

    INSERT CMN_LookupTypeCorrelationsHistory (CMN_LookupTypeCorrelationsRef,CMN_LookupTypeParentRef,CMN_LookupTypeChildRef,GroupingLookupTypeRef,CorrelationDescription,IsActive,UTCCreatedOn,CreatedByRef,UTCLastUpdatedOn,LastUpdatedByRef,UTCHistoryCreatedOn,HistoryCreatedByRef,SaveAttempt)
    Select CMN_LookupTypeCorrelationsId,CMN_LookupTypeParentRef,CMN_LookupTypeChildRef,GroupingLookupTypeRef,CorrelationDescription,IsActive,UTCCreatedOn,CreatedByRef,UTCLastUpdatedOn,LastUpdatedByRef,GETUTCDATE(),1,0 From CMN_LookupTypeCorrelations Where CMN_LookupTypeCorrelationsId = 3
END
GO

IF NOT EXISTS (SELECT * FROM dbo.CMN_LookupTypeCorrelations WHERE CMN_LookupTypeCorrelationsId = 4)
BEGIN
    INSERT CMN_LookupTypeCorrelations (CMN_LookupTypeCorrelationsId,CMN_LookupTypeParentRef,CMN_LookupTypeChildRef,GroupingLookupTypeRef,CorrelationDescription,IsActive,UTCCreatedOn,CreatedByRef,UTCLastUpdatedOn,LastUpdatedByRef)
    VALUES (4,10,28,NULL,'Queue Vs Action', 1, GETUTCDATE(), 1, GETUTCDATE(), 1)

    INSERT CMN_LookupTypeCorrelationsHistory (CMN_LookupTypeCorrelationsRef,CMN_LookupTypeParentRef,CMN_LookupTypeChildRef,GroupingLookupTypeRef,CorrelationDescription,IsActive,UTCCreatedOn,CreatedByRef,UTCLastUpdatedOn,LastUpdatedByRef,UTCHistoryCreatedOn,HistoryCreatedByRef,SaveAttempt)
    Select CMN_LookupTypeCorrelationsId,CMN_LookupTypeParentRef,CMN_LookupTypeChildRef,GroupingLookupTypeRef,CorrelationDescription,IsActive,UTCCreatedOn,CreatedByRef,UTCLastUpdatedOn,LastUpdatedByRef,GETUTCDATE(),1,0 From CMN_LookupTypeCorrelations Where CMN_LookupTypeCorrelationsId = 4
END
GO

IF NOT EXISTS (SELECT * FROM dbo.CMN_LookupTypeCorrelations WHERE CMN_LookupTypeCorrelationsId = 5)
BEGIN
    INSERT CMN_LookupTypeCorrelations (CMN_LookupTypeCorrelationsId,CMN_LookupTypeParentRef,CMN_LookupTypeChildRef,GroupingLookupTypeRef,CorrelationDescription,IsActive,UTCCreatedOn,CreatedByRef,UTCLastUpdatedOn,LastUpdatedByRef)
    VALUES (5,28,18,'6','Discrepancy Category Vs Action Vs Resolution', 1, GETUTCDATE(), 1, GETUTCDATE(), 1)

    INSERT CMN_LookupTypeCorrelationsHistory (CMN_LookupTypeCorrelationsRef,CMN_LookupTypeParentRef,CMN_LookupTypeChildRef,GroupingLookupTypeRef,CorrelationDescription,IsActive,UTCCreatedOn,CreatedByRef,UTCLastUpdatedOn,LastUpdatedByRef,UTCHistoryCreatedOn,HistoryCreatedByRef,SaveAttempt)
    Select CMN_LookupTypeCorrelationsId,CMN_LookupTypeParentRef,CMN_LookupTypeChildRef,GroupingLookupTypeRef,CorrelationDescription,IsActive,UTCCreatedOn,CreatedByRef,UTCLastUpdatedOn,LastUpdatedByRef,GETUTCDATE(),1,0 From CMN_LookupTypeCorrelations Where CMN_LookupTypeCorrelationsId = 5
END
GO

IF NOT EXISTS (SELECT * FROM dbo.CMN_LookupTypeCorrelations WHERE CMN_LookupTypeCorrelationsId = 6)
BEGIN
    INSERT CMN_LookupTypeCorrelations (CMN_LookupTypeCorrelationsId,CMN_LookupTypeParentRef,CMN_LookupTypeChildRef,GroupingLookupTypeRef,CorrelationDescription,IsActive,UTCCreatedOn,CreatedByRef,UTCLastUpdatedOn,LastUpdatedByRef)
    VALUES (6,28,24,'6','Discrepancy Category Vs Action Vs Root Cause', 1, GETUTCDATE(), 1, GETUTCDATE(), 1)

    INSERT CMN_LookupTypeCorrelationsHistory (CMN_LookupTypeCorrelationsRef,CMN_LookupTypeParentRef,CMN_LookupTypeChildRef,GroupingLookupTypeRef,CorrelationDescription,IsActive,UTCCreatedOn,CreatedByRef,UTCLastUpdatedOn,LastUpdatedByRef,UTCHistoryCreatedOn,HistoryCreatedByRef,SaveAttempt)
    Select CMN_LookupTypeCorrelationsId,CMN_LookupTypeParentRef,CMN_LookupTypeChildRef,GroupingLookupTypeRef,CorrelationDescription,IsActive,UTCCreatedOn,CreatedByRef,UTCLastUpdatedOn,LastUpdatedByRef,GETUTCDATE(),1,0 From CMN_LookupTypeCorrelations Where CMN_LookupTypeCorrelationsId = 6
END
GO

IF NOT EXISTS (SELECT * FROM dbo.CMN_LookupTypeCorrelations WHERE CMN_LookupTypeCorrelationsId = 7)
BEGIN
    INSERT CMN_LookupTypeCorrelations (CMN_LookupTypeCorrelationsId,CMN_LookupTypeParentRef,CMN_LookupTypeChildRef,GroupingLookupTypeRef,CorrelationDescription,IsActive,UTCCreatedOn,CreatedByRef,UTCLastUpdatedOn,LastUpdatedByRef)
    VALUES (7,28,30,'6','Discrepancy Category Vs Action Vs Pend Reason', 1, GETUTCDATE(), 1, GETUTCDATE(), 1)

    INSERT CMN_LookupTypeCorrelationsHistory (CMN_LookupTypeCorrelationsRef,CMN_LookupTypeParentRef,CMN_LookupTypeChildRef,GroupingLookupTypeRef,CorrelationDescription,IsActive,UTCCreatedOn,CreatedByRef,UTCLastUpdatedOn,LastUpdatedByRef,UTCHistoryCreatedOn,HistoryCreatedByRef,SaveAttempt)
    Select CMN_LookupTypeCorrelationsId,CMN_LookupTypeParentRef,CMN_LookupTypeChildRef,GroupingLookupTypeRef,CorrelationDescription,IsActive,UTCCreatedOn,CreatedByRef,UTCLastUpdatedOn,LastUpdatedByRef,GETUTCDATE(),1,0 From CMN_LookupTypeCorrelations Where CMN_LookupTypeCorrelationsId = 7
END
GO