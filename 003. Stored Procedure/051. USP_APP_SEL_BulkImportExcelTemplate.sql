IF OBJECT_ID ('USP_APP_SEL_BulkImportExcelTemplate') IS NOT NULL 
BEGIN
	DROP PROC [dbo].[USP_APP_SEL_BulkImportExcelTemplate]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:Anil Kumar Sahoo
-- Create date: 07/22/2017
-- Modified By: 
-- Modification Date: 
-- Description:To Get Master Execel Template and mapping columns to put in Cache
-- Eg.
-- Declare @ErrorMessage VARCHAR(2000)
-- Set @ErrorMessage=''
-- Exec [dbo].[USP_APP_SEL_BulkImportExcelTemplate] @ErrorMessage = @ErrorMessage Output
-- =============================================
CREATE PROC [dbo].[USP_APP_SEL_BulkImportExcelTemplate]
@ErrorMessage Varchar(2000) OUTPUT
As
BEGIN
	BEGIN TRY
		SELECT [GEN_BulkImportExcelTemplateMasterId],[WorkBasketLkup],[DiscrepancyCategoryLkup],[ExcelTemplateName],[ExcelTemplateDescription],[SheetName],[StartRow],[StartColumn]
			  ,[ExcelDirectoryPath],[IsActive],[CustomValidationSP],[StagingTableName],[StagingInsertSPName],[StagingUpdateSPName],[StagingInsertTVPName],[StagingUpdateTVPName]
			  ,[UTCCreatedOn],[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef]
		  FROM [dbo].[GEN_BulkImportExcelTemplateMaster] with(nolock)
		 WHERE [IsActive]=1
		
		SELECT [GEN_BulkImportColumnsMappingId],[GEN_BulkImportColumnsMappingParentRef],[GEN_BulkImportExcelTemplateMasterRef],[ColumnTypeLkup],[DBColumnName],[ColumnDisplayName]
			  ,[MaxLength],[ColumnSequence],[ControlTypeLkup],[ControlLkupValue],[IsUniqueKey],[IsActive],[UTCCreatedOn],[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef]
		  FROM [dbo].[GEN_BulkImportColumnsMapping] with(nolock)
		 WHERE [IsActive]=1
	END TRY
	BEGIN CATCH
		   SET @ErrorMessage= ERROR_MESSAGE();
	END CATCH  
END
