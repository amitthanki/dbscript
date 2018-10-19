IF OBJECT_ID ('USP_APP_SEL_QueueSummary') IS NOT NULL 
BEGIN
	DROP PROC [dbo].[USP_APP_SEL_QueueSummary]
END
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:Rakesh Hosagoudar
-- Create date: 06/29/2017
-- Modified By: 
-- Modification Date: 
-- Description:To get Queue summary by Discrepancy Category.
-- Eg.
-- Declare @ErrorMessage VARCHAR(2000)
-- Set @ErrorMessage=''
-- Exec [USP_APP_SEL_QueueSummary] @ErrorMessage = @ErrorMessage Output
-- =============================================
CREATE PROC [dbo].[USP_APP_SEL_QueueSummary]
@StartDate DATETIME=NULL,
@EndDate DATETIME=NULL,
@BusinessSegmentLkup BIGINT = NULL,
@DiscrepancyCategoryLkup BIGINT = NULL,
@ErrorMessage varchar(2000) OUTPUT
As
BEGIN
	BEGIN TRY
		Declare @StartDateId BIGINT=FORMAT(@StartDate, 'yyyyMMdd')
		Declare @EndDateId BIGINT=FORMAT(@EndDate, 'yyyyMMdd')

		if(@DiscrepancyCategoryLkup = 6001 OR @DiscrepancyCategoryLkup IS NULL)--OOA
		BEGIN
			SELECT
			COUNT(CASE WHEN (GQ.MostRecentWorkQueueLkup=10001)  THEN 1 END) AS OOAAddressScrub,
			COUNT(CASE WHEN (GQ.MostRecentWorkQueueLkup=10002)	THEN 1 END)	AS OOACMSAccepted,
			COUNT(CASE WHEN (GQ.MostRecentWorkQueueLkup=10004)	THEN 1 END)	AS OOACompleted,
			COUNT(CASE WHEN (GQ.MostRecentWorkQueueLkup=10005)	THEN 1 END)	AS OOAMARxAddressLetter,
			COUNT(CASE WHEN (GQ.MostRecentWorkQueueLkup=10006)	THEN 1 END)	AS OOAMIIMUpdated,
			COUNT(CASE WHEN (GQ.MostRecentWorkQueueLkup=10007)	THEN 1 END)	AS OOANewCase,
			COUNT(CASE WHEN (GQ.MostRecentWorkQueueLkup=10008)	THEN 1 END)	AS OOAOpenDisenroll,
			COUNT(CASE WHEN (GQ.MostRecentWorkQueueLkup=10009)	THEN 1 END)	AS OOAOpenNOT,
			COUNT(CASE WHEN (GQ.MostRecentWorkQueueLkup=10010)	THEN 1 END)	AS OOAPended,
			COUNT(CASE WHEN (GQ.MostRecentWorkQueueLkup=10011)	THEN 1 END)	AS OOAPendingAudit,
			COUNT(CASE WHEN (GQ.MostRecentWorkQueueLkup=10012)	THEN 1 END)	AS OOAPendingFTT,
			COUNT(CASE WHEN (GQ.MostRecentWorkQueueLkup=10013)	THEN 1 END)	AS OOAPendingNOT,
			COUNT(CASE WHEN (GQ.MostRecentWorkQueueLkup=10014)	THEN 1 END)	AS OOASubmitToCMS,
			COUNT(CASE WHEN (GQ.MostRecentWorkQueueLkup=10015)	THEN 1 END)	AS OOAUpdateSentToCMS,
			COUNT(CASE WHEN (GQ.MostRecentWorkQueueLkup=10094)	THEN 1 END)	AS OOAPeerAuditFailed,
			COUNT(CASE WHEN (GQ.MostRecentWorkQueueLkup=10107)	THEN 1 END)	AS OOAPendingSCCRPR,
			COUNT(CASE WHEN (GQ.MostRecentWorkQueueLkup=10114)	THEN 1 END)	AS OOAUpdateSenttoCMSFAILED,
			COUNT(CASE WHEN (GQ.MostRecentWorkQueueLkup=10115)	THEN 1 END)	AS OOALetterSentFAILED,
			COUNT(CASE WHEN (GQ.MostRecentWorkQueueLkup IN (10001,10005,10006,10007,10008,10009,10010,10011,10094,10114,10115))	THEN 1 END)	AS OOAProcessingTotal,
			COUNT(CASE WHEN (GQ.MostRecentWorkQueueLkup IN (10004,10002))	THEN 1 END)	AS OOACompletedTotal,
			COUNT(CASE WHEN (GQ.MostRecentWorkQueueLkup IN (10012,10013,10014,10015,10107))	THEN 1 END)	AS OOAHoldingTotal,
			COUNT(CASE WHEN (GQ.DiscrepancyCategoryLkup=6001) THEN 1 END)	AS OOATotal
			FROM GEN_Queue GQ With(Nolock)
			LEFT JOIN GEN_OSTActions GOST With(Nolock) ON GQ.GEN_QueueId=GOST.GEN_QueueRef
			WHERE GQ.BusinessSegmentLkup = @BusinessSegmentLkup AND (@DiscrepancyCategoryLkup IS NULL OR GQ.DiscrepancyCategoryLkup = @DiscrepancyCategoryLkup) AND GQ.IsActive=1 AND 
			((GOST.AdjustedComplianceStartDateId IS NULL AND GQ.[ComplianceStartDateId] >= @StartDateId AND GQ.[ComplianceStartDateId] <= @EndDateId) OR (GOST.AdjustedComplianceStartDateId IS NOT NULL AND GOST.AdjustedComplianceStartDateId >= @StartDateId AND GOST.AdjustedComplianceStartDateId <= @EndDateId))
		END

		if(@DiscrepancyCategoryLkup = 6002 OR @DiscrepancyCategoryLkup IS NULL)--SCC
		BEGIN
			SELECT			
			COUNT(CASE WHEN (GQ.MostRecentWorkQueueLkup=10017)	THEN 1 END)	AS SCCCMSAccepted,
			COUNT(CASE WHEN (GQ.MostRecentWorkQueueLkup=10019)	THEN 1 END)	AS SCCCompleted,			
			COUNT(CASE WHEN (GQ.MostRecentWorkQueueLkup=10021)	THEN 1 END)	AS SCCMIIMUpdated,
			COUNT(CASE WHEN (GQ.MostRecentWorkQueueLkup=10022)	THEN 1 END)	AS SCCNewCase,
			COUNT(CASE WHEN (GQ.MostRecentWorkQueueLkup=10025)	THEN 1 END)	AS SCCPended,
			COUNT(CASE WHEN (GQ.MostRecentWorkQueueLkup=10026)	THEN 1 END)	AS SCCPendingAudit,
			COUNT(CASE WHEN (GQ.MostRecentWorkQueueLkup=10029)	THEN 1 END)	AS SCCPendingSCCRPR,
			COUNT(CASE WHEN (GQ.MostRecentWorkQueueLkup=10031)	THEN 1 END)	AS SCCSubmitToCMS,
			COUNT(CASE WHEN (GQ.MostRecentWorkQueueLkup=10032)	THEN 1 END)	AS SCCUpdateSentToCMS,
			COUNT(CASE WHEN (GQ.MostRecentWorkQueueLkup=10095)	THEN 1 END)	AS SCCPeerAuditFailed,
			COUNT(CASE WHEN (GQ.MostRecentWorkQueueLkup=10111)	THEN 1 END)	AS SCCPotentialSCCRPRDay1,
			COUNT(CASE WHEN (GQ.MostRecentWorkQueueLkup=10112)	THEN 1 END)	AS SCCNeedEGHPReview,
			COUNT(CASE WHEN (GQ.MostRecentWorkQueueLkup=10113)	THEN 1 END)	AS SCCPotentialSCCRPRDay2,
			COUNT(CASE WHEN (GQ.MostRecentWorkQueueLkup=10116)	THEN 1 END)	AS SCCUpdateSenttoCMSFAILED,
			--COUNT(CASE WHEN (GQ.MostRecentWorkQueueLkup=10016)  THEN 1 END) AS SCCAddressScrub,
			--COUNT(CASE WHEN (GQ.MostRecentWorkQueueLkup=10020)	THEN 1 END)	AS SCCMARxAddressLetter,
			--COUNT(CASE WHEN (GQ.MostRecentWorkQueueLkup=10023)	THEN 1 END)	AS SCCOpenDisenroll,
			--COUNT(CASE WHEN (GQ.MostRecentWorkQueueLkup=10024)	THEN 1 END)	AS SCCOpenNOT,
			--COUNT(CASE WHEN (GQ.MostRecentWorkQueueLkup=10027)	THEN 1 END)	AS SCCPendingFTT,
			--COUNT(CASE WHEN (GQ.MostRecentWorkQueueLkup=10028)	THEN 1 END)	AS SCCPendingNOT,
			COUNT(CASE WHEN (GQ.MostRecentWorkQueueLkup IN (10021,10022,10025,10026,10095,10111,10112,10113,10116)) THEN 1 END)	AS SCCProcessingTotal,
			COUNT(CASE WHEN (GQ.MostRecentWorkQueueLkup IN (10019,10017))	THEN 1 END)	AS SCCCompletedTotal,
			COUNT(CASE WHEN (GQ.MostRecentWorkQueueLkup IN (10029,10031,10032))	THEN 1 END)	AS SCCHoldingTotal,
			COUNT(CASE WHEN (GQ.DiscrepancyCategoryLkup=6002) THEN 1 END)	AS SCCTotal
			FROM GEN_Queue GQ With(Nolock)
			LEFT JOIN GEN_OSTActions GOST With(Nolock) ON GQ.GEN_QueueId=GOST.GEN_QueueRef
			WHERE GQ.BusinessSegmentLkup = @BusinessSegmentLkup AND (@DiscrepancyCategoryLkup IS NULL OR GQ.DiscrepancyCategoryLkup = @DiscrepancyCategoryLkup) AND GQ.IsActive=1 AND 
			((GOST.AdjustedComplianceStartDateId IS NULL AND GQ.[ComplianceStartDateId] >= @StartDateId AND GQ.[ComplianceStartDateId] <= @EndDateId) OR (GOST.AdjustedComplianceStartDateId IS NOT NULL AND GOST.AdjustedComplianceStartDateId >= @StartDateId AND GOST.AdjustedComplianceStartDateId <= @EndDateId))
		END

		if(@DiscrepancyCategoryLkup = 6003 OR @DiscrepancyCategoryLkup IS NULL)--TRR
		BEGIN			
			SELECT
			COUNT(CASE WHEN (GQ.MostRecentWorkQueueLkup=10033)  THEN 1 END) AS TRRCMSRejected,
			COUNT(CASE WHEN (GQ.MostRecentWorkQueueLkup=10034)	THEN 1 END)	AS TRRCMSRejectedDeletionCode,
			COUNT(CASE WHEN (GQ.MostRecentWorkQueueLkup=10036)	THEN 1 END)	AS TRRCompleted,
			COUNT(CASE WHEN (GQ.MostRecentWorkQueueLkup=10037)	THEN 1 END)	AS TRREscalated,
			--COUNT(CASE WHEN (GQ.MostRecentWorkQueueLkup=10038)	THEN 1 END)	AS TRRFalloutTRC085,
			COUNT(CASE WHEN (GQ.MostRecentWorkQueueLkup=10039)	THEN 1 END)	AS TRRFalloutTRC155,
			COUNT(CASE WHEN (GQ.MostRecentWorkQueueLkup=10042)	THEN 1 END)	AS TRRPendingAudit,
			COUNT(CASE WHEN (GQ.MostRecentWorkQueueLkup=10043)	THEN 1 END)	AS TRRSubmitToCMS,
			COUNT(CASE WHEN (GQ.MostRecentWorkQueueLkup=10044)	THEN 1 END)	AS TRRSubmitToCMSDeletionCode,
			--COUNT(CASE WHEN (GQ.MostRecentWorkQueueLkup=10045)	THEN 1 END)	AS TRRTRC085,
			COUNT(CASE WHEN (GQ.MostRecentWorkQueueLkup=10046)	THEN 1 END)	AS TRRTRC15476,
			COUNT(CASE WHEN (GQ.MostRecentWorkQueueLkup=10108)	THEN 1 END)	AS TRRTRC15401,
			COUNT(CASE WHEN (GQ.MostRecentWorkQueueLkup=10047)	THEN 1 END)	AS TRRTRC155,
			COUNT(CASE WHEN (GQ.MostRecentWorkQueueLkup=10048)	THEN 1 END)	AS TRRTRC282,
			COUNT(CASE WHEN (GQ.MostRecentWorkQueueLkup=10049)	THEN 1 END)	AS TRRUpdateSentToCMS,
			COUNT(CASE WHEN (GQ.MostRecentWorkQueueLkup=10050)	THEN 1 END)	AS TRRUpdateSentToCMSDeletionCode,
			COUNT(CASE WHEN (GQ.MostRecentWorkQueueLkup=10090)	THEN 1 END)	AS TRRPended,
			COUNT(CASE WHEN (GQ.MostRecentWorkQueueLkup=10091)	THEN 1 END)	AS TRRPendingSCCRPR,
			COUNT(CASE WHEN (GQ.MostRecentWorkQueueLkup=10092)	THEN 1 END)	AS TRRCMSAccepted,
			COUNT(CASE WHEN (GQ.MostRecentWorkQueueLkup=10093)	THEN 1 END)	AS TRRCMSAcceptedDeletionCode,
			COUNT(CASE WHEN (GQ.MostRecentWorkQueueLkup=10096)	THEN 1 END)	AS TRRPeerAuditFailed,
			COUNT(CASE WHEN (GQ.MostRecentWorkQueueLkup=10117)	THEN 1 END)	AS TRRUpdateSenttoCMSFAILED,
			--COUNT(CASE WHEN (GQ.MostRecentWorkQueueLkup=10040)	THEN 1 END)	AS TRRMARxAddressLetter,
			--COUNT(CASE WHEN (GQ.MostRecentWorkQueueLkup=10041)	THEN 1 END)	AS TRRPendingNOT,
			--COUNT(CASE WHEN (GQ.MostRecentWorkQueueLkup=10100)	THEN 1 END)	AS TRRAddressScrub,
			--COUNT(CASE WHEN (GQ.MostRecentWorkQueueLkup=10102)	THEN 1 END)	AS TRROpenDisenroll,
			--COUNT(CASE WHEN (GQ.MostRecentWorkQueueLkup=10103)	THEN 1 END)	AS TRROpenNOT,
			--COUNT(CASE WHEN (GQ.MostRecentWorkQueueLkup=10104)	THEN 1 END)	AS TRRPendingFTT,
			COUNT(CASE WHEN (GQ.MostRecentWorkQueueLkup IN (10033,10034,10037,10039,10042,10046,10108,10047,10048,10090,10096,10117))	THEN 1 END)	AS TRRProcessingTotal,
			COUNT(CASE WHEN (GQ.MostRecentWorkQueueLkup IN (10036,10092,10093))	THEN 1 END)	AS TRRCompletedTotal,
			COUNT(CASE WHEN (GQ.MostRecentWorkQueueLkup IN (10043,10044,10049,10050,10091))THEN 1 END)	AS TRRHoldingTotal,
			COUNT(CASE WHEN (GQ.DiscrepancyCategoryLkup=6003)	THEN 1 END)	AS TRRTotal
			FROM GEN_Queue GQ With(Nolock)
			LEFT JOIN GEN_OSTActions GOST With(Nolock) ON GQ.GEN_QueueId=GOST.GEN_QueueRef
			WHERE GQ.BusinessSegmentLkup = @BusinessSegmentLkup AND (@DiscrepancyCategoryLkup IS NULL OR GQ.DiscrepancyCategoryLkup = @DiscrepancyCategoryLkup) AND GQ.IsActive=1 AND 
			((GOST.AdjustedComplianceStartDateId IS NULL AND GQ.[ComplianceStartDateId] >= @StartDateId AND GQ.[ComplianceStartDateId] <= @EndDateId) OR (GOST.AdjustedComplianceStartDateId IS NOT NULL AND GOST.AdjustedComplianceStartDateId >= @StartDateId AND GOST.AdjustedComplianceStartDateId <= @EndDateId))
		END

		if(@DiscrepancyCategoryLkup = 6004 OR @DiscrepancyCategoryLkup IS NULL)--Eligibility
		BEGIN
			SELECT
			--COUNT(CASE WHEN (GQ.MostRecentWorkQueueLkup=10051)  THEN 1 END) AS EligCMSAccepted,
			--COUNT(CASE WHEN (GQ.MostRecentWorkQueueLkup=10052)	THEN 1 END)	AS EligCMSRejected,
			COUNT(CASE WHEN (GQ.MostRecentWorkQueueLkup=10053)	THEN 1 END)	AS EligCompleted,
			COUNT(CASE WHEN (GQ.MostRecentWorkQueueLkup=10054)	THEN 1 END)	AS EligNewCase,
			COUNT(CASE WHEN (GQ.MostRecentWorkQueueLkup=10055)	THEN 1 END)	AS EligPended,
			COUNT(CASE WHEN (GQ.MostRecentWorkQueueLkup=10056)	THEN 1 END)	AS EligPendingAudit,
			--COUNT(CASE WHEN (GQ.MostRecentWorkQueueLkup=10057)	THEN 1 END)	AS EligSubmitToCMS,
			--COUNT(CASE WHEN (GQ.MostRecentWorkQueueLkup=10058)	THEN 1 END)	AS EligUpdateSentToCMS,
			COUNT(CASE WHEN (GQ.MostRecentWorkQueueLkup=10097)	THEN 1 END)	AS EligPeerAuditFailed,
			COUNT(CASE WHEN (GQ.MostRecentWorkQueueLkup IN (10054,10055,10056,10097))	THEN 1 END)	AS EligProcessingTotal,
			COUNT(CASE WHEN (GQ.MostRecentWorkQueueLkup IN (10053))	THEN 1 END)	AS EligCompletedTotal,
			--COUNT(CASE WHEN (GQ.MostRecentWorkQueueLkup IN (10057,10058))	THEN 1 END)	AS EligHoldingTotal,
			COUNT(CASE WHEN (GQ.DiscrepancyCategoryLkup=6004) THEN 1 END)	AS EligTotal
			FROM GEN_Queue GQ With(Nolock)
			WHERE GQ.BusinessSegmentLkup = @BusinessSegmentLkup AND (@DiscrepancyCategoryLkup IS NULL OR GQ.DiscrepancyCategoryLkup = @DiscrepancyCategoryLkup) AND GQ.IsActive=1 AND [UTCCreatedOnId] >= @StartDateId AND [UTCCreatedOnId] <= @EndDateId
		END

		if(@DiscrepancyCategoryLkup = 6005 OR @DiscrepancyCategoryLkup IS NULL)--DOB
		BEGIN
			SELECT
			COUNT(CASE WHEN (GQ.MostRecentWorkQueueLkup=10059)  THEN 1 END) AS DOBCompleted,
			COUNT(CASE WHEN (GQ.MostRecentWorkQueueLkup=10060)	THEN 1 END)	AS DOBNewCase,
			COUNT(CASE WHEN (GQ.MostRecentWorkQueueLkup=10061)	THEN 1 END)	AS DOBPended,
			COUNT(CASE WHEN (GQ.MostRecentWorkQueueLkup=10062)	THEN 1 END)	AS DOBPendingAudit,
			COUNT(CASE WHEN (GQ.MostRecentWorkQueueLkup=10099)	THEN 1 END)	AS DOBPeerAuditFailed,
			COUNT(CASE WHEN (GQ.MostRecentWorkQueueLkup IN (10060,10061,10062,10099))	THEN 1 END)	AS DOBProcessingTotal,
			COUNT(CASE WHEN (GQ.MostRecentWorkQueueLkup IN (10059))	THEN 1 END)	AS DOBCompletedTotal,
			COUNT(CASE WHEN (GQ.DiscrepancyCategoryLkup=6005)	THEN 1 END)	AS DOBTotal
			FROM GEN_Queue GQ With(Nolock)
			WHERE GQ.BusinessSegmentLkup = @BusinessSegmentLkup AND (@DiscrepancyCategoryLkup IS NULL OR GQ.DiscrepancyCategoryLkup = @DiscrepancyCategoryLkup) AND GQ.IsActive=1 AND [UTCCreatedOnId] >= @StartDateId AND [UTCCreatedOnId] <= @EndDateId
		END

		if(@DiscrepancyCategoryLkup = 6006 OR @DiscrepancyCategoryLkup IS NULL)--Gender
		BEGIN
			SELECT
			COUNT(CASE WHEN (GQ.MostRecentWorkQueueLkup=10063)  THEN 1 END) AS GenderCompleted,
			COUNT(CASE WHEN (GQ.MostRecentWorkQueueLkup=10064)	THEN 1 END)	AS GenderNewCase,
			COUNT(CASE WHEN (GQ.MostRecentWorkQueueLkup=10065)	THEN 1 END)	AS GenderPended,
			COUNT(CASE WHEN (GQ.MostRecentWorkQueueLkup=10066)	THEN 1 END)	AS GenderPendingAudit,
			COUNT(CASE WHEN (GQ.MostRecentWorkQueueLkup=10098)	THEN 1 END)	AS GenderPeerAuditFailed,
			COUNT(CASE WHEN (GQ.MostRecentWorkQueueLkup IN (10064,10065,10066,10098))	THEN 1 END)	AS GenderProcessingTotal,
			COUNT(CASE WHEN (GQ.MostRecentWorkQueueLkup IN (10063))	THEN 1 END)	AS GenderCompletedTotal,
			COUNT(CASE WHEN (GQ.DiscrepancyCategoryLkup=6006)	THEN 1 END)	AS GenderTotal
			FROM GEN_Queue GQ With(Nolock)
			WHERE GQ.BusinessSegmentLkup = @BusinessSegmentLkup AND (@DiscrepancyCategoryLkup IS NULL OR GQ.DiscrepancyCategoryLkup = @DiscrepancyCategoryLkup) AND GQ.IsActive=1 AND [UTCCreatedOnId] >= @StartDateId AND [UTCCreatedOnId] <= @EndDateId
		END

		if(@DiscrepancyCategoryLkup = 6007 OR @DiscrepancyCategoryLkup IS NULL)--RPR
		BEGIN
			SELECT
			COUNT(CASE WHEN (GQ.MostRecentWorkQueueLkup=10067)  THEN 1 END) AS RPRCMSAccountManagerSent,
			COUNT(CASE WHEN (GQ.MostRecentWorkQueueLkup=10068)	THEN 1 END)	AS RPRCMSRejectedDeletionCode,
			COUNT(CASE WHEN (GQ.MostRecentWorkQueueLkup=10069)	THEN 1 END)	AS RPRCompleted,
			COUNT(CASE WHEN (GQ.MostRecentWorkQueueLkup=10070)	THEN 1 END)	AS RPRInitialSCCRPR,
			COUNT(CASE WHEN (GQ.MostRecentWorkQueueLkup=10071)  THEN 1 END) AS RPRReceivedRPCFDR,
			--COUNT(CASE WHEN (GQ.MostRecentWorkQueueLkup=10072)	THEN 1 END)	AS RPRReceivedTRC282,
			COUNT(CASE WHEN (GQ.MostRecentWorkQueueLkup=10073)	THEN 1 END)	AS RPRPeerAudit,
			COUNT(CASE WHEN (GQ.MostRecentWorkQueueLkup=10074)	THEN 1 END)	AS RPRPeerAuditFailed,
			COUNT(CASE WHEN (GQ.MostRecentWorkQueueLkup=10075)  THEN 1 END) AS RPRRejected,
			COUNT(CASE WHEN (GQ.MostRecentWorkQueueLkup=10076)	THEN 1 END)	AS RPRRequestCategory2,
			COUNT(CASE WHEN (GQ.MostRecentWorkQueueLkup=10077)	THEN 1 END)	AS RPRRequestCategory3,
			COUNT(CASE WHEN (GQ.MostRecentWorkQueueLkup=10078)	THEN 1 END)	AS RPRReSubmission,
			COUNT(CASE WHEN (GQ.MostRecentWorkQueueLkup=10079)  THEN 1 END) AS RPRSubmissionCategory2,
			COUNT(CASE WHEN (GQ.MostRecentWorkQueueLkup=10080)	THEN 1 END)	AS RPRSubmissionCategory3,
			COUNT(CASE WHEN (GQ.MostRecentWorkQueueLkup=10081)	THEN 1 END)	AS RPRPended,
			COUNT(CASE WHEN (GQ.MostRecentWorkQueueLkup=10082)	THEN 1 END)	AS RPRSCCRPRFDRReceived,
			COUNT(CASE WHEN (GQ.MostRecentWorkQueueLkup=10083)	THEN 1 END)	AS RPRSCCRPRReSubmission,
			COUNT(CASE WHEN (GQ.MostRecentWorkQueueLkup=10084)	THEN 1 END)	AS RPRSCCRPRSent,
			COUNT(CASE WHEN (GQ.MostRecentWorkQueueLkup=10085)	THEN 1 END)	AS RPRSCCRPRSubmission,
			COUNT(CASE WHEN (GQ.MostRecentWorkQueueLkup=10086)	THEN 1 END)	AS RPRSCCRPRTransactionInquiry,
			COUNT(CASE WHEN (GQ.MostRecentWorkQueueLkup=10087)	THEN 1 END)	AS RPRSentToRPC,
			--COUNT(CASE WHEN (GQ.MostRecentWorkQueueLkup=10088)	THEN 1 END)	AS RPRSubmitToCMSDeletionCode,
			--COUNT(CASE WHEN (GQ.MostRecentWorkQueueLkup=10089)	THEN 1 END)	AS RPRUpdateSentToCMSDeletionCode,
			COUNT(CASE WHEN (GQ.MostRecentWorkQueueLkup=10106)	THEN 1 END)	AS RPREligibilityUpdateInMARx,
			COUNT(CASE WHEN (GQ.MostRecentWorkQueueLkup=10109)	THEN 1 END)	AS RPRTrend_2,
			COUNT(CASE WHEN (GQ.MostRecentWorkQueueLkup=10110)	THEN 1 END)	AS RPRRequestCategory2CTM,
			COUNT(CASE WHEN (GQ.MostRecentWorkQueueLkup IN (10067,10068,10070,10071,10073,10074,10075,10076,10077,10078,10079,10080,10081,10082,10083,10084,10085,10086,10087,10106,10109,10110))	THEN 1 END)	AS RPRProcessingTotal,
			COUNT(CASE WHEN (GQ.MostRecentWorkQueueLkup IN (10069))	THEN 1 END)	AS RPRCompletedTotal,
			--COUNT(CASE WHEN (GQ.MostRecentWorkQueueLkup IN (10088,10089))	THEN 1 END)	AS RPRHoldingTotal,
			COUNT(CASE WHEN (GQ.DiscrepancyCategoryLkup=6007)	THEN 1 END)	AS RPRTotal
			FROM GEN_Queue GQ With(Nolock)
			WHERE GQ.BusinessSegmentLkup = @BusinessSegmentLkup AND (@DiscrepancyCategoryLkup IS NULL OR GQ.DiscrepancyCategoryLkup = @DiscrepancyCategoryLkup) AND GQ.IsActive=1 AND [UTCCreatedOnId] >= @StartDateId AND [UTCCreatedOnId] <= @EndDateId
		END
	END TRY 

	BEGIN CATCH
		   SET @ErrorMessage= ERROR_MESSAGE();
	END CATCH  
END
GO