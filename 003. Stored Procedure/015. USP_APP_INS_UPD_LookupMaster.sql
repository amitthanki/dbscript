IF OBJECT_ID ('USP_APP_INS_UPD_LookupMaster') IS NOT NULL 
BEGIN
	DROP PROC [dbo].[USP_APP_INS_UPD_LookupMaster]
END
GO

/****** Object:  StoredProcedure [dbo].[USP_APP_INS_UPD_LookupMaster]    Script Date: 12-06-2017 19:53:27 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: Harsh Kumar Singhi
-- Create date: 06/14/2017
-- Modified By: 
-- Modification Date: 
-- Description: insert and update values into Lookup Master table in db
-- Eg.
-- Declare @ErrorMessage VARCHAR(2000)
-- Set @ErrorMessage=''
-- Exec [USP_APP_INS_UPD_LookupMaster] @ErrorMessage = @ErrorMessage Output
-- =============================================
CREATE PROCEDURE [dbo].[USP_APP_INS_UPD_LookupMaster]
@CMN_LookupMasterId BIGINT = 0,
@CMN_LookupTypeRef bigint = NULL,
@LookupValue varchar(200) = NULL,
@LookupDescription varchar(200) = NULL,
@LookupValue1 varchar(200) = NULL,
@LookupValue2 varchar(200) = NULL,
@DisplayOrder bigint = NULL,
@IsActive bit = 1,
@LoginUserId BIGINT,
@ErrorMessage VARCHAR(2000) OUT
AS
BEGIN  
	BEGIN TRY  
	BEGIN TRAN

		DECLARE @UTCDate DATETIME
		SET @UTCDate=getutcdate()

		DECLARE @SaveAttempt BIGINT
		UPDATE dbo.CMN_TableSequenceCounts SET @SaveAttempt=Sequence,Sequence=Sequence+1 WHERE CMN_TableSequenceCountsId=1;

		IF(@CMN_LookupMasterId = 0) --- (0 => Insert, >0 => Update)
		BEGIN

			Declare @MaxId bigint = 0
			Select @MaxId = ISNULL(Max(CMN_LookupMasterId),@CMN_LookupTypeRef * 1000) From [CMN_LookupMaster] Where [CMN_LookupTypeRef] = @CMN_LookupTypeRef

			IF(@MaxId < 1000000)
				Set @CMN_LookupMasterId = @CMN_LookupTypeRef * 1000;
			ELSE
				Set @CMN_LookupMasterId = @MaxId + 1

			INSERT INTO [dbo].[CMN_LookupMaster]
				   ([CMN_LookupMasterId],[CMN_LookupTypeRef],[LookupValue],[LookupDescription],[LookupValue1],[LookupValue2],[DisplayOrder],[IsActive],
				    [UTCCreatedOn],[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef])
			 VALUES
				   (@CMN_LookupMasterId,@CMN_LookupTypeRef,@LookupValue,@LookupDescription,@LookupValue1,@LookupValue2,
				    @DisplayOrder,1,@UTCDate,@LoginUserId,@UTCDate,@LoginUserId)
		END
		ELSE 
		BEGIN
			UPDATE [dbo].[CMN_LookupMaster]
				SET [CMN_LookupTypeRef] = @CMN_LookupTypeRef,[LookupValue]= @LookupValue,[LookupDescription] = @LookupDescription,
					[LookupValue1] = @LookupValue1, [LookupValue2] = @LookupValue2,
					[DisplayOrder] = @DisplayOrder, [IsActive] = @IsActive,[UTCLastUpdatedOn] = @UTCDate,
					[LastUpdatedByRef] = @LoginUserId   
				Where [CMN_LookupMasterId] = @CMN_LookupMasterId
		END

		------Insert the record into history table

		INSERT INTO [dbo].[CMN_LookupMasterHistory]
				([CMN_LookupMasterRef],[CMN_LookupTypeRef],[LookupValue],[LookupDescription],[LookupValue1],[LookupValue2],[DisplayOrder],
			     [IsActive],[UTCCreatedOn],[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef],[UTCHistoryCreatedOn],[HistoryCreatedByRef],
				 [SaveAttempt])
		SELECT	[CMN_LookupMasterID],[CMN_LookupTypeRef],[LookupValue],[LookupDescription],[LookupValue1],[LookupValue2],[DisplayOrder],
				[IsActive],[UTCCreatedOn],[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef],@UTCDate,@LoginUserId,@SaveAttempt
		FROM	[CMN_LookupMaster]
		WHERE	[CMN_LookupMasterId] = @CMN_LookupMasterId

 	COMMIT TRAN
	END TRY 

	BEGIN CATCH
		BEGIN TRY ROLLBACK TRAN; END TRY BEGIN CATCH END CATCH
		SET @ErrorMessage = ERROR_MESSAGE();
	END CATCH  
END
GO
