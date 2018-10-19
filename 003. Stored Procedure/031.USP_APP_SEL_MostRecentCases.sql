IF OBJECT_ID ('USP_APP_SEL_MostRecentCases') IS NOT NULL 
BEGIN
	DROP PROC [dbo].[USP_APP_SEL_MostRecentCases]
END
GO
/****** Object:  StoredProcedure [dbo].[USP_APP_SEL_MostRecentCases]    Script Date: 8/7/2017 4:32:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:Rakesh
-- Create date: 09/01/2017
-- Modified By: 
-- Modification Date: 
-- Description: Get most recent cases accessed by logged-in user
-- Eg.
-- Declare @ErrorMessage VARCHAR(2000)
-- Set @ErrorMessage=''
-- Exec [USP_APP_SEL_MostRecentCases] @ErrorMessage = @ErrorMessage Output
-- =============================================
CREATE PROCEDURE [dbo].[USP_APP_SEL_MostRecentCases]
@LoginUserId bigint,
@BusinessSegmentLkup BIGINT,
@WorkBasketLkup BIGINT = NULL,
@ErrorMessage as varchar(2000) OUTPUT 
AS
BEGIN
BEGIN TRY
	
	With CTE as
	(
		SELECT GQ.[GEN_QueueId]
			,GQ.[MemberMedicareId]
			,GQ.[GPSHouseholdID]
			,GQ.[MemberFirstName]
			,GQ.[MemberMiddleName]
			,GQ.[MemberLastName]
			,GQ.[MemberContractIDLkup]
			,LMContract.LookupValue MemberContract
			,GQ.[MemberPBPLkup]
			,LMPBP.LookupValue MemberPBP
			,GQ.[MemberLOBLkup]
			,LMLOB.LookupValue MemberLOB
			,GQ.[BusinessSegmentLkup]
			,LMBusinessSegment.LookupValue BusinessSegment
			,GQ.[WorkBasketLkup]
			,LMWorkBasket.LookupValue AS WorkBasket
			,GQ.[DiscrepancyCategoryLkup]
			,LMDiscrepancyCategory.LookupValue AS DiscrepancyCategory
			,GQ.[DiscrepancyTypeLkup]
			,LMDiscrepancyType.LookupValue AS DiscrepancyType
			,GQ.[AssignedToRef]
			,UMAssignedTo.[FullName] AS AssignedTo
			,GQ.[UTCAssignedOn]
			,GQ.[LockedByRef]
			,UMLockedBy.[FullName] AS LockedBy
			,GQ.[UTCLockedOn],GQ.[CSTLockedOn]
			,GQ.[MostRecentActionLkup]
			,LMMostRecentAction.LookupValue AS MostRecentAction 
			,GQ.[MostRecentWorkQueueLkup]
			,LMMostRecentWorkQueue.LookupValue AS MostRecentWorkQueue
			,GQ.[MostRecentStatusLkup]
			,LMMostRecentStatus.LookupValue AS MostRecentStatus
			,GQ.UTCCreatedOn
			,GQ.CreatedByRef
			,UMCreatedBy.FullName as CreatedBy
			,GQ.UTCLastUpdatedOn
			,GQ.LastUpdatedByRef
			,UMLastUpdatedBy.FullName as LastUpdatedBy
			,MC.[UTCCreatedOn] as ManageCaseCreatedOn
	        ,GQ.OOALetterStatusLkup
			,GQ.CMSTransactionStatusLkup
			,LMQueueType.GroupingLookupMasterRef as QueueProgressTypeLkup
			,Rank() Over (Partition By GEN_QueueId Order By MC.[UTCCreatedOn] DESC) As RowNum
		FROM [dbo].[GEN_ManageCases] MC With(Nolock)
		LEFT JOIN [dbo].[GEN_Queue] GQ With(Nolock) ON MC.GEN_QueueRef=GQ.Gen_QueueId AND MC.CurrentUserRef=@LoginUserId AND MC.IsActive=1 AND GQ.IsActive=1 AND MC.UTCCreatedOn >= DATEADD(DAY,-1,GETUTCDATE())
		LEFT JOIN [dbo].[CMN_LookupMaster] LMBusinessSegment  With(Nolock) ON GQ.[BusinessSegmentLkup]=LMBusinessSegment.[CMN_LookupMasterId] AND LMBusinessSegment.IsActive=1
		LEFT JOIN [dbo].[CMN_LookupMaster] LMContract  With(Nolock) ON GQ.[MemberContractIDLkup]=LMContract.[CMN_LookupMasterId] AND LMContract.IsActive=1
		LEFT JOIN [dbo].[CMN_LookupMaster] LMPBP  With(Nolock) ON GQ.[MemberPBPLkup]=LMPBP.[CMN_LookupMasterId] AND LMPBP.IsActive=1
		LEFT JOIN [dbo].[CMN_LookupMaster] LMLOB With(Nolock) ON GQ.[MemberLOBLkup]=LMLOB.[CMN_LookupMasterId] AND LMLOB.IsActive=1
		LEFT JOIN [dbo].[CMN_LookupMaster] LMWorkBasket With(Nolock) ON GQ.[WorkBasketLkup]=LMWorkBasket.[CMN_LookupMasterId] AND LMWorkBasket.IsActive=1
		LEFT JOIN [dbo].[CMN_LookupMaster] LMDiscrepancyCategory With(Nolock) ON GQ.[DiscrepancyCategoryLkup]=LMDiscrepancyCategory.[CMN_LookupMasterId] AND LMDiscrepancyCategory.IsActive=1
		LEFT JOIN [dbo].[CMN_LookupMaster] LMDiscrepancyType With(Nolock) ON GQ.[DiscrepancyTypeLkup]=LMDiscrepancyType.[CMN_LookupMasterId] AND LMDiscrepancyType.IsActive=1
		LEFT JOIN [dbo].[CMN_LookupMaster] LMMostRecentAction With(Nolock) ON GQ.[MostRecentActionLkup]=LMMostRecentAction.[CMN_LookupMasterId] AND LMMostRecentAction.IsActive=1
		LEFT JOIN [dbo].[CMN_LookupMaster] LMMostRecentWorkQueue With(Nolock) ON GQ.[MostRecentWorkQueueLkup]=LMMostRecentWorkQueue.[CMN_LookupMasterId] AND LMMostRecentWorkQueue.IsActive=1
		LEFT JOIN [dbo].[CMN_LookupMaster] LMMostRecentStatus With(Nolock) ON GQ.[MostRecentStatusLkup]=LMMostRecentStatus.[CMN_LookupMasterId] AND LMMostRecentStatus.IsActive=1
		LEFT JOIN CMN_LookupMasterCorrelations LMQueueType With(Nolock) ON GQ.MostRecentWorkQueueLkup=LMQueueType.CMN_LookupMasterChildRef AND LMQueueType.CMN_LookupTypeCorrelationsRef=3
		LEFT JOIN [dbo].[ADM_UserMaster] UMCreatedBy With(Nolock) ON GQ.CreatedByRef=UMCreatedBy.ADM_UserMasterId
		LEFT JOIN [dbo].[ADM_UserMaster] UMLastUpdatedBy With(Nolock) ON GQ.LastUpdatedByRef=UMLastUpdatedBy.ADM_UserMasterId
		LEFT JOIN [dbo].[ADM_UserMaster] UMAssignedTo  With(Nolock) ON GQ.[AssignedToRef]=UMAssignedTo.[ADM_UserMasterId] AND UMAssignedTo.IsActive=1
		LEFT JOIN [dbo].[ADM_UserMaster] UMLockedBy  With(Nolock) ON GQ.LockedByRef=UMLockedBy.[ADM_UserMasterId] AND UMLockedBy.IsActive=1
		WHERE GQ.[BusinessSegmentLkup]=@BusinessSegmentLkup AND GQ.[WorkBasketLkup]=@WorkBasketLkup
	)
	Select Distinct TOP 10 [GEN_QueueId],[MemberMedicareId] AS [MemberCurrentHICN],[GPSHouseholdID],[MemberFirstName],[MemberMiddleName],[MemberLastName],[MemberContractIDLkup],[MemberContract],
					[MemberPBPLkup],[MemberPBP],[MemberLOBLkup],[MemberLOB],[BusinessSegmentLkup],[BusinessSegment],[WorkBasketLkup],[WorkBasket],[DiscrepancyCategoryLkup],[DiscrepancyCategory],[DiscrepancyTypeLkup],
					[DiscrepancyType],[AssignedToRef],[AssignedTo],[UTCAssignedOn],[LockedByRef],[LockedBy],[UTCLockedOn],[CSTLockedOn],[MostRecentActionLkup],[MostRecentAction],[MostRecentWorkQueueLkup],[MostRecentWorkQueue],
					[MostRecentStatusLkup],[MostRecentStatus],[UTCCreatedOn],[CreatedByRef],[CreatedBy],[UTCLastUpdatedOn],[LastUpdatedByRef],[LastUpdatedBy],[ManageCaseCreatedOn],OOALetterStatusLkup,CMSTransactionStatusLkup,QueueProgressTypeLkup
	From CTE Where RowNum = 1 ORDER BY [ManageCaseCreatedOn] DESC

END TRY

BEGIN CATCH
SET @ErrorMessage = Error_Message();
END CATCH

END 