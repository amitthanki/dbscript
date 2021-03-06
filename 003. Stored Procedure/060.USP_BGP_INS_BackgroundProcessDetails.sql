IF OBJECT_ID ('USP_BGP_INS_BackgroundProcessDetails') IS NOT NULL 
BEGIN
	DROP PROC [dbo].[USP_BGP_INS_BackgroundProcessDetails]
END
GO
/****** Object:  StoredProcedure [dbo].[USP_BGP_INS_BackgroundProcessDetails]    Script Date: 8/7/2017 4:32:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:Amit Thanki
-- Create date: 07/27/2017
-- Modified By: 
-- Modification Date: 
-- Description: Insert BG Process details to DB
-- Eg.
-- Declare @ErrorMessage VARCHAR(2000)
-- Set @ErrorMessage=''
-- Exec [USP_BGP_INSERT_BackgroundProcessDetails] @ErrorMessage = @ErrorMessage Output
-- =============================================
CREATE PROCEDURE [dbo].[USP_BGP_INS_BackgroundProcessDetails]
@CMN_BackgroundProcessMasterRef bigint
,@GEN_QueueRef bigint = NULL
,@GEN_BulkImportRef bigint = NULL
,@GEN_FDRUploadStagingRef bigint = NULL
,@UploadFileName varchar(2000) = NULL
,@BGPRecordStatusLkup bigint = NULL
,@FailureReason varchar(4000) = NULL
,@ErrorMessage as varchar(2000) OUTPUT 
AS
BEGIN
BEGIN TRY

	Declare @UTCDate datetime=GETUTCDATE()

	INSERT INTO [dbo].[CMN_BackgroundProcessDetails]
			   ([CMN_BackgroundProcessMasterRef]
			   ,[GEN_QueueRef]
			   ,[GEN_BulkImportRef]
			   ,[GEN_FDRUploadStagingRef]
			   ,[UploadFileName]             
			   ,[BGPRecordStatusLkup]          
			   ,[FailureReason]
			   ,[IsActive]
			   ,[UTCCreatedOn])
		 VALUES
			   (@CMN_BackgroundProcessMasterRef
			   ,@GEN_QueueRef
			   ,@GEN_BulkImportRef
			   ,@GEN_FDRUploadStagingRef
			   ,@UploadFileName
			   ,@BGPRecordStatusLkup  
			   ,@FailureReason
			   ,1
			   ,@UTCDate)

END TRY

BEGIN CATCH
SET @ErrorMessage = Error_Message();
END CATCH

END 