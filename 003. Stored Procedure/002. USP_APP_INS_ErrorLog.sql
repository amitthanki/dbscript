IF OBJECT_ID ('USP_APP_INS_ErrorLog') IS NOT NULL
BEGIN
	DROP PROC [DBO].[USP_APP_INS_ErrorLog]
END
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: VenkataSubramanyam
-- Create date: 06/12/2017
-- Modified By: 
-- Modification Date: 
-- Description: insert to error log
-- Eg.
-- Declare @ErrorMessage VARCHAR(2000)
-- Set @ErrorMessage=''
-- Exec [USP_APP_INS_ErrorLog] @ErrorMessage = @ErrorMessage Output
-- =============================================
CREATE PROCEDURE [dbo].[USP_APP_INS_ErrorLog]
@ErrorLocation varchar(100)=null,
@ErrorSourceLkup bigint =null,
@ERSErrorCode bigint =null,
@ERSErrorMessage as varchar(max)= null,
@ErrorDescription as varchar(max)= null,
@UserRef as bigint = null,
@ErrorMessage varchar(2000) OUTPUT,
@CMN_AppErrorLogId as bigint OUTPUT
As
BEGIN  

	BEGIN TRY  
		Declare @UTCDate datetime
		Set @UTCDate=getutcdate()

		INSERT INTO [dbo].[CMN_AppErrorLog]
				   ([ADM_UserMasterRef]
				   ,[ErrorLocation]
				   ,[ErrorSourceLkup]
				   ,[ErrorMessage]
				   ,[ErrorDescription]
				   ,[UTCErrorDateTime]
				   ,[UTCCreatedOn])
			 VALUES
				   (@UserRef        
				   ,@ErrorLocation
				   ,@ErrorSourceLkup
				   ,@ERSErrorMessage
				   ,@ErrorDescription
				   ,@UTCDate
				   ,@UTCDate)
          
		SELECT @CMN_AppErrorLogId=SCOPE_IDENTITY()
	END TRY 

	BEGIN CATCH
		   SET @ErrorMessage= ERROR_MESSAGE();
	END CATCH  

END
GO
