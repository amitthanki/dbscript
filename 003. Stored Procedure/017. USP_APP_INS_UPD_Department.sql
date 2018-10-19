IF OBJECT_ID ('USP_APP_INS_UPD_Department') IS NOT NULL 
BEGIN
	DROP PROC [dbo].[USP_APP_INS_UPD_Department]
END
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author: Sourabha Ranjan Barik
-- Create date: 06/14/2017
-- Modified By: 
-- Modification Date: 
-- Description: SP used to insert/update department data to DB
-- Eg.
-- Declare @ErrorMessage VARCHAR(2000)
-- Set @ErrorMessage=''
-- Exec [USP_APP_INS_UPD_Department] @ErrorMessage = @ErrorMessage Output
-- =============================================
CREATE PROC [dbo].[USP_APP_INS_UPD_Department]
@CMN_DepartmentId bigint = 0,
@ERSDepartmentName varchar(500) = NULL,
@BusinessSegmentLkup bigint = NULL,
@DepartmentLkup bigint = NULL,
@EffectiveDate datetime = NULL,
@InactivationDate datetime = NULL,
@IsActive bit = 1,
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
				
				DECLARE @IsEditMode Bit = 0

				IF(@CMN_DepartmentId=0)  --(0 - Add mode | >0 - Edit mode)
				BEGIN
					--Insert New Row
					INSERT INTO [dbo].[CMN_Department]
							   ([ERSDepartmentName],[BusinessSegmentLkup],[DepartmentLkup],[EffectiveDate],[InactivationDate]
							   ,[IsActive],[UTCCreatedOn],[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef])
						 VALUES
							   (@ERSDepartmentName,@BusinessSegmentLkup,@DepartmentLkup,@EffectiveDate,@InactivationDate,
							    1,@UTCDate,@LoginUserId,@UTCDate,@LoginUserId)

					SELECT @CMN_DepartmentId = Scope_Identity()
				END
				ELSE
				BEGIN
					Set @IsEditMode = 1

					--Update Row
					UPDATE [dbo].[CMN_Department]
					   SET [ERSDepartmentName] = @ERSDepartmentName
						  ,[BusinessSegmentLkup] = @BusinessSegmentLkup
						  ,[DepartmentLkup] = @DepartmentLkup
						  ,[EffectiveDate] = @EffectiveDate
						  ,[InactivationDate] = @InactivationDate
						  ,[IsActive] = @IsActive
						  ,[UTCLastUpdatedOn] = @UTCDate
						  ,[LastUpdatedByRef] = @LoginUserId
					 WHERE [CMN_DepartmentId] = @CMN_DepartmentId
				END			

				--Insert a copy into history table
				INSERT INTO [dbo].[CMN_DepartmentHistory]
						   ([CMN_DepartmentRef],[LockedByRef],[UTCLockedOn],[ERSDepartmentName],[BusinessSegmentLkup],[DepartmentLkup],[EffectiveDate],[InactivationDate]
						   ,[IsActive],[UTCCreatedOn],[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef],[UTCHistoryCreatedOn],[HistoryCreatedByRef],[SaveAttempt])
				SELECT	[CMN_DepartmentId],[LockedByRef],[UTCLockedOn],[ERSDepartmentName],[BusinessSegmentLkup],[DepartmentLkup],[EffectiveDate],[InactivationDate],
						[IsActive],[UTCCreatedOn],[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef],@UTCDate,@LoginUserId,@SaveAttempt 
				FROM	[CMN_Department] 
				WHERE	[CMN_DepartmentId] = @CMN_DepartmentId

				---After Edit, Unlock the record
				IF(@IsEditMode = 1)
				BEGIN
				DELETE FROM   CMN_RecordsLocked WHERE [ScreenLkup]=@ScreenLkup AND [CaseId]=@CMN_DepartmentId
		
					DECLARE @TableName varchar(200)
					DECLARE @PKColumn varchar(200)
					Select @TableName = LookupValue1, @PKColumn = LookupValue2 From CMN_LookupMaster Where CMN_LookupMasterId = @ScreenLkup AND CMN_LookupTypeRef = 37

					DECLARE @query NVARCHAR(MAX)=null

					SET @query = N'UPDATE '+Cast(@TableName As Varchar(200))+'
								   SET LockedByRef = NULL,
									   UTCLockedOn = NULL
								   WHERE '+Cast(@PKColumn As Varchar(200))+' = '+Cast(@CMN_DepartmentId As Varchar(10))+''

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

