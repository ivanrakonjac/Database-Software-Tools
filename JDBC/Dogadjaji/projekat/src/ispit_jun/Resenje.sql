USE [DOGADJAJI]
GO
/****** Object:  StoredProcedure [dbo].[spChangeStatus]    Script Date: 12.6.2021. 14:31:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Ivan
-- Create date: Jun 2021.
-- Description:	Change status to P of specific row from Ulaznica table
-- =============================================
ALTER PROCEDURE [dbo].[spChangeStatus]
	@SifU int
AS
BEGIN
	update ULAZNICA
	set Status = 'P'
	where SifU=@SifU
END


USE [DOGADJAJI]
GO
/****** Object:  UserDefinedFunction [dbo].[fRedBrojMesta]    Script Date: 12.6.2021. 14:31:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER FUNCTION [dbo].[fRedBrojMesta] 
(
	@IdD int
)
RETURNS @Table TABLE 
(
	IdD int,
	IdR int,
	BrojKarata int
)
AS
BEGIN
	insert into @Table
	
	select V.SifD, U.SifR, count(*)
	from ULAZNICA U 
	join Vazi V
	on V.SifU = U.SifU
	where U.Status = 'S' and V.SifD=@IdD
	group by V.SifD, U.SifR

	RETURN
END

USE [DOGADJAJI]
GO
/****** Object:  StoredProcedure [dbo].[getUlazniceFromRed]    Script Date: 12.6.2021. 22:00:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Ivan
-- Create date: Jun 2021
-- Description:	Vraca SifU i Status Ulaznica koje su u statusu "S" i imaju SifR=@SifR
-- =============================================
ALTER PROCEDURE [dbo].[getUlazniceFromRed]
	@SifR int
AS
BEGIN
	select SifU, Status
	from ULAZNICA
	where Status='S' and SifR=@SifR
END

USE [DOGADJAJI]
GO
/****** Object:  StoredProcedure [dbo].[spDogadjajSteta]    Script Date: 12.6.2021. 22:00:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Ivan
-- Create date: Jun 2021.
-- Description:	Procedura koja racuna stetu nastalu otkazivanjem dogadjaja
-- =============================================
ALTER PROCEDURE [dbo].[spDogadjajSteta]
	@IdDogadjaja int
AS
BEGIN
	select sum(RED.FaktorR*SEKTOR.FaktorS*ULAZNICA.ZvanicnaCena) as Cena
	from Vazi
	join ULAZNICA
	on ULAZNICA.SifU = VAZI.SifU
	join RED
	on RED.SifR = ULAZNICA.SifR
	join SEKTOR
	on SEKTOR.SifS = RED.SifS
	where ULAZNICA.Status='P' and VAZI.SifD = @IdDogadjaja
END
