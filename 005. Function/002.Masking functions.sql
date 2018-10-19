
/****** Object:  UserDefinedFunction [dbo].[datemask]    Script Date: 12/6/2017 12:13:41 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create function [dbo].[datemask](@msg varchar(30))
returns varchar(30)
as
begin
declare @mdate1 date,@mdate2 date,@mdate3 date,@er varchar(30)

      if(isdate(cast(@msg as varchar))=0)
         begin 
           set @er='invalid date'
          return @er
         end

    if(month(@msg)=1 and (day(@msg)=29 or day(@msg)=30 or day(@msg)=31 or day(@msg)=28) )
     begin

       set @mdate1=dateadd(year,2,@msg)
     set @mdate2=dateadd(month,0,@mdate1)
       set @mdate3=dateadd(day,0,@mdate2)
       return @mdate3
       end

   if(day(@msg)=29 or day(@msg)=30 or day(@msg)=31 or day(@msg)=28)
     begin

       set @mdate1=dateadd(year,2,@msg)
     set @mdate2=dateadd(month,-1,@mdate1)

       --set @mdate3=dateadd(day,0,@mdate2)
       return @mdate2
       end

       if(month(@msg)=1)
       begin
       set @mdate1=dateadd(year,2,@msg)
     set @mdate2=dateadd(month,0,@mdate1)
       set @mdate3=dateadd(day,1,@mdate2)
       return @mdate3
       end

       else 
     begin
     set @mdate1=dateadd(year,2,@msg)
     set @mdate2=dateadd(month,-1,@mdate1)
     set @mdate3=dateadd(day,1,@mdate2)
      end
      
         return @mdate3
end
GO

/****** Object:  UserDefinedFunction [dbo].[EmailMask]    Script Date: 12/6/2017 12:14:15 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[EmailMask](
@name varchar(30)
)
returns varchar(30)
as     
    begin
    declare @name1 varchar(30),@name2 varchar(30),@name3 varchar(30)
    declare @t varchar(30)
    declare @i int
    set @i = 1
	set @name1=''
	set @name2='@xyz.com'

          while(@i <=LEN(LEFT(@name,CHARINDEX('@',@name)-1)))
            begin
                 set  @t =  char(ascii(substring(@name,@i,1))+ 4)
	             set @name1=reverse(@name1+@t)
				 set @name3=@name1+@name2
                 set @i = @i + 1
             end 
return @name3  
end

GO

/****** Object:  UserDefinedFunction [dbo].[hicn_Mask]    Script Date: 12/6/2017 12:14:55 PM ******/

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create function [dbo].[hicn_Mask](@msg varchar(100))
returns varchar(100)
as
begin
declare @msg1 varchar(100),@i int,@t varchar(100)
set @i=1
set @msg1=''
     while(@i<=len(@msg))
      begin 
        set @t=substring(@msg,@i,1)
           if(@t='0'or @t='1' or @t='2' or @t='3' or @t='4' or @t='5' or @t='6' or @t='7')
                begin 
                 set @t=char(ascii(@t)+2)
                 end
                 else if(@t='8')
                 set @t='8'
                 else if(@t='9')
                 set @t='9'
                 else if(@t='A')
                 set @t='W'
                 else if(@t='B')
                 set @t='M'
                 else if(@t='C')
                 set @t='A'
                 else if(@t='D')
                 set @t='T'
                 else if(@t='M')
                 set @t='D'
                 else if(@t='T')
                 set @t='B'
                 else if(@t='W')
                 set @t='C'
                 else if(@t='Z')
                 set @t='Z'
                 else
                 set @t=char(ascii(@t)+1)
       set @msg1=@msg1+@t 
           set @i=@i+1
              end 
               return @msg1   
end
GO

/****** Object:  UserDefinedFunction [dbo].[IdMask]    Script Date: 12/6/2017 12:16:19 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[IdMask](
@Id varchar(100)
)
returns varchar(100)
as     
    begin
    declare @Id1 bigint,@Id2 bigint,@Id3 bigint
    set @Id1=14567

           set @Id2=reverse(@Id)
           set @Id3 = @Id2 + @Id1
		  return @Id3   
    end 




GO
/****** Object:  UserDefinedFunction [dbo].[IdMask_varchar]    Script Date: 12/6/2017 12:17:08 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE function [dbo].[IdMask_varchar](
@Id varchar(100)
)
returns varchar(100)
as     
    begin
    declare @Id1 varchar(100),@Id2 varchar(100),@Id3 varchar(100)
    set @Id1=14567

           set @Id2=reverse(@Id)
           set @Id3 = @Id2 + @Id1
		  return @Id3   
    end 




GO

/****** Object:  UserDefinedFunction [dbo].[namemask]    Script Date: 12/6/2017 12:17:43 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create function [dbo].[namemask](@msg varchar(100))
returns varchar(100)
as
begin 
	declare @i int,@t varchar(10),@msg1 varchar(100),@rev varchar(100)
	set @i=1
	set @rev=reverse(@msg)
	set @msg1=''
	while(@i<=len(@rev))
	begin
		set @t=substring(@rev,@i,1)
		if(@t='y')
			set @t='y'
		else if(@t='z')
			set @t='z'
		else if(@t=' ')
			set @t=' '
			else if(@t='8')
			set @t='8'
			else if(@t='9')
				set @t='9'
		else if((@t between 'a' and 'z')or(@t between '0' and '7'))
			set @t=char(ascii(@t)+2)
		else
			set @t='@'
			set @msg1=@msg1+@t
			set @i=@i+1
	end
	return @msg1
end
GO
