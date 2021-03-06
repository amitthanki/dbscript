IF OBJECT_ID ('USP_APP_UPD_AutoUnlockRecords') IS NOT NULL 
BEGIN
	DROP PROC [dbo].[USP_APP_UPD_AutoUnlockRecords]
END
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author: Pradeep Patil
-- Create date: 10/13/2017
-- Modified By: 
-- Modification Date: 
-- Description: SP to unlock records, locked for more than 2 hours
-- Eg.
-- Declare @ErrorMessage VARCHAR(2000)
-- Set @ErrorMessage=''
-- Exec [USP_APP_UPD_AutoUnlockRecords] @ErrorMessage = @ErrorMessage Output
-- =============================================
CREATE PROC [dbo].[USP_APP_UPD_AutoUnlockRecords]

@ErrorMessage varchar(2000) OUTPUT
As
BEGIN
	BEGIN TRY
		BEGIN TRAN

			DECLARE @UTCDATE DATETIME = GETUTCDATE();

			DECLARE @AutoUnlockHours INT;

			Set @AutoUnlockHours = TRY_CAST((select [ConfigValue] From [dbo].[MGR_ConfigMaster] Where IsActive = 1 And [ConfigName] = 'AutoUnlockRecordHours' ) AS INT ) --Configuration value for autlock period

			IF(@AutoUnlockHours IS NULL)
				BEGIN
					SET @AutoUnlockHours = 2; --Default unlock period
				END 
			
			UPDATE [dbo].[GEN_Queue] SET
			[LockedByRef]=NULL
			,[UTCLockedOn]=NULL
			,[UTCLockedOnId]=NULL
			,[UTCLockedOnYear]=NULL
			,[UTCLockedOnMonth]=NULL
			,[UTCLockedOnDay]=NULL
			,[CSTLockedOn]=NULL
			,[CSTLockedOnId]=NULL
			,[CSTLockedOnYear]=NULL
			,[CSTLockedOnMonth]=NULL
			,[CSTLockedOnDay]=NULL
			WHERE UTCLockedOn <= DATEADD(HH,-@AutoUnlockHours,@UTCDATE)

			DELETE FROM CMN_RecordsLocked WHERE 
			[ScreenLkup]=37010 --Unlock only gen_queue records
			AND [StartTime] <= DATEADD(HH,-@AutoUnlockHours,@UTCDATE)

		COMMIT TRAN
	END TRY 

	BEGIN CATCH
		Rollback Tran;
		INSERT INTO [dbo].[CMN_AppErrorLog] (ADM_UserMasterRef,[ErrorLocation],[ErrorSourceLkup],[ErrorMessage],[ErrorDescription],[UTCErrorDateTime],[UTCCreatedOn])
		VALUES(0,'[dbo].[USP_APP_UPD_AutoUnlockRecords]',null,ERROR_NUMBER(),ERROR_MESSAGE(),GETUTCDATE(),GETUTCDATE())
		SET @ErrorMessage= ERROR_MESSAGE();
	END CATCH
END
GO