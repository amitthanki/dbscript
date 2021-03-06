IF OBJECT_ID ('USP_APP_SEL_QueueCMSTransaction') IS NOT NULL 
DROP PROC [DBO].[USP_APP_SEL_QueueCMSTransaction]
GO

/****** Object:  StoredProcedure [dbo].[USP_APP_SEL_QueueCMSTransaction]    Script Date: 05/07/2017 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- =============================================
-- Author: Rakesh
-- Create date: 10/25/2017
-- Description: Get Records to Send OOA letter
-- Eg.
 --Declare @ErrorMessage VARCHAR(2000)
 --Set @ErrorMessage=''
 --Exec [USP_APP_SEL_QueueCMSTransaction] @GEN_QueueIdsToSkip='',@ErrorMessage = ''
-- =============================================
Create PROCEDURE [dbo].[USP_APP_SEL_QueueCMSTransaction] 
@GEN_QueueIdsToSkip VARCHAR(MAX),
@ErrorMessage varchar(2000) OUTPUT
as

BEGIN  
	BEGIN TRY
		
		Declare @GEN_QueueId BIGINT = 0

		SELECT Item as GEN_QueueId 
		INTO dbo.[#TGEN_QueueId]
		FROM SplitString(@GEN_QueueIdsToSkip,',') WHERE Item <>''

		SELECT TOP 1 @GEN_QueueId = GQ.GEN_QueueId
		From GEN_Queue GQ WITH(NOLOCK)
		Where GQ.IsActive=1 AND GQ.CMSTransactionStatusLkup = 55001 AND (GQ.MostRecentStatusLkup = 20001 OR GQ.MostRecentStatusLkup = 20002) AND
			  LockedByRef IS NULL AND UTCLockedOn IS NULL AND  GQ.GEN_QueueId not in (select GEN_QueueId from [#TGEN_QueueId])
		ORDER BY GQ.UTCCreatedOn, GQ.GEN_QueueId 
		
		SELECT GQ.* From GEN_Queue GQ WITH(NOLOCK) Where GQ.GEN_QueueId=@GEN_QueueId

		SELECT GOST.* FROM GEN_Queue GQ  WITH(NOLOCK)
		LEFT JOIN GEN_OSTActions GOST WITH(NOLOCK) ON GQ.GEN_QueueId=GOST.GEN_QueueRef
		WHERE GQ.GEN_QueueId=@GEN_QueueId

	END TRY
	BEGIN CATCH
		SET @ErrorMessage= ERROR_MESSAGE();
	END CATCH
END