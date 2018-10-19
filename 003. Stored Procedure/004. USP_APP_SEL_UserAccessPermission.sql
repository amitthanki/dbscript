IF OBJECT_ID ('USP_APP_SEL_UserAccessPermission') IS NOT NULL 
BEGIN
	DROP PROC [dbo].[USP_APP_SEL_UserAccessPermission]
END
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:Venkata Subramanyam Perepu
-- Create date: 06/09/2017
-- Modified By: 
-- Modification Date: 
-- Description:To get user access group
-- Eg.
-- Declare @ErrorMessage VARCHAR(2000)
-- Set @ErrorMessage=''
-- Exec [USP_APP_SEL_UserAccessPermission] @MSID=vperepu,@ErrorMessage = @ErrorMessage Output
-- =============================================
CREATE PROCEDURE [dbo].[USP_APP_SEL_UserAccessPermission]
@MSID VARCHAR(100) = NULL,
@BusinessSegmentLkup BIGINT = NULL,
@WorkBasketLkup BIGINT = NULL,
@RoleLkup BIGINT = NULL,
@ErrorMessage VARCHAR(2000) OUTPUT
As
BEGIN
	Declare @UserId BIGINT = NULL;
	BEGIN TRY
		SELECT @UserId = UM.ADM_UserMasterId FROM ADM_UserMaster UM with(NoLock) WHERE UM.MSID=@MSID AND UM.IsActive=1

		SELECT ADM_UserMasterId,FullName,MSID,Email,ManagerId,LocationLkup,StartDate,EndDate FROM ADM_UserMaster with(NoLock) WHERE MSID=@MSID AND IsActive=1

		SELECT ASM.SkillsName,ASM.RoleLkup,ASM.BusinessSegmentLkup,ASM.WorkBasketLkup,ASM.CMN_DepartmentRef,ASM.DiscrepancyCategoryLkup,ASQC.WorkQueuesLkup,
			   AGSC.CanCreate,AGSC.CanModify,AGSC.CanSearch,AGSC.CanView,AGSC.CanMassUpdate,AGSC.CanHistory,AGSC.CanReassign,AGSC.CanUnlock,AGSC.CanUpload,AGSC.CanClone,AGSC.CanReopen
		FROM ADM_AccessGroupUserCorrelation AGU with(NoLock)
		JOIN ADM_AccessGroupMaster AGM with(NoLock) on AGU.ADM_AccessGroupMasterRef = AGM.ADM_AccessGroupMasterId AND AGU.IsActive=1 AND AGM.IsActive = 1
		JOIN ADM_AccessGroupSkillsCorrelation AGSC with(NoLock) on AGM.ADM_AccessGroupMasterId = AGSC.ADM_AccessGroupMasterRef AND AGSC.IsActive = 1
		JOIN ADM_SkillsMaster ASM with(NoLock) on AGSC.ADM_SkillsMasterRef=ASM.ADM_SkillsMasterId AND ASM.IsActive = 1
		JOIN ADM_SkillWorkQueuesCorrelation ASQC with(NoLock) on ASM.ADM_SkillsMasterId=ASQC.ADM_SkillsMasterRef AND ASQC.IsActive = 1
		LEFT JOIN CMN_LookupMaster LM with(NoLock) on ASQC.WorkQueuesLkup = LM.CMN_LookupMasterId AND LM.CMN_LookupTypeRef=10 AND LM.IsActive = 1
		WHERE AGU.ADM_UserMasterRef=@UserId

		SELECT LM.CMN_LookupMasterId as QueueLkp, LM.LookupValue as QueueName
		FROM  ADM_AccessGroupUserCorrelation AGU with(NoLock)
		JOIN ADM_AccessGroupMaster AGM with(NoLock) on AGU.ADM_AccessGroupMasterRef = AGM.ADM_AccessGroupMasterId AND AGU.IsActive=1 AND AGM.IsActive = 1
		JOIN ADM_AccessGroupSkillsCorrelation AGSC with(NoLock) on AGM.ADM_AccessGroupMasterId = AGSC.ADM_AccessGroupMasterRef AND AGSC.IsActive = 1
		JOIN ADM_SkillsMaster ASM with(NoLock) on AGSC.ADM_SkillsMasterRef=ASM.ADM_SkillsMasterId AND ASM.IsActive = 1
		JOIN ADM_SkillWorkQueuesCorrelation ASQC with(NoLock) on ASM.ADM_SkillsMasterId=ASQC.ADM_SkillsMasterRef AND ASQC.IsActive = 1
		LEFT JOIN CMN_LookupMaster LM with(NoLock) on ASQC.WorkQueuesLkup = LM.CMN_LookupMasterId AND LM.CMN_LookupTypeRef=10 AND LM.IsActive = 1
		WHERE AGU.ADM_UserMasterRef=@UserId

		SELECT	ADM_UserPreferenceId,ADM_UserMasterRef,ShowAlerts,ShowResources,BusinessSegmentLkup,RoleLkup,TimezoneLkup,WorkBasketLkup,ShowOSTSummary,
				ShowEligibilitySummary,ShowRPRSummary,IsActive,UTCCreatedOn,CreatedByRef,UTCLastUpdatedOn,LastUpdatedByRef 
		FROM	ADM_UserPreference with(NoLock)
		WHERE	ADM_UserMasterRef = @UserId

		SELECT AGM.ADM_AccessGroupMasterId,AGM.AccessGroupName,AGM.AccessGroupDescription,AGM.RoleLkup,AGM.WorkBasketLkup
		FROM ADM_AccessGroupUserCorrelation AGU with(NoLock)
		JOIN ADM_AccessGroupMaster AGM with(NoLock) on AGU.ADM_AccessGroupMasterRef = AGM.ADM_AccessGroupMasterId AND AGU.IsActive=1 AND AGM.IsActive = 1
		WHERE AGU.ADM_UserMasterRef = @UserId

		--SELECT RM.RPT_ReportsMasterId,RM.ReportName,RM.ReportServer,RM.ReportURL,RM.ReportsCategoryLkup,RM.ViewInUI		
		--FROM ADM_AccessGroupUserCorrelation AGU
		--JOIN ADM_AccessGroupMaster AGM on AGU.ADM_AccessGroupMasterRef = AGM.ADM_AccessGroupMasterId AND AGU.IsActive=1 AND AGM.IsActive = 1
		--JOIN ADM_AccessGroupReportCorrelation AGSC on AGM.ADM_AccessGroupMasterId = AGSC.ADM_AccessGroupMasterRef AND AGSC.IsActive = 1
		--JOIN RPT_ReportsMaster RM on AGSC.RPT_ReportsMasterRef=RM.RPT_ReportsMasterId AND RM.IsActive = 1
		--WHERE AGU.ADM_UserMasterRef=@UserId

		SELECT RM.RPT_ReportsMasterId,RM.ReportName,RM.ReportServer,RM.ReportURL,RM.ReportsCategoryLkup,RM.ViewInUI,AGM.ADM_AccessGroupMasterId,AGM.AccessGroupName,AGM.AccessGroupDescription,AGM.RoleLkup,AGM.WorkBasketLkup
		FROM ADM_AccessGroupUserCorrelation AGU with(NoLock)
		JOIN ADM_AccessGroupMaster AGM with(NoLock) on AGU.ADM_AccessGroupMasterRef = AGM.ADM_AccessGroupMasterId AND AGU.IsActive=1 AND AGM.IsActive = 1
		JOIN ADM_AccessGroupReportCorrelation AGSC with(NoLock) on AGU.ADM_AccessGroupMasterRef = AGSC.ADM_AccessGroupMasterRef AND AGSC.IsActive = 1
		JOIN RPT_ReportsMaster RM with(NoLock) on AGSC.RPT_ReportsMasterRef=RM.RPT_ReportsMasterId AND RM.IsActive = 1
		WHERE AGU.ADM_UserMasterRef=@UserId


	END TRY

	BEGIN CATCH
		SET @ErrorMessage= ERROR_MESSAGE();
	END CATCH
END