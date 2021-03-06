IF OBJECT_ID ('USP_BGP_INS_MQMessagesRecieved') IS NOT NULL 
DROP PROC [DBO].[USP_BGP_INS_MQMessagesRecieved]
GO

/****** Object:  StoredProcedure [dbo].[USP_BGP_INS_MQMessagesRecieved]    Script Date: 11/15/2017 6:49:27 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author: Pradeep Patil
-- Create date: 11/15/2017
-- Modified By: 
-- Modification Date: 
-- Description: Save MQ recieved messages 

-- Eg.
-- Declare @ErrorMessage VARCHAR(2000)
-- Set @ErrorMessage=''
-- Exec [USP_BGP_INS_MQMessagesRecieved] @ErrorMessage = @ErrorMessage Output
-- =============================================
CREATE PROCEDURE [dbo].[USP_BGP_INS_MQMessagesRecieved]
@BackgroundProcessMasterRef bigint
,@MQSourceTypeLkup bigint
,@MQMessage varchar(max)
,@SystemId bigint
,@MQMessagesRecievedId bigint OUTPUT
,@ErrorMessage as varchar(2000) OUTPUT 
AS
BEGIN
BEGIN TRY

	SET @MQMessagesRecievedId = 0;
	Declare @UTCStartDate datetime = GETUTCDATE();

	INSERT INTO [dbo].[MQMessagesRecieved]
			   ([CMN_BackgroundProcessMasterRef]
			   ,[MQSourceTypeLkup]           
			   ,[MQMessage]
			   ,[IsProcessed]
			   ,[UTCCreatedOn]
			   ,[CreatedByRef])
		 VALUES
			   (@BackgroundProcessMasterRef
			   ,@MQSourceTypeLkup
			   ,@MQMessage
			   ,0
			   ,@UTCStartDate
			   ,@SystemId);
          
	SELECT @MQMessagesRecievedId = SCOPE_IDENTITY() FROM [dbo].[MQMessagesRecieved];

END TRY

BEGIN CATCH
	SET @ErrorMessage = Error_Message();
END CATCH

END 