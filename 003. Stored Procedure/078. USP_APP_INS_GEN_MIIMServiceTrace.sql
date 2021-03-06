IF OBJECT_ID ('USP_APP_INS_GEN_MIIMServiceTrace') IS NOT NULL 
BEGIN
	DROP PROC [dbo].[USP_APP_INS_GEN_MIIMServiceTrace]
END
GO
-- =============================================
-- Author: Praveen Kumar Joshi
-- Create date: 9/21/2017 12:09:05 PM
-- Modified By: 
-- Modification Date: 
-- Description: MIIM Service Trace
-- Eg.
-- Declare @ErrorMessage VARCHAR(2000)
-- Set @ErrorMessage=''
-- Exec USP_APP_INS_GEN_GEN_MIIMServiceTrace @ErrorMessage = @ErrorMessage Output
-- =============================================
CREATE PROCEDURE [dbo].[USP_APP_INS_GEN_MIIMServiceTrace]
(
    @WebServiceMethodLkup  BIGINT
   ,@WebServiceMethodName  VARCHAR(100)=NULL
   ,@TarceMethodLkup       BIGINT
   ,@RequestInputData      VARCHAR(4000)
   ,@ResponseStatusMessage VARCHAR(4000)
   ,@LoggedInUserId        BIGINT     
   ,@ErrorMessage          VARCHAR(2000) OUT
)

AS 

BEGIN TRY

	INSERT INTO [dbo].[GEN_MIIMServiceTrace]
			   ([WebServiceMethodLkup]
			   ,[WebServiceMethodName]
			   ,[TarceMethodLkup]
			   ,[RequestInputData]
			   ,[ResponseStatusMessage]
			   ,[IsActive]
			   ,[UTCCreatedOn]
			   ,[CreatedByRef])
		 VALUES
			   (@WebServiceMethodLkup
			   ,@WebServiceMethodName
			   ,@TarceMethodLkup
			   ,@RequestInputData
			   ,@ResponseStatusMessage
			   ,1
			   ,GETUTCDATE()
			   ,@LoggedInUserId)


END TRY

BEGIN CATCH
--Insert to Error log
 
	INSERT INTO [dbo].[CMN_AppErrorLog](ADM_UserMasterRef,[ErrorLocation],[ErrorSourceLkup],[ErrorMessage],[ErrorDescription],[UTCErrorDateTime],[UTCCreatedOn])
		 VALUES( @LoggedInUserId,'[dbo].[USP_APP_INS_GEN_GEN_MIIMServiceTrace]',null,ERROR_NUMBER(),ERROR_MESSAGE(),GETUTCDATE(),GETUTCDATE())
            SET @ErrorMessage=ERROR_MESSAGE()
END CATCH
