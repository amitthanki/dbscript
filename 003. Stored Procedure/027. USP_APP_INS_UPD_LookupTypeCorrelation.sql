IF OBJECT_ID ('USP_APP_INS_UPD_LookupTypeCorrelation') IS NOT NULL
BEGIN
	DROP PROC [dbo].[USP_APP_INS_UPD_LookupTypeCorrelation]
END
GO

/****** Object:  StoredProcedure [dbo].[USP_APP_INS_UPD_LookupTypeCorrelation]    Script Date: 12-06-2017 19:53:27 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author: Harsh Kumar Singhi
-- Create date: 06/14/2017
-- Modified By: 
-- Modification Date: 
-- Description: insert and update values into Lookup type Correlation table in DB.
-- Eg.
-- Declare @ErrorMessage VARCHAR(2000)
-- Set @ErrorMessage=''
-- Exec [USP_APP_INS_UPD_LookupTypeCorrelation] @ErrorMessage = @ErrorMessage Output
-- =============================================
CREATE PROCEDURE [dbo].[USP_APP_INS_UPD_LookupTypeCorrelation]
@CMN_LookupTypeCorrelationsId BIGINT = 0,
@CorrelationDescription VARCHAR(1000) = NULL,
@CMN_LookupTypeParentRef BIGINT = 0,
@CMN_LookupTypeChildRef BIGINT = 0,
@GroupingLookupTypeRef BIGINT = 0,
@LoginUserId BIGINT,
@IsActive BIT = 1,
@ScreenLkup bigint,
@ErrorMessage VARCHAR(2000) OUT
AS
BEGIN  
	BEGIN TRY  
		BEGIN TRAN 
			DECLARE @UTCDate datetime
			SET @UTCDate=getutcdate()

			DECLARE @SaveAttempt BIGINT
			UPDATE dbo.CMN_TableSequenceCounts SET @SaveAttempt=Sequence,Sequence=Sequence+1 WHERE CMN_TableSequenceCountsId=1;

			DECLARE @IsEditMode Bit = 0

			IF(@CMN_LookupTypeCorrelationsId = 0) --- (0=> Insert, >0 => Update)
			BEGIN
				Declare @MaxId bigint = 0
				Select @MaxId = Max(CMN_LookupTypeCorrelationsId) From [CMN_LookupTypeCorrelations]

				IF(@MaxId < 1000)
					Set @CMN_LookupTypeCorrelationsId = 1000				
				ELSE
					Set @CMN_LookupTypeCorrelationsId = @MaxId + 1

				INSERT INTO [dbo].[CMN_LookupTypeCorrelations]
						([CMN_LookupTypeCorrelationsId],[CMN_LookupTypeParentRef],[CMN_LookupTypeChildRef],[CorrelationDescription],[GroupingLookupTypeRef],[IsActive]
						,[UTCCreatedOn],[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef])
				VALUES
				    	(@CMN_LookupTypeCorrelationsId,@CMN_LookupTypeParentRef,@CMN_LookupTypeChildRef,@CorrelationDescription,@GroupingLookupTypeRef,1
						,@UTCDate,@LoginUserId,@UTCDate,@LoginUserId)
			END
			ELSE 
			BEGIN
				Set @IsEditMode = 1

				UPDATE [dbo].[CMN_LookupTypeCorrelations]
				SET  [CorrelationDescription] = @CorrelationDescription
					,[CMN_LookupTypeParentRef] = @CMN_LookupTypeParentRef
					,[CMN_LookupTypeChildRef] = @CMN_LookupTypeChildRef
					,[GroupingLookupTypeRef] = @GroupingLookupTypeRef
					,[IsActive] = @IsActive
					,[UTCLastUpdatedOn] = @UTCDate
					,[LastUpdatedByRef] = @LoginUserId          
				WHERE [CMN_LookupTypeCorrelationsId] = @CMN_LookupTypeCorrelationsId
			END

			------Insert the record into history table
			INSERT INTO [dbo].[CMN_LookupTypeCorrelationsHistory]
			   ([CMN_LookupTypeCorrelationsRef],[CMN_LookupTypeParentRef],[CMN_LookupTypeChildRef],[CorrelationDescription],[GroupingLookupTypeRef],[IsActive],
			   [UTCCreatedOn],[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef],[UTCHistoryCreatedOn],[HistoryCreatedByRef],
			   [SaveAttempt])
			SELECT [CMN_LookupTypeCorrelationsId],[CMN_LookupTypeParentRef],[CMN_LookupTypeChildRef],[CorrelationDescription],[GroupingLookupTypeRef],[IsActive]
			       ,[UTCCreatedOn],[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef],@UTCDate,@LoginUserId,@SaveAttempt
			FROM [CMN_LookupTypeCorrelations]
			WHERE [CMN_LookupTypeCorrelationsId] = @CMN_LookupTypeCorrelationsId

			---After Edit, Unlock the record
			IF(@IsEditMode = 1)
			BEGIN
			    DELETE FROM dbo.CMN_RecordsLocked WHERE [ScreenLkup]=@ScreenLkup AND [CaseId]=@CMN_LookupTypeCorrelationsId
	
		
				DECLARE @TableName varchar(200)
				DECLARE @PKColumn varchar(200)
				Select @TableName = LookupValue1, @PKColumn = LookupValue2 From CMN_LookupMaster Where CMN_LookupMasterId = @ScreenLkup AND CMN_LookupTypeRef = 37

				DECLARE @query NVARCHAR(MAX)=null

				SET @query = N'UPDATE '+Cast(@TableName As Varchar(200))+'
							   SET LockedByRef = NULL,
								   UTCLockedOn = NULL
							   WHERE '+Cast(@PKColumn As Varchar(200))+' = '+Cast(@CMN_LookupTypeCorrelationsId As Varchar(10))+''

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
