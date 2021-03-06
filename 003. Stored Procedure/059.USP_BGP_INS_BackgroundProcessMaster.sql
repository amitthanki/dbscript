IF OBJECT_ID ('USP_BGP_INS_BackgroundProcessMaster') IS NOT NULL 
BEGIN
	DROP PROC [dbo].[USP_BGP_INS_BackgroundProcessMaster]
END
GO
/****** Object:  StoredProcedure [dbo].[USP_BGP_INS_BackgroundProcessMaster]    Script Date: 8/7/2017 4:29:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author: Amit Thanki
-- Create date: 07/27/2017
-- Modified By: 
-- Modification Date: 
-- Description: Insert BG Process Master to DB
-- Eg.
-- Declare @ErrorMessage VARCHAR(2000)
-- Set @ErrorMessage=''
-- Exec [USP_BGP_INS_BackgroundProcessMaster] @ErrorMessage = @ErrorMessage Output
-- =============================================
CREATE PROCEDURE [dbo].[USP_BGP_INS_BackgroundProcessMaster]
@BackgroundProcessTypeLkup bigint
,@LoginId bigint
,@BGPMasterId bigint OUTPUT
,@ErrorMessage as varchar(2000) OUTPUT 
AS
BEGIN
BEGIN TRY

	SET @BGPMasterId = 0;
	Declare @UTCStartDate datetime = GETUTCDATE();

	INSERT INTO [dbo].[CMN_BackgroundProcessMaster]
			   ([BackgroundProcessTypeLkup]
			   ,[UTCStartDate]           
			   ,[IsActive]
			   ,[UTCCreatedOn]
			   ,[CreatedByRef])
		 VALUES
			   (@BackgroundProcessTypeLkup
			   ,@UTCStartDate
			   ,1
			   ,@UTCStartDate
			   ,@LoginId);
          
	SELECT @BGPMasterId = SCOPE_IDENTITY() FROM [dbo].[CMN_BackgroundProcessMaster];

END TRY

BEGIN CATCH
	SET @ErrorMessage = Error_Message();
END CATCH

END 

GO

