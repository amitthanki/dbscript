IF OBJECT_ID ('USP_APP_SEL_Skills') IS NOT NULL 
BEGIN
	DROP PROC [dbo].[USP_APP_SEL_Skills]
END
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author: Harsh Kumar Singhi
-- Create date: 06/15/2017
-- Modified By: Rakesh Hosagoudar
-- Modification Date: 06/24/2017
-- Description: Get skills data based upon search criteria
-- Eg.
-- Declare @ErrorMessage VARCHAR(2000)
-- Set @ErrorMessage=''
-- Exec [USP_APP_SEL_Skills] @ErrorMessage = @ErrorMessage Output
-- =============================================
CREATE PROC [dbo].[USP_APP_SEL_Skills]
@ADM_SkillsMasterId bigint = NULL,
@SkillsName varchar(200) = NULL,
@RoleLkup bigint = NULL,
@BusinessSegmentLkup bigint = NULL,
@CMN_DepartmentRef bigint = NULL,
@WorkBasketLkup bigint = NULL,
@DiscrepancyCategoryLkup bigint = NULL,
@IsActive Bit = NULL,
@ErrorMessage varchar(2000) OUTPUT
As
BEGIN
	BEGIN TRY
		Select 
			SM.[ADM_SkillsMasterId],SM.[LockedByRef],UM1.Fullname as [LockedByName],SM.[UTCLockedOn],SM.[SkillsName],SM.[RoleLkup],
			LM.LookupValue as [RoleValue],SM.[BusinessSegmentLkup],LM1.LookupValue as [BusinessSegmentValue],SM.[CMN_DepartmentRef],
			D.ERSDepartmentName as [DepartmentName],SM.[WorkBasketLkup],LM2.LookupValue as [WorkBasketValue],SM.[DiscrepancyCategoryLkup],LM3.LookupValue as [DiscrepancyCategoryValue],
			SM.[IsActive],SM.[UTCCreatedOn],SM.[CreatedByRef],UM2.FullName as [CreatedByName],SM.[UTCLastUpdatedOn],SM.[LastUpdatedByRef],UM3.FullName as [LastUpdatedByName]
		From ADM_SkillsMaster SM With(Nolock)
			left Join ADM_UserMaster UM1 With(Nolock) On UM1.ADM_UserMasterId = SM.LockedByRef
			left Join ADM_UserMaster UM2 With(Nolock) On UM2.ADM_UserMasterId = SM.CreatedByRef
			left Join ADM_UserMaster UM3 With(Nolock) On UM3.ADM_UserMasterId = SM.LastUpdatedByRef
			left join CMN_LookupMaster LM With(Nolock) on LM.CMN_LookupMasterId = SM.RoleLkup AND LM.CMN_LookupTypeRef = 2
			left join CMN_LookupMaster LM1 With(Nolock) on LM1.CMN_LookupMasterId = SM.BusinessSegmentLkup AND LM1.CMN_LookupTypeRef = 1
			left join CMN_LookupMaster LM2 With(Nolock)on LM2.CMN_LookupMasterId = SM.WorkBasketLkup AND LM2.CMN_LookupTypeRef = 3
			left join CMN_LookupMaster LM3 With(Nolock)on LM3.CMN_LookupMasterId = SM.DiscrepancyCategoryLkup AND LM3.CMN_LookupTypeRef = 6
			left join CMN_Department D With(Nolock) on D.CMN_DepartmentId = SM.CMN_DepartmentRef
		Where (@IsActive IS NULL OR SM.IsActive=@IsActive )
			  And (@ADM_SkillsMasterId Is NULL Or SM.ADM_SkillsMasterId=@ADM_SkillsMasterId)
			  And (@SkillsName Is NULL Or SM.SkillsName LIKE '%'+@SkillsName+'%')
			  And (@RoleLkup Is NULL Or SM.RoleLkup = @RoleLkup)
			  And (@BusinessSegmentLkup Is NULL Or SM.BusinessSegmentLkup = @BusinessSegmentLkup)
			  And (@WorkBasketLkup Is NULL Or SM.WorkBasketLkup = @WorkBasketLkup)
			  And (@DiscrepancyCategoryLkup Is NULL Or SM.DiscrepancyCategoryLkup = @DiscrepancyCategoryLkup)
			  And (@CMN_DepartmentRef Is NULL Or SM.CMN_DepartmentRef = @CMN_DepartmentRef)	
			  
		SELECT SWQC.ADM_SkillWorkQueuesCorrelationId, [ADM_SkillsMasterRef],SWQC.[WorkQueuesLkup],
				LM1.LookupValue as [WorkQueuesValue],SWQC.[IsActive],SWQC.[UTCCreatedOn],SWQC.[CreatedByRef],UM1.FullName as [CreatedByName],
			   SWQC.[UTCLastUpdatedOn],SWQC.[LastUpdatedByRef], UM2.FullName as [LastUpdatedByName]
		FROM   [dbo].[ADM_SkillWorkQueuesCorrelation] SWQC With(Nolock)
			   LEFT JOIN ADM_SkillsMaster SM With(Nolock) on SM.ADM_SkillsMasterId = SWQC.ADM_SkillsMasterRef
			   LEFT JOIN CMN_LookupMaster LM1 With(Nolock) on LM1.CMN_LookupMasterId = SWQC.WorkQueuesLkup AND LM1.CMN_LookupTypeRef = 10
			   LEFT Join ADM_UserMaster UM1 With(Nolock) On UM1.ADM_UserMasterId = SWQC.CreatedByRef
			   LEFT Join ADM_UserMaster UM2 With(Nolock) On UM2.ADM_UserMasterId = SWQC.LastUpdatedByRef
		WHERE  SWQC.IsActive = 1
			   AND SWQC.ADM_SkillsMasterRef = @ADM_SkillsMasterId
		
	END TRY 

	BEGIN CATCH
		   SET @ErrorMessage= ERROR_MESSAGE();
	END CATCH  
END
GO
