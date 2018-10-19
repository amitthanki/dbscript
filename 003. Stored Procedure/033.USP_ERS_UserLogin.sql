/*                      
******************************************************************************************************************       
Procedure Name       :USP_ERS_UserLogin
Author               :Venkatasubramanyam
Parameters           :@LoginName
Purpose              :used for login 
EXEC USP_ERS_UserLogin 'vperepu'
**********************************************************************************************************************      
*/ 
CREATE PROCEDURE [dbo].[USP_ERS_UserLogin] 
@LoginName VARCHAR(100)=NULL

AS
BEGIN
       DECLARE @UserId BIGINT;
--any old user record with active status then auto logout

IF EXISTS (SELECT TOP 1 1 FROM ADM_UserSession WITH(NOLOCK) WHERE IsActive=1 AND LastActivity< DATEADD(hh,-1,GETUTCDATE()))
BEGIN
       UPDATE ADM_UserSession set IsActive=0,LogoffTime=LastActivity WHERE IsActive=1 AND LastActivity<DATEADD(hh,-1,GETUTCDATE());
END

SELECT @UserId=ADM_UserMasterId  FROM ADM_UserMaster USR WITH(NOLOCK) WHERE IsActive=1 AND MSID=@LoginName;

--if user exists then insert to session
IF @UserId IS NOT NULL
BEGIN

--if user is already active then do not insert into session

IF NOT EXISTS (SELECT TOP 1 1 FROM ADM_UserSession WITH(NOLOCK) WHERE IsActive=1 AND ADM_UserMasterRef=@UserId)
BEGIN
       INSERT INTO [dbo].[ADM_UserSession]
                        (ADM_UserMasterRef,LoginTime,LogoffTime,LastActivity,IsActive,UTCCreatedOn,CreatedByRef,UTCLastUpdatedOn,LastUpdatedByRef)
              VALUES
                            (@UserId,GETUTCDATE(),NULL,GETUTCDATE(),1,GETUTCDATE(),@UserId,GETUTCDATE(),@UserId);

END --end user active
ELSE
BEGIN
       UPDATE [dbo].[ADM_UserSession] SET LastActivity=GETUTCDATE(),UTCLastUpdatedOn=GETUTCDATE(),LastUpdatedByRef=@UserId WHERE IsActive=1 AND ADM_UserMasterRef=@UserId;
END --end user not active
END --end user exists
END