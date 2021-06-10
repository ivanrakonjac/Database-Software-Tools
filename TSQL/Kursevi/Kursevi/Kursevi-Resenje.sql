USE [Kursevi]
GO
/****** Object:  UserDefinedFunction [dbo].[fStudentsGPA]    Script Date: 10.6.2021. 16:06:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Ivan
-- Description:	Function for calculatoing student's GPA
-- =============================================
ALTER FUNCTION [dbo].[fStudentsGPA] 
(
	@IdS int
)
RETURNS decimal(5,2)
AS
BEGIN
	RETURN (

	select avg(cast(O.Ocena as decimal(5,2)))
	from Ispit I, Ocena O
	where I.Id = O.IdI and O.IdS = @IdS and O.Ocena>5 and I.DatumOdrzavanja = (
		select MAX(I2.DatumOdrzavanja)
		from Ispit I2, Ocena O2
		where I2.IdK = I.IdK and O2.IdI = I2.Id and O2.IdS = @idS
	)

	)
END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Ivan
-- Description:	Procedure for changing value of column Prosek in Student table
-- =============================================
CREATE PROCEDURE changeProsek
	@IdS int
AS
BEGIN
	update Student
	set Prosek=[dbo].[fStudentsGPA] (@IdS)
	where Id=@IdS
END
GO



/* Trigger for Ocena table*/

USE [Kursevi]
GO
/****** Object:  Trigger [dbo].[prosecnaOcenaStudenta]    Script Date: 10.6.2021. 14:21:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER TRIGGER [dbo].[prosecnaOcenaStudenta] 
   ON  [dbo].[Ocena] 
   AFTER INSERT, UPDATE, DELETE
AS 
BEGIN
	
	declare @brI int
	declare @brD int
	declare @idSStari int, @idSNovi int
		
	declare @kursorI cursor, @kursorD cursor

	set @kursorI = cursor for
	select IdS
	from inserted

	set @kursorD = cursor for
	select IdS
	from deleted

	select @brI = count(*)
	from inserted

	select  @brD = COUNT(*)
	from deleted

	if(@brI = 0) -- delete
		begin
			open @kursorD

			fetch next from @kursorD
			into @IdSStari

			while @@FETCH_STATUS = 0
			begin
				execute [dbo].[changeProsek] @idSStari

				fetch next from @kursorD
				into @IdSStari
			end

			close @kursorD
			deallocate @kursorD
		end
	else if(@brD = 0) -- insert
		begin
			open @kursorI

			fetch next from @kursorI
			into @IdSNovi

			while @@FETCH_STATUS = 0
			begin
				execute [dbo].[changeProsek] @IdSNovi

				fetch next from @kursorI
				into @IdSNovi
			end

			close @kursorI
			deallocate @kursorI
		end
	else -- update
		begin
			open @kursorI
			open @kursorD

			fetch next from @kursorI
			into @IdSNovi

			fetch next from @kursorD
			into @IdSStari

			while @@FETCH_STATUS = 0
			begin
				execute [dbo].[changeProsek] @idSNovi
				if(@idSStari <> @idSNovi)
					execute [dbo].[changeProsek] @idSStari

				fetch next from @kursorI
				into @IdSNovi

				fetch next from @kursorD
				into @IdSStari
			end

			close @kursorI
			deallocate @kursorI

			close @kursorD
			deallocate @kursorD
		end
END
GO