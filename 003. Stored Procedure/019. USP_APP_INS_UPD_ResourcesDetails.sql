IF OBJECT_ID ('USP_APP_INS_UPD_ResourceDetails') IS NOT NULL
BEGIN
	DROP PROC [dbo].[USP_APP_INS_UPD_ResourceDetails]
END
GO

/****** Object:  StoredProcedure [dbo].[USP_APP_INS_UPD_ResourceDetails]    Script Date: 14-06-2017 19:53:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: Harsh Kumar Singhi
-- Create date: 06/14/2017
-- Modified By: 
-- Modification Date: 
-- Description: insert and update values into Resource Details table in DB
-- Eg.
-- Declare @ErrorMessage VARCHAR(2000)
-- Set @ErrorMessage=''
-- Exec [USP_APP_INS_UPD_ResourceDetails] @ErrorMessage = @ErrorMessage Output
-- =============================================
CREATE PROCEDURE [dbo].[USP_APP_INS_UPD_ResourceDetails]
@ADM_ResourceDetailsId BIGINT = 0,
@ResourceName varchar(50) = NULL,
@ResourceDescription varchar(5000) = NULL,
@ResourceLinkLocation varchar(500) = NULL,
@ResourceEffectiveDate datetime = NULL,
@ResourceInactivationDate datetime = NULL,
@CMN_DepartmentRef bigint = NULL,
@IsActive bit = 1,
@LoginUserId BIGINT,
@ScreenLkup bigint,
@ErrorMessage VARCHAR(2000) OUT
AS
BEGIN  
	BEGIN TRY  
		BEGIN TRAN 
			--Get current utc datetime
			DECLARE @UTCDate DATETIME
			SET @UTCDate=getutcdate()

			--Get SaveAttempt for this action
			DECLARE @SaveAttempt BIGINT
			UPDATE dbo.CMN_TableSequenceCounts SET @SaveAttempt=Sequence,Sequence=Sequence+1 WHERE CMN_TableSequenceCountsId=1;

			DECLARE @IsEditMode Bit = 0

			IF(@ADM_ResourceDetailsId = 0) --- (0 => Insert, >0 => Update)
			BEGIN
				INSERT INTO [dbo].[ADM_ResourceDetails]
					   ([ResourceName],[ResourceDescription],[ResourceLinkLocation],[ResourceEffectiveDate],
						[ResourceInactivationDate],[CMN_DepartmentRef],[IsActive],[UTCCreatedOn],[CreatedByRef],[UTCLastUpdatedOn],
						[LastUpdatedByRef])
				 VALUES
					   (@ResourceName,@ResourceDescription,@ResourceLinkLocation,@ResourceEffectiveDate,@ResourceInactivationDate,
					    @CMN_DepartmentRef,1,@UTCDate,@LoginUserId,@UTCDate,@LoginUserId)

				SELECT @ADM_ResourceDetailsId = Scope_Identity()
			END
			ELSE 
			BEGIN
				Set @IsEditMode = 1

				UPDATE	[dbo].[ADM_ResourceDetails]
				SET		[ResourceName] = @ResourceName,[ResourceDescription]= @ResourceDescription,[ResourceLinkLocation] = @ResourceLinkLocation,
						[ResourceEffectiveDate] = @ResourceEffectiveDate, [ResourceInactivationDate] = @ResourceInactivationDate,
						[CMN_DepartmentRef] = @CMN_DepartmentRef, [IsActive] = @IsActive,[UTCLastUpdatedOn] = @UTCDate,
						[LastUpdatedByRef] = @LoginUserId   
				Where [ADM_ResourceDetailsId] = @ADM_ResourceDetailsId
			END

			------Insert the record into history table
			INSERT INTO [dbo].[ADM_ResourceDetailsHistory]
				   ([ADM_ResourceDetailsRef],[ResourceName],[ResourceDescription],[ResourceLinkLocation],[ResourceEffectiveDate],
					[ResourceInactivationDate],[CMN_DepartmentRef],[IsActive],[UTCCreatedOn],[CreatedByRef],[UTCLastUpdatedOn],
					[LastUpdatedByRef],[UTCHistoryCreatedOn],[HistoryCreatedByRef],[SaveAttempt])
			SELECT	[ADM_ResourceDetailsId],[ResourceName],[ResourceDescription],[ResourceLinkLocation],[ResourceEffectiveDate],
					[ResourceInactivationDate],[CMN_DepartmentRef],[IsActive],[UTCCreatedOn],[CreatedByRef],[UTCLastUpdatedOn],
					[LastUpdatedByRef],@UTCDate,@LoginUserId,@SaveAttempt
			FROM	[ADM_ResourceDetails]
			WHERE	[ADM_ResourceDetailsId] = @ADM_ResourceDetailsId

			---After Edit, Unlock the record
			IF(@IsEditMode = 1)
			BEGIN
			    
				DELETE FROM CMN_RecordsLocked WHERE  [ScreenLkup]=@ScreenLkup AND [CaseId]=@ADM_ResourceDetailsId
				
		
				DECLARE @TableName varchar(200)
				DECLARE @PKColumn varchar(200)
				Select @TableName = LookupValue1, @PKColumn = LookupValue2 From CMN_LookupMaster Where CMN_LookupMasterId = @ScreenLkup AND CMN_LookupTypeRef = 37

				DECLARE @query NVARCHAR(MAX)=null

				SET @query = N'UPDATE '+Cast(@TableName As Varchar(200))+'
							   SET LockedByRef = NULL,
								   UTCLockedOn = NULL
							   WHERE '+Cast(@PKColumn As Varchar(200))+' = '+Cast(@ADM_ResourceDetailsId As Varchar(10))+''

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
