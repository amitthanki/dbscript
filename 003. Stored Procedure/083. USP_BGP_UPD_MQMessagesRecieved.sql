IF OBJECT_ID ('USP_BGP_UPD_MQMessagesRecieved') IS NOT NULL 
DROP PROC [DBO].[USP_BGP_UPD_MQMessagesRecieved]
GO

/****** Object:  StoredProcedure [dbo].[USP_BGP_UPD_MQMessagesRecieved]    Script Date: 11/15/2017 6:50:31 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:Pradeep Patil
-- Create date: 11/15/2017
-- Modified By: 
-- Modification Date: 
-- Description: Update BGP Process Details with records processsed and time duration
-- =============================================
CREATE PROCEDURE [dbo].[USP_BGP_UPD_MQMessagesRecieved]
@MQMessagesRecievedId bigint,
@SystemId bigint,
@IsProcessed bit,
@ProcessedResult varchar(max) = null,
@MQTRRWorkQueueItemRef bigint = 0,
@ProcessingFailReason varchar(1000) = null,
@ErrorMessage VARCHAR(2000) OUT
As
BEGIN
		BEGIN TRY
				Declare @UTCDate datetime = GETUTCDATE();
				BEGIN TRAN
						UPDATE [dbo].[MQMessagesRecieved]
						SET [IsProcessed] = @IsProcessed,[ProcessedResult] = @ProcessedResult, [MQTRRWorkQueueItemRef] =@MQTRRWorkQueueItemRef
						,[ProcessingFailReason] = @ProcessingFailReason,[UTCLastUpdatedOn] = @UTCDate, [LastUpdatedByRef] = @SystemId
						WHERE [MQMessagesRecievedId] = @MQMessagesRecievedId
				COMMIT TRAN
		END TRY
		BEGIN CATCH
				Rollback TRAN
				SET @ErrorMessage = Error_Message();
		END CATCH  
END