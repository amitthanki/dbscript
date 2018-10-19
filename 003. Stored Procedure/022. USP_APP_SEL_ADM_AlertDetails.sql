IF OBJECT_ID ('USP_APP_SEL_ADM_AlertDetails') IS NOT NULL 
BEGIN
	DROP PROC [dbo].[USP_APP_SEL_ADM_AlertDetails]
END
GO

/****** Object:  StoredProcedure [dbo].[USP_APP_SEL_ADM_AlertDetails]    Script Date: 14-06-2017 19:31:14 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author: Harsh Kumar Singhi
-- Create date: 06/14/2017
-- Modified By: 
-- Modification Date: 
-- Description: Get alert details data based upon search criteria
-- Eg.
-- Declare @ErrorMessage VARCHAR(2000)
-- Set @ErrorMessage=''
-- Exec [USP_APP_SEL_ADM_AlertDetails] @ErrorMessage = @ErrorMessage Output
-- =============================================
CREATE PROC [dbo].[USP_APP_SEL_ADM_AlertDetails]
@ADM_AlertDetailsId BIGINT = NULL,
@AlertTitle VARCHAR(250) = NULL,
@AlertDescription VARCHAR(5000) = NULL,
@LoginUserId BIGINT = NULL,
@ConsiderDates Bit = 0,
@IsActive BIT = 1,
@ErrorMessage VARCHAR(2000) OUTPUT
AS
BEGIN
	BEGIN TRY
		
		DECLARE @Departments TABLE(CMN_DepartmentRef BIGINT)
		INSERT INTO @Departments(CMN_DepartmentRef)	SELECT DISTINCT ASM.CMN_DepartmentRef
													FROM ADM_AccessGroupUserCorrelation AGU with(NoLock)
													JOIN ADM_AccessGroupMaster AGM with(NoLock) on AGU.ADM_AccessGroupMasterRef = AGM.ADM_AccessGroupMasterId AND AGU.IsActive=1 AND AGM.IsActive = 1
													JOIN ADM_AccessGroupSkillsCorrelation AGSC with(NoLock) on AGM.ADM_AccessGroupMasterId = AGSC.ADM_AccessGroupMasterRef AND AGSC.IsActive = 1
													JOIN ADM_SkillsMaster ASM with(NoLock) on AGSC.ADM_SkillsMasterRef=ASM.ADM_SkillsMasterId AND ASM.IsActive = 1
													WHERE AGU.ADM_UserMasterRef=@LoginUserId

		Select	[ADM_AlertDetailsId],AD.[LockedByRef],UM.FullName as [LockedByName],AD.[UTCLockedOn],[AlertTitle],[AlertDescription],
				[AlertPublishedDate],[AlertEffectiveDate],[AlertInactivationDate],[AlertCriticalityLkup],LM.LookupValue as [AlertCriticalityValue],
				[SendAlertToLkup],LM1.LookupValue as [SendAlertToValue],AD.[CMN_DepartmentRef],D.ERSDepartmentName as [DepartmentName],
				AD.[ADM_UserMasterRef],UM3.FullName as [IndividualUserName],AD.[IsActive],AD.[UTCCreatedOn],AD.[CreatedByRef],
				UM1.FullName as [CreatedByName],AD.[UTCLastUpdatedOn],AD.[LastUpdatedByRef],UM2.Fullname as [LastUpdatedByName]
		FROM	ADM_AlertDetails AD with(NoLock)
				   Left Join ADM_UserMaster UM with(NoLock) on UM.ADM_UserMasterId = AD.LockedByRef
				   Left Join ADM_UserMaster UM1 with(NoLock) on UM1.ADM_UserMasterId = AD.CreatedByRef
				   Left Join ADM_UserMaster UM2 with(NoLock) on UM2.ADM_UserMasterId = AD.LastUpdatedByRef
				   Left Join ADM_UserMaster UM3 with(NoLock) on UM3.ADM_UserMasterId = AD.ADM_UserMasterRef
				   Left Join CMN_Department D with(NoLock) on D.CMN_DepartmentId = AD.CMN_DepartmentRef
				   Left Join CMN_LookupMaster LM with(NoLock) on LM.CMN_LookupMasterId = AD.AlertCriticalityLkup AND LM.CMN_LookupTypeRef = 36
				   Left Join CMN_LookupMaster LM1 with(NoLock) on LM1.CMN_LookupMasterId = AD.SendAlertToLkup AND LM1.CMN_LookupTypeRef = 35
		WHERE	AD.IsActive = @IsActive
				AND (@AlertTitle Is Null Or AlertTitle LIKE '%'+@AlertTitle+'%')
				AND (@AlertDescription Is Null Or AlertDescription LIKE '%'+@AlertDescription+'%')
				AND (@ADM_AlertDetailsId Is Null Or ADM_AlertDetailsId = @ADM_AlertDetailsId)
				AND (@LoginUserId Is Null Or SendAlertToLkup = 35001 Or ADM_UserMasterRef = @LoginUserId OR CMN_DepartmentRef In (Select CMN_DepartmentRef from @Departments))
				AND (@ConsiderDates = 0 OR ((AD.AlertInactivationDate Is NULL OR getutcdate() <= AD.AlertInactivationDate) AND (AD.AlertEffectiveDate Is NULL OR getutcdate() >= AD.AlertEffectiveDate)))
	END TRY

	BEGIN CATCH
		SET @ErrorMessage= ERROR_MESSAGE();
	END CATCH
END