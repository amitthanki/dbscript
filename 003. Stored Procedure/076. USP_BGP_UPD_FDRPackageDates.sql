IF OBJECT_ID ('USP_BGP_UPD_FDRPackageDates') IS NOT NULL 
BEGIN
	DROP PROC [dbo].[USP_BGP_UPD_FDRPackageDates]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: Pradeep
-- Create date: 09/14/2017
-- Modified By: 
-- Modification Date: 
-- Description: Update FDR package dates
-- Eg.
-- Declare @ErrorMessage VARCHAR(2000)
-- Set @ErrorMessage=''
-- Exec [USP_BGP_UPD_FDRPackageDates] @ErrorMessage = @ErrorMessage Output
-- =============================================
CREATE PROCEDURE [dbo].[USP_BGP_UPD_FDRPackageDates]
@FDRSubmissionCategoryLkup BIGINT,
@CaseIds VARCHAR(MAX)=NULL,
@LoginUserId BIGINT,
@ErrorMessage VARCHAR(2000) OUT
AS
BEGIN
BEGIN TRY  
		BEGIN TRAN FDRPackageDates
			Declare @UTCDate DATETIME = GETUTCDATE()
			Declare @UTCDateId BIGINT = FORMAT(@UTCDate, 'yyyyMMdd')

			Declare @Cases Table([GenQueueRef] BIGINT)
			INSERT INTO @Cases SELECT * FROM  [dbo].[SplitString](@CaseIds,',') where item <> ''

			--Update dates
			DECLARE @tempErsCaseId BIGINT
			DECLARE GenQueueRef_Cursor CURSOR FOR  
			SELECT [GenQueueRef] FROM @Cases
			OPEN GenQueueRef_Cursor;  
			FETCH NEXT FROM GenQueueRef_Cursor INTO @tempErsCaseId;
			WHILE @@FETCH_STATUS = 0  
				BEGIN
					UPDATE [dbo].[GEN_RPRActions] SET [FDRPackageDate] = @UTCDate,[FDRPackageDateId] = @UTCDateId,FDRSubmissionCategoryLkup = @FDRSubmissionCategoryLkup
					WHERE [GEN_QueueRef] = @tempErsCaseId
					FETCH NEXT FROM GenQueueRef_Cursor INTO @tempErsCaseId;
				END;  
			CLOSE GenQueueRef_Cursor;
			DEALLOCATE GenQueueRef_Cursor;  

		COMMIT TRAN FDRPackageDates
	END TRY
	BEGIN CATCH		
		ROLLBACK TRAN FDRPackageDates;
		INSERT INTO [dbo].[CMN_AppErrorLog] (ADM_UserMasterRef,[ErrorLocation],[ErrorSourceLkup],[ErrorMessage],[ErrorDescription],[UTCErrorDateTime],[UTCCreatedOn])
		VALUES(@LoginUserId,'[dbo].[USP_BGP_UPD_FDRPackageDates]',null,ERROR_NUMBER(),ERROR_MESSAGE(),GETUTCDATE(),GETUTCDATE())
	END CATCH 
END