USE [DOGADJAJI]
GO
/****** Object:  UserDefinedFunction [dbo].[fDogadjajSteta]    Script Date: 11.6.2021. 16:38:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Ivan
-- Create date: Jun 2021.
-- Description:	Fja koja racuna stetu nastalu otkazivanjem dogadjaja
-- =============================================
ALTER FUNCTION [dbo].[fDogadjajSteta]
(
	@IdD int
)
RETURNS decimal(10,2)
AS
BEGIN
	RETURN(
		select sum(RED.FaktorR*SEKTOR.FaktorS*ULAZNICA.ZvanicnaCena) as Cena
		from Vazi
		join ULAZNICA
		on ULAZNICA.SifU = VAZI.SifU
		join RED
		on RED.SifR = ULAZNICA.SifR
		join SEKTOR
		on SEKTOR.SifS = RED.SifS
		where ULAZNICA.Status='P' and VAZI.SifD = @IdD
	)

END


USE [DOGADJAJI]
GO
/****** Object:  Trigger [dbo].[DogadjajOtkazanSteta]    Script Date: 11.6.2021. 16:27:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Ivan
-- Create date: Jun 2021.
-- Description:	Ispit Jun 18/19, SAB, ETF, Triger za otkazane dogadjaje
-- =============================================
ALTER TRIGGER [dbo].[DogadjajOtkazanSteta] 
   ON  [dbo].[DOGADJAJ_OTKAZAN]
   AFTER INSERT
AS
BEGIN

	declare @kursorDogadjaji cursor
	declare @IdD int

	set @kursorDogadjaji = cursor for
	select distinct inserted.SifD
	from inserted

	open @kursorDogadjaji

	fetch from @kursorDogadjaji
	into @IdD

	while @@FETCH_STATUS = 0
	begin

		print @IdD
		print dbo.fDogadjajSteta(@IdD)
	
		update [DOGADJAJ_OTKAZAN]
		set Steta = dbo.fDogadjajSteta(@IdD)
		where SifD = @IdD
		
		fetch from @kursorDogadjaji
		into @IdD
	end

	close @kursorDogadjaji
	deallocate @kursorDogadjaji

END
