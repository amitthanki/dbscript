IF OBJECT_ID ('USP_APP_SEL_ResourceDetails') IS NOT NULL
BEGIN
	DROP PROC [DBO].[USP_APP_SEL_ResourceDetails]
END
GO

/****** Object:  StoredProcedure [dbo].[USP_APP_SEL_ResourceDetails]    Script Date: 12-06-2017 19:31:14 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author: Harsh Kumar Singhi
-- Create date: 06/14/2017
-- Modified By: 
-- Modification Date: 
-- Description: Get Resource Details data based upon search criteria
-- Eg.
-- Declare @ErrorMessage VARCHAR(2000)
-- Set @ErrorMessage=''
-- Exec [USP_APP_SEL_ResourceDetails] @ErrorMessage = @ErrorMessage Output
-- =============================================
CREATE PROC [dbo].[USP_APP_SEL_ResourceDetails]
@ADM_ResourceDetailsId Bigint = NULL,
@ResourceName varchar(50) = NULL,
@ResourceDescription varchar(5000) = NULL,
@ResourceLinkLocation varchar(500) = NULL,
@ConsiderDates Bit = 0,
@IsActive Bit = 1,
@ErrorMessage varchar(2000) OUTPUT
As
BEGIN
	BEGIN TRY
		Select	ADM_ResourceDetailsId
				,RD.LockedByRef
				,UM.FullName as [LockedByName]
				,RD.UTCLockedOn
				,ResourceName
				,ResourceDescription
				,ResourceLinkLocation
				,ResourceEffectiveDate
				,ResourceInactivationDate
				,CMN_DepartmentRef
				,D.ERSDepartmentName as [CMN_DepartmentValue]
				,RD.IsActive
				,RD.UTCCreatedOn
				,RD.CreatedByRef
				,UM1.FullName as [CreatedByName]
				,RD.UTCLastUpdatedOn
				,RD.LastUpdatedByRef
				,UM2.FullName as [LastUpdatedByName]
		From ADM_ResourceDetails RD with(NoLock)
				Left Join ADM_UserMaster UM with(NoLock) on UM.ADM_UserMasterId = RD.LockedByRef
				Left Join ADM_UserMaster UM1 with(NoLock) on UM1.ADM_UserMasterId = RD.CreatedByRef
				Left Join ADM_UserMaster UM2 with(NoLock) on UM2.ADM_UserMasterId = RD.LastUpdatedByRef
				Left Join CMN_Department D with(NoLock) on D.CMN_DepartmentId = RD.CMN_DepartmentRef
		where RD.IsActive = @IsActive
			AND (@ResourceName Is Null Or RD.ResourceName LIKE '%'+@ResourceName+'%')
			AND (@ResourceDescription Is Null Or RD.ResourceDescription LIKE '%'+@ResourceDescription+'%')
			AND (@ResourceLinkLocation Is Null Or RD.ResourceLinkLocation = @ResourceLinkLocation)
			AND (@ADM_ResourceDetailsId Is NULL Or RD.ADM_ResourceDetailsId = @ADM_ResourceDetailsId)
			AND (@ConsiderDates = 0 OR ((RD.ResourceInactivationDate Is NULL OR getUtcdate() <= RD.ResourceInactivationDate) AND (RD.ResourceEffectiveDate Is NULL OR getUtcdate() >= RD.ResourceEffectiveDate)))

	END TRY

	BEGIN CATCH
		SET @ErrorMessage= ERROR_MESSAGE();
	END CATCH
END