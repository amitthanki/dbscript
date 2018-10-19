IF OBJECT_ID ('USP_APP_SEL_UserMaster') IS NOT NULL 
BEGIN
	DROP PROC [dbo].[USP_APP_SEL_UserMaster]
END
GO
/****** Object:  StoredProcedure [dbo].[USP_APP_SEL_UserMaster]    Script Date: 8/16/2017 12:30:53 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:Venkata Subramanyam Perepu
-- Create date: 06/09/2017
-- Modified By: Rakesh Hosagoudar
-- Modification Date: 06/24/2017
-- Description:To get user details based on search criteria.
-- Eg.
-- Declare @ErrorMessage VARCHAR(2000)
-- Set @ErrorMessage=''
-- Exec [USP_APP_SEL_UserMaster] @MSID=vperepu,@ErrorMessage = @ErrorMessage Output
-- =============================================
CREATE PROCEDURE [dbo].[USP_APP_SEL_UserMaster]
@MSID VARCHAR(100) = NULL,
@FullName VARCHAR(100) = NULL,
@IsActive bit = NULL,
@IsManager bit = NULL,
@Email VARCHAR(100) = NULL,
@UserId BIGINT = NULL,
@ErrorMessage VARCHAR(2000) OUT
As
BEGIN
	BEGIN TRY
		SELECT UM.[ADM_UserMasterId],UM.[LockedByRef],UM.[UTCLockedOn],UM.[Title],UM.[FirstName],UM.[LastName],UM.[FullName],UM.[SystemFullName],UM.[MSID],UM.[Email],UM.[ManagerId],
		UM.[LocationLkup],UM.[NonUserLkup],UM.[StartDate],UM.[EndDate],UM.[SpecialistTitle],UM.[SpecialistPhone],UM.[SpecialistFax],UM.[SpecialistHours],UM.[SpecialistTimeZone],
		UM.[UserAddressLine1],UM.[UserAddressLine2],UM.[UserCity],UM.[UserStateLkup],UM.[UserZip],UM.[IsActive],UM.[IsManager],UM.[UTCCreatedOn],UM.[CreatedByRef],UMCreatedBy.FullName AS CreatedBy,
		UM.[CreatedByRoleLkup],UM.[UTCLastUpdatedOn],UM.[LastUpdatedByRef],UMLastUpdatedBy.FullName AS LastUpdatedBy,UM.[LastUpdatedByRoleLkup],UMLockedBy.[FullName] as LockedByName
		FROM [dbo].[ADM_UserMaster] UM with(NoLock)
		LEFT JOIN [dbo].[ADM_UserMaster] UMCreatedBy with(NoLock) ON UM.CreatedByRef=UMCreatedBy.[ADM_UserMasterId] AND UMCreatedBy.IsActive=1
		LEFT JOIN [dbo].[ADM_UserMaster] UMLastUpdatedBy with(NoLock) ON UM.LastUpdatedByRef=UMLastUpdatedBy.[ADM_UserMasterId] AND UMLastUpdatedBy.IsActive=1
		LEFT JOIN [dbo].[ADM_UserMaster] UMLockedBy with(NoLock) ON UM.[LockedByRef] = UMLockedBy.[ADM_UserMasterId] AND UMLockedBy.IsActive=1
		WHERE (@IsActive IS NULL OR UM.IsActive=@IsActive) AND
		(@IsManager Is NULL Or UM.IsManager = @IsManager) AND
		((@MSID IS NOT NULL AND UM.MSID LIKE '%'+@MSID+'%') OR @MSID IS NULL) AND
		((@FullName IS NOT NULL AND UM.FullName LIKE '%'+@FullName+'%') OR @FullName IS NULL) AND
		((@Email IS NOT NULL AND UM.Email=@Email) OR @Email IS NULL) AND		 
		((@UserId IS NOT NULL AND UM.ADM_UserMasterId=@UserId) OR @UserId IS NULL) AND
		UM.[ADM_UserMasterId] >= 1000

		SELECT AGUC.[ADM_AccessGroupUserCorrelationId], AGUC.[ADM_AccessGroupMasterRef], AGM.[AccessGroupName], AGM.[AccessGroupDescription], AGUC.[ADM_UserMasterRef],
			   AGUC.[UTCCreatedOn],AGUC.[CreatedByRef],UMCreatedBy.FullName AS CreatedBy,AGUC.[CreatedByRoleLkup],AGUC.[UTCLastUpdatedOn],AGUC.[LastUpdatedByRef],UMLastUpdatedBy.FullName AS LastUpdatedBy,AGUC.[LastUpdatedByRoleLkup]
		FROM [dbo].[ADM_AccessGroupMaster] AGM with(NoLock)
		INNER JOIN [dbo].[ADM_AccessGroupUserCorrelation] AGUC with(NoLock) ON AGM.ADM_AccessGroupMasterId = AGUC.ADM_AccessGroupMasterRef
		LEFT JOIN [dbo].[ADM_UserMaster] UMCreatedBy with(NoLock) ON AGUC.CreatedByRef=UMCreatedBy.[ADM_UserMasterId] AND UMCreatedBy.IsActive=1
		LEFT JOIN [dbo].[ADM_UserMaster] UMLastUpdatedBy with(NoLock) ON AGUC.LastUpdatedByRef=UMLastUpdatedBy.[ADM_UserMasterId] AND UMLastUpdatedBy.IsActive=1
		WHERE AGUC.ADM_UserMasterRef = @UserId AND AGUC.IsActive= 1
	END TRY
	BEGIN CATCH
		SET @ErrorMessage = Error_Message();
	END CATCH
END

GO


