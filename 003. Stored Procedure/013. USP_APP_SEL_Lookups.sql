IF OBJECT_ID ('USP_APP_SEL_Lookups') IS NOT NULL 
BEGIN
	DROP PROC [DBO].[USP_APP_SEL_Lookups]
END
GO

/****** Object:  StoredProcedure [dbo].[USP_APP_SEL_Lookups]    Script Date: 12-06-2017 19:31:14 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author: Harsh Kumar Singhi
-- Create date: 06/12/2017
-- Modified By: 
-- Modification Date: 
-- Description: Get CMN_LookupType & CMN_LookupMaster data based upon search criteria
-- Eg.
-- Declare @ErrorMessage VARCHAR(2000)
-- Set @ErrorMessage=''
-- Exec [USP_APP_SEL_Lookups] @ErrorMessage = @ErrorMessage Output
-- =============================================
CREATE PROC [dbo].[USP_APP_SEL_Lookups]
@CMN_LookupTypeId bigint = NULL,
@CMN_LookupMasterId bigint = NULL,
@LookupTypeDescription varchar(75) = NULL,
@IsActive Bit = NULL,
@ErrorMessage varchar(2000) OUTPUT
As
BEGIN
	BEGIN TRY
		--If LookupMasterId filter provided, fetch only related lookuptype details
		IF(@CMN_LookupMasterId IS NOT NULL)
		BEGIN
			Set @CMN_LookupTypeId = (Select Top 1 CMN_LookupTypeRef From CMN_LookupMaster with(NoLock) WHere CMN_LookupMasterId = @CMN_LookupMasterId)
		END

		--Fetch Lookup Type
		SELECT  LT.CMN_LookupTypeId,LT.LockedByRef,UM.FullName As LockedByName,LT.UTCLockedOn,LT.LookupTypeDescription,LT.IsActive,
				LT.UTCCreatedOn,LT.CreatedByRef, UM1.FullName As CreatedByName,LT.UTCLastUpdatedOn,LT.LastUpdatedByRef, 
				UM2.FullName As LastUpdatedByName
		FROM	CMN_LookupType LT with(NoLock)
					Left Join ADM_UserMaster UM with(NoLock) on UM.ADM_UserMasterId = LT.LockedByRef
					Left Join ADM_UserMaster UM1 with(NoLock) on UM1.ADM_UserMasterId = LT.CreatedByRef
					Left Join ADM_UserMaster UM2 with(NoLock) on UM2.ADM_UserMasterId = LT.LastUpdatedByRef
		WHERE	(@IsActive IS NULL OR LT.IsActive = @IsActive)
				And (@LookupTypeDescription Is Null Or LT.LookupTypeDescription LIKE '%'+@LookupTypeDescription+'%')
				And (@CMN_LookupTypeId Is NULL Or LT.CMN_LookupTypeId = @CMN_LookupTypeId)
		
		--Fetch Lookup Master
		SELECT	LM.CMN_LookupMasterId,LM.CMN_LookupTypeRef,LM.LookupValue,LM.LookupDescription,LM.LookupValue1,LM.LookupValue2,LM.DisplayOrder,LM.IsActive,
				LM.UTCCreatedOn,LM.CreatedByRef,UM1.FullName As CreatedByName,LM.UTCLastUpdatedOn,LM.LastUpdatedByRef,UM2.FullName As LastUpdatedByName 
		FROM	CMN_LookupMaster LM with(NoLock)
					Left Join ADM_UserMaster UM1 with(NoLock) on UM1.ADM_UserMasterId = LM.CreatedByRef
					Left Join ADM_UserMaster UM2 with(NoLock) on UM2.ADM_UserMasterId = LM.LastUpdatedByRef
		WHERE	(@CMN_LookupTypeId IS NULL Or LM.CMN_LookupTypeRef = @CMN_LookupTypeId) And
				(@CMN_LookupMasterId IS NULL Or LM.CMN_LookupMasterId = @CMN_LookupMasterId)

	END TRY

	BEGIN CATCH
		SET @ErrorMessage= ERROR_MESSAGE();
	END CATCH
END
GO