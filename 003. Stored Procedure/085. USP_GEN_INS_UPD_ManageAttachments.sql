IF OBJECT_ID ('USP_GEN_INS_UPD_ManageAttachments') IS NOT NULL 
DROP PROC [DBO].[USP_GEN_INS_UPD_ManageAttachments]
GO

/****** Object:  StoredProcedure [dbo].[USP_GEN_INS_UPD_ManageAttachments]    Script Date: 02/03/2018 ******/
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
-- Exec [USP_GEN_INS_UPD_ManageAttachments] @ErrorMessage = @ErrorMessage Output
-- =============================================
CREATE PROCEDURE [dbo].[USP_GEN_INS_UPD_ManageAttachments]
(
	 @GEN_AttachmentsId BIGINT=0
	,@GEN_QueueRef      BIGINT=NULL
	,@UploadedFileName  VARCHAR(200)=NULL
	,@FileName          VARCHAR(200)=NULL
	,@FilePath          VARCHAR(500)=NULL
	,@LoginUserId       BIGINT
	,@ErrorMessage      VARCHAR(2000) OUT
)
AS
BEGIN
	BEGIN TRY  
		BEGIN TRAN ERSAttachments

		IF(@GEN_AttachmentsId>0)
			BEGIN
			 UPDATE [dbo].[GEN_Attachments] 
							SET  [IsActive] = 0
								,[UTCLastUpdatedOn] = GETUTCDATE()
								,[LastUpdatedByRef] = @LoginUserId
					WHERE GEN_AttachmentsId=@GEN_AttachmentsId
			END
		ELSE 
			BEGIN 
			 INSERT INTO [dbo].[GEN_Attachments]
						([GEN_QueueRef],[UploadedFileName],[FileName],[FilePath],[GEN_DMSDataRef],[IsActive],[UTCCreatedOn],[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef])
						VALUES(@GEN_QueueRef,@UploadedFileName,@FileName,@FilePath,null,1,GETUTCDATE(),@LoginUserId,GETUTCDATE(),@LoginUserId)
			END


	  -- Select records from Attachemnts Table0
	  SELECT GA.[GEN_AttachmentsId],GA.[GEN_QueueRef],GA.[UploadedFileName],GA.[FileName],GA.[FilePath],GA.[GEN_DMSDataRef],GA.[IsActive],GA.[UTCCreatedOn],GA.[CreatedByRef],GA.[UTCLastUpdatedOn],GA.[LastUpdatedByRef],UMCreatedBy.FullName AS CreatedBy,UMLastUpdatedBy.FullName AS LastUpdatedBy
	    FROM [dbo].[GEN_Attachments] GA  WITH(NOLOCK)
		LEFT JOIN [dbo].[ADM_UserMaster] UMCreatedBy WITH(NOLOCK)  ON GA.CreatedByRef=UMCreatedBy.[ADM_UserMasterId] AND UMCreatedBy.IsActive=1
		LEFT JOIN [dbo].[ADM_UserMaster] UMLastUpdatedBy WITH(NOLOCK)  ON GA.LastUpdatedByRef=UMLastUpdatedBy.[ADM_UserMasterId] AND UMLastUpdatedBy.IsActive=1
	   WHERE [GEN_QueueRef] = @GEN_QueueRef AND GA.[IsActive] = 1
	   ORDER BY GA.[UTCLastUpdatedOn] DESC

		COMMIT TRAN ERSAttachments
	END TRY
	BEGIN CATCH		
			ROLLBACK TRAN ERSAttachments;
			INSERT INTO [dbo].[CMN_AppErrorLog] (ADM_UserMasterRef,[ErrorLocation],[ErrorSourceLkup],[ErrorMessage],[ErrorDescription],[UTCErrorDateTime],[UTCCreatedOn])
			VALUES(@LoginUserId,'[dbo].[USP_GEN_INS_ManageAttachments]',null,ERROR_NUMBER(),ERROR_MESSAGE(),GETUTCDATE(),GETUTCDATE())
	END CATCH  

END

