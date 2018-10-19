
IF OBJECT_ID ('USP_BGP_SEL_FDRGetCaseDetails') IS NOT NULL 
BEGIN
	DROP PROC [dbo].[USP_BGP_SEL_FDRGetCaseDetails]
END
GO
/****** Object:  StoredProcedure [dbo].[USP_BGP_SEL_FDRGetCaseDetails]    Script Date: 8/14/2017 4:04:30 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- =============================================
-- Author: Pradeep Patil
-- Create date: 03/08/2017
-- Description: Get Case Details by Current HICN and Contract for FDR Submision
-- Eg.
 --Declare @ErrorMessage VARCHAR(2000)
 --Set @ErrorMessage=''
 --Exec [USP_BGP_SEL_FDRGetCaseDetails] ,@CurrentHICN='dfgerg54',@ContractID='H0234',@ErrorMessage = ''
-- =============================================
CREATE PROCEDURE [dbo].[USP_BGP_SEL_FDRGetCaseDetails]
@CurrentHICN VARCHAR(100)=NULL,
@ContractID VARCHAR(100)=NULL,
@TransactionTypeLkup bigint = 0,
@DiscrepancyTypeLkup bigint = 7010,
@ErrorMessage varchar(2000) OUTPUT
as

BEGIN  

BEGIN TRY 
	
	DECLARE @ActionRequestedGroup TABLE (ID BIGINT)

	IF(@TransactionTypeLkup = 43001) INSERT INTO @ActionRequestedGroup VALUES (14006),(14012),(14008),(14007),(14011),(14016)--Create group of action requested for Reinstmt
	IF(@TransactionTypeLkup = 43002) INSERT INTO @ActionRequestedGroup VALUES (14001),(14003),(14009),(14014)--Create group of action requested for RetDis
	IF(@TransactionTypeLkup = 43003) INSERT INTO @ActionRequestedGroup VALUES (14002),(14004),(14010),(14015)--Create group of action requested for RetEnrl
	IF(@TransactionTypeLkup = 43005) INSERT INTO @ActionRequestedGroup VALUES (14005)--Create group of action requested for PBP

	SELECT GQ.[GEN_QueueId]
		,GQ.[MemberFirstName]
		,GQ.[MemberLastName]
		,LMMemberContractID.LookupValue AS MemberContractID
		,LMMemberPBP.LookupValue AS MemberPBP
		,GQ.[RPRRequestedEffectiveDate]
		,GQ.[RPRActionRequestedLkup]
		,GQ.[SCCRPRRequested]
		,GQ.[SCCRPRRequestedZip]
		,LMRPRActionRequested.LookupValue AS RPRActionRequested
		,GQ.[MemberCurrentHICN]
		,GENRPR.[ApplicationDate]
		,GENRPR.[EffectiveDate]
		,GENRPR.[EndDate]
		,LMET.LookupValue AS ElectionType

	FROM [dbo].[GEN_Queue] GQ with(nolock)
		LEFT JOIN [dbo].[CMN_LookupMaster] LMMemberContractID with(nolock) ON GQ.[MemberContractIDLkup]=LMMemberContractID.[CMN_LookupMasterId] AND LMMemberContractID.CMN_LookupTypeRef = 11 AND LMMemberContractID.IsActive=1
		LEFT JOIN [dbo].[CMN_LookupMaster] LMMemberPBP with(nolock) ON GQ.[MemberPBPLkup]=LMMemberPBP.[CMN_LookupMasterId] AND LMMemberPBP.CMN_LookupTypeRef = 12 AND LMMemberPBP.IsActive=1
		LEFT JOIN [dbo].[CMN_LookupMaster] LMRPRActionRequested with(nolock) ON GQ.[RPRActionRequestedLkup]=LMRPRActionRequested.[CMN_LookupMasterId] AND LMRPRActionRequested.CMN_LookupTypeRef = 14 AND LMRPRActionRequested.IsActive=1	
		LEFT JOIN [dbo].[GEN_RPRActions] GENRPR with(nolock) ON GENRPR.[GEN_QueueRef] = GQ.[GEN_QueueId]
		LEFT JOIN dbo.[CMN_LookupMaster] LMET with(nolock) ON GENRPR.ElectionTypeLkup=LMET.[CMN_LookupMasterId] AND LMET.CMN_LookupTypeRef = 23 AND LMET.IsActive=1

	WHERE GQ.[DiscrepancyCategoryLkup] = 6007 --Only RPR Cases
		AND GQ.[DiscrepancyTypeLkup] = @DiscrepancyTypeLkup --to distinguish RPR and SCC RPR FDR Submission
		AND GQ.[IsActive] = 1
		AND GQ.[MostRecentWorkQueueLkup] IN (10087,10083,10084,10078) -- Current Queues(RPR - Re-Submission,RPR - SCC RPR Re-Submission,RPR - SCC RPR Sent,RPR - Sent to RPC)
		AND GQ.[MostRecentStatusLkup] != 20003 --Not resolved
		AND (GQ.[MemberCurrentHICN] = @CurrentHICN OR GQ.[MemberMedicareId]= @CurrentHICN)
		AND LMMemberContractID.LookupValue = @ContractID
		AND (@TransactionTypeLkup Is Null OR @TransactionTypeLkup = 0 OR GQ.RPRActionRequestedLkup IN (SELECT ID FROM @ActionRequestedGroup))
	
END TRY 
BEGIN CATCH

SET @ErrorMessage= ERROR_MESSAGE();

END CATCH 

END

GO

