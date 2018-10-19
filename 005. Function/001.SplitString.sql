IF OBJECT_ID ('SplitString') IS NOT NULL 
BEGIN
	DROP FUNCTION  [dbo].[SplitString]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[SplitString]
(    
      @Input NVARCHAR(MAX),
      @Delemeter CHAR(1)
)
RETURNS @Output TABLE (
      Item NVARCHAR(1000)
)
AS
BEGIN
      DECLARE @StartIndex INT, @EndIndex INT
 
      SET @StartIndex = 1
      IF SUBSTRING(@Input, LEN(@Input) - 1, LEN(@Input)) <> @Delemeter
      BEGIN
            SET @Input = @Input + @Delemeter
      END
 
      WHILE CHARINDEX(@Delemeter, @Input) > 0
      BEGIN
            SET @EndIndex = CHARINDEX(@Delemeter, @Input)
           
            INSERT INTO @Output(Item)
            SELECT SUBSTRING(@Input, @StartIndex, @EndIndex - 1)
           
            SET @Input = SUBSTRING(@Input, @EndIndex + 1, LEN(@Input))
      END
 
      RETURN
END