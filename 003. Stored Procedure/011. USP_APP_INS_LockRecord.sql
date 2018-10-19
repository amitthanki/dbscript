IF OBJECT_ID ('USP_APP_INS_UPD_LockRecord') IS NOT NULL 
BEGIN
	DROP PROC [dbo].[USP_APP_INS_UPD_LockRecord]
END
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author: Sourabha Ranjan Barik
-- Create date: 06/13/2017
-- Modified By: 
-- Modification Date: 
-- Description: SP used to lock/relock record in any table
-- Eg.
-- Declare @ErrorMessage VARCHAR(2000)
-- Set @ErrorMessage=''
-- Exec [USP_APP_INS_UPD_LockRecord] @ErrorMessage = @ErrorMessage Output
-- =============================================
CREATE PROC [dbo].[USP_APP_INS_UPD_LockRecord]
@LoginUserId bigint,
@ScreenLkup bigint,  --UserAdmin,LookupType,LookupTypeCorrelation,Queue,ConfigMaster,Department,AccessGroup
@CaseId bigint,		 --Id
@Guid varchar(40),
@IsRelockRequired Bit = 0,  --0 : Last locked within 2 Hour | 1 : More Then 2 Hour over
@ErrorMessage varchar(2000) OUTPUT
As
BEGIN
	BEGIN TRY		

		DECLARE @UTCDATE datetime
		SET @UTCDATE = GETUTCDATE()

		DECLARE @TableName varchar(200)
		DECLARE @PKColumn varchar(200)
		Select @TableName = LookupValue1, @PKColumn = LookupValue2 From CMN_LookupMaster Where CMN_LookupMasterId = @ScreenLkup AND CMN_LookupTypeRef=37

		DECLARE @query NVARCHAR(MAX) = NULL

		BEGIN TRAN

			--If @IsRelockRequired = 1, then Delete the old case and create a new locking as usual
			IF(@IsRelockRequired = 1)
			BEGIN
				DELETE FROM CMN_RecordsLocked WHERE [ScreenLkup]=@ScreenLkup 
				                                    AND [CaseId]=@CaseId 
													AND (([CreatedByRef] <> @LoginUserId AND DATEDIFF(MINUTE,[StartTime],GETUTCDATE()) >= 60) OR ([CreatedByRef] = @LoginUserId))

				--SET @query = N'UPDATE '+Cast(@TableName As Varchar(200))+'
				--			   SET LockedByRef = NULL,
				--					UTCLockedOn = NULL
				--			   WHERE '+Cast(@PKColumn As Varchar(200))+' = '+Cast(@CaseId As Varchar(10))+''

				--EXEC sp_executesql @query	
			END

			IF(@IsRelockRequired = 0 OR (@IsRelockRequired = 1 AND @@RowCount > 0))
			BEGIN

				--If record not locked by any user then Insert locking
				INSERT INTO [dbo].[CMN_RecordsLocked]
						([ScreenLkup]
						,[CaseId]
						,[StartTime]
						,[Guid]
						,[IsActive]
						,[UTCCreatedOn]
						,[CreatedByRef]
						,[UTCLastUpdatedOn]
						,[LastUpdatedByRef])
				--Values (@ScreenLkup,@CaseId,@UTCDATE,@Guid,1,@UTCDATE,@LoginUserId,@UTCDATE,@LoginUserId) 
				Select T.* From (
					Select @ScreenLkup As ScreenLkup,@CaseId As CaseId,@UTCDATE As StartTime,@Guid As [Guid],1 As IsActive,@UTCDATE As UTCCreatedOn,
							@LoginUserId As CreatedByRef,@UTCDATE As UTCLastUpdatedOn,@LoginUserId As LastUpdatedByRef
				) T
				Where (SELECT Count(1) FROM CMN_RecordsLocked RL WHERE RL.ScreenLkup=@ScreenLkup AND RL.[CaseId]=@CaseId) = 0
				
				--IF EXISTS (SELECT Count(1) FROM CMN_RecordsLocked RL WHERE RL.ScreenLkup=@ScreenLkup AND RL.[CaseId]=@CaseId AND RL.[CreatedByRef] = @LoginUserId)
				IF(@@RowCount > 0)
				BEGIN
					SET @query = N'UPDATE '+Cast(@TableName As Varchar(200))+'
									SET LockedByRef = '+Cast(@LoginUserId As Varchar(10))+',
										UTCLockedOn = '''+CONVERT(Varchar,@UTCDATE,113)+'''
									WHERE '+Cast(@PKColumn As Varchar(200))+' = '+Cast(@CaseId As Varchar(10))+''

					EXEC sp_executesql @query
				END
			END

			--Get locked records details
			SELECT	RL.CMN_RecordsLockedId,RL.ScreenLkup,LM.LookupValue As ScreenValue,RL.CaseId,RL.StartTime,RL.EndTime,RL.[Guid],
					RL.IsActive,RL.UTCCreatedOn,RL.CreatedByRef,UM.FullName As CreatedByName,RL.UTCLastUpdatedOn,RL.LastUpdatedByRef
			FROM	CMN_RecordsLocked RL 
						LEFT JOIN CMN_LookupMaster LM On LM.CMN_LookupMasterId = RL.ScreenLkup AND LM.CMN_LookupTypeRef=37
						LEFT JOIN ADM_UserMaster UM On UM.ADM_UserMasterId = RL.CreatedByRef
			WHERE	RL.IsActive=1 AND RL.ScreenLkup=@ScreenLkup AND RL.[CaseId]=@CaseId

		COMMIT TRAN
	END TRY 

	BEGIN CATCH
		BEGIN TRY Rollback Tran; END TRY BEGIN CATCH END CATCH 
		
		INSERT INTO [dbo].[CMN_AppErrorLog](ADM_UserMasterRef,[ErrorLocation],[ErrorSourceLkup],[ErrorMessage],[ErrorDescription],[UTCErrorDateTime],[UTCCreatedOn])
		VALUES( @LoginUserId,'[dbo].[USP_APP_INS_UPD_LockRecord]',null,ERROR_NUMBER(),ERROR_MESSAGE(),GETUTCDATE(),GETUTCDATE())

		SET @ErrorMessage= ERROR_MESSAGE();
	END CATCH  
END
GO