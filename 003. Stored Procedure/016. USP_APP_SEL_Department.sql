IF OBJECT_ID ('USP_APP_SEL_Department') IS NOT NULL 
BEGIN
	DROP PROC [dbo].[USP_APP_SEL_Department]
END
GO

/****** Object:  StoredProcedure [dbo].[USP_APP_SEL_Department]    Script Date: 12-06-2017 19:31:14 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author: Sourabha Ranjan Barik
-- Create date: 06/12/2017
-- Modified By: 
-- Modification Date: 
-- Description: Get Department data based upon search criteria
-- Eg.
-- Declare @ErrorMessage VARCHAR(2000)
-- Set @ErrorMessage=''
-- Exec [USP_APP_SEL_Department] @ErrorMessage = @ErrorMessage Output
-- =============================================
CREATE PROC [dbo].[USP_APP_SEL_Department]
@CMN_DepartmentId bigint = NULL,
@ERSDepartmentName varchar(500) = NULL,
@BusinessSegmentLkup bigint = NULL,
@DepartmentLkup bigint = NULL,
@IsActive Bit = 1,
@ErrorMessage varchar(2000) OUTPUT
As
BEGIN
	BEGIN TRY

		SELECT	D.[CMN_DepartmentId],D.[LockedByRef],UM.FullName As LockedByName,D.[UTCLockedOn],D.[ERSDepartmentName],D.[BusinessSegmentLkup],LM.LookupValue As BusinessSegmentValue,
				D.[DepartmentLkup],LM1.LookupValue As DepartmentValue,D.[EffectiveDate],D.[InactivationDate],
				D.[IsActive],D.[UTCCreatedOn],D.[CreatedByRef],UM1.FullName As CreatedByName,D.[UTCLastUpdatedOn],D.[LastUpdatedByRef], UM2.FullName As LastUpdatedByName
		FROM	[CMN_Department] D with(NoLock)
				Left Join ADM_UserMaster UM with(NoLock) on UM.ADM_UserMasterId = D.LockedByRef
				Left Join ADM_UserMaster UM1 with(NoLock) on UM1.ADM_UserMasterId = D.CreatedByRef
				Left Join ADM_UserMaster UM2 with(NoLock) on UM2.ADM_UserMasterId = D.LastUpdatedByRef
				Join CMN_LookupMaster LM with(NoLock) On LM.CMN_LookupMasterId = D.BusinessSegmentLkup AND LM.CMN_LookupTypeRef = 1
				Join CMN_LookupMaster LM1 with(NoLock) On LM1.CMN_LookupMasterId = D.DepartmentLkup AND LM1.CMN_LookupTypeRef = 8
		WHERE	D.IsActive = @IsActive
				And (@CMN_DepartmentId Is NULL Or D.CMN_DepartmentId = @CMN_DepartmentId)
				And (@ERSDepartmentName Is NULL Or D.ERSDepartmentName LIKE '%'+@ERSDepartmentName+'%')
				And (@BusinessSegmentLkup Is NULL Or D.BusinessSegmentLkup = @BusinessSegmentLkup)
				And (@DepartmentLkup Is NULL Or D.DepartmentLkup = @DepartmentLkup)

	END TRY

	BEGIN CATCH
		SET @ErrorMessage = ERROR_MESSAGE();
	END CATCH
END
GO

