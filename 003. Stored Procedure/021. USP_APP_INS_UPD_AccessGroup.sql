IF OBJECT_ID ('USP_APP_INS_UPD_AccessGroup') IS NOT NULL
BEGIN
	DROP PROC [DBO].[USP_APP_INS_UPD_AccessGroup]
END
GO

IF TYPE_ID ('TVP_AccessGroupSkills') IS NOT NULL
BEGIN
	DROP Type [DBO].[TVP_AccessGroupSkills]
END
GO

IF TYPE_ID ('TVP_AccessGroupReports') IS NOT NULL
BEGIN	
	DROP Type [DBO].[TVP_AccessGroupReports]
END
GO

/****** Object:  UserDefinedTableType [dbo].[TVP_Skills]    Script Date: 06/21/2017 10:37:47 AM ******/
CREATE TYPE [dbo].[TVP_AccessGroupSkills] AS TABLE(
[ADM_AccessGroupSkillsCorrelationId] bigint NULL,
[ADM_AccessGroupMasterRef] bigint NULL,
[ADM_SkillsMasterRef] bigint NULL,
[CanCreate] bit NULL,
[CanModify] bit NULL,
[CanSearch] bit NULL,
[CanView] bit NULL,
[CanMassUpdate] bit NULL,
[CanHistory] bit NULL,
[CanReassign] bit NULL,
[CanUnlock] bit NULL,
[CanUpload] bit NULL,
[CanClone] bit NULL,
[CanReopen] bit NULL,
[IsActive] bit NULL
)
GO

/****** Object:  UserDefinedTableType [dbo].[TVP_AccessGroupReports]    Script Date: 06/21/2017 10:37:47 AM ******/
CREATE TYPE [dbo].[TVP_AccessGroupReports] AS TABLE(
[ADM_AccessGroupReportCorrelationId] bigint NULL,
[ADM_AccessGroupMasterRef] bigint NULL,
[RPT_ReportsMasterRef] bigint NULL,
[IsActive] bit NULL
)
GO

--------------------------------------------------------------

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: Sourabha Ranjan Barik
-- Create date: 06/21/2017
-- Modified By: 
-- Modification Date: 
-- Description: insert to error log
-- Eg.
-- Declare @ErrorMessage VARCHAR(2000)
-- Set @ErrorMessage=''
-- Exec [USP_APP_INS_UPD_AccessGroup] @ErrorMessage = @ErrorMessage Output
-- =============================================
CREATE PROCEDURE [dbo].[USP_APP_INS_UPD_AccessGroup]
@ADM_AccessGroupMasterId bigint = 0,
@AccessGroupName varchar(200),
@AccessGroupDescription varchar(500),
@RoleLkup bigint,
@WorkBasketLkup bigint,
@IsActive bit = 1,
@ScreenLkup Bigint,
@LoginUserId bigint,
@TV_Skills as [dbo].[TVP_AccessGroupSkills] readonly,
@TV_Reports as [dbo].[TVP_AccessGroupReports] readonly,
@ErrorMessage varchar(2000) OUTPUT
As
BEGIN
	BEGIN TRY
		BEGIN TRAN
			
			--Set Current UTC Datetime
			DECLARE @UTCDATE datetime = GETUTCDATE()

			DECLARE @IsEditMode Bit = 0

			--Set Save Attempt
			DECLARE @SaveAttempt BIGINT
			UPDATE dbo.CMN_TableSequenceCounts SET @SaveAttempt=Sequence,Sequence=Sequence+1 WHERE CMN_TableSequenceCountsId=1;

			--Temp Table to Get newly inserted row id for Skills Correlation Table
			Create Table dbo.[#TSkills] (ADM_AccessGroupSkillsCorrelationId Bigint)
			Create Table dbo.[#TReports] (ADM_AccessGroupReportCorrelationId Bigint)

			IF(@ADM_AccessGroupMasterId = 0)   --Add Mode
			BEGIN
				--Add data to access group master
				INSERT INTO [dbo].[ADM_AccessGroupMaster]
						   ([AccessGroupName],[AccessGroupDescription],[RoleLkup],[WorkBasketLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef])
					 VALUES
						   (@AccessGroupName,@AccessGroupDescription,@RoleLkup,@WorkBasketLkup,1,@UTCDate,@LoginUserId,@UTCDate,@LoginUserId)

				-- Get newly added accessgroup id for history insert & correlation insert
				SELECT @ADM_AccessGroupMasterId = Scope_Identity()

				/************* START Skills Correlation INSERT *********************/

				-- Insert all skills related to new access group
				INSERT INTO [dbo].[ADM_AccessGroupSkillsCorrelation]
					   ([ADM_AccessGroupMasterRef],[ADM_SkillsMasterRef],[CanCreate],[CanModify],[CanSearch],[CanView],[CanMassUpdate],[CanHistory],[CanReassign]
					   ,[CanUnlock],[CanUpload],[CanClone],[CanReopen],[IsActive],[UTCCreatedOn],[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef])
				
				-- Get all newly created Access group Skills Correlation id's for history insert
				Output INSERTED.ADM_AccessGroupSkillsCorrelationId Into dbo.[#TSkills]
    
				Select	@ADM_AccessGroupMasterId,ADM_SkillsMasterRef,CanCreate,CanModify,CanSearch,CanView,CanMassUpdate,CanHistory,CanReassign,CanUnlock,
						CanUpload,CanClone,CanReopen,IsActive,@UTCDate,@LoginUserId,@UTCDate,@LoginUserId 
				From	@TV_Skills 
				WHere	[ADM_AccessGroupSkillsCorrelationId] = 0

				/************* END Skills Correlation INSERT *********************/

				/************* START Reports Correlation INSERT *********************/

				-- Insert all reports related to new access group
				INSERT INTO [dbo].[ADM_AccessGroupReportCorrelation]
						([ADM_AccessGroupMasterRef],[RPT_ReportsMasterRef],[IsActive],[UTCCreatedOn],[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef])
				
				-- Get all newly created Access group Reports Correlation id's for history insert
				Output INSERTED.ADM_AccessGroupReportCorrelationId Into dbo.[#TReports]

				Select	@ADM_AccessGroupMasterId,RPT_ReportsMasterRef,IsActive ,@UTCDate,@LoginUserId,@UTCDate,@LoginUserId 
				From	@TV_Reports 
				Where	[ADM_AccessGroupReportCorrelationId] = 0

				/************* END Reports Correlation INSERT *********************/

			END
			ELSE  --Edit Mode
			BEGIN
				Set @IsEditMode = 1

				-- Update Access group details
				UPDATE [dbo].[ADM_AccessGroupMaster]
				   SET [AccessGroupName] = @AccessGroupName
					  ,[AccessGroupDescription] = @AccessGroupDescription
					  ,[RoleLkup] = @RoleLkup
					  ,[WorkBasketLkup] = @WorkBasketLkup
					  ,[IsActive] = @IsActive
					  ,[UTCLastUpdatedOn] = @UTCDate
					  ,[LastUpdatedByRef] = @LoginUserId
				 WHERE ADM_AccessGroupMasterId = @ADM_AccessGroupMasterId

				 /************* START Skills Correlation INSERT/UPDATE *********************/
				
				 -- Insert all new skills related to access group
				INSERT INTO [dbo].[ADM_AccessGroupSkillsCorrelation]
					   ([ADM_AccessGroupMasterRef],[ADM_SkillsMasterRef],[CanCreate],[CanModify],[CanSearch],[CanView],[CanMassUpdate],[CanHistory],[CanReassign]
					   ,[CanUnlock],[CanUpload],[CanClone],[CanReopen],[IsActive],[UTCCreatedOn],[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef])
    
				Output INSERTED.ADM_AccessGroupSkillsCorrelationId Into dbo.[#TSkills]
    
				Select @ADM_AccessGroupMasterId,ADM_SkillsMasterRef,CanCreate,CanModify,CanSearch,CanView,CanMassUpdate,CanHistory,CanReassign,CanUnlock,
					   CanUpload,CanClone,CanReopen,IsActive,@UTCDate,@LoginUserId,@UTCDate,@LoginUserId From @TV_Skills WHere [ADM_AccessGroupSkillsCorrelationId] = 0
					
				 -- Insert all existing skills related to access group
				 UPDATE [dbo].[ADM_AccessGroupSkillsCorrelation]
				   SET [ADM_AccessGroupMasterRef] = S.ADM_AccessGroupMasterRef
					  ,[ADM_SkillsMasterRef] = S.ADM_SkillsMasterRef
					  ,[CanCreate] = S.CanCreate
					  ,[CanModify] = S.CanModify
					  ,[CanSearch] = S.CanSearch
					  ,[CanView] = S.CanView
					  ,[CanMassUpdate] = S.CanMassUpdate
					  ,[CanHistory] = S.CanHistory
					  ,[CanReassign] = S.CanReassign
					  ,[CanUnlock] = S.CanUnlock
					  ,[CanUpload] = S.CanUpload
					  ,[CanClone] = S.CanClone
					  ,[CanReopen] = S.CanReopen
					  ,[IsActive] = S.IsActive
					  ,[UTCLastUpdatedOn] = @UTCDate
					  ,[LastUpdatedByRef] = @LoginUserId
				 FROM @TV_Skills S Where [dbo].[ADM_AccessGroupSkillsCorrelation].[ADM_AccessGroupSkillsCorrelationId] = S.ADM_AccessGroupSkillsCorrelationId AND S.ADM_AccessGroupSkillsCorrelationId > 0
				 
				 /************* END Skills Correlation INSERT/UPDATE *********************/

				 /************* START Reports Correlation INSERT/UPDATE *********************/

				 -- Insert all reports related to new access group
				 INSERT INTO [dbo].[ADM_AccessGroupReportCorrelation]
						([ADM_AccessGroupMasterRef],[RPT_ReportsMasterRef],[IsActive],[UTCCreatedOn],[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef])
				
				 -- Get all newly created Access group Reports Correlation id's for history insert
				 Output INSERTED.ADM_AccessGroupReportCorrelationId Into dbo.[#TReports]

				 Select	@ADM_AccessGroupMasterId,RPT_ReportsMasterRef,IsActive,@UTCDate,@LoginUserId,@UTCDate,@LoginUserId 
				 From	@TV_Reports 
				 Where	[ADM_AccessGroupReportCorrelationId] = 0

				 -- Insert all existing Reports related to access group
				 UPDATE [dbo].[ADM_AccessGroupReportCorrelation]
				   SET [ADM_AccessGroupMasterRef] = R.ADM_AccessGroupMasterRef
					  ,[RPT_ReportsMasterRef] = R.RPT_ReportsMasterRef
					  ,[IsActive] = R.IsActive
					  ,[UTCLastUpdatedOn] = @UTCDate
					  ,[LastUpdatedByRef] = @LoginUserId
				 FROM @TV_Reports R Where [dbo].[ADM_AccessGroupReportCorrelation].[ADM_AccessGroupReportCorrelationId] = R.ADM_AccessGroupReportCorrelationId AND R.ADM_AccessGroupReportCorrelationId > 0

				 /************* END Reports Correlation INSERT/UPDATE *********************/

			END

			--Insert data to history tables
			INSERT INTO [dbo].[ADM_AccessGroupMasterHistory]
					   ([ADM_AccessGroupMasterRef],[AccessGroupName],[AccessGroupDescription],[RoleLkup],[WorkBasketLkup],[IsActive]
					   ,[UTCCreatedOn],[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef],[UTCHistoryCreatedOn],[HistoryCreatedByRef],[SaveAttempt])
				SELECT ADM_AccessGroupMasterId,AccessGroupName,AccessGroupDescription,RoleLkup,WorkBasketLkup,IsActive,UTCCreatedOn,
					   CreatedByRef,UTCLastUpdatedOn,LastUpdatedByRef,@UTCDate,@LoginUserId,@SaveAttempt 
				FROM   [ADM_AccessGroupMaster] AG
				WHERE  [ADM_AccessGroupMasterId] = @ADM_AccessGroupMasterId

			INSERT INTO [dbo].[ADM_AccessGroupSkillsCorrelationHistory]
					   ([ADM_AccessGroupSkillsCorrelationRef],[ADM_AccessGroupMasterRef],[ADM_SkillsMasterRef],[CanCreate],[CanModify],[CanSearch],[CanView],[CanMassUpdate]
					   ,[CanHistory],[CanReassign],[CanUnlock],[CanUpload],[CanClone],[CanReopen],[IsActive],[UTCCreatedOn],[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef],[UTCHistoryCreatedOn]
					   ,[HistoryCreatedByRef],[SaveAttempt])
				SELECT  AGSC.[ADM_AccessGroupSkillsCorrelationId],AGSC.[ADM_AccessGroupMasterRef],AGSC.[ADM_SkillsMasterRef],AGSC.[CanCreate],AGSC.[CanModify],AGSC.[CanSearch],AGSC.[CanView],AGSC.[CanMassUpdate]
					   ,AGSC.[CanHistory],AGSC.[CanReassign],AGSC.[CanUnlock],AGSC.[CanUpload],AGSC.[CanClone],AGSC.[CanReopen],AGSC.[IsActive],AGSC.[UTCCreatedOn],AGSC.[CreatedByRef],AGSC.[UTCLastUpdatedOn],AGSC.[LastUpdatedByRef],@UTCDate,@LoginUserId,@SaveAttempt 
				FROM   [ADM_AccessGroupSkillsCorrelation] AGSC
						Join dbo.[#TSkills] T On AGSC.[ADM_AccessGroupSkillsCorrelationId] = T.ADM_AccessGroupSkillsCorrelationId
						--Join @TV_Skills TV On TV.ADM_AccessGroupSkillsCorrelationId > 0 And 
											  --AGSC.[ADM_AccessGroupSkillsCorrelationId]  = TV.ADM_AccessGroupSkillsCorrelationId

			INSERT INTO [dbo].[ADM_AccessGroupSkillsCorrelationHistory]
					   ([ADM_AccessGroupSkillsCorrelationRef],[ADM_AccessGroupMasterRef],[ADM_SkillsMasterRef],[CanCreate],[CanModify],[CanSearch],[CanView],[CanMassUpdate]
					   ,[CanHistory],[CanReassign],[CanUnlock],[CanUpload],[CanClone],[CanReopen],[IsActive],[UTCCreatedOn],[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef],[UTCHistoryCreatedOn]
					   ,[HistoryCreatedByRef],[SaveAttempt])
				SELECT  AGSC.[ADM_AccessGroupSkillsCorrelationId],AGSC.[ADM_AccessGroupMasterRef],AGSC.[ADM_SkillsMasterRef],AGSC.[CanCreate],AGSC.[CanModify],AGSC.[CanSearch],AGSC.[CanView],AGSC.[CanMassUpdate]
					   ,AGSC.[CanHistory],AGSC.[CanReassign],AGSC.[CanUnlock],AGSC.[CanUpload],AGSC.[CanClone],AGSC.[CanReopen],AGSC.[IsActive],AGSC.[UTCCreatedOn],AGSC.[CreatedByRef],AGSC.[UTCLastUpdatedOn],AGSC.[LastUpdatedByRef],@UTCDate,@LoginUserId,@SaveAttempt 
				FROM   [ADM_AccessGroupSkillsCorrelation] AGSC
						--Join dbo.[#TSkills] T On AGSC.[ADM_AccessGroupSkillsCorrelationId] = T.ADM_AccessGroupSkillsCorrelationId
						Join @TV_Skills TV On TV.ADM_AccessGroupSkillsCorrelationId > 0 And 
											  AGSC.[ADM_AccessGroupSkillsCorrelationId]  = TV.ADM_AccessGroupSkillsCorrelationId

			INSERT INTO [dbo].[ADM_AccessGroupReportCorrelationHistory]
					   ([ADM_AccessGroupReportCorrelationRef],[ADM_AccessGroupMasterRef],[RPT_ReportsMasterRef],[IsActive],[UTCCreatedOn],[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef]
					   ,[UTCHistoryCreatedOn],[HistoryCreatedByRef],[SaveAttempt])
				SELECT AGRC.[ADM_AccessGroupReportCorrelationId],AGRC.[ADM_AccessGroupMasterRef],AGRC.[RPT_ReportsMasterRef],AGRC.[IsActive],AGRC.[UTCCreatedOn],AGRC.[CreatedByRef],AGRC.[UTCLastUpdatedOn],AGRC.[LastUpdatedByRef],
						@UTCDate,@LoginUserId,@SaveAttempt 
				FROM   [ADM_AccessGroupReportCorrelation] AGRC
						Join dbo.[#TReports] R On AGRC.[ADM_AccessGroupReportCorrelationId] = R.ADM_AccessGroupReportCorrelationId
						--Join @TV_Reports TR On TR.ADM_AccessGroupReportCorrelationId > 0 And 
											--AGRC.[ADM_AccessGroupReportCorrelationId]  = TV.ADM_AccessGroupReportCorrelationId

			INSERT INTO [dbo].[ADM_AccessGroupReportCorrelationHistory]
					   ([ADM_AccessGroupReportCorrelationRef],[ADM_AccessGroupMasterRef],[RPT_ReportsMasterRef],[IsActive],[UTCCreatedOn],[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef]
					   ,[UTCHistoryCreatedOn],[HistoryCreatedByRef],[SaveAttempt])
				SELECT AGRC.[ADM_AccessGroupReportCorrelationId],AGRC.[ADM_AccessGroupMasterRef],AGRC.[RPT_ReportsMasterRef],AGRC.[IsActive],AGRC.[UTCCreatedOn],AGRC.[CreatedByRef],AGRC.[UTCLastUpdatedOn],AGRC.[LastUpdatedByRef],
						@UTCDate,@LoginUserId,@SaveAttempt 
				FROM   [ADM_AccessGroupReportCorrelation] AGRC
						--Join dbo.[#TReports] R On AGRC.[ADM_AccessGroupReportCorrelationId] = R.ADM_AccessGroupReportCorrelationId
						Join @TV_Reports TR On TR.ADM_AccessGroupReportCorrelationId > 0 And 
											AGRC.[ADM_AccessGroupReportCorrelationId]  = TR.ADM_AccessGroupReportCorrelationId

			---After Edit, Unlock the record
			IF(@IsEditMode = 1)
			BEGIN
			    ------------Unlock-----------------
			    DELETE CMN_RecordsLocked WHERE [ScreenLkup]=@ScreenLkup AND [CaseId]=@ADM_AccessGroupMasterId
				-----------------------------------
				
		
				DECLARE @TableName varchar(200)
				DECLARE @PKColumn varchar(200)
				Select @TableName = LookupValue1, @PKColumn = LookupValue2 From CMN_LookupMaster Where CMN_LookupMasterId = @ScreenLkup AND CMN_LookupTypeRef = 37

				DECLARE @query NVARCHAR(MAX)=null

				SET @query = N'UPDATE '+Cast(@TableName As Varchar(200))+'
							   SET LockedByRef = NULL,
								   UTCLockedOn = NULL
							   WHERE '+Cast(@PKColumn As Varchar(200))+' = '+Cast(@ADM_AccessGroupMasterId As Varchar(10))+''

				EXEC sp_executesql @query
			END

		COMMIT TRAN
	END TRY 

	BEGIN CATCH
		Begin Try Rollback Tran; End Try Begin Catch End Catch
		SET @ErrorMessage= ERROR_MESSAGE();
	END CATCH  
END