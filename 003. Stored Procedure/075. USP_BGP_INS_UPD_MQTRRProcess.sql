IF OBJECT_ID ('USP_BGP_INS_UPD_MQTRRProcess') IS NOT NULL 
BEGIN
	DROP PROC [DBO].[USP_BGP_INS_UPD_MQTRRProcess]
END
GO

/****** Object:  StoredProcedure [dbo].[USP_BGP_INS_UPD_MQTRRProcess]    Script Date: 08/21/2017 7:08:26 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: Sourabha Ranjan Barik
-- Create date: 08/21/2017
-- Modified By: 
-- Modification Date: 
-- Description: Update Queue data depends upon TRC Codes
-- Eg.
-- Declare @ErrorMessage VARCHAR(2000)
-- Set @ErrorMessage=''
-- Exec [USP_BGP_INS_UPD_MQTRRProcess] @MQTRRWorkQueueItemsId = 1, @ErrorMessage = @ErrorMessage Output
-- =============================================

CREATE PROC [dbo].[USP_BGP_INS_UPD_MQTRRProcess]
@MQTRRWorkQueueItemsId bigint,
@GEN_QueueId bigint = 0,
@MQSourceTypeLkup bigint,
@CurrentUserId bigint,
@ErrorMessage VARCHAR(2000) OUTPUT
As
BEGIN

BEGIN TRY
BEGIN TRAN

IF(@MQSourceTypeLkup = 54002)
BEGIN
	SET @GEN_QueueId = 0
END

DECLARE @HICN varchar(30) = ''
DECLARE @HouseHoldId varchar(64) = ''
DECLARE @Contract bigint = 0
DECLARE @ContractValue varchar(8) = ''
DECLARE @PBP bigint = 0 
DECLARE @PBPValue varchar(5) = '' 
DECLARE @FirstName varchar(35) = ''
DECLARE @MiddleName varchar(35) = ''
DECLARE @LastName varchar(35) = ''
DECLARE @MemberDOB datetime
DECLARE @SCCCode varchar(50) = ''
DECLARE @LOB bigint = 0
DECLARE @DisEnrollPeriod int = 0
DECLARE @TRCCode varchar(5) = ''
DECLARE @TRCTypeCode varchar(5) = ''
DECLARE @EffectiveDate datetime
DECLARE @FileReceiptDate datetime
DECLARE @PlanTerminationDate datetime
DECLARE @GPSReasonDesc varchar(1000) = ''

DECLARE @GPSProposedEffectiveDate datetime = NULL
DECLARE @GPSPDPAutoEnrolleIndicator bit = 0
DECLARE @GPSApplicationStatus varchar(50) = NULL
DECLARE @GPSContract varchar(8) = NULL
DECLARE @GPSContractValue varchar(8) = NULL
DECLARE @GPSPBP varchar(5) = NULL
DECLARE @GPSPBPValue varchar(5) = NULL

DECLARE @SSLkup bigint = 0
DECLARE @ComplianceStartDateId bigint = 0
DECLARE @MemberDOBId bigint = 0
DECLARE @IsRestricted Bit = 0

DECLARE @CMN_BackgroundProcessMasterRef bigint = 0
DECLARE @IsNationalEmployee Bit = 0
DECLARE @ERSCaseNumber VARCHAR(50) = ''

Select  @HICN = HICN, @HouseHoldId = Cast(HouseholdID as varchar(64)), @Contract = LMContract.CMN_LookupMasterId, @ContractValue = A.[Contract],
		@PBP = LMPBP.CMN_LookupMasterId, @PBPValue = A.PBP, @FirstName = Firstname, @MiddleName = MiddleName, @LastName = Lastname, @MemberDOB = DOB,
		@SCCCode = Cast(SCCCode As varchar(50)), @LOB = LMLOB.CMN_LookupMasterId, @DisEnrollPeriod = DisenrollementPeriod, @TRCCode = TRC, @TRCTypeCode = TRCTypeCode,
		@EffectiveDate = TimelineEffectiveDate, @FileReceiptDate = TRRFileReceiptDate, @PlanTerminationDate = PlanTerminationDate, @GPSReasonDesc = ReasonDescription,
		@GPSProposedEffectiveDate = GPSProposedEffectiveDate, @GPSPDPAutoEnrolleIndicator = GPSPDPAutoEnroleeIndicator, @GPSApplicationStatus = GPSApplicationStatus,
		@GPSContract = LMGPSContract.CMN_LookupMasterId, @GPSContractValue = GPSContract, @GPSPBP = LMGPSPBP.CMN_LookupMasterId ,@GPSPBPValue = GPSPBP,
		@IsRestricted = IsRestricted, @CMN_BackgroundProcessMasterRef = CMN_BackgroundProcessMasterRef, @IsNationalEmployee = IsNationalEmployee,@ERSCaseNumber = ERSCaseNumber
From MQTRRWorkQueueItems A  WITH(NOLOCK)
	Left Join CMN_LookupMaster LMContract WITH(NOLOCK) On LMContract.LookupValue = A.[Contract] And LMContract.CMN_LookupTypeRef = 11
	Left Join CMN_LookupMaster LMPBP WITH(NOLOCK) On LMPBP.LookupValue = A.PBP And LMPBP.CMN_LookupTypeRef = 12
	Left Join CMN_LookupMaster LMLOB WITH(NOLOCK) On LMLOB.LookupValue = A.LOB And LMLOB.CMN_LookupTypeRef = 31
	Left Join CMN_LookupMaster LMGPSContract WITH(NOLOCK) On LMGPSContract.LookupValue = A.[Contract] And LMGPSContract.CMN_LookupTypeRef = 11
	Left Join CMN_LookupMaster LMGPSPBP WITH(NOLOCK) On LMGPSPBP.LookupValue = A.PBP And LMGPSPBP.CMN_LookupTypeRef = 12
Where A.MQTRRWorkQueueItemId = @MQTRRWorkQueueItemsId And (A.IsProcessed Is NULL Or A.IsProcessed = 0)

DECLARE @CurrentDate datetime = GETDATE()
DECLARE @CurrentUTCDate datetime = GETUTCDATE()

--If Contract mismatch found in TRC Record & GPS record, then don't process.
IF(@ContractValue <> @GPSContractValue) 
BEGIN
	Update MQTRRWorkQueueItems Set IsProcessed = 1, UTCProcessedOn = @CurrentUTCDate,ProcessedByRef = @CurrentUserId, UTCLastUpdatedOn = @CurrentUTCDate, UpdatedByRef = @CurrentUserId, ProcessingErrorMessage = 'Discrepancy found in TRC Contract '+@ContractValue+' & GPS Contract '+@GPSContractValue+'' Where MQTRRWorkQueueItemId = @MQTRRWorkQueueItemsId
END

--If PBP mismatch found in TRC Record & GPS record, then don't process.
ELSE IF(@PBPValue <> @GPSPBPValue) 
BEGIN
	Update MQTRRWorkQueueItems Set IsProcessed = 1, UTCProcessedOn = @CurrentUTCDate,ProcessedByRef = @CurrentUserId, UTCLastUpdatedOn = @CurrentUTCDate, UpdatedByRef = @CurrentUserId, ProcessingErrorMessage = 'Discrepancy found in TRC PBP '+@PBPValue+' & GPS PBP '+@GPSPBPValue+'' Where MQTRRWorkQueueItemId = @MQTRRWorkQueueItemsId
END

--If IsNationalEmployee = 1 And TRC in 154,016,155, then don't process.
ELSE IF (@IsNationalEmployee = 1 AND @TRCCode In ('154','016','155'))
BEGIN
	Update MQTRRWorkQueueItems Set IsProcessed = 1, UTCProcessedOn = @CurrentUTCDate,ProcessedByRef = @CurrentUserId, UTCLastUpdatedOn = @CurrentUTCDate, UpdatedByRef = @CurrentUserId, ProcessingErrorMessage = 'Member is a National Employee. No Action performed' Where MQTRRWorkQueueItemId = @MQTRRWorkQueueItemsId
END

--If MQSourceType is Topic and no macthing case in ERS
ELSE IF (@MQSourceTypeLkup = 54003 AND (@ERSCaseNumber IS NULL OR @ERSCaseNumber = '' OR @ERSCaseNumber = 0))
BEGIN
	Update MQTRRWorkQueueItems Set IsProcessed = 1, UTCProcessedOn = @CurrentUTCDate,ProcessedByRef = @CurrentUserId, UTCLastUpdatedOn = @CurrentUTCDate, UpdatedByRef = @CurrentUserId, ProcessingErrorMessage = 'MQ Topic Message received with No Matching ERS Case.' Where MQTRRWorkQueueItemId = @MQTRRWorkQueueItemsId
END

ELSE
BEGIN
	SET @SSLkup = 38001   --GPS
	SET @ComplianceStartDateId = CONVERT(varchar,@FileReceiptDate,112)
	SET @MemberDOBId = CONVERT(varchar,@MemberDOB,112)

	--SELECT DATEADD (dd, -1, DATEADD(mm, DATEDIFF(mm, 0, GETUTCDATE()) + 1, 0))    --Get Month End date
	DECLARE @DisenrollDate datetime = DATEADD (dd, -1, DATEADD(mm, DATEDIFF(mm, 0, DateAdd(MM,Cast(@DisEnrollPeriod as int),Cast(@FileReceiptDate as datetime))) + 1, 0))

	DECLARE @UTCDateId bigint = CONVERT(varchar,@CurrentUTCDate,112)

	DECLARE @AuditDescption varchar(1000) = ''

	DECLARE @DiscpCat Bigint = 0
	DECLARE @DiscpType Bigint = 0
	DECLARE @MostRecentRecStatus bigint = 0

	DECLARE @PreviousActionLkup bigint = 0
	DECLARE @PreviousWQLkup bigint = 0
	DECLARE @PreviousStsLkup bigint = 0

	DECLARE @ClosedQueueIdForReference bigint = 0

	DECLARE @CurrentActionLkup bigint = 0
	DECLARE @CurrentWorkQueuesLkup bigint = 0
	DECLARE @CurrentStatusLkup bigint = 0
	DECLARE @CurrentResolutionLkup bigint = 0
	DECLARE @IsCaseResolved bit = 0
	DECLARE @IsPlanTermed bit = 0
	DECLARE @OOALetterStatusLkup bigint = 0
	DECLARE @CMSTransactionStatusLkup bigint = 0
	DECLARE @LockedByRef bigint = NULL
	Declare @TRCLkup bigint = NULL
	DECLARE @Reason varchar(20) = NULL
	DECLARE @CreatedByRef Bigint = 0
	DECLARE @LastUpdatedByRef bigint = 0

	SELECT @TRCLkup = CMN_LookupMasterId FROM CMN_LookupMaster WHERE CMN_LookupTypeRef=22 AND LookupValue=concat('TRC - ',CAST(@TRCCode as int))

	CREATE TABLE #TempRecordsToProcess (SNO Int Identity(1,1),GEN_QueueId Bigint,DiscpCat Bigint,DiscpType Bigint,PreviousActionLkup Bigint,PreviousWQLkup Bigint,
										PreviousStsLkup Bigint,LockedByRef Bigint,CreatedByRef Bigint,LastUpdatedByRef Bigint)
	DECLARE @TotalRecordsCount int = 0
	DECLARE @IterationCount int = 0
	DECLARE @ProcessedQueueIds varchar(5000) = '' 
	DECLARE @BSRRecords varchar(5000) = ''

	DECLARE @SingleTRRCaseCreate int = 0   --1(True) / 0(False) 
	DECLARE @IsOOACaseFound int = 0
	DECLARE @IsSCCCaseFound int = 0

	IF(@TRCCode = '265')
	BEGIN
	
		--=========================== TRC 265 (Residence Address Change Accepted, New SCC) ===========================--
		-------- BEGIN ----------

		--Match Logic:
		--Existing SCC or OOA Case (Discrepancy Case Category = SCC (6002) or OOA (6001),  
		--Status is other than Resolved-Completed, and 
		--Discrepancy Type is some value other than Incarcerated
		--Where:HICN, Contract # and PBP in discrepancy record is matched with the HICN, Contract# and PBP in the Case. 
		--The system will look for a match using the following order of application fields.· GPS Contract and GPS PBP and Current HICN· MMR Contract and MMR PBP and Current HICN· Other Contract and Other PBP and Current HICNRecord
		--Exclude BSR Records - CAT = SCC And Created Or Last updated By = 12 (SCC Incremental Data Load / SSIS Admin) And Queue = 10032 (SCC Update Sent to CMS)

		--Action: Record status updated to Resolved-Completed and End Queue updated to Completed and Resolution field updated to ‘CMS Accepted’

		IF(@MQSourceTypeLkup = 54002)
		BEGIN
			INSERT INTO #TempRecordsToProcess
			Select  Distinct Q.GEN_QueueId, Q.DiscrepancyCategoryLkup, Q.DiscrepancyTypeLkup, Q.MostRecentActionLkup, Q.MostRecentWorkQueueLkup, Q.MostRecentStatusLkup, Q.LockedByRef,
					Q.CreatedByRef, Q.LastUpdatedByRef
			From GEN_Queue Q
			Where Q.IsActive = 1 And Q.DiscrepancyCategoryLkup In (6001,6002,6003) And Q.MostRecentStatusLkup Not In (20003) And Q.DiscrepancyTypeLkup Not In (7003)
			And (Q.MemberCurrentHICN = @HICN Or Q.MemberMedicareId = @HICN) And Q.MemberContractIDLkup= @Contract And Q.MemberPBPLkup= @PBP
		END
		ELSE
		BEGIN
			INSERT INTO #TempRecordsToProcess
			Select  @GEN_QueueId, Q.DiscrepancyCategoryLkup, Q.DiscrepancyTypeLkup, Q.MostRecentActionLkup, Q.MostRecentWorkQueueLkup, Q.MostRecentStatusLkup, Q.LockedByRef,
					Q.CreatedByRef, Q.LastUpdatedByRef
			From GEN_Queue Q
			Where Q.IsActive = 1 And Q.GEn_QueueId = @GEN_QueueId
		END

		SET @TotalRecordsCount = (Select Count(1) From #TempRecordsToProcess)
		SET @IterationCount = 1

		IF(@TotalRecordsCount = 0)
		BEGIN
			SET @BSRRecords = 'No matching case found in Application. No Action performed.'
		END
		ELSE
		BEGIN
			WHILE(@IterationCount <= @TotalRecordsCount)
			BEGIN	
				SET @ClosedQueueIdForReference = 0
				SET @GEN_QueueId = 0
				SET @DiscpCat = 0
				SET @PreviousActionLkup = 0
				SET @PreviousWQLkup = 0
				SET @PreviousStsLkup = 0
				SET @LockedByRef = 0
				SET @CreatedByRef = 0
				SET @LastUpdatedByRef = 0
		
				Select @GEN_QueueId = GEN_QueueId, @DiscpCat = DiscpCat, @PreviousActionLkup = PreviousActionLkup, @PreviousWQLkup = PreviousWQLkup,
						@PreviousStsLkup = PreviousStsLkup, @LockedByRef = LockedByRef, @CreatedByRef = CreatedByRef, @LastUpdatedByRef = LastUpdatedByRef  
				From #TempRecordsToProcess Where SNO = @IterationCount

				IF ((@CreatedByRef = 12 Or @LastUpdatedByRef = 12) And @PreviousWQLkup = 10032 And @DiscpCat = 6002)
				BEGIN
					SET @IterationCount = @IterationCount+1

					IF(LEN(@BSRRecords) > 0)
					BEGIN
						SET @BSRRecords = @BSRRecords + ','
					END

					SET @BSRRecords = @BSRRecords + Cast(@GEN_QueueId As Varchar)
				END
				ELSE
				BEGIN
					IF(@LockedByRef Is NULL Or @LockedByRef = 0)
					BEGIN
						IF(@GEN_QueueId Is NOT NULL And @GEN_QueueId > 0)
						BEGIN
		
							SET @CurrentActionLkup = 28049			--CMS Accepted
							SET @CurrentStatusLkup = 20003			--Resolve Completed
							SET @CurrentResolutionLkup = 18008		--Resolution - CMS Accepted
							SET @IsCaseResolved = 1

							IF(@DiscpCat = 6001)	--OOA
							BEGIN
								SET @CurrentWorkQueuesLkup = 10002		--OOA - CMS Accepted Queue
							END

							ELSE IF(@DiscpCat = 6002)	--SCC
							BEGIN
								SET @CurrentWorkQueuesLkup = 10017		--SCC - CMS Accepted
							END

							ELSE IF(@DiscpCat = 6003)	--TRR
							BEGIN					
								SET @CurrentWorkQueuesLkup = 10092		--TRR - CMS Accepted
							END
		
							--Update GEN_Queue
							Update GEN_Queue 
							Set MostRecentStatusLkup = @CurrentStatusLkup
								,MostRecentWorkQueueLkup = @CurrentWorkQueuesLkup
								,[UTCLastUpdatedOn]= @CurrentUTCDate
								,[UTCLastUpdatedOnId]= FORMAT(@CurrentUTCDate, 'yyyyMMdd')
								,[UTCLastUpdatedOnYear]= FORMAT(@CurrentUTCDate, 'yyyy')
								,[UTCLastUpdatedOnMonth]= FORMAT(@CurrentUTCDate, 'MM')
								,[UTCLastUpdatedOnDay]= FORMAT(@CurrentUTCDate, 'dd')
								,[CSTLastUpdatedOn]= DATEADD(hh, -6, @CurrentUTCDate)
								,[CSTLastUpdatedOnId]= FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'yyyyMMdd')
								,[CSTLastUpdatedOnYear]= FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'yyyy')
								,[CSTLastUpdatedOnMonth]= FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'MM')
								,[CSTLastUpdatedOnDay]= FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'dd')
								,[LastUpdatedByRef] = @CurrentUserId
								,[MostRecentActionLkup]= @CurrentActionLkup
								,[IsCaseResolved]=@IsCaseResolved
								,[ResolvedByRef]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE @CurrentUserId END
								,[UTCResolvedOn]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE @CurrentUTCDate END
								,[UTCResolvedOnId]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE FORMAT(@CurrentUTCDate, 'yyyyMMdd') END
								,[UTCResolvedOnYear]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE FORMAT(@CurrentUTCDate, 'yyyy') END
								,[UTCResolvedOnMonth]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE FORMAT(@CurrentUTCDate, 'MM') END
								,[UTCResolvedOnDay]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE FORMAT(@CurrentUTCDate, 'dd') END
								,[CSTResolvedOn]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE DATEADD(hh, -6, @CurrentUTCDate) END
								,[CSTResolvedOnId]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'yyyyMMdd') END
								,[CSTResolvedOnYear]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'yyyy') END
								,[CSTResolvedOnMonth]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'MM') END
								,[CSTResolvedOnDay]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'dd') END
								,[TRCLkup]= @TRCLkup
							Where GEN_QueueId = @GEN_QueueId

							--Update GEN_OSTActions
							If EXISTS (Select 1 From GEN_OSTActions Where GEN_QueueRef = @GEN_QueueId)
							BEGIN
								Update GEN_OSTActions Set ActionLkup = @CurrentActionLkup, ResolutionLkup = @CurrentResolutionLkup, UTCLastUpdatedOn = @CurrentUTCDate, LastUpdatedByRef = @CurrentUserId Where GEN_QueueRef = @GEN_QueueId
							END
							ELSE
							BEGIN
								INSERT INTO [dbo].[GEN_OSTActions]
											([GEN_QueueRef],[ActionLkup],[LastName],[DateofBirth],[ContractIDLkup],[PBPLkup],[ApplicationDate],[EffectiveDate],
											[EndDate],[FirstLetterMailDate],[SecondLetterMailDate],[ResidentialDocumentationRequired],[CountyAttestationRequired],
											[PendReasonLkup],[ContainsErrorsLkup],[ResolutionLkup],[Reason],[InitialAddressVerificationDate],
											[MemberResponseVerificationDate],[MemberVerifiedState],[SCCLetterMailDate],[IsActive],[UTCCreatedOn],[CreatedByRef],
											[UTCLastUpdatedOn],[LastUpdatedByRef])
									VALUES  (@GEN_QueueId,@CurrentActionLkup,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,@CurrentResolutionLkup,NULL,NULL,
											NULL,NULL,NULL,1,@CurrentUTCDate,@CurrentUserId,@CurrentUTCDate,@CurrentUserId)
							END

							--Add Comments
							SET @AuditDescption = 'TRC Code – '+cast(@TRCCode as varchar(5))+' is received, Status of the case is changed to Resolved-Completed and Performed By as System: GPS  WQ'

							INSERT INTO [dbo].[GEN_Comments]
										([GEN_QueueRef],[Comments],[ActionLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef],[SourceSystemLkup])
							VALUES      (@GEN_QueueId,@AuditDescption,@CurrentActionLkup,1,@CurrentUTCDate,@CurrentUserId,@CurrentUTCDate,@CurrentUserId,@SSLkup)

							--Add Workflow
							INSERT INTO [dbo].[GEN_QueueWorkFlowCorrelation]
										([GEN_QueueRef],[RoleLkup],[WorkBasketLkup],[DiscrepancyCategoryLkup],[PreviousActionLkup],[PreviousWorkQueuesLkup],
											[PreviousStatusLkup],[CurrentActionLkup],[CurrentWorkQueuesLkup],[CurrentStatusLkup],[IsActive],[UTCCreatedOn],
											[CreatedByRef])
							VALUES		(@GEN_QueueId,2001,3001,@DiscpCat,@PreviousActionLkup,@PreviousWQLkup,@PreviousStsLkup,@CurrentActionLkup,@CurrentWorkQueuesLkup,@CurrentStatusLkup,1,@CurrentUTCDate,@CurrentUserId)

							--Add ManageCases for Action performed
							INSERT INTO [dbo].[GEN_ManageCases]([GEN_QueueRef],[ActionPerformedLkup],[CurrentUserRef],[CasesComments],[ReAssignUserRef],[IsActive],[UTCCreatedOn],
										[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef])
								VALUES  (@GEN_QueueId,@CurrentActionLkup,@CurrentUserId,NULL,NULL,1,@CurrentUTCDate,@CurrentUserId,@CurrentUTCDate,@CurrentUserId)
						END
					END
		
					SET @IterationCount = @IterationCount+1

					IF(LEN(@ProcessedQueueIds) > 0)
					BEGIN
						SET @ProcessedQueueIds = @ProcessedQueueIds + ','
					END

					IF(@ClosedQueueIdForReference > 0)
					BEGIN
						SET @ProcessedQueueIds = @ProcessedQueueIds + Cast(@ClosedQueueIdForReference as Varchar) + ',' +Cast(@GEN_QueueId as Varchar)
					END
					ELSE
					BEGIN
						SET @ProcessedQueueIds = @ProcessedQueueIds + Cast(@GEN_QueueId as Varchar)
					END
				END
			END

			IF(LEN(@BSRRecords) > 0)
			BEGIN
				SET @BSRRecords = 'Matching ERS Case '+@BSRRecords+' found. It will be processed by BSR.'
			END
		END

		--Update MQTRRWorkItem as IsProcessed = 1
		Update MQTRRWorkQueueItems Set ProcessedGENQueueRef = @ProcessedQueueIds, IsProcessed = 1, UTCProcessedOn = @CurrentUTCDate,ProcessedByRef = @CurrentUserId, UTCLastUpdatedOn = @CurrentUTCDate, UpdatedByRef = @CurrentUserId, ProcessingErrorMessage = @BSRRecords Where MQTRRWorkQueueItemId = @MQTRRWorkQueueItemsId

		DROP Table #TempRecordsToProcess

	END
	-------- END ----------


	ELSE IF(@TRCCode = '260' Or @TRCCode = '261' Or @TRCCode = '266' Or @TRCCode = '283')
	BEGIN

		--=========================== TRC 260 / 261 / 266 / 283 ===========================--
		-------- BEGIN ----------

		--260: Rejected; Bad End Date on Residence Address Change
		--261: Rejected; Incomplete Residence Address Information
		--266: Unable to Resolve SSA State County Codes
		--283: Residence Address Delete Rejected


		--Match Logic:
		--Existing SCC or OOA Case (Discrepancy Case Category = SCC or OOA, and 
		--Status is other than Resolved-Completed
		--Where:HICN, Contract # and PBP in discrepancy record is matched with the HICN, Contract# and PBP in the Case. 
		--The system will look for a match using the following order of application fields.· GPS Contract and GPS PBP and Current HICN· MMR Contract and MMR PBP and Current HICN· Other Contract and Other PBP and Current HICNQueue

		IF(@MQSourceTypeLkup = 54002)
		BEGIN 
			INSERT INTO #TempRecordsToProcess
			Select  Distinct Q.GEN_QueueId, Q.DiscrepancyCategoryLkup, Q.DiscrepancyTypeLkup, Q.MostRecentActionLkup, Q.MostRecentWorkQueueLkup, Q.MostRecentStatusLkup, Q.LockedByRef,
					Q.CreatedByRef, Q.LastUpdatedByRef
			From GEN_Queue Q  WITH(NOLOCK)
			Where Q.IsActive = 1 And Q.DiscrepancyCategoryLkup In (6001,6002,6003) And Q.MostRecentStatusLkup Not In (20003)
			And (Q.MemberCurrentHICN = @HICN Or Q.MemberMedicareId = @HICN) And Q.MemberContractIDLkup= @Contract And Q.MemberPBPLkup= @PBP
		END
		ELSE
		BEGIN
			INSERT INTO #TempRecordsToProcess
			Select  @GEN_QueueId, Q.DiscrepancyCategoryLkup, Q.DiscrepancyTypeLkup, Q.MostRecentActionLkup, Q.MostRecentWorkQueueLkup, Q.MostRecentStatusLkup, Q.LockedByRef,
					Q.CreatedByRef, Q.LastUpdatedByRef
			From GEN_Queue Q  WITH(NOLOCK)
			Where Q.IsActive = 1 And Q.GEn_QueueId = @GEN_QueueId
		END

		-- Code to decide Single TRR case creation if OOA & SCC case found
		-------------------------------------------------------------------
		
		Select @IsOOACaseFound = Count(1) From #TempRecordsToProcess Where DiscpCat = 6001

		Select @IsSCCCaseFound = Count(1) From #TempRecordsToProcess Where DiscpCat = 6002

		IF(@IsOOACaseFound > 0 AND @IsSCCCaseFound > 0)
		BEGIN
			SET @SingleTRRCaseCreate = 1
		END

		----------------------------------------------------------------------

		SET @TotalRecordsCount = (Select Count(1) From #TempRecordsToProcess)
		SET @IterationCount = 1

		WHILE(@TotalRecordsCount = 0 Or @IterationCount <= @TotalRecordsCount)
		BEGIN
			SET @ClosedQueueIdForReference = 0
			SET @GEN_QueueId = 0
			SET @DiscpCat = 0
			SET @PreviousActionLkup = 0
			SET @PreviousWQLkup = 0
			SET @PreviousStsLkup = 0
			SET @LockedByRef = 0
			SET @CreatedByRef = 0
			SET @LastUpdatedByRef = 0
		
			Select @GEN_QueueId = GEN_QueueId, @DiscpCat = DiscpCat, @PreviousActionLkup = PreviousActionLkup, @PreviousWQLkup = PreviousWQLkup,
					@PreviousStsLkup = PreviousStsLkup, @LockedByRef = LockedByRef, @CreatedByRef = CreatedByRef, @LastUpdatedByRef = LastUpdatedByRef  
			From #TempRecordsToProcess Where SNO = @IterationCount

			IF ((@CreatedByRef = 12 Or @LastUpdatedByRef = 12) And @PreviousWQLkup = 10032 And @DiscpCat = 6002)
			BEGIN
				SET @IterationCount = @IterationCount+1

				IF(LEN(@BSRRecords) > 0)
				BEGIN
					SET @BSRRecords = @BSRRecords + ','
				END

				SET @BSRRecords = @BSRRecords + Cast(@GEN_QueueId As Varchar)
			END
			ELSE
			BEGIN
				IF(@LockedByRef Is NULL Or @LockedByRef = 0)
				BEGIN
					IF(@GEN_QueueId Is NOT NULL And @GEN_QueueId > 0)
					BEGIN
						IF(@DiscpCat = 6003)    --TRR
						BEGIN
							SET @CurrentActionLkup = 28050			--CMS Rejected
							SET @CurrentStatusLkup = 20002			--INPROGRESS
							SET @Reason = 'CMS Rejected TRC Code '+cast(@TRCCode as varchar(5))

							If(@TRCCode = '283')
								BEGIN
									SET @CurrentWorkQueuesLkup = 10034		--TRR - CMS Rejected - Deletion Code
								END
							ELSE
								BEGIN
									SET @CurrentWorkQueuesLkup = 10033		--TRR - CMS Rejected
								END

							--Update queue with action (Add Comments)
							Update GEN_Queue 
							Set  [MostRecentStatusLkup] = @CurrentStatusLkup
								,MostRecentWorkQueueLkup = @CurrentWorkQueuesLkup
								,[UTCLastUpdatedOn]= @CurrentUTCDate
								,[UTCLastUpdatedOnId]= FORMAT(@CurrentUTCDate, 'yyyyMMdd')
								,[UTCLastUpdatedOnYear]= FORMAT(@CurrentUTCDate, 'yyyy')
								,[UTCLastUpdatedOnMonth]= FORMAT(@CurrentUTCDate, 'MM')
								,[UTCLastUpdatedOnDay]= FORMAT(@CurrentUTCDate, 'dd')
								,[CSTLastUpdatedOn]= DATEADD(hh, -6, @CurrentUTCDate)
								,[CSTLastUpdatedOnId]= FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'yyyyMMdd')
								,[CSTLastUpdatedOnYear]= FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'yyyy')
								,[CSTLastUpdatedOnMonth]= FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'MM')
								,[CSTLastUpdatedOnDay]= FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'dd')
								,[LastUpdatedByRef] = @CurrentUserId
								,[MostRecentActionLkup]= @CurrentActionLkup	
								,[TRCLkup]= @TRCLkup
							Where GEN_QueueId = @GEN_QueueId
				
							If EXISTS (Select 1 From GEN_OSTActions Where GEN_QueueRef = @GEN_QueueId)
							BEGIN
								Update GEN_OSTActions Set ActionLkup = @CurrentActionLkup, UTCLastUpdatedOn = @CurrentUTCDate, LastUpdatedByRef = @CurrentUserId Where GEN_QueueRef = @GEN_QueueId
							END
							ELSE
							BEGIN
								INSERT INTO [dbo].[GEN_OSTActions]
											([GEN_QueueRef],[ActionLkup],[LastName],[DateofBirth],[ContractIDLkup],[PBPLkup],[ApplicationDate],[EffectiveDate],
											[EndDate],[FirstLetterMailDate],[SecondLetterMailDate],[ResidentialDocumentationRequired],[CountyAttestationRequired],
											[PendReasonLkup],[ContainsErrorsLkup],[ResolutionLkup],[Reason],[InitialAddressVerificationDate],
											[MemberResponseVerificationDate],[MemberVerifiedState],[SCCLetterMailDate],[IsActive],[UTCCreatedOn],[CreatedByRef],
											[UTCLastUpdatedOn],[LastUpdatedByRef])
									VALUES  (@GEN_QueueId,@CurrentActionLkup,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,@Reason,NULL,
											NULL,NULL,NULL,1,@CurrentUTCDate,@CurrentUserId,@CurrentUTCDate,@CurrentUserId)
							END

							SET @AuditDescption = 'TRC Code – '+cast(@TRCCode as varchar(5))+' is received'

							--Add Comments
							INSERT INTO [dbo].[GEN_Comments]
										([GEN_QueueRef],[Comments],[ActionLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef],[SourceSystemLkup])
							VALUES      (@GEN_QueueId,@AuditDescption,@CurrentActionLkup,1,@CurrentUTCDate,@CurrentUserId,@CurrentUTCDate,@CurrentUserId,@SSLkup)

							--Add Workflow
							INSERT INTO [dbo].[GEN_QueueWorkFlowCorrelation]
										([GEN_QueueRef],[RoleLkup],[WorkBasketLkup],[DiscrepancyCategoryLkup],[PreviousActionLkup],[PreviousWorkQueuesLkup],
											[PreviousStatusLkup],[CurrentActionLkup],[CurrentWorkQueuesLkup],[CurrentStatusLkup],[IsActive],[UTCCreatedOn],
											[CreatedByRef])
							VALUES		(@GEN_QueueId,2001,3001,@DiscpCat,@PreviousActionLkup,@PreviousWQLkup,@PreviousStsLkup,@CurrentActionLkup,@CurrentWorkQueuesLkup,@CurrentStatusLkup,1,@CurrentUTCDate,@CurrentUserId)

							--Add ManageCases for Action performed
							INSERT INTO [dbo].[GEN_ManageCases]([GEN_QueueRef],[ActionPerformedLkup],[CurrentUserRef],[CasesComments],[ReAssignUserRef],[IsActive],[UTCCreatedOn],
										[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef])
								VALUES  (@GEN_QueueId,@CurrentActionLkup,@CurrentUserId,NULL,NULL,1,@CurrentUTCDate,@CurrentUserId,@CurrentUTCDate,@CurrentUserId)
						END
						ELSE
						BEGIN
							SET @CurrentActionLkup = 28002			--Action - Close Case
							SET @CurrentResolutionLkup = 18006		--Resolution - Close Case

							IF(@DiscpCat = 6001)	--OOA
							BEGIN
								SET @CurrentWorkQueuesLkup = 10004		--OOA Completed
								SET @CurrentStatusLkup = 20003			--Resolve Completed

								SET @AuditDescption = 'TRC Code – '+cast(@TRCCode as varchar(5))+' is received, closing OOA Case'
								SET @IsCaseResolved = 1
							END

							ELSE IF(@DiscpCat = 6002)	--SCC
							BEGIN
								SET @CurrentWorkQueuesLkup = 10019		--SCC Completed
								SET @CurrentStatusLkup = 20003			--Resolve Completed

								SET @AuditDescption = 'TRC Code – '+cast(@TRCCode as varchar(5))+' is received, closing SCC case'
								SET @IsCaseResolved = 1
							END

							Set @ClosedQueueIdForReference = @GEN_QueueId			

							--Update GEN_Queue
							Update GEN_Queue 
							Set MostRecentStatusLkup = @CurrentStatusLkup
								,MostRecentWorkQueueLkup = @CurrentWorkQueuesLkup
								,[UTCLastUpdatedOn]= @CurrentUTCDate
								,[UTCLastUpdatedOnId]= FORMAT(@CurrentUTCDate, 'yyyyMMdd')
								,[UTCLastUpdatedOnYear]= FORMAT(@CurrentUTCDate, 'yyyy')
								,[UTCLastUpdatedOnMonth]= FORMAT(@CurrentUTCDate, 'MM')
								,[UTCLastUpdatedOnDay]= FORMAT(@CurrentUTCDate, 'dd')
								,[CSTLastUpdatedOn]= DATEADD(hh, -6, @CurrentUTCDate)
								,[CSTLastUpdatedOnId]= FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'yyyyMMdd')
								,[CSTLastUpdatedOnYear]= FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'yyyy')
								,[CSTLastUpdatedOnMonth]= FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'MM')
								,[CSTLastUpdatedOnDay]= FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'dd')
								,[LastUpdatedByRef] = @CurrentUserId
								,[MostRecentActionLkup]= @CurrentActionLkup
								,[IsCaseResolved]=@IsCaseResolved
								,[ResolvedByRef]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE @CurrentUserId END
								,[UTCResolvedOn]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE @CurrentUTCDate END
								,[UTCResolvedOnId]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE FORMAT(@CurrentUTCDate, 'yyyyMMdd') END
								,[UTCResolvedOnYear]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE FORMAT(@CurrentUTCDate, 'yyyy') END
								,[UTCResolvedOnMonth]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE FORMAT(@CurrentUTCDate, 'MM') END
								,[UTCResolvedOnDay]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE FORMAT(@CurrentUTCDate, 'dd') END
								,[CSTResolvedOn]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE DATEADD(hh, -6, @CurrentUTCDate) END
								,[CSTResolvedOnId]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'yyyyMMdd') END
								,[CSTResolvedOnYear]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'yyyy') END
								,[CSTResolvedOnMonth]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'MM') END
								,[CSTResolvedOnDay]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'dd') END
								,[TRCLkup]= @TRCLkup
							Where GEN_QueueId = @GEN_QueueId

							--Update GEN_OSTActions
							If EXISTS (Select 1 From GEN_OSTActions Where GEN_QueueRef = @GEN_QueueId)
							BEGIN
								Update GEN_OSTActions Set ActionLkup = @CurrentActionLkup, ResolutionLkup = @CurrentResolutionLkup, UTCLastUpdatedOn = @CurrentUTCDate, LastUpdatedByRef = @CurrentUserId Where GEN_QueueRef = @GEN_QueueId
							END
							ELSE
							BEGIN
								INSERT INTO [dbo].[GEN_OSTActions]
											([GEN_QueueRef],[ActionLkup],[LastName],[DateofBirth],[ContractIDLkup],[PBPLkup],[ApplicationDate],[EffectiveDate],
											[EndDate],[FirstLetterMailDate],[SecondLetterMailDate],[ResidentialDocumentationRequired],[CountyAttestationRequired],
											[PendReasonLkup],[ContainsErrorsLkup],[ResolutionLkup],[Reason],[InitialAddressVerificationDate],
											[MemberResponseVerificationDate],[MemberVerifiedState],[SCCLetterMailDate],[IsActive],[UTCCreatedOn],[CreatedByRef],
											[UTCLastUpdatedOn],[LastUpdatedByRef])
									VALUES  (@GEN_QueueId,@CurrentActionLkup,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,@CurrentResolutionLkup,NULL,NULL,
											NULL,NULL,NULL,1,@CurrentUTCDate,@CurrentUserId,@CurrentUTCDate,@CurrentUserId)
							END

							--Add Comments
							INSERT INTO [dbo].[GEN_Comments]
										([GEN_QueueRef],[Comments],[ActionLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef],[SourceSystemLkup])
							VALUES      (@GEN_QueueId,@AuditDescption,@CurrentActionLkup,1,@CurrentUTCDate,@CurrentUserId,@CurrentUTCDate,@CurrentUserId,@SSLkup)

							--Add Workflow
							INSERT INTO [dbo].[GEN_QueueWorkFlowCorrelation]
										([GEN_QueueRef],[RoleLkup],[WorkBasketLkup],[DiscrepancyCategoryLkup],[PreviousActionLkup],[PreviousWorkQueuesLkup],
											[PreviousStatusLkup],[CurrentActionLkup],[CurrentWorkQueuesLkup],[CurrentStatusLkup],[IsActive],[UTCCreatedOn],
											[CreatedByRef])
							VALUES		(@GEN_QueueId,2001,3001,@DiscpCat,@PreviousActionLkup,@PreviousWQLkup,@PreviousStsLkup,@CurrentActionLkup,@CurrentWorkQueuesLkup,@CurrentStatusLkup,1,@CurrentUTCDate,@CurrentUserId)

							--Add ManageCases for Action performed
							INSERT INTO [dbo].[GEN_ManageCases]([GEN_QueueRef],[ActionPerformedLkup],[CurrentUserRef],[CasesComments],[ReAssignUserRef],[IsActive],[UTCCreatedOn],
											[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef])
									VALUES  (@GEN_QueueId,@CurrentActionLkup,@CurrentUserId,NULL,NULL,1,@CurrentUTCDate,@CurrentUserId,@CurrentUTCDate,@CurrentUserId)
		
							IF(@ClosedQueueIdForReference > 0)
							BEGIN
								Set @GEN_QueueId = 0
								
								IF(@SingleTRRCaseCreate = 1 AND @DiscpCat = 6002) --6002 - SCC
								BEGIN
									SET @SingleTRRCaseCreate = 1  --Just to avoid creating a TRR for SCC case
								END
								ELSE
								BEGIN
									SET @CurrentActionLkup = 28050			--CMS Rejected
									SET @CurrentWorkQueuesLkup = 10033		--TRR - CMS Rejected
									SET @CurrentStatusLkup = 20001			--NEW

									If(@TRCCode = '283')
									BEGIN
										SET @CurrentWorkQueuesLkup = 10034		--TRR - CMS Rejected - Deletion Code
									END

									SET @AuditDescption = 'TRC Code – '+cast(@TRCCode as varchar(5))+' is received, queue of the case is changed to Open-CMS Rejected and Performed By as System: GPS  WQ'

									EXEC [USP_APP_INS_CreateSuspectCase] @BusinessSegmentLkup = 1001, @WorkBasketLkup = 3001, @DiscrepancyCategoryLkup = 6003, @DiscrepancyTypeLkup = 7001,
									@MostRecentActionLkup = @CurrentActionLkup,@MostRecentWorkQueueLkup = @CurrentWorkQueuesLkup, @MostRecentStatusLkup = @CurrentStatusLkup, @SourceSystemLkup = @SSLkup, @DiscrepancySourceLkup = 13001, 
									@DiscrepancyReceiptDate = @CurrentUTCDate, @DiscrepancyReceiptDateId = @UTCDateId, @ComplianceStartDate = @FileReceiptDate,@ComplianceStartDateId = @ComplianceStartDateId,
									@DisenrollmentDate = @DisenrollDate, @MemberSCCCode = @SCCCode, @MemberCurrentHICN = @HICN, @GPSHouseholdID = @HouseHoldId,
									@MemberFirstName = @FirstName,@MemberLastName = @LastName, @MemberContractIDLkup = @Contract,@MemberPBPLkup = @PBP,@MemberLOBLkup = @LOB,
									@MemberDOB = @MemberDOB,@MemberDOBId = @MemberDOBId,@EligOOAFlagLkup = 0,@RPRCTMMember = 0,@RPREGHPMember = 0,@IsParentCase = 0,
									@IsChildCase = 1,@ParentQueueRef = @ClosedQueueIdForReference,@Comments = @AuditDescption,@RoleLkup = 2001,
									@CurrentActionLkup = @CurrentActionLkup,@CurrentWorkQueuesLkup = @CurrentWorkQueuesLkup,@CurrentStatusLkup = @CurrentStatusLkup,@LoginUserId = @CurrentUserId,
									@TRCLkup=@TRCLkup,@IsRestricted = @IsRestricted,@ErrorMessage = @ErrorMessage OUTPUT,@CommentsSourceSystemLkup = @SSLkup,@GEN_QueueId = @GEN_QueueId OUTPUT
								END
							END
						END
					END
					ELSE
					BEGIN
						If (@PlanTerminationDate Is Not NULL And Convert(date,@PlanTerminationDate,101) <= Convert(date,GetUTCDate(),101))  --(Plan Termed)
						BEGIN
							SET @IsPlanTermed = 1
						END

						Set @GEN_QueueId = 0

						SET @CurrentActionLkup = 28050			--CMS Rejected
						SET @CurrentWorkQueuesLkup = 10033		--TRR - CMS Rejected
						SET @CurrentStatusLkup = 20001			--NEW

						If(@TRCCode = '283')
						BEGIN
							SET @CurrentWorkQueuesLkup = 10034		--TRR - CMS Rejected - Deletion Code
						END

						SET @AuditDescption = 'TRC Code – '+cast(@TRCCode as varchar(5))+' is received, queue of the case is changed to Open-CMS Rejected and Performed By as System: GPS  WQ'

						EXEC [USP_APP_INS_CreateSuspectCase] @BusinessSegmentLkup = 1001, @WorkBasketLkup = 3001, @DiscrepancyCategoryLkup = 6003, @DiscrepancyTypeLkup = 7001,
						@MostRecentActionLkup = @CurrentActionLkup,@MostRecentWorkQueueLkup = @CurrentWorkQueuesLkup, @MostRecentStatusLkup = @CurrentStatusLkup, @SourceSystemLkup = @SSLkup, @DiscrepancySourceLkup = 13001, 
						@DiscrepancyReceiptDate = @CurrentUTCDate, @DiscrepancyReceiptDateId = @UTCDateId, @ComplianceStartDate = @FileReceiptDate,@ComplianceStartDateId = @ComplianceStartDateId,
						@DisenrollmentDate = @DisenrollDate, @MemberSCCCode = @SCCCode, @MemberCurrentHICN = @HICN, @GPSHouseholdID = @HouseHoldId,
						@MemberFirstName = @FirstName,@MemberLastName = @LastName, @MemberContractIDLkup = @Contract,@MemberPBPLkup = @PBP,@MemberLOBLkup = @LOB,
						@MemberDOB = @MemberDOB,@MemberDOBId = @MemberDOBId,@EligOOAFlagLkup = 0,@RPRCTMMember = 0,@RPREGHPMember = 0,@IsParentCase = 0,
						@IsChildCase = 0,@Comments = @AuditDescption,@RoleLkup = 2001,@CurrentActionLkup = @CurrentActionLkup,
						@CurrentWorkQueuesLkup = @CurrentWorkQueuesLkup,@CurrentStatusLkup = @CurrentStatusLkup,@LoginUserId = @CurrentUserId,
						@TRCLkup=@TRCLkup,@IsRestricted = @IsRestricted,@ErrorMessage = @ErrorMessage OUTPUT,@CommentsSourceSystemLkup = @SSLkup,@GEN_QueueId = @GEN_QueueId OUTPUT

						IF(@IsPlanTermed = 1)
						BEGIN
							Select @PreviousActionLkup= Q.MostRecentActionLkup, @PreviousWQLkup = Q.MostRecentWorkQueueLkup, @PreviousStsLkup = Q.MostRecentStatusLkup
							From GEN_Queue Q
							Where Q.IsActive = 1 And Q.LockedByRef Is NULL And GEN_QueueId = @GEN_QueueId

							IF EXISTS(Select 1 
										From MQTRRWorkQueueItems 
										Where (IsProcessed = 0 And CMN_BackgroundProcessMasterRef = @CMN_BackgroundProcessMasterRef And TRC In ('285', '018', '015', '014', '013') And TimelineEffectiveDate = @EffectiveDate  
											And [Contract] = @ContractValue And PBP = @PBPValue 
											AND CONVERT(varchar,UTCCreatedOn,101) >= Convert(varchar,GETUTcDate(),101) 
											And CONVERT(varchar,UTCCreatedOn,101) < Convert(varchar,DateAdd(dd,1,GETUTcDate()),101)) OR
											(IsProcessed = 0 And CMN_BackgroundProcessMasterRef = @CMN_BackgroundProcessMasterRef And TRC In ('100') And TRCTypeCode = '61' And TimelineEffectiveDate = @EffectiveDate 
											And ([Contract] <> @ContractValue Or PBP <> @PBPValue) 
											AND CONVERT(varchar,UTCCreatedOn,101) >= Convert(varchar,GETUTcDate(),101) 
											And CONVERT(varchar,UTCCreatedOn,101) < Convert(varchar,DateAdd(dd,1,GETUTcDate()),101)))
							BEGIN
								SET @CurrentActionLkup = 28002			--Close Case
								SET @CurrentWorkQueuesLkup = 10036		--TRR - Completed
								SET @CurrentStatusLkup = 20003			--RESOLVE COMPLETED
								SET @CurrentResolutionLkup = 18006		--Resolution - Close Case
								SET @IsCaseResolved = 1

								--Update Queue
								Update GEN_Queue 
								Set MostRecentStatusLkup = @CurrentStatusLkup
									,MostRecentWorkQueueLkup = @CurrentWorkQueuesLkup
									,[UTCLastUpdatedOn]= @CurrentUTCDate
									,[UTCLastUpdatedOnId]= FORMAT(@CurrentUTCDate, 'yyyyMMdd')
									,[UTCLastUpdatedOnYear]= FORMAT(@CurrentUTCDate, 'yyyy')
									,[UTCLastUpdatedOnMonth]= FORMAT(@CurrentUTCDate, 'MM')
									,[UTCLastUpdatedOnDay]= FORMAT(@CurrentUTCDate, 'dd')
									,[CSTLastUpdatedOn]= DATEADD(hh, -6, @CurrentUTCDate)
									,[CSTLastUpdatedOnId]= FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'yyyyMMdd')
									,[CSTLastUpdatedOnYear]= FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'yyyy')
									,[CSTLastUpdatedOnMonth]= FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'MM')
									,[CSTLastUpdatedOnDay]= FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'dd')
									,[LastUpdatedByRef] = @CurrentUserId
									,[MostRecentActionLkup]= @CurrentActionLkup
									,[IsCaseResolved]=@IsCaseResolved
									,[ResolvedByRef]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE @CurrentUserId END
									,[UTCResolvedOn]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE @CurrentUTCDate END
									,[UTCResolvedOnId]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE FORMAT(@CurrentUTCDate, 'yyyyMMdd') END
									,[UTCResolvedOnYear]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE FORMAT(@CurrentUTCDate, 'yyyy') END
									,[UTCResolvedOnMonth]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE FORMAT(@CurrentUTCDate, 'MM') END
									,[UTCResolvedOnDay]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE FORMAT(@CurrentUTCDate, 'dd') END
									,[CSTResolvedOn]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE DATEADD(hh, -6, @CurrentUTCDate) END
									,[CSTResolvedOnId]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'yyyyMMdd') END
									,[CSTResolvedOnYear]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'yyyy') END
									,[CSTResolvedOnMonth]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'MM') END
									,[CSTResolvedOnDay]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'dd') END
									,[TRCLkup]= @TRCLkup
								Where GEN_QueueId = @GEN_QueueId

								--Update GEN_OSTActions
								If EXISTS (Select 1 From GEN_OSTActions Where GEN_QueueRef = @GEN_QueueId)
								BEGIN
									Update GEN_OSTActions Set ActionLkup = @CurrentActionLkup, ResolutionLkup = @CurrentResolutionLkup, UTCLastUpdatedOn = @CurrentUTCDate, LastUpdatedByRef = @CurrentUserId Where GEN_QueueRef = @GEN_QueueId
								END
								ELSE
								BEGIN
									INSERT INTO [dbo].[GEN_OSTActions]
												([GEN_QueueRef],[ActionLkup],[LastName],[DateofBirth],[ContractIDLkup],[PBPLkup],[ApplicationDate],[EffectiveDate],
												[EndDate],[FirstLetterMailDate],[SecondLetterMailDate],[ResidentialDocumentationRequired],[CountyAttestationRequired],
												[PendReasonLkup],[ContainsErrorsLkup],[ResolutionLkup],[Reason],[InitialAddressVerificationDate],
												[MemberResponseVerificationDate],[MemberVerifiedState],[SCCLetterMailDate],[IsActive],[UTCCreatedOn],[CreatedByRef],
												[UTCLastUpdatedOn],[LastUpdatedByRef])
										VALUES  (@GEN_QueueId,@CurrentActionLkup,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,@CurrentResolutionLkup,NULL,NULL,
												NULL,NULL,NULL,1,@CurrentUTCDate,@CurrentUserId,@CurrentUTCDate,@CurrentUserId)
								END

								--Set Comments
								SET @AuditDescption = 'TRC Code – '+cast(@TRCCode as varchar(5))+' is received. status of the case is changed to Resolved-Completed and a GPS note was added and Performed By as System: GPS  WQ'

								INSERT INTO [dbo].[GEN_Comments]
											([GEN_QueueRef],[Comments],[ActionLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef],[SourceSystemLkup])
								VALUES      (@GEN_QueueId,@AuditDescption,@CurrentActionLkup,1,@CurrentUTCDate,@CurrentUserId,@CurrentUTCDate,@CurrentUserId,@SSLkup)

								--Add Workflow
								INSERT INTO [dbo].[GEN_QueueWorkFlowCorrelation]
											([GEN_QueueRef],[RoleLkup],[WorkBasketLkup],[DiscrepancyCategoryLkup],[PreviousActionLkup],[PreviousWorkQueuesLkup],
												[PreviousStatusLkup],[CurrentActionLkup],[CurrentWorkQueuesLkup],[CurrentStatusLkup],[IsActive],[UTCCreatedOn],
												[CreatedByRef])
								VALUES		(@GEN_QueueId,2001,3001,@DiscpCat,@PreviousActionLkup,@PreviousWQLkup,@PreviousStsLkup,@CurrentActionLkup,@CurrentWorkQueuesLkup,@CurrentStatusLkup,1,@CurrentUTCDate,@CurrentUserId)

								--Add ManageCases for Action performed
								INSERT INTO [dbo].[GEN_ManageCases]([GEN_QueueRef],[ActionPerformedLkup],[CurrentUserRef],[CasesComments],[ReAssignUserRef],[IsActive],[UTCCreatedOn],
											[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef])
									VALUES  (@GEN_QueueId,@CurrentActionLkup,@CurrentUserId,NULL,NULL,1,@CurrentUTCDate,@CurrentUserId,@CurrentUTCDate,@CurrentUserId)
				
								--Need to enable this, because once a matching record processed, need to mark the filtered record also processed
								Update M 
								Set M.ProcessedGENQueueRef = @GEN_QueueId, M.IsProcessed = 1, M.UTCProcessedOn = @CurrentUTCDate, M.ProcessedByRef = @CurrentUserId, 
									M.UTCLastUpdatedOn = @CurrentUTCDate, M.UpdatedByRef = @CurrentUserId
								From MQTRRWorkQueueItems M 
								Where (IsProcessed = 0 And CMN_BackgroundProcessMasterRef = @CMN_BackgroundProcessMasterRef And TRC In ('285', '018', '015', '014', '013') And TimelineEffectiveDate = @EffectiveDate  
									And [Contract] = @ContractValue And PBP = @PBPValue 
									AND CONVERT(varchar,UTCCreatedOn,101) >= Convert(varchar,GETUTcDate(),101) 
									And CONVERT(varchar,UTCCreatedOn,101) < Convert(varchar,DateAdd(dd,1,GETUTcDate()),101)) OR
									(IsProcessed = 0 And CMN_BackgroundProcessMasterRef = @CMN_BackgroundProcessMasterRef And TRC In ('100') And TRCTypeCode = '61' And TimelineEffectiveDate = @EffectiveDate 
									And ([Contract] <> @ContractValue Or PBP <> @PBPValue) 
									AND CONVERT(varchar,UTCCreatedOn,101) >= Convert(varchar,GETUTcDate(),101) 
									And CONVERT(varchar,UTCCreatedOn,101) < Convert(varchar,DateAdd(dd,1,GETUTcDate()),101))
							END
							ELSE
							BEGIN
								SET @CurrentActionLkup = 28062			--Escalated Action
								SET @CurrentWorkQueuesLkup = 10037		--TRR - Escalated
								SET @CurrentStatusLkup = 20002			--INPROGRESS

								--Update Queue
								Update GEN_Queue 
								Set MostRecentStatusLkup = @CurrentStatusLkup
									,MostRecentWorkQueueLkup = @CurrentWorkQueuesLkup
									,[UTCLastUpdatedOn]= @CurrentUTCDate
									,[UTCLastUpdatedOnId]= FORMAT(@CurrentUTCDate, 'yyyyMMdd')
									,[UTCLastUpdatedOnYear]= FORMAT(@CurrentUTCDate, 'yyyy')
									,[UTCLastUpdatedOnMonth]= FORMAT(@CurrentUTCDate, 'MM')
									,[UTCLastUpdatedOnDay]= FORMAT(@CurrentUTCDate, 'dd')
									,[CSTLastUpdatedOn]= DATEADD(hh, -6, @CurrentUTCDate)
									,[CSTLastUpdatedOnId]= FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'yyyyMMdd')
									,[CSTLastUpdatedOnYear]= FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'yyyy')
									,[CSTLastUpdatedOnMonth]= FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'MM')
									,[CSTLastUpdatedOnDay]= FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'dd')
									,[LastUpdatedByRef] = @CurrentUserId
									,[MostRecentActionLkup]= @CurrentActionLkup
									,[TRCLkup]= @TRCLkup
								Where GEN_QueueId = @GEN_QueueId

								--Update GEN_OSTActions
								If EXISTS (Select 1 From GEN_OSTActions Where GEN_QueueRef = @GEN_QueueId)
								BEGIN
									Update GEN_OSTActions Set ActionLkup = @CurrentActionLkup, UTCLastUpdatedOn = @CurrentUTCDate, LastUpdatedByRef = @CurrentUserId Where GEN_QueueRef = @GEN_QueueId
								END
								ELSE
								BEGIN
									INSERT INTO [dbo].[GEN_OSTActions]
												([GEN_QueueRef],[ActionLkup],[LastName],[DateofBirth],[ContractIDLkup],[PBPLkup],[ApplicationDate],[EffectiveDate],
												[EndDate],[FirstLetterMailDate],[SecondLetterMailDate],[ResidentialDocumentationRequired],[CountyAttestationRequired],
												[PendReasonLkup],[ContainsErrorsLkup],[ResolutionLkup],[Reason],[InitialAddressVerificationDate],
												[MemberResponseVerificationDate],[MemberVerifiedState],[SCCLetterMailDate],[IsActive],[UTCCreatedOn],[CreatedByRef],
												[UTCLastUpdatedOn],[LastUpdatedByRef])
										VALUES  (@GEN_QueueId,@CurrentActionLkup,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,
												NULL,NULL,NULL,1,@CurrentUTCDate,@CurrentUserId,@CurrentUTCDate,@CurrentUserId)
								END

								--Set Comments 
								SET @AuditDescption = 'TRC Code – '+cast(@TRCCode as varchar(5))+' is received, Escalating case because no active timeline exists in GPS'

								INSERT INTO [dbo].[GEN_Comments]
											([GEN_QueueRef],[Comments],[ActionLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef],[SourceSystemLkup])
								VALUES      (@GEN_QueueId,@AuditDescption,@CurrentActionLkup,1,@CurrentUTCDate,@CurrentUserId,@CurrentUTCDate,@CurrentUserId,@SSLkup)

								--Add Workflow
								INSERT INTO [dbo].[GEN_QueueWorkFlowCorrelation]
											([GEN_QueueRef],[RoleLkup],[WorkBasketLkup],[DiscrepancyCategoryLkup],[PreviousActionLkup],[PreviousWorkQueuesLkup],
												[PreviousStatusLkup],[CurrentActionLkup],[CurrentWorkQueuesLkup],[CurrentStatusLkup],[IsActive],[UTCCreatedOn],
												[CreatedByRef])
								VALUES		(@GEN_QueueId,2001,3001,@DiscpCat,@PreviousActionLkup,@PreviousWQLkup,@PreviousStsLkup,@CurrentActionLkup,@CurrentWorkQueuesLkup,@CurrentStatusLkup,1,@CurrentUTCDate,@CurrentUserId)

								--Add ManageCases for Action performed
								INSERT INTO [dbo].[GEN_ManageCases]([GEN_QueueRef],[ActionPerformedLkup],[CurrentUserRef],[CasesComments],[ReAssignUserRef],[IsActive],[UTCCreatedOn],
											[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef])
									VALUES  (@GEN_QueueId,@CurrentActionLkup,@CurrentUserId,NULL,NULL,1,@CurrentUTCDate,@CurrentUserId,@CurrentUTCDate,@CurrentUserId)
							END
						END
					END
				END

				SET @IterationCount = @IterationCount+1

				IF(LEN(@ProcessedQueueIds) > 0)
				BEGIN
					SET @ProcessedQueueIds = @ProcessedQueueIds + ','
				END

				IF(@ClosedQueueIdForReference > 0)
				BEGIN
					IF(@SingleTRRCaseCreate = 1 AND @DiscpCat = 6002)
					BEGIN
						SET @ProcessedQueueIds = @ProcessedQueueIds + Cast(@ClosedQueueIdForReference as Varchar)
					END
					ELSE
					BEGIN
						SET @ProcessedQueueIds = @ProcessedQueueIds + Cast(@ClosedQueueIdForReference as Varchar) + ',' +Cast(@GEN_QueueId as Varchar)
					END
				END
				ELSE
				BEGIN
					SET @ProcessedQueueIds = @ProcessedQueueIds + Cast(@GEN_QueueId as Varchar)
				END

				IF(@TotalRecordsCount = 0)
				BEGIN
					BREAK;
				END
			END
		END

		IF(LEN(@BSRRecords) > 0)
		BEGIN
			SET @BSRRecords = 'Matching ERS Case '+@BSRRecords+' found. It will be processed by BSR.'
		END

		--Update MQTRRWorkItem as IsProcessed = 1
		Update MQTRRWorkQueueItems Set ProcessedGENQueueRef = @ProcessedQueueIds, IsProcessed = 1, UTCProcessedOn = @CurrentUTCDate,ProcessedByRef = @CurrentUserId, UTCLastUpdatedOn = @CurrentUTCDate, UpdatedByRef = @CurrentUserId, ProcessingErrorMessage = @BSRRecords Where MQTRRWorkQueueItemId = @MQTRRWorkQueueItemsId

		DROP Table #TempRecordsToProcess
	
	END
	-------- END ----------


	ELSE IF(@TRCCode = '282')
	BEGIN

		--=========================== TRC 282 (Residence Address Deleted) ===========================--
		-------- BEGIN ----------

		--Match Logic:
		--Existing Resolved SCC OR OOA Case (Discrepancy Case Category = SCC or OOA, and 
		--Status = Resolved-Completed (no other case is open/in progress), and 
		--Resolution = CMS Accepted
		--Where:HICN, Contract # and PBP in discrepancy record is matched with the HICN, Contract# and PBP in the Case. 
		--The system will look for a match using the following order of application fields.· GPS Contract and GPS PBP and Current HICN· MMR Contract and MMR PBP and Current HICN· Other Contract and Other PBP and Current HICN

		IF(@MQSourceTypeLkup = 54002)
		BEGIN 
			INSERT INTO #TempRecordsToProcess
			Select  Distinct Q.GEN_QueueId, Q.DiscrepancyCategoryLkup, Q.DiscrepancyTypeLkup, Q.MostRecentActionLkup, Q.MostRecentWorkQueueLkup, Q.MostRecentStatusLkup, Q.LockedByRef,
					Q.CreatedByRef, Q.LastUpdatedByRef
			From GEN_Queue Q
			Where Q.IsActive = 1 And Q.DiscrepancyCategoryLkup In (6001,6002,6003)
					And (Q.MemberCurrentHICN = @HICN Or Q.MemberMedicareId = @HICN) And Q.MemberContractIDLkup= @Contract And Q.MemberPBPLkup= @PBP
		END
		ELSE
		BEGIN
			INSERT INTO #TempRecordsToProcess
			Select  @GEN_QueueId, Q.DiscrepancyCategoryLkup, Q.DiscrepancyTypeLkup, Q.MostRecentActionLkup, Q.MostRecentWorkQueueLkup, Q.MostRecentStatusLkup, Q.LockedByRef,
					Q.CreatedByRef, Q.LastUpdatedByRef
			From GEN_Queue Q
			Where Q.IsActive = 1 And Q.GEn_QueueId = @GEN_QueueId
		END

		SET @TotalRecordsCount = (Select Count(1) From #TempRecordsToProcess)
		SET @IterationCount = 1

		WHILE(@TotalRecordsCount = 0 Or @IterationCount <= @TotalRecordsCount)
		BEGIN
			SET @ClosedQueueIdForReference = 0
			SET @GEN_QueueId = 0
			SET @DiscpCat = 0
			SET @PreviousActionLkup = 0
			SET @PreviousWQLkup = 0
			SET @PreviousStsLkup = 0
			SET @LockedByRef = 0
			SET @CreatedByRef = 0
			SET @LastUpdatedByRef = 0
			SET @MostRecentRecStatus = 0
		
			Select @GEN_QueueId = GEN_QueueId, @DiscpCat = DiscpCat, @PreviousActionLkup = PreviousActionLkup, @PreviousWQLkup = PreviousWQLkup,
					@PreviousStsLkup = PreviousStsLkup, @LockedByRef = LockedByRef, @CreatedByRef = CreatedByRef, @LastUpdatedByRef = LastUpdatedByRef,
					@MostRecentRecStatus = PreviousStsLkup
			From #TempRecordsToProcess Where SNO = @IterationCount

			IF ((@CreatedByRef = 12 Or @LastUpdatedByRef = 12) And @PreviousWQLkup = 10032 And @DiscpCat = 6002)
			BEGIN
				SET @IterationCount = @IterationCount+1

				IF(LEN(@BSRRecords) > 0)
				BEGIN
					SET @BSRRecords = @BSRRecords + ','
				END

				SET @BSRRecords = @BSRRecords + Cast(@GEN_QueueId As Varchar)
			END
			ELSE
			BEGIN
				IF(@LockedByRef Is NULL Or @LockedByRef = 0)
				BEGIN
					IF(@GEN_QueueId Is NOT NULL And @GEN_QueueId > 0)
					BEGIN
		
						If (@MostRecentRecStatus = 20003)  --Resolve Completed
						BEGIN
							Set @GEN_QueueId = 0

							SET @CurrentActionLkup = 28032			--Save
							SET @CurrentWorkQueuesLkup = 10048		--TRR - TRC 282
							SET @CurrentStatusLkup = 20001			--NEW

							SET @AuditDescption = 'TRC Code – 282 is received. A new case is created on '+ CONVERT(varchar, @CurrentUTCDate,113) +' and Performed By as System: GPS  WQ'

							EXEC [USP_APP_INS_CreateSuspectCase] @BusinessSegmentLkup = 1001, @WorkBasketLkup = 3001, @DiscrepancyCategoryLkup = 6003, @DiscrepancyTypeLkup = 7001,
							@MostRecentActionLkup = @CurrentActionLkup,@MostRecentWorkQueueLkup = @CurrentWorkQueuesLkup, @MostRecentStatusLkup = @CurrentStatusLkup, @SourceSystemLkup = @SSLkup, @DiscrepancySourceLkup = 13001, 
							@DiscrepancyReceiptDate = @CurrentUTCDate, @DiscrepancyReceiptDateId = @UTCDateId, @ComplianceStartDate = @FileReceiptDate,@ComplianceStartDateId = @ComplianceStartDateId,
							@DisenrollmentDate = @DisenrollDate, @MemberSCCCode = @SCCCode, @MemberCurrentHICN = @HICN, @GPSHouseholdID = @HouseHoldId,
							@MemberFirstName = @FirstName,@MemberLastName = @LastName, @MemberContractIDLkup = @Contract,@MemberPBPLkup = @PBP,@MemberLOBLkup = @LOB,
							@MemberDOB = @MemberDOB,@MemberDOBId = @MemberDOBId,@EligOOAFlagLkup = 0,@RPRCTMMember = 0,@RPREGHPMember = 0,@IsParentCase = 0,
							@IsChildCase = 0,@Comments = @AuditDescption,@RoleLkup = 2001,@CurrentActionLkup = @CurrentActionLkup,
							@CurrentWorkQueuesLkup = @CurrentWorkQueuesLkup,@CurrentStatusLkup = @CurrentStatusLkup,@LoginUserId = @CurrentUserId,
							@TRCLkup=@TRCLkup,@IsRestricted = @IsRestricted,@ErrorMessage = @ErrorMessage OUTPUT,@CommentsSourceSystemLkup = @SSLkup,@GEN_QueueId = @GEN_QueueId OUTPUT
						END
						ELSE
						BEGIN
							
							DECLARE @DBPendReasonLkup Bigint = 0
							DECLARE @PreviousWorkQueueLkupFromQueueTable Bigint = 0
							SET @DBPendReasonLkup = (Select PendReasonLkup From GEN_OSTActions Where GEN_QueueRef = @GEN_QueueId)
							SET @PreviousWorkQueueLkupFromQueueTable = (Select PreviousWorkQueueLkup From GEN_Queue Where GEN_QueueId = @GEN_QueueId)

							IF(@DiscpCat = 6003)	--TRR
							BEGIN
								SET @CurrentActionLkup = 28064			--TRC 282 Received
								SET @CurrentWorkQueuesLkup = 10048		--TRR - TRC 282
								SET @CurrentStatusLkup = 20002			--INPROGRESS

								SET @AuditDescption = 'TRC Code – '+cast(@TRCCode as varchar(5))+'  is received and current case routed to TRC 282 queue on '+ CONVERT(varchar, @CurrentUTCDate,113) +' and Performed By as System: GPS  WQ'
								SET @IsCaseResolved = 0
							END
							ELSE
							BEGIN
								IF(@DiscpCat = 6001)	--OOA
								BEGIN
									SET @CurrentActionLkup = 28002			--Action - Close Case
									SET @CurrentResolutionLkup = 18006		--Resolution - Close Case
									SET @CurrentWorkQueuesLkup = 10004		--OOA Completed
									SET @CurrentStatusLkup = 20003			--Resolve Completed

									SET @AuditDescption = 'TRC Code – '+cast(@TRCCode as varchar(5))+' is received, closing OOA Case'
									SET @IsCaseResolved = 1

									Set @ClosedQueueIdForReference = @GEN_QueueId
								END

								ELSE IF(@DiscpCat = 6002)	--SCC
								BEGIN

									--If MostRecentWQ = 'SCC Pended' (10025)  + PreviousWQ From Queue Table = 'Potential SCC RPR Day 1' (10111) + 
									--PendReasonLkup = 'Deletion - 76' (30024) = >  Move to Potential SCC RPR Day 2
									
									If(@MostRecentRecStatus = 20002 And @PreviousWQLkup = 10025 AND 
										@PreviousWorkQueueLkupFromQueueTable = 10111 AND @DBPendReasonLkup = 30024)
									BEGIN
										SET @CurrentActionLkup = 28001					--Add Comments
										SET @CurrentWorkQueuesLkup = 10113				--10113 - SCC - Potential SCC RPR Day 2
										SET @CurrentStatusLkup = 20002					--INPROGRESS

										SET @AuditDescption = 'TRC Code – '+cast(@TRCCode as varchar(5))+' received. Updating the Queue from SCC - Potential SCC RPR Day 1 to SCC - Potential SCC RPR Day 2'
									END
									ELSE
									BEGIN
										SET @CurrentActionLkup = 28002			--Action - Close Case
										SET @CurrentResolutionLkup = 18006		--Resolution - Close Case
										SET @CurrentWorkQueuesLkup = 10019		--SCC Completed
										SET @CurrentStatusLkup = 20003			--Resolve Completed

										SET @AuditDescption = 'TRC Code – '+cast(@TRCCode as varchar(5))+' is received, closing SCC case'
										SET @IsCaseResolved = 1

										Set @ClosedQueueIdForReference = @GEN_QueueId
									END
								END						
							END

							--Update GEN_Queue
							Update GEN_Queue 
							Set MostRecentStatusLkup = @CurrentStatusLkup
								,MostRecentWorkQueueLkup = @CurrentWorkQueuesLkup
								,[UTCLastUpdatedOn]= @CurrentUTCDate
								,[UTCLastUpdatedOnId]= FORMAT(@CurrentUTCDate, 'yyyyMMdd')
								,[UTCLastUpdatedOnYear]= FORMAT(@CurrentUTCDate, 'yyyy')
								,[UTCLastUpdatedOnMonth]= FORMAT(@CurrentUTCDate, 'MM')
								,[UTCLastUpdatedOnDay]= FORMAT(@CurrentUTCDate, 'dd')
								,[CSTLastUpdatedOn]= DATEADD(hh, -6, @CurrentUTCDate)
								,[CSTLastUpdatedOnId]= FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'yyyyMMdd')
								,[CSTLastUpdatedOnYear]= FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'yyyy')
								,[CSTLastUpdatedOnMonth]= FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'MM')
								,[CSTLastUpdatedOnDay]= FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'dd')
								,[LastUpdatedByRef] = @CurrentUserId
								,[MostRecentActionLkup]= @CurrentActionLkup
								,[IsCaseResolved]=@IsCaseResolved
								,[ResolvedByRef]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE @CurrentUserId END
								,[UTCResolvedOn]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE @CurrentUTCDate END
								,[UTCResolvedOnId]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE FORMAT(@CurrentUTCDate, 'yyyyMMdd') END
								,[UTCResolvedOnYear]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE FORMAT(@CurrentUTCDate, 'yyyy') END
								,[UTCResolvedOnMonth]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE FORMAT(@CurrentUTCDate, 'MM') END
								,[UTCResolvedOnDay]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE FORMAT(@CurrentUTCDate, 'dd') END
								,[CSTResolvedOn]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE DATEADD(hh, -6, @CurrentUTCDate) END
								,[CSTResolvedOnId]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'yyyyMMdd') END
								,[CSTResolvedOnYear]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'yyyy') END
								,[CSTResolvedOnMonth]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'MM') END
								,[CSTResolvedOnDay]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'dd') END
								,[TRCLkup]= @TRCLkup
								,[IsCasePended]=0
								,[PendedbyRef]= NULL
								,[UTCPendedOn]= NULL
								,[UTCPendedOnId]= NULL
								,[UTCPendedOnYear]= NULL
								,[UTCPendedOnMonth]= NULL
								,[UTCPendedOnDay]= NULL
								,[CSTPendedOn]= NULL
								,[CSTPendedOnId]= NULL
								,[CSTPendedOnYear]= NULL
								,[CSTPendedOnMonth]= NULL
								,[CSTPendedOnDay]= NULL
								,PreviousWorkQueueLkup = NULL
							Where GEN_QueueId = @GEN_QueueId

							--Update GEN_OSTActions
							If EXISTS (Select 1 From GEN_OSTActions Where GEN_QueueRef = @GEN_QueueId)
							BEGIN
								Update GEN_OSTActions Set ActionLkup = @CurrentActionLkup, ResolutionLkup = @CurrentResolutionLkup, PendReasonLkup = @DBPendReasonLkup, UTCLastUpdatedOn = @CurrentUTCDate, LastUpdatedByRef = @CurrentUserId Where GEN_QueueRef = @GEN_QueueId
							END
							ELSE
							BEGIN
								INSERT INTO [dbo].[GEN_OSTActions]
											([GEN_QueueRef],[ActionLkup],[LastName],[DateofBirth],[ContractIDLkup],[PBPLkup],[ApplicationDate],[EffectiveDate],
											[EndDate],[FirstLetterMailDate],[SecondLetterMailDate],[ResidentialDocumentationRequired],[CountyAttestationRequired],
											[PendReasonLkup],[ContainsErrorsLkup],[ResolutionLkup],[Reason],[InitialAddressVerificationDate],
											[MemberResponseVerificationDate],[MemberVerifiedState],[SCCLetterMailDate],[IsActive],[UTCCreatedOn],[CreatedByRef],
											[UTCLastUpdatedOn],[LastUpdatedByRef])
									VALUES  (@GEN_QueueId,@CurrentActionLkup,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,@DBPendReasonLkup,NULL,@CurrentResolutionLkup,NULL,NULL,
											NULL,NULL,NULL,1,@CurrentUTCDate,@CurrentUserId,@CurrentUTCDate,@CurrentUserId)
							END

							--Add Comments
							INSERT INTO [dbo].[GEN_Comments]
										([GEN_QueueRef],[Comments],[ActionLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef],[SourceSystemLkup])
							VALUES      (@GEN_QueueId,@AuditDescption,@CurrentActionLkup,1,@CurrentUTCDate,@CurrentUserId,@CurrentUTCDate,@CurrentUserId,@SSLkup)

							--Add Workflow
							INSERT INTO [dbo].[GEN_QueueWorkFlowCorrelation]
										([GEN_QueueRef],[RoleLkup],[WorkBasketLkup],[DiscrepancyCategoryLkup],[PreviousActionLkup],[PreviousWorkQueuesLkup],
											[PreviousStatusLkup],[CurrentActionLkup],[CurrentWorkQueuesLkup],[CurrentStatusLkup],[IsActive],[UTCCreatedOn],
											[CreatedByRef])
							VALUES		(@GEN_QueueId,2001,3001,@DiscpCat,@PreviousActionLkup,@PreviousWQLkup,@PreviousStsLkup,@CurrentActionLkup,@CurrentWorkQueuesLkup,@CurrentStatusLkup,1,@CurrentUTCDate,@CurrentUserId)

							--Add ManageCases for Action performed
							INSERT INTO [dbo].[GEN_ManageCases]([GEN_QueueRef],[ActionPerformedLkup],[CurrentUserRef],[CasesComments],[ReAssignUserRef],[IsActive],[UTCCreatedOn],
											[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef])
									VALUES  (@GEN_QueueId,@CurrentActionLkup,@CurrentUserId,NULL,NULL,1,@CurrentUTCDate,@CurrentUserId,@CurrentUTCDate,@CurrentUserId)
		
							IF(@ClosedQueueIdForReference > 0)
							BEGIN
								Set @GEN_QueueId = 0

								SET @CurrentActionLkup = 28064			--TRC 282 Received
								SET @CurrentWorkQueuesLkup = 10048		--TRR - TRC 282
								SET @CurrentStatusLkup = 20001			--NEW

								SET @AuditDescption =  'TRC Code – '+cast(@TRCCode as varchar(5))+'  is received. New case createed and routed to TRC 282 queue on '+ CONVERT(varchar, @CurrentUTCDate,113) +' and Performed By as System: GPS  WQ'

								EXEC [USP_APP_INS_CreateSuspectCase] @BusinessSegmentLkup = 1001, @WorkBasketLkup = 3001, @DiscrepancyCategoryLkup = 6003, @DiscrepancyTypeLkup = 7001,
								@MostRecentActionLkup = @CurrentActionLkup,@MostRecentWorkQueueLkup = @CurrentWorkQueuesLkup, @MostRecentStatusLkup = @CurrentStatusLkup, @SourceSystemLkup = @SSLkup, @DiscrepancySourceLkup = 13001, 
								@DiscrepancyReceiptDate = @CurrentUTCDate, @DiscrepancyReceiptDateId = @UTCDateId, @ComplianceStartDate = @FileReceiptDate,@ComplianceStartDateId = @ComplianceStartDateId,
								@DisenrollmentDate = @DisenrollDate, @MemberSCCCode = @SCCCode, @MemberCurrentHICN = @HICN, @GPSHouseholdID = @HouseHoldId,
								@MemberFirstName = @FirstName,@MemberLastName = @LastName, @MemberContractIDLkup = @Contract,@MemberPBPLkup = @PBP,@MemberLOBLkup = @LOB,
								@MemberDOB = @MemberDOB,@MemberDOBId = @MemberDOBId,@EligOOAFlagLkup = 0,@RPRCTMMember = 0,@RPREGHPMember = 0,@IsParentCase = 0,
								@IsChildCase = 1,@ParentQueueRef = @ClosedQueueIdForReference,@Comments = @AuditDescption,@RoleLkup = 2001,
								@CurrentActionLkup = @CurrentActionLkup,@CurrentWorkQueuesLkup = @CurrentWorkQueuesLkup,@CurrentStatusLkup = @CurrentStatusLkup,@LoginUserId = @CurrentUserId,
								@TRCLkup=@TRCLkup,@IsRestricted = @IsRestricted,@ErrorMessage = @ErrorMessage OUTPUT,@CommentsSourceSystemLkup = @SSLkup,@GEN_QueueId = @GEN_QueueId OUTPUT
							END
						END
		
					END
					ELSE
					BEGIN
						If (@PlanTerminationDate Is Not NULL And Convert(date,@PlanTerminationDate,101) <= Convert(date,GetDate(),101))   --(Plan Termed)
						BEGIN
							SET @IsPlanTermed = 1
						END

						SET @CurrentActionLkup = 28032			--Save
						SET @CurrentWorkQueuesLkup = 10048		--TRR - TRC 282
						SET @CurrentStatusLkup = 20001			--NEW

						SET @AuditDescption = 'TRC Code – 282 is received. A new case is created on '+ CONVERT(varchar, @CurrentUTCDate,113) +' and Performed By as System: GPS  WQ'

						EXEC [USP_APP_INS_CreateSuspectCase] @BusinessSegmentLkup = 1001, @WorkBasketLkup = 3001, @DiscrepancyCategoryLkup = 6003, @DiscrepancyTypeLkup = 7001,
						@MostRecentActionLkup = @CurrentActionLkup,@MostRecentWorkQueueLkup = @CurrentWorkQueuesLkup, @MostRecentStatusLkup = @CurrentStatusLkup, @SourceSystemLkup = @SSLkup, @DiscrepancySourceLkup = 13001, 
						@DiscrepancyReceiptDate = @CurrentUTCDate, @DiscrepancyReceiptDateId = @UTCDateId, @ComplianceStartDate = @FileReceiptDate,@ComplianceStartDateId = @ComplianceStartDateId,
						@DisenrollmentDate = @DisenrollDate, @MemberSCCCode = @SCCCode, @MemberCurrentHICN = @HICN, @GPSHouseholdID = @HouseHoldId,
						@MemberFirstName = @FirstName,@MemberLastName = @LastName, @MemberContractIDLkup = @Contract,@MemberPBPLkup = @PBP,@MemberLOBLkup = @LOB,
						@MemberDOB = @MemberDOB,@MemberDOBId = @MemberDOBId,@EligOOAFlagLkup = 0,@RPRCTMMember = 0,@RPREGHPMember = 0,@IsParentCase = 0,
						@IsChildCase = 0,@Comments = @AuditDescption,@RoleLkup = 2001,@CurrentActionLkup = @CurrentActionLkup,
						@CurrentWorkQueuesLkup = @CurrentWorkQueuesLkup,@CurrentStatusLkup = @CurrentStatusLkup,@LoginUserId = @CurrentUserId,
						@TRCLkup=@TRCLkup,@IsRestricted = @IsRestricted,@ErrorMessage = @ErrorMessage OUTPUT,@CommentsSourceSystemLkup = @SSLkup,@GEN_QueueId = @GEN_QueueId OUTPUT

						IF(@IsPlanTermed = 1)
						BEGIN
							Select @PreviousActionLkup= Q.MostRecentActionLkup, @PreviousWQLkup = Q.MostRecentWorkQueueLkup, @PreviousStsLkup = Q.MostRecentStatusLkup
							From GEN_Queue Q
							Where Q.IsActive = 1 And Q.LockedByRef Is NULL And GEN_QueueId = @GEN_QueueId

							IF EXISTS(Select 1 
										From MQTRRWorkQueueItems 
										Where (IsProcessed = 0 And CMN_BackgroundProcessMasterRef = @CMN_BackgroundProcessMasterRef And TRC In ('285', '018', '015', '014', '013') And TimelineEffectiveDate = @EffectiveDate  
											And [Contract] = @ContractValue And PBP = @PBPValue 
											AND CONVERT(varchar,UTCCreatedOn,101) >= Convert(varchar,GETUTcDate(),101) 
											And CONVERT(varchar,UTCCreatedOn,101) < Convert(varchar,DateAdd(dd,1,GETUTcDate()),101)) OR
											(IsProcessed = 0 And CMN_BackgroundProcessMasterRef = @CMN_BackgroundProcessMasterRef And TRC In ('100') And TRCTypeCode = '61' And TimelineEffectiveDate = @EffectiveDate 
											And ([Contract] <> @ContractValue Or PBP <> @PBPValue) 
											AND CONVERT(varchar,UTCCreatedOn,101) >= Convert(varchar,GETUTcDate(),101) 
											And CONVERT(varchar,UTCCreatedOn,101) < Convert(varchar,DateAdd(dd,1,GETUTcDate()),101)))
							BEGIN
								SET @CurrentActionLkup = 28002			--Close Case
								SET @CurrentWorkQueuesLkup = 10036		--TRR - Completed
								SET @CurrentStatusLkup = 20003			--RESOLVE COMPLETED
								SET @CurrentResolutionLkup = 18006		--Resolution - Close Case
								SET @IsCaseResolved = 1

								--Update Queue
								Update GEN_Queue 
								Set MostRecentStatusLkup = @CurrentStatusLkup
									,MostRecentWorkQueueLkup = @CurrentWorkQueuesLkup
									,[UTCLastUpdatedOn]= @CurrentUTCDate
									,[UTCLastUpdatedOnId]= FORMAT(@CurrentUTCDate, 'yyyyMMdd')
									,[UTCLastUpdatedOnYear]= FORMAT(@CurrentUTCDate, 'yyyy')
									,[UTCLastUpdatedOnMonth]= FORMAT(@CurrentUTCDate, 'MM')
									,[UTCLastUpdatedOnDay]= FORMAT(@CurrentUTCDate, 'dd')
									,[CSTLastUpdatedOn]= DATEADD(hh, -6, @CurrentUTCDate)
									,[CSTLastUpdatedOnId]= FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'yyyyMMdd')
									,[CSTLastUpdatedOnYear]= FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'yyyy')
									,[CSTLastUpdatedOnMonth]= FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'MM')
									,[CSTLastUpdatedOnDay]= FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'dd')
									,[LastUpdatedByRef] = @CurrentUserId
									,[MostRecentActionLkup]= @CurrentActionLkup
									,[IsCaseResolved]=@IsCaseResolved
									,[ResolvedByRef]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE @CurrentUserId END
									,[UTCResolvedOn]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE @CurrentUTCDate END
									,[UTCResolvedOnId]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE FORMAT(@CurrentUTCDate, 'yyyyMMdd') END
									,[UTCResolvedOnYear]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE FORMAT(@CurrentUTCDate, 'yyyy') END
									,[UTCResolvedOnMonth]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE FORMAT(@CurrentUTCDate, 'MM') END
									,[UTCResolvedOnDay]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE FORMAT(@CurrentUTCDate, 'dd') END
									,[CSTResolvedOn]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE DATEADD(hh, -6, @CurrentUTCDate) END
									,[CSTResolvedOnId]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'yyyyMMdd') END
									,[CSTResolvedOnYear]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'yyyy') END
									,[CSTResolvedOnMonth]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'MM') END
									,[CSTResolvedOnDay]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'dd') END
									,[TRCLkup]= @TRCLkup
								Where GEN_QueueId = @GEN_QueueId

								--Update GEN_OSTActions
								If EXISTS (Select 1 From GEN_OSTActions Where GEN_QueueRef = @GEN_QueueId)
								BEGIN
									Update GEN_OSTActions Set ActionLkup = @CurrentActionLkup, ResolutionLkup = @CurrentResolutionLkup, UTCLastUpdatedOn = @CurrentUTCDate, LastUpdatedByRef = @CurrentUserId Where GEN_QueueRef = @GEN_QueueId
								END
								ELSE
								BEGIN
									INSERT INTO [dbo].[GEN_OSTActions]
												([GEN_QueueRef],[ActionLkup],[LastName],[DateofBirth],[ContractIDLkup],[PBPLkup],[ApplicationDate],[EffectiveDate],
												[EndDate],[FirstLetterMailDate],[SecondLetterMailDate],[ResidentialDocumentationRequired],[CountyAttestationRequired],
												[PendReasonLkup],[ContainsErrorsLkup],[ResolutionLkup],[Reason],[InitialAddressVerificationDate],
												[MemberResponseVerificationDate],[MemberVerifiedState],[SCCLetterMailDate],[IsActive],[UTCCreatedOn],[CreatedByRef],
												[UTCLastUpdatedOn],[LastUpdatedByRef])
										VALUES  (@GEN_QueueId,@CurrentActionLkup,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,@CurrentResolutionLkup,NULL,NULL,
												NULL,NULL,NULL,1,@CurrentUTCDate,@CurrentUserId,@CurrentUTCDate,@CurrentUserId)
								END

								--Set Comments
								SET @AuditDescption = 'TRC Code – '+cast(@TRCCode as varchar(5))+' is received. Record status updated to Resolved-Completed and a GPS note was added and Performed By as System: GPS  WQ'

								INSERT INTO [dbo].[GEN_Comments]
											([GEN_QueueRef],[Comments],[ActionLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef],[SourceSystemLkup])
								VALUES      (@GEN_QueueId,@AuditDescption,@CurrentActionLkup,1,@CurrentUTCDate,@CurrentUserId,@CurrentUTCDate,@CurrentUserId,@SSLkup)

								--Add Workflow
								INSERT INTO [dbo].[GEN_QueueWorkFlowCorrelation]
											([GEN_QueueRef],[RoleLkup],[WorkBasketLkup],[DiscrepancyCategoryLkup],[PreviousActionLkup],[PreviousWorkQueuesLkup],
												[PreviousStatusLkup],[CurrentActionLkup],[CurrentWorkQueuesLkup],[CurrentStatusLkup],[IsActive],[UTCCreatedOn],
												[CreatedByRef])
								VALUES		(@GEN_QueueId,2001,3001,@DiscpCat,@PreviousActionLkup,@PreviousWQLkup,@PreviousStsLkup,@CurrentActionLkup,@CurrentWorkQueuesLkup,@CurrentStatusLkup,1,@CurrentUTCDate,@CurrentUserId)

								--Add ManageCases for Action performed
								INSERT INTO [dbo].[GEN_ManageCases]([GEN_QueueRef],[ActionPerformedLkup],[CurrentUserRef],[CasesComments],[ReAssignUserRef],[IsActive],[UTCCreatedOn],
											[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef])
									VALUES  (@GEN_QueueId,@CurrentActionLkup,@CurrentUserId,NULL,NULL,1,@CurrentUTCDate,@CurrentUserId,@CurrentUTCDate,@CurrentUserId)
				
								--Need to enable this, because once a matching record processed, need to mark the filtered record also processed
								Update M 
								Set M.ProcessedGENQueueRef = @GEN_QueueId, M.IsProcessed = 1, M.UTCProcessedOn = @CurrentUTCDate, M.ProcessedByRef = @CurrentUserId, 
									M.UTCLastUpdatedOn = @CurrentUTCDate, M.UpdatedByRef = @CurrentUserId
								From MQTRRWorkQueueItems M 
								Where (IsProcessed = 0 And CMN_BackgroundProcessMasterRef = @CMN_BackgroundProcessMasterRef And TRC In ('285', '018', '015', '014', '013') And TimelineEffectiveDate = @EffectiveDate  
									And [Contract] = @ContractValue And PBP = @PBPValue 
									AND CONVERT(varchar,UTCCreatedOn,101) >= Convert(varchar,GETUTcDate(),101) 
									And CONVERT(varchar,UTCCreatedOn,101) < Convert(varchar,DateAdd(dd,1,GETUTcDate()),101)) OR
									(IsProcessed = 0 And CMN_BackgroundProcessMasterRef = @CMN_BackgroundProcessMasterRef And TRC In ('100') And TRCTypeCode = '61' And TimelineEffectiveDate = @EffectiveDate 
									And ([Contract] <> @ContractValue Or PBP <> @PBPValue) 
									AND CONVERT(varchar,UTCCreatedOn,101) >= Convert(varchar,GETUTcDate(),101) 
									And CONVERT(varchar,UTCCreatedOn,101) < Convert(varchar,DateAdd(dd,1,GETUTcDate()),101))
							END
							ELSE
							BEGIN
								SET @CurrentActionLkup = 28062			--Escalated Action
								SET @CurrentWorkQueuesLkup = 10037		--TRR - Escalated
								SET @CurrentStatusLkup = 20002			--INPROGRESS

								--Update Queue
								Update GEN_Queue 
								Set MostRecentStatusLkup = @CurrentStatusLkup
									,MostRecentWorkQueueLkup = @CurrentWorkQueuesLkup
									,[UTCLastUpdatedOn]= @CurrentUTCDate
									,[UTCLastUpdatedOnId]= FORMAT(@CurrentUTCDate, 'yyyyMMdd')
									,[UTCLastUpdatedOnYear]= FORMAT(@CurrentUTCDate, 'yyyy')
									,[UTCLastUpdatedOnMonth]= FORMAT(@CurrentUTCDate, 'MM')
									,[UTCLastUpdatedOnDay]= FORMAT(@CurrentUTCDate, 'dd')
									,[CSTLastUpdatedOn]= DATEADD(hh, -6, @CurrentUTCDate)
									,[CSTLastUpdatedOnId]= FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'yyyyMMdd')
									,[CSTLastUpdatedOnYear]= FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'yyyy')
									,[CSTLastUpdatedOnMonth]= FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'MM')
									,[CSTLastUpdatedOnDay]= FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'dd')
									,[LastUpdatedByRef] = @CurrentUserId
									,[MostRecentActionLkup]= @CurrentActionLkup
									,[TRCLkup]= @TRCLkup
								Where GEN_QueueId = @GEN_QueueId

								--Update GEN_OSTActions
								If EXISTS (Select 1 From GEN_OSTActions Where GEN_QueueRef = @GEN_QueueId)
								BEGIN
									Update GEN_OSTActions Set ActionLkup = @CurrentActionLkup, UTCLastUpdatedOn = @CurrentUTCDate, LastUpdatedByRef = @CurrentUserId Where GEN_QueueRef = @GEN_QueueId
								END
								ELSE
								BEGIN
									INSERT INTO [dbo].[GEN_OSTActions]
												([GEN_QueueRef],[ActionLkup],[LastName],[DateofBirth],[ContractIDLkup],[PBPLkup],[ApplicationDate],[EffectiveDate],
												[EndDate],[FirstLetterMailDate],[SecondLetterMailDate],[ResidentialDocumentationRequired],[CountyAttestationRequired],
												[PendReasonLkup],[ContainsErrorsLkup],[ResolutionLkup],[Reason],[InitialAddressVerificationDate],
												[MemberResponseVerificationDate],[MemberVerifiedState],[SCCLetterMailDate],[IsActive],[UTCCreatedOn],[CreatedByRef],
												[UTCLastUpdatedOn],[LastUpdatedByRef])
										VALUES  (@GEN_QueueId,@CurrentActionLkup,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,
												NULL,NULL,NULL,1,@CurrentUTCDate,@CurrentUserId,@CurrentUTCDate,@CurrentUserId)
								END

								--Set Comments
								SET @AuditDescption = 'TRC Code – '+cast(@TRCCode as varchar(5))+' is received, Escalating case because no active timeline exists in GPS'

								INSERT INTO [dbo].[GEN_Comments]
											([GEN_QueueRef],[Comments],[ActionLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef],[SourceSystemLkup])
								VALUES      (@GEN_QueueId,@AuditDescption,@CurrentActionLkup,1,@CurrentUTCDate,@CurrentUserId,@CurrentUTCDate,@CurrentUserId,@SSLkup)

								--Add Workflow
								INSERT INTO [dbo].[GEN_QueueWorkFlowCorrelation]
											([GEN_QueueRef],[RoleLkup],[WorkBasketLkup],[DiscrepancyCategoryLkup],[PreviousActionLkup],[PreviousWorkQueuesLkup],
												[PreviousStatusLkup],[CurrentActionLkup],[CurrentWorkQueuesLkup],[CurrentStatusLkup],[IsActive],[UTCCreatedOn],
												[CreatedByRef])
								VALUES		(@GEN_QueueId,2001,3001,@DiscpCat,@PreviousActionLkup,@PreviousWQLkup,@PreviousStsLkup,@CurrentActionLkup,@CurrentWorkQueuesLkup,@CurrentStatusLkup,1,@CurrentUTCDate,@CurrentUserId)

								--Add ManageCases for Action performed
								INSERT INTO [dbo].[GEN_ManageCases]([GEN_QueueRef],[ActionPerformedLkup],[CurrentUserRef],[CasesComments],[ReAssignUserRef],[IsActive],[UTCCreatedOn],
											[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef])
									VALUES  (@GEN_QueueId,@CurrentActionLkup,@CurrentUserId,NULL,NULL,1,@CurrentUTCDate,@CurrentUserId,@CurrentUTCDate,@CurrentUserId)
							END
						END
					END				
				END

				SET @IterationCount = @IterationCount+1

				IF(LEN(@ProcessedQueueIds) > 0)
				BEGIN
					SET @ProcessedQueueIds = @ProcessedQueueIds + ','
				END

				IF(@ClosedQueueIdForReference > 0)
				BEGIN
					SET @ProcessedQueueIds = @ProcessedQueueIds + Cast(@ClosedQueueIdForReference as Varchar) + ',' +Cast(@GEN_QueueId as Varchar)
				END
				ELSE
				BEGIN
					SET @ProcessedQueueIds = @ProcessedQueueIds + Cast(@GEN_QueueId as Varchar)
				END

				IF(@TotalRecordsCount = 0)
				BEGIN
					BREAK;
				END
			END
		END

		IF(LEN(@BSRRecords) > 0)
		BEGIN
			SET @BSRRecords = 'Matching ERS Case '+@BSRRecords+' found. It will be processed by BSR.'
		END

		--Update MQTRRWorkItem as IsProcessed = 1
		Update MQTRRWorkQueueItems Set ProcessedGENQueueRef = @ProcessedQueueIds, IsProcessed = 1, UTCProcessedOn = @CurrentUTCDate,ProcessedByRef = @CurrentUserId, UTCLastUpdatedOn = @CurrentUTCDate, UpdatedByRef = @CurrentUserId, ProcessingErrorMessage = @BSRRecords Where MQTRRWorkQueueItemId = @MQTRRWorkQueueItemsId

		DROP Table #TempRecordsToProcess

	END
	-------- END ----------


	ELSE IF(@TRCCode = '155')
	BEGIN

		--=========================== TRC 155 (Incarceration Notification Received) ===========================--
		-------- BEGIN ----------

		--Match Logic:
		--Existing OOA Case (Discrepancy Case Category = OOA, and Status is other than Resolved-Completed, and Discrepancy Type = Incarcerated
		--Where:HICN, Contract # and PBP in discrepancy record is matched with the HICN, Contract# and PBP in the Case. 
		--The system will look for a match using the following order of application fields.· GPS Contract and GPS PBP and Current HICN· MMR Contract and MMR PBP and Current HICN· Other Contract and Other PBP and Current HICN

		IF(@MQSourceTypeLkup = 54002)
		BEGIN
			INSERT INTO #TempRecordsToProcess
			Select  Distinct Q.GEN_QueueId, Q.DiscrepancyCategoryLkup, Q.DiscrepancyTypeLkup, Q.MostRecentActionLkup, Q.MostRecentWorkQueueLkup, Q.MostRecentStatusLkup, Q.LockedByRef,
					Q.CreatedByRef, Q.LastUpdatedByRef
			From GEN_Queue Q 
			Where Q.IsActive = 1 And Q.DiscrepancyCategoryLkup In (6001,6003) And Q.MostRecentStatusLkup Not In (20003) And Q.DiscrepancyTypeLkup In (7003)
			And (Q.MemberCurrentHICN = @HICN Or Q.MemberMedicareId = @HICN) And Q.MemberContractIDLkup= @Contract And Q.MemberPBPLkup= @PBP
		END
		ELSE
		BEGIN
			INSERT INTO #TempRecordsToProcess
			Select  @GEN_QueueId, Q.DiscrepancyCategoryLkup, Q.DiscrepancyTypeLkup, Q.MostRecentActionLkup, Q.MostRecentWorkQueueLkup, Q.MostRecentStatusLkup, Q.LockedByRef,
					Q.CreatedByRef, Q.LastUpdatedByRef
			From GEN_Queue Q
			Where Q.IsActive = 1 And Q.GEn_QueueId = @GEN_QueueId
		END

		SET @TotalRecordsCount = (Select Count(1) From #TempRecordsToProcess)
		SET @IterationCount = 1

		WHILE(@TotalRecordsCount = 0 Or @IterationCount <= @TotalRecordsCount)
		BEGIN
			SET @ClosedQueueIdForReference = 0
			SET @GEN_QueueId = 0
			SET @DiscpCat = 0
			SET @PreviousActionLkup = 0
			SET @PreviousWQLkup = 0
			SET @PreviousStsLkup = 0
			SET @LockedByRef = 0
			SET @CreatedByRef = 0
			SET @LastUpdatedByRef = 0
			
			Select @GEN_QueueId = GEN_QueueId, @DiscpCat = DiscpCat, @PreviousActionLkup = PreviousActionLkup, @PreviousWQLkup = PreviousWQLkup,
					@PreviousStsLkup = PreviousStsLkup, @LockedByRef = LockedByRef, @CreatedByRef = CreatedByRef, @LastUpdatedByRef = LastUpdatedByRef
			From #TempRecordsToProcess Where SNO = @IterationCount

			IF(@LockedByRef Is NULL Or @LockedByRef = 0)
			BEGIN
				IF(@GEN_QueueId Is NOT NULL And @GEN_QueueId > 0)
				BEGIN
					IF(@DiscpCat = 6003)	--TRR
					BEGIN
						SET @CurrentActionLkup = 28001					--Add Comments
						SET @CurrentWorkQueuesLkup = @PreviousWQLkup	--Same as previous WorkQueue Lookup	
						SET @CurrentStatusLkup = 20002					--INPROGRESS

						SET @AuditDescption = 'TRC Code – '+cast(@TRCCode as varchar(5))+' is received and no new case is created on '+ CONVERT(varchar, @CurrentUTCDate,113) +' and Performed By as System: GPS  WQ'
						SET @IsCaseResolved = 0
					END
					ELSE
					BEGIN
						SET @CurrentActionLkup = 28002			--Action - Close Case
						SET @CurrentResolutionLkup = 18006		--Resolution - Close Case

						IF(@DiscpCat = 6001)	--OOA
						BEGIN
							SET @CurrentWorkQueuesLkup = 10004		--OOA Completed
							SET @CurrentStatusLkup = 20003			--Resolve Completed

							SET @AuditDescption = 'TRC Code – '+cast(@TRCCode as varchar(5))+' is received, closing OOA Case'
							SET @IsCaseResolved = 1
						END

						--ELSE IF(@DiscpCat = 6002)	--SCC
						--BEGIN
						--	SET @CurrentWorkQueuesLkup = 10019		--SCC Completed
						--	SET @CurrentStatusLkup = 20003			--Resolve Completed

						--	SET @AuditDescption = 'TRC Code – '+cast(@TRCCode as varchar(5))+' is received, closing SCC case'
						--	SET @IsCaseResolved = 1
						--END

						Set @ClosedQueueIdForReference = @GEN_QueueId	
					END

					--Update GEN_Queue
					Update GEN_Queue 
					Set MostRecentStatusLkup = @CurrentStatusLkup
						,MostRecentWorkQueueLkup = @CurrentWorkQueuesLkup
						,[UTCLastUpdatedOn]= @CurrentUTCDate
						,[UTCLastUpdatedOnId]= FORMAT(@CurrentUTCDate, 'yyyyMMdd')
						,[UTCLastUpdatedOnYear]= FORMAT(@CurrentUTCDate, 'yyyy')
						,[UTCLastUpdatedOnMonth]= FORMAT(@CurrentUTCDate, 'MM')
						,[UTCLastUpdatedOnDay]= FORMAT(@CurrentUTCDate, 'dd')
						,[CSTLastUpdatedOn]= DATEADD(hh, -6, @CurrentUTCDate)
						,[CSTLastUpdatedOnId]= FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'yyyyMMdd')
						,[CSTLastUpdatedOnYear]= FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'yyyy')
						,[CSTLastUpdatedOnMonth]= FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'MM')
						,[CSTLastUpdatedOnDay]= FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'dd')
						,[LastUpdatedByRef] = @CurrentUserId
						,[MostRecentActionLkup]= @CurrentActionLkup
						,[IsCaseResolved]=@IsCaseResolved
						,[ResolvedByRef]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE @CurrentUserId END
						,[UTCResolvedOn]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE @CurrentUTCDate END
						,[UTCResolvedOnId]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE FORMAT(@CurrentUTCDate, 'yyyyMMdd') END
						,[UTCResolvedOnYear]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE FORMAT(@CurrentUTCDate, 'yyyy') END
						,[UTCResolvedOnMonth]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE FORMAT(@CurrentUTCDate, 'MM') END
						,[UTCResolvedOnDay]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE FORMAT(@CurrentUTCDate, 'dd') END
						,[CSTResolvedOn]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE DATEADD(hh, -6, @CurrentUTCDate) END
						,[CSTResolvedOnId]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'yyyyMMdd') END
						,[CSTResolvedOnYear]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'yyyy') END
						,[CSTResolvedOnMonth]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'MM') END
						,[CSTResolvedOnDay]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'dd') END
						,[TRCLkup]= @TRCLkup
					Where GEN_QueueId = @GEN_QueueId
				
					If EXISTS (Select 1 From GEN_OSTActions Where GEN_QueueRef = @GEN_QueueId)
					BEGIN
						Update GEN_OSTActions Set ActionLkup = @CurrentActionLkup, ResolutionLkup = @CurrentResolutionLkup, UTCLastUpdatedOn = @CurrentUTCDate, LastUpdatedByRef = @CurrentUserId Where GEN_QueueRef = @GEN_QueueId
					END
					ELSE
					BEGIN
						INSERT INTO [dbo].[GEN_OSTActions]
									([GEN_QueueRef],[ActionLkup],[LastName],[DateofBirth],[ContractIDLkup],[PBPLkup],[ApplicationDate],[EffectiveDate],
									[EndDate],[FirstLetterMailDate],[SecondLetterMailDate],[ResidentialDocumentationRequired],[CountyAttestationRequired],
									[PendReasonLkup],[ContainsErrorsLkup],[ResolutionLkup],[Reason],[InitialAddressVerificationDate],
									[MemberResponseVerificationDate],[MemberVerifiedState],[SCCLetterMailDate],[IsActive],[UTCCreatedOn],[CreatedByRef],
									[UTCLastUpdatedOn],[LastUpdatedByRef])
							VALUES  (@GEN_QueueId,@CurrentActionLkup,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,@CurrentResolutionLkup,NULL,NULL,
									NULL,NULL,NULL,1,@CurrentUTCDate,@CurrentUserId,@CurrentUTCDate,@CurrentUserId)
					END

					--Add Comments
					INSERT INTO [dbo].[GEN_Comments]
								([GEN_QueueRef],[Comments],[ActionLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef],[SourceSystemLkup])
					VALUES      (@GEN_QueueId,@AuditDescption,@CurrentActionLkup,1,@CurrentUTCDate,@CurrentUserId,@CurrentUTCDate,@CurrentUserId,@SSLkup)

					--Add Workflow
					INSERT INTO [dbo].[GEN_QueueWorkFlowCorrelation]
								([GEN_QueueRef],[RoleLkup],[WorkBasketLkup],[DiscrepancyCategoryLkup],[PreviousActionLkup],[PreviousWorkQueuesLkup],
									[PreviousStatusLkup],[CurrentActionLkup],[CurrentWorkQueuesLkup],[CurrentStatusLkup],[IsActive],[UTCCreatedOn],
									[CreatedByRef])
					VALUES		(@GEN_QueueId,2001,3001,@DiscpCat,@PreviousActionLkup,@PreviousWQLkup,@PreviousStsLkup,@CurrentActionLkup,@PreviousWQLkup,@CurrentStatusLkup,1,@CurrentUTCDate,@CurrentUserId)

					--Add ManageCases for Action performed
					INSERT INTO [dbo].[GEN_ManageCases]([GEN_QueueRef],[ActionPerformedLkup],[CurrentUserRef],[CasesComments],[ReAssignUserRef],[IsActive],[UTCCreatedOn],
								[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef])
						VALUES  (@GEN_QueueId,@CurrentActionLkup,@CurrentUserId,NULL,NULL,1,@CurrentUTCDate,@CurrentUserId,@CurrentUTCDate,@CurrentUserId)

					IF(@ClosedQueueIdForReference > 0)
					BEGIN
						Set @GEN_QueueId = 0

						SET @CurrentActionLkup = 28032			--Save
						SET @CurrentWorkQueuesLkup = 10047		--TRR - TRC 155
						SET @CurrentStatusLkup = 20001			--NEW

						SET @AuditDescption = 'TRC Code – '+cast(@TRCCode as varchar(5))+' is received, a new case is created with Status New and Performed By as System: GPS  WQ'

						EXEC [USP_APP_INS_CreateSuspectCase] @BusinessSegmentLkup = 1001, @WorkBasketLkup = 3001, @DiscrepancyCategoryLkup = 6003, @DiscrepancyTypeLkup = 7003,
						@MostRecentActionLkup = @CurrentActionLkup,@MostRecentWorkQueueLkup = @CurrentWorkQueuesLkup, @MostRecentStatusLkup = @CurrentStatusLkup, @SourceSystemLkup = @SSLkup, @DiscrepancySourceLkup = 13001, 
						@DiscrepancyReceiptDate = @CurrentUTCDate, @DiscrepancyReceiptDateId = @UTCDateId, @ComplianceStartDate = @FileReceiptDate,@ComplianceStartDateId = @ComplianceStartDateId,
						@DisenrollmentDate = @DisenrollDate, @MemberSCCCode = @SCCCode, @MemberCurrentHICN = @HICN, @GPSHouseholdID = @HouseHoldId,
						@MemberFirstName = @FirstName,@MemberLastName = @LastName, @MemberContractIDLkup = @Contract,@MemberPBPLkup = @PBP,@MemberLOBLkup = @LOB,
						@MemberDOB = @MemberDOB,@MemberDOBId = @MemberDOBId,@EligOOAFlagLkup = 0,@RPRCTMMember = 0,@RPREGHPMember = 0,@IsParentCase = 0,
						@IsChildCase = 1,@ParentQueueRef = @ClosedQueueIdForReference,@Comments = @AuditDescption,@RoleLkup = 2001,
						@CurrentActionLkup = @CurrentActionLkup,@CurrentWorkQueuesLkup = @CurrentWorkQueuesLkup,@CurrentStatusLkup = @CurrentStatusLkup,@LoginUserId = @CurrentUserId,
						@TRCLkup=@TRCLkup,@IsRestricted = @IsRestricted,@ErrorMessage = @ErrorMessage OUTPUT,@CommentsSourceSystemLkup = @SSLkup,@GEN_QueueId = @GEN_QueueId OUTPUT
					END
				END
				ELSE
				BEGIN
					If (@PlanTerminationDate Is Not NULL And Convert(date,@PlanTerminationDate,101) <= Convert(date,GetUTCDate(),101))  --(Plan Termed)
					BEGIN
						--Don't do anything
						SET @IsPlanTermed = 1
						SET @BSRRecords = 'No matching case found in application. Plan is Termed. No Action Performed.'
					END
					ELSE
					BEGIN
						SET @CurrentActionLkup = 28032			--Save
						SET @CurrentWorkQueuesLkup = 10047		--TRR - TRC 155
						SET @CurrentStatusLkup = 20001			--NEW

						SET @AuditDescption = 'TRC Code – '+cast(@TRCCode as varchar(5))+' is received, a new case is created with Status New and Performed By as System: GPS  WQ'

						EXEC [USP_APP_INS_CreateSuspectCase] @BusinessSegmentLkup = 1001, @WorkBasketLkup = 3001, @DiscrepancyCategoryLkup = 6003, @DiscrepancyTypeLkup = 7003,
						@MostRecentActionLkup = @CurrentActionLkup,@MostRecentWorkQueueLkup = @CurrentWorkQueuesLkup, @MostRecentStatusLkup = @CurrentStatusLkup, @SourceSystemLkup = @SSLkup, @DiscrepancySourceLkup = 13001, 
						@DiscrepancyReceiptDate = @CurrentUTCDate, @DiscrepancyReceiptDateId = @UTCDateId, @ComplianceStartDate = @FileReceiptDate,@ComplianceStartDateId = @ComplianceStartDateId,
						@DisenrollmentDate = @DisenrollDate, @MemberSCCCode = @SCCCode, @MemberCurrentHICN = @HICN, @GPSHouseholdID = @HouseHoldId,
						@MemberFirstName = @FirstName,@MemberLastName = @LastName, @MemberContractIDLkup = @Contract,@MemberPBPLkup = @PBP,@MemberLOBLkup = @LOB,
						@MemberDOB = @MemberDOB,@MemberDOBId = @MemberDOBId,@EligOOAFlagLkup = 0,@RPRCTMMember = 0,@RPREGHPMember = 0,@IsParentCase = 0,
						@IsChildCase = 0,@Comments = @AuditDescption,@RoleLkup = 2001,@CurrentActionLkup = @CurrentActionLkup,
						@CurrentWorkQueuesLkup = @CurrentWorkQueuesLkup,@CurrentStatusLkup = @CurrentStatusLkup,@LoginUserId = @CurrentUserId,
						@TRCLkup=@TRCLkup,@IsRestricted = @IsRestricted,@ErrorMessage = @ErrorMessage OUTPUT,@CommentsSourceSystemLkup = @SSLkup,@GEN_QueueId = @GEN_QueueId OUTPUT
					END
				END
			END

			SET @IterationCount = @IterationCount+1

			IF(LEN(@ProcessedQueueIds) > 0)
			BEGIN
				SET @ProcessedQueueIds = @ProcessedQueueIds + ','
			END

			IF(@ClosedQueueIdForReference > 0)
			BEGIN
				SET @ProcessedQueueIds = @ProcessedQueueIds + Cast(@ClosedQueueIdForReference as Varchar) + ',' +Cast(@GEN_QueueId as Varchar)
			END
			ELSE
			BEGIN
				SET @ProcessedQueueIds = @ProcessedQueueIds + Cast(@GEN_QueueId as Varchar)
			END

			IF(@TotalRecordsCount = 0)
			BEGIN
				BREAK;
			END
		END

		--Update MQTRRWorkItem as IsProcessed = 1
		Update MQTRRWorkQueueItems Set ProcessedGENQueueRef = @ProcessedQueueIds, IsProcessed = 1, UTCProcessedOn = @CurrentUTCDate,ProcessedByRef = @CurrentUserId, UTCLastUpdatedOn = @CurrentUTCDate, UpdatedByRef = @CurrentUserId, ProcessingErrorMessage = @BSRRecords Where MQTRRWorkQueueItemId = @MQTRRWorkQueueItemsId

		DROP Table #TempRecordsToProcess
	END
	-------- END ----------


	ELSE IF(@TRCCode = '154')
	BEGIN

		--=========================== TRC 154 (Out of Area Status) ===========================--
		-------- BEGIN ----------

		--Type Code 01: MCO Correction
		--Type Code 76: Residence Address Record Update


		--Match Logic:
		--Existing OOA Case (Discrepancy Case Category = OOA, and 
		--Status is other than Resolved-Completed, and Discrepancy Type is some value other than Incarcerated
		--Where:HICN, Contract # and PBP in discrepancy record is matched with the HICN, Contract# and PBP in the Case. 
		--The system will look for a match using the following order of application fields.· GPS Contract and GPS PBP and Current HICN· MMR Contract and MMR PBP and Current HICN· Other Contract and Other PBP and Current HICN

		IF(@MQSourceTypeLkup = 54002)
		BEGIN
			INSERT INTO #TempRecordsToProcess
			Select  Distinct Q.GEN_QueueId, Q.DiscrepancyCategoryLkup, Q.DiscrepancyTypeLkup, Q.MostRecentActionLkup, Q.MostRecentWorkQueueLkup, Q.MostRecentStatusLkup, Q.LockedByRef,
					Q.CreatedByRef, Q.LastUpdatedByRef
			From GEN_Queue Q 
			Where Q.IsActive = 1 And Q.DiscrepancyCategoryLkup In (6001,6003) And Q.MostRecentStatusLkup Not In (20003) And Q.DiscrepancyTypeLkup Not In (7003)
			And (Q.MemberCurrentHICN = @HICN Or Q.MemberMedicareId = @HICN) And Q.MemberContractIDLkup= @Contract And Q.MemberPBPLkup= @PBP
		END
		ELSE
		BEGIN
			INSERT INTO #TempRecordsToProcess
			Select  @GEN_QueueId, Q.DiscrepancyCategoryLkup, Q.DiscrepancyTypeLkup, Q.MostRecentActionLkup, Q.MostRecentWorkQueueLkup, Q.MostRecentStatusLkup, Q.LockedByRef,
					Q.CreatedByRef, Q.LastUpdatedByRef
			From GEN_Queue Q
			Where Q.IsActive = 1 And Q.GEn_QueueId = @GEN_QueueId
		END

		SET @TotalRecordsCount = (Select Count(1) From #TempRecordsToProcess)
		SET @IterationCount = 1

		WHILE(@TotalRecordsCount = 0 Or @IterationCount <= @TotalRecordsCount)
		BEGIN
			SET @ClosedQueueIdForReference = 0
			SET @GEN_QueueId = 0
			SET @DiscpCat = 0
			SET @DiscpType = 0
			SET @PreviousActionLkup = 0
			SET @PreviousWQLkup = 0
			SET @PreviousStsLkup = 0
			SET @LockedByRef = 0
			SET @CreatedByRef = 0
			SET @LastUpdatedByRef = 0
		
			Select @GEN_QueueId = GEN_QueueId, @DiscpCat = DiscpCat, @DiscpType = DiscpType, @PreviousActionLkup = PreviousActionLkup, @PreviousWQLkup = PreviousWQLkup,
					@PreviousStsLkup = PreviousStsLkup, @LockedByRef = LockedByRef, @CreatedByRef = CreatedByRef, @LastUpdatedByRef = LastUpdatedByRef
			From #TempRecordsToProcess Where SNO = @IterationCount

			IF(@LockedByRef Is NULL Or @LockedByRef = 0)
			BEGIN
				IF(@GEN_QueueId Is NOT NULL And @GEN_QueueId > 0)
				BEGIN
					IF (@TRCTypeCode = '76') --If Type Code = 76
					BEGIN
						IF(@DiscpCat = 6003)	--TRR
						BEGIN
							SET @CurrentActionLkup = 28063			--Action : TRC 154:76 Received
							SET @CurrentWorkQueuesLkup = 10046		--TRR - TRC 154:76	
							SET @CurrentStatusLkup = 20002			--INPROGRESS
							SET @DiscpType = 7001					--OOA

							SET @AuditDescption = 'TRC Code – '+cast(@TRCCode as varchar(5))+' is received and no new case is created on '+ CONVERT(varchar, @CurrentUTCDate,113) +' and Performed By as System: GPS  WQ'
							SET @IsCaseResolved = 0
						END

						ELSE 
						BEGIN
							IF(@DiscpCat = 6001)	--OOA
							BEGIN
								SET @CurrentActionLkup = 28002			--Action - Close Case				
								SET @CurrentWorkQueuesLkup = 10004		--OOA Completed
								SET @CurrentStatusLkup = 20003			--Resolve Completed
								SET @CurrentResolutionLkup = 18006		--Resolution - Close Case

								SET @AuditDescption = 'TRC Code – '+cast(@TRCCode as varchar(5))+' is received, closing OOA Case'
								SET @IsCaseResolved = 1
							END

							--ELSE IF(@DiscpCat = 6002)	--SCC
							--BEGIN
							--  SET @CurrentActionLkup = 28002			--Action - Close Case		
							--	SET @CurrentWorkQueuesLkup = 10019		--SCC Completed
							--	SET @CurrentStatusLkup = 20003			--Resolve Completed
							--  SET @CurrentResolutionLkup = 18006		--Resolution - Close Case

							--	SET @AuditDescption = 'TRC Code – '+cast(@TRCCode as varchar(5))+' is received, closing SCC case'
							--	SET @IsCaseResolved = 1
							--END

							Set @ClosedQueueIdForReference = @GEN_QueueId
						END						

						--Update GEN_Queue
						Update GEN_Queue 
						Set MostRecentStatusLkup = @CurrentStatusLkup
							,MostRecentWorkQueueLkup = @CurrentWorkQueuesLkup
							,[DiscrepancyTypeLkup] = @DiscpType 
							,[UTCLastUpdatedOn]= @CurrentUTCDate
							,[UTCLastUpdatedOnId]= FORMAT(@CurrentUTCDate, 'yyyyMMdd')
							,[UTCLastUpdatedOnYear]= FORMAT(@CurrentUTCDate, 'yyyy')
							,[UTCLastUpdatedOnMonth]= FORMAT(@CurrentUTCDate, 'MM')
							,[UTCLastUpdatedOnDay]= FORMAT(@CurrentUTCDate, 'dd')
							,[CSTLastUpdatedOn]= DATEADD(hh, -6, @CurrentUTCDate)
							,[CSTLastUpdatedOnId]= FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'yyyyMMdd')
							,[CSTLastUpdatedOnYear]= FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'yyyy')
							,[CSTLastUpdatedOnMonth]= FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'MM')
							,[CSTLastUpdatedOnDay]= FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'dd')
							,[LastUpdatedByRef] = @CurrentUserId
							,[MostRecentActionLkup]= @CurrentActionLkup
							,[IsCaseResolved]=@IsCaseResolved
							,[ResolvedByRef]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE @CurrentUserId END
							,[UTCResolvedOn]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE @CurrentUTCDate END
							,[UTCResolvedOnId]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE FORMAT(@CurrentUTCDate, 'yyyyMMdd') END
							,[UTCResolvedOnYear]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE FORMAT(@CurrentUTCDate, 'yyyy') END
							,[UTCResolvedOnMonth]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE FORMAT(@CurrentUTCDate, 'MM') END
							,[UTCResolvedOnDay]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE FORMAT(@CurrentUTCDate, 'dd') END
							,[CSTResolvedOn]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE DATEADD(hh, -6, @CurrentUTCDate) END
							,[CSTResolvedOnId]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'yyyyMMdd') END
							,[CSTResolvedOnYear]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'yyyy') END
							,[CSTResolvedOnMonth]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'MM') END
							,[CSTResolvedOnDay]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'dd') END
							,[TRCLkup]= @TRCLkup
						Where GEN_QueueId = @GEN_QueueId

						--Update GEN_OSTActions
						If EXISTS (Select 1 From GEN_OSTActions Where GEN_QueueRef = @GEN_QueueId)
						BEGIN
							Update GEN_OSTActions Set ActionLkup = @CurrentActionLkup, ResolutionLkup = @CurrentResolutionLkup, UTCLastUpdatedOn = @CurrentUTCDate, LastUpdatedByRef = @CurrentUserId Where GEN_QueueRef = @GEN_QueueId
						END
						ELSE
						BEGIN
							INSERT INTO [dbo].[GEN_OSTActions]
										([GEN_QueueRef],[ActionLkup],[LastName],[DateofBirth],[ContractIDLkup],[PBPLkup],[ApplicationDate],[EffectiveDate],
										[EndDate],[FirstLetterMailDate],[SecondLetterMailDate],[ResidentialDocumentationRequired],[CountyAttestationRequired],
										[PendReasonLkup],[ContainsErrorsLkup],[ResolutionLkup],[Reason],[InitialAddressVerificationDate],
										[MemberResponseVerificationDate],[MemberVerifiedState],[SCCLetterMailDate],[IsActive],[UTCCreatedOn],[CreatedByRef],
										[UTCLastUpdatedOn],[LastUpdatedByRef])
								VALUES  (@GEN_QueueId,@CurrentActionLkup,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,@CurrentResolutionLkup,NULL,NULL,
										NULL,NULL,NULL,1,@CurrentUTCDate,@CurrentUserId,@CurrentUTCDate,@CurrentUserId)
						END

						--Add Comments
						INSERT INTO [dbo].[GEN_Comments]
									([GEN_QueueRef],[Comments],[ActionLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef],[SourceSystemLkup])
						VALUES      (@GEN_QueueId,@AuditDescption,@CurrentActionLkup,1,@CurrentUTCDate,@CurrentUserId,@CurrentUTCDate,@CurrentUserId,@SSLkup)

						--Add Workflow
						INSERT INTO [dbo].[GEN_QueueWorkFlowCorrelation]
									([GEN_QueueRef],[RoleLkup],[WorkBasketLkup],[DiscrepancyCategoryLkup],[PreviousActionLkup],[PreviousWorkQueuesLkup],
										[PreviousStatusLkup],[CurrentActionLkup],[CurrentWorkQueuesLkup],[CurrentStatusLkup],[IsActive],[UTCCreatedOn],
										[CreatedByRef])
						VALUES		(@GEN_QueueId,2001,3001,@DiscpCat,@PreviousActionLkup,@PreviousWQLkup,@PreviousStsLkup,@CurrentActionLkup,@CurrentWorkQueuesLkup,@CurrentStatusLkup,1,@CurrentUTCDate,@CurrentUserId)

						--Add ManageCases for Action performed
						INSERT INTO [dbo].[GEN_ManageCases]([GEN_QueueRef],[ActionPerformedLkup],[CurrentUserRef],[CasesComments],[ReAssignUserRef],[IsActive],[UTCCreatedOn],
										[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef])
								VALUES  (@GEN_QueueId,@CurrentActionLkup,@CurrentUserId,NULL,NULL,1,@CurrentUTCDate,@CurrentUserId,@CurrentUTCDate,@CurrentUserId)
		
						IF(@ClosedQueueIdForReference > 0 AND @DiscpCat <> 6003)
						BEGIN
							Set @GEN_QueueId = 0

							SET @CurrentActionLkup = 28063			--Action : TRC 154:76 Received
							SET @CurrentWorkQueuesLkup = 10046		--TRR - TRC 154:76
							SET @CurrentStatusLkup = 20001			--NEW

							SET @AuditDescption = 'TRC Code – '+cast(@TRCCode as varchar(5))+' is received and route the case to CMS TRC 154:76 queue with status NEW'

							EXEC [USP_APP_INS_CreateSuspectCase] @BusinessSegmentLkup = 1001, @WorkBasketLkup = 3001, @DiscrepancyCategoryLkup = 6003, @DiscrepancyTypeLkup = 7001,
							@MostRecentActionLkup = @CurrentActionLkup,@MostRecentWorkQueueLkup = @CurrentWorkQueuesLkup, @MostRecentStatusLkup = @CurrentStatusLkup, @SourceSystemLkup = @SSLkup, @DiscrepancySourceLkup = 13001, 
							@DiscrepancyReceiptDate = @CurrentUTCDate, @DiscrepancyReceiptDateId = @UTCDateId, @ComplianceStartDate = @FileReceiptDate,@ComplianceStartDateId = @ComplianceStartDateId,
							@DisenrollmentDate = @DisenrollDate, @MemberSCCCode = @SCCCode, @MemberCurrentHICN = @HICN, @GPSHouseholdID = @HouseHoldId,
							@MemberFirstName = @FirstName,@MemberLastName = @LastName, @MemberContractIDLkup = @Contract,@MemberPBPLkup = @PBP,@MemberLOBLkup = @LOB,
							@MemberDOB = @MemberDOB,@MemberDOBId = @MemberDOBId,@EligOOAFlagLkup = 0,@RPRCTMMember = 0,@RPREGHPMember = 0,@IsParentCase = 0,
							@IsChildCase = 1,@ParentQueueRef = @ClosedQueueIdForReference,@Comments = @AuditDescption,@RoleLkup = 2001,
							@CurrentActionLkup = @CurrentActionLkup,@CurrentWorkQueuesLkup = @CurrentWorkQueuesLkup,@CurrentStatusLkup = @CurrentStatusLkup,@LoginUserId = @CurrentUserId,
							@TRCLkup=@TRCLkup,@IsRestricted = @IsRestricted,@ErrorMessage = @ErrorMessage OUTPUT,@CommentsSourceSystemLkup = @SSLkup,@GEN_QueueId = @GEN_QueueId OUTPUT
						END

					END
					ELSE
					BEGIN
						IF(@DiscpType = 7001)  --OOA
						BEGIN
							IF(@DiscpCat = 6003)	--TRR
							BEGIN
								SET @CurrentActionLkup = 28001			--Add Comments
								SET @CurrentStatusLkup = 20002			--INPROGRESS

								SET @AuditDescption = 'TRC Code – '+cast(@TRCCode as varchar(5))+' is received and no new case is created on '+ CONVERT(varchar, @CurrentUTCDate,113) +' and Performed By as System: GPS  WQ'

								--Update queue with action (Add Comments)
								Update GEN_Queue 
								Set MostRecentStatusLkup = @CurrentStatusLkup
									--,MostRecentWorkQueueLkup = @PreviousWQLkup   ---Not required as for TRR record we are only adding a comment.
									,[UTCLastUpdatedOn]= @CurrentUTCDate
									,[UTCLastUpdatedOnId]= FORMAT(@CurrentUTCDate, 'yyyyMMdd')
									,[UTCLastUpdatedOnYear]= FORMAT(@CurrentUTCDate, 'yyyy')
									,[UTCLastUpdatedOnMonth]= FORMAT(@CurrentUTCDate, 'MM')
									,[UTCLastUpdatedOnDay]= FORMAT(@CurrentUTCDate, 'dd')
									,[CSTLastUpdatedOn]= DATEADD(hh, -6, @CurrentUTCDate)
									,[CSTLastUpdatedOnId]= FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'yyyyMMdd')
									,[CSTLastUpdatedOnYear]= FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'yyyy')
									,[CSTLastUpdatedOnMonth]= FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'MM')
									,[CSTLastUpdatedOnDay]= FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'dd')
									,[LastUpdatedByRef] = @CurrentUserId
									,[MostRecentActionLkup]= @CurrentActionLkup	
									,[TRCLkup]= @TRCLkup
								Where GEN_QueueId = @GEN_QueueId
				
								If EXISTS (Select 1 From GEN_OSTActions Where GEN_QueueRef = @GEN_QueueId)
								BEGIN
									Update GEN_OSTActions Set ActionLkup = @CurrentActionLkup, UTCLastUpdatedOn = @CurrentUTCDate, LastUpdatedByRef = @CurrentUserId Where GEN_QueueRef = @GEN_QueueId
								END
								ELSE
								BEGIN
									INSERT INTO [dbo].[GEN_OSTActions]
												([GEN_QueueRef],[ActionLkup],[LastName],[DateofBirth],[ContractIDLkup],[PBPLkup],[ApplicationDate],[EffectiveDate],
												[EndDate],[FirstLetterMailDate],[SecondLetterMailDate],[ResidentialDocumentationRequired],[CountyAttestationRequired],
												[PendReasonLkup],[ContainsErrorsLkup],[ResolutionLkup],[Reason],[InitialAddressVerificationDate],
												[MemberResponseVerificationDate],[MemberVerifiedState],[SCCLetterMailDate],[IsActive],[UTCCreatedOn],[CreatedByRef],
												[UTCLastUpdatedOn],[LastUpdatedByRef])
										VALUES  (@GEN_QueueId,@CurrentActionLkup,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,
												NULL,NULL,NULL,1,@CurrentUTCDate,@CurrentUserId,@CurrentUTCDate,@CurrentUserId)
								END	
						
								--Add Comments
								INSERT INTO [dbo].[GEN_Comments]
											([GEN_QueueRef],[Comments],[ActionLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef],[SourceSystemLkup])
								VALUES      (@GEN_QueueId,@AuditDescption,@CurrentActionLkup,1,@CurrentUTCDate,@CurrentUserId,@CurrentUTCDate,@CurrentUserId,@SSLkup)

								--Add Workflow
								INSERT INTO [dbo].[GEN_QueueWorkFlowCorrelation]
											([GEN_QueueRef],[RoleLkup],[WorkBasketLkup],[DiscrepancyCategoryLkup],[PreviousActionLkup],[PreviousWorkQueuesLkup],
												[PreviousStatusLkup],[CurrentActionLkup],[CurrentWorkQueuesLkup],[CurrentStatusLkup],[IsActive],[UTCCreatedOn],
												[CreatedByRef])
								VALUES		(@GEN_QueueId,2001,3001,@DiscpCat,@PreviousActionLkup,@PreviousWQLkup,@PreviousStsLkup,@CurrentActionLkup,@PreviousWQLkup,@CurrentStatusLkup,1,@CurrentUTCDate,@CurrentUserId)

								--Add ManageCases for Action performed
								INSERT INTO [dbo].[GEN_ManageCases]([GEN_QueueRef],[ActionPerformedLkup],[CurrentUserRef],[CasesComments],[ReAssignUserRef],[IsActive],[UTCCreatedOn],
											[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef])
									VALUES  (@GEN_QueueId,@CurrentActionLkup,@CurrentUserId,NULL,NULL,1,@CurrentUTCDate,@CurrentUserId,@CurrentUTCDate,@CurrentUserId)
							END
							ELSE
							BEGIN
								IF (@TRCTypeCode = '01')
								BEGIN
									IF(@DiscpCat = 6001) --OOA
									BEGIN
										
										IF(@PreviousWQLkup = 10007)
										BEGIN
											SET @CurrentActionLkup = 28015          --Action : Send OOA Letter
											SET @CurrentStatusLkup = 20002          --Inprogress
											SET @OOALetterStatusLkup = 53001        --Send OOA Letter Status - Ready

											SET @AuditDescption = 'TRC Code – '+cast(@TRCCode as varchar(5))+' is received and OOA Letter will be triggered.'
										END
										ELSE
										BEGIN	
											SET @CurrentActionLkup = 28001          --Action : Add Comments
											SET @CurrentStatusLkup = 20002          --Inprogress
											Select @OOALetterStatusLkup = OOALetterStatusLkup From GEN_Queue Where GEN_QueueId = @GEN_QueueId
											
											SET @AuditDescption = 'TRC Code – '+cast(@TRCCode as varchar(5))+' is received and no additional action is needed as member is already in OOA Tracking.'
										END		

									END

									--Update GEN_Queue
									Update GEN_Queue 
									Set MostRecentStatusLkup = @CurrentStatusLkup
										,[UTCLastUpdatedOn]= @CurrentUTCDate
										,[UTCLastUpdatedOnId]= FORMAT(@CurrentUTCDate, 'yyyyMMdd')
										,[UTCLastUpdatedOnYear]= FORMAT(@CurrentUTCDate, 'yyyy')
										,[UTCLastUpdatedOnMonth]= FORMAT(@CurrentUTCDate, 'MM')
										,[UTCLastUpdatedOnDay]= FORMAT(@CurrentUTCDate, 'dd')
										,[CSTLastUpdatedOn]= DATEADD(hh, -6, @CurrentUTCDate)
										,[CSTLastUpdatedOnId]= FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'yyyyMMdd')
										,[CSTLastUpdatedOnYear]= FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'yyyy')
										,[CSTLastUpdatedOnMonth]= FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'MM')
										,[CSTLastUpdatedOnDay]= FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'dd')
										,[LastUpdatedByRef] = @CurrentUserId
										,[MostRecentActionLkup]= @CurrentActionLkup 
										,[OOALetterStatusLkup] = @OOALetterStatusLkup
										,[TRCLkup]= @TRCLkup
									Where GEN_QueueId = @GEN_QueueId

									--Update GEN_OSTActions
									If EXISTS (Select 1 From GEN_OSTActions Where GEN_QueueRef = @GEN_QueueId)
									BEGIN
										Update GEN_OSTActions Set ActionLkup = @CurrentActionLkup, UTCLastUpdatedOn = @CurrentUTCDate, LastUpdatedByRef = @CurrentUserId Where GEN_QueueRef = @GEN_QueueId
									END
									ELSE
									BEGIN
										INSERT INTO [dbo].[GEN_OSTActions]
																([GEN_QueueRef],[ActionLkup],[LastName],[DateofBirth],[ContractIDLkup],[PBPLkup],[ApplicationDate],[EffectiveDate],
																[EndDate],[FirstLetterMailDate],[SecondLetterMailDate],[ResidentialDocumentationRequired],[CountyAttestationRequired],
																[PendReasonLkup],[ContainsErrorsLkup],[ResolutionLkup],[Reason],[InitialAddressVerificationDate],
																[MemberResponseVerificationDate],[MemberVerifiedState],[SCCLetterMailDate],[IsActive],[UTCCreatedOn],[CreatedByRef],
																[UTCLastUpdatedOn],[LastUpdatedByRef])
												VALUES  (@GEN_QueueId,@CurrentActionLkup,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,
																NULL,NULL,NULL,1,@CurrentUTCDate,@CurrentUserId,@CurrentUTCDate,@CurrentUserId)
									END

									--Add Comments
									INSERT INTO [dbo].[GEN_Comments]
												([GEN_QueueRef],[Comments],[ActionLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef],[SourceSystemLkup])
									VALUES      (@GEN_QueueId,@AuditDescption,@CurrentActionLkup,1,@CurrentUTCDate,@CurrentUserId,@CurrentUTCDate,@CurrentUserId,@SSLkup)

									--Add Workflow
									INSERT INTO [dbo].[GEN_QueueWorkFlowCorrelation]
													([GEN_QueueRef],[RoleLkup],[WorkBasketLkup],[DiscrepancyCategoryLkup],[PreviousActionLkup],[PreviousWorkQueuesLkup],
													[PreviousStatusLkup],[CurrentActionLkup],[CurrentWorkQueuesLkup],[CurrentStatusLkup],[IsActive],[UTCCreatedOn],
													[CreatedByRef])
									VALUES        (@GEN_QueueId,2001,3001,@DiscpCat,@PreviousActionLkup,@PreviousWQLkup,@PreviousStsLkup,@CurrentActionLkup,@PreviousWQLkup,@CurrentStatusLkup,1,@CurrentUTCDate,@CurrentUserId)

									--Add ManageCases for Action performed
									INSERT INTO [dbo].[GEN_ManageCases]([GEN_QueueRef],[ActionPerformedLkup],[CurrentUserRef],[CasesComments],[ReAssignUserRef],[IsActive],[UTCCreatedOn],
														[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef])
									VALUES  (@GEN_QueueId,@CurrentActionLkup,@CurrentUserId,NULL,NULL,1,@CurrentUTCDate,@CurrentUserId,@CurrentUTCDate,@CurrentUserId)
								END
								ELSE
								BEGIN
									IF(@DiscpCat = 6001)	--OOA
									BEGIN
										SET @CurrentActionLkup = 28002			--Action - Close Case				
										SET @CurrentWorkQueuesLkup = 10004		--OOA Completed
										SET @CurrentStatusLkup = 20003			--Resolve Completed
										SET @CurrentResolutionLkup = 18037		--Resolution - New Discrepancy

										SET @AuditDescption = 'TRC Code – '+cast(@TRCCode as varchar(5))+' is received, closing OOA Case'
										SET @IsCaseResolved = 1
									END

									--ELSE IF(@DiscpCat = 6002)	--SCC
									--BEGIN
									--  SET @CurrentActionLkup = 28002			--Action - Close Case		
									--	SET @CurrentWorkQueuesLkup = 10019		--SCC Completed
									--	SET @CurrentStatusLkup = 20003			--Resolve Completed
									--  SET @CurrentResolutionLkup = 18037		--Resolution - New Discrepancy

									--	SET @AuditDescption = 'TRC Code – '+cast(@TRCCode as varchar(5))+' is received, closing SCC case'
									--	SET @IsCaseResolved = 1
									--END

									Set @ClosedQueueIdForReference = @GEN_QueueId

									--Update GEN_Queue
									Update GEN_Queue 
									Set MostRecentStatusLkup = @CurrentStatusLkup
										,MostRecentWorkQueueLkup = @CurrentWorkQueuesLkup
										,[UTCLastUpdatedOn]= @CurrentUTCDate
										,[UTCLastUpdatedOnId]= FORMAT(@CurrentUTCDate, 'yyyyMMdd')
										,[UTCLastUpdatedOnYear]= FORMAT(@CurrentUTCDate, 'yyyy')
										,[UTCLastUpdatedOnMonth]= FORMAT(@CurrentUTCDate, 'MM')
										,[UTCLastUpdatedOnDay]= FORMAT(@CurrentUTCDate, 'dd')
										,[CSTLastUpdatedOn]= DATEADD(hh, -6, @CurrentUTCDate)
										,[CSTLastUpdatedOnId]= FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'yyyyMMdd')
										,[CSTLastUpdatedOnYear]= FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'yyyy')
										,[CSTLastUpdatedOnMonth]= FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'MM')
										,[CSTLastUpdatedOnDay]= FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'dd')
										,[LastUpdatedByRef] = @CurrentUserId
										,[MostRecentActionLkup]= @CurrentActionLkup
										,[IsCaseResolved]=@IsCaseResolved
										,[ResolvedByRef]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE @CurrentUserId END
										,[UTCResolvedOn]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE @CurrentUTCDate END
										,[UTCResolvedOnId]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE FORMAT(@CurrentUTCDate, 'yyyyMMdd') END
										,[UTCResolvedOnYear]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE FORMAT(@CurrentUTCDate, 'yyyy') END
										,[UTCResolvedOnMonth]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE FORMAT(@CurrentUTCDate, 'MM') END
										,[UTCResolvedOnDay]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE FORMAT(@CurrentUTCDate, 'dd') END
										,[CSTResolvedOn]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE DATEADD(hh, -6, @CurrentUTCDate) END
										,[CSTResolvedOnId]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'yyyyMMdd') END
										,[CSTResolvedOnYear]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'yyyy') END
										,[CSTResolvedOnMonth]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'MM') END
										,[CSTResolvedOnDay]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'dd') END
										,[TRCLkup]= @TRCLkup
									Where GEN_QueueId = @GEN_QueueId

									--Update GEN_OSTActions
									If EXISTS (Select 1 From GEN_OSTActions Where GEN_QueueRef = @GEN_QueueId)
									BEGIN
										Update GEN_OSTActions Set ActionLkup = @CurrentActionLkup, ResolutionLkup = @CurrentResolutionLkup, UTCLastUpdatedOn = @CurrentUTCDate, LastUpdatedByRef = @CurrentUserId Where GEN_QueueRef = @GEN_QueueId
									END
									ELSE
									BEGIN
										INSERT INTO [dbo].[GEN_OSTActions]
													([GEN_QueueRef],[ActionLkup],[LastName],[DateofBirth],[ContractIDLkup],[PBPLkup],[ApplicationDate],[EffectiveDate],
													[EndDate],[FirstLetterMailDate],[SecondLetterMailDate],[ResidentialDocumentationRequired],[CountyAttestationRequired],
													[PendReasonLkup],[ContainsErrorsLkup],[ResolutionLkup],[Reason],[InitialAddressVerificationDate],
													[MemberResponseVerificationDate],[MemberVerifiedState],[SCCLetterMailDate],[IsActive],[UTCCreatedOn],[CreatedByRef],
													[UTCLastUpdatedOn],[LastUpdatedByRef])
											VALUES  (@GEN_QueueId,@CurrentActionLkup,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,@CurrentResolutionLkup,NULL,NULL,
													NULL,NULL,NULL,1,@CurrentUTCDate,@CurrentUserId,@CurrentUTCDate,@CurrentUserId)
									END

									--Add Comments
									INSERT INTO [dbo].[GEN_Comments]
												([GEN_QueueRef],[Comments],[ActionLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef],[SourceSystemLkup])
									VALUES      (@GEN_QueueId,@AuditDescption,@CurrentActionLkup,1,@CurrentUTCDate,@CurrentUserId,@CurrentUTCDate,@CurrentUserId,@SSLkup)

									--Add Workflow
									INSERT INTO [dbo].[GEN_QueueWorkFlowCorrelation]
												([GEN_QueueRef],[RoleLkup],[WorkBasketLkup],[DiscrepancyCategoryLkup],[PreviousActionLkup],[PreviousWorkQueuesLkup],
													[PreviousStatusLkup],[CurrentActionLkup],[CurrentWorkQueuesLkup],[CurrentStatusLkup],[IsActive],[UTCCreatedOn],
													[CreatedByRef])
									VALUES		(@GEN_QueueId,2001,3001,@DiscpCat,@PreviousActionLkup,@PreviousWQLkup,@PreviousStsLkup,@CurrentActionLkup,@CurrentWorkQueuesLkup,@CurrentStatusLkup,1,@CurrentUTCDate,@CurrentUserId)

									--Add ManageCases for Action performed
									INSERT INTO [dbo].[GEN_ManageCases]([GEN_QueueRef],[ActionPerformedLkup],[CurrentUserRef],[CasesComments],[ReAssignUserRef],[IsActive],[UTCCreatedOn],
													[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef])
											VALUES  (@GEN_QueueId,@CurrentActionLkup,@CurrentUserId,NULL,NULL,1,@CurrentUTCDate,@CurrentUserId,@CurrentUTCDate,@CurrentUserId)

									IF(@ClosedQueueIdForReference > 0)
									BEGIN
										Set @GEN_QueueId = 0
								
										SET @CurrentActionLkup = 28062			--Escalated Action
										SET @CurrentWorkQueuesLkup = 10037		--TRR - Escalated
										SET @CurrentStatusLkup = 20001			--NEW

										SET @AuditDescption = 'TRC Code – '+cast(@TRCCode as varchar(5))+' is received. A new case has been created and routed to Escalation queue with status NEW (Existing OOA case closed, Type Code is not 01)'

										EXEC [USP_APP_INS_CreateSuspectCase] @BusinessSegmentLkup = 1001, @WorkBasketLkup = 3001, @DiscrepancyCategoryLkup = 6003, @DiscrepancyTypeLkup = 7001,
										@MostRecentActionLkup = @CurrentActionLkup,@MostRecentWorkQueueLkup = @CurrentWorkQueuesLkup, @MostRecentStatusLkup = @CurrentStatusLkup, @SourceSystemLkup = @SSLkup, @DiscrepancySourceLkup = 13001, 
										@DiscrepancyReceiptDate = @CurrentUTCDate, @DiscrepancyReceiptDateId = @UTCDateId, @ComplianceStartDate = @FileReceiptDate,@ComplianceStartDateId = @ComplianceStartDateId,
										@DisenrollmentDate = @DisenrollDate, @MemberSCCCode = @SCCCode, @MemberCurrentHICN = @HICN, @GPSHouseholdID = @HouseHoldId,
										@MemberFirstName = @FirstName,@MemberLastName = @LastName, @MemberContractIDLkup = @Contract,@MemberPBPLkup = @PBP,@MemberLOBLkup = @LOB,
										@MemberDOB = @MemberDOB,@MemberDOBId = @MemberDOBId,@EligOOAFlagLkup = 0,@RPRCTMMember = 0,@RPREGHPMember = 0,@IsParentCase = 0,
										@IsChildCase = 1,@ParentQueueRef = @ClosedQueueIdForReference,@Comments = @AuditDescption,@RoleLkup = 2001,
										@CurrentActionLkup = @CurrentActionLkup,@CurrentWorkQueuesLkup = @CurrentWorkQueuesLkup,@CurrentStatusLkup = @CurrentStatusLkup,@LoginUserId = @CurrentUserId,
										@TRCLkup=@TRCLkup,@IsRestricted = @IsRestricted,@ErrorMessage = @ErrorMessage OUTPUT,@CommentsSourceSystemLkup = @SSLkup,@GEN_QueueId = @GEN_QueueId OUTPUT
									END
								END						
							END
						END
						ELSE IF(@DiscpType = 7002)   --InArea
						BEGIN
							IF(@DiscpCat = 6003)	--TRR
							BEGIN
								IF (@TRCTypeCode = '01')
								BEGIN
									SET @CurrentActionLkup = 28002			--Action - Close Case				
									SET @CurrentWorkQueuesLkup = 10036		--TRR Completed
									SET @CurrentStatusLkup = 20003			--Resolve Completed
									SET @CurrentResolutionLkup = 18037		--Resolution - New Discrepancy

									SET @AuditDescption = 'TRC Code – '+cast(@TRCCode as varchar(5))+' is received, closing TRR Case'
									SET @IsCaseResolved = 1

									Set @ClosedQueueIdForReference = @GEN_QueueId

									--Update GEN_Queue
									Update GEN_Queue 
									Set MostRecentStatusLkup = @CurrentStatusLkup
										,MostRecentWorkQueueLkup = @CurrentWorkQueuesLkup
										,[UTCLastUpdatedOn]= @CurrentUTCDate
										,[UTCLastUpdatedOnId]= FORMAT(@CurrentUTCDate, 'yyyyMMdd')
										,[UTCLastUpdatedOnYear]= FORMAT(@CurrentUTCDate, 'yyyy')
										,[UTCLastUpdatedOnMonth]= FORMAT(@CurrentUTCDate, 'MM')
										,[UTCLastUpdatedOnDay]= FORMAT(@CurrentUTCDate, 'dd')
										,[CSTLastUpdatedOn]= DATEADD(hh, -6, @CurrentUTCDate)
										,[CSTLastUpdatedOnId]= FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'yyyyMMdd')
										,[CSTLastUpdatedOnYear]= FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'yyyy')
										,[CSTLastUpdatedOnMonth]= FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'MM')
										,[CSTLastUpdatedOnDay]= FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'dd')
										,[LastUpdatedByRef] = @CurrentUserId
										,[MostRecentActionLkup]= @CurrentActionLkup
										,[IsCaseResolved]=@IsCaseResolved
										,[ResolvedByRef]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE @CurrentUserId END
										,[UTCResolvedOn]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE @CurrentUTCDate END
										,[UTCResolvedOnId]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE FORMAT(@CurrentUTCDate, 'yyyyMMdd') END
										,[UTCResolvedOnYear]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE FORMAT(@CurrentUTCDate, 'yyyy') END
										,[UTCResolvedOnMonth]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE FORMAT(@CurrentUTCDate, 'MM') END
										,[UTCResolvedOnDay]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE FORMAT(@CurrentUTCDate, 'dd') END
										,[CSTResolvedOn]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE DATEADD(hh, -6, @CurrentUTCDate) END
										,[CSTResolvedOnId]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'yyyyMMdd') END
										,[CSTResolvedOnYear]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'yyyy') END
										,[CSTResolvedOnMonth]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'MM') END
										,[CSTResolvedOnDay]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'dd') END
										,[TRCLkup]= @TRCLkup
									Where GEN_QueueId = @GEN_QueueId

									--Update GEN_OSTActions
									If EXISTS (Select 1 From GEN_OSTActions Where GEN_QueueRef = @GEN_QueueId)
									BEGIN
										Update GEN_OSTActions Set ActionLkup = @CurrentActionLkup, ResolutionLkup = @CurrentResolutionLkup, UTCLastUpdatedOn = @CurrentUTCDate, LastUpdatedByRef = @CurrentUserId Where GEN_QueueRef = @GEN_QueueId
									END
									ELSE
									BEGIN
										INSERT INTO [dbo].[GEN_OSTActions]
													([GEN_QueueRef],[ActionLkup],[LastName],[DateofBirth],[ContractIDLkup],[PBPLkup],[ApplicationDate],[EffectiveDate],
													[EndDate],[FirstLetterMailDate],[SecondLetterMailDate],[ResidentialDocumentationRequired],[CountyAttestationRequired],
													[PendReasonLkup],[ContainsErrorsLkup],[ResolutionLkup],[Reason],[InitialAddressVerificationDate],
													[MemberResponseVerificationDate],[MemberVerifiedState],[SCCLetterMailDate],[IsActive],[UTCCreatedOn],[CreatedByRef],
													[UTCLastUpdatedOn],[LastUpdatedByRef])
											VALUES  (@GEN_QueueId,@CurrentActionLkup,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,@CurrentResolutionLkup,NULL,NULL,
													NULL,NULL,NULL,1,@CurrentUTCDate,@CurrentUserId,@CurrentUTCDate,@CurrentUserId)
									END

									--Add Comments
									INSERT INTO [dbo].[GEN_Comments]
												([GEN_QueueRef],[Comments],[ActionLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef],[SourceSystemLkup])
									VALUES      (@GEN_QueueId,@AuditDescption,@CurrentActionLkup,1,@CurrentUTCDate,@CurrentUserId,@CurrentUTCDate,@CurrentUserId,@SSLkup)

									--Add Workflow
									INSERT INTO [dbo].[GEN_QueueWorkFlowCorrelation]
												([GEN_QueueRef],[RoleLkup],[WorkBasketLkup],[DiscrepancyCategoryLkup],[PreviousActionLkup],[PreviousWorkQueuesLkup],
													[PreviousStatusLkup],[CurrentActionLkup],[CurrentWorkQueuesLkup],[CurrentStatusLkup],[IsActive],[UTCCreatedOn],
													[CreatedByRef])
									VALUES		(@GEN_QueueId,2001,3001,@DiscpCat,@PreviousActionLkup,@PreviousWQLkup,@PreviousStsLkup,@CurrentActionLkup,@CurrentWorkQueuesLkup,@CurrentStatusLkup,1,@CurrentUTCDate,@CurrentUserId)

									--Add ManageCases for Action performed
									INSERT INTO [dbo].[GEN_ManageCases]([GEN_QueueRef],[ActionPerformedLkup],[CurrentUserRef],[CasesComments],[ReAssignUserRef],[IsActive],[UTCCreatedOn],
													[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef])
											VALUES  (@GEN_QueueId,@CurrentActionLkup,@CurrentUserId,NULL,NULL,1,@CurrentUTCDate,@CurrentUserId,@CurrentUTCDate,@CurrentUserId)

									IF(@ClosedQueueIdForReference > 0)
									BEGIN
										Set @GEN_QueueId = 0
								
										SET @CurrentActionLkup = 28015			--Action : Send OOA Letter
										SET @CurrentWorkQueuesLkup = 10007		--OOA - New Case
										SET @CurrentStatusLkup = 20001			--NEW
										SET @OOALetterStatusLkup = 53001        --Send OOA Letter Status - Ready

										SET @AuditDescption = 'TRC Code – '+cast(@TRCCode as varchar(5))+' is received and OOA Letter will be triggered.'

										EXEC [USP_APP_INS_CreateSuspectCase] @BusinessSegmentLkup = 1001, @WorkBasketLkup = 3001, @DiscrepancyCategoryLkup = 6001, @DiscrepancyTypeLkup = 7001,
										@MostRecentActionLkup = @CurrentActionLkup,@MostRecentWorkQueueLkup = @CurrentWorkQueuesLkup, @MostRecentStatusLkup = @CurrentStatusLkup, @SourceSystemLkup = @SSLkup, @DiscrepancySourceLkup = 13001, 
										@DiscrepancyReceiptDate = @CurrentUTCDate, @DiscrepancyReceiptDateId = @UTCDateId, @ComplianceStartDate = @FileReceiptDate,@ComplianceStartDateId = @ComplianceStartDateId,
										@DisenrollmentDate = @DisenrollDate, @MemberSCCCode = @SCCCode, @MemberCurrentHICN = @HICN, @GPSHouseholdID = @HouseHoldId,
										@MemberFirstName = @FirstName,@MemberLastName = @LastName, @MemberContractIDLkup = @Contract,@MemberPBPLkup = @PBP,@MemberLOBLkup = @LOB,
										@MemberDOB = @MemberDOB,@MemberDOBId = @MemberDOBId,@EligOOAFlagLkup = 0,@RPRCTMMember = 0,@RPREGHPMember = 0,@IsParentCase = 0,
										@IsChildCase = 1,@ParentQueueRef = @ClosedQueueIdForReference,@Comments = @AuditDescption,@RoleLkup = 2001,
										@CurrentActionLkup = @CurrentActionLkup,@CurrentWorkQueuesLkup = @CurrentWorkQueuesLkup,@CurrentStatusLkup = @CurrentStatusLkup,@LoginUserId = @CurrentUserId,
										@OOALetterStatusLkup = @OOALetterStatusLkup,@TRCLkup=@TRCLkup,@IsRestricted = @IsRestricted,
										@ErrorMessage = @ErrorMessage OUTPUT,@CommentsSourceSystemLkup = @SSLkup,@GEN_QueueId = @GEN_QueueId OUTPUT
									END
								END
								ELSE
								BEGIN
									SET @CurrentActionLkup = 28062			--Escalated Action
									SET @CurrentWorkQueuesLkup = 10037		--TRR - Escalated
									SET @CurrentStatusLkup = 20002			--INPROGRESS

									SET @AuditDescption = 'TRC Code – '+cast(@TRCCode as varchar(5))+' is received and routed to the Escalation queue (Type Code is not 01)'

									--Update queue with action (Add Comments)
									Update GEN_Queue 
									Set MostRecentStatusLkup = @CurrentStatusLkup
										,MostRecentWorkQueueLkup = @CurrentWorkQueuesLkup
										,[UTCLastUpdatedOn]= @CurrentUTCDate
										,[UTCLastUpdatedOnId]= FORMAT(@CurrentUTCDate, 'yyyyMMdd')
										,[UTCLastUpdatedOnYear]= FORMAT(@CurrentUTCDate, 'yyyy')
										,[UTCLastUpdatedOnMonth]= FORMAT(@CurrentUTCDate, 'MM')
										,[UTCLastUpdatedOnDay]= FORMAT(@CurrentUTCDate, 'dd')
										,[CSTLastUpdatedOn]= DATEADD(hh, -6, @CurrentUTCDate)
										,[CSTLastUpdatedOnId]= FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'yyyyMMdd')
										,[CSTLastUpdatedOnYear]= FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'yyyy')
										,[CSTLastUpdatedOnMonth]= FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'MM')
										,[CSTLastUpdatedOnDay]= FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'dd')
										,[LastUpdatedByRef] = @CurrentUserId
										,[MostRecentActionLkup]= @CurrentActionLkup	
										,[TRCLkup]= @TRCLkup
									Where GEN_QueueId = @GEN_QueueId
					
									--Update Actions
									If EXISTS (Select 1 From GEN_OSTActions Where GEN_QueueRef = @GEN_QueueId)
									BEGIN
										Update GEN_OSTActions 
										Set ActionLkup = @CurrentActionLkup, UTCLastUpdatedOn = @CurrentUTCDate, LastUpdatedByRef = @CurrentUserId 
										Where GEN_QueueRef = @GEN_QueueId
									END
									ELSE
									BEGIN
										INSERT INTO [dbo].[GEN_OSTActions]
													([GEN_QueueRef],[ActionLkup],[LastName],[DateofBirth],[ContractIDLkup],[PBPLkup],[ApplicationDate],[EffectiveDate],
													[EndDate],[FirstLetterMailDate],[SecondLetterMailDate],[ResidentialDocumentationRequired],[CountyAttestationRequired],
													[PendReasonLkup],[ContainsErrorsLkup],[ResolutionLkup],[Reason],[InitialAddressVerificationDate],
													[MemberResponseVerificationDate],[MemberVerifiedState],[SCCLetterMailDate],[IsActive],[UTCCreatedOn],[CreatedByRef],
													[UTCLastUpdatedOn],[LastUpdatedByRef])
											VALUES  (@GEN_QueueId,@CurrentActionLkup,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,
													NULL,NULL,NULL,1,@CurrentUTCDate,@CurrentUserId,@CurrentUTCDate,@CurrentUserId)
									END

									--Add Comments
									INSERT INTO [dbo].[GEN_Comments]
												([GEN_QueueRef],[Comments],[ActionLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef],[SourceSystemLkup])
									VALUES      (@GEN_QueueId,@AuditDescption,@CurrentActionLkup,1,@CurrentUTCDate,@CurrentUserId,@CurrentUTCDate,@CurrentUserId,@SSLkup)

									--Add Workflow
									INSERT INTO [dbo].[GEN_QueueWorkFlowCorrelation]
												([GEN_QueueRef],[RoleLkup],[WorkBasketLkup],[DiscrepancyCategoryLkup],[PreviousActionLkup],[PreviousWorkQueuesLkup],
													[PreviousStatusLkup],[CurrentActionLkup],[CurrentWorkQueuesLkup],[CurrentStatusLkup],[IsActive],[UTCCreatedOn],
													[CreatedByRef])
									VALUES		(@GEN_QueueId,2001,3001,@DiscpCat,@PreviousActionLkup,@PreviousWQLkup,@PreviousStsLkup,@CurrentActionLkup,@PreviousWQLkup,@CurrentStatusLkup,1,@CurrentUTCDate,@CurrentUserId)

									--Add ManageCases for Action performed
									INSERT INTO [dbo].[GEN_ManageCases]([GEN_QueueRef],[ActionPerformedLkup],[CurrentUserRef],[CasesComments],[ReAssignUserRef],[IsActive],[UTCCreatedOn],
												[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef])
										VALUES  (@GEN_QueueId,@CurrentActionLkup,@CurrentUserId,NULL,NULL,1,@CurrentUTCDate,@CurrentUserId,@CurrentUTCDate,@CurrentUserId)
									END						
							END
							ELSE
							BEGIN
								IF (@TRCTypeCode = '01')
								BEGIN
									IF(@DiscpCat = 6001) --OOA
									BEGIN
										
										IF(@PreviousWQLkup = 10007)
										BEGIN
											SET @CurrentActionLkup = 28015          --Action : Send OOA Letter
											SET @CurrentStatusLkup = 20002          --Inprogress
											SET @OOALetterStatusLkup = 53001        --Send OOA Letter Status - Ready

											SET @AuditDescption = 'TRC Code – '+cast(@TRCCode as varchar(5))+' is received and OOA Letter will be triggered.'
										END
										ELSE
										BEGIN
											SET @CurrentActionLkup = 28001          --Action : Add Comments
											SET @CurrentStatusLkup = 20002          --Inprogress
											Select @OOALetterStatusLkup = OOALetterStatusLkup From GEN_Queue Where GEN_QueueId = @GEN_QueueId
											
											SET @AuditDescption = 'TRC Code – '+cast(@TRCCode as varchar(5))+' is received and no additional action is needed as member is already in OOA Tracking.'
										END	

									END

									--Update GEN_Queue
									Update GEN_Queue 
									Set MostRecentStatusLkup = @CurrentStatusLkup
										,[UTCLastUpdatedOn]= @CurrentUTCDate
										,[UTCLastUpdatedOnId]= FORMAT(@CurrentUTCDate, 'yyyyMMdd')
										,[UTCLastUpdatedOnYear]= FORMAT(@CurrentUTCDate, 'yyyy')
										,[UTCLastUpdatedOnMonth]= FORMAT(@CurrentUTCDate, 'MM')
										,[UTCLastUpdatedOnDay]= FORMAT(@CurrentUTCDate, 'dd')
										,[CSTLastUpdatedOn]= DATEADD(hh, -6, @CurrentUTCDate)
										,[CSTLastUpdatedOnId]= FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'yyyyMMdd')
										,[CSTLastUpdatedOnYear]= FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'yyyy')
										,[CSTLastUpdatedOnMonth]= FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'MM')
										,[CSTLastUpdatedOnDay]= FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'dd')
										,[LastUpdatedByRef] = @CurrentUserId
										,[MostRecentActionLkup]= @CurrentActionLkup
										,[OOALetterStatusLkup] = @OOALetterStatusLkup
										,[TRCLkup]= @TRCLkup
									Where GEN_QueueId = @GEN_QueueId

									--Update GEN_OSTActions
									If EXISTS (Select 1 From GEN_OSTActions Where GEN_QueueRef = @GEN_QueueId)
									BEGIN
										Update GEN_OSTActions Set ActionLkup = @CurrentActionLkup, UTCLastUpdatedOn = @CurrentUTCDate, LastUpdatedByRef = @CurrentUserId Where GEN_QueueRef = @GEN_QueueId
									END
									ELSE
									BEGIN
										INSERT INTO [dbo].[GEN_OSTActions]
																([GEN_QueueRef],[ActionLkup],[LastName],[DateofBirth],[ContractIDLkup],[PBPLkup],[ApplicationDate],[EffectiveDate],
																[EndDate],[FirstLetterMailDate],[SecondLetterMailDate],[ResidentialDocumentationRequired],[CountyAttestationRequired],
																[PendReasonLkup],[ContainsErrorsLkup],[ResolutionLkup],[Reason],[InitialAddressVerificationDate],
																[MemberResponseVerificationDate],[MemberVerifiedState],[SCCLetterMailDate],[IsActive],[UTCCreatedOn],[CreatedByRef],
																[UTCLastUpdatedOn],[LastUpdatedByRef])
												VALUES  (@GEN_QueueId,@CurrentActionLkup,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,
																NULL,NULL,NULL,1,@CurrentUTCDate,@CurrentUserId,@CurrentUTCDate,@CurrentUserId)
									END

									--Add Comments
									INSERT INTO [dbo].[GEN_Comments]
												([GEN_QueueRef],[Comments],[ActionLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef],[SourceSystemLkup])
									VALUES      (@GEN_QueueId,@AuditDescption,@CurrentActionLkup,1,@CurrentUTCDate,@CurrentUserId,@CurrentUTCDate,@CurrentUserId,@SSLkup)

									--Add Workflow
									INSERT INTO [dbo].[GEN_QueueWorkFlowCorrelation]
													([GEN_QueueRef],[RoleLkup],[WorkBasketLkup],[DiscrepancyCategoryLkup],[PreviousActionLkup],[PreviousWorkQueuesLkup],
													[PreviousStatusLkup],[CurrentActionLkup],[CurrentWorkQueuesLkup],[CurrentStatusLkup],[IsActive],[UTCCreatedOn],
													[CreatedByRef])
									VALUES        (@GEN_QueueId,2001,3001,@DiscpCat,@PreviousActionLkup,@PreviousWQLkup,@PreviousStsLkup,@CurrentActionLkup,@PreviousWQLkup,@CurrentStatusLkup,1,@CurrentUTCDate,@CurrentUserId)

									--Add ManageCases for Action performed
									INSERT INTO [dbo].[GEN_ManageCases]([GEN_QueueRef],[ActionPerformedLkup],[CurrentUserRef],[CasesComments],[ReAssignUserRef],[IsActive],[UTCCreatedOn],
														[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef])
									VALUES  (@GEN_QueueId,@CurrentActionLkup,@CurrentUserId,NULL,NULL,1,@CurrentUTCDate,@CurrentUserId,@CurrentUTCDate,@CurrentUserId)
								END
								ELSE
								BEGIN
									IF(@DiscpCat = 6001)	--OOA
									BEGIN
										SET @CurrentActionLkup = 28002			--Action - Close Case				
										SET @CurrentWorkQueuesLkup = 10004		--OOA Completed
										SET @CurrentStatusLkup = 20003			--Resolve Completed
										SET @CurrentResolutionLkup = 18037		--Resolution - New Discrepancy

										SET @AuditDescption = 'TRC Code – '+cast(@TRCCode as varchar(5))+' is received, closing OOA Case'
										SET @IsCaseResolved = 1
									END

									--ELSE IF(@DiscpCat = 6002)	--SCC
									--BEGIN
									--  SET @CurrentActionLkup = 28002			--Action - Close Case		
									--	SET @CurrentWorkQueuesLkup = 10019		--SCC Completed
									--	SET @CurrentStatusLkup = 20003			--Resolve Completed
									--  SET @CurrentResolutionLkup = 18037		--Resolution - New Discrepancy

									--	SET @AuditDescption = 'TRC Code – '+cast(@TRCCode as varchar(5))+' is received, closing SCC case'
									--	SET @IsCaseResolved = 1
									--END

									Set @ClosedQueueIdForReference = @GEN_QueueId

									--Update GEN_Queue
									Update GEN_Queue 
									Set MostRecentStatusLkup = @CurrentStatusLkup
										,MostRecentWorkQueueLkup = @CurrentWorkQueuesLkup
										,[UTCLastUpdatedOn]= @CurrentUTCDate
										,[UTCLastUpdatedOnId]= FORMAT(@CurrentUTCDate, 'yyyyMMdd')
										,[UTCLastUpdatedOnYear]= FORMAT(@CurrentUTCDate, 'yyyy')
										,[UTCLastUpdatedOnMonth]= FORMAT(@CurrentUTCDate, 'MM')
										,[UTCLastUpdatedOnDay]= FORMAT(@CurrentUTCDate, 'dd')
										,[CSTLastUpdatedOn]= DATEADD(hh, -6, @CurrentUTCDate)
										,[CSTLastUpdatedOnId]= FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'yyyyMMdd')
										,[CSTLastUpdatedOnYear]= FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'yyyy')
										,[CSTLastUpdatedOnMonth]= FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'MM')
										,[CSTLastUpdatedOnDay]= FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'dd')
										,[LastUpdatedByRef] = @CurrentUserId
										,[MostRecentActionLkup]= @CurrentActionLkup
										,[IsCaseResolved]=@IsCaseResolved
										,[ResolvedByRef]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE @CurrentUserId END
										,[UTCResolvedOn]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE @CurrentUTCDate END
										,[UTCResolvedOnId]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE FORMAT(@CurrentUTCDate, 'yyyyMMdd') END
										,[UTCResolvedOnYear]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE FORMAT(@CurrentUTCDate, 'yyyy') END
										,[UTCResolvedOnMonth]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE FORMAT(@CurrentUTCDate, 'MM') END
										,[UTCResolvedOnDay]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE FORMAT(@CurrentUTCDate, 'dd') END
										,[CSTResolvedOn]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE DATEADD(hh, -6, @CurrentUTCDate) END
										,[CSTResolvedOnId]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'yyyyMMdd') END
										,[CSTResolvedOnYear]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'yyyy') END
										,[CSTResolvedOnMonth]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'MM') END
										,[CSTResolvedOnDay]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'dd') END
										,[TRCLkup]= @TRCLkup
									Where GEN_QueueId = @GEN_QueueId

									--Update GEN_OSTActions
									If EXISTS (Select 1 From GEN_OSTActions Where GEN_QueueRef = @GEN_QueueId)
									BEGIN
										Update GEN_OSTActions Set ActionLkup = @CurrentActionLkup, ResolutionLkup = @CurrentResolutionLkup, UTCLastUpdatedOn = @CurrentUTCDate, LastUpdatedByRef = @CurrentUserId Where GEN_QueueRef = @GEN_QueueId
									END
									ELSE
									BEGIN
										INSERT INTO [dbo].[GEN_OSTActions]
													([GEN_QueueRef],[ActionLkup],[LastName],[DateofBirth],[ContractIDLkup],[PBPLkup],[ApplicationDate],[EffectiveDate],
													[EndDate],[FirstLetterMailDate],[SecondLetterMailDate],[ResidentialDocumentationRequired],[CountyAttestationRequired],
													[PendReasonLkup],[ContainsErrorsLkup],[ResolutionLkup],[Reason],[InitialAddressVerificationDate],
													[MemberResponseVerificationDate],[MemberVerifiedState],[SCCLetterMailDate],[IsActive],[UTCCreatedOn],[CreatedByRef],
													[UTCLastUpdatedOn],[LastUpdatedByRef])
											VALUES  (@GEN_QueueId,@CurrentActionLkup,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,@CurrentResolutionLkup,NULL,NULL,
													NULL,NULL,NULL,1,@CurrentUTCDate,@CurrentUserId,@CurrentUTCDate,@CurrentUserId)
									END

									--Add Comments
									INSERT INTO [dbo].[GEN_Comments]
												([GEN_QueueRef],[Comments],[ActionLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef],[SourceSystemLkup])
									VALUES      (@GEN_QueueId,@AuditDescption,@CurrentActionLkup,1,@CurrentUTCDate,@CurrentUserId,@CurrentUTCDate,@CurrentUserId,@SSLkup)

									--Add Workflow
									INSERT INTO [dbo].[GEN_QueueWorkFlowCorrelation]
												([GEN_QueueRef],[RoleLkup],[WorkBasketLkup],[DiscrepancyCategoryLkup],[PreviousActionLkup],[PreviousWorkQueuesLkup],
													[PreviousStatusLkup],[CurrentActionLkup],[CurrentWorkQueuesLkup],[CurrentStatusLkup],[IsActive],[UTCCreatedOn],
													[CreatedByRef])
									VALUES		(@GEN_QueueId,2001,3001,@DiscpCat,@PreviousActionLkup,@PreviousWQLkup,@PreviousStsLkup,@CurrentActionLkup,@CurrentWorkQueuesLkup,@CurrentStatusLkup,1,@CurrentUTCDate,@CurrentUserId)

									--Add ManageCases for Action performed
									INSERT INTO [dbo].[GEN_ManageCases]([GEN_QueueRef],[ActionPerformedLkup],[CurrentUserRef],[CasesComments],[ReAssignUserRef],[IsActive],[UTCCreatedOn],
													[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef])
											VALUES  (@GEN_QueueId,@CurrentActionLkup,@CurrentUserId,NULL,NULL,1,@CurrentUTCDate,@CurrentUserId,@CurrentUTCDate,@CurrentUserId)

									IF(@ClosedQueueIdForReference > 0)
									BEGIN
										Set @GEN_QueueId = 0
								
										SET @CurrentActionLkup = 28062			--Escalated Action
										SET @CurrentWorkQueuesLkup = 10037		--TRR - Escalated
										SET @CurrentStatusLkup = 20001			--NEW

										SET @AuditDescption = 'TRC Code – '+cast(@TRCCode as varchar(5))+' is received. A new case has been created and routed to Escalation queue with status NEW (Existing OOA Case of Type In Area - Closed And type Code is not 01)'

										EXEC [USP_APP_INS_CreateSuspectCase] @BusinessSegmentLkup = 1001, @WorkBasketLkup = 3001, @DiscrepancyCategoryLkup = 6003, @DiscrepancyTypeLkup = 7001,
										@MostRecentActionLkup = @CurrentActionLkup,@MostRecentWorkQueueLkup = @CurrentWorkQueuesLkup, @MostRecentStatusLkup = @CurrentStatusLkup, @SourceSystemLkup = @SSLkup, @DiscrepancySourceLkup = 13001, 
										@DiscrepancyReceiptDate = @CurrentUTCDate, @DiscrepancyReceiptDateId = @UTCDateId, @ComplianceStartDate = @FileReceiptDate,@ComplianceStartDateId = @ComplianceStartDateId,
										@DisenrollmentDate = @DisenrollDate, @MemberSCCCode = @SCCCode, @MemberCurrentHICN = @HICN, @GPSHouseholdID = @HouseHoldId,
										@MemberFirstName = @FirstName,@MemberLastName = @LastName, @MemberContractIDLkup = @Contract,@MemberPBPLkup = @PBP,@MemberLOBLkup = @LOB,
										@MemberDOB = @MemberDOB,@MemberDOBId = @MemberDOBId,@EligOOAFlagLkup = 0,@RPRCTMMember = 0,@RPREGHPMember = 0,@IsParentCase = 0,
										@IsChildCase = 1,@ParentQueueRef = @ClosedQueueIdForReference,@Comments = @AuditDescption,@RoleLkup = 2001,
										@CurrentActionLkup = @CurrentActionLkup,@CurrentWorkQueuesLkup = @CurrentWorkQueuesLkup,@CurrentStatusLkup = @CurrentStatusLkup,@LoginUserId = @CurrentUserId,
										@TRCLkup=@TRCLkup,@IsRestricted = @IsRestricted,@ErrorMessage = @ErrorMessage OUTPUT,@CommentsSourceSystemLkup = @SSLkup,@GEN_QueueId = @GEN_QueueId OUTPUT
									END
								END
							END
						END
					END
				END
				ELSE
				BEGIN
					If (@PlanTerminationDate Is Not NULL And Convert(date,@PlanTerminationDate,101) <= Convert(date,GetUTCDate(),101))
					BEGIN
						SET @CurrentActionLkup = 28032			--Save
						SET @CurrentWorkQueuesLkup = 10046		--Queue - TRR - TRC 154:76
						SET @CurrentStatusLkup = 20001			--NEW

						SET @AuditDescption = 'TRC Code – '+cast(@TRCCode as varchar(5))+' is received. A new case is created on '+ CONVERT(varchar, @CurrentUTCDate,113) +' and Performed By as System: GPS  WQ'

						EXEC [USP_APP_INS_CreateSuspectCase] @BusinessSegmentLkup = 1001, @WorkBasketLkup = 3001, @DiscrepancyCategoryLkup = 6003, @DiscrepancyTypeLkup = 7001,
						@MostRecentActionLkup = @CurrentActionLkup,@MostRecentWorkQueueLkup = @CurrentWorkQueuesLkup, @MostRecentStatusLkup = @CurrentStatusLkup, @SourceSystemLkup = @SSLkup, @DiscrepancySourceLkup = 13001, 
						@DiscrepancyReceiptDate = @CurrentUTCDate, @DiscrepancyReceiptDateId = @UTCDateId, @ComplianceStartDate = @FileReceiptDate,@ComplianceStartDateId = @ComplianceStartDateId,
						@DisenrollmentDate = @DisenrollDate, @MemberSCCCode = @SCCCode, @MemberCurrentHICN = @HICN, @GPSHouseholdID = @HouseHoldId,
						@MemberFirstName = @FirstName,@MemberLastName = @LastName, @MemberContractIDLkup = @Contract,@MemberPBPLkup = @PBP,@MemberLOBLkup = @LOB,
						@MemberDOB = @MemberDOB,@MemberDOBId = @MemberDOBId,@EligOOAFlagLkup = 0,@RPRCTMMember = 0,@RPREGHPMember = 0,@IsParentCase = 0,
						@IsChildCase = 0,@Comments = @AuditDescption,@RoleLkup = 2001,@CurrentActionLkup = @CurrentActionLkup,
						@CurrentWorkQueuesLkup = @CurrentWorkQueuesLkup,@CurrentStatusLkup = @CurrentStatusLkup,@LoginUserId = @CurrentUserId,
						@TRCLkup=@TRCLkup,@IsRestricted = @IsRestricted,@ErrorMessage = @ErrorMessage OUTPUT,@CommentsSourceSystemLkup = @SSLkup,@GEN_QueueId = @GEN_QueueId OUTPUT

						Select @PreviousActionLkup= Q.MostRecentActionLkup, @PreviousWQLkup = Q.MostRecentWorkQueueLkup, @PreviousStsLkup = Q.MostRecentStatusLkup
						From GEN_Queue Q
						Where Q.IsActive = 1 And Q.LockedByRef Is NULL And GEN_QueueId = @GEN_QueueId

						IF EXISTS(Select 1 
									From MQTRRWorkQueueItems 
									Where (IsProcessed = 0 And CMN_BackgroundProcessMasterRef = @CMN_BackgroundProcessMasterRef And TRC In ('285', '018', '015', '014', '013') And TimelineEffectiveDate = @EffectiveDate  
										And [Contract] = @ContractValue And PBP = @PBPValue 
										AND CONVERT(varchar,UTCCreatedOn,101) >= Convert(varchar,GETUTcDate(),101) 
										And CONVERT(varchar,UTCCreatedOn,101) < Convert(varchar,DateAdd(dd,1,GETUTcDate()),101)) OR
										(IsProcessed = 0 And CMN_BackgroundProcessMasterRef = @CMN_BackgroundProcessMasterRef And TRC In ('100') And TRCTypeCode = '61' And TimelineEffectiveDate = @EffectiveDate 
										And ([Contract] <> @ContractValue Or PBP <> @PBPValue) 
										AND CONVERT(varchar,UTCCreatedOn,101) >= Convert(varchar,GETUTcDate(),101) 
										And CONVERT(varchar,UTCCreatedOn,101) < Convert(varchar,DateAdd(dd,1,GETUTcDate()),101)))
						BEGIN
							SET @CurrentActionLkup = 28002			--Close Case
							SET @CurrentWorkQueuesLkup = 10036		--TRR - Completed
							SET @CurrentStatusLkup = 20003			--RESOLVE COMPLETED
							SET @CurrentResolutionLkup = 18006		--Resolution - Close Case
							SET @IsCaseResolved = 1

							--Update Queue
							Update GEN_Queue 
							Set MostRecentStatusLkup = @CurrentStatusLkup
								,MostRecentWorkQueueLkup = @CurrentWorkQueuesLkup
								,[UTCLastUpdatedOn]= @CurrentUTCDate
								,[UTCLastUpdatedOnId]= FORMAT(@CurrentUTCDate, 'yyyyMMdd')
								,[UTCLastUpdatedOnYear]= FORMAT(@CurrentUTCDate, 'yyyy')
								,[UTCLastUpdatedOnMonth]= FORMAT(@CurrentUTCDate, 'MM')
								,[UTCLastUpdatedOnDay]= FORMAT(@CurrentUTCDate, 'dd')
								,[CSTLastUpdatedOn]= DATEADD(hh, -6, @CurrentUTCDate)
								,[CSTLastUpdatedOnId]= FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'yyyyMMdd')
								,[CSTLastUpdatedOnYear]= FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'yyyy')
								,[CSTLastUpdatedOnMonth]= FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'MM')
								,[CSTLastUpdatedOnDay]= FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'dd')
								,[LastUpdatedByRef] = @CurrentUserId
								,[MostRecentActionLkup]= @CurrentActionLkup
								,[IsCaseResolved]=@IsCaseResolved
								,[ResolvedByRef]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE @CurrentUserId END
								,[UTCResolvedOn]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE @CurrentUTCDate END
								,[UTCResolvedOnId]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE FORMAT(@CurrentUTCDate, 'yyyyMMdd') END
								,[UTCResolvedOnYear]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE FORMAT(@CurrentUTCDate, 'yyyy') END
								,[UTCResolvedOnMonth]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE FORMAT(@CurrentUTCDate, 'MM') END
								,[UTCResolvedOnDay]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE FORMAT(@CurrentUTCDate, 'dd') END
								,[CSTResolvedOn]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE DATEADD(hh, -6, @CurrentUTCDate) END
								,[CSTResolvedOnId]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'yyyyMMdd') END
								,[CSTResolvedOnYear]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'yyyy') END
								,[CSTResolvedOnMonth]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'MM') END
								,[CSTResolvedOnDay]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'dd') END
								,[TRCLkup]= @TRCLkup
							Where GEN_QueueId = @GEN_QueueId

							--Update GEN_OSTActions
							If EXISTS (Select 1 From GEN_OSTActions Where GEN_QueueRef = @GEN_QueueId)
							BEGIN
								Update GEN_OSTActions Set ActionLkup = @CurrentActionLkup, ResolutionLkup = @CurrentResolutionLkup, UTCLastUpdatedOn = @CurrentUTCDate, LastUpdatedByRef = @CurrentUserId Where GEN_QueueRef = @GEN_QueueId
							END
							ELSE
							BEGIN
								INSERT INTO [dbo].[GEN_OSTActions]
											([GEN_QueueRef],[ActionLkup],[LastName],[DateofBirth],[ContractIDLkup],[PBPLkup],[ApplicationDate],[EffectiveDate],
											[EndDate],[FirstLetterMailDate],[SecondLetterMailDate],[ResidentialDocumentationRequired],[CountyAttestationRequired],
											[PendReasonLkup],[ContainsErrorsLkup],[ResolutionLkup],[Reason],[InitialAddressVerificationDate],
											[MemberResponseVerificationDate],[MemberVerifiedState],[SCCLetterMailDate],[IsActive],[UTCCreatedOn],[CreatedByRef],
											[UTCLastUpdatedOn],[LastUpdatedByRef])
									VALUES  (@GEN_QueueId,@CurrentActionLkup,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,@CurrentResolutionLkup,NULL,NULL,
											NULL,NULL,NULL,1,@CurrentUTCDate,@CurrentUserId,@CurrentUTCDate,@CurrentUserId)
							END

							--Set Comments
							SET @AuditDescption = 'TRC Code – '+cast(@TRCCode as varchar(5))+' is received. Record status updated to Resolved-Completed and a GPS note was added on '+ CONVERT(varchar, @CurrentUTCDate,113) +''

							INSERT INTO [dbo].[GEN_Comments]
										([GEN_QueueRef],[Comments],[ActionLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef],[SourceSystemLkup])
							VALUES      (@GEN_QueueId,@AuditDescption,@CurrentActionLkup,1,@CurrentUTCDate,@CurrentUserId,@CurrentUTCDate,@CurrentUserId,@SSLkup)

							--Add Workflow
							INSERT INTO [dbo].[GEN_QueueWorkFlowCorrelation]
										([GEN_QueueRef],[RoleLkup],[WorkBasketLkup],[DiscrepancyCategoryLkup],[PreviousActionLkup],[PreviousWorkQueuesLkup],
											[PreviousStatusLkup],[CurrentActionLkup],[CurrentWorkQueuesLkup],[CurrentStatusLkup],[IsActive],[UTCCreatedOn],
											[CreatedByRef])
							VALUES		(@GEN_QueueId,2001,3001,@DiscpCat,@PreviousActionLkup,@PreviousWQLkup,@PreviousStsLkup,@CurrentActionLkup,@CurrentWorkQueuesLkup,@CurrentStatusLkup,1,@CurrentUTCDate,@CurrentUserId)

							--Add ManageCases for Action performed
							INSERT INTO [dbo].[GEN_ManageCases]([GEN_QueueRef],[ActionPerformedLkup],[CurrentUserRef],[CasesComments],[ReAssignUserRef],[IsActive],[UTCCreatedOn],
										[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef])
								VALUES  (@GEN_QueueId,@CurrentActionLkup,@CurrentUserId,NULL,NULL,1,@CurrentUTCDate,@CurrentUserId,@CurrentUTCDate,@CurrentUserId)
				
							--Need to enable this, because once a matching record processed, need to mark the filtered record also processed
							Update M 
							Set M.ProcessedGENQueueRef = @GEN_QueueId, M.IsProcessed = 1, M.UTCProcessedOn = @CurrentUTCDate, M.ProcessedByRef = @CurrentUserId, 
								M.UTCLastUpdatedOn = @CurrentUTCDate, M.UpdatedByRef = @CurrentUserId
							From MQTRRWorkQueueItems M 
							Where (IsProcessed = 0 And CMN_BackgroundProcessMasterRef = @CMN_BackgroundProcessMasterRef And TRC In ('285', '018', '015', '014', '013') And TimelineEffectiveDate = @EffectiveDate  
								And [Contract] = @ContractValue And PBP = @PBPValue 
								AND CONVERT(varchar,UTCCreatedOn,101) >= Convert(varchar,GETUTcDate(),101) 
								And CONVERT(varchar,UTCCreatedOn,101) < Convert(varchar,DateAdd(dd,1,GETUTcDate()),101)) OR
								(IsProcessed = 0 And CMN_BackgroundProcessMasterRef = @CMN_BackgroundProcessMasterRef And TRC In ('100') And TRCTypeCode = '61' And TimelineEffectiveDate = @EffectiveDate 
								And ([Contract] <> @ContractValue Or PBP <> @PBPValue) 
								AND CONVERT(varchar,UTCCreatedOn,101) >= Convert(varchar,GETUTcDate(),101) 
								And CONVERT(varchar,UTCCreatedOn,101) < Convert(varchar,DateAdd(dd,1,GETUTcDate()),101))
						END
						ELSE
						BEGIN
							SET @CurrentActionLkup = 28062			--Escalated Action
							SET @CurrentWorkQueuesLkup = 10037		--TRR - Escalated
							SET @CurrentStatusLkup = 20001			--NEW

							--Update Queue
							Update GEN_Queue 
							Set MostRecentStatusLkup = @CurrentStatusLkup
								,MostRecentWorkQueueLkup = @CurrentWorkQueuesLkup
								,[UTCLastUpdatedOn]= @CurrentUTCDate
								,[UTCLastUpdatedOnId]= FORMAT(@CurrentUTCDate, 'yyyyMMdd')
								,[UTCLastUpdatedOnYear]= FORMAT(@CurrentUTCDate, 'yyyy')
								,[UTCLastUpdatedOnMonth]= FORMAT(@CurrentUTCDate, 'MM')
								,[UTCLastUpdatedOnDay]= FORMAT(@CurrentUTCDate, 'dd')
								,[CSTLastUpdatedOn]= DATEADD(hh, -6, @CurrentUTCDate)
								,[CSTLastUpdatedOnId]= FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'yyyyMMdd')
								,[CSTLastUpdatedOnYear]= FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'yyyy')
								,[CSTLastUpdatedOnMonth]= FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'MM')
								,[CSTLastUpdatedOnDay]= FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'dd')
								,[LastUpdatedByRef] = @CurrentUserId
								,[MostRecentActionLkup]= @CurrentActionLkup
								,[TRCLkup]= @TRCLkup
							Where GEN_QueueId = @GEN_QueueId

							If EXISTS (Select 1 From GEN_OSTActions Where GEN_QueueRef = @GEN_QueueId)
							BEGIN
								Update GEN_OSTActions Set ActionLkup = @CurrentActionLkup, UTCLastUpdatedOn = @CurrentUTCDate, LastUpdatedByRef = @CurrentUserId Where GEN_QueueRef = @GEN_QueueId
							END
							ELSE
							BEGIN
								INSERT INTO [dbo].[GEN_OSTActions]
											([GEN_QueueRef],[ActionLkup],[LastName],[DateofBirth],[ContractIDLkup],[PBPLkup],[ApplicationDate],[EffectiveDate],
											[EndDate],[FirstLetterMailDate],[SecondLetterMailDate],[ResidentialDocumentationRequired],[CountyAttestationRequired],
											[PendReasonLkup],[ContainsErrorsLkup],[ResolutionLkup],[Reason],[InitialAddressVerificationDate],
											[MemberResponseVerificationDate],[MemberVerifiedState],[SCCLetterMailDate],[IsActive],[UTCCreatedOn],[CreatedByRef],
											[UTCLastUpdatedOn],[LastUpdatedByRef])
									VALUES  (@GEN_QueueId,@CurrentActionLkup,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,
											NULL,NULL,NULL,1,@CurrentUTCDate,@CurrentUserId,@CurrentUTCDate,@CurrentUserId)
							END

							--Set Comments
							SET @AuditDescption = 'TRC Code – '+cast(@TRCCode as varchar(5))+' is received, Escalating case because no active timeline exists in GPS'

							INSERT INTO [dbo].[GEN_Comments]
										([GEN_QueueRef],[Comments],[ActionLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef],[SourceSystemLkup])
							VALUES      (@GEN_QueueId,@AuditDescption,@CurrentActionLkup,1,@CurrentUTCDate,@CurrentUserId,@CurrentUTCDate,@CurrentUserId,@SSLkup)

							--Add Workflow
							INSERT INTO [dbo].[GEN_QueueWorkFlowCorrelation]
										([GEN_QueueRef],[RoleLkup],[WorkBasketLkup],[DiscrepancyCategoryLkup],[PreviousActionLkup],[PreviousWorkQueuesLkup],
											[PreviousStatusLkup],[CurrentActionLkup],[CurrentWorkQueuesLkup],[CurrentStatusLkup],[IsActive],[UTCCreatedOn],
											[CreatedByRef])
							VALUES		(@GEN_QueueId,2001,3001,@DiscpCat,@PreviousActionLkup,@PreviousWQLkup,@PreviousStsLkup,@CurrentActionLkup,@CurrentWorkQueuesLkup,@CurrentStatusLkup,1,@CurrentUTCDate,@CurrentUserId)

							--Add ManageCases for Action performed
							INSERT INTO [dbo].[GEN_ManageCases]([GEN_QueueRef],[ActionPerformedLkup],[CurrentUserRef],[CasesComments],[ReAssignUserRef],[IsActive],[UTCCreatedOn],
										[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef])
								VALUES  (@GEN_QueueId,@CurrentActionLkup,@CurrentUserId,NULL,NULL,1,@CurrentUTCDate,@CurrentUserId,@CurrentUTCDate,@CurrentUserId)
						END
					END
					ELSE
					BEGIN
						IF(@TRCTypeCode = '76')
						BEGIN
							SET @CurrentActionLkup = 28063			--Action : TRC 154:76 Received
							SET @CurrentWorkQueuesLkup = 10046		--TRR - TRC 154:76
							SET @CurrentStatusLkup = 20001			--NEW

							SET @AuditDescption = 'TRC Code – '+cast(@TRCCode as varchar(5))+' is received and route the case to CMS TRC 154:76 queue with status NEW'

							EXEC [USP_APP_INS_CreateSuspectCase] @BusinessSegmentLkup = 1001, @WorkBasketLkup = 3001, @DiscrepancyCategoryLkup = 6003, @DiscrepancyTypeLkup = 7001,
							@MostRecentActionLkup = @CurrentActionLkup,@MostRecentWorkQueueLkup = @CurrentWorkQueuesLkup, @MostRecentStatusLkup = @CurrentStatusLkup, @SourceSystemLkup = @SSLkup, @DiscrepancySourceLkup = 13001, 
							@DiscrepancyReceiptDate = @CurrentUTCDate, @DiscrepancyReceiptDateId = @UTCDateId, @ComplianceStartDate = @FileReceiptDate,@ComplianceStartDateId = @ComplianceStartDateId,
							@DisenrollmentDate = @DisenrollDate, @MemberSCCCode = @SCCCode, @MemberCurrentHICN = @HICN, @GPSHouseholdID = @HouseHoldId,
							@MemberFirstName = @FirstName,@MemberLastName = @LastName, @MemberContractIDLkup = @Contract,@MemberPBPLkup = @PBP,@MemberLOBLkup = @LOB,
							@MemberDOB = @MemberDOB,@MemberDOBId = @MemberDOBId,@EligOOAFlagLkup = 0,@RPRCTMMember = 0,@RPREGHPMember = 0,@IsParentCase = 0,
							@IsChildCase = 0,@Comments = @AuditDescption,@RoleLkup = 2001,@CurrentActionLkup = @CurrentActionLkup,
							@CurrentWorkQueuesLkup = @CurrentWorkQueuesLkup,@CurrentStatusLkup = @CurrentStatusLkup,@LoginUserId = @CurrentUserId,
							@TRCLkup=@TRCLkup,@IsRestricted = @IsRestricted,@ErrorMessage = @ErrorMessage OUTPUT,@CommentsSourceSystemLkup = @SSLkup,@GEN_QueueId = @GEN_QueueId OUTPUT
						END
						ELSE
						BEGIN
							IF (@TRCTypeCode = '01')
							BEGIN
								SET @CurrentActionLkup = 28015			--Action : Send OOA Letter
								SET @CurrentWorkQueuesLkup = 10007		--OOA - New Case
								SET @CurrentStatusLkup = 20001			--NEW
								SET @OOALetterStatusLkup = 53001		--Send OOA Letter Status - Ready

								SET @AuditDescption = 'TRC Code – '+cast(@TRCCode as varchar(5))+' is received and OOA Letter will be triggered.'

								EXEC [USP_APP_INS_CreateSuspectCase] @BusinessSegmentLkup = 1001, @WorkBasketLkup = 3001, @DiscrepancyCategoryLkup = 6001, @DiscrepancyTypeLkup = 7001,
								@MostRecentActionLkup = @CurrentActionLkup,@MostRecentWorkQueueLkup = @CurrentWorkQueuesLkup, @MostRecentStatusLkup = @CurrentStatusLkup, @SourceSystemLkup = @SSLkup, @DiscrepancySourceLkup = 13001, 
								@DiscrepancyReceiptDate = @CurrentUTCDate, @DiscrepancyReceiptDateId = @UTCDateId, @ComplianceStartDate = @FileReceiptDate,@ComplianceStartDateId = @ComplianceStartDateId,
								@DisenrollmentDate = @DisenrollDate, @MemberSCCCode = @SCCCode, @MemberCurrentHICN = @HICN, @GPSHouseholdID = @HouseHoldId,
								@MemberFirstName = @FirstName,@MemberLastName = @LastName, @MemberContractIDLkup = @Contract,@MemberPBPLkup = @PBP,@MemberLOBLkup = @LOB,
								@MemberDOB = @MemberDOB,@MemberDOBId = @MemberDOBId,@EligOOAFlagLkup = 0,@RPRCTMMember = 0,@RPREGHPMember = 0,@IsParentCase = 0,
								@IsChildCase = 0,@Comments = @AuditDescption,@RoleLkup = 2001,@CurrentActionLkup = @CurrentActionLkup,
								@CurrentWorkQueuesLkup = @CurrentWorkQueuesLkup,@CurrentStatusLkup = @CurrentStatusLkup,@LoginUserId = @CurrentUserId,
								@OOALetterStatusLkup = @OOALetterStatusLkup,@TRCLkup=@TRCLkup,@IsRestricted = @IsRestricted,@ErrorMessage = @ErrorMessage OUTPUT,
								@CommentsSourceSystemLkup = @SSLkup,@GEN_QueueId = @GEN_QueueId OUTPUT
							END
							ELSE
							BEGIN
								SET @CurrentActionLkup = 28062			--Escalated Action
								SET @CurrentWorkQueuesLkup = 10037		--TRR - Escalated
								SET @CurrentStatusLkup = 20002			--NEW

								SET @AuditDescption = 'TRC Code – '+cast(@TRCCode as varchar(5))+' is received. A new case has been created and routed to Escalation queue with status NEW (No matching Case found, Plan not termed & Type Code is not 01)'

								EXEC [USP_APP_INS_CreateSuspectCase] @BusinessSegmentLkup = 1001, @WorkBasketLkup = 3001, @DiscrepancyCategoryLkup = 6003, @DiscrepancyTypeLkup = 7001,
								@MostRecentActionLkup = @CurrentActionLkup,@MostRecentWorkQueueLkup = @CurrentWorkQueuesLkup, @MostRecentStatusLkup = @CurrentStatusLkup, @SourceSystemLkup = @SSLkup, @DiscrepancySourceLkup = 13001, 
								@DiscrepancyReceiptDate = @CurrentUTCDate, @DiscrepancyReceiptDateId = @UTCDateId, @ComplianceStartDate = @FileReceiptDate,@ComplianceStartDateId = @ComplianceStartDateId,
								@DisenrollmentDate = @DisenrollDate, @MemberSCCCode = @SCCCode, @MemberCurrentHICN = @HICN, @GPSHouseholdID = @HouseHoldId,
								@MemberFirstName = @FirstName,@MemberLastName = @LastName, @MemberContractIDLkup = @Contract,@MemberPBPLkup = @PBP,@MemberLOBLkup = @LOB,
								@MemberDOB = @MemberDOB,@MemberDOBId = @MemberDOBId,@EligOOAFlagLkup = 0,@RPRCTMMember = 0,@RPREGHPMember = 0,@IsParentCase = 0,
								@IsChildCase = 0,@Comments = @AuditDescption,@RoleLkup = 2001,@CurrentActionLkup = @CurrentActionLkup,
								@CurrentWorkQueuesLkup = @CurrentWorkQueuesLkup,@CurrentStatusLkup = @CurrentStatusLkup,@LoginUserId = @CurrentUserId,
								@TRCLkup=@TRCLkup,@IsRestricted = @IsRestricted,@ErrorMessage = @ErrorMessage OUTPUT,@CommentsSourceSystemLkup = @SSLkup,@GEN_QueueId = @GEN_QueueId OUTPUT
							END
						END
					END

				END
			END

			SET @IterationCount = @IterationCount+1

			IF(LEN(@ProcessedQueueIds) > 0)
			BEGIN
				SET @ProcessedQueueIds = @ProcessedQueueIds + ','
			END

			IF(@ClosedQueueIdForReference > 0)
			BEGIN
				SET @ProcessedQueueIds = @ProcessedQueueIds + Cast(@ClosedQueueIdForReference as Varchar) + ',' +Cast(@GEN_QueueId as Varchar)
			END
			ELSE
			BEGIN
				SET @ProcessedQueueIds = @ProcessedQueueIds + Cast(@GEN_QueueId as Varchar)
			END

			IF(@TotalRecordsCount = 0)
			BEGIN
				BREAK;
			END
		END

		--Update MQTRRWorkItem as IsProcessed = 1
		Update MQTRRWorkQueueItems Set ProcessedGENQueueRef = @ProcessedQueueIds, IsProcessed = 1, UTCProcessedOn = @CurrentUTCDate,ProcessedByRef = @CurrentUserId, UTCLastUpdatedOn = @CurrentUTCDate, UpdatedByRef = @CurrentUserId Where MQTRRWorkQueueItemId = @MQTRRWorkQueueItemsId

		DROP Table #TempRecordsToProcess
	END
	-------- END ----------


	--ELSE IF(@TRCCode = '085')
	--BEGIN

	--	--=========================== TRC 085 ===========================--
	--	-------- BEGIN ----------

	--	--Match Logic:
	--	--Existing OOA Case (Discrepancy Case Category = OOA, and 
	--	--Status is other than Resolved-Completed, and 
	--	--Discrepancy Type is some value other than Incarcerated
	--	--Where:HICN, Contract # and PBP in discrepancy record is matched with the HICN, Contract# and PBP in the Case. 
	--	--The system will look for a match using the following order of application fields.· GPS Contract and GPS PBP and Current HICN· MMR Contract and MMR PBP and Current HICN· Other Contract and Other PBP and Current HICN

	--	Select @GEN_QueueId = Q.GEN_QueueId, @DiscpCat = Q.DiscrepancyCategoryLkup, @DiscpType = Q.DiscrepancyTypeLkup 
	--	From GEN_Queue Q 
	--	Where Q.IsActive = 1 And Q.LockedByRef Is NULL And Q.DiscrepancyCategoryLkup In (6001,6003) And Q.MostRecentStatusLkup Not In (20003) And Q.DiscrepancyTypeLkup Not In (7003)
	--	And Q.MemberCurrentHICN = @HICN And Q.MemberContractIDLkup= @Contract And Q.MemberPBPLkup= @PBP
	--	Group By Q.GEN_QueueId,Q.DiscrepancyCategoryLkup,Q.DiscrepancyTypeLkup

	--	IF(@GEN_QueueId Is NOT NULL And @GEN_QueueId > 0)
	--	BEGIN
	--		--Don't do anything
	--		--Add TRC Description code

	--		SET @AuditDescption = 'This TRC Code – 085 is received and no new case is created on '+ CONVERT(varchar, @CurrentUTCDate,113) +' and Performed By as System: GPS WQ'

	--		INSERT INTO [dbo].[GEN_Comments]
	--						([GEN_QueueRef],[Comments],[ActionLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef],[SourceSystemLkup])
	--			VALUES      (@GEN_QueueId,@AuditDescption,28032,1,@CurrentUTCDate,2,@CurrentUTCDate,2,@SSLkup)

	--		Update MQTRRWorkQueueItems Set ProcessedGENQueueRef = @GEN_QueueId, IsProcessed = 1, UTCProcessedOn = @CurrentUTCDate,ProcessedByRef = 2, UTCLastUpdatedOn = @CurrentUTCDate, UpdatedByRef = 2 Where MQTRRWorkQueueItemId = @MQTRRWorkQueueItemsId
	--	END
	--	ELSE
	--	BEGIN
	--		IF(@GPSReasonDesc = 'STATE AND/OR COUNTY DO NOT MATCH')
	--		BEGIN

	--			DECLARE @CountMatchingRec bigint = 0
	--			SELECT @CountMatchingRec = Count(1) From GEN_Queue Q 
	--			Where Q.MemberCurrentHICN = @HICN And Q.MemberContractIDLkup= @Contract And Q.MemberPBPLkup= @PBP And Q.DiscrepancyCategoryLkup In (6001,6002) 
	--				  And Q.MostRecentStatusLkup In (20003) And DiscrepancyTypeLkup = 7002 
	--				  And ((MemberLOBLkup = 31004 And ComplianceStartDate <= DateAdd(mm,-6 ,GetUTCDate())) Or 
	--					   (MemberLOBLkup = 31007 And ComplianceStartDate <= DateAdd(mm,-12 ,GetUTCDate())))

	--			If(@CountMatchingRec = 0)
	--			BEGIN
	--				If (@PlanTerminationDate Is Not NULL And Convert(date,@PlanTerminationDate,101) <= Convert(date,GetUTCDate(),101))  --(Plan Termed)
	--				BEGIN
				
	--					-- Condition Met (Rec’d associated 285, 018, 015, 014, 013 with same Eff Date, Contract, PBP OR 100 TC 61 for a new contract/PBP with same eff date)
	--					IF EXISTS(Select 1 From MQTRRWorkQueueItems Where (IsProcessed = 0 And TRC In ('285', '018', '015', '014', '013') And TimelineEffectiveDate = @EffectiveDate And [Contract] = @Contract And PBP = @PBP) OR
	--							 (IsProcessed = 0 And TRC In ('100') And TRCTypeCode = '61' And TimelineEffectiveDate = @EffectiveDate And ([Contract] <> @Contract Or PBP <> @PBP)))
	--					BEGIN   -- 20003 - Resolve Completed | 10004 - OOA - Completed

	--						EXEC [USP_APP_INS_CreateSuspectCase] @BusinessSegmentLkup = 1001, @WorkBasketLkup = 3001, @DiscrepancyCategoryLkup = 6003, @DiscrepancyTypeLkup = 7002,
	--						@MostRecentActionLkup = 28032,@MostRecentWorkQueueLkup = 10004, @MostRecentStatusLkup = 20003, @SourceSystemLkup = @SSLkup, @DiscrepancySourceLkup = 13001, 
	--						@DiscrepancyReceiptDate = @CurrentUTCDate, @DiscrepancyReceiptDateId = @UTCDateId, @ComplianceStartDate = @FileReceiptDate,@ComplianceStartDateId = @ComplianceStartDateId,
	--						@DisenrollmentDate = @DisenrollDate, @MemberSCCCode = @SCCCode, @MemberCurrentHICN = @HICN, @GPSHouseholdID = @HouseHoldId,
	--						@MemberFirstName = @FirstName,@MemberLastName = @LastName, @MemberContractIDLkup = @Contract,@MemberPBPLkup = @PBP,@MemberLOBLkup = @LOB,
	--						@MemberDOB = @MemberDOB,@MemberDOBId = @MemberDOBId,@EligOOAFlagLkup = 0,@RPRCTMMember = 0,@RPREGHPMember = 0,@IsParentCase = 0,
	--						@IsChildCase = 0,@Comments = 'New TRR Case Created with Record status updated to Resolved-Completed and End Queue updated to Completed. Add GPS Note',@RoleLkup = 0,
	--						@CurrentWorkQueuesLkup = 10034,@CurrentStatusLkup = 20001,@LoginUserId = 2,@TRCLkup=@TRCLkup,@ErrorMessage = @ErrorMessage OUTPUT,@CommentsSourceSystemLkup = @SSLkup

	--						Update MQTRRWorkQueueItems Set ProcessedGENQueueRef = @GEN_QueueId, IsProcessed = 1, UTCProcessedOn = @CurrentUTCDate,ProcessedByRef = 2, UTCLastUpdatedOn = @CurrentUTCDate, UpdatedByRef = 2 Where MQTRRWorkQueueItemId = @MQTRRWorkQueueItemsId
						
	--					END
	--					ELSE
	--					BEGIN   -- 10037 - TRR Escalated

	--					EXEC [USP_APP_INS_CreateSuspectCase] @BusinessSegmentLkup = 1001, @WorkBasketLkup = 3001, @DiscrepancyCategoryLkup = 6003, @DiscrepancyTypeLkup = 7002,
	--					@MostRecentActionLkup = 28032,@MostRecentWorkQueueLkup = 10037, @MostRecentStatusLkup = 20001, @SourceSystemLkup = @SSLkup, @DiscrepancySourceLkup = 13001, 
	--					@DiscrepancyReceiptDate = @CurrentUTCDate, @DiscrepancyReceiptDateId = @UTCDateId, @ComplianceStartDate = @FileReceiptDate,@ComplianceStartDateId = @ComplianceStartDateId,
	--					@DisenrollmentDate = @DisenrollDate, @MemberSCCCode = @SCCCode, @MemberCurrentHICN = @HICN, @GPSHouseholdID = @HouseHoldId,
	--					@MemberFirstName = @FirstName,@MemberLastName = @LastName, @MemberContractIDLkup = @Contract,@MemberPBPLkup = @PBP,@MemberLOBLkup = @LOB,
	--					@MemberDOB = @MemberDOB,@MemberDOBId = @MemberDOBId,@EligOOAFlagLkup = 0,@RPRCTMMember = 0,@RPREGHPMember = 0,@IsParentCase = 0,
	--					@IsChildCase = 0,@Comments = 'New TRR Case Created with Record queue updated to Escalated & User Escalation Reason set to GPS Transaction Failure.',@RoleLkup = 0,
	--					@CurrentWorkQueuesLkup = 10034,@CurrentStatusLkup = 20001,@LoginUserId = 2,@TRCLkup=@TRCLkup,@ErrorMessage = @ErrorMessage OUTPUT,@CommentsSourceSystemLkup = @SSLkup

	--					Update MQTRRWorkQueueItems Set ProcessedGENQueueRef = @GEN_QueueId, IsProcessed = 1, UTCProcessedOn = @CurrentUTCDate,ProcessedByRef = 2, UTCLastUpdatedOn = @CurrentUTCDate, UpdatedByRef = 2 Where MQTRRWorkQueueItemId = @MQTRRWorkQueueItemsId
				 
	--					-- ??User Escalation Reason set to GPS Transaction Failure??

	--					END
	--				END
	--				ELSE
	--				BEGIN   -- 10045 - TRC 085
					
	--					-- Add TRC Description Code

	--					EXEC [USP_APP_INS_CreateSuspectCase] @BusinessSegmentLkup = 1001, @WorkBasketLkup = 3001, @DiscrepancyCategoryLkup = 6003, @DiscrepancyTypeLkup = 7002,
	--					@MostRecentActionLkup = 28032,@MostRecentWorkQueueLkup = 10045, @MostRecentStatusLkup = 20001, @SourceSystemLkup = @SSLkup, @DiscrepancySourceLkup = 13001, 
	--					@DiscrepancyReceiptDate = @CurrentUTCDate, @DiscrepancyReceiptDateId = @UTCDateId, @ComplianceStartDate = @FileReceiptDate,@ComplianceStartDateId = @ComplianceStartDateId,
	--					@DisenrollmentDate = @DisenrollDate, @MemberSCCCode = @SCCCode, @MemberCurrentHICN = @HICN, @GPSHouseholdID = @HouseHoldId,
	--					@MemberFirstName = @FirstName,@MemberLastName = @LastName, @MemberContractIDLkup = @Contract,@MemberPBPLkup = @PBP,@MemberLOBLkup = @LOB,
	--					@MemberDOB = @MemberDOB,@MemberDOBId = @MemberDOBId,@EligOOAFlagLkup = 0,@RPRCTMMember = 0,@RPREGHPMember = 0,@IsParentCase = 0,
	--					@IsChildCase = 0,@Comments = 'New TRR Case Created with Queue updated to TRC 085',@RoleLkup = 0,
	--					@CurrentWorkQueuesLkup = 10034,@CurrentStatusLkup = 20001,@LoginUserId = 2,@TRCLkup=@TRCLkup,@ErrorMessage = @ErrorMessage OUTPUT,@CommentsSourceSystemLkup = @SSLkup

	--					Update MQTRRWorkQueueItems Set ProcessedGENQueueRef = @GEN_QueueId, IsProcessed = 1, UTCProcessedOn = @CurrentUTCDate,ProcessedByRef = 2, UTCLastUpdatedOn = @CurrentUTCDate, UpdatedByRef = 2 Where MQTRRWorkQueueItemId = @MQTRRWorkQueueItemsId

	--				END
	--			END
	--		END

	--		--ELSE IF(@GPSReasonDesc = 'STATE AND/OR COUNTY MATCH')   --Or Any Other Reason Description
	--		--BEGIN
	--		--	--Don't do anything
	--		--END
	--	END

	--END
	-------- END ----------

	ELSE IF(@TRCCode = '016')
	BEGIN

		--=========================== TRC 016 (Enrollment Accepted, Out of Area) ===========================--
		-------- BEGIN ----------
		--Match Logic: Existing OOA Case (Discrepancy Case Category = OOA, and Status is other than Resolved-Completed, and Discrepancy Type is some value other than Incarcerated
		--Where: HICN, Contract # and PBP in discrepancy record is matched with the HICN, Contract# and PBP in the Case.
		--The system will look for a match using the following order of application fields.· GPS Contract and GPS PBP and Current HICN· MMR Contract and MMR PBP and Current HICN· Other Contract and Other PBP and Current HICN

		IF(@MQSourceTypeLkup = 54002)
		BEGIN
			INSERT INTO #TempRecordsToProcess
			Select  Distinct Q.GEN_QueueId, Q.DiscrepancyCategoryLkup, Q.DiscrepancyTypeLkup, Q.MostRecentActionLkup, Q.MostRecentWorkQueueLkup, Q.MostRecentStatusLkup, Q.LockedByRef,
					Q.CreatedByRef, Q.LastUpdatedByRef
			From GEN_Queue Q
			Where Q.IsActive = 1 And Q.DiscrepancyCategoryLkup In (6001,6003) And Q.MostRecentStatusLkup Not In (20003) And Q.DiscrepancyTypeLkup Not In (7003)
			And (Q.MemberCurrentHICN = @HICN Or Q.MemberMedicareId = @HICN) And Q.MemberContractIDLkup= @Contract And Q.MemberPBPLkup= @PBP
		END
		ELSE
		BEGIN
			INSERT INTO #TempRecordsToProcess
			Select  @GEN_QueueId, Q.DiscrepancyCategoryLkup, Q.DiscrepancyTypeLkup, Q.MostRecentActionLkup, Q.MostRecentWorkQueueLkup, Q.MostRecentStatusLkup, Q.LockedByRef,
					Q.CreatedByRef, Q.LastUpdatedByRef
			From GEN_Queue Q
			Where Q.IsActive = 1 And Q.GEn_QueueId = @GEN_QueueId
		END

		SET @TotalRecordsCount = (Select Count(1) From #TempRecordsToProcess)
		SET @IterationCount = 1

		WHILE(@TotalRecordsCount = 0 Or @IterationCount <= @TotalRecordsCount)
		BEGIN
			SET @ClosedQueueIdForReference = 0
			SET @GEN_QueueId = 0
			SET @DiscpCat = 0
			SET @PreviousActionLkup = 0
			SET @PreviousWQLkup = 0
			SET @PreviousStsLkup = 0
			SET @LockedByRef = 0
			SET @CreatedByRef = 0
			SET @LastUpdatedByRef = 0
		
			Select @GEN_QueueId = GEN_QueueId, @DiscpCat = DiscpCat, @PreviousActionLkup = PreviousActionLkup, @PreviousWQLkup = PreviousWQLkup,
					@PreviousStsLkup = PreviousStsLkup, @LockedByRef = LockedByRef, @CreatedByRef = CreatedByRef, @LastUpdatedByRef = LastUpdatedByRef
			From #TempRecordsToProcess Where SNO = @IterationCount

			IF(@LockedByRef Is NULL Or @LockedByRef = 0)
			BEGIN
				IF(@GEN_QueueId Is NOT NULL And @GEN_QueueId > 0)
				BEGIN
					IF(@DiscpCat = 6003)	--TRR
					BEGIN
						SET @CurrentActionLkup = 28001			--Add Comments
						SET @CurrentStatusLkup = 20002			--INPROGRESS

						--Update queue with action (Add Comments)
						Update GEN_Queue 
						Set MostRecentStatusLkup = @CurrentStatusLkup
							--,MostRecentWorkQueueLkup = @PreviousWQLkup   ---Not required. Only TRC description note added
							,[UTCLastUpdatedOn]= @CurrentUTCDate
							,[UTCLastUpdatedOnId]= FORMAT(@CurrentUTCDate, 'yyyyMMdd')
							,[UTCLastUpdatedOnYear]= FORMAT(@CurrentUTCDate, 'yyyy')
							,[UTCLastUpdatedOnMonth]= FORMAT(@CurrentUTCDate, 'MM')
							,[UTCLastUpdatedOnDay]= FORMAT(@CurrentUTCDate, 'dd')
							,[CSTLastUpdatedOn]= DATEADD(hh, -6, @CurrentUTCDate)
							,[CSTLastUpdatedOnId]= FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'yyyyMMdd')
							,[CSTLastUpdatedOnYear]= FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'yyyy')
							,[CSTLastUpdatedOnMonth]= FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'MM')
							,[CSTLastUpdatedOnDay]= FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'dd')
							,[LastUpdatedByRef] = @CurrentUserId
							,[MostRecentActionLkup]= @CurrentActionLkup	
							,[TRCLkup]= @TRCLkup
						Where GEN_QueueId = @GEN_QueueId
				
						If EXISTS (Select 1 From GEN_OSTActions Where GEN_QueueRef = @GEN_QueueId)
						BEGIN
							Update GEN_OSTActions Set ActionLkup = @CurrentActionLkup, UTCLastUpdatedOn = @CurrentUTCDate, LastUpdatedByRef = @CurrentUserId Where GEN_QueueRef = @GEN_QueueId
						END
						ELSE
						BEGIN
							INSERT INTO [dbo].[GEN_OSTActions]
										([GEN_QueueRef],[ActionLkup],[LastName],[DateofBirth],[ContractIDLkup],[PBPLkup],[ApplicationDate],[EffectiveDate],
										[EndDate],[FirstLetterMailDate],[SecondLetterMailDate],[ResidentialDocumentationRequired],[CountyAttestationRequired],
										[PendReasonLkup],[ContainsErrorsLkup],[ResolutionLkup],[Reason],[InitialAddressVerificationDate],
										[MemberResponseVerificationDate],[MemberVerifiedState],[SCCLetterMailDate],[IsActive],[UTCCreatedOn],[CreatedByRef],
										[UTCLastUpdatedOn],[LastUpdatedByRef])
								VALUES  (@GEN_QueueId,@CurrentActionLkup,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,
										NULL,NULL,NULL,1,@CurrentUTCDate,@CurrentUserId,@CurrentUTCDate,@CurrentUserId)
						END

						--Add Comments
						SET @AuditDescption = 'TRC Code – '+cast(@TRCCode as varchar(5))+' is received and no new case is created on '+ CONVERT(varchar, @CurrentUTCDate,113) +' and Performed By as System: GPS  WQ'

						INSERT INTO [dbo].[GEN_Comments]
									([GEN_QueueRef],[Comments],[ActionLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef],[SourceSystemLkup])
						VALUES      (@GEN_QueueId,@AuditDescption,@CurrentActionLkup,1,@CurrentUTCDate,@CurrentUserId,@CurrentUTCDate,@CurrentUserId,@SSLkup)

						--Add Workflow
						INSERT INTO [dbo].[GEN_QueueWorkFlowCorrelation]
									([GEN_QueueRef],[RoleLkup],[WorkBasketLkup],[DiscrepancyCategoryLkup],[PreviousActionLkup],[PreviousWorkQueuesLkup],
										[PreviousStatusLkup],[CurrentActionLkup],[CurrentWorkQueuesLkup],[CurrentStatusLkup],[IsActive],[UTCCreatedOn],
										[CreatedByRef])
						VALUES		(@GEN_QueueId,2001,3001,@DiscpCat,@PreviousActionLkup,@PreviousWQLkup,@PreviousStsLkup,@CurrentActionLkup,@PreviousWQLkup,@CurrentStatusLkup,1,@CurrentUTCDate,@CurrentUserId)

						--Add ManageCases for Action performed
						INSERT INTO [dbo].[GEN_ManageCases]([GEN_QueueRef],[ActionPerformedLkup],[CurrentUserRef],[CasesComments],[ReAssignUserRef],[IsActive],[UTCCreatedOn],
									[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef])
							VALUES  (@GEN_QueueId,@CurrentActionLkup,@CurrentUserId,NULL,NULL,1,@CurrentUTCDate,@CurrentUserId,@CurrentUTCDate,@CurrentUserId)
					END
					ELSE
					BEGIN
						IF(@DiscpCat = 6001)	--OOA
						BEGIN
							SET @CurrentActionLkup = 28002			--Action - Close Case				
							SET @CurrentWorkQueuesLkup = 10004		--OOA Completed
							SET @CurrentStatusLkup = 20003			--Resolve Completed
							SET @CurrentResolutionLkup = 18006		--Resolution - Close Case

							SET @AuditDescption = 'TRC Code – '+cast(@TRCCode as varchar(5))+' is received, closing OOA Case'
							SET @IsCaseResolved = 1
						END

						--ELSE IF(@DiscpCat = 6002)	--SCC
						--BEGIN
						--  SET @CurrentActionLkup = 28002			--Action - Close Case		
						--	SET @CurrentWorkQueuesLkup = 10019		--SCC Completed
						--	SET @CurrentStatusLkup = 20003			--Resolve Completed
						--  SET @CurrentResolutionLkup = 18006		--Resolution - Close Case

						--	SET @AuditDescption = 'TRC Code – '+cast(@TRCCode as varchar(5))+' is received, closing SCC case'
						--	SET @IsCaseResolved = 1
						--END

						Set @ClosedQueueIdForReference = @GEN_QueueId

						--Update GEN_Queue
						Update GEN_Queue 
						Set MostRecentStatusLkup = @CurrentStatusLkup
							,MostRecentWorkQueueLkup = @CurrentWorkQueuesLkup
							,[UTCLastUpdatedOn]= @CurrentUTCDate
							,[UTCLastUpdatedOnId]= FORMAT(@CurrentUTCDate, 'yyyyMMdd')
							,[UTCLastUpdatedOnYear]= FORMAT(@CurrentUTCDate, 'yyyy')
							,[UTCLastUpdatedOnMonth]= FORMAT(@CurrentUTCDate, 'MM')
							,[UTCLastUpdatedOnDay]= FORMAT(@CurrentUTCDate, 'dd')
							,[CSTLastUpdatedOn]= DATEADD(hh, -6, @CurrentUTCDate)
							,[CSTLastUpdatedOnId]= FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'yyyyMMdd')
							,[CSTLastUpdatedOnYear]= FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'yyyy')
							,[CSTLastUpdatedOnMonth]= FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'MM')
							,[CSTLastUpdatedOnDay]= FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'dd')
							,[LastUpdatedByRef] = @CurrentUserId
							,[MostRecentActionLkup]= @CurrentActionLkup
							,[IsCaseResolved]=@IsCaseResolved
							,[ResolvedByRef]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE @CurrentUserId END
							,[UTCResolvedOn]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE @CurrentUTCDate END
							,[UTCResolvedOnId]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE FORMAT(@CurrentUTCDate, 'yyyyMMdd') END
							,[UTCResolvedOnYear]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE FORMAT(@CurrentUTCDate, 'yyyy') END
							,[UTCResolvedOnMonth]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE FORMAT(@CurrentUTCDate, 'MM') END
							,[UTCResolvedOnDay]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE FORMAT(@CurrentUTCDate, 'dd') END
							,[CSTResolvedOn]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE DATEADD(hh, -6, @CurrentUTCDate) END
							,[CSTResolvedOnId]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'yyyyMMdd') END
							,[CSTResolvedOnYear]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'yyyy') END
							,[CSTResolvedOnMonth]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'MM') END
							,[CSTResolvedOnDay]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'dd') END
							,[TRCLkup]= @TRCLkup
						Where GEN_QueueId = @GEN_QueueId

						--Update GEN_OSTActions
						If EXISTS (Select 1 From GEN_OSTActions Where GEN_QueueRef = @GEN_QueueId)
						BEGIN
							Update GEN_OSTActions Set ActionLkup = @CurrentActionLkup, ResolutionLkup = @CurrentResolutionLkup, UTCLastUpdatedOn = @CurrentUTCDate, LastUpdatedByRef = @CurrentUserId Where GEN_QueueRef = @GEN_QueueId
						END
						ELSE
						BEGIN
							INSERT INTO [dbo].[GEN_OSTActions]
										([GEN_QueueRef],[ActionLkup],[LastName],[DateofBirth],[ContractIDLkup],[PBPLkup],[ApplicationDate],[EffectiveDate],
										[EndDate],[FirstLetterMailDate],[SecondLetterMailDate],[ResidentialDocumentationRequired],[CountyAttestationRequired],
										[PendReasonLkup],[ContainsErrorsLkup],[ResolutionLkup],[Reason],[InitialAddressVerificationDate],
										[MemberResponseVerificationDate],[MemberVerifiedState],[SCCLetterMailDate],[IsActive],[UTCCreatedOn],[CreatedByRef],
										[UTCLastUpdatedOn],[LastUpdatedByRef])
								VALUES  (@GEN_QueueId,@CurrentActionLkup,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,@CurrentResolutionLkup,NULL,NULL,
										NULL,NULL,NULL,1,@CurrentUTCDate,@CurrentUserId,@CurrentUTCDate,@CurrentUserId)
						END

						--Add Comments
						INSERT INTO [dbo].[GEN_Comments]
									([GEN_QueueRef],[Comments],[ActionLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef],[SourceSystemLkup])
						VALUES      (@GEN_QueueId,@AuditDescption,@CurrentActionLkup,1,@CurrentUTCDate,@CurrentUserId,@CurrentUTCDate,@CurrentUserId,@SSLkup)

						--Add Workflow
						INSERT INTO [dbo].[GEN_QueueWorkFlowCorrelation]
									([GEN_QueueRef],[RoleLkup],[WorkBasketLkup],[DiscrepancyCategoryLkup],[PreviousActionLkup],[PreviousWorkQueuesLkup],
										[PreviousStatusLkup],[CurrentActionLkup],[CurrentWorkQueuesLkup],[CurrentStatusLkup],[IsActive],[UTCCreatedOn],
										[CreatedByRef])
						VALUES		(@GEN_QueueId,2001,3001,@DiscpCat,@PreviousActionLkup,@PreviousWQLkup,@PreviousStsLkup,@CurrentActionLkup,@CurrentWorkQueuesLkup,@CurrentStatusLkup,1,@CurrentUTCDate,@CurrentUserId)

						--Add ManageCases for Action performed
						INSERT INTO [dbo].[GEN_ManageCases]([GEN_QueueRef],[ActionPerformedLkup],[CurrentUserRef],[CasesComments],[ReAssignUserRef],[IsActive],[UTCCreatedOn],
										[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef])
								VALUES  (@GEN_QueueId,@CurrentActionLkup,@CurrentUserId,NULL,NULL,1,@CurrentUTCDate,@CurrentUserId,@CurrentUTCDate,@CurrentUserId)
		
						IF(@ClosedQueueIdForReference > 0 AND @DiscpCat <> 6003)
						BEGIN
							Set @GEN_QueueId = 0

							DECLARE @TRC016Count int = 0
							Select @TRC016Count = Count(1) From MQTRRWorkQueueItems Where IsProcessed = 0 And CMN_BackgroundProcessMasterRef = @CMN_BackgroundProcessMasterRef And TRC = '016' And HICN = @HICN

							IF(@TRC016Count = 1)
							BEGIN
								IF(@GPSPDPAutoEnrolleIndicator = 1)  --PDP
								BEGIN
									SET @CurrentActionLkup = 28015			--Action : Send OOA Letter
									SET @CurrentWorkQueuesLkup = 10007		--OOA - New Case
									SET @CurrentStatusLkup = 20001			--NEW
									SET @OOALetterStatusLkup = 53001		--Send OOA Letter Status - Ready

									SET @AuditDescption = 'TRC Code – '+cast(@TRCCode as varchar(5))+' is received, a new case is created with Status New and Performed By as System: GPS WQ (OOA Letter will be triggered)'

									EXEC [USP_APP_INS_CreateSuspectCase] @BusinessSegmentLkup = 1001, @WorkBasketLkup = 3001, @DiscrepancyCategoryLkup = 6001, @DiscrepancyTypeLkup = 7001,
									@MostRecentActionLkup = @CurrentActionLkup,@MostRecentWorkQueueLkup = @CurrentWorkQueuesLkup, @MostRecentStatusLkup = @CurrentStatusLkup, @SourceSystemLkup = @SSLkup, @DiscrepancySourceLkup = 13001, 
									@DiscrepancyReceiptDate = @CurrentUTCDate, @DiscrepancyReceiptDateId = @UTCDateId, @ComplianceStartDate = @FileReceiptDate,@ComplianceStartDateId = @ComplianceStartDateId,
									@DisenrollmentDate = @DisenrollDate, @MemberSCCCode = @SCCCode, @MemberCurrentHICN = @HICN, @GPSHouseholdID = @HouseHoldId,
									@MemberFirstName = @FirstName,@MemberLastName = @LastName, @MemberContractIDLkup = @Contract,@MemberPBPLkup = @PBP,@MemberLOBLkup = @LOB,
									@MemberDOB = @MemberDOB,@MemberDOBId = @MemberDOBId,@EligOOAFlagLkup = 0,@RPRCTMMember = 0,@RPREGHPMember = 0,@IsParentCase = 0,
									@IsChildCase = 1,@ParentQueueRef = @ClosedQueueIdForReference,@Comments = @AuditDescption,@RoleLkup = 2001,
									@CurrentActionLkup = @CurrentActionLkup,@CurrentWorkQueuesLkup = @CurrentWorkQueuesLkup,@CurrentStatusLkup = @CurrentStatusLkup,@LoginUserId = @CurrentUserId,
									@OOALetterStatusLkup = @OOALetterStatusLkup,@TRCLkup=@TRCLkup,@IsRestricted = @IsRestricted,
									@ErrorMessage = @ErrorMessage OUTPUT,@CommentsSourceSystemLkup = @SSLkup,@GEN_QueueId = @GEN_QueueId OUTPUT
								END
								ELSE
								BEGIN
									DECLARE @TRC700SeriesCount int = 0
									Select @TRC700SeriesCount = Count(1) From MQTRRWorkQueueItems Where IsProcessed = 0 And CMN_BackgroundProcessMasterRef = @CMN_BackgroundProcessMasterRef And HICN = @HICN And [Contract]= @ContractValue And PBP = @PBPValue And [TRC] BETWEEN 700 AND 799
					
									IF(@GPSApplicationStatus = 'APPROVED' AND @TRC700SeriesCount = 0)
									BEGIN
										SET @CurrentActionLkup = 28017			--Send SCC Update to CMS
										SET @CurrentWorkQueuesLkup = 10037		--Queue - TRR - Escalated
										SET @CurrentStatusLkup = 20002			--Inprogress
										SET @CMSTransactionStatusLkup = 55001	--Ready to Send CMS Transaction Update

										SET @AuditDescption = 'TRC Code – '+cast(@TRCCode as varchar(5))+' is received, a new case is created with Status In Progress and Performed By as System: GPS  WQ (CMS Transaction Update will be triggered)'

										EXEC [USP_APP_INS_CreateSuspectCase] @BusinessSegmentLkup = 1001, @WorkBasketLkup = 3001, @DiscrepancyCategoryLkup = 6003, @DiscrepancyTypeLkup = 7001,
										@MostRecentActionLkup = @CurrentActionLkup,@MostRecentWorkQueueLkup = @CurrentWorkQueuesLkup, @MostRecentStatusLkup = @CurrentStatusLkup, @SourceSystemLkup = @SSLkup, @DiscrepancySourceLkup = 13001, 
										@DiscrepancyReceiptDate = @CurrentUTCDate, @DiscrepancyReceiptDateId = @UTCDateId, @ComplianceStartDate = @FileReceiptDate,@ComplianceStartDateId = @ComplianceStartDateId,
										@DisenrollmentDate = @DisenrollDate, @MemberSCCCode = @SCCCode, @MemberCurrentHICN = @HICN, @GPSHouseholdID = @HouseHoldId,
										@MemberFirstName = @FirstName,@MemberLastName = @LastName, @MemberContractIDLkup = @Contract,@MemberPBPLkup = @PBP,@MemberLOBLkup = @LOB,
										@MemberDOB = @MemberDOB,@MemberDOBId = @MemberDOBId,@EligOOAFlagLkup = 0,@RPRCTMMember = 0,@RPREGHPMember = 0,@IsParentCase = 0,
										@IsChildCase = 1,@ParentQueueRef = @ClosedQueueIdForReference,@Comments = @AuditDescption,@RoleLkup = 2001,
										@CurrentActionLkup = @CurrentActionLkup,@CurrentWorkQueuesLkup = @CurrentWorkQueuesLkup,@CurrentStatusLkup = @CurrentStatusLkup,@LoginUserId = @CurrentUserId,
										@CMSTransactionStatusLkup = @CMSTransactionStatusLkup,@TRCLkup=@TRCLkup,@IsRestricted = @IsRestricted,
										@ErrorMessage = @ErrorMessage OUTPUT,@CommentsSourceSystemLkup = @SSLkup,@GEN_QueueId = @GEN_QueueId OUTPUT
									END
									ELSE
									BEGIN
										SET @CurrentActionLkup = 28032			--Save
										SET @CurrentWorkQueuesLkup = 10037		--Queue - TRR - Escalated
										SET @CurrentStatusLkup = 20002			--INPROGRESS

										IF(@TRC700SeriesCount > 0)
										BEGIN
											DECLARE @TRC700SeriesValue varchar(5) = ''
											Select @TRC700SeriesValue = Max(TRC) From MQTRRWorkQueueItems Where IsProcessed = 0 And CMN_BackgroundProcessMasterRef = @CMN_BackgroundProcessMasterRef And HICN = @HICN And [Contract]= @ContractValue And PBP = @PBPValue And [TRC] BETWEEN 700 AND 799

											SET @AuditDescption = 'TRC Code – '+cast(@TRCCode as varchar(5))+' is received with an associated 700 series '+@TRC700SeriesValue+', a new case is created with Status New and Performed By as System: GPS  WQ'
										END
										ELSE
										BEGIN
											SET @AuditDescption = 'TRC Code – '+cast(@TRCCode as varchar(5))+' is received without an associated 700 series and application status is NULL or not approved, a new case is created with Status New and Performed By as System: GPS  WQ'
										END

										EXEC [USP_APP_INS_CreateSuspectCase] @BusinessSegmentLkup = 1001, @WorkBasketLkup = 3001, @DiscrepancyCategoryLkup = 6003, @DiscrepancyTypeLkup = 7001,
										@MostRecentActionLkup = @CurrentActionLkup,@MostRecentWorkQueueLkup = @CurrentWorkQueuesLkup, @MostRecentStatusLkup = @CurrentStatusLkup, @SourceSystemLkup = @SSLkup, @DiscrepancySourceLkup = 13001, 
										@DiscrepancyReceiptDate = @CurrentUTCDate, @DiscrepancyReceiptDateId = @UTCDateId, @ComplianceStartDate = @FileReceiptDate,@ComplianceStartDateId = @ComplianceStartDateId,
										@DisenrollmentDate = @DisenrollDate, @MemberSCCCode = @SCCCode, @MemberCurrentHICN = @HICN, @GPSHouseholdID = @HouseHoldId,
										@MemberFirstName = @FirstName,@MemberLastName = @LastName, @MemberContractIDLkup = @Contract,@MemberPBPLkup = @PBP,@MemberLOBLkup = @LOB,
										@MemberDOB = @MemberDOB,@MemberDOBId = @MemberDOBId,@EligOOAFlagLkup = 0,@RPRCTMMember = 0,@RPREGHPMember = 0,@IsParentCase = 0,
										@IsChildCase = 1,@ParentQueueRef = @ClosedQueueIdForReference,@Comments = @AuditDescption,@RoleLkup = 2001,
										@CurrentActionLkup = @CurrentActionLkup,@CurrentWorkQueuesLkup = @CurrentWorkQueuesLkup,@CurrentStatusLkup = @CurrentStatusLkup,@LoginUserId = @CurrentUserId,
										@TRCLkup=@TRCLkup,@IsRestricted = @IsRestricted,@ErrorMessage = @ErrorMessage OUTPUT,@CommentsSourceSystemLkup = @SSLkup,@GEN_QueueId = @GEN_QueueId OUTPUT
									END					
								END								
							END
							ELSE IF(@TRC016Count > 1)
							BEGIN
								DECLARE @TotalTRC016CntByIndvId int = 0
								Select @TotalTRC016CntByIndvId = Count(1) From MQTRRWorkQueueItems Where IsProcessed = 0 And CMN_BackgroundProcessMasterRef = @CMN_BackgroundProcessMasterRef And TRC = '016' And HICN = @HICN

								DECLARE @TRC016GroupByIndvIdCnt int = 0
								Select @TRC016GroupByIndvIdCnt = Count(1) From MQTRRWorkQueueItems Where IsProcessed = 0 And CMN_BackgroundProcessMasterRef = @CMN_BackgroundProcessMasterRef And TRC = '016' And HICN = @HICN
								Group By IndividualID,[Contract],PBP,TimelineEffectiveDate

								DECLARE @TotalTRC016CntByIndvIdndEffectDate int = 0
								Select @TotalTRC016CntByIndvIdndEffectDate = Count(1) From MQTRRWorkQueueItems Where IsProcessed = 0 And CMN_BackgroundProcessMasterRef = @CMN_BackgroundProcessMasterRef And TRC = '016' And HICN = @HICN And TimelineEffectiveDate = @EffectiveDate

								DECLARE @TRC016GroupByIndvIdCntndEffectDate int = 0
								Select @TRC016GroupByIndvIdCntndEffectDate = Count(1) From MQTRRWorkQueueItems Where IsProcessed = 0 And CMN_BackgroundProcessMasterRef = @CMN_BackgroundProcessMasterRef And TRC = '016' And HICN = @HICN And TimelineEffectiveDate = @EffectiveDate
								Group By IndividualID,[Contract],PBP,TimelineEffectiveDate

								DECLARE @TRC016ApprovedCount int = 0
								Select @TRC016ApprovedCount = Count(1) From MQTRRWorkQueueItems Where IsProcessed = 0 And CMN_BackgroundProcessMasterRef = @CMN_BackgroundProcessMasterRef And TRC = '016' And HICN = @HICN And TimelineEffectiveDate = @EffectiveDate And GPSApplicationStatus = 'APPROVED'

								If((@TotalTRC016CntByIndvId = @TRC016GroupByIndvIdCnt) Or (@TotalTRC016CntByIndvIdndEffectDate = @TRC016GroupByIndvIdCntndEffectDate And @TRC016ApprovedCount>0))  --Records for Same Member But different Contract + PBP + Effective Date
								BEGIN
									IF(@GPSPDPAutoEnrolleIndicator = 1)  --PDP
									BEGIN
										SET @CurrentActionLkup = 28015			--Action : Send OOA Letter
										SET @CurrentWorkQueuesLkup = 10007		--OOA - New Case
										SET @CurrentStatusLkup = 20001			--NEW
										SET @OOALetterStatusLkup = 53001        --Send OOA Letter Status - Ready

										SET @AuditDescption = 'TRC Code – '+cast(@TRCCode as varchar(5))+' is received, a new case is created with Status New and Performed By as System: GPS WQ (OOA Letter will be triggered)'

										EXEC [USP_APP_INS_CreateSuspectCase] @BusinessSegmentLkup = 1001, @WorkBasketLkup = 3001, @DiscrepancyCategoryLkup = 6001, @DiscrepancyTypeLkup = 7001,
										@MostRecentActionLkup = @CurrentActionLkup,@MostRecentWorkQueueLkup = @CurrentWorkQueuesLkup, @MostRecentStatusLkup = @CurrentStatusLkup, @SourceSystemLkup = @SSLkup, @DiscrepancySourceLkup = 13001, 
										@DiscrepancyReceiptDate = @CurrentUTCDate, @DiscrepancyReceiptDateId = @UTCDateId, @ComplianceStartDate = @FileReceiptDate,@ComplianceStartDateId = @ComplianceStartDateId,
										@DisenrollmentDate = @DisenrollDate, @MemberSCCCode = @SCCCode, @MemberCurrentHICN = @HICN, @GPSHouseholdID = @HouseHoldId,
										@MemberFirstName = @FirstName,@MemberLastName = @LastName, @MemberContractIDLkup = @Contract,@MemberPBPLkup = @PBP,@MemberLOBLkup = @LOB,
										@MemberDOB = @MemberDOB,@MemberDOBId = @MemberDOBId,@EligOOAFlagLkup = 0,@RPRCTMMember = 0,@RPREGHPMember = 0,@IsParentCase = 0,
										@IsChildCase = 1,@ParentQueueRef = @ClosedQueueIdForReference,@Comments = @AuditDescption,@RoleLkup = 2001,
										@CurrentActionLkup = @CurrentActionLkup,@CurrentWorkQueuesLkup = @CurrentWorkQueuesLkup,@CurrentStatusLkup = @CurrentStatusLkup,@LoginUserId = @CurrentUserId,
										@OOALetterStatusLkup = @OOALetterStatusLkup,@TRCLkup=@TRCLkup,@IsRestricted = @IsRestricted,
										@ErrorMessage = @ErrorMessage OUTPUT,@CommentsSourceSystemLkup = @SSLkup,@GEN_QueueId = @GEN_QueueId OUTPUT
									END
									ELSE
									BEGIN
										DECLARE @ApprovedCount int = 0
										Select @ApprovedCount = Count(1) From MQTRRWorkQueueItems 
										Where IsProcessed = 0 And CMN_BackgroundProcessMasterRef = @CMN_BackgroundProcessMasterRef And HICN = @HICN And [Contract]= @ContractValue And PBP = @PBPValue And TimelineEffectiveDate = @GPSProposedEffectiveDate And GPSApplicationStatus = 'APPROVED' And [TRC] NOT BETWEEN 700 AND 799

										IF(@ApprovedCount>0)
										BEGIN
											SET @CurrentActionLkup = 28017			--Send SCC Update to CMS
											SET @CurrentWorkQueuesLkup = 10037		--Queue - TRR - Escalated
											SET @CurrentStatusLkup = 20001			--NEW
											SET @CMSTransactionStatusLkup = 55001	--Ready to Send CMS Transaction Update

											SET @AuditDescption = 'TRC Code – '+cast(@TRCCode as varchar(5))+' is received, a new case is created with Status New and Performed By as System: GPS WQ (CMS Transaction Update will be triggered)'

											EXEC [USP_APP_INS_CreateSuspectCase] @BusinessSegmentLkup = 1001, @WorkBasketLkup = 3001, @DiscrepancyCategoryLkup = 6003, @DiscrepancyTypeLkup = 7001,
											@MostRecentActionLkup = @CurrentActionLkup,@MostRecentWorkQueueLkup = @CurrentWorkQueuesLkup, @MostRecentStatusLkup = @CurrentStatusLkup, @SourceSystemLkup = @SSLkup, @DiscrepancySourceLkup = 13001, 
											@DiscrepancyReceiptDate = @CurrentUTCDate, @DiscrepancyReceiptDateId = @UTCDateId, @ComplianceStartDate = @FileReceiptDate,@ComplianceStartDateId = @ComplianceStartDateId,
											@DisenrollmentDate = @DisenrollDate, @MemberSCCCode = @SCCCode, @MemberCurrentHICN = @HICN, @GPSHouseholdID = @HouseHoldId,
											@MemberFirstName = @FirstName,@MemberLastName = @LastName, @MemberContractIDLkup = @Contract,@MemberPBPLkup = @PBP,@MemberLOBLkup = @LOB,
											@MemberDOB = @MemberDOB,@MemberDOBId = @MemberDOBId,@EligOOAFlagLkup = 0,@RPRCTMMember = 0,@RPREGHPMember = 0,@IsParentCase = 0,
											@IsChildCase = 1,@ParentQueueRef = @ClosedQueueIdForReference,@Comments = @AuditDescption,@RoleLkup = 2001,
											@CurrentActionLkup = @CurrentActionLkup,@CurrentWorkQueuesLkup = @CurrentWorkQueuesLkup,@CurrentStatusLkup = @CurrentStatusLkup,@LoginUserId = @CurrentUserId,
											@CMSTransactionStatusLkup = @CMSTransactionStatusLkup,@TRCLkup=@TRCLkup,@IsRestricted = @IsRestricted,
											@ErrorMessage = @ErrorMessage OUTPUT,@CommentsSourceSystemLkup = @SSLkup,@GEN_QueueId = @GEN_QueueId OUTPUT
										END
										ELSE
										BEGIN
											SET @CurrentActionLkup = 28032			--Save
											SET @CurrentWorkQueuesLkup = 10037		--Queue - TRR - Escalated
											SET @CurrentStatusLkup = 20002			--INPROGRESS

											IF(@ApprovedCount = 0)
											BEGIN
												SET @TRC700SeriesValue = ''
												Select @TRC700SeriesValue = Max(TRC) From MQTRRWorkQueueItems
												Where IsProcessed = 0 And CMN_BackgroundProcessMasterRef = @CMN_BackgroundProcessMasterRef And HICN = @HICN And [Contract]= @ContractValue And PBP = @PBPValue And TimelineEffectiveDate = @GPSProposedEffectiveDate And GPSApplicationStatus = 'APPROVED' And [TRC] BETWEEN 700 AND 799

												SET @AuditDescption = 'TRC Code – '+cast(@TRCCode as varchar(5))+' is received with an associated 700 series '+@TRC700SeriesValue+', a new case is created with Status New and Performed By as System: GPS  WQ'
											END
											ELSE
											BEGIN
												SET @AuditDescption = 'TRC Code – '+cast(@TRCCode as varchar(5))+' is received without an associated 700 series and application status is not approved, a new case is created with Status New and Performed By as System: GPS  WQ'
											END

											EXEC [USP_APP_INS_CreateSuspectCase] @BusinessSegmentLkup = 1001, @WorkBasketLkup = 3001, @DiscrepancyCategoryLkup = 6003, @DiscrepancyTypeLkup = 7001,
											@MostRecentActionLkup = @CurrentActionLkup,@MostRecentWorkQueueLkup = @CurrentWorkQueuesLkup, @MostRecentStatusLkup = @CurrentStatusLkup, @SourceSystemLkup = @SSLkup, @DiscrepancySourceLkup = 13001, 
											@DiscrepancyReceiptDate = @CurrentUTCDate, @DiscrepancyReceiptDateId = @UTCDateId, @ComplianceStartDate = @FileReceiptDate,@ComplianceStartDateId = @ComplianceStartDateId,
											@DisenrollmentDate = @DisenrollDate, @MemberSCCCode = @SCCCode, @MemberCurrentHICN = @HICN, @GPSHouseholdID = @HouseHoldId,
											@MemberFirstName = @FirstName,@MemberLastName = @LastName, @MemberContractIDLkup = @Contract,@MemberPBPLkup = @PBP,@MemberLOBLkup = @LOB,
											@MemberDOB = @MemberDOB,@MemberDOBId = @MemberDOBId,@EligOOAFlagLkup = 0,@RPRCTMMember = 0,@RPREGHPMember = 0,@IsParentCase = 0,
											@IsChildCase = 1,@ParentQueueRef = @ClosedQueueIdForReference,@Comments = @AuditDescption,@RoleLkup = 2001,
											@CurrentActionLkup = @CurrentActionLkup,@CurrentWorkQueuesLkup = @CurrentWorkQueuesLkup,@CurrentStatusLkup = @CurrentStatusLkup,@LoginUserId = @CurrentUserId,
											@TRCLkup=@TRCLkup,@IsRestricted = @IsRestricted,@ErrorMessage = @ErrorMessage OUTPUT,@CommentsSourceSystemLkup = @SSLkup,@GEN_QueueId = @GEN_QueueId OUTPUT
										END
									END
								END	
								ELSE
								BEGIN 
									SET @CurrentActionLkup = 28032			--Save
									SET @CurrentWorkQueuesLkup = 10037		--Queue - TRR - Escalated
									SET @CurrentStatusLkup = 20002			--INPROGRESS

									SET @AuditDescption = 'Multiple TRC Code – '+cast(@TRCCode as varchar(5))+' have been received and did not meet any conditions for the TRC16 workflow, a new case is created with Status New and Performed By as System: GPS  WQ'

									EXEC [USP_APP_INS_CreateSuspectCase] @BusinessSegmentLkup = 1001, @WorkBasketLkup = 3001, @DiscrepancyCategoryLkup = 6003, @DiscrepancyTypeLkup = 7001,
									@MostRecentActionLkup = @CurrentActionLkup,@MostRecentWorkQueueLkup = @CurrentWorkQueuesLkup, @MostRecentStatusLkup = @CurrentStatusLkup, @SourceSystemLkup = @SSLkup, @DiscrepancySourceLkup = 13001, 
									@DiscrepancyReceiptDate = @CurrentUTCDate, @DiscrepancyReceiptDateId = @UTCDateId, @ComplianceStartDate = @FileReceiptDate,@ComplianceStartDateId = @ComplianceStartDateId,
									@DisenrollmentDate = @DisenrollDate, @MemberSCCCode = @SCCCode, @MemberCurrentHICN = @HICN, @GPSHouseholdID = @HouseHoldId,
									@MemberFirstName = @FirstName,@MemberLastName = @LastName, @MemberContractIDLkup = @Contract,@MemberPBPLkup = @PBP,@MemberLOBLkup = @LOB,
									@MemberDOB = @MemberDOB,@MemberDOBId = @MemberDOBId,@EligOOAFlagLkup = 0,@RPRCTMMember = 0,@RPREGHPMember = 0,@IsParentCase = 0,
									@IsChildCase = 1,@ParentQueueRef = @ClosedQueueIdForReference,@Comments = @AuditDescption,@RoleLkup = 2001,
									@CurrentActionLkup = @CurrentActionLkup,@CurrentWorkQueuesLkup = @CurrentWorkQueuesLkup,@CurrentStatusLkup = @CurrentStatusLkup,@LoginUserId = @CurrentUserId,
									@TRCLkup=@TRCLkup,@IsRestricted = @IsRestricted,@ErrorMessage = @ErrorMessage OUTPUT,@CommentsSourceSystemLkup = @SSLkup,@GEN_QueueId = @GEN_QueueId OUTPUT					
								END								
							END
						END
					END
				END
				ELSE
				BEGIN
					If (@PlanTerminationDate Is Not NULL And Convert(date,@PlanTerminationDate,101) <= Convert(date,GetUTCDate(),101))  --(Plan Termed)
					BEGIN
						SET @CurrentActionLkup = 28032			--Save
						SET @CurrentWorkQueuesLkup = 10033		--TRR - CMS Rejected
						SET @CurrentStatusLkup = 20001			--NEW

						SET @AuditDescption = 'TRC Code – '+cast(@TRCCode as varchar(5))+' is received. queue of the case is changed to Open-CMS Rejected and Performed By as System: GPS  WQ'

						EXEC [USP_APP_INS_CreateSuspectCase] @BusinessSegmentLkup = 1001, @WorkBasketLkup = 3001, @DiscrepancyCategoryLkup = 6003, @DiscrepancyTypeLkup = 7001,
						@MostRecentActionLkup = @CurrentActionLkup,@MostRecentWorkQueueLkup = @CurrentWorkQueuesLkup, @MostRecentStatusLkup = @CurrentStatusLkup, @SourceSystemLkup = @SSLkup, @DiscrepancySourceLkup = 13001, 
						@DiscrepancyReceiptDate = @CurrentUTCDate, @DiscrepancyReceiptDateId = @UTCDateId, @ComplianceStartDate = @FileReceiptDate,@ComplianceStartDateId = @ComplianceStartDateId,
						@DisenrollmentDate = @DisenrollDate, @MemberSCCCode = @SCCCode, @MemberCurrentHICN = @HICN, @GPSHouseholdID = @HouseHoldId,
						@MemberFirstName = @FirstName,@MemberLastName = @LastName, @MemberContractIDLkup = @Contract,@MemberPBPLkup = @PBP,@MemberLOBLkup = @LOB,
						@MemberDOB = @MemberDOB,@MemberDOBId = @MemberDOBId,@EligOOAFlagLkup = 0,@RPRCTMMember = 0,@RPREGHPMember = 0,@IsParentCase = 0,
						@IsChildCase = 0,@Comments = @AuditDescption,@RoleLkup = 2001,@CurrentActionLkup = @CurrentActionLkup,
						@CurrentWorkQueuesLkup = @CurrentWorkQueuesLkup,@CurrentStatusLkup = @CurrentStatusLkup,@LoginUserId = @CurrentUserId,
						@TRCLkup=@TRCLkup,@IsRestricted = @IsRestricted,@ErrorMessage = @ErrorMessage OUTPUT,@CommentsSourceSystemLkup = @SSLkup,@GEN_QueueId = @GEN_QueueId OUTPUT

						Select @PreviousActionLkup= Q.MostRecentActionLkup, @PreviousWQLkup = Q.MostRecentWorkQueueLkup, @PreviousStsLkup = Q.MostRecentStatusLkup
						From GEN_Queue Q
						Where Q.IsActive = 1 And Q.LockedByRef Is NULL And GEN_QueueId = @GEN_QueueId

						IF EXISTS(Select 1 
									From MQTRRWorkQueueItems 
									Where (IsProcessed = 0 And CMN_BackgroundProcessMasterRef = @CMN_BackgroundProcessMasterRef And TRC In ('285', '018', '015', '014', '013') And TimelineEffectiveDate = @EffectiveDate  
										And [Contract] = @ContractValue And PBP = @PBPValue 
										AND CONVERT(varchar,UTCCreatedOn,101) >= Convert(varchar,GETUTcDate(),101) 
										And CONVERT(varchar,UTCCreatedOn,101) < Convert(varchar,DateAdd(dd,1,GETUTcDate()),101)) OR
										(IsProcessed = 0 And CMN_BackgroundProcessMasterRef = @CMN_BackgroundProcessMasterRef And TRC In ('100') And TRCTypeCode = '61' And TimelineEffectiveDate = @EffectiveDate 
										And ([Contract] <> @ContractValue Or PBP <> @PBPValue) 
										AND CONVERT(varchar,UTCCreatedOn,101) >= Convert(varchar,GETUTcDate(),101) 
										And CONVERT(varchar,UTCCreatedOn,101) < Convert(varchar,DateAdd(dd,1,GETUTcDate()),101)))
						BEGIN
							SET @CurrentActionLkup = 28002			--Close Case
							SET @CurrentWorkQueuesLkup = 10036		--TRR - Completed
							SET @CurrentStatusLkup = 20003			--RESOLVE COMPLETED
							SET @CurrentResolutionLkup = 18006		--Resolution - Close Case
							SET @IsCaseResolved = 1

							--Update Queue
							Update GEN_Queue 
							Set MostRecentStatusLkup = @CurrentStatusLkup
								,MostRecentWorkQueueLkup = @CurrentWorkQueuesLkup
								,[UTCLastUpdatedOn]= @CurrentUTCDate
								,[UTCLastUpdatedOnId]= FORMAT(@CurrentUTCDate, 'yyyyMMdd')
								,[UTCLastUpdatedOnYear]= FORMAT(@CurrentUTCDate, 'yyyy')
								,[UTCLastUpdatedOnMonth]= FORMAT(@CurrentUTCDate, 'MM')
								,[UTCLastUpdatedOnDay]= FORMAT(@CurrentUTCDate, 'dd')
								,[CSTLastUpdatedOn]= DATEADD(hh, -6, @CurrentUTCDate)
								,[CSTLastUpdatedOnId]= FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'yyyyMMdd')
								,[CSTLastUpdatedOnYear]= FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'yyyy')
								,[CSTLastUpdatedOnMonth]= FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'MM')
								,[CSTLastUpdatedOnDay]= FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'dd')
								,[LastUpdatedByRef] = @CurrentUserId
								,[MostRecentActionLkup]= @CurrentActionLkup
								,[IsCaseResolved]=@IsCaseResolved
								,[ResolvedByRef]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE @CurrentUserId END
								,[UTCResolvedOn]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE @CurrentUTCDate END
								,[UTCResolvedOnId]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE FORMAT(@CurrentUTCDate, 'yyyyMMdd') END
								,[UTCResolvedOnYear]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE FORMAT(@CurrentUTCDate, 'yyyy') END
								,[UTCResolvedOnMonth]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE FORMAT(@CurrentUTCDate, 'MM') END
								,[UTCResolvedOnDay]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE FORMAT(@CurrentUTCDate, 'dd') END
								,[CSTResolvedOn]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE DATEADD(hh, -6, @CurrentUTCDate) END
								,[CSTResolvedOnId]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'yyyyMMdd') END
								,[CSTResolvedOnYear]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'yyyy') END
								,[CSTResolvedOnMonth]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'MM') END
								,[CSTResolvedOnDay]= CASE WHEN (@IsCaseResolved = 0) THEN NULL ELSE FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'dd') END
								,[TRCLkup]= @TRCLkup
							Where GEN_QueueId = @GEN_QueueId

							--Update GEN_OSTActions
							If EXISTS (Select 1 From GEN_OSTActions Where GEN_QueueRef = @GEN_QueueId)
							BEGIN
								Update GEN_OSTActions Set ActionLkup = @CurrentActionLkup, ResolutionLkup = @CurrentResolutionLkup, UTCLastUpdatedOn = @CurrentUTCDate, LastUpdatedByRef = @CurrentUserId Where GEN_QueueRef = @GEN_QueueId
							END
							ELSE
							BEGIN
								INSERT INTO [dbo].[GEN_OSTActions]
											([GEN_QueueRef],[ActionLkup],[LastName],[DateofBirth],[ContractIDLkup],[PBPLkup],[ApplicationDate],[EffectiveDate],
											[EndDate],[FirstLetterMailDate],[SecondLetterMailDate],[ResidentialDocumentationRequired],[CountyAttestationRequired],
											[PendReasonLkup],[ContainsErrorsLkup],[ResolutionLkup],[Reason],[InitialAddressVerificationDate],
											[MemberResponseVerificationDate],[MemberVerifiedState],[SCCLetterMailDate],[IsActive],[UTCCreatedOn],[CreatedByRef],
											[UTCLastUpdatedOn],[LastUpdatedByRef])
									VALUES  (@GEN_QueueId,@CurrentActionLkup,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,@CurrentResolutionLkup,NULL,NULL,
											NULL,NULL,NULL,1,@CurrentUTCDate,@CurrentUserId,@CurrentUTCDate,@CurrentUserId)
							END

							--Set Comments
							SET @AuditDescption = 'TRC Code – '+cast(@TRCCode as varchar(5))+' is received and closed and a GPS note was added and Performed By as System: GPS  WQ'

							INSERT INTO [dbo].[GEN_Comments]
										([GEN_QueueRef],[Comments],[ActionLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef],[SourceSystemLkup])
							VALUES      (@GEN_QueueId,@AuditDescption,@CurrentActionLkup,1,@CurrentUTCDate,@CurrentUserId,@CurrentUTCDate,@CurrentUserId,@SSLkup)

							--Add Workflow
							INSERT INTO [dbo].[GEN_QueueWorkFlowCorrelation]
										([GEN_QueueRef],[RoleLkup],[WorkBasketLkup],[DiscrepancyCategoryLkup],[PreviousActionLkup],[PreviousWorkQueuesLkup],
											[PreviousStatusLkup],[CurrentActionLkup],[CurrentWorkQueuesLkup],[CurrentStatusLkup],[IsActive],[UTCCreatedOn],
											[CreatedByRef])
							VALUES		(@GEN_QueueId,2001,3001,@DiscpCat,@PreviousActionLkup,@PreviousWQLkup,@PreviousStsLkup,@CurrentActionLkup,@CurrentWorkQueuesLkup,@CurrentStatusLkup,1,@CurrentUTCDate,@CurrentUserId)

							--Add ManageCases for Action performed
							INSERT INTO [dbo].[GEN_ManageCases]([GEN_QueueRef],[ActionPerformedLkup],[CurrentUserRef],[CasesComments],[ReAssignUserRef],[IsActive],[UTCCreatedOn],
										[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef])
								VALUES  (@GEN_QueueId,@CurrentActionLkup,@CurrentUserId,NULL,NULL,1,@CurrentUTCDate,@CurrentUserId,@CurrentUTCDate,@CurrentUserId)
				
							--Need to enable this, because once a matching record processed, need to mark the filtered record also processed
							Update M 
							Set M.ProcessedGENQueueRef = @GEN_QueueId, M.IsProcessed = 1, M.UTCProcessedOn = @CurrentUTCDate, M.ProcessedByRef = @CurrentUserId, 
								M.UTCLastUpdatedOn = @CurrentUTCDate, M.UpdatedByRef = @CurrentUserId
							From MQTRRWorkQueueItems M 
							Where (IsProcessed = 0 And CMN_BackgroundProcessMasterRef = @CMN_BackgroundProcessMasterRef And TRC In ('285', '018', '015', '014', '013') And TimelineEffectiveDate = @EffectiveDate  
								And [Contract] = @ContractValue And PBP = @PBPValue 
								AND CONVERT(varchar,UTCCreatedOn,101) >= Convert(varchar,GETUTcDate(),101) 
								And CONVERT(varchar,UTCCreatedOn,101) < Convert(varchar,DateAdd(dd,1,GETUTcDate()),101)) OR
								(IsProcessed = 0 And CMN_BackgroundProcessMasterRef = @CMN_BackgroundProcessMasterRef And TRC In ('100') And TRCTypeCode = '61' And TimelineEffectiveDate = @EffectiveDate 
								And ([Contract] <> @ContractValue Or PBP <> @PBPValue) 
								AND CONVERT(varchar,UTCCreatedOn,101) >= Convert(varchar,GETUTcDate(),101) 
								And CONVERT(varchar,UTCCreatedOn,101) < Convert(varchar,DateAdd(dd,1,GETUTcDate()),101))
						END
						ELSE
						BEGIN
							SET @CurrentActionLkup = 28062			--Escalated Action
							SET @CurrentWorkQueuesLkup = 10037		--TRR - Escalated
							SET @CurrentStatusLkup = 20001			--NEW

							--Update Queue
							Update GEN_Queue 
							Set MostRecentStatusLkup = @CurrentStatusLkup
								,MostRecentWorkQueueLkup = @CurrentWorkQueuesLkup
								,[UTCLastUpdatedOn]= @CurrentUTCDate
								,[UTCLastUpdatedOnId]= FORMAT(@CurrentUTCDate, 'yyyyMMdd')
								,[UTCLastUpdatedOnYear]= FORMAT(@CurrentUTCDate, 'yyyy')
								,[UTCLastUpdatedOnMonth]= FORMAT(@CurrentUTCDate, 'MM')
								,[UTCLastUpdatedOnDay]= FORMAT(@CurrentUTCDate, 'dd')
								,[CSTLastUpdatedOn]= DATEADD(hh, -6, @CurrentUTCDate)
								,[CSTLastUpdatedOnId]= FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'yyyyMMdd')
								,[CSTLastUpdatedOnYear]= FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'yyyy')
								,[CSTLastUpdatedOnMonth]= FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'MM')
								,[CSTLastUpdatedOnDay]= FORMAT(DATEADD(hh, -6, @CurrentUTCDate), 'dd')
								,[LastUpdatedByRef] = @CurrentUserId
								,[MostRecentActionLkup]= @CurrentActionLkup
								,[TRCLkup]= @TRCLkup
							Where GEN_QueueId = @GEN_QueueId

							If EXISTS (Select 1 From GEN_OSTActions Where GEN_QueueRef = @GEN_QueueId)
							BEGIN
								Update GEN_OSTActions Set ActionLkup = @CurrentActionLkup, UTCLastUpdatedOn = @CurrentUTCDate, LastUpdatedByRef = @CurrentUserId Where GEN_QueueRef = @GEN_QueueId
							END
							ELSE
							BEGIN
								INSERT INTO [dbo].[GEN_OSTActions]
											([GEN_QueueRef],[ActionLkup],[LastName],[DateofBirth],[ContractIDLkup],[PBPLkup],[ApplicationDate],[EffectiveDate],
											[EndDate],[FirstLetterMailDate],[SecondLetterMailDate],[ResidentialDocumentationRequired],[CountyAttestationRequired],
											[PendReasonLkup],[ContainsErrorsLkup],[ResolutionLkup],[Reason],[InitialAddressVerificationDate],
											[MemberResponseVerificationDate],[MemberVerifiedState],[SCCLetterMailDate],[IsActive],[UTCCreatedOn],[CreatedByRef],
											[UTCLastUpdatedOn],[LastUpdatedByRef])
									VALUES  (@GEN_QueueId,@CurrentActionLkup,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,
											NULL,NULL,NULL,1,@CurrentUTCDate,@CurrentUserId,@CurrentUTCDate,@CurrentUserId)
							END

							--Set Comments
							SET @AuditDescption = 'TRC Code – '+cast(@TRCCode as varchar(5))+' is received and the current plan is termed with no other associated TRR Codes, and record was routed to the  Escalation queue and Performed By as System: GPS  WQ'

							INSERT INTO [dbo].[GEN_Comments]
										([GEN_QueueRef],[Comments],[ActionLkup],[IsActive],[UTCCreatedOn],[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef],[SourceSystemLkup])
							VALUES      (@GEN_QueueId,@AuditDescption,@CurrentActionLkup,1,@CurrentUTCDate,@CurrentUserId,@CurrentUTCDate,@CurrentUserId,@SSLkup)

							--Add Workflow
							INSERT INTO [dbo].[GEN_QueueWorkFlowCorrelation]
										([GEN_QueueRef],[RoleLkup],[WorkBasketLkup],[DiscrepancyCategoryLkup],[PreviousActionLkup],[PreviousWorkQueuesLkup],
											[PreviousStatusLkup],[CurrentActionLkup],[CurrentWorkQueuesLkup],[CurrentStatusLkup],[IsActive],[UTCCreatedOn],
											[CreatedByRef])
							VALUES		(@GEN_QueueId,2001,3001,@DiscpCat,@PreviousActionLkup,@PreviousWQLkup,@PreviousStsLkup,@CurrentActionLkup,@CurrentWorkQueuesLkup,@CurrentStatusLkup,1,@CurrentUTCDate,@CurrentUserId)

							--Add ManageCases for Action performed
							INSERT INTO [dbo].[GEN_ManageCases]([GEN_QueueRef],[ActionPerformedLkup],[CurrentUserRef],[CasesComments],[ReAssignUserRef],[IsActive],[UTCCreatedOn],
										[CreatedByRef],[UTCLastUpdatedOn],[LastUpdatedByRef])
								VALUES  (@GEN_QueueId,@CurrentActionLkup,@CurrentUserId,NULL,NULL,1,@CurrentUTCDate,@CurrentUserId,@CurrentUTCDate,@CurrentUserId)
						END						
					END
					ELSE
					BEGIN
						SET @TRC016Count = 0
						Select @TRC016Count = Count(1) From MQTRRWorkQueueItems Where IsProcessed = 0 And CMN_BackgroundProcessMasterRef = @CMN_BackgroundProcessMasterRef And TRC = '016' And HICN = @HICN

						IF(@TRC016Count = 1)
						BEGIN
							IF(@GPSPDPAutoEnrolleIndicator = 1)  --PDP
							BEGIN
								--If Single TRC 016 & PDP AutoEnrolle true, then Send OOA Letter

								SET @CurrentActionLkup = 28015			--Action : Send OOA Letter
								SET @CurrentWorkQueuesLkup = 10007		--OOA - New Case
								SET @CurrentStatusLkup = 20001			--NEW
								SET @OOALetterStatusLkup = 53001        --Send OOA Letter Status - Ready

								SET @AuditDescption = 'TRC Code – '+cast(@TRCCode as varchar(5))+' is received, a new case is created with Status New and Performed By as System: GPS WQ (OOA Letter will be triggered)'

								EXEC [USP_APP_INS_CreateSuspectCase] @BusinessSegmentLkup = 1001, @WorkBasketLkup = 3001, @DiscrepancyCategoryLkup = 6001, @DiscrepancyTypeLkup = 7001,
								@MostRecentActionLkup = @CurrentActionLkup,@MostRecentWorkQueueLkup = @CurrentWorkQueuesLkup, @MostRecentStatusLkup = @CurrentStatusLkup, @SourceSystemLkup = @SSLkup, @DiscrepancySourceLkup = 13001, 
								@DiscrepancyReceiptDate = @CurrentUTCDate, @DiscrepancyReceiptDateId = @UTCDateId, @ComplianceStartDate = @FileReceiptDate,@ComplianceStartDateId = @ComplianceStartDateId,
								@DisenrollmentDate = @DisenrollDate, @MemberSCCCode = @SCCCode, @MemberCurrentHICN = @HICN, @GPSHouseholdID = @HouseHoldId,
								@MemberFirstName = @FirstName,@MemberLastName = @LastName, @MemberContractIDLkup = @Contract,@MemberPBPLkup = @PBP,@MemberLOBLkup = @LOB,
								@MemberDOB = @MemberDOB,@MemberDOBId = @MemberDOBId,@EligOOAFlagLkup = 0,@RPRCTMMember = 0,@RPREGHPMember = 0,@IsParentCase = 0,
								@IsChildCase = 0,@Comments = @AuditDescption,@RoleLkup = 2001,
								@CurrentActionLkup = @CurrentActionLkup,@CurrentWorkQueuesLkup = @CurrentWorkQueuesLkup,@CurrentStatusLkup = @CurrentStatusLkup,@LoginUserId = @CurrentUserId,
								@OOALetterStatusLkup = @OOALetterStatusLkup,@TRCLkup=@TRCLkup,@IsRestricted = @IsRestricted,@ErrorMessage = @ErrorMessage OUTPUT,@CommentsSourceSystemLkup = @SSLkup,@GEN_QueueId = @GEN_QueueId OUTPUT
							END
							ELSE
							BEGIN
								SET @TRC700SeriesCount = 0
								Select @TRC700SeriesCount = Count(1) From MQTRRWorkQueueItems Where IsProcessed = 0 And CMN_BackgroundProcessMasterRef = @CMN_BackgroundProcessMasterRef And HICN = @HICN And [Contract]= @ContractValue And PBP = @PBPValue And [TRC] BETWEEN 700 AND 799
					
								IF(@GPSApplicationStatus = 'APPROVED' AND @TRC700SeriesCount = 0)
								BEGIN
									--App status = Approved and Related 016 TRC code is not associated with a TRC in the 700 Series, then Send CMS Transaction Update

									SET @CurrentActionLkup = 28017			--Send SCC Update to CMS
									SET @CurrentWorkQueuesLkup = 10037		--Queue - TRR - Escalated
									SET @CurrentStatusLkup = 20002			--Inprogress
									SET @CMSTransactionStatusLkup = 55001	--Ready to Send CMS Transaction Update

									SET @AuditDescption = 'TRC Code – '+cast(@TRCCode as varchar(5))+' is received, a new case is created with Status In Progress and Performed By as System: GPS  WQ (CMS Transaction Update will be triggered)'

									EXEC [USP_APP_INS_CreateSuspectCase] @BusinessSegmentLkup = 1001, @WorkBasketLkup = 3001, @DiscrepancyCategoryLkup = 6003, @DiscrepancyTypeLkup = 7001,
									@MostRecentActionLkup = @CurrentActionLkup,@MostRecentWorkQueueLkup = @CurrentWorkQueuesLkup, @MostRecentStatusLkup = @CurrentStatusLkup, @SourceSystemLkup = @SSLkup, @DiscrepancySourceLkup = 13001, 
									@DiscrepancyReceiptDate = @CurrentUTCDate, @DiscrepancyReceiptDateId = @UTCDateId, @ComplianceStartDate = @FileReceiptDate,@ComplianceStartDateId = @ComplianceStartDateId,
									@DisenrollmentDate = @DisenrollDate, @MemberSCCCode = @SCCCode, @MemberCurrentHICN = @HICN, @GPSHouseholdID = @HouseHoldId,
									@MemberFirstName = @FirstName,@MemberLastName = @LastName, @MemberContractIDLkup = @Contract,@MemberPBPLkup = @PBP,@MemberLOBLkup = @LOB,
									@MemberDOB = @MemberDOB,@MemberDOBId = @MemberDOBId,@EligOOAFlagLkup = 0,@RPRCTMMember = 0,@RPREGHPMember = 0,@IsParentCase = 0,
									@IsChildCase = 0,@Comments = @AuditDescption,@RoleLkup = 2001,
									@CurrentActionLkup = @CurrentActionLkup,@CurrentWorkQueuesLkup = @CurrentWorkQueuesLkup,@CurrentStatusLkup = @CurrentStatusLkup,@LoginUserId = @CurrentUserId,
									@CMSTransactionStatusLkup = @CMSTransactionStatusLkup,@TRCLkup=@TRCLkup,@IsRestricted = @IsRestricted,@ErrorMessage = @ErrorMessage OUTPUT,@CommentsSourceSystemLkup = @SSLkup,@GEN_QueueId = @GEN_QueueId OUTPUT
								END
								ELSE
								BEGIN
									--If Related 700 series found, then escalate the case and provide comment with TRC 700 series value.

									SET @CurrentActionLkup = 28032			--Save
									SET @CurrentWorkQueuesLkup = 10037		--Queue - TRR - Escalated
									SET @CurrentStatusLkup = 20001			--NEW

									IF(@TRC700SeriesCount > 0)
									BEGIN
										SET @TRC700SeriesValue = ''
										Select @TRC700SeriesValue = Max(TRC) From MQTRRWorkQueueItems Where IsProcessed = 0 And CMN_BackgroundProcessMasterRef = @CMN_BackgroundProcessMasterRef And HICN = @HICN And [Contract]= @ContractValue And PBP = @PBPValue And [TRC] BETWEEN 700 AND 799

										SET @AuditDescption = 'TRC Code – '+cast(@TRCCode as varchar(5))+' is received with an associated 700 series '+@TRC700SeriesValue+', a new case is created with Status New and Performed By as System: GPS  WQ'
									END
									ELSE
									BEGIN
										SET @AuditDescption = 'TRC Code – '+cast(@TRCCode as varchar(5))+' is received without an associated 700 series and application status is NULL or not approved, a new case is created with Status New and Performed By as System: GPS  WQ'
									END

									EXEC [USP_APP_INS_CreateSuspectCase] @BusinessSegmentLkup = 1001, @WorkBasketLkup = 3001, @DiscrepancyCategoryLkup = 6003, @DiscrepancyTypeLkup = 7001,
									@MostRecentActionLkup = @CurrentActionLkup,@MostRecentWorkQueueLkup = @CurrentWorkQueuesLkup, @MostRecentStatusLkup = @CurrentStatusLkup, @SourceSystemLkup = @SSLkup, @DiscrepancySourceLkup = 13001, 
									@DiscrepancyReceiptDate = @CurrentUTCDate, @DiscrepancyReceiptDateId = @UTCDateId, @ComplianceStartDate = @FileReceiptDate,@ComplianceStartDateId = @ComplianceStartDateId,
									@DisenrollmentDate = @DisenrollDate, @MemberSCCCode = @SCCCode, @MemberCurrentHICN = @HICN, @GPSHouseholdID = @HouseHoldId,
									@MemberFirstName = @FirstName,@MemberLastName = @LastName, @MemberContractIDLkup = @Contract,@MemberPBPLkup = @PBP,@MemberLOBLkup = @LOB,
									@MemberDOB = @MemberDOB,@MemberDOBId = @MemberDOBId,@EligOOAFlagLkup = 0,@RPRCTMMember = 0,@RPREGHPMember = 0,@IsParentCase = 0,
									@IsChildCase = 0,@Comments = @AuditDescption,@RoleLkup = 2001,
									@CurrentActionLkup = @CurrentActionLkup,@CurrentWorkQueuesLkup = @CurrentWorkQueuesLkup,@CurrentStatusLkup = @CurrentStatusLkup,@LoginUserId = @CurrentUserId,
									@TRCLkup=@TRCLkup,@IsRestricted = @IsRestricted,@ErrorMessage = @ErrorMessage OUTPUT,@CommentsSourceSystemLkup = @SSLkup,@GEN_QueueId = @GEN_QueueId OUTPUT
								END					
							END							
						END
						ELSE IF(@TRC016Count > 1)
						BEGIN
							SET @TotalTRC016CntByIndvId = 0
							Select @TotalTRC016CntByIndvId = Count(1) From MQTRRWorkQueueItems Where IsProcessed = 0 And CMN_BackgroundProcessMasterRef = @CMN_BackgroundProcessMasterRef And TRC = '016' And HICN = @HICN

							SET @TRC016GroupByIndvIdCnt = 0
							Select @TRC016GroupByIndvIdCnt = Count(1) From MQTRRWorkQueueItems Where IsProcessed = 0 And CMN_BackgroundProcessMasterRef = @CMN_BackgroundProcessMasterRef And TRC = '016' And HICN = @HICN
							Group By IndividualID,[Contract],PBP,TimelineEffectiveDate

							SET @TotalTRC016CntByIndvIdndEffectDate = 0
							Select @TotalTRC016CntByIndvIdndEffectDate = Count(1) From MQTRRWorkQueueItems Where IsProcessed = 0 And CMN_BackgroundProcessMasterRef = @CMN_BackgroundProcessMasterRef And TRC = '016' And HICN = @HICN And TimelineEffectiveDate = @EffectiveDate

							SET @TRC016GroupByIndvIdCntndEffectDate = 0
							Select @TRC016GroupByIndvIdCntndEffectDate = Count(1) From MQTRRWorkQueueItems Where IsProcessed = 0 And CMN_BackgroundProcessMasterRef = @CMN_BackgroundProcessMasterRef And TRC = '016' And HICN = @HICN And TimelineEffectiveDate = @EffectiveDate
							Group By IndividualID,[Contract],PBP,TimelineEffectiveDate

							SET @TRC016ApprovedCount = 0
							Select @TRC016ApprovedCount = Count(1) From MQTRRWorkQueueItems Where IsProcessed = 0 And CMN_BackgroundProcessMasterRef = @CMN_BackgroundProcessMasterRef And TRC = '016' And HICN = @HICN And TimelineEffectiveDate = @EffectiveDate And GPSApplicationStatus = 'APPROVED'

							If((@TotalTRC016CntByIndvId = @TRC016GroupByIndvIdCnt) Or (@TotalTRC016CntByIndvIdndEffectDate = @TRC016GroupByIndvIdCntndEffectDate And @TRC016ApprovedCount>0))  --Records for Same Member But different Contract + PBP + Effective Date
							BEGIN
								IF(@GPSPDPAutoEnrolleIndicator = 1)  --PDP
								BEGIN
									SET @CurrentActionLkup = 28015			--Action : Send OOA Letter
									SET @CurrentWorkQueuesLkup = 10007		--OOA - New Case
									SET @CurrentStatusLkup = 20001			--NEW
									SET @OOALetterStatusLkup = 53001        --Send OOA Letter Status - Ready

									SET @AuditDescption = 'TRC Code – '+cast(@TRCCode as varchar(5))+' is received, a new case is created with Status New and Performed By as System: GPS WQ (OOA Letter will be triggered)'

									EXEC [USP_APP_INS_CreateSuspectCase] @BusinessSegmentLkup = 1001, @WorkBasketLkup = 3001, @DiscrepancyCategoryLkup = 6001, @DiscrepancyTypeLkup = 7001,
									@MostRecentActionLkup = @CurrentActionLkup,@MostRecentWorkQueueLkup = @CurrentWorkQueuesLkup, @MostRecentStatusLkup = @CurrentStatusLkup, @SourceSystemLkup = @SSLkup, @DiscrepancySourceLkup = 13001, 
									@DiscrepancyReceiptDate = @CurrentUTCDate, @DiscrepancyReceiptDateId = @UTCDateId, @ComplianceStartDate = @FileReceiptDate,@ComplianceStartDateId = @ComplianceStartDateId,
									@DisenrollmentDate = @DisenrollDate, @MemberSCCCode = @SCCCode, @MemberCurrentHICN = @HICN, @GPSHouseholdID = @HouseHoldId,
									@MemberFirstName = @FirstName,@MemberLastName = @LastName, @MemberContractIDLkup = @Contract,@MemberPBPLkup = @PBP,@MemberLOBLkup = @LOB,
									@MemberDOB = @MemberDOB,@MemberDOBId = @MemberDOBId,@EligOOAFlagLkup = 0,@RPRCTMMember = 0,@RPREGHPMember = 0,@IsParentCase = 0,
									@IsChildCase = 0,@Comments = @AuditDescption,@RoleLkup = 2001,
									@CurrentActionLkup = @CurrentActionLkup,@CurrentWorkQueuesLkup = @CurrentWorkQueuesLkup,@CurrentStatusLkup = @CurrentStatusLkup,@LoginUserId = @CurrentUserId,
									@OOALetterStatusLkup = @OOALetterStatusLkup,@TRCLkup=@TRCLkup,@IsRestricted = @IsRestricted,@ErrorMessage = @ErrorMessage OUTPUT,@CommentsSourceSystemLkup = @SSLkup,@GEN_QueueId = @GEN_QueueId OUTPUT
								END
								ELSE
								BEGIN
									SET @ApprovedCount = 0
									Select @ApprovedCount = Count(1) From MQTRRWorkQueueItems 
									Where IsProcessed = 0 And CMN_BackgroundProcessMasterRef = @CMN_BackgroundProcessMasterRef And HICN = @HICN And [Contract]= @ContractValue And PBP = @PBPValue And TimelineEffectiveDate = @GPSProposedEffectiveDate And GPSApplicationStatus = 'APPROVED' And [TRC] NOT BETWEEN 700 AND 799

									IF(@ApprovedCount>0)
									BEGIN
										SET @CurrentActionLkup = 28017			--Send SCC Update to CMS
										SET @CurrentWorkQueuesLkup = 10037		--Queue - TRR - Escalated
										SET @CurrentStatusLkup = 20001			--NEW
										SET @CMSTransactionStatusLkup = 55001	--Ready to Send CMS Transaction Update

										SET @AuditDescption = 'TRC Code – '+cast(@TRCCode as varchar(5))+' is received, a new case is created with Status New and Performed By as System: GPS WQ (CMS Transaction Update will be triggered)'

										EXEC [USP_APP_INS_CreateSuspectCase] @BusinessSegmentLkup = 1001, @WorkBasketLkup = 3001, @DiscrepancyCategoryLkup = 6003, @DiscrepancyTypeLkup = 7001,
										@MostRecentActionLkup = @CurrentActionLkup,@MostRecentWorkQueueLkup = @CurrentWorkQueuesLkup, @MostRecentStatusLkup = @CurrentStatusLkup, @SourceSystemLkup = @SSLkup, @DiscrepancySourceLkup = 13001, 
										@DiscrepancyReceiptDate = @CurrentUTCDate, @DiscrepancyReceiptDateId = @UTCDateId, @ComplianceStartDate = @FileReceiptDate,@ComplianceStartDateId = @ComplianceStartDateId,
										@DisenrollmentDate = @DisenrollDate, @MemberSCCCode = @SCCCode, @MemberCurrentHICN = @HICN, @GPSHouseholdID = @HouseHoldId,
										@MemberFirstName = @FirstName,@MemberLastName = @LastName, @MemberContractIDLkup = @Contract,@MemberPBPLkup = @PBP,@MemberLOBLkup = @LOB,
										@MemberDOB = @MemberDOB,@MemberDOBId = @MemberDOBId,@EligOOAFlagLkup = 0,@RPRCTMMember = 0,@RPREGHPMember = 0,@IsParentCase = 0,
										@IsChildCase = 0,@Comments = @AuditDescption,@RoleLkup = 2001,
										@CurrentActionLkup = @CurrentActionLkup,@CurrentWorkQueuesLkup = @CurrentWorkQueuesLkup,@CurrentStatusLkup = @CurrentStatusLkup,@LoginUserId = @CurrentUserId,
										@CMSTransactionStatusLkup = @CMSTransactionStatusLkup,@TRCLkup=@TRCLkup,@IsRestricted = @IsRestricted,@ErrorMessage = @ErrorMessage OUTPUT,@CommentsSourceSystemLkup = @SSLkup,@GEN_QueueId = @GEN_QueueId OUTPUT
									END
									ELSE
									BEGIN
										SET @CurrentActionLkup = 28032			--Save
										SET @CurrentWorkQueuesLkup = 10037		--Queue - TRR - Escalated
										SET @CurrentStatusLkup = 20002			--INPROGRESS

										IF(@ApprovedCount = 0)
										BEGIN
											SET @TRC700SeriesValue = ''
											Select @TRC700SeriesValue = Max(TRC) From MQTRRWorkQueueItems
											Where IsProcessed = 0 And CMN_BackgroundProcessMasterRef = @CMN_BackgroundProcessMasterRef And HICN = @HICN And [Contract]= @ContractValue And PBP = @PBPValue And TimelineEffectiveDate = @GPSProposedEffectiveDate And GPSApplicationStatus = 'APPROVED' And [TRC] BETWEEN 700 AND 799

											SET @AuditDescption = 'TRC Code – '+cast(@TRCCode as varchar(5))+' is received with an associated 700 series '+@TRC700SeriesValue+', a new case is created with Status New and Performed By as System: GPS  WQ'
										END
										ELSE
										BEGIN
											SET @AuditDescption = 'TRC Code – '+cast(@TRCCode as varchar(5))+' is received without an associated 700 series and application status is not approved, a new case is created with Status New and Performed By as System: GPS  WQ'
										END

										EXEC [USP_APP_INS_CreateSuspectCase] @BusinessSegmentLkup = 1001, @WorkBasketLkup = 3001, @DiscrepancyCategoryLkup = 6003, @DiscrepancyTypeLkup = 7001,
										@MostRecentActionLkup = @CurrentActionLkup,@MostRecentWorkQueueLkup = @CurrentWorkQueuesLkup, @MostRecentStatusLkup = @CurrentStatusLkup, @SourceSystemLkup = @SSLkup, @DiscrepancySourceLkup = 13001, 
										@DiscrepancyReceiptDate = @CurrentUTCDate, @DiscrepancyReceiptDateId = @UTCDateId, @ComplianceStartDate = @FileReceiptDate,@ComplianceStartDateId = @ComplianceStartDateId,
										@DisenrollmentDate = @DisenrollDate, @MemberSCCCode = @SCCCode, @MemberCurrentHICN = @HICN, @GPSHouseholdID = @HouseHoldId,
										@MemberFirstName = @FirstName,@MemberLastName = @LastName, @MemberContractIDLkup = @Contract,@MemberPBPLkup = @PBP,@MemberLOBLkup = @LOB,
										@MemberDOB = @MemberDOB,@MemberDOBId = @MemberDOBId,@EligOOAFlagLkup = 0,@RPRCTMMember = 0,@RPREGHPMember = 0,@IsParentCase = 0,
										@IsChildCase = 0,@Comments = @AuditDescption,@RoleLkup = 2001,
										@CurrentActionLkup = @CurrentActionLkup,@CurrentWorkQueuesLkup = @CurrentWorkQueuesLkup,@CurrentStatusLkup = @CurrentStatusLkup,@LoginUserId = @CurrentUserId,
										@TRCLkup=@TRCLkup,@IsRestricted = @IsRestricted,@ErrorMessage = @ErrorMessage OUTPUT,@CommentsSourceSystemLkup = @SSLkup,@GEN_QueueId = @GEN_QueueId OUTPUT
									END
								END
							END	
							ELSE
							BEGIN 
								SET @CurrentActionLkup = 28032			--Save
								SET @CurrentWorkQueuesLkup = 10037		--Queue - TRR - Escalated
								SET @CurrentStatusLkup = 20002			--INPROGRESS

								SET @AuditDescption = 'Multiple TRC Code – '+cast(@TRCCode as varchar(5))+' have been received and did not meet any conditions for the TRC16 workflow, a new case is created with Status New and Performed By as System: GPS  WQ'

								EXEC [USP_APP_INS_CreateSuspectCase] @BusinessSegmentLkup = 1001, @WorkBasketLkup = 3001, @DiscrepancyCategoryLkup = 6003, @DiscrepancyTypeLkup = 7001,
								@MostRecentActionLkup = @CurrentActionLkup,@MostRecentWorkQueueLkup = @CurrentWorkQueuesLkup, @MostRecentStatusLkup = @CurrentStatusLkup, @SourceSystemLkup = @SSLkup, @DiscrepancySourceLkup = 13001, 
								@DiscrepancyReceiptDate = @CurrentUTCDate, @DiscrepancyReceiptDateId = @UTCDateId, @ComplianceStartDate = @FileReceiptDate,@ComplianceStartDateId = @ComplianceStartDateId,
								@DisenrollmentDate = @DisenrollDate, @MemberSCCCode = @SCCCode, @MemberCurrentHICN = @HICN, @GPSHouseholdID = @HouseHoldId,
								@MemberFirstName = @FirstName,@MemberLastName = @LastName, @MemberContractIDLkup = @Contract,@MemberPBPLkup = @PBP,@MemberLOBLkup = @LOB,
								@MemberDOB = @MemberDOB,@MemberDOBId = @MemberDOBId,@EligOOAFlagLkup = 0,@RPRCTMMember = 0,@RPREGHPMember = 0,@IsParentCase = 0,
								@IsChildCase = 0,@Comments = @AuditDescption,@RoleLkup = 2001,
								@CurrentActionLkup = @CurrentActionLkup,@CurrentWorkQueuesLkup = @CurrentWorkQueuesLkup,@CurrentStatusLkup = @CurrentStatusLkup,@LoginUserId = @CurrentUserId,
								@TRCLkup=@TRCLkup,@IsRestricted = @IsRestricted,@ErrorMessage = @ErrorMessage OUTPUT,@CommentsSourceSystemLkup = @SSLkup,@GEN_QueueId = @GEN_QueueId OUTPUT					
							END							
						END
					END
				END
			END

			SET @IterationCount = @IterationCount+1

			IF(LEN(@ProcessedQueueIds) > 0)
			BEGIN
				SET @ProcessedQueueIds = @ProcessedQueueIds + ','
			END

			IF(@ClosedQueueIdForReference > 0)
			BEGIN
				SET @ProcessedQueueIds = @ProcessedQueueIds + Cast(@ClosedQueueIdForReference as Varchar) + ',' +Cast(@GEN_QueueId as Varchar)
			END
			ELSE
			BEGIN
				SET @ProcessedQueueIds = @ProcessedQueueIds + Cast(@GEN_QueueId as Varchar)
			END

			IF(@TotalRecordsCount = 0)
			BEGIN
				BREAK;
			END
		END

		--Update MQTRRWorkItem as IsProcessed = 1
		Update MQTRRWorkQueueItems Set ProcessedGENQueueRef = @ProcessedQueueIds, IsProcessed = 1, UTCProcessedOn = @CurrentUTCDate,ProcessedByRef = @CurrentUserId, UTCLastUpdatedOn = @CurrentUTCDate, UpdatedByRef = @CurrentUserId Where IsProcessed = 0 And HICN = @HICN And TRC = '016' ANd CMN_BackgroundProcessMasterRef = @CMN_BackgroundProcessMasterRef

		DROP Table #TempRecordsToProcess
	END
	-------- END ----------
END


COMMIT TRAN
END TRY
BEGIN CATCH
	BEGIN TRY ROLLBACK TRAN; END TRY BEGIN CATCH END CATCH
	Set @ErrorMessage = Error_Message()
END CATCH
END
GO