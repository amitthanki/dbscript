IF OBJECT_ID ('USP_APP_INS_UPD_UserPreference') IS NOT NULL 
BEGIN
	DROP PROC [dbo].[USP_APP_INS_UPD_UserPreference]
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
-- Exec [USP_APP_INS_UPD_UserPreference] @ErrorMessage = @ErrorMessage Output
-- =============================================
CREATE PROC [dbo].[USP_APP_INS_UPD_UserPreference]
@ADM_UserPreferenceId bigint = 0,
@ADM_UserMasterId bigint,
@ShowAlerts bit = 0,
@ShowResources bit = 0,
@BusinessSegmentLkup bigint = NULL,
@RoleLkup bigint = NULL,
@TimezoneLkup bigint = NULL,
@WorkBasketLkup bigint = NULL,
@ShowOSTSummary bit = 0,
@ShowEligibilitySummary bit = 0,
@ShowRPRSummary bit = 0,
@IsActive bit = 1,
@ErrorMessage varchar(2000) OUTPUT
AS
BEGIN
	BEGIN TRY
		BEGIN TRAN
			--Get current utc datetime
			Declare @UTCDate datetime
			Set @UTCDate=getutcdate()

			--Get SaveAttempt for this action
			DECLARE @SaveAttempt BIGINT
			UPDATE dbo.CMN_TableSequenceCounts SET @SaveAttempt=Sequence,Sequence=Sequence+1 WHERE CMN_TableSequenceCountsId=1;

			IF(@ADM_UserPreferenceId = 0)  --(0 - Add mode | >0 - Edit mode)
			BEGIN
				INSERT INTO [dbo].[ADM_UserPreference]
						   ([ADM_UserMasterRef],[ShowAlerts],[ShowResources],[BusinessSegmentLkup],[RoleLkup],[TimezoneLkup],[WorkBasketLkup],[ShowOSTSummary]
						   ,[ShowEligibilitySummary],[ShowRPRSummary],[IsActive],[UTCCreatedOn],[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef])
					VALUES 
					   (@ADM_UserMasterId,@ShowAlerts,@ShowResources,@BusinessSegmentLkup,@RoleLkup,@TimezoneLkup,@WorkBasketLkup,@ShowOSTSummary,
					    @ShowEligibilitySummary,@ShowRPRSummary,1,@UTCDate,@ADM_UserMasterId,@UTCDate,@ADM_UserMasterId)
			END
			ELSE
			BEGIN
				UPDATE [dbo].[ADM_UserPreference]
				   SET [ADM_UserMasterRef] = @ADM_UserMasterId
					  ,[ShowAlerts] = @ShowAlerts
					  ,[ShowResources] = @ShowResources
					  ,[BusinessSegmentLkup] = @BusinessSegmentLkup
					  ,[RoleLkup] = @RoleLkup
					  ,[TimezoneLkup] = @TimezoneLkup
					  ,[WorkBasketLkup] = @WorkBasketLkup
					  ,[ShowOSTSummary] = @ShowOSTSummary
					  ,[ShowEligibilitySummary] = @ShowEligibilitySummary
					  ,[ShowRPRSummary] = @ShowRPRSummary
					  ,[IsActive] = @IsActive
					  ,[UTCLastUpdatedOn] = @UTCDate
					  ,[LastUpdatedByRef] = @ADM_UserMasterId
				WHERE ADM_UserPreferenceId = @ADM_UserPreferenceId
			END

			--Insert to History Table
			INSERT INTO [dbo].[ADM_UserPreferenceHistory]
					   ([ADM_UserPreferenceRef],[ADM_UserMasterRef],[ShowAlerts],[ShowResources],[BusinessSegmentLkup],[RoleLkup],[TimezoneLkup],[WorkBasketLkup],[ShowOSTSummary]
					   ,[ShowEligibilitySummary],[ShowRPRSummary],[IsActive],[UTCCreatedOn],[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef]
					   ,[UTCHistoryCreatedOn],[HistoryCreatedByRef],[SaveAttempt])
				SELECT  [ADM_UserPreferenceId],[ADM_UserMasterRef],[ShowAlerts],[ShowResources],[BusinessSegmentLkup],[RoleLkup],[TimezoneLkup],[WorkBasketLkup],[ShowOSTSummary]
					   ,[ShowEligibilitySummary],[ShowRPRSummary],[IsActive],[UTCCreatedOn],[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef],@UTCDate,@ADM_UserPreferenceId,@SaveAttempt
				FROM	[ADM_UserPreference]
				WHERE	ADM_UserPreferenceId = @ADM_UserPreferenceId

		COMMIT TRAN
	END TRY

	BEGIN CATCH
		Begin Try Rollback Tran; End Try Begin Catch End Catch
		SET @ErrorMessage= ERROR_MESSAGE();
	END CATCH  
END
GO