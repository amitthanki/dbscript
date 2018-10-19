IF OBJECT_ID ('USP_APP_SEL_LookupMaster') IS NOT NULL 
BEGIN
	DROP PROC [dbo].[USP_APP_SEL_LookupMaster]
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
-- Description:To get Lookup Master based on Lookup Type.
-- Eg.
-- Declare @ErrorMessage VARCHAR(2000)
-- Set @ErrorMessage=''
-- Exec [USP_APP_SEL_LookupMaster] @MSID=vperepu,@ErrorMessage = @ErrorMessage Output
-- =============================================
CREATE PROC [dbo].[USP_APP_SEL_LookupMaster]
@LookupTypeId BIGINT = NULL
As
BEGIN
	IF(@LookupTypeId IS NOT NULL)
	BEGIN
		SELECT * FROM CMN_LookupMaster with(NoLock) WHERE CMN_LookupTypeRef=@LookupTypeId
	END
	ELSE
	BEGIN
		SELECT * FROM CMN_LookupMaster with(NoLock)
	END
END
GO