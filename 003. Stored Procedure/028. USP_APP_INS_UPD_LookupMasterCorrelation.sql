IF OBJECT_ID ('USP_APP_INS_UPD_LookupMasterCorrelation') IS NOT NULL
BEGIN
	DROP PROC [dbo].[USP_APP_INS_UPD_LookupMasterCorrelation]
END
GO

/****** Object:  StoredProcedure [dbo].[USP_APP_INS_UPD_LookupMasterCorrelation]    Script Date: 12-06-2017 19:53:27 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author: Harsh Kumar Singhi
-- Create date: 06/14/2017
-- Modified By: 
-- Modification Date: 
-- Description: insert and update values into Lookup master Correlation table in DB.
-- Eg.
-- Declare @ErrorMessage VARCHAR(2000)
-- Set @ErrorMessage=''
-- Exec [USP_APP_INS_UPD_LookupMasterCorrelation] @ErrorMessage = @ErrorMessage Output
-- =============================================
CREATE PROCEDURE [dbo].[USP_APP_INS_UPD_LookupMasterCorrelation]
@CMN_LookupMasterCorrelationsId bigint = 0,
@CMN_LookupTypeCorrelationsRef bigint = 0,
@CMN_LookupMasterParentRef bigint = 0,
@CMN_LookupMasterChildRef bigint = 0,
@GroupingLookupMasterRef bigint = NULL,
@CorrelationDescription varchar(1000) = NULL,
@DisplayOrder bigint = 1,
@IsActive BIT = 1,
@LoginUserId BIGINT,
@ErrorMessage VARCHAR(2000) OUT
AS
BEGIN  
	BEGIN TRY  
		BEGIN TRAN 
			DECLARE @UTCDate datetime
			SET @UTCDate=getutcdate()

			DECLARE @SaveAttempt BIGINT
			UPDATE dbo.CMN_TableSequenceCounts SET @SaveAttempt=Sequence,Sequence=Sequence+1 WHERE CMN_TableSequenceCountsId=1;

			IF(@CMN_LookupMasterCorrelationsId = 0) --- (0=> Insert, >0 => Update)
			BEGIN
				Declare @MaxId bigint = 0
				Select @MaxId = ISNULL(Max(CMN_LookupMasterCorrelationsId),@CMN_LookupTypeCorrelationsRef * 1000) From [CMN_LookupMasterCorrelations] Where [CMN_LookupTypeCorrelationsRef] = @CMN_LookupTypeCorrelationsRef

				IF(@MaxId < 1000000)
					Set @CMN_LookupMasterCorrelationsId = @CMN_LookupTypeCorrelationsRef * 1000;
				ELSE
					Set @CMN_LookupMasterCorrelationsId = @MaxId + 1
				
				INSERT INTO [dbo].[CMN_LookupMasterCorrelations]
						   ([CMN_LookupMasterCorrelationsId],[CMN_LookupTypeCorrelationsRef],[CMN_LookupMasterParentRef],[CMN_LookupMasterChildRef],[GroupingLookupMasterRef]
						   ,[CorrelationDescription],[DisplayOrder],[IsActive],[UTCCreatedOn],[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef])
					 VALUES
						   (@CMN_LookupMasterCorrelationsId,@CMN_LookupTypeCorrelationsRef,@CMN_LookupMasterParentRef,@CMN_LookupMasterChildRef
						   ,@GroupingLookupMasterRef,@CorrelationDescription,@DisplayOrder,1,@UTCDate,@LoginUserId,@UTCDate,@LoginUserId)
			END
			ELSE 
			BEGIN
				UPDATE [dbo].[CMN_LookupMasterCorrelations]
				   SET [CMN_LookupTypeCorrelationsRef] = @CMN_LookupTypeCorrelationsRef
					  ,[CMN_LookupMasterParentRef] = @CMN_LookupMasterParentRef
					  ,[CMN_LookupMasterChildRef] = @CMN_LookupMasterChildRef
					  ,[GroupingLookupMasterRef] = @GroupingLookupMasterRef
					  ,[CorrelationDescription] = @CorrelationDescription
					  ,[DisplayOrder] = @DisplayOrder
					  ,[IsActive] = @IsActive
					  ,[UTCLastUpdatedOn] = @UTCDate
					  ,[LastUpdatedByRef] = @LoginUserId       
				WHERE [CMN_LookupMasterCorrelationsId] = @CMN_LookupMasterCorrelationsId
			END

			------Insert the record into history table
			INSERT INTO [dbo].[CMN_LookupMasterCorrelationsHistory]
					   ([CMN_LookupMasterCorrelationsRef],[CMN_LookupTypeCorrelationsRef],[CMN_LookupMasterParentRef],[CMN_LookupMasterChildRef],[GroupingLookupMasterRef]
					   ,[CorrelationDescription],[DisplayOrder],[IsActive],[UTCCreatedOn],[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef],[UTCHistoryCreatedOn]
					   ,[HistoryCreatedByRef],[SaveAttempt])
				SELECT	[CMN_LookupMasterCorrelationsId],[CMN_LookupTypeCorrelationsRef],[CMN_LookupMasterParentRef],[CMN_LookupMasterChildRef],[GroupingLookupMasterRef]
					   ,[CorrelationDescription],[DisplayOrder],[IsActive],[UTCCreatedOn],[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef],@UTCDate,@LoginUserId,@SaveAttempt
				FROM	[CMN_LookupMasterCorrelations]
				WHERE	[CMN_LookupMasterCorrelationsId] = @CMN_LookupMasterCorrelationsId

 		COMMIT TRAN
	END TRY 

	BEGIN CATCH
		Begin Try Rollback Tran; End Try Begin Catch End Catch
		SET @ErrorMessage= ERROR_MESSAGE();
	END CATCH  
END
GO