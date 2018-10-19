IF OBJECT_ID ('USP_APP_INS_UPD_LookupType') IS NOT NULL 
BEGIN
	DROP PROC [DBO].[USP_APP_INS_UPD_LookupType]
END
GO

/****** Object:  StoredProcedure [dbo].[USP_APP_INS_UPD_LookupType]    Script Date: 13-06-2017 19:53:27 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: Harsh Kumar Singhi
-- Create date: 06/13/2017
-- Modified By: 
-- Modification Date: 
-- Description: insert and update values into Lookup Type
-- Eg.
-- Declare @ErrorMessage VARCHAR(2000)
-- Set @ErrorMessage=''
-- Exec [USP_APP_INS_UPD_LookupType] @ErrorMessage = @ErrorMessage Output
-- =============================================
CREATE PROCEDURE [dbo].[USP_APP_INS_UPD_LookupType]
@CMN_LookupTypeId BIGINT = 0,
@LookupTypeDescription VARCHAR(75) = NULL,
@LoginUserId BIGINT,
@IsActive BIT = 1,
@ScreenLkup bigint,
@ErrorMessage VARCHAR(2000) OUT
AS
BEGIN  
	BEGIN TRY  
		BEGIN TRAN 
			DECLARE @UTCDate DATETIME
			SET @UTCDate=getutcdate()

			DECLARE @SaveAttempt BIGINT
			UPDATE dbo.CMN_TableSequenceCounts SET @SaveAttempt=Sequence,Sequence=Sequence+1 WHERE CMN_TableSequenceCountsId=1;

			DECLARE @IsEditMode Bit = 0

			IF(@CMN_LookupTypeId = 0) --- (0=> Insert, >0 => Update)
			BEGIN

				Declare @MaxId bigint = 0
				Select @MaxId = Max(CMN_LookupTypeId) From [CMN_LookupType]

				IF(@MaxId < 1000)
					Set @CMN_LookupTypeId = 1000				
				ELSE
					Set @CMN_LookupTypeId = @MaxId + 1

				INSERT INTO [dbo].[CMN_LookupType]
					   ([CMN_LookupTypeId],[LookupTypeDescription],[IsActive],[UTCCreatedOn],[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef])
				 VALUES
					   (@CMN_LookupTypeId, @LookupTypeDescription,1,@UTCDate,@LoginUserId,@UTCDate,@LoginUserId)
			END
			ELSE 
			BEGIN
				Set @IsEditMode = 1

				UPDATE [dbo].[CMN_LookupType]
				Set   [LookupTypeDescription] = @LookupTypeDescription,[IsActive] = @IsActive,[UTCLastUpdatedOn] = @UTCDate
					  ,[LastUpdatedByRef] = @LoginUserId   
				Where [CMN_LookupTypeId] = @CMN_LookupTypeId
			END

			------Insert the record into history table

			INSERT INTO [dbo].[CMN_LookupTypeHistory]
					([CMN_LookupTypeRef],[LookupTypeDescription],[IsActive],[UTCCreatedOn],[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef],
					 [UTCHistoryCreatedOn],[HistoryCreatedByRef],[SaveAttempt])
			SELECT	[CMN_LookupTypeId],[LookupTypeDescription],[IsActive],[UTCCreatedOn],[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef],
					@UTCDate,@LoginUserId,@SaveAttempt
			FROM	[CMN_LookupType]
			WHERE	[CMN_LookupTypeId] = @CMN_LookupTypeId

			---After Edit, Unlock the record
			IF(@IsEditMode = 1)
			BEGIN
			    DELETE  FROM CMN_RecordsLocked WHERE  [ScreenLkup]=@ScreenLkup AND [CaseId]=@CMN_LookupTypeId
		
				DECLARE @TableName varchar(200)
				DECLARE @PKColumn varchar(200)
				Select @TableName = LookupValue1, @PKColumn = LookupValue2 From CMN_LookupMaster Where CMN_LookupMasterId = @ScreenLkup AND CMN_LookupTypeRef=37

				DECLARE @query NVARCHAR(MAX)=null

				SET @query = N'UPDATE '+Cast(@TableName As Varchar(200))+'
							   SET LockedByRef = NULL,
								   UTCLockedOn = NULL
							   WHERE '+Cast(@PKColumn As Varchar(200))+' = '+Cast(@CMN_LookupTypeId As Varchar(10))+''

				EXEC sp_executesql @query
			END

 		COMMIT TRAN
	END TRY 

	BEGIN CATCH
		BEGIN TRY ROLLBACK TRAN; END TRY BEGIN CATCH END CATCH
		SET @ErrorMessage= ERROR_MESSAGE();
	END CATCH  
END
GO
