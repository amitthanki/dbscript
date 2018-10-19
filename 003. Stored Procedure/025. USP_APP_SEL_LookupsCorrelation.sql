IF OBJECT_ID ('USP_APP_SEL_LookupsCorrelation') IS NOT NULL 
BEGIN
	DROP PROC [dbo].[USP_APP_SEL_LookupsCorrelation]
END
GO

/****** Object:  StoredProcedure [dbo].[USP_APP_SEL_LookupsCorrelation]    Script Date: 14-06-2017 19:31:14 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: Harsh Kumar Singhi
-- Create date: 06/14/2017
-- Modified By: 
-- Modification Date: 
-- Description: Get lookup correlation data based upon search criteria.
-- Eg.
-- Declare @ErrorMessage VARCHAR(2000)
-- Set @ErrorMessage=''
-- Exec [USP_APP_SEL_LookupsCorrelation] @ErrorMessage = @ErrorMessage Output
-- =============================================
CREATE PROC [dbo].[USP_APP_SEL_LookupsCorrelation]
@CMN_LookupTypeCorrelationsId bigint = NULL,
@CMN_LookupMasterCorrelationsId bigint = NULL,
@CorrelationDescription varchar(1000) = NULL,
@CMN_LookupTypeParentRef bigint = NULL,
@CMN_LookupTypeChildRef bigint = NULL,
@IsActive Bit = NULL,
@ErrorMessage varchar(2000) OUTPUT
AS
BEGIN
	BEGIN TRY
		--If LookupMasterCorrelationsId filter provided fetch only related LookupTypeCorrelation details
		IF(@CMN_LookupMasterCorrelationsId Is NOT NULL)
		BEGIN
			Set @CMN_LookupTypeCorrelationsId = (Select Top 1 CMN_LookupTypeCorrelationsRef From CMN_LookupMasterCorrelations Where CMN_LookupMasterCorrelationsId = @CMN_LookupMasterCorrelationsId)
		END

		--Fetch LookupTypeCorrelation details
		SELECT	LTC.CMN_LookupTypeCorrelationsId,LTC.CMN_LookupTypeParentRef, LT.LookupTypeDescription as [CMN_LookupTypeParentValue],
				LTC.CMN_LookupTypeChildRef, LT1.LookupTypeDescription as [CMN_LookupTypeChildValue],
				LTC.GroupingLookupTypeRef, LT2.LookupTypeDescription as [GroupingLookupTypeValue],LTC.CorrelationDescription,
				LTC.LockedByRef, UM.FullName as [LockedByName],LTC.UTCLockedOn,LTC.IsActive,LTC.UTCCreatedOn,LTC.CreatedByRef,
				UM1.FullName as [CreatedByName],LTC.UTCLastUpdatedOn,LTC.LastUpdatedByRef,UM2.FullName as [LastUpdatedByName]
		FROM	CMN_LookupTypeCorrelations LTC With(Nolock)
				  Left Join CMN_LookupType LT With(Nolock) on LT.CMN_LookupTypeId = LTC.CMN_LookupTypeParentRef
				  Left Join CMN_LookupType LT1 With(Nolock) on LT1.CMN_LookupTypeId = LTC.CMN_LookupTypeChildRef
				  Left Join CMN_LookupType LT2 With(Nolock) on LT2.CMN_LookupTypeId = LTC.GroupingLookupTypeRef
				  Left Join ADM_UserMaster UM With(Nolock) on UM.ADM_UserMasterId = LTC.LockedByRef
				  Left Join ADM_UserMaster UM1 With(Nolock) on UM1.ADM_UserMasterId = LTC.CreatedByRef
				  Left Join ADM_UserMaster UM2 With(Nolock) on UM2.ADM_UserMasterId = LTC.LastUpdatedByRef
		WHERE	(@IsActive IS NULL OR LTC.IsActive = @IsActive)
				And (@CMN_LookupTypeCorrelationsId Is NULL Or LTC.CMN_LookupTypeCorrelationsId = @CMN_LookupTypeCorrelationsId)
				And (@CorrelationDescription Is Null or LTC.CorrelationDescription like '%'+@CorrelationDescription+'%')
				And (@CMN_LookupTypeParentRef Is Null or LTC.CMN_LookupTypeParentRef = @CMN_LookupTypeParentRef)
				And (@CMN_LookupTypeChildRef Is NULL Or LTC.CMN_LookupTypeChildRef = @CMN_LookupTypeChildRef)

		--Fetch LookupMasterCorrelation details
		SELECT	LMC.CMN_LookupMasterCorrelationsId,LMC.CMN_LookupTypeCorrelationsRef,LMC.CMN_LookupMasterParentRef,LM.LookupValue As LookupMasterParentValue,
				LMC.CMN_LookupMasterChildRef,LM1.LookupValue As LookupMasterChildValue,LMC.GroupingLookupMasterRef,LM2.LookupValue As GroupingLookupMasterValue,
				LMC.CorrelationDescription,LMC.DisplayOrder,LMC.IsActive,LMC.UTCCreatedOn,LMC.CreatedByRef,UM1.FullName As CreatedByName,LMC.UTCLastUpdatedOn,
				LMC.LastUpdatedByRef,UM2.FullName As LastUpdatedByName
		FROM	CMN_LookupMasterCorrelations LMC With(Nolock)
					Left Join CMN_LookupMaster LM With(Nolock) on LM.CMN_LookupMasterId = LMC.CMN_LookupMasterParentRef
					Left Join CMN_LookupMaster LM1 With(Nolock) on LM1.CMN_LookupMasterId = LMC.CMN_LookupMasterChildRef
					Left Join CMN_LookupMaster LM2 With(Nolock) on LM2.CMN_LookupMasterId = LMC.GroupingLookupMasterRef
					Left Join ADM_UserMaster UM1 With(Nolock) on UM1.ADM_UserMasterId = LMC.CreatedByRef
					Left Join ADM_UserMaster UM2 With(Nolock) on UM2.ADM_UserMasterId = LMC.LastUpdatedByRef
		WHERE	(@CMN_LookupTypeCorrelationsId Is NULL Or LMC.CMN_LookupTypeCorrelationsRef = @CMN_LookupTypeCorrelationsId)
				And (@CMN_LookupMasterCorrelationsId Is NULL Or LMC.CMN_LookupMasterCorrelationsId = @CMN_LookupMasterCorrelationsId)

	END TRY
	BEGIN CATCH
		SET @ErrorMessage= ERROR_MESSAGE();
	END CATCH
END
GO