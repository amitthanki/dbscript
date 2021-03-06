IF OBJECT_ID ('USP_APP_INS_GEN_BulkImport') IS NOT NULL 
BEGIN
	DROP PROC [dbo].[USP_APP_INS_GEN_BulkImport]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: Anil Kumar Sahoo
-- Create date: 07/24/2017
-- Modified By: 
-- Modification Date: 
-- Description: Insert a record for bulkupload file,
-- Eg.
-- Declare @ErrorMessage VARCHAR(2000)
-- Set @ErrorMessage=''
-- Exec [dbo].[USP_APP_INS_GEN_BulkImport] @ErrorMessage = @ErrorMessage Output
-- =============================================
CREATE PROCEDURE [dbo].[USP_APP_INS_GEN_BulkImport]
(
   @WorkBasketLkup                       BIGINT
  ,@DiscrepancyCategoryLkup              BIGINT
  ,@GEN_BulkImportExcelTemplateMasterRef BIGINT
  ,@ExcelFileName                        VARCHAR(250)
  ,@DuplicateFileName                    VARCHAR(250)
  ,@ExcelFilelPath                       VARCHAR(2000)
  ,@ImportStatusLkup                     BIGINT
  ,@LoginUserId                          BIGINT
  ,@ErrorMessage VARCHAR(2000)           OUT
)
AS
BEGIN

	BEGIN TRY  
	BEGIN TRAN BulkImport

		INSERT INTO [dbo].[GEN_BulkImport]
			   ([WorkBasketLkup],[DiscrepancyCategoryLkup],[GEN_BulkImportExcelTemplateMasterRef],[ExcelFileName],[DuplicateFileName],[ExcelFilelPath]
			   ,[ImportStatusLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef])
		 VALUES
			   (@WorkBasketLkup,@DiscrepancyCategoryLkup,@GEN_BulkImportExcelTemplateMasterRef,@ExcelFileName,@DuplicateFileName,@ExcelFilelPath
			   ,@ImportStatusLkup,1,GETUTCDATE(),@LoginUserId,GETUTCDATE(),@LoginUserId)

	COMMIT TRAN BulkImport
	END TRY
	BEGIN CATCH
		ROLLBACK TRAN BulkImport
		INSERT INTO [dbo].[CMN_AppErrorLog](ADM_UserMasterRef,[ErrorLocation],[ErrorSourceLkup],[ErrorMessage],[ErrorDescription],[UTCErrorDateTime],[UTCCreatedOn])
		VALUES(@LoginUserId,'[dbo].[USP_APP_INS_GEN_BulkImport]',null,ERROR_NUMBER(),ERROR_MESSAGE(),GETUTCDATE(),GETUTCDATE())
		SET @ErrorMessage=ERROR_MESSAGE()
	END CATCH  
END