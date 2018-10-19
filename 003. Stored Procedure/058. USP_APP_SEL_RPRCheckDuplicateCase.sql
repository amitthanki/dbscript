
IF OBJECT_ID ('USP_APP_SEL_RPRCheckDuplicateCase') IS NOT NULL
BEGIN
	DROP PROC [DBO].[USP_APP_SEL_RPRCheckDuplicateCase]
END
GO

/****** Object:  StoredProcedure [dbo].[USP_APP_SEL_RPRCheckDuplicateCase]    Script Date: 8/12/2017 3:02:06 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author: Pradeep Patil
-- Create date: 8/11/2015
-- Modified By: 
-- Modification Date: 
-- Description: Check Duplicate case for RPR
-- Eg.
-- Declare @ErrorMessage VARCHAR(2000)
-- Set @ErrorMessage=''
-- Exec [USP_APP_SEL_RPRCheckDuplicateCase] @ErrorMessage = @ErrorMessage Output
-- =============================================
CREATE PROCEDURE [dbo].[USP_APP_SEL_RPRCheckDuplicateCase]
@MemberCurrentHICN VARCHAR(100),
@MemberContractIDLkup BIGINT,
@RequestedEffectiveDateId BIGINT,
@RPRActionRequestedLkup BIGINT,
@ErrorMessage varchar(2000) OUTPUT
As
BEGIN
	BEGIN Try
		DECLARE @ActionRequestedGroup TABLE (ID BIGINT)
		DECLARE @RetDisenrlGroup TABLE (ID BIGINT)
		DECLARE @PBPGroup TABLE (ID BIGINT)
		DECLARE @RetEnrlGroup TABLE (ID BIGINT)
		DECLARE @ReInstmtGroup TABLE (ID BIGINT)

		INSERT INTO @RetDisenrlGroup VALUES (14001),(14003),(14009)
		INSERT INTO @PBPGroup VALUES (14005)
		INSERT INTO @RetEnrlGroup VALUES (14002),(14004),(14010)
		INSERT INTO @ReInstmtGroup VALUES (14006),(14012),(14008),(14007),(14011)
		
		IF(@RPRActionRequestedLkup IN (SELECT ID FROM @RetDisenrlGroup)) INSERT INTO @ActionRequestedGroup SELECT ID FROM @RetDisenrlGroup
		IF(@RPRActionRequestedLkup IN (SELECT ID FROM @PBPGroup)) INSERT INTO @ActionRequestedGroup SELECT ID FROM @PBPGroup
		IF(@RPRActionRequestedLkup IN (SELECT ID FROM @RetEnrlGroup)) INSERT INTO @ActionRequestedGroup SELECT ID FROM @RetEnrlGroup
		IF(@RPRActionRequestedLkup IN (SELECT ID FROM @ReInstmtGroup)) INSERT INTO @ActionRequestedGroup SELECT ID FROM @ReInstmtGroup

		Select DISTINCT 
		[GEN_QueueId]
		FROM GEN_Queue GQ WITH(NOLOCK)
		WHERE GQ.IsActive=1
		AND GQ.DiscrepancyCategoryLkup=6007--RPR
		AND GQ.MostRecentStatusLkup != 20003--Not Resolved Completed
		AND (@MemberCurrentHICN Is Null OR GQ.MemberCurrentHICN = @MemberCurrentHICN OR GQ.[MemberMedicareId]=@MemberCurrentHICN)
		AND (@MemberContractIDLkup Is Null OR GQ.MemberContractIDLkup =@MemberContractIDLkup)
		AND (@RequestedEffectiveDateId Is Null OR GQ.RPRRequestedEffectiveDateId = @RequestedEffectiveDateId)
		AND (@RPRActionRequestedLkup Is Null OR GQ.RPRActionRequestedLkup IN (SELECT ID FROM @ActionRequestedGroup))
	END Try

	BEGIN CATCH
		Set @ErrorMessage = Error_Message()
	END CATCH
END



GO

