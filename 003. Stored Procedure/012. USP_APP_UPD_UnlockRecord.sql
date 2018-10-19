IF OBJECT_ID ('USP_APP_UPD_UnlockRecord') IS NOT NULL 
BEGIN
	DROP PROC [dbo].[USP_APP_UPD_UnlockRecord]
END
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author: Sourabha Ranjan Barik
-- Create date: 06/13/2017
-- Modified By: 
-- Modification Date: 
-- Description: SP used to unlock record in any table based on GUID
-- Eg.
-- Declare @ErrorMessage VARCHAR(2000)
-- Set @ErrorMessage=''
-- Exec [USP_APP_UPD_UnlockRecord] @ErrorMessage = @ErrorMessage Output
-- =============================================
CREATE PROC [dbo].[USP_APP_UPD_UnlockRecord]
@ScreenLkup bigint,
@CaseId bigint,
@ErrorMessage varchar(2000) OUTPUT
As
BEGIN
	BEGIN TRY

		DECLARE @UTCDATE datetime
		SET @UTCDATE = GETUTCDATE()

		DECLARE @query NVARCHAR(MAX)=null

		DECLARE @TableName varchar(200)
		DECLARE @PKColumn varchar(200)
		Select @TableName = LookupValue1, @PKColumn = LookupValue2 From CMN_LookupMaster Where CMN_LookupMasterId = @ScreenLkup			

		BEGIN TRAN

			DELETE FROM CMN_RecordsLocked WHERE [ScreenLkup]=@ScreenLkup AND [CaseId]=@CaseId

			SET @query = N'UPDATE '+Cast(@TableName As Varchar(200))+'
						   SET LockedByRef = NULL,
							   UTCLockedOn = NULL
						   WHERE '+Cast(@PKColumn As Varchar(200))+' = '+Cast(@CaseId As Varchar(10))+''

			EXEC sp_executesql @query

		COMMIT TRAN
	END TRY 

	BEGIN CATCH
		Begin Try Rollback Tran; End Try Begin Catch End Catch

		SET @ErrorMessage= ERROR_MESSAGE();
	END CATCH
END
GO


