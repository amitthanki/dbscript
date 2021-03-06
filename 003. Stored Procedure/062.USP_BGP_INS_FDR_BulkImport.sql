IF OBJECT_ID ('USP_BGP_INS_FDR_BulkImport') IS NOT NULL 
BEGIN
	DROP PROC [dbo].[USP_BGP_INS_FDR_BulkImport]
END
GO
/****** Object:  StoredProcedure [dbo].[USP_BGP_INS_FDR_BulkImport]    Script Date: 8/7/2017 10:56:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:Amit Thanki
-- Create date: 08/03/2017
-- Modified By: 
-- Modification Date: 
-- Description:To insert FDR Bulk Import
-- =============================================
CREATE PROCEDURE [dbo].[USP_BGP_INS_FDR_BulkImport]
@SubmissionId VARCHAR(100) = NULL,
@ContractNumber VARCHAR(100) = NULL,
@TransactionType VARCHAR(2000) = NULL,
@ExcelFileName VARCHAR(2000) = NULL,
@ExcelFilePath VARCHAR(2000),
@ImportStatusLkup bigint = null,
@IsActive BIT = 1,
@ErrorMessage VARCHAR(2000) OUT
As
BEGIN
       BEGIN TRY
              BEGIN TRAN 
                     --Set Current UTC Datetime
                     DECLARE @UTCDATE datetime
                     SET @UTCDATE = GETUTCDATE()
                     DECLARE @TransactionTypeLkup bigint
                     DECLARE @ContractNumberLkup bigint       
                     
                     select @TransactionTypeLkup = CMN_LookupMasterID  from CMN_LookupMaster where CMN_LookupTypeRef = 43 And LookupValue = @TransactionType;

                     select @ContractNumberLkup = CMN_LookupMasterID  from CMN_LookupMaster where CMN_LookupTypeRef = 11 And LookupValue = @ContractNumber;
                     
					 if(@TransactionTypeLkup IS NOT NULL And @ContractNumberLkup  IS NOT NULL)
					 Begin 
                     --Insert into Gen_FDRBulkImport table    
                     INSERT INTO GEN_FDRBulkImport(SubmissionId,ContractNumberLkup,TransactionTypeLkup,ExcelFileName,ExcelFilelPath,ImportStatusLkup,IsActive,UTCCreatedOn)
                     VALUES(@SubmissionId,@ContractNumberLkup,@TransactionTypeLkup,@ExcelFileName,@ExcelFilePath,@ImportStatusLkup,@IsActive,@UTCDATE)
					 End
					 else
					 Begin
					    SET @ErrorMessage = 'Transaction Type or Contract Number Missing';
					 End
              COMMIT TRAN
       END TRY
BEGIN CATCH
       Rollback TRAN
       SET @ErrorMessage = Error_Message();
END CATCH     
END