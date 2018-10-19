IF OBJECT_ID ('USP_APP_SEL_Reports') IS NOT NULL 
BEGIN
	DROP PROC [dbo].[USP_APP_SEL_Reports]
END
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:Venkata Sourabha Ranjan Barik
-- Create date: 14/06/2017
-- Modified By: 
-- Modification Date: 
-- Description:To get accessgroup details.
-- Eg.
-- Declare @ErrorMessage VARCHAR(2000)
-- Set @ErrorMessage=''
-- Exec [USP_APP_SEL_Reports] @ErrorMessage = @ErrorMessage Output
-- =============================================
CREATE PROC [dbo].[USP_APP_SEL_Reports]
@RPT_ReportsMasterId BIGINT = NULL,
@ReportName VARCHAR(250) = NULL,
@ErrorMessage VARCHAR(2000) OUT
As
BEGIN
	BEGIN TRY
		SELECT [RPT_ReportsMasterId]
			  ,[ReportName]
			  ,[ReportServer]
			  ,[ReportURL]
			  ,[ReportsCategoryLkup]
			  ,[ViewInUI]
			  ,[IsActive]
			  ,[UTCCreatedOn]
			  ,[CreatedByRef]
		FROM [dbo].[RPT_ReportsMaster] with(NoLock)
		WHERE IsActive=1
				And (@RPT_ReportsMasterId Is NULL Or RPT_ReportsMasterId = @RPT_ReportsMasterId)
				And (@ReportName Is NULL Or ReportName = @ReportName)
	END TRY

	BEGIN CATCH
		SET @ErrorMessage = Error_Message();
	END CATCH
END
GO 




