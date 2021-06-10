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
		
		SELECT @message = 'Studenti kojima je dodata ocena'
		PRINT @message
		PRINT @IdS
		PRINT ' '
		PRINT @Ocena


		select @Prosek = cast (avg(cast(Ocena as decimal(5,2))) as decimal(5,2))
		from Ocena
		where IdS=@IdS

		PRINT @Prosek

		update Student
		set Prosek=@Prosek
		where Id=@IdS

		fetch from @kursor
		into @IdS, @Ocena
	end


	close @kursor
	deallocate @kursor

END
