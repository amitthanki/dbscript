IF OBJECT_ID ('USP_APP_UPD_UpdateSuspectCase') IS NOT NULL 
BEGIN
	DROP PROC [dbo].[USP_APP_UPD_UpdateSuspectCase]
END
GO
/****** Object:  StoredProcedure [dbo].[USP_APP_UPD_UpdateSuspectCase]    Script Date: 8/10/2017 11:51:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author: Anil
-- Create date:  2/10/2018 
-- Modified By: 
-- Modification Date: 
-- Description:Update Case Information
-- Eg.
-- Declare @ErrorMessage VARCHAR(2000)
-- Set @ErrorMessage=''
-- Exec [USP_APP_UPD_UpdateSuspectCase] @ErrorMessage = @ErrorMessage Output
-- =============================================
CREATE PROCEDURE [dbo].[USP_APP_UPD_UpdateSuspectCase]
(
	 @GEN_QueueId bigint
	,@WorkBasketLkup bigint = NULL
	,@DiscrepancyCategoryLkup bigint = NULL
	,@MemberID varchar(20) = NULL
	,@MemberFirstName varchar(35) = NULL
	,@MemberMiddleName varchar(35) = NULL
	,@MemberLastName varchar(35) = NULL
	,@MemberContractIDLkup bigint = NULL
	,@MemberPBPLkup bigint = NULL
	,@MemberLOBLkup bigint = NULL
	,@MemberVerifiedState varchar(5) = NULL
	,@MemberVerifiedCountyCode varchar(3) = NULL
	,@MemberDOB datetime = NULL
	,@ActionPerformedLkup BIGINT
	,@DiscrepancyReceiptDate datetime = NULL
    ,@RPRCTMMember        BIT=NULL
	,@RPRCTMNumber VARCHAR(20) = NUL
    ,@ComplianceStartDate datetime = NULL
	,@DisenrollmentDate datetime =NULL
	,@Comments   VARCHAR(4000) = NULL
    ,@LoginUserId BIGINT
	,@RoleLkup BIGINT
	,@ErrorMessage VARCHAR(2000) OUT
)
AS
BEGIN  
	BEGIN TRY  
		BEGIN TRAN 

		DECLARE @UTCDate DATETIME
		SET @UTCDate=getutcdate()

		 UPDATE [dbo].[GEN_Queue] SET
			 [MemberID] =@MemberID
			,[MemberFirstName]=@MemberFirstName 
			,[MemberMiddleName]=@MemberMiddleName 
			,[MemberLastName]=@MemberLastName 
			,[MemberContractIDLkup]=@MemberContractIDLkup
			,[MemberPBPLkup]=@MemberPBPLkup 
			,[MemberLOBLkup]=@MemberLOBLkup
			,[MemberVerifiedState]=@MemberVerifiedState
			,[MemberVerifiedCountyCode]=@MemberVerifiedCountyCode
			,[MemberDOB]=@MemberDOB
			,[RPRCTMMember]=@RPRCTMMember
			,[RPRCTMNumber]=@RPRCTMNumber
			,[DisenrollmentDate]=@DisenrollmentDate
			,[ComplianceStartDate]=@ComplianceStartDate
			,[ComplianceStartDateId]=FORMAT(DATEADD(hh, -6, @ComplianceStartDate), 'yyyyMMdd')
			,[DiscrepancyReceiptDate]=@DiscrepancyReceiptDate
			,[DiscrepancyReceiptDateId]=FORMAT(DATEADD(hh, -6, @DiscrepancyReceiptDate), 'yyyyMMdd')
			,[UTCLastUpdatedOn]= @UTCDate
			,[UTCLastUpdatedOnId]= FORMAT(@UTCDate, 'yyyyMMdd')
			,[UTCLastUpdatedOnYear]= FORMAT(@UTCDate, 'yyyy')
			,[UTCLastUpdatedOnMonth]= FORMAT(@UTCDate, 'MM')
			,[UTCLastUpdatedOnDay]= FORMAT(@UTCDate, 'dd')
			,[CSTLastUpdatedOn]= DATEADD(hh, -6, @UTCDate)
			,[CSTLastUpdatedOnId]= FORMAT(DATEADD(hh, -6, @UTCDate), 'yyyyMMdd')
			,[CSTLastUpdatedOnYear]= FORMAT(DATEADD(hh, -6, @UTCDate), 'yyyy')
			,[CSTLastUpdatedOnMonth]= FORMAT(DATEADD(hh, -6, @UTCDate), 'MM')
			,[CSTLastUpdatedOnDay]= FORMAT(DATEADD(hh, -6, @UTCDate), 'dd')
			,[LastUpdatedByRef] =@LoginUserId
			WHERE [GEN_QueueId] = @GEN_QueueId


	   IF(@WorkBasketLkup = 3001) --- 3001 = OST
		BEGIN
			IF EXISTS (SELECT 'x' FROM GEN_OSTActions WHERE GEN_QueueRef = @GEN_QueueId)
			BEGIN
			 UPDATE GEN_OSTActions 
			  SET	GEN_QueueRef=@GEN_QueueId,ActionLkup=@ActionPerformedLkup,LastName=@MemberLastName,DateofBirth=@MemberDOB,
					ContractIDLkup=@MemberContractIDLkup,PBPLkup=@MemberPBPLkup,
					IsActive=1,UTCLastUpdatedOn=@UTCDate,LastUpdatedByRef=@LoginUserId
			 WHERE   GEN_QueueRef = @GEN_QueueId
			END

		END
		IF(@WorkBasketLkup = 3002) --- 3002 = Eligibility
		BEGIN
		    IF EXISTS (SELECT 'x' FROM GEN_OSTActions WHERE GEN_QueueRef = @GEN_QueueId)
			BEGIN
			 UPDATE [dbo].[GEN_EligibilityActions]
				SET GEN_QueueRef=@GEN_QueueId,ActionLkup=@ActionPerformedLkup,LastName=@MemberLastName,DateofBirth=@MemberDOB,
					ContractIDLkup=@MemberContractIDLkup,PBPLkup=@MemberPBPLkup,IsActive=1,UTCLastUpdatedOn=@UTCDate,LastUpdatedByRef=@LoginUserId
			WHERE GEN_QueueRef = @GEN_QueueId
			END
		END

		IF(@WorkBasketLkup = 3003) --- 3003 = RPR
		BEGIN
		    IF EXISTS (SELECT 'x' FROM GEN_OSTActions WHERE GEN_QueueRef = @GEN_QueueId)
			BEGIN
			 UPDATE [dbo].[GEN_RPRActions]
					SET GEN_QueueRef=@GEN_QueueId,ActionLkup=@ActionPerformedLkup,LastName=@MemberLastName,DateofBirth=@MemberDOB,ContractIDLkup=@MemberContractIDLkup,PBPLkup=@MemberPBPLkup
					,IsActive=1,UTCLastUpdatedOn=@UTCDate,LastUpdatedByRef=@LoginUserId
			   WHERE GEN_QueueRef = @GEN_QueueId		
		    END	

		END

		--- Insert record into comments 
		IF(@Comments IS NOT NULL)
		BEGIN
			INSERT INTO [dbo].[GEN_Comments]
						([GEN_QueueRef],[Comments],[ActionLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef])
			VALUES      (@GEN_QueueId,@Comments,@ActionPerformedLkup,1,@UTCDate,@LoginUserId,@UTCDate,@LoginUserId)
		END

		--- Insert record into Manage cases

		INSERT INTO [dbo].[GEN_ManageCases]
					([GEN_QueueRef],[ActionPerformedLkup],[CurrentUserRef],[CasesComments],[ReAssignUserRef],[IsActive],[UTCCreatedOn],
					 [CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef])
		VALUES		(@GEN_QueueId,@ActionPerformedLkup,@LoginUserId,@Comments,@LoginUserId,1,@UTCDate,@LoginUserId,
					@UTCDate,@LoginUserId)


		--- Insert record into Gen_Queue Workflow correlation
		INSERT INTO [dbo].[GEN_QueueWorkFlowCorrelation]
					([GEN_QueueRef],[RoleLkup],[WorkBasketLkup],[DiscrepancyCategoryLkup],[PreviousActionLkup],[PreviousWorkQueuesLkup],
					 [PreviousStatusLkup],[CurrentActionLkup],[CurrentWorkQueuesLkup],[CurrentStatusLkup],[IsActive],[UTCCreatedOn],
					 [CreatedByRef])
	SELECT TOP 1 @GEN_QueueId,[RoleLkup],[WorkBasketLkup],[DiscrepancyCategoryLkup],[PreviousActionLkup],[PreviousWorkQueuesLkup],
			     [PreviousStatusLkup],@ActionPerformedLkup,[CurrentWorkQueuesLkup],[CurrentStatusLkup],[IsActive],@UTCDate,@LoginUserId 
		    FROM [dbo].[GEN_QueueWorkFlowCorrelation]
		   WHERE GEN_QueueRef = @GEN_QueueId	ORDER BY [UTCCreatedOn] DESC

		
		COMMIT TRAN
	END TRY
	BEGIN CATCH
		BEGIN TRY ROLLBACK TRAN; END TRY BEGIN CATCH END CATCH
		SET @ErrorMessage= ERROR_MESSAGE();
	    INSERT INTO [dbo].[CMN_AppErrorLog] (ADM_UserMasterRef,[ErrorLocation],[ErrorSourceLkup],[ErrorMessage],[ErrorDescription],[UTCErrorDateTime],[UTCCreatedOn])
		VALUES(@LoginUserId,'[dbo].[USP_APP_UPD_UpdateSuspectCase]',null,ERROR_NUMBER(),ERROR_MESSAGE(),GETUTCDATE(),GETUTCDATE())
	END CATCH  
END
