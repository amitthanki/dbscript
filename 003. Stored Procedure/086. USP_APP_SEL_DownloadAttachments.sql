USE [ERS]
GO
/****** Object:  StoredProcedure [dbo].[USP_APP_SEL_DownloadAttachments]    Script Date: 02/03/2018 1:04:55 PM ******/
IF OBJECT_ID ('USP_APP_SEL_DownloadAttachments') IS NOT NULL 
DROP PROC [DBO].[USP_APP_SEL_DownloadAttachments]
GO

/****** Object:  StoredProcedure [dbo].[USP_APP_SEL_DownloadAttachments]    Script Date: 02/03/2018 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: Rakesh
-- Create date: 02/03/2018
-- Modified By: 
-- Modification Date: 
-- Description: 
-- Eg.
-- Declare @ErrorMessage VARCHAR(2000)
-- Set @ErrorMessage=''
-- Exec [dbo].[USP_APP_SEL_DownloadAttachments]  @ErrorMessage = @ErrorMessage Output
-- =============================================
CREATE PROCEDURE [dbo].[USP_APP_SEL_DownloadAttachments] 
(
  @GEN_AttachmentsId BIGINT
  ,@ErrorMessage VARCHAR(2000) OUT
)
 As
BEGIN
	BEGIN TRY
      SELECT  GA.[GEN_AttachmentsId] AS [ID]
			 ,GA.[FileName] 
			 ,GA.[FilePath]
	    FROM [dbo].[GEN_Attachments] GA WITH(NOLOCK)
	   WHERE GA.[GEN_AttachmentsId] = @GEN_AttachmentsId AND GA.[IsActive] = 1
	   	END TRY

	BEGIN CATCH
		SET @ErrorMessage = Error_Message();
	END CATCH
END