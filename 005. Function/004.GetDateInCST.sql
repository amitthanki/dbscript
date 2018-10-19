IF OBJECT_ID ('GetTimeInCST') IS NOT NULL 
BEGIN
	DROP FUNCTION  [dbo].[GetTimeInCST]
END
GO

/****** Object:  UserDefinedFunction [dbo].[GetTimeInCST]    Script Date: 2/9/2018 12:07:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create FUNCTION [dbo].[GetTimeInCST](@UTCCreatedOn datetime)
Returns datetime
as
BEGIN 

Declare @GetDateInCST DateTime
DECLARE @year INT = year(@UTCCreatedOn)
DECLARE
    @StartOfMarch DATETIME ,
    @StartOfNovember DATETIME ,
    @DstStart DATETIME ,
    @DstEnd DATETIME


SET @StartOfMarch = DATEADD(MONTH, 2, DATEADD(YEAR, @year - 1900, 0))
SET @StartOfNovember = DATEADD(MONTH, 10, DATEADD(YEAR, @year - 1900, 0));
SET @DstStart = DATEADD(HOUR, 2,
                        DATEADD(day,
                                ( ( 15 - DATEPART(dw, @StartOfMarch) ) % 7 )
                                + 7, @StartOfMarch))
SET @DstEnd = DATEADD(HOUR, 2,
                      DATEADD(day,
                              ( ( 8 - DATEPART(dw, @StartOfNovember) ) % 7 ),
                              @StartOfNovember))


IF(@UTCCreatedOn BETWEEN @DstStart and @DstEnd)
BEGIN
	SET @GetDateInCST = DATEADD(mi, -300*-1,@UTCCreatedOn)				
END
ELSE
	SET @GetDateInCST = DATEADD(mi, -360*-1,@UTCCreatedOn)	

RETURN @GetDateInCST

END
GO