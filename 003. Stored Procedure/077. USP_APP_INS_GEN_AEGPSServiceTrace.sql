IF OBJECT_ID ('USP_APP_INS_GEN_AEGPSServiceTrace') IS NOT NULL 
BEGIN
	DROP PROC [dbo].[USP_APP_INS_GEN_AEGPSServiceTrace]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:Praveen Kumar Joshi
-- Create date: 06/09/2017
-- Modified By: 
-- Modification Date: 
-- Description:To insert User details into DB
-- Eg.
-- Exec [USP_APP_INS_ADM_UserMaster] @GEN_QueueRef=,@WebServiceMethodLkup=,@InputData=,@WebServiceMethodName=,@ResponseData=,@Statuslkup=,@CreatedByRef=
-- =============================================
CREATE Procedure [dbo].[USP_APP_INS_GEN_AEGPSServiceTrace]
(
@GEN_QueueRef bigint
,@WebServiceMethodLkup bigint
,@RequestData Varchar(max)
,@WebServiceMethodName varchar(1000)
,@ResponseData  Varchar(max)=null
,@Statuslkup bigint
,@CreatedByRef bigint
)

AS 

BEGIN Try
INSERT INTO [dbo].[GEN_AEGPSServiceTrace ]
           ([GEN_QueueRef]
           ,[WebServiceMethodLkup]
           ,[RequestData]
           ,[ResponseData]
                 ,[WebServiceMethodName]
                 ,[Statuslkup]
           ,[IsActive]
           ,[UTCCreatedOn]
           ,[CreatedByRef]
           ,[UTCLastUpdatedOn]
           ,[LastUpdatedByRef])
     VALUES
           (@GEN_QueueRef
           ,@WebServiceMethodLkup
           ,@RequestData
           ,@ResponseData
                 ,@WebServiceMethodName
                 ,@Statuslkup
           ,1
           ,GetUTCDate()
           ,@CreatedByRef
           ,GetUTCDate()
           ,@CreatedByRef)

END TRY

BEGIN CATCH
--Insert to Error log

INSERT INTO [dbo].[CMN_AppErrorLog](ADM_UserMasterRef,[ErrorLocation],[ErrorSourceLkup],[ErrorMessage],[ErrorDescription],[UTCErrorDateTime],[UTCCreatedOn])
              VALUES( @CreatedByRef,'[dbo].[USP_APP_INS_GEN_AEGPSServiceTrace]',null,ERROR_NUMBER(),ERROR_MESSAGE(),GETUTCDATE(),GETUTCDATE())
        

END CATCH


GO
