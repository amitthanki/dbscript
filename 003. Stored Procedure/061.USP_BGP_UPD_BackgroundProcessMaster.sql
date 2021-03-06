IF OBJECT_ID ('USP_BGP_UPD_BackgroundProcessMaster') IS NOT NULL 
BEGIN
	DROP PROC [dbo].[USP_BGP_UPD_BackgroundProcessMaster]
END
GO
/****** Object:  StoredProcedure [dbo].[USP_BGP_UPD_BackgroundProcessMaster]    Script Date: 8/11/2017 5:30:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:Pradeep Patil
-- Create date: 08/10/2017
-- Modified By: 
-- Modification Date: 
-- Description: Update BGP Process Details with records processsed and time duration
-- =============================================
CREATE PROCEDURE [dbo].[USP_BGP_UPD_BackgroundProcessMaster]
@CMN_BackgroundProcessMasterId bigint,
@LoginId bigint,
@TotalRecordProcessed bigint,
@BGPStatusLkup bigint,
@ErrorMessage VARCHAR(2000) OUT
As
BEGIN
		BEGIN TRY
				Declare @UTCEndDate datetime = GETUTCDATE();
				BEGIN TRAN
						UPDATE [dbo].[CMN_BackgroundProcessMaster]
						SET [UTCEndDate] = @UTCEndDate,[TotalDuration] = DateDiff(SECOND,[UTCStartDate],@UTCEndDate),[TotalRecordProcessed] = @TotalRecordProcessed,
							[BGPStatusLkup] =@BGPStatusLkup,[UTCLastUpdatedOn] = @UTCEndDate,LastUpdatedByRef = @LoginId, IsActive = 0
						WHERE [CMN_BackgroundProcessMasterId] = @CMN_BackgroundProcessMasterId
				COMMIT TRAN
		END TRY
		BEGIN CATCH
				Rollback TRAN
				SET @ErrorMessage = Error_Message();
		END CATCH  
END


GO



