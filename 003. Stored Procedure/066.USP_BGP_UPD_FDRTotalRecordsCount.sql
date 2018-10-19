IF OBJECT_ID ('USP_BGP_UPD_FDRTotalRecordsCount') IS NOT NULL 
BEGIN
	DROP PROC [dbo].[USP_BGP_UPD_FDRTotalRecordsCount]
END
GO
/****** Object:  StoredProcedure [dbo].[USP_BGP_UPD_FDRTotalRecordsCount]    Script Date: 8/10/2017 11:51:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:Amit Thanki
-- Create date: 08/10/2017
-- Modified By: 
-- Modification Date: 
-- Description: Check Total Record count
-- =============================================
CREATE PROCEDURE [dbo].[USP_BGP_UPD_FDRTotalRecordsCount]
@GEN_FDRBulkImportId bigint,
@ImportStatusLkup bigint,
@ErrorMessage VARCHAR(2000) OUT
As
BEGIN
       BEGIN TRY
              BEGIN TRAN   
                              DECLARE @TotalRecord bigint 
                              DECLARE @IsDuplicate bigint                           
                              DECLARE @IsInvalid bigint 
                              DECLARE @ValidRecord bigint 
                                         
                         If(@ImportStatusLkup = 41003)
                   BEGIN         
                              select @TotalRecord = COUNT(*), 
                                     @IsDuplicate = COUNT(Case When IsDuplicate = 1 Then 1 END),
                                     @IsInvalid   = COUNT(Case When IsInvalid = 1 Then 1 END) ,
                                     @ValidRecord = COUNT(CASE When IsDuplicate = 0 And IsInValid = 0 Then 1 END)
                               from GEN_FDRStaging  where GEN_FDRBulkImportRef = @GEN_FDRBulkImportId              
                                                                                                                            
                              Update GEN_FDRBulkImport set TotalRecordsCount = @TotalRecord,
                                                           InvalidRecordsCount = @IsInvalid,
                                                           DuplicateRecordCount = @IsDuplicate,
                                                           ValidRecordCount = @ValidRecord,
                                                           ImportStatusLkup = @ImportStatusLkup
                               where GEN_FDRBulkImportId = @GEN_FDRBulkImportId;
                     END
                         ELSE
                   BEGIN
                              Update GEN_FDRBulkImport set ImportStatusLkup = @ImportStatusLkup where GEN_FDRBulkImportId = @GEN_FDRBulkImportId;
                     END
                       
              COMMIT TRAN
       END TRY
BEGIN CATCH
       Rollback TRAN
       SET @ErrorMessage = Error_Message();
END CATCH     
END
