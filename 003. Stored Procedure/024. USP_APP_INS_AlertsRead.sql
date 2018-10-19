IF OBJECT_ID ('USP_APP_INS_AlertsRead') IS NOT NULL
BEGIN 
	DROP PROC [dbo].[USP_APP_INS_AlertsRead]
END
GO

/****** Object:  StoredProcedure [dbo].[USP_APP_INS_AlertsRead]  ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author: Harsh Kumar Singhi
-- Create date: 14/06/2017
-- Modified By: 
-- Modification Date: 
-- Description: Insert the alerts read into the alerts read table in Db
-- declare @ErrorMessage VARCHAR(2000)
-- Eg: Exec [USP_APP_INS_AlertsRead] 1, @ErrorMessage out
-- =============================================
CREATE PROC [dbo].[USP_APP_INS_AlertsRead]
@ADM_AlertDetailsId BIGINT,
@LoginUserId BIGINT,
@ErrorMessage VARCHAR(2000) OUT
As
BEGIN
	BEGIN TRY
		INSERT INTO ADM_AlertsRead (ADM_AlertDetailsRef,ADM_UserMasterRef,IsActive,UTCCreatedOn,CreatedByRef) 
		Values(@ADM_AlertDetailsId,@LoginUserId,1,GETUTCDATE(),@LoginUserId)
	END TRY  
	                  
	BEGIN CATCH
		SET @ErrorMessage = Error_Message();
	END CATCH
END
GO