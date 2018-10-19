IF OBJECT_ID ('USP_APP_SEL_AccesssGroup') IS NOT NULL 
BEGIN
	DROP PROC [dbo].[USP_APP_SEL_AccesssGroup]
END
GO
/****** Object:  StoredProcedure [dbo].[USP_APP_SEL_AccesssGroup]    Script Date: 8/16/2017 2:12:58 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:Venkata Subramanyam Perepu
-- Create date: 14/06/2017
-- Modified By: Rakesh Hosagoudar
-- Modification Date: 06/24/2017
-- Description:To get accessgroup details.
-- Eg.
-- Declare @ErrorMessage VARCHAR(2000)
-- Set @ErrorMessage=''
-- Exec [USP_APP_SEL_AccesssGroup] @ErrorMessage = @ErrorMessage Output
-- =============================================
CREATE PROC [dbo].[USP_APP_SEL_AccesssGroup]
@AccessGroupMasterId BIGINT = NULL,
@AccessGroupName VARCHAR(250) = NULL,
@AccessGroupDescription VARCHAR(100) = NULL,
@IsActive Bit = NULL,
@ErrorMessage VARCHAR(2000) OUT
As
BEGIN
	BEGIN TRY
		SELECT	AGM.ADM_AccessGroupMasterId AS AccessGroupMasterId,
				AGM.AccessGroupName AS AccessGroupName,
				AGM.AccessGroupDescription AS AccessGroupDescription,
				AGM.RoleLkup AS RoleLkup,
				AGM.WorkBasketLkup AS WorkBasketLkup,
				AGM.IsActive AS IsActive,
				AGM.CreatedByRef,
				UM.FullName AS CreatedByName,
				AGM.UTCCreatedOn AS CreatedOn,
				AGM.LastUpdatedByRef,
				UM1.FullName AS LastUpdatedByName,
				AGM.UTCLastUpdatedOn AS LastUpdatedOn,
				AGM.LockedByRef AS LockedByRef,
				AGM.UTCLockedOn AS UTCLockedOn,
				LB.FullName AS LockedBy
		FROM	[dbo].[ADM_AccessGroupMaster] AGM with(NoLock)
				LEFT JOIN ADM_UserMaster UM with(NoLock) ON UM.ADM_UserMasterId=AGM.CreatedByRef
				LEFT JOIN ADM_UserMaster UM1 with(NoLock) ON UM1.ADM_UserMasterId=AGM.LastUpdatedByRef
				LEFT JOIN ADM_UserMaster LB with(NoLock) ON LB.ADM_UserMasterId = AGM.LockedByRef
		WHERE	(@IsActive IS NULL OR AGM.IsActive = @IsActive)
				AND (@AccessGroupMasterId IS NULL Or AGM.ADM_AccessGroupMasterId = @AccessGroupMasterId) 
				AND (@AccessGroupName IS NULL Or AGM.AccessGroupName LIKE '%'+@AccessGroupName+'%') 
				AND (@AccessGroupDescription IS NULL Or AGM.AccessGroupDescription LIKE '%'+@AccessGroupDescription+'%') 

		SELECT	AGSC.[ADM_AccessGroupSkillsCorrelationId], [ADM_AccessGroupMasterRef],AGM.[AccessGroupName],[ADM_SkillsMasterRef],SM.[SkillsName],[CanCreate],[CanModify],[CanSearch],[CanView],[CanMassUpdate],[CanHistory],[CanReassign],
				[CanUnlock],[CanUpload],[CanClone],[CanReopen],AGSC.[IsActive],AGSC.[UTCCreatedOn],AGSC.[CreatedByRef],UM.FullName As CreatedByName,AGSC.[UTCLastUpdatedOn],AGSC.[LastUpdatedByRef],UM1.FullName As LastUpdatedByName
		FROM	[dbo].[ADM_AccessGroupSkillsCorrelation] AGSC with(NoLock)
				LEFT JOIN [ADM_AccessGroupMaster] AGM with(NoLock) On AGM.[ADM_AccessGroupMasterId] = AGSC.[ADM_AccessGroupMasterRef]
				LEFT JOIN [ADM_SkillsMaster] SM with(NoLock) On SM.[ADM_SkillsMasterId] = AGSC.[ADM_SkillsMasterRef]
				LEFT JOIN [ADM_UserMaster] UM with(NoLock) ON UM.ADM_UserMasterId=AGSC.CreatedByRef
				LEFT JOIN [ADM_UserMaster] UM1 with(NoLock) ON UM1.ADM_UserMasterId=AGSC.LastUpdatedByRef
		WHERE	AGSC.IsActive = 1 
				AND AGSC.[ADM_AccessGroupMasterRef] = @AccessGroupMasterId

		SELECT	AGRC.[ADM_AccessGroupReportCorrelationId],[ADM_AccessGroupMasterRef],[RPT_ReportsMasterRef],RM.[ReportName],AGRC.[IsActive],
				AGRC.[UTCCreatedOn],AGRC.[CreatedByRef],UM.FullName As CreatedByName,AGRC.[UTCLastUpdatedOn],AGRC.[LastUpdatedByRef],UM1.FullName As LastUpdatedByName
		FROM	[dbo].[ADM_AccessGroupReportCorrelation] AGRC with(NoLock)
				LEFT JOIN [RPT_ReportsMaster] RM with(NoLock) On RM.RPT_ReportsMasterId = AGRC.RPT_ReportsMasterRef
				LEFT JOIN [ADM_UserMaster] UM with(NoLock) ON UM.ADM_UserMasterId=AGRC.CreatedByRef
				LEFT JOIN [ADM_UserMaster] UM1 with(NoLock) ON UM1.ADM_UserMasterId=AGRC.LastUpdatedByRef
		WHERE	AGRC.IsActive = 1
				AND AGRC.[ADM_AccessGroupMasterRef] = @AccessGroupMasterId

	END TRY

	BEGIN CATCH
		SET @ErrorMessage = Error_Message();
	END CATCH
END