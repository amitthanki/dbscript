IF OBJECT_ID ('USP_APP_INS_BulkReassignRecord') IS NOT NULL 
BEGIN
	DROP PROC [dbo].[USP_APP_INS_BulkReassignRecord]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- =============================================
-- Author: Venkatasubramanyam
-- Create date: 05/19/2017
-- Description: to reassign record.
-- Eg.
 --Declare @ErrorMessage VARCHAR(2000)
 --Set @ErrorMessage=''
 --Exec [USP_APP_INS_BulkReassignRecord] ,@GEN_QueueRef=1,@ReAssignUserRef=1,@ActionPerformedLkup=28035,@CurrentUserRef=1001,@CasesComments='',@ErrorMessage = @ErrorMessage Output
-- =============================================
CREATE PROCEDURE [dbo].[USP_APP_INS_BulkReassignRecord]
@GEN_QueueRef BIGINT=NULL,
@QueueIds VARCHAR(MAX),
@ReAssignUserRef BIGINT,
@ActionPerformedLkup BIGINT,
@CurrentUserRef  BIGINT,
@CasesComments VARCHAR(2000),
@ErrorMessage VARCHAR(2000) OUT

AS
BEGIN  
	BEGIN TRY  
		BEGIN TRAN 
		DECLARE @GEN_QueueIds TABLE (ID BIGINT IDENTITY(1,1),QueueID BIGINT)

		INSERT INTO @GEN_QueueIds
		SELECT Item AS QueueID FROM SplitString(@QueueIds,',') WHERE Item <>''
		
		DECLARE @UTCDate DATETIME=NULL
		DECLARE @UTCDateId BIGINT=NULL
		DECLARE @CSTDate DATETIME=NULL
		DECLARE @CSTDateId BIGINT=NULL
		
		SET @UTCDate=GETUTCDATE()
		SET @CSTDate=DATEADD(MINUTE,DATEDIFF(MINUTE,@UTCDate,GETDATE()),@UTCDate)
		SET @UTCDateId=CAST(CAST(DATEPART(MONTH,@UTCDate) AS VARCHAR(10))+CAST(DATEPART(DAY,@UTCDate) AS VARCHAR(10))+CAST(DATEPART(YEAR,@UTCDate) AS VARCHAR(10)) AS bigint)
		SET @CSTDateId=CAST(CAST(DATEPART(MONTH,@CSTDate) AS VARCHAR(10))+CAST(DATEPART(DAY,@CSTDate) AS VARCHAR(10))+CAST(DATEPART(YEAR,@CSTDate) AS VARCHAR(10)) AS bigint)

		DECLARE @Initial INT =1
		DECLARE @QId BIGINT=NULL
		DECLARE @Total INT =0
		SELECT @Total=COUNT(QueueID) FROM @GEN_QueueIds

		DECLARE @LockedByRef BIGINT = NULL

		WHILE @Initial <= @Total
		BEGIN
		   SELECT @QId=QueueID FROM @GEN_QueueIds WHERE ID=@Initial;
		   
		   SELECT @LockedByRef = LockedByRef FROM GEN_Queue WHERE GEN_QueueId=@QId

			UPDATE GEN_Queue SET 
			AssignedToRef=@ReAssignUserRef,
			UTCAssignedOn=@UTCDate,
			UTCAssignedOnId=@UTCDateId,
			UTCAssignedOnYear=DATEPART(YEAR,@UTCDate),
			UTCAssignedOnMonth=DATEPART(MONTH,@UTCDate),
			UTCAssignedOnDay=DATEPART(DAY,@UTCDate),
			CSTAssignedOn=@CSTDate,
			CSTAssignedOnId=@CSTDateId,
			CSTAssignedOnYear=DATEPART(YEAR,@CSTDate),
			CSTAssignedOnMonth=DATEPART(MONTH,@CSTDate),
			CSTAssignedOnDay=DATEPART(DAY,@CSTDate),
			PendedbyRef=@ReAssignUserRef,
			UTCPendedOn=CASE WHEN IsCasePended=1 THEN @UTCDate ELSE NULL END,
			UTCPendedOnId=CASE WHEN IsCasePended=1 THEN @UTCDateId ELSE NULL END,
			UTCPendedOnYear=CASE WHEN IsCasePended=1 THEN DATEPART(YEAR,@UTCDate) ELSE NULL END,
			UTCPendedOnMonth=CASE WHEN IsCasePended=1 THEN DATEPART(MONTH,@UTCDate) ELSE NULL END,
			UTCPendedOnDay=CASE WHEN IsCasePended=1 THEN DATEPART(DAY,@UTCDate) ELSE NULL END,
			CSTPendedOn=CASE WHEN IsCasePended=1 THEN @CSTDate ELSE NULL END,
			CSTPendedOnId=CASE WHEN IsCasePended=1 THEN @CSTDateId ELSE NULL END,
			CSTPendedOnYear=CASE WHEN IsCasePended=1 THEN DATEPART(YEAR,@CSTDate) ELSE NULL END,
			CSTPendedOnMonth=CASE WHEN IsCasePended=1 THEN DATEPART(MONTH,@CSTDate) ELSE NULL END,
			CSTPendedOnDay=CASE WHEN IsCasePended=1 THEN DATEPART(DAY,@CSTDate) ELSE NULL END,
			UTCLastUpdatedOn=@UTCDate,
			UTCLastUpdatedOnId=@UTCDateId,
			UTCLastUpdatedOnYear=DATEPART(YEAR,@UTCDate),
			UTCLastUpdatedOnMonth=DATEPART(MONTH,@UTCDate),
			UTCLastUpdatedOnDay=DATEPART(DAY,@UTCDate),
			CSTLastUpdatedOn=@CSTDate,
			CSTLastUpdatedOnId=@CSTDateId,
			CSTLastUpdatedOnYear=DATEPART(YEAR,@CSTDate),
			CSTLastUpdatedOnMonth=DATEPART(YEAR,@CSTDate),
			CSTLastUpdatedOnDay=DATEPART(YEAR,@CSTDate),
			LastUpdatedByRef=@CurrentUserRef 
			WHERE GEN_QueueId=@QId AND [LockedByRef] IS NULL AND [UTCLockedOn] IS NULL
	
			IF(@LockedByRef IS NOT NULL)
			BEGIN
				--- Insert record into manage cases 
				INSERT INTO [dbo].[GEN_ManageCases]
							([GEN_QueueRef],[ActionPerformedLkup],[CurrentUserRef],[CasesComments],[ReAssignUserRef],[IsActive],[UTCCreatedOn],
							 [CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef])
				VALUES(@QId,@ActionPerformedLkup,@CurrentUserRef,@CasesComments,@ReAssignUserRef,1,@UTCDate,@CurrentUserRef,
							 @UTCDate,@CurrentUserRef)
			END

		   SET @Initial = @Initial + 1;
		END;

		COMMIT TRAN
	END TRY
	BEGIN CATCH
		BEGIN TRY ROLLBACK TRAN; END TRY BEGIN CATCH END CATCH
		SET @ErrorMessage= ERROR_MESSAGE();
	END CATCH  
END
GO