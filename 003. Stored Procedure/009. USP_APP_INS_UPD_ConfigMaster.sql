IF OBJECT_ID ('USP_APP_INS_UPD_ConfigMaster') IS NOT NULL 
BEGIN
	DROP PROC [dbo].[USP_APP_INS_UPD_ConfigMaster]
END
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author: Sourabha Ranjan Barik
-- Create date: 06/12/2017
-- Modified By: 
-- Modification Date: 
-- Description: SP used to insert/update config data to DB
-- Eg.
-- Declare @ErrorMessage VARCHAR(2000)
-- Set @ErrorMessage=''
-- Exec [USP_APP_INS_UPD_ConfigMaster] @ErrorMessage = @ErrorMessage Output
-- =============================================
CREATE PROC [dbo].[USP_APP_INS_UPD_ConfigMaster]
@ConfigId bigint = 0,
@ConfigName varchar(500) = NULL,
@ConfigValue varchar(2000) = NULL,
@Version bigint = 1,
@StartDate datetime = NULL,
@EndDate datetime = NULL,
@IsActive Bit = 1,
@LoginUserId bigint,
@ScreenLkup bigint,
@ErrorMessage varchar(2000) OUTPUT
As
BEGIN
	BEGIN TRY
		BEGIN TRAN
				--Get current utc datetime
				Declare @UTCDate datetime
				Set @UTCDate=getutcdate()

				--Get SaveAttempt for this action
				DECLARE @SaveAttempt BIGINT
				UPDATE dbo.CMN_TableSequenceCounts SET @SaveAttempt=Sequence,Sequence=Sequence+1 WHERE CMN_TableSequenceCountsId=1;

				--Set startdate if startdate is null
				If(@StartDate Is NULL)
				BEGIN
					Set @StartDate = @UTCDate
				END

				--Set enddate if enddate is null
				If(@EndDate Is NULL)
				BEGIN
					Set @EndDate = DateAdd(yy,20,@UTCDate)
				END
				
				DECLARE @IsEditMode Bit = 0

				IF(@ConfigId=0)  --(0 - Add mode | >0 - Edit mode)
				BEGIN
					--Insert New Row
					INSERT INTO [dbo].[MGR_ConfigMaster]
					   ([ConfigName],[ConfigValue],[Version],[StartDate],[EndDate],[IsActive],[UTCCreatedOn],[CreatedByRef],[UTCLastUpdatedOn]
					   ,[LastUpdatedByRef])
					VALUES
					   (@ConfigName,@ConfigValue,@Version,@StartDate,@EndDate,1,@UTCDate,@LoginUserId,@UTCDate,@LoginUserId)

					SELECT @ConfigId = Scope_Identity()
				END
				ELSE
				BEGIN
					Set @IsEditMode = 1

					--Update Row
					UPDATE [dbo].[MGR_ConfigMaster]
					SET    [ConfigName] = @ConfigName
						  ,[ConfigValue] = @ConfigValue
						  ,[Version] = @Version
						  ,[StartDate] = @StartDate
						  ,[EndDate] = @EndDate	 
						  ,[IsActive] = @IsActive 
						  ,[UTCLastUpdatedOn] = @UTCDate
						  ,[LastUpdatedByRef] = @LoginUserId
					WHERE  [MGR_ConfigMasterId] = @ConfigId
				END			

				--Insert a copy into history table
				INSERT INTO [dbo].[MGR_ConfigMasterHistory]
				   ([MGR_ConfigMasterRef],[LockedByRef],[UTCLockedOn],[ConfigName],[ConfigValue],[Version],[StartDate],[EndDate],[IsActive],[UTCCreatedOn],[CreatedByRef]
				   ,[UTCLastUpdatedOn],[LastUpdatedByRef],[UTCHistoryCreatedOn],[HistoryCreatedByRef],[SaveAttempt])
				SELECT  [MGR_ConfigMasterId],[LockedByRef],[UTCLockedOn],[ConfigName],[ConfigValue],[Version],[StartDate],[EndDate],[IsActive],[UTCCreatedOn],
						   [CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef],@UTCDate,@LoginUserId,@SaveAttempt 
				FROM [MGR_ConfigMaster] 
				WHERE [MGR_ConfigMasterId] = @ConfigId

				---After Edit, Unlock the record
				IF(@IsEditMode = 1)
				BEGIN
				------------Unlock------------
				    DELETE FROM CMN_RecordsLocked WHERE [ScreenLkup]=@ScreenLkup AND [CaseId]=@ConfigId
                ------------------------------
		
					DECLARE @TableName varchar(200)
					DECLARE @PKColumn varchar(200)
					Select @TableName = LookupValue1, @PKColumn = LookupValue2 From CMN_LookupMaster Where CMN_LookupMasterId = @ScreenLkup AND CMN_LookupTypeRef=37

					DECLARE @query NVARCHAR(MAX)=null

					SET @query = N'UPDATE '+Cast(@TableName As Varchar(200))+'
								   SET LockedByRef = NULL,
									   UTCLockedOn = NULL
								   WHERE '+Cast(@PKColumn As Varchar(200))+' = '+Cast(@ConfigId As Varchar(10))+''

					EXEC sp_executesql @query
				END

		COMMIT TRAN
	END TRY 

	BEGIN CATCH
		Begin Try Rollback Tran; End Try Begin Catch End Catch
		SET @ErrorMessage= ERROR_MESSAGE();
	END CATCH  
END
GO