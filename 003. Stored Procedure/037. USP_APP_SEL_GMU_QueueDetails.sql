IF OBJECT_ID ('USP_APP_SEL_GMU_QueueDetails') IS NOT NULL 
BEGIN
	DROP PROC [dbo].[USP_APP_SEL_GMU_QueueDetails]
END
GO

/****** Object:  StoredProcedure [dbo].[USP_APP_SEL_GMU_QueueDetails]    Script Date: 30-06-2017 16:46:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: Rakesh
-- Create date: 06/30/2017
-- Modified By: 
-- Modification Date: 
-- Description: Get most urgent record from the queue within the date range 
-- Eg.
-- Declare @ErrorMessage VARCHAR(2000)
-- Set @ErrorMessage=''
-- Exec [USP_APP_SEL_GMU_QueueDetails] @ErrorMessage = @ErrorMessage Output
-- =============================================
CREATE PROCEDURE [dbo].[USP_APP_SEL_GMU_QueueDetails]
@StartDate DATETIME=NULL,
@EndDate DATETIME=NULL,
@QueueLkup BIGINT=NULL,
@GEN_QueueIdToSkip BIGINT=NULL,
@LoginUserId BIGINT=NULL,
@BusinessSegmentLkup BIGINT=NULL,
@IsRestricted BIT=0,
@ErrorMessage VARCHAR(2000) OUT
AS
BEGIN  
	BEGIN TRY
		Declare @StartDateId BIGINT = FORMAT(@StartDate, 'yyyyMMdd')
		Declare @EndDateId BIGINT = FORMAT(@EndDate, 'yyyyMMdd')
		--Get most urgent record from GEN_Queue 
		SELECT TOP 1 GQ.[GEN_QueueId],GQ.[BusinessSegmentLkup],GQ.[WorkBasketLkup],GQ.[DiscrepancyCategoryLkup],GQ.[MemberMedicareId] AS [MemberCurrentHICN],GQ.[DiscrepancyTypeLkup],GQ.[DiscrepancyStartDate],GQ.[ComplianceStartDate],GQ.[MemberFirstName],GQ.[MemberLastName],GQ.[LockedByRef],GR.[AdjustedCreateDate],
					[dbo].[GetAge](GQ.[GEN_QueueId]) AS [CaseAge]
		FROM [dbo].[GEN_Queue] GQ With(Nolock)
		LEFT JOIN GEN_OSTActions GOST With(Nolock) ON GQ.[GEN_QueueId] = GOST.[GEN_QueueRef]
		LEFT JOIN GEN_RPRActions GR With(Nolock) ON GQ.[GEN_QueueId] = GR.[GEN_QueueRef]
		WHERE GQ.[BusinessSegmentLkup] = @BusinessSegmentLkup AND 
			  ((GQ.[WorkBasketLkup] = 3001 AND (GOST.AdjustedComplianceStartDateId IS NULL AND GQ.[ComplianceStartDateId] >= @StartDateId AND GQ.[ComplianceStartDateId] <= @EndDateId) OR 
			  (GOST.AdjustedComplianceStartDateId IS NOT NULL AND GOST.AdjustedComplianceStartDateId >= @StartDateId AND GOST.AdjustedComplianceStartDateId <= @EndDateId)) OR 
			  (GQ.[WorkBasketLkup] <> 3001 AND GQ.[UTCCreatedOnId] >= @StartDateId AND GQ.[UTCCreatedOnId] <= @EndDateId)) AND
			  (@GEN_QueueIdToSkip IS NULL OR GQ.[GEN_QueueId] != @GEN_QueueIdToSkip) AND ((@QueueLkup IN (10094,10095,10096,10097,10098,10099,10074) AND GQ.[MostRecentWorkQueueLkup] = @QueueLkup AND GQ.[AssignedToRef]=@LoginUserId) OR (GQ.[MostRecentWorkQueueLkup] = @QueueLkup)) AND 			  
			  GQ.[IsCasePended]=0 AND GQ.[IsCaseResolved]=0 AND (GQ.[LockedByRef] = @LoginUserId OR GQ.[LockedByRef] IS NULL) AND GQ.[IsActive] = 1	AND (OOALetterStatusLkup IS NULL OR OOALetterStatusLkup <> 53001) AND (CMSTransactionStatusLkup IS NULL OR CMSTransactionStatusLkup <> 55001)  AND
			  (@IsRestricted = 1 OR (@IsRestricted = 0 AND (GQ.IsRestricted IS NULL OR GQ.IsRestricted = 0)))
		ORDER BY GQ.[LockedByRef] DESC,[CaseAge] DESC,GQ.[UTCCreatedOn],GEN_QueueId
	END TRY
	BEGIN CATCH
		SET @ErrorMessage= ERROR_MESSAGE();
	END CATCH  
END
GO