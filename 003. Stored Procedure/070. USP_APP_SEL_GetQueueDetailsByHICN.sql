IF OBJECT_ID ('USP_APP_SEL_GetQueueDetailsByHICN') IS NOT NULL 
BEGIN
	DROP PROC [dbo].[USP_APP_SEL_GetQueueDetailsByHICN]
END
GO
/****** Object:  StoredProcedure [dbo].[USP_APP_SEL_GetQueueDetailsByHICN]    Script Date: 8/17/2017 7:39:12 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Praveen
-- Create date: 7/27/2017
-- Description:	Used to Get All Case By HICN and Pass Values to MIIM request
-- =============================================
CREATE PROCEDURE [dbo].[USP_APP_SEL_GetQueueDetailsByHICN] 
	@HICN Varchar(11)
AS
 
BEGIN

	SET NOCOUNT ON;

    SELECT GQ.GEN_QueueId AS QueueId,
	       GQ.CSTCreatedOn As CreatedOn,
		   GQ.MostRecentStatusLkup AS StatusRef,
		   CL1.LookupValue AS Status,
		   GQ.DiscrepancyTypeLkup AS CaseType,
		   CL.LookupValue AS CaseTypeRef,
		   GQ.DiscrepancyCategoryLkup AS CaseCategoryType,
		   CL2.LookupValue AS CaseCategoryTypeRef
	 FROM [dbo].GEN_Queue GQ WITH(NOLOCK)
		   INNER JOIN  [dbo].CMN_LookupMaster CL WITH(NOLOCK)
			   ON GQ.DiscrepancyTypeLkup=CL.CMN_LookupMasterId
			INNER JOIN  [dbo].CMN_LookupMaster CL1 WITH(NOLOCK)
			   ON GQ.MostRecentStatusLkup=CL1.CMN_LookupMasterId
			INNER JOIN  [dbo].CMN_LookupMaster CL2 WITH(NOLOCK)
			   ON GQ.DiscrepancyCategoryLkup=CL2.CMN_LookupMasterId
			Where GQ.IsActive = 1
			AND GQ.WorkBasketLkup = 3001 --only OST cases
			AND GQ.DiscrepancyCategoryLkup IN (6001,6002) --OOA and SCC Cases
			AND GQ.MostRecentWorkQueueLkup IS NOT NULL
			--AND GQ.MostRecentStatusLkup <> 20003 --Not Resolved cases
			--AND GQ.MostRecentWorkQueueLkup IN (10013,10028) --cases in Queue (OOA - Pending NOT,SCC - Pending NOT)
			AND (GQ.MemberCurrentHICN = @HICN OR GQ.[MemberMedicareId]= @HICN)
END


GO

