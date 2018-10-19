IF OBJECT_ID ('USP_BGP_SEL_FDR_BulkImportPath') IS NOT NULL 
BEGIN
	DROP PROC [dbo].[USP_BGP_SEL_FDR_BulkImportPath]
END
GO
/****** Object:  StoredProcedure [dbo].[USP_BGP_SEL_FDR_BulkImportPath]    Script Date: 8/7/2017 10:56:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:Amit Thanki
-- Create date: 08/07/2017
-- Modified By: 
-- Modification Date: 
-- Description: get FDRBulkImportId and Excel File Path With Status ReadyforImport.
-- =============================================
CREATE PROCEDURE [dbo].[USP_BGP_SEL_FDR_BulkImportPath]
@GEN_FDRBulkImportId bigint OUT,
@ExcelFilePath VARCHAR(2000)OUT,
@ErrorMessage VARCHAR(2000) OUT
As
BEGIN
       BEGIN TRY
              BEGIN TRAN                 
			               SET @GEN_FDRBulkImportId = 0
                     select Top 1 @GEN_FDRBulkImportId = GEN_FDRBulkImportId,@ExcelFilePath = ExcelFilelPath from GEN_FDRBulkImport WITH(NOLOCK)
                      Where ImportStatusLkup = 41001 And LockedByRef Is NULL; -- Ready for Import

              COMMIT TRAN
       END TRY
BEGIN CATCH
       Rollback TRAN
       SET @ErrorMessage = Error_Message();
END CATCH     
END