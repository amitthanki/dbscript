IF OBJECT_ID ('USP_APP_SEL_BulkImport') IS NOT NULL 
BEGIN
	DROP PROC [dbo].[USP_APP_SEL_BulkImport]
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
-- Description:
-- Eg.[dbo].[GEN_BulkImport]
-- Declare @ErrorMessage VARCHAR(2000)
-- Set @ErrorMessage=
-- Exec [USP_APP_SEL_Case] @ErrorMessage = @ErrorMessage Output
-- =============================================
CREATE PROCEDURE [dbo].[USP_APP_SEL_BulkImport] 
(
   @GEN_BulkImportId BIGINT=NULL,
   @DiscrepancyCategoryLkup BIGINT=NULL,
   @StartDate DATETIME=NULL,
   @EndDate DATETIME=NULL,
   @WorkbasketLkup BIGINT=NULL,
   @ErrorMessage VARCHAR(2000) OUT
)
AS
BEGIN
	BEGIN TRY  

		SELECT GB.[GEN_BulkImportId],GB.[WorkBasketLkup],LMWorkBasket.LookupValue 'WorkBasket',GB.[DiscrepancyCategoryLkup],LMDiscrepancyCategory.LookupValue  'DiscrepancyCategory',GB.[GEN_BulkImportExcelTemplateMasterRef],GB.[LockedByRef]
		,GB.[UTCLockedOn],GB.[ExcelFileName],GB.[DuplicateFileName],GB.[ExcelFilelPath],GB.[TotalRecordsCount],GB.[ValidRecordsCount],GB.[InvalidRecordsCount],GB.[DuplicateRecordCount],GB.[ErrorDescription]
		,GB.[ExcelStatusLkup],LMExcelStatus.LookupValue  'ExcelStatus',GB.[ImportStatusLkup],LMImportStatus.LookupValue  'ImportStatus',GB.[CMN_AppErrorLogRef],GB.[IsActive],GB.[UTCCreatedOn],GB.[CreatedByRef],UMCreatedBy.FullName 'CreatedBy',GB.[UTCLastUpdatedOn],GB.[LastUpdatedByRef],UMLastUpdatedBy.FullName 'LastUpdatedBy'
		FROM [dbo].[GEN_BulkImport] GB with(nolock)
		INNER JOIN [dbo].[CMN_LookupMaster] LMWorkBasket with(nolock) ON GB.[WorkBasketLkup]=LMWorkBasket.[CMN_LookupMasterId] And LMWorkBasket.CMN_LookupTypeRef = 3  AND LMWorkBasket.IsActive=1
		INNER JOIN [dbo].[CMN_LookupMaster] LMDiscrepancyCategory with(nolock) ON GB.[DiscrepancyCategoryLkup]=LMDiscrepancyCategory.[CMN_LookupMasterId] And LMDiscrepancyCategory.CMN_LookupTypeRef = 6 AND LMDiscrepancyCategory.IsActive=1
		LEFT JOIN [dbo].[CMN_LookupMaster] LMExcelStatus with(nolock) ON GB.[ExcelStatusLkup]=LMExcelStatus.[CMN_LookupMasterId] AND LMExcelStatus.IsActive=1
		LEFT JOIN [dbo].[CMN_LookupMaster] LMImportStatus with(nolock) ON GB.[ImportStatusLkup]=LMImportStatus.[CMN_LookupMasterId] And LMImportStatus.CMN_LookupTypeRef = 41 AND LMImportStatus.IsActive=1
		LEFT JOIN [dbo].[ADM_UserMaster] UMCreatedBy with(nolock) ON GB.[CreatedByRef]=UMCreatedBy.[ADM_UserMasterId] AND UMCreatedBy.IsActive=1
		LEFT JOIN [dbo].[ADM_UserMaster] UMLastUpdatedBy with(nolock) ON GB.[LastUpdatedByRef]=UMLastUpdatedBy.[ADM_UserMasterId] AND UMLastUpdatedBy.IsActive=1
	    WHERE (@WorkbasketLkup IS NULL OR GB.[WorkBasketLkup]=@WorkbasketLkup) AND 
		      (@GEN_BulkImportId IS NULL OR GB.[GEN_BulkImportId]=@GEN_BulkImportId) AND 
			  (@DiscrepancyCategoryLkup IS NULL OR GB.[DiscrepancyCategoryLkup]=@DiscrepancyCategoryLkup) AND
			  ((@StartDate IS NULL OR @EndDate IS NULL) OR (GB.[UTCCreatedOn] >= @StartDate AND GB.[UTCCreatedOn] <= DATEADD(dd,1,@EndDate)))
		ORDER BY GB.[GEN_BulkImportId] DESC
	END TRY
	BEGIN CATCH
		SET @ErrorMessage= ERROR_MESSAGE();
	END CATCH  
END