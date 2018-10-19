IF OBJECT_ID ('TRG_UPD_CMN_RecordsLocked') IS NOT NULL 
BEGIN
	DROP TRIGGER [dbo].[TRG_UPD_CMN_RecordsLocked]
END
GO
/****** Object:  Trigger [dbo].[TRG_UPD_CMN_RecordsLocked]    Script Date: 8/17/2017 3:16:59 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE TRIGGER [dbo].[TRG_UPD_CMN_RecordsLocked]
  ON [dbo].[CMN_RecordsLocked]
  AFTER INSERT
  AS

IF EXISTS(SELECT * FROM INSERTED)
INSERT INTO [dbo].[CMN_RecordsLockedHistory]
            (
				[CMN_RecordsLockedRef],
				[ScreenLkup],
				[CaseId],
				[StartTime],
				[EndTime],
				[Guid],
				[IsActive],
				[UTCCreatedOn],
				[CreatedByRef],
				[UTCLastUpdatedOn],
				[LastUpdatedByRef],				
				[HistoryCreatedByRef]
			)
        SELECT	[CMN_RecordsLockedId],
				[ScreenLkup],
				[CaseId],
				[StartTime],
				[EndTime],
				[Guid],
				[IsActive],
				[UTCCreatedOn],
				[CreatedByRef],
				[UTCLastUpdatedOn],
				[LastUpdatedByRef],
				[CreatedByRef]
			FROM INSERTED
GO