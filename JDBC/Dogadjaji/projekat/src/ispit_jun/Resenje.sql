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
