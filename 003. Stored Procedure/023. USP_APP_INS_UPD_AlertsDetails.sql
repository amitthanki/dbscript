IF OBJECT_ID ('USP_APP_INS_UPD_AlertsDetails') IS NOT NULL 
BEGIN
	DROP PROC [dbo].[USP_APP_INS_UPD_AlertsDetails]
END
GO

/****** Object:  StoredProcedure [dbo].[USP_APP_INS_UPD_AlertsDetails]    Script Date: 14-06-2017 19:53:27 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: Harsh Kumar Singhi
-- Create date: 06/14/2017
-- Modified By: 
-- Modification Date: 
-- Description: insert and update values into alerts Details table in db.
-- Eg.
-- Declare @ErrorMessage VARCHAR(2000)
-- Set @ErrorMessage=''
-- Exec [USP_APP_INS_UPD_AlertsDetails] @ErrorMessage = @ErrorMessage Output
-- =============================================
CREATE PROCEDURE [dbo].[USP_APP_INS_UPD_AlertsDetails]
@ADM_AlertDetailsId BIGINT = 0,
@AlertTitle varchar(250) = NULL,
@AlertDescription varchar(5000) = NULL,
@AlertPublishedDate datetime = NULL,
@AlertEffectiveDate datetime = NULL,
@AlertInactivationDate datetime = NULL,
@AlertCriticalityLkup bigint = NULL,
@SendAlertToLkup bigint = NULL,		--All | Department | Individual
@CMN_DepartmentRef bigint = NULL,	--Send to all user within this department
@ADM_UserMasterRef bigint = NULL,	--Particular User to whom this alert needs to be send
@IsActive bit = 1,
@LoginUserId BIGINT,				--Current Login User who is creating/updating an alert
@ScreenLkup BIGINT,
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

			IF(@ADM_AlertDetailsId = 0) --- (0 => Insert, >0 => Update)
			BEGIN
				INSERT INTO [dbo].[ADM_AlertDetails]
					   ([AlertTitle],[AlertDescription],[AlertPublishedDate],[AlertEffectiveDate],[AlertInactivationDate],[AlertCriticalityLkup],
						[SendAlertToLkup],[CMN_DepartmentRef],[ADM_UserMasterRef],[IsActive],[UTCCreatedOn],[CreatedByRef],[UTCLastUpdatedOn],
						[LastUpdatedByRef])
				 VALUES
					   (@AlertTitle,@AlertDescription,@AlertPublishedDate,@AlertEffectiveDate,@AlertInactivationDate,
					    @AlertCriticalityLkup, @SendAlertToLkup,@CMN_DepartmentRef,@ADM_UserMasterRef,1,@UTCDate,@LoginUserId,@UTCDate,@LoginUserId)

				SELECT ADM_AlertDetailsId = Scope_Identity()
			END
			ELSE 
			BEGIN
				Set @IsEditMode = 1

				UPDATE	[dbo].[ADM_AlertDetails]
				SET		[AlertTitle] = @AlertTitle, [AlertDescription]= @AlertDescription, [AlertPublishedDate] = @AlertPublishedDate,
						[AlertEffectiveDate] = @AlertEffectiveDate, [AlertInactivationDate] = @AlertInactivationDate,
						[AlertCriticalityLkup] = @AlertCriticalityLkup, [SendAlertToLkup] = @SendAlertToLkup, [CMN_DepartmentRef] = @CMN_DepartmentRef,
						[ADM_UserMasterRef] = @ADM_UserMasterRef, [IsActive] = @IsActive, [UTCLastUpdatedOn] = @UTCDate, [LastUpdatedByRef] = @LoginUserId   
				Where	[ADM_AlertDetailsId] = @ADM_AlertDetailsId
			END

			------Insert the record into history table

			INSERT INTO [dbo].[ADM_AlertDetailsHistory]
				   ([ADM_AlertDetailsRef],[AlertTitle],[AlertDescription],[AlertPublishedDate],[AlertEffectiveDate],[AlertInactivationDate],
				   [AlertCriticalityLkup],[SendAlertToLkup],[CMN_DepartmentRef],[ADM_UserMasterRef],[IsActive],[UTCCreatedOn],[CreatedByRef],
				   [UTCLastUpdatedOn],[LastUpdatedByRef],[UTCHistoryCreatedOn],[HistoryCreatedByRef],[SaveAttempt])
			SELECT [ADM_AlertDetailsId],[AlertTitle],[AlertDescription],[AlertPublishedDate],[AlertEffectiveDate],[AlertInactivationDate],
				   [AlertCriticalityLkup],[SendAlertToLkup],[CMN_DepartmentRef],[ADM_UserMasterRef],[IsActive],[UTCCreatedOn],[CreatedByRef],
				   [UTCLastUpdatedOn],[LastUpdatedByRef],@UTCDate,@LoginUserId,@SaveAttempt
			FROM [ADM_AlertDetails]
			WHERE [ADM_AlertDetailsId] = @ADM_AlertDetailsId

			---After Edit, Unlock the record
			IF(@IsEditMode = 1)
			BEGIN
			    DELETE FROM [dbo].CMN_RecordsLocked WHERE [ScreenLkup]=@ScreenLkup AND [CaseId]=@ADM_AlertDetailsId
		
				DECLARE @TableName varchar(200)
				DECLARE @PKColumn varchar(200)
				Select @TableName = LookupValue1, @PKColumn = LookupValue2 From CMN_LookupMaster Where CMN_LookupMasterId = @ScreenLkup AND CMN_LookupTypeRef = 37

				DECLARE @query NVARCHAR(MAX)=null

				SET @query = N'UPDATE '+Cast(@TableName As Varchar(200))+'
							   SET LockedByRef = NULL,
								   UTCLockedOn = NULL
							   WHERE '+Cast(@PKColumn As Varchar(200))+' = '+Cast(@ADM_AlertDetailsId As Varchar(10))+''

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
