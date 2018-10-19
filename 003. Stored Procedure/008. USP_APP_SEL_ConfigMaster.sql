IF OBJECT_ID ('USP_APP_SEL_ConfigMaster') IS NOT NULL 
BEGIN
	DROP PROC [dbo].[USP_APP_SEL_ConfigMaster]
END
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author: Sourabha Ranjan Barik
-- Create date: 06/12/2017
-- Modified By: 
-- Modification Date: 
-- Description: Get MGR_ConfigMaster data based upon search criteria
-- Eg.
-- Declare @ErrorMessage VARCHAR(2000)
-- Set @ErrorMessage=''
-- Exec [USP_APP_SEL_ConfigMaster] @ErrorMessage = @ErrorMessage Output
-- =============================================
CREATE PROC [dbo].[USP_APP_SEL_ConfigMaster]
@MGR_ConfigMasterId bigint = NULL,
@ConfigName varchar(500) = NULL,
@IsActive Bit = 1,
@ErrorMessage varchar(2000) OUTPUT
As
BEGIN
	BEGIN TRY
		Select CM.MGR_ConfigMasterId,CM.LockedByRef,UM1.FullName As LockedByName,CM.UTCLockedOn,CM.ConfigName,CM.ConfigValue,CM.[Version],CM.StartDate,CM.EndDate,CM.IsActive,
			   CM.UTCCreatedOn,CM.CreatedByRef,UM2.FullName As CreatedByName,CM.UTCLastUpdatedOn,CM.LastUpdatedByRef,UM3.FullName As LastUpdatedByName
		From MGR_ConfigMaster CM with(NoLock)
				Left Join ADM_UserMaster UM1 with(NoLock) On UM1.ADM_UserMasterId = CM.LockedByRef
				Left Join ADM_UserMaster UM2 with(NoLock) On UM2.ADM_UserMasterId = CM.CreatedByRef
				Left Join ADM_UserMaster UM3 with(NoLock) On UM3.ADM_UserMasterId = CM.LastUpdatedByRef
		Where CM.IsActive=@IsActive 
			  And (@ConfigName Is NULL Or CM.ConfigName LIKE '%'+@ConfigName+'%')
			  And (@MGR_ConfigMasterId Is NULL Or CM.MGR_ConfigMasterId = @MGR_ConfigMasterId)
	END TRY 

	BEGIN CATCH
		   SET @ErrorMessage= ERROR_MESSAGE();
	END CATCH  
END
GO
