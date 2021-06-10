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
	
	SET NOCOUNT ON;

    declare @kursor cursor
	declare @IdS int, @Ocena int,@message VARCHAR(100);
	declare @Prosek decimal(5,2);
	declare @ProsekInt int;

	set @kursor = cursor for 
	select IdS, Ocena
	from inserted

	open @kursor

	fetch from @kursor
	into @IdS, @Ocena

	while @@FETCH_STATUS = 0
	begin
		
		update Student
		set Prosek=[dbo].[fStudentsGPA] (@IdS)
		where Id=@IdS

		fetch from @kursor
		into @IdS, @Ocena
	end


	close @kursor
	deallocate @kursor

END

