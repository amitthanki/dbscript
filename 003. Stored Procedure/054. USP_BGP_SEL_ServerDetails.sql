IF OBJECT_ID ('USP_BGP_SEL_ServerDetails') IS NOT NULL
BEGIN
	DROP PROC [DBO].[USP_BGP_SEL_ServerDetails]
END
GO

/****** Object:  StoredProcedure [dbo].[USP_BGP_SEL_ServerDetails]    Script Date: 8/11/2017 12:50:40 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author: Pradeep Patil
-- Create date: 8/10/2015
-- Modified By: 
-- Modification Date: 
-- Description: Get server details
-- Eg.
-- Declare @ErrorMessage VARCHAR(2000)
-- Set @ErrorMessage=''
-- Exec [USP_BGP_SEL_ServerDetails] @ErrorMessage = @ErrorMessage Output
-- =============================================
CREATE PROCEDURE [dbo].[USP_BGP_SEL_ServerDetails]
@SystemName varchar(100),
@ErrorMessage varchar(2000) OUTPUT
As
BEGIN
	BEGIN Try

	--Get Server Id for current running server name
	Declare @ServerId bigint
	Set @ServerId = (select ADM_UserMasterId As ADM_UserMasterId From ADM_UserMaster Where IsActive = 1 And MSID = @SystemName)
	--Print @ServerId

	--If Server Name not present in DB
	If(@ServerId Is NULL Or @ServerId = 0)
	Begin
		--Get Max ServerId to insert new server details
		Set @ServerId = (select Max(ADM_UserMasterId)+1 As ADM_UserMasterId From ADM_UserMaster Where ADM_UserMasterId < 1000 And IsActive = 1)
		--Print @ServerId

		If(@ServerId Is NULL Or @ServerId = 0)
		BEGIN
			Set @ServerId=1
		END

		Set IDentity_Insert [ADM_UserMaster] On
		INSERT INTO [dbo].[ADM_UserMaster]
				   ([ADM_UserMasterID],[LockedByRef],[UTCLockedOn],[FullName],[SystemFullName],[MSID],[Email],[ManagerId],[LocationLkup],[NonUserLkup],
				   [IsManager],[StartDate],[EndDate],[IsActive],[UTCCreatedOn],[CreatedByRef],[UTCLastUpdatedOn])
			 VALUES
				   (@ServerId,NULL,NULL,'System Admin',@SystemName,@SystemName,'XLHI-App-Data-Support-Distribution@xlhealth.com',NULL,NULL,NULL,0,GETUTCDATE(),'2099-01-01',
				   1,GETUTCDATE(),1,NULL)
		Set IDentity_Insert [ADM_UserMaster] Off
	END

	--Fetch existing or new server details
	Select ADM_UserMasterId,FullName,MSID,Email From [ADM_UserMaster] with(nolock) Where ADM_UserMasterId = @ServerId And IsActive=1

	END Try

	BEGIN CATCH
		Set @ErrorMessage = Error_Message()
	END CATCH
END

GO

