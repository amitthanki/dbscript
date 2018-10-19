IF OBJECT_ID ('GetAge') IS NOT NULL 
BEGIN
	DROP FUNCTION  [dbo].[GetAge]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[GetAge](@GEN_QueueId BIGINT)
Returns BIGINT
as
BEGIN 
	Declare @Age BIGINT = NULL
	Declare @WorkBasketLkup BIGINT = NULL
	Declare @ComplianceStartDate DATETIME = NULL
	Declare @UTCResolvedOn DATETIME = NULL
	Declare @IsCaseResolved BIT = NULL
	Declare @AdjustedComplianceStartDate DATETIME = NULL
	Declare @AdjustedCreateDate DATETIME = NULL
	
	SELECT @WorkBasketLkup = GQ.WorkBasketLkup, @ComplianceStartDate = GQ.ComplianceStartDate, @IsCaseResolved = GQ.IsCaseResolved, @UTCResolvedOn = GQ.UTCResolvedOn, 
	@AdjustedComplianceStartDate = GOST.AdjustedComplianceStartDate, @AdjustedCreateDate = GRPR.AdjustedCreateDate
	FROM GEN_Queue GQ
	LEFT JOIN GEN_OSTActions GOST on GOST.GEN_QueueRef = GQ.GEN_QueueId AND GQ.GEN_QueueId = @GEN_QueueId
	LEFT JOIN GEN_RPRActions GRPR on GRPR.GEN_QueueRef = GQ.GEN_QueueId AND GQ.GEN_QueueId = @GEN_QueueId
	WHERE GEN_QueueId = @GEN_QueueId

	IF(@IsCaseResolved IS NULL OR @IsCaseResolved = 0)
		BEGIN
			IF (@WorkBasketLkup = 3001)
				BEGIN
					IF(@AdjustedComplianceStartDate IS NULL)
						SET @Age = DATEDIFF(DAY, @ComplianceStartDate,CONVERT(date, GETUTCDATE()))
					ELSE
						SET @Age = DATEDIFF(DAY, @AdjustedComplianceStartDate,CONVERT(date, GETUTCDATE()))
				END
			ELSE IF (@WorkBasketLkup = 3002)
				BEGIN
					SET @Age = DATEDIFF(DAY, @ComplianceStartDate,CONVERT(date, GETUTCDATE()))
				END
			ELSE IF (@WorkBasketLkup = 3003)
				BEGIN
					IF(@AdjustedCreateDate IS NULL)
						SET @Age = DATEDIFF(DAY, @ComplianceStartDate,CONVERT(date, GETUTCDATE()))
					ELSE
						SET @Age = DATEDIFF(DAY, @AdjustedCreateDate,CONVERT(date, GETUTCDATE()))
				END
		END
	ELSE
		BEGIN
			IF (@WorkBasketLkup = 3001)
				BEGIN
					IF(@AdjustedComplianceStartDate IS NULL)
						SET @Age = DATEDIFF(DAY, @ComplianceStartDate, @UTCResolvedOn)
					ELSE
						SET @Age = DATEDIFF(DAY, @AdjustedComplianceStartDate, @UTCResolvedOn)
				END
			ELSE IF (@WorkBasketLkup = 3002)
				BEGIN
					SET @Age = DATEDIFF(DAY, @ComplianceStartDate, @UTCResolvedOn)
				END
			ELSE IF (@WorkBasketLkup = 3003)
				BEGIN
					IF(@AdjustedCreateDate IS NULL)
						SET @Age = DATEDIFF(DAY, @ComplianceStartDate, @UTCResolvedOn)
					ELSE
						SET @Age = DATEDIFF(DAY, @AdjustedCreateDate, @UTCResolvedOn)
				END
		END

	RETURN @Age
END
GO