IF OBJECT_ID ('USP_ERS_UserLogout') IS NOT NULL 
BEGIN
	DROP PROC [dbo].[USP_ERS_UserLogout]
END
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
/*                      
******************************************************************************************************************       
Procedure Name       :USP_ERS_UserLogout
Author               :Venkatasubramanyam
Parameters           :@LoginName
Purpose              :used for logout.
EXEC USP_ERS_UserLogout 'vperepu'
**********************************************************************************************************************      
*/ 

CREATE PROCEDURE [dbo].[USP_ERS_UserLogout] 
@LoginName VARCHAR(100)=NULL
AS

BEGIN
       DECLARE @UserId BIGINT;

SELECT @UserId=ADM_UserMasterId  FROM ADM_UserMaster USR WITH(NOLOCK) WHERE IsActive=1 AND MSID=@LoginName;
--if user exists 
IF @UserId IS NOT NULL
BEGIN
--if user is already active then do not insert into session
IF EXISTS (SELECT TOP 1 1 FROM ADM_UserSession WITH(NOLOCK) WHERE IsActive=1 AND ADM_UserMasterRef=@UserId)
BEGIN
--unlock all locked records
--UPDATE [dbo].[CMN_RecordsLocked] SET IsActive=0 WHERE IsActive=1 AND CreatedByRef=@UserId;
--logout
UPDATE [dbo].[ADM_UserSession] SET LastActivity=GETUTCDATE(),UTCLastUpdatedOn=GETUTCDATE(),LastUpdatedByRef=@UserId,IsActive=0 WHERE IsActive=1 AND ADM_UserMasterRef=@UserId;
END --end user active
END --end user exists
END
