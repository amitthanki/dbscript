IF OBJECT_ID ('USP_APP_SEL_PendedRecords') IS NOT NULL 
BEGIN
	DROP PROC [dbo].[USP_APP_SEL_PendedRecords]
END
GO

/****** Object:  StoredProcedure [dbo].[USP_APP_SEL_PendedRecords]    Script Date: 30-06-2017 16:46:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: Rakesh
-- Create date: 06/30/2017
-- Modified By: 
-- Modification Date: 
-- Description: Get Pended records from the queue within the date range
-- Eg.
-- Declare @ErrorMessage VARCHAR(2000)
-- Set @ErrorMessage=''
-- Exec [USP_APP_SEL_PendedRecords] @ErrorMessage = @ErrorMessage Output
-- =============================================
CREATE PROCEDURE [dbo].[USP_APP_SEL_PendedRecords]
@PendedByRef BIGINT,
@BusinessSegmentLkup BIGINT,
@DiscrepancyCategoryLkup BIGINT = NULL,
@WorkBasketLkup BIGINT = NULL,
@ErrorMessage VARCHAR(2000) OUT
AS
BEGIN  
	BEGIN TRY
		--Get Pended records for the particular Queue(QueueLkup) from the GEN_Queue
		BEGIN
		IF(@WorkBasketLkup = 3001)
			BEGIN
				SELECT DISTINCT TOP 500
				   GQ.[GEN_QueueId],GQ.[BusinessSegmentLkup],LMBusinessSegment.LookupValue AS BusinessSegment,GQ.[WorkBasketLkup],GQ.[WorkBasketLkup],LMWorkBasket.LookupValue AS WorkBasket,GQ.[DiscrepancyCategoryLkup],LMDiscrepancyCategory.LookupValue AS DiscrepancyCategory,GQ.[DiscrepancyTypeLkup],LMDiscrepancyType.LookupValue AS DiscrepancyType
				  ,GQ.[MostRecentActionLkup], LMMostRecentAction.LookupValue AS MostRecentAction
				  ,GQ.[MostRecentWorkQueueLkup],LMMostRecentWorkQueue.LookupValue AS MostRecentWorkQueue,GQ.[MostRecentStatusLkup],LMMostRecentStatus.LookupValue AS MostRecentStatus
				  ,GQ.[ComplianceStartDate],GQ.[DisenrollmentDate],[dbo].[GetAge](GQ.[GEN_QueueId]) as Aging,GQ.[DiscrepancyStartDate],GQ.[DiscrepancyEndDate],GQ.[MemberSCCCode]
				  ,GQ.[MemberID],GQ.[MemberMedicareId] AS [MemberCurrentHICN],GQ.[GPSHouseholdID],GQ.[MemberFirstName],GQ.[MemberMiddleName],GQ.[MemberLastName],GQ.[MemberContractIDLkup],LMMemberContractID.LookupValue AS MemberContractID
				  ,GQ.[MemberPBPLkup],LMMemberPBP.LookupValue AS MemberPBP,GQ.[MemberLOBLkup],LMMemberLOB.LookupValue AS MemberLOB,GQ.[MemberVerifiedState],GQ.[MemberVerifiedCountyCode],GQ.[MemberDOB],GQ.[MemberGenderLkup],LMMemberGender.LookupValue AS MemberGender
				  ,[dbo].[GetAge](GQ.[GEN_QueueId]) AS [CaseAge],GQ.[DisenrollmentDate],GQ.[IsCasePended],GQ.[PendedbyRef],UMPendedby.FullName AS Pendedby,GQ.[UTCPendedOn]
				  ,GQ.[IsActive],GQ.[UTCCreatedOn],GQ.[CreatedByRef],UMCreatedBy.FullName AS CreatedBy,GQ.[UTCLastUpdatedOn],GQ.[LastUpdatedByRef],UMLastUpdatedBy.FullName AS LastUpdatedBy,
				  ActOST.PendReasonLkup AS PendReasonLkup,
				  LMOSTPendReason.LookupValue AS PendReason
			 FROM [dbo].[GEN_Queue] GQ With(Nolock)
				INNER JOIN [dbo].[GEN_OSTActions] ActOST With(Nolock) ON GQ.[Gen_QueueId] = ActOST.[Gen_QueueRef] AND GQ.[WorkBasketLkup] = @WorkBasketLkup AND ActOST.IsActive=1
				LEFT JOIN [dbo].[CMN_LookupMaster] LMOSTPendReason With(Nolock) ON ActOST.[PendReasonLkup]=LMOSTPendReason.[CMN_LookupMasterId] AND GQ.[WorkBasketLkup] = @WorkBasketLkup AND LMOSTPendReason.IsActive=1
				LEFT JOIN [dbo].[CMN_LookupMaster] LMBusinessSegment  With(Nolock) ON GQ.[BusinessSegmentLkup]=LMBusinessSegment.[CMN_LookupMasterId] AND LMBusinessSegment.IsActive=1
				LEFT JOIN [dbo].[CMN_LookupMaster] LMWorkBasket  With(Nolock) ON GQ.[WorkBasketLkup]=LMWorkBasket.[CMN_LookupMasterId] AND LMWorkBasket.IsActive=1
				LEFT JOIN [dbo].[CMN_LookupMaster] LMDiscrepancyCategory With(Nolock) ON GQ.[DiscrepancyCategoryLkup]=LMDiscrepancyCategory.[CMN_LookupMasterId] AND LMDiscrepancyCategory.IsActive=1
				LEFT JOIN [dbo].[CMN_LookupMaster] LMDiscrepancyType With(Nolock) ON GQ.[DiscrepancyTypeLkup]=LMDiscrepancyType.[CMN_LookupMasterId] AND LMDiscrepancyType.IsActive=1
				LEFT JOIN [dbo].[CMN_LookupMaster] LMMostRecentAction With(Nolock) ON GQ.[MostRecentActionLkup]=LMMostRecentAction.[CMN_LookupMasterId] AND LMMostRecentAction.IsActive=1
				LEFT JOIN [dbo].[CMN_LookupMaster] LMMostRecentWorkQueue With(Nolock) ON GQ.[MostRecentWorkQueueLkup]=LMMostRecentWorkQueue.[CMN_LookupMasterId] AND LMMostRecentWorkQueue.IsActive=1
				LEFT JOIN [dbo].[CMN_LookupMaster] LMMostRecentStatus With(Nolock) ON GQ.[MostRecentStatusLkup]=LMMostRecentStatus.[CMN_LookupMasterId] AND LMMostRecentStatus.IsActive=1
				LEFT JOIN [dbo].[CMN_LookupMaster] LMMemberContractID With(Nolock) ON GQ.[MemberContractIDLkup]=LMMemberContractID.[CMN_LookupMasterId] AND LMMemberContractID.IsActive=1
				LEFT JOIN [dbo].[CMN_LookupMaster] LMMemberPBP With(Nolock) ON GQ.[MemberPBPLkup]=LMMemberPBP.[CMN_LookupMasterId] AND LMMemberPBP.IsActive=1
				LEFT JOIN [dbo].[CMN_LookupMaster] LMMemberLOB With(Nolock) ON GQ.[MemberLOBLkup]=LMMemberLOB.[CMN_LookupMasterId] AND LMMemberLOB.IsActive=1
				LEFT JOIN [dbo].[CMN_LookupMaster] LMMemberGender With(Nolock) ON GQ.[MemberGenderLkup]=LMMemberGender.[CMN_LookupMasterId] AND LMMemberGender.IsActive=1
				INNER JOIN [dbo].[ADM_UserMaster] UMCreatedBy  With(Nolock) ON GQ.CreatedByRef=UMCreatedBy.[ADM_UserMasterId]
				INNER JOIN [dbo].[ADM_UserMaster] UMLastUpdatedBy  With(Nolock) ON GQ.LastUpdatedByRef=UMLastUpdatedBy.[ADM_UserMasterId]
				INNER JOIN [dbo].[ADM_UserMaster] UMPendedby  With(Nolock) ON GQ.PendedbyRef=UMPendedby.[ADM_UserMasterId]
				WHERE GQ.[BusinessSegmentLkup] = @BusinessSegmentLkup AND (@WorkBasketLkup IS NULL OR GQ.[WorkBasketLkup] = @WorkBasketLkup) AND 
					  (@DiscrepancyCategoryLkup IS NULL OR GQ.[DiscrepancyCategoryLkup]=@DiscrepancyCategoryLkup) AND GQ.[IsCasePended] = 1 AND GQ.[PendedbyRef] = @PendedByRef AND GQ.[IsActive] = 1
				ORDER BY [UTCCreatedOn]
			END
		ELSE IF(@WorkBasketLkup = 3002)
			BEGIN
				SELECT DISTINCT TOP 500
				   GQ.[GEN_QueueId],GQ.[BusinessSegmentLkup],LMBusinessSegment.LookupValue AS BusinessSegment,GQ.[WorkBasketLkup],GQ.[WorkBasketLkup],LMWorkBasket.LookupValue AS WorkBasket,GQ.[DiscrepancyCategoryLkup],LMDiscrepancyCategory.LookupValue AS DiscrepancyCategory,GQ.[DiscrepancyTypeLkup],LMDiscrepancyType.LookupValue AS DiscrepancyType
				  ,GQ.[MostRecentActionLkup], LMMostRecentAction.LookupValue AS MostRecentAction
				  ,GQ.[MostRecentWorkQueueLkup],LMMostRecentWorkQueue.LookupValue AS MostRecentWorkQueue,GQ.[MostRecentStatusLkup],LMMostRecentStatus.LookupValue AS MostRecentStatus
				  ,GQ.[ComplianceStartDate],GQ.[DisenrollmentDate],[dbo].[GetAge](GQ.[GEN_QueueId]) as Aging,GQ.[DiscrepancyStartDate],GQ.[DiscrepancyEndDate],GQ.[MemberSCCCode]
				  ,GQ.[MemberID],GQ.[MemberMedicareId] AS [MemberCurrentHICN],GQ.[GPSHouseholdID],GQ.[MemberFirstName],GQ.[MemberMiddleName],GQ.[MemberLastName],GQ.[MemberContractIDLkup],LMMemberContractID.LookupValue AS MemberContractID
				  ,GQ.[MemberPBPLkup],LMMemberPBP.LookupValue AS MemberPBP,GQ.[MemberLOBLkup],LMMemberLOB.LookupValue AS MemberLOB,GQ.[MemberVerifiedState],GQ.[MemberVerifiedCountyCode],GQ.[MemberDOB],GQ.[MemberGenderLkup],LMMemberGender.LookupValue AS MemberGender
				  ,[dbo].[GetAge](GQ.[GEN_QueueId]) AS [CaseAge],GQ.[DisenrollmentDate],GQ.[IsCasePended],GQ.[PendedbyRef],UMPendedby.FullName AS Pendedby,GQ.[UTCPendedOn]
				  ,GQ.[IsActive],GQ.[UTCCreatedOn],GQ.[CreatedByRef],UMCreatedBy.FullName AS CreatedBy,GQ.[UTCLastUpdatedOn],GQ.[LastUpdatedByRef],UMLastUpdatedBy.FullName AS LastUpdatedBy,
				  ActELIG.PendReasonLkup AS PendReasonLkup,
				  LMELIGPendReason.LookupValue AS PendReason
			 FROM [dbo].[GEN_Queue] GQ With(Nolock)
				INNER JOIN [dbo].[GEN_EligibilityActions] ActELIG With(Nolock) ON GQ.[Gen_QueueId] = ActELIG.[Gen_QueueRef] AND ActELIG.IsActive=1
				LEFT JOIN [dbo].[CMN_LookupMaster] LMELIGPendReason With(Nolock) ON ActELIG.[PendReasonLkup]=LMELIGPendReason.[CMN_LookupMasterId] AND LMELIGPendReason.IsActive=1
				LEFT JOIN [dbo].[CMN_LookupMaster] LMBusinessSegment  With(Nolock) ON GQ.[BusinessSegmentLkup]=LMBusinessSegment.[CMN_LookupMasterId] AND LMBusinessSegment.IsActive=1
				LEFT JOIN [dbo].[CMN_LookupMaster] LMWorkBasket  With(Nolock) ON GQ.[WorkBasketLkup]=LMWorkBasket.[CMN_LookupMasterId] AND LMWorkBasket.IsActive=1
				LEFT JOIN [dbo].[CMN_LookupMaster] LMDiscrepancyCategory With(Nolock) ON GQ.[DiscrepancyCategoryLkup]=LMDiscrepancyCategory.[CMN_LookupMasterId] AND LMDiscrepancyCategory.IsActive=1
				LEFT JOIN [dbo].[CMN_LookupMaster] LMDiscrepancyType With(Nolock) ON GQ.[DiscrepancyTypeLkup]=LMDiscrepancyType.[CMN_LookupMasterId] AND LMDiscrepancyType.IsActive=1
				LEFT JOIN [dbo].[CMN_LookupMaster] LMMostRecentAction With(Nolock) ON GQ.[MostRecentActionLkup]=LMMostRecentAction.[CMN_LookupMasterId] AND LMMostRecentAction.IsActive=1
				LEFT JOIN [dbo].[CMN_LookupMaster] LMMostRecentWorkQueue With(Nolock) ON GQ.[MostRecentWorkQueueLkup]=LMMostRecentWorkQueue.[CMN_LookupMasterId] AND LMMostRecentWorkQueue.IsActive=1
				LEFT JOIN [dbo].[CMN_LookupMaster] LMMostRecentStatus With(Nolock) ON GQ.[MostRecentStatusLkup]=LMMostRecentStatus.[CMN_LookupMasterId] AND LMMostRecentStatus.IsActive=1
				LEFT JOIN [dbo].[CMN_LookupMaster] LMMemberContractID With(Nolock) ON GQ.[MemberContractIDLkup]=LMMemberContractID.[CMN_LookupMasterId] AND LMMemberContractID.IsActive=1
				LEFT JOIN [dbo].[CMN_LookupMaster] LMMemberPBP With(Nolock) ON GQ.[MemberPBPLkup]=LMMemberPBP.[CMN_LookupMasterId] AND LMMemberPBP.IsActive=1
				LEFT JOIN [dbo].[CMN_LookupMaster] LMMemberLOB With(Nolock) ON GQ.[MemberLOBLkup]=LMMemberLOB.[CMN_LookupMasterId] AND LMMemberLOB.IsActive=1
				LEFT JOIN [dbo].[CMN_LookupMaster] LMMemberGender With(Nolock) ON GQ.[MemberGenderLkup]=LMMemberGender.[CMN_LookupMasterId] AND LMMemberGender.IsActive=1
				INNER JOIN [dbo].[ADM_UserMaster] UMCreatedBy  With(Nolock) ON GQ.CreatedByRef=UMCreatedBy.[ADM_UserMasterId]
				INNER JOIN [dbo].[ADM_UserMaster] UMLastUpdatedBy  With(Nolock) ON GQ.LastUpdatedByRef=UMLastUpdatedBy.[ADM_UserMasterId]
				INNER JOIN [dbo].[ADM_UserMaster] UMPendedby  With(Nolock) ON GQ.PendedbyRef=UMPendedby.[ADM_UserMasterId]
				WHERE GQ.[BusinessSegmentLkup] = @BusinessSegmentLkup AND (@WorkBasketLkup IS NULL OR GQ.[WorkBasketLkup] = @WorkBasketLkup) AND 
					  (@DiscrepancyCategoryLkup IS NULL OR GQ.[DiscrepancyCategoryLkup]=@DiscrepancyCategoryLkup) AND GQ.[IsCasePended] = 1 AND GQ.[PendedbyRef] = @PendedByRef AND GQ.[IsActive] = 1
				ORDER BY [UTCCreatedOn]
			END
		ELSE IF(@WorkBasketLkup = 3003)
			BEGIN
				SELECT DISTINCT TOP 500
					GQ.[GEN_QueueId],GQ.[BusinessSegmentLkup],LMBusinessSegment.LookupValue AS BusinessSegment,GQ.[WorkBasketLkup],LMWorkBasket.LookupValue AS WorkBasket,GQ.[DiscrepancyCategoryLkup],LMDiscrepancyCategory.LookupValue AS DiscrepancyCategory,GQ.[DiscrepancyTypeLkup],LMDiscrepancyType.LookupValue AS DiscrepancyType
					,GQ.[MostRecentActionLkup], LMMostRecentAction.LookupValue AS MostRecentAction
					,GQ.[MostRecentWorkQueueLkup],LMMostRecentWorkQueue.LookupValue AS MostRecentWorkQueue,GQ.[MostRecentStatusLkup],LMMostRecentStatus.LookupValue AS MostRecentStatus
					,GQ.[ComplianceStartDate],GQ.[DisenrollmentDate],[dbo].[GetAge](GQ.[GEN_QueueId]) as Aging,GQ.[DiscrepancyStartDate],GQ.[DiscrepancyEndDate],GQ.[MemberSCCCode]
					,GQ.[MemberID],GQ.[MemberMedicareId] AS [MemberCurrentHICN],GQ.[GPSHouseholdID],GQ.[MemberFirstName],GQ.[MemberMiddleName],GQ.[MemberLastName],GQ.[MemberContractIDLkup],LMMemberContractID.LookupValue AS MemberContractID
					,GQ.[MemberPBPLkup],LMMemberPBP.LookupValue AS MemberPBP,GQ.[MemberLOBLkup],LMMemberLOB.LookupValue AS MemberLOB,GQ.[MemberVerifiedState],GQ.[MemberVerifiedCountyCode],GQ.[MemberDOB],GQ.[MemberGenderLkup],LMMemberGender.LookupValue AS MemberGender
					,[dbo].[GetAge](GQ.[GEN_QueueId]) AS [CaseAge],GQ.[DisenrollmentDate],GQ.[IsCasePended],GQ.[PendedbyRef],UMPendedby.FullName AS Pendedby,GQ.[UTCPendedOn]
					,GQ.[IsActive],GQ.[UTCCreatedOn],GQ.[CreatedByRef],UMCreatedBy.FullName AS CreatedBy,GQ.[UTCLastUpdatedOn],GQ.[LastUpdatedByRef],UMLastUpdatedBy.FullName AS LastUpdatedBy,
					ActRPR.PendReasonLkup AS PendReasonLkup,
					LMRPRPendReason.LookupValue AS PendReason
				FROM [dbo].[GEN_Queue] GQ With(Nolock)
				INNER JOIN [dbo].[GEN_RPRActions] ActRPR With(Nolock) ON GQ.[Gen_QueueId] = ActRPR.[Gen_QueueRef] AND ActRPR.IsActive=1 
				LEFT JOIN [dbo].[CMN_LookupMaster] LMRPRPendReason With(Nolock) ON ActRPR.[PendReasonLkup]=LMRPRPendReason.[CMN_LookupMasterId] AND LMRPRPendReason.IsActive=1
				LEFT JOIN [dbo].[CMN_LookupMaster] LMBusinessSegment  With(Nolock) ON GQ.[BusinessSegmentLkup]=LMBusinessSegment.[CMN_LookupMasterId] AND LMBusinessSegment.IsActive=1
				LEFT JOIN [dbo].[CMN_LookupMaster] LMWorkBasket  With(Nolock) ON GQ.[WorkBasketLkup]=LMWorkBasket.[CMN_LookupMasterId] AND LMWorkBasket.IsActive=1
				LEFT JOIN [dbo].[CMN_LookupMaster] LMDiscrepancyCategory With(Nolock) ON GQ.[DiscrepancyCategoryLkup]=LMDiscrepancyCategory.[CMN_LookupMasterId] AND LMDiscrepancyCategory.IsActive=1
				LEFT JOIN [dbo].[CMN_LookupMaster] LMDiscrepancyType With(Nolock) ON GQ.[DiscrepancyTypeLkup]=LMDiscrepancyType.[CMN_LookupMasterId] AND LMDiscrepancyType.IsActive=1
				LEFT JOIN [dbo].[CMN_LookupMaster] LMMostRecentAction With(Nolock) ON GQ.[MostRecentActionLkup]=LMMostRecentAction.[CMN_LookupMasterId] AND LMMostRecentAction.IsActive=1
				LEFT JOIN [dbo].[CMN_LookupMaster] LMMostRecentWorkQueue With(Nolock) ON GQ.[MostRecentWorkQueueLkup]=LMMostRecentWorkQueue.[CMN_LookupMasterId] AND LMMostRecentWorkQueue.IsActive=1
				LEFT JOIN [dbo].[CMN_LookupMaster] LMMostRecentStatus With(Nolock) ON GQ.[MostRecentStatusLkup]=LMMostRecentStatus.[CMN_LookupMasterId] AND LMMostRecentStatus.IsActive=1
				LEFT JOIN [dbo].[CMN_LookupMaster] LMMemberContractID With(Nolock) ON GQ.[MemberContractIDLkup]=LMMemberContractID.[CMN_LookupMasterId] AND LMMemberContractID.IsActive=1
				LEFT JOIN [dbo].[CMN_LookupMaster] LMMemberPBP With(Nolock) ON GQ.[MemberPBPLkup]=LMMemberPBP.[CMN_LookupMasterId] AND LMMemberPBP.IsActive=1
				LEFT JOIN [dbo].[CMN_LookupMaster] LMMemberLOB With(Nolock) ON GQ.[MemberLOBLkup]=LMMemberLOB.[CMN_LookupMasterId] AND LMMemberLOB.IsActive=1
				LEFT JOIN [dbo].[CMN_LookupMaster] LMMemberGender With(Nolock) ON GQ.[MemberGenderLkup]=LMMemberGender.[CMN_LookupMasterId] AND LMMemberGender.IsActive=1
				INNER JOIN [dbo].[ADM_UserMaster] UMCreatedBy  With(Nolock) ON GQ.CreatedByRef=UMCreatedBy.[ADM_UserMasterId]
				INNER JOIN [dbo].[ADM_UserMaster] UMLastUpdatedBy  With(Nolock) ON GQ.LastUpdatedByRef=UMLastUpdatedBy.[ADM_UserMasterId]
				INNER JOIN [dbo].[ADM_UserMaster] UMPendedby  With(Nolock) ON GQ.PendedbyRef=UMPendedby.[ADM_UserMasterId]
				WHERE GQ.[BusinessSegmentLkup] = @BusinessSegmentLkup AND (@WorkBasketLkup IS NULL OR GQ.[WorkBasketLkup] = @WorkBasketLkup) AND 
						(@DiscrepancyCategoryLkup IS NULL OR GQ.[DiscrepancyCategoryLkup]=@DiscrepancyCategoryLkup) AND GQ.[IsCasePended] = 1 AND GQ.[PendedbyRef] = @PendedByRef AND GQ.[IsActive] = 1
				ORDER BY [UTCCreatedOn]
			END
		END
	END TRY
	BEGIN CATCH
		SET @ErrorMessage= ERROR_MESSAGE();
	END CATCH  
END