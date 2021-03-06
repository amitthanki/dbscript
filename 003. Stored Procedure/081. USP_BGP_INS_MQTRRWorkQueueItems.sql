IF OBJECT_ID ('USP_BGP_INS_MQTRRWorkQueueItems') IS NOT NULL 
DROP PROC [DBO].[USP_BGP_INS_MQTRRWorkQueueItems]
GO

/****** Object:  StoredProcedure [dbo].[USP_BGP_INS_MQTRRWorkQueueItems]    Script Date: 05/07/2017 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: Pradeep Patil
-- Create date: 09/11/2017
-- Modified By: 
-- Modification Date: 
-- Description: Insert MQ message details
-- Eg.
-- Declare @ErrorMessage VARCHAR(2000)
-- Set @ErrorMessage=''
-- Exec [USP_BGP_INS_MQTRRWorkQueueItems] @ErrorMessage = @ErrorMessage Output
-- =============================================
CREATE PROCEDURE [dbo].[USP_BGP_INS_MQTRRWorkQueueItems]
	@WQTrackingNumber varchar(25),
	@MQSourceTypeLkup bigint,
	@MemberId varchar(20) = NULL,
	@IndividualID varchar(15) = NULL,
	@HICN varchar(15) = NULL,
	@HouseholdID varchar(64) = NULL,
	@Contract varchar(10) = NULL,
	@PBP varchar(10) = NULL,
	@FirstName varchar(25) = NULL,
	@MiddleName varchar(25) = NULL,
	@LastName varchar(25) = NULL,
	@DOB datetime = NULL,
	@SourceSystem varchar(50) = 'GPS',
	@SCCCode varchar(50) = NULL,
	@LOB varchar(30) = NULL,
	@DisenrollementPeriod int = 6,
	@TRC varchar(5) = NULL,
	@TRCTypeCode varchar(5) = NULL,
	@TimelineEffectiveDate datetime = NULL,
	@TRRFileReceiptDate datetime = NULL,
	@PlanTerminationDate datetime = NULL,
	@ReasonDescription varchar(50) = NULL,
	@ERSCaseNumber bigint = NULL,
	@TRRRecordID varchar(20) = NULL,
	@GPSProposedEffectiveDate datetime = NULL,
	@GPSPDPAutoEnroleeIndicator bit = 0,
	@GPSApplicationStatus varchar(20) = NULL,
	@GPSCONTRACT varchar(10) = NULL,
	@GPSPBP varchar(5) = NULL,
	@SystemId bigint = 2,
	@CMN_BackgroundProcessMasterRef bigint = NULL,
	@IsRestricted bit = 0,
	@EmployerId varchar(20) = NULL,
	@IsNationalEmployee bit = 0,
	@MQTRRWorkQueueItemId bigint OUTPUT,
	@ErrorMessage as varchar(2000) OUTPUT 
AS
BEGIN
BEGIN TRY
DECLARE @UTCDate DATETIME
SET @UTCDate=getutcdate()
INSERT INTO [dbo].[MQTRRWorkQueueItems]
           ([WQTrackingNumber]
           ,[MQSourceTypeLkup]
		   ,[MemberID]
           ,[IndividualID]
           ,[HICN]
           ,[HouseholdID]
           ,[Contract]
           ,[PBP]
           ,[Firstname]
		   ,[MiddleName]
           ,[Lastname]
		   ,[DOB]
		   ,[SourceSystem]
		   ,[SCCCode]
		   ,[LOB]
		   ,[DisenrollementPeriod]
		   ,[TRC]
		   ,[TRCTypeCode]
		   ,[TimelineEffectiveDate]
		   ,[TRRFileReceiptDate]
		   ,[PlanTerminationDate]
		   ,[ReasonDescription]
		   ,[ERSCaseNumber]
		   ,[TRRRecordID]
		   ,[GPSProposedEffectiveDate]
		   ,[GPSPDPAutoEnroleeIndicator]
		   ,[GPSApplicationStatus]
		   ,[GPSCONTRACT]
		   ,[GPSPBP]
		   ,[IsProcessed]
		   ,[UTCCreatedOn]
		   ,[CreatedByRef]
		   ,[CMN_BackgroundProcessMasterRef]
		   ,[IsRestricted]
		   ,[IsRestrictedProcessed]
		   ,[EmployerId]
		   ,[IsNationalEmployee])
     VALUES
           (	
		   	@WQTrackingNumber
			,@MQSourceTypeLkup
			,@MemberId
			,@IndividualID
			,@HICN
			,@HouseholdID
			,@Contract
			,@PBP
			,@FirstName
			,@MiddleName
			,@LastName
			,@DOB
			,@SourceSystem
			,@SCCCode
			,@LOB
			,@DisenrollementPeriod
			,@TRC
			,@TRCTypeCode
			,@TimelineEffectiveDate
			,@TRRFileReceiptDate
			,@PlanTerminationDate
			,@ReasonDescription
			,@ERSCaseNumber
			,@TRRRecordID
			,@GPSProposedEffectiveDate
			,@GPSPDPAutoEnroleeIndicator
			,@GPSApplicationStatus
			,@GPSCONTRACT
			,@GPSPBP
			,0
			,@UTCDate
			,@SystemId
			,@CMN_BackgroundProcessMasterRef
			,@IsRestricted
			,1
			,@EmployerId
			,@IsNationalEmployee
			)
			SELECT @MQTRRWorkQueueItemId = SCOPE_IDENTITY() FROM [dbo].[MQTRRWorkQueueItems];
END TRY

BEGIN CATCH
	SET @ErrorMessage = Error_Message();
END CATCH

END 


