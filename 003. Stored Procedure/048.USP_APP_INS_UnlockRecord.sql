IF OBJECT_ID ('USP_APP_INS_UnlockRecord') IS NOT NULL 
BEGIN
	DROP PROC [dbo].[USP_APP_INS_UnlockRecord]
END
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
 
 -- =============================================
-- Author: Rakesh Hosagoudar
-- Create date: 01/18/2018
-- Description: to unlock record.
-- Eg.
 --Declare @ErrorMessage VARCHAR(2000)
 --Set @ErrorMessage=''
 --Exec [dbo].[USP_APP_INS_UnlockRecord]
 CREATE PROC [dbo].[USP_APP_INS_UnlockRecord]
 (
	  @GEN_QueueIds VARCHAR(MAX)
	 ,@ActionPerformedLkup BIGINT
	 ,@CurrentUserRef  BIGINT
	 ,@CasesComments VARCHAR(2000)
	 ,@ErrorMessage VARCHAR(2000) OUT
)
AS
BEGIN TRY  
BEGIN TRAN 
	DECLARE @UTCDate DATETIME=NULL
	DECLARE @UTCDateId BIGINT=NULL
	DECLARE @CSTDate DATETIME=NULL
	DECLARE @CSTDateId BIGINT=NULL	

	SET @UTCDate=GETUTCDATE()
	SET @CSTDate=DATEADD(MINUTE,DATEDIFF(MINUTE,@UTCDate,GETDATE()),@UTCDate)
	SET @UTCDateId=CAST(CAST(DATEPART(MONTH,@UTCDate) AS VARCHAR(10))+CAST(DATEPART(DAY,@UTCDate) AS VARCHAR(10))+CAST(DATEPART(YEAR,@UTCDate) AS VARCHAR(10)) AS bigint)
	SET @CSTDateId=CAST(CAST(DATEPART(MONTH,@CSTDate) AS VARCHAR(10))+CAST(DATEPART(DAY,@CSTDate) AS VARCHAR(10))+CAST(DATEPART(YEAR,@CSTDate) AS VARCHAR(10)) AS bigint)

	DECLARE @QueueIds TABLE (ID BIGINT IDENTITY(1,1),QueueID BIGINT)

    INSERT INTO @QueueIds
    SELECT Item AS QueueID FROM SplitString(@GEN_QueueIds,',') WHERE Item <>''

       UPDATE GQ SET GQ.LockedByRef=NULL,GQ.UTCLockedOn=NULL ,GQ.UTCLockedOnId=NULL,GQ.UTCLockedOnYear=NULL,GQ.UTCLockedOnMonth=NULL
					 ,GQ.UTCLockedOnDay=NULL,GQ.CSTLockedOn=NULL,GQ.CSTLockedOnId=NULL,GQ.CSTLockedOnYear=NULL,GQ.CSTLockedOnMonth=NULL
					 ,GQ.CSTLockedOnDay=NULL,GQ.UTCLastUpdatedOn=GETUTCDATE(),GQ.UTCLastUpdatedOnId=@UTCDateId,GQ.UTCLastUpdatedOnYear=DATEPART(YEAR,@UTCDate)
					 ,GQ.UTCLastUpdatedOnMonth=DATEPART(MONTH,@UTCDate),GQ.UTCLastUpdatedOnDay=DATEPART(DAY,@UTCDate)
					 ,GQ.CSTLastUpdatedOn=@CSTDate,GQ.CSTLastUpdatedOnId=@CSTDateId,GQ.CSTLastUpdatedOnYear=DATEPART(YEAR,@CSTDate)
					 ,GQ.CSTLastUpdatedOnMonth=DATEPART(YEAR,@CSTDate),GQ.CSTLastUpdatedOnDay=DATEPART(YEAR,@CSTDate),GQ.LastUpdatedByRef=@CurrentUserRef
			    FROM GEN_Queue GQ
	      INNER JOIN @QueueIds QIDs ON GQ.GEN_QueueId=QIDs.QueueID

	----------------Update Locked Record-------------------------

		UPDATE CRL SET CRL.IsActive=0
				      ,CRL.UTCLastUpdatedOn=@UTCDate
					  ,CRL.LastUpdatedByRef=@CurrentUserRef 
				 FROM CMN_RecordsLocked CRL
		   INNER JOIN @QueueIds QIDs ON CRL.CaseId=QIDs.QueueID AND CRL.IsActive=1
		--------------Insert ino Manage Case---------------  


		INSERT INTO [dbo].[GEN_ManageCases]
					([GEN_QueueRef],[ActionPerformedLkup],[CurrentUserRef],[CasesComments],[ReAssignUserRef],[IsActive],[UTCCreatedOn],
					 [CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef])
		SELECT QueueID,@ActionPerformedLkup,@CurrentUserRef,@CasesComments,null,1,@UTCDate,@CurrentUserRef,@UTCDate,@CurrentUserRef 
		  FROM @QueueIds

COMMIT TRAN
END TRY
BEGIN CATCH
	ROLLBACK TRAN;
	SET @ErrorMessage= ERROR_MESSAGE();
			SET @ErrorMessage= ERROR_MESSAGE();
	INSERT INTO [dbo].[CMN_AppErrorLog] (ADM_UserMasterRef,[ErrorLocation],[ErrorSourceLkup],[ErrorMessage],[ErrorDescription],[UTCErrorDateTime],[UTCCreatedOn])
	VALUES(@CurrentUserRef,'[dbo].[USP_APP_INS_UnlockRecord]',null,ERROR_NUMBER(),ERROR_MESSAGE(),GETUTCDATE(),GETUTCDATE())
END CATCH  
