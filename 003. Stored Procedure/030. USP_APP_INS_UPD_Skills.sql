IF OBJECT_ID ('USP_APP_INS_UPD_Skills') IS NOT NULL
BEGIN
	DROP PROC [DBO].[USP_APP_INS_UPD_Skills]
END
GO

IF TYPE_ID ('TVP_SkillWorkQueues') IS NOT NULL
BEGIN
	DROP Type [DBO].[TVP_SkillWorkQueues]
END
GO

/****** Object:  UserDefinedTableType [dbo].[TVP_SkillWorkQueue]    Script Date: 06/22/2017 10:37:47 AM ******/
CREATE TYPE [dbo].[TVP_SkillWorkQueues] AS TABLE(
	[ADM_SkillWorkQueuesCorrelationId] bigint NULL,
	[ADM_SkillsMasterRef] bigint NULL,
	[WorkQueuesLkup] bigint NULL,
	[IsActive] bit NULL
)
GO

/****** Object:  StoredProcedure [dbo].[USP_APP_INS_UPD_Skills]    Script Date: 22-06-2017 21:10:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: Harsh Kumar Singhi
-- Create date: 06/15/2017
-- Modified By: 
-- Modification Date: 
-- Description: insert and update values into skills table in db.
-- Eg.
-- Declare @ErrorMessage VARCHAR(2000)
-- Set @ErrorMessage=''
-- Exec [USP_APP_INS_UPD_Skills] @ErrorMessage = @ErrorMessage Output
-- =============================================
CREATE PROCEDURE [dbo].[USP_APP_INS_UPD_Skills]
@ADM_SkillsMasterId BIGINT = 0,
@SkillsName VARCHAR(200) = NULL,
@RoleLkup BIGINT = NULL,
@BusinessSegmentLkup BIGINT = NULL,
@CMN_DepartmentRef BIGINT = NULL,
@WorkBasketLkup BIGINT = NULL,
@DiscrepancyCategoryLkup BIGINT = NULL,
@LoginUserId BIGINT,
@IsActive BIT = 1,
@ScreenLkup Bigint,
@TV_Queues as [dbo].[TVP_SkillWorkQueues] readonly,
@ErrorMessage VARCHAR(2000) OUT
AS
BEGIN  
	BEGIN TRY  
		BEGIN TRAN 

			-- Set Current UTC datetime
			DECLARE @UTCDate DATETIME
			SET @UTCDate=getutcdate()

			-- Set Save Attempt
			DECLARE @SaveAttempt BIGINT
			UPDATE dbo.CMN_TableSequenceCounts SET @SaveAttempt=Sequence,Sequence=Sequence+1 WHERE CMN_TableSequenceCountsId=1;

			--Temp Table to Get newly inserted row id for Skills workgroup Correlation Table
			Create Table dbo.[#TSkillsWorkQueues] (ADM_SkillWorkQueuesCorrelationId Bigint)

			DECLARE @IsEditMode Bit = 0

			IF(@ADM_SkillsMasterId = 0) -- Add Mode
			BEGIN
				-- Add data to Skills master
				INSERT INTO [dbo].[ADM_SkillsMaster]
					   ([SkillsName],[RoleLkup],[BusinessSegmentLkup],[CMN_DepartmentRef],[WorkBasketLkup],[DiscrepancyCategoryLkup],[IsActive],[UTCCreatedOn],
					   [CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef])
				VALUES
					   (@SkillsName,@RoleLkup,@BusinessSegmentLkup,@CMN_DepartmentRef,@WorkBasketLkup,@DiscrepancyCategoryLkup,1,@UTCDate,@LoginUserId,@UTCDate,
					   @LoginUserId)			 
				
				-- Get newly added skillsMaster Id for history insert & correlation insert
				SELECT @ADM_SkillsMasterId = Scope_Identity()

				/************START skills workqueue correlation INSERT **********************/

				-- Insert all work queue related to new skill 
				INSERT INTO [dbo].[ADM_SkillWorkQueuesCorrelation]
					   ([ADM_SkillsMasterRef],[WorkQueuesLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],
					   [UTCLastUpdatedOn],[LastUpdatedByRef])

				-- Get all newly create skill work queue correaltion ids for history insert
				OUTPUT INSERTED.ADM_SkillWorkQueuesCorrelationId Into dbo.[#TSkillsWorkQueues]

				SELECT @ADM_SkillsMasterId,WorkQueuesLkup,IsActive,@UTCDate,@LoginUserId,
					   @UTCDate,@LoginUserId From @TV_Queues WHere [ADM_SkillWorkQueuesCorrelationId] = 0

			END
			ELSE -- Edit Mode
			BEGIN
				Set @IsEditMode = 1

				-- Update Skill details
				UPDATE [dbo].[ADM_SkillsMaster]
				Set    [SkillsName] = @SkillsName,[RoleLkup] = @RoleLkup,[BusinessSegmentLkup] = @BusinessSegmentLkup,
					   [CMN_DepartmentRef] = @CMN_DepartmentRef, [WorkBasketLkup] = @WorkBasketLkup, [DiscrepancyCategoryLkup] = @DiscrepancyCategoryLkup, [IsActive] = @IsActive,
					   [UTCLastUpdatedOn] = @UTCDate, [LastUpdatedByRef] = @LoginUserId   
				Where  [ADM_SkillsMasterId] = @ADM_SkillsMasterId


				/**************** START skills work queue correlation INSERT/UPDATE **********************/

				-- Insert all new work queues related to skill
				INSERT INTO [dbo].[ADM_SkillWorkQueuesCorrelation]
					   ([ADM_SkillsMasterRef],[WorkQueuesLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],
					   [UTCLastUpdatedOn],[LastUpdatedByRef])

				OUTPUT INSERTED.ADM_SkillWorkQueuesCorrelationId Into dbo.[#TSkillsWorkQueues]

				SELECT @ADM_SkillsMasterId,WorkQueuesLkup,IsActive,@UTCDate,@LoginUserId,
					   @UTCDate,@LoginUserId From @TV_Queues WHere [ADM_SkillWorkQueuesCorrelationId] = 0

				-- Insert all existing work queues related to skill
			     UPDATE [dbo].[ADM_SkillWorkQueuesCorrelation]
				   SET [ADM_SkillsMasterRef] = S.ADM_SkillsMasterRef
					  ,[WorkQueuesLkup] = S.WorkQueuesLkup
					  ,[IsActive] = S.IsActive
					  ,[UTCLastUpdatedOn] = @UTCDate
					  ,[LastUpdatedByRef] = @LoginUserId					  
				FROM @TV_Queues S Where S.ADM_SkillWorkQueuesCorrelationId > 0
				AND [dbo].[ADM_SkillWorkQueuesCorrelation].ADM_SkillWorkQueuesCorrelationId = S.ADM_SkillWorkQueuesCorrelationId 
				AND ([dbo].[ADM_SkillWorkQueuesCorrelation].[WorkQueuesLkup] <> S.WorkQueuesLkup OR [dbo].[ADM_SkillWorkQueuesCorrelation].[IsActive]  != S.IsActive)

				 /**************** END Skills Correlation INSERT/UPDATE ************************/
			END		   

			------Insert the record into history table
			INSERT INTO [dbo].[ADM_SkillsMasterHistory]
					([ADM_SkillsMasterRef],[SkillsName],[RoleLkup],[BusinessSegmentLkup],[CMN_DepartmentRef],[WorkBasketLkup],[DiscrepancyCategoryLkup],[IsActive],
					 [UTCCreatedOn],[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef],[UTCHistoryCreatedOn],[HistoryCreatedByRef],
					 [SaveAttempt])
			SELECT	 [ADM_SkillsMasterId],[SkillsName],[RoleLkup],[BusinessSegmentLkup],[CMN_DepartmentRef],[WorkBasketLkup],[DiscrepancyCategoryLkup],[IsActive],
					 [UTCCreatedOn],[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef],@UTCDate,@LoginUserId,@SaveAttempt
			FROM	 [ADM_SkillsMaster]
			WHERE	 [ADM_SkillsMasterId] = @ADM_SkillsMasterId


			INSERT INTO [dbo].[ADM_SkillWorkQueuesCorrelationHistory]
						([ADM_SkillWorkQueuesCorrelationRef],[ADM_SkillsMasterRef],[WorkQueuesLkup],[IsActive],
						[UTCCreatedOn],[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef],[UTCHistoryCreatedOn],[HistoryCreatedByRef],
						[SaveAttempt])
		     SELECT		ASWQ.[ADM_SkillWorkQueuesCorrelationId],ASWQ.[ADM_SkillsMasterRef],ASWQ.[WorkQueuesLkup],ASWQ.[IsActive],
						ASWQ.[UTCCreatedOn],ASWQ.[CreatedByRef],ASWQ.[UTCLastUpdatedOn],ASWQ.[LastUpdatedByRef],@UTCDate,@LoginUserId,@SaveAttempt 
			 FROM       [ADM_SkillWorkQueuesCorrelation] ASWQ
						JOIN dbo.[#TSkillsWorkQueues] T on ASWQ.[ADM_SkillWorkQueuesCorrelationId] = T.ADM_SkillWorkQueuesCorrelationId
						--JOIN @TV_Queues TV on TV.ADM_SkillWorkQueuesCorrelationId > 0 and 
													 -- ASWQ.[ADM_SkillWorkQueuesCorrelationId] = TV.ADM_SkillWorkQueuesCorrelationId

			INSERT INTO [dbo].[ADM_SkillWorkQueuesCorrelationHistory]
						([ADM_SkillWorkQueuesCorrelationRef],[ADM_SkillsMasterRef],[WorkQueuesLkup],[IsActive],
						[UTCCreatedOn],[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef],[UTCHistoryCreatedOn],[HistoryCreatedByRef],
						[SaveAttempt])
		     SELECT		ASWQ.[ADM_SkillWorkQueuesCorrelationId],ASWQ.[ADM_SkillsMasterRef],ASWQ.[WorkQueuesLkup],ASWQ.[IsActive],
						ASWQ.[UTCCreatedOn],ASWQ.[CreatedByRef],ASWQ.[UTCLastUpdatedOn],ASWQ.[LastUpdatedByRef],@UTCDate,@LoginUserId,@SaveAttempt 
			 FROM       [ADM_SkillWorkQueuesCorrelation] ASWQ
						--JOIN dbo.[#TSkillsWorkQueues] T on ASWQ.[ADM_SkillWorkQueuesCorrelationId] = T.ADM_SkillWorkQueuesCorrelationId
						JOIN @TV_Queues TV on TV.ADM_SkillWorkQueuesCorrelationId > 0 and 
													 ASWQ.[ADM_SkillWorkQueuesCorrelationId] = TV.ADM_SkillWorkQueuesCorrelationId


			---After Edit, Unlock the record
			IF(@IsEditMode = 1)
			BEGIN

			    DELETE FROM CMN_RecordsLocked WHERE [ScreenLkup]=@ScreenLkup AND [CaseId]=@ADM_SkillsMasterId
		
				DECLARE @TableName varchar(200)
				DECLARE @PKColumn varchar(200)
				Select @TableName = LookupValue1, @PKColumn = LookupValue2 From CMN_LookupMaster Where CMN_LookupMasterId = @ScreenLkup AND CMN_LookupTypeRef = 37

				DECLARE @query NVARCHAR(MAX)=null

				SET @query = N'UPDATE '+Cast(@TableName As Varchar(200))+'
							   SET LockedByRef = NULL,
								   UTCLockedOn = NULL
							   WHERE '+Cast(@PKColumn As Varchar(200))+' = '+Cast(@ADM_SkillsMasterId As Varchar(10))+''

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