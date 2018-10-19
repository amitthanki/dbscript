IF OBJECT_ID ('USP_APP_INS_ADM_UserMaster') IS NOT NULL 
BEGIN
	DROP PROC [dbo].[USP_APP_INS_ADM_UserMaster]
END
GO

IF OBJECT_ID ('USP_APP_UPD_ADM_UserMaster') IS NOT NULL 
BEGIN
	DROP PROC [dbo].[USP_APP_UPD_ADM_UserMaster]
END
GO

IF TYPE_ID ('TVP_UserAccessGroup') IS NOT NULL
BEGIN
	DROP Type [DBO].[TVP_UserAccessGroup]
END
GO

/****** Object:  UserDefinedTableType [dbo].[TVP_Skills]    Script Date: 06/21/2017 10:37:47 AM ******/
CREATE TYPE [dbo].[TVP_UserAccessGroup] AS TABLE(
[ADM_AccessGroupUserCorrelationId] bigint NULL,
[ADM_AccessGroupMasterRef] bigint NULL,
[ADM_UserMasterRef] bigint NULL,
[IsActive] bit NULL
)
GO

---------------------------------------------------------------------------------------------------

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:Venkata Subramanyam Perepu
-- Create date: 06/09/2017
-- Modified By: 
-- Modification Date: 
-- Description:To insert User details into DB
-- Eg.
-- Declare @ErrorMessage VARCHAR(2000)
-- Set @ErrorMessage=''
-- Exec [USP_APP_INS_ADM_UserMaster] @MSID=vperepu,@ErrorMessage = @ErrorMessage Output
-- =============================================
CREATE PROCEDURE [dbo].[USP_APP_INS_ADM_UserMaster]
@FirstName VARCHAR(100) = NULL,
@LastName VARCHAR(100) = NULL,
@FullName VARCHAR(250) = NULL,
@MSID VARCHAR(100),
@Email VARCHAR(100),
@StartDate DATETIME,
@EndDate DATETIME = NULL,
@IsManager Bit = 0,
@IsActive BIT = 1,
@CreatedBy BIGINT,
@CreatedByRoleLkup BIGINT = NULL,
@Title BIGINT = NULL,
@ManagerId BIGINT = NULL,
@LocationLkup BIGINT = NULL,
@SpecialistTitle VARCHAR(50) = NULL,
@SpecialistPhone VARCHAR(12) = NULL,
@SpecialistFax VARCHAR(12) = NULL,
@SpecialistHours VARCHAR(12) = NULL,
@SpecialistTimeZone BIGINT = NULL,
@UserAddressLine1 VARCHAR(100) = NULL,
@UserAddressLine2 VARCHAR(100) = NULL,
@UserCity VARCHAR(50) = NULL,
@UserStateLkup BIGINT = NULL,
@UserZip VARCHAR(10) = NULL,
@TV_UserAccessGroup as [dbo].[TVP_UserAccessGroup] readonly,
@ErrorMessage VARCHAR(2000) OUT
As
BEGIN
	BEGIN TRY
		BEGIN TRAN 

			--Set Current UTC Datetime
			DECLARE @UTCDATE datetime
			SET @UTCDATE = GETUTCDATE()

			DECLARE @SaveAttempt BIGINT
			UPDATE dbo.CMN_TableSequenceCounts SET @SaveAttempt=Sequence,Sequence=Sequence+1 WHERE CMN_TableSequenceCountsId=1;

			--Temp Table to Get newly inserted row id for User Access Correlation Table
			Create Table dbo.[#TUserAccess] (ADM_AccessGroupUserCorrelationId Bigint)

			INSERT INTO ADM_UserMaster(FirstName,LastName,FullName,MSID,Email,StartDate,EndDate,IsActive,Title,IsManager,ManagerId,LocationLkup,SpecialistTitle,SpecialistPhone,SpecialistFax,SpecialistHours,SpecialistTimeZone,UserAddressLine1,UserAddressLine2,UserCity,UserStateLkup,UserZip,UTCCreatedOn,CreatedByRef,CreatedByRoleLkup,UTCLastUpdatedOn,LastUpdatedByRef,LastUpdatedByRoleLkup)
			VALUES(@FirstName,@LastName,@FullName,@MSID,@Email,@StartDate,@EndDate,1,@Title,@IsManager,@ManagerId,@LocationLkup,@SpecialistTitle,@SpecialistPhone,@SpecialistFax,@SpecialistHours,@SpecialistTimeZone,@UserAddressLine1,@UserAddressLine2,@UserCity,@UserStateLkup,@UserZip,@UTCDATE,@CreatedBy,@CreatedByRoleLkup,@UTCDATE,@CreatedBy,@CreatedByRoleLkup)

			Declare @ADM_UserMasterId BIGINT;
			SELECT @ADM_UserMasterId = Scope_Identity()

			/************* START User Access Group Correlation INSERT *********************/

			INSERT INTO [dbo].[ADM_AccessGroupUserCorrelation]
						([ADM_AccessGroupMasterRef],[ADM_UserMasterRef],[IsActive],[UTCCreatedOn],[CreatedByRef],[CreatedByRoleLkup],[UTCLastUpdatedOn],[LastUpdatedByRef],[LastUpdatedByRoleLkup])
			
			-- Get all newly created Access group Skills Correlation id's for history insert
			Output INSERTED.ADM_AccessGroupUserCorrelationId Into dbo.[#TUserAccess]

			SELECT [ADM_AccessGroupMasterRef],@ADM_UserMasterId,1,@UTCDATE,@CreatedBy,@CreatedByRoleLkup,@UTCDate,@CreatedBy,@CreatedByRoleLkup
			FROM @TV_UserAccessGroup
			WHERE [ADM_AccessGroupUserCorrelationId] = 0

			/************* END User Access Group Correlation INSERT *********************/

			--Insert Data to History Table
			INSERT INTO ADM_UserMasterHistory(ADM_UserMasterRef,FirstName,LastName,FullName,MSID,Email,StartDate,EndDate,IsActive,Title,IsManager,ManagerId,LocationLkup,SpecialistTitle,SpecialistPhone,SpecialistFax,SpecialistHours,SpecialistTimeZone,UserAddressLine1,UserAddressLine2,UserCity,UserStateLkup,UserZip,UTCCreatedOn,CreatedByRef,CreatedByRoleLkup,UTCLastUpdatedOn,LastUpdatedByRef,LastUpdatedByRoleLkup,UTCHistoryCreatedOn,HistoryCreatedByRef,HistoryCreatedByRoleLkup,SaveAttempt)
			Select ADM_UserMasterId,FirstName,LastName,FullName,MSID,Email,StartDate,EndDate,IsActive,Title,IsManager,ManagerId,LocationLkup,SpecialistTitle,SpecialistPhone,SpecialistFax,SpecialistHours,SpecialistTimeZone,UserAddressLine1,UserAddressLine2,UserCity,UserStateLkup,UserZip,UTCCreatedOn,CreatedByRef,CreatedByRoleLkup,UTCLastUpdatedOn,LastUpdatedByRef,LastUpdatedByRoleLkup,@UTCDATE,@CreatedBy,@CreatedByRoleLkup,@SaveAttempt From ADM_UserMaster Where ADM_UserMasterId = @ADM_UserMasterId

			INSERT INTO [dbo].[ADM_AccessGroupUserCorrelationHistory]
					   ([ADM_AccessGroupUserCorrelationRef],[ADM_AccessGroupMasterRef],[ADM_UserMasterRef],[IsActive],[UTCCreatedOn],[CreatedByRef],[CreatedByRoleLkup],[UTCLastUpdatedOn]
					   ,[LastUpdatedByRef],[LastUpdatedByRoleLkup],[UTCHistoryCreatedOn],[HistoryCreatedByRef],[HistoryCreatedByRoleLkup],[SaveAttempt])
			SELECT		AGUC.[ADM_AccessGroupUserCorrelationId],AGUC.[ADM_AccessGroupMasterRef],AGUC.[ADM_UserMasterRef],AGUC.[IsActive],[UTCCreatedOn],[CreatedByRef],[CreatedByRoleLkup],[UTCLastUpdatedOn]
					   ,[LastUpdatedByRef],[LastUpdatedByRoleLkup],@UTCDATE,@CreatedBy,@CreatedByRoleLkup,@SaveAttempt
			FROM		ADM_AccessGroupUserCorrelation AGUC
							JOIN dbo.[#TUserAccess] T ON AGUC.ADM_AccessGroupUserCorrelationId = T.ADM_AccessGroupUserCorrelationId

		COMMIT TRAN
	END TRY
	BEGIN CATCH
		Begin Try Rollback Tran; End Try Begin Catch End Catch
		SET @ErrorMessage = Error_Message();
	END CATCH
END
GO

------------------------------------------------------------------------------

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:Venkata Subramanyam Perepu
-- Create date: 06/09/2017
-- Modified By: 
-- Modification Date: 
-- Description:To update user details in DB
-- Eg.
-- Declare @ErrorMessage VARCHAR(2000)
-- Set @ErrorMessage=''
-- Exec [USP_APP_UPD_ADM_UserMaster] @MSID=vperepu,@ErrorMessage = @ErrorMessage Output
-- =============================================
CREATE PROCEDURE [dbo].[USP_APP_UPD_ADM_UserMaster]
@ADM_UserMasterId BIGINT,
@FirstName VARCHAR(100) = NULL,
@LastName VARCHAR(100) = NULL,
@FullName VARCHAR(250) = NULL,
@MSID VARCHAR(100),
@Email VARCHAR(100),
@StartDate DATETIME,
@EndDate DATETIME = NULL,
@IsManager bit = 0,
@IsActive BIT = 1,
@UpdatedBy BIGINT,
@UpdatedByRoleLkup BIGINT = NULL,
@Title BIGINT = NULL,
@ManagerId BIGINT = NULL,
@LocationLkup BIGINT = NULL,
@SpecialistTitle VARCHAR(50) = NULL,
@SpecialistPhone VARCHAR(12) = NULL,
@SpecialistFax VARCHAR(12) = NULL,
@SpecialistHours VARCHAR(12) = NULL,
@SpecialistTimeZone BIGINT = NULL,
@UserAddressLine1 VARCHAR(100) = NULL,
@UserAddressLine2 VARCHAR(100) = NULL,
@UserCity VARCHAR(50) = NULL,
@UserStateLkup BIGINT = NULL,
@UserZip VARCHAR(10) = NULL,
@ScreenLkup Bigint,
@TV_UserAccessGroup as [dbo].[TVP_UserAccessGroup] readonly,
@ErrorMessage VARCHAR(2000) OUT
As
BEGIN
	BEGIN TRY
		BEGIN TRAN

			--Get current utc datetime
			Declare @UTCDate datetime
			Set @UTCDate=getutcdate()
			
			--Get SaveAttempt for History Insert
			DECLARE @SaveAttempt BIGINT
			UPDATE dbo.CMN_TableSequenceCounts SET @SaveAttempt=Sequence,Sequence=Sequence+1 WHERE CMN_TableSequenceCountsId=1;

			--Temp Table to Get newly inserted row id for User Access Correlation Table
			Create Table dbo.[#TUserAccess] (ADM_AccessGroupUserCorrelationId Bigint)

			--Update user details
			UPDATE ADM_UserMaster SET 
			FirstName=@FirstName,
			LastName=@LastName,
			FullName=@FullName,
			Email=@Email,
			StartDate=@StartDate,
			EndDate=@EndDate,			
			IsActive=@IsActive,
			Title=@Title,
			IsManager=@IsManager,
			ManagerId=@ManagerId,
			LocationLkup=@LocationLkup,
			SpecialistTitle=@SpecialistTitle,
			SpecialistPhone=@SpecialistPhone,
			SpecialistFax=@SpecialistFax,
			SpecialistHours=@SpecialistHours,
			SpecialistTimeZone=@SpecialistTimeZone,
			UserAddressLine1=@UserAddressLine1,
			UserAddressLine2=@UserAddressLine2,
			UserCity=@UserCity,
			UserStateLkup=@UserStateLkup,
			UserZip=@UserZip,
			UTCLastUpdatedOn=@UTCDate,
			LastUpdatedByRef=@UpdatedBy,
			LastUpdatedByRoleLkup=@UpdatedByRoleLkup
			WHERE ADM_UserMasterId=@ADM_UserMasterId

			/************* START User Access Group Correlation INSERT *********************/

			INSERT INTO [dbo].[ADM_AccessGroupUserCorrelation]
						([ADM_AccessGroupMasterRef],[ADM_UserMasterRef],[IsActive],[UTCCreatedOn],[CreatedByRef],[CreatedByRoleLkup],[UTCLastUpdatedOn],[LastUpdatedByRef],[LastUpdatedByRoleLkup])
			
			-- Get all newly created Access group Skills Correlation id's for history insert
			Output INSERTED.ADM_AccessGroupUserCorrelationId Into dbo.[#TUserAccess]

			SELECT [ADM_AccessGroupMasterRef],@ADM_UserMasterId,1,@UTCDATE,@UpdatedBy,@UpdatedByRoleLkup,@UTCDate,@UpdatedBy,@UpdatedByRoleLkup
			FROM @TV_UserAccessGroup
			WHERE [ADM_AccessGroupUserCorrelationId] = 0


			UPDATE [dbo].[ADM_AccessGroupUserCorrelation]
			   SET [ADM_AccessGroupMasterRef] = T.ADM_AccessGroupMasterRef
				  ,[ADM_UserMasterRef] = T.ADM_UserMasterRef
				  ,[IsActive] = T.IsActive
				  ,[UTCLastUpdatedOn] = @UTCDate
				  ,[LastUpdatedByRef] = @UpdatedBy
				  ,[LastUpdatedByRoleLkup] = @UpdatedByRoleLkup
			FROM @TV_UserAccessGroup T Where [dbo].[ADM_AccessGroupUserCorrelation].[ADM_AccessGroupUserCorrelationId] = T.[ADM_AccessGroupUserCorrelationId] and  T.[ADM_AccessGroupUserCorrelationId] > 0


			/************* END User Access Group Correlation INSERT *********************/

			--Insert to History
			INSERT INTO ADM_UserMasterHistory(ADM_UserMasterRef,FirstName,LastName,FullName,MSID,Email,StartDate,EndDate,IsActive,Title,IsManager,ManagerId,LocationLkup,SpecialistTitle,SpecialistPhone,SpecialistFax,SpecialistHours,SpecialistTimeZone,UserAddressLine1,UserAddressLine2,UserCity,UserStateLkup,UserZip,UTCCreatedOn,CreatedByRef,CreatedByRoleLkup,UTCLastUpdatedOn,LastUpdatedByRef,LastUpdatedByRoleLkup,UTCHistoryCreatedOn,HistoryCreatedByRef,HistoryCreatedByRoleLkup,SaveAttempt)
			Select ADM_UserMasterId,FirstName,LastName,FullName,MSID,Email,StartDate,EndDate,IsActive,Title,IsManager,ManagerId,LocationLkup,SpecialistTitle,SpecialistPhone,SpecialistFax,SpecialistHours,SpecialistTimeZone,UserAddressLine1,UserAddressLine2,UserCity,UserStateLkup,UserZip,UTCCreatedOn,CreatedByRef,CreatedByRoleLkup,UTCLastUpdatedOn,LastUpdatedByRef,LastUpdatedByRoleLkup,GETUTCDATE(),@UpdatedBy,@UpdatedByRoleLkup,@SaveAttempt From ADM_UserMaster Where ADM_UserMasterId = @ADM_UserMasterId

			INSERT INTO [dbo].[ADM_AccessGroupUserCorrelationHistory]
					   ([ADM_AccessGroupUserCorrelationRef],[ADM_AccessGroupMasterRef],[ADM_UserMasterRef],[IsActive],[UTCCreatedOn],[CreatedByRef],[CreatedByRoleLkup],[UTCLastUpdatedOn]
					   ,[LastUpdatedByRef],[LastUpdatedByRoleLkup],[UTCHistoryCreatedOn],[HistoryCreatedByRef],[HistoryCreatedByRoleLkup],[SaveAttempt])
			SELECT		AGUC.[ADM_AccessGroupUserCorrelationId],AGUC.[ADM_AccessGroupMasterRef],AGUC.[ADM_UserMasterRef],AGUC.[IsActive],[UTCCreatedOn],[CreatedByRef],[CreatedByRoleLkup],[UTCLastUpdatedOn]
					   ,[LastUpdatedByRef],[LastUpdatedByRoleLkup],@UTCDATE,@UpdatedBy,@UpdatedByRoleLkup,@SaveAttempt
			FROM		ADM_AccessGroupUserCorrelation AGUC
							Join @TV_UserAccessGroup TV On	TV.ADM_AccessGroupUserCorrelationId > 0 And 
															AGUC.[ADM_AccessGroupUserCorrelationId]  = TV.ADM_AccessGroupUserCorrelationId

			--Unlock record
			DELETE FROM CMN_RecordsLocked  WHERE  [ScreenLkup]=@ScreenLkup AND [CaseId]=@ADM_UserMasterId
			---------------
		
			DECLARE @TableName varchar(200)
			DECLARE @PKColumn varchar(200)
			Select @TableName = LookupValue1, @PKColumn = LookupValue2 From CMN_LookupMaster Where CMN_LookupMasterId = @ScreenLkup AND CMN_LookupTypeRef=37

			DECLARE @query NVARCHAR(MAX)=null

			SET @query = N'UPDATE '+Cast(@TableName As Varchar(200))+'
							SET LockedByRef = NULL,
								UTCLockedOn = NULL
							WHERE '+Cast(@PKColumn As Varchar(200))+' = '+Cast(@ADM_UserMasterId As Varchar(10))+''

			EXEC sp_executesql @query

		COMMIT TRAN
	END TRY
	BEGIN CATCH
		Begin Try Rollback Tran; End Try Begin Catch End Catch
		SET @ErrorMessage = Error_Message();
	END CATCH
END
GO