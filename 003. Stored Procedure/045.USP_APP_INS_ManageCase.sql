IF OBJECT_ID ('USP_APP_INS_ManageCase') IS NOT NULL 
BEGIN
	DROP PROC [dbo].[USP_APP_INS_ManageCase]
END
GO
/****** Object:  StoredProcedure [dbo].[USP_APP_INS_ManageCase]    Script Date: 8/7/2017 4:32:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:Amit Thanki
-- Create date: 08/29/2017
-- Modified By: 
-- Modification Date: 
-- Description: Insert into  Manage Case table
-- Eg.
-- Declare @ErrorMessage VARCHAR(2000)
-- Set @ErrorMessage=''
-- Exec [USP_BGP_INS_ManageCase] @ErrorMessage = @ErrorMessage Output
-- =============================================
CREATE PROCEDURE [dbo].[USP_APP_INS_ManageCase]
@GEN_QueueRef bigint,
@ActionLkup bigint,
@CurrentUserRef bigint,
@CreatedByRef bigint,
@ErrorMessage as varchar(2000) OUTPUT 
AS
BEGIN
BEGIN TRY

	Declare @UTCDate datetime=GETUTCDATE()

	INSERT INTO [dbo].[GEN_ManageCases]
           ([GEN_QueueRef]
           ,[ActionPerformedLkup]
           ,[CurrentUserRef]
           ,[CasesComments]
           ,[ReAssignUserRef]
           ,[IsActive]
           ,[UTCCreatedOn]
           ,[CreatedByRef]
           ,[UTCLastUpdatedOn]
           ,[LastUpdatedByRef])
     VALUES
           (@GEN_QueueRef,
           @ActionLkup,
           @CurrentUserRef, 
           null, 
           null,
           1,
           @UTCDate, 
           @CreatedByRef,
           @UTCDate,
           @CreatedByRef)

END TRY

BEGIN CATCH
SET @ErrorMessage = Error_Message();
END CATCH

END 