# Database-Software-Tools

### Kreiranje procedure

    create proc spSviArtikli
    as
    begin
      select *
      from Artikal
    end

### GO sluzi za razdvajanje transakcija

    go

    exec sviArtikli

### Vracanje povratne vrednosti

    /*Nacin I*/

    USE [ProdavnicaArtikala]
    GO

    DECLARE	@return_value int

    EXEC	@return_value = [dbo].[sviArtikli]

    SELECT	'Return Value' = @return_value

    GO

    /*Nacin II*/

    USE [ProdavnicaArtikala]
    GO

    DECLARE	@return_value int

    EXEC	@return_value = [dbo].[sviArtikli]

    SELECT @return_value as 'Return Value'

    GO

### Printovi (ispisuju se u Message tabu)

    USE [ProdavnicaArtikala]
    GO

    DECLARE	@return_value int

    EXEC	@return_value = [dbo].[sviArtikli]

    SELECT @return_value as 'Return Value'

    print 'Return value is '
    print @return_value

    GO

### Procedura sa ulaznim parametrima 

    CREATE PROCEDURE spRadnjaPoPovrsini
    @PovrsinaMin int,
    @PovrsinaMax int
    AS
    BEGIN
      SELECT Naziv,Povrsina
      from Radnja
      where Povrsina>=@PovrsinaMin and Povrsina<=@PovrsinaMax
    END
    GO

### Procedura sa ulaznim i sa izlaznim parametrima

    CREATE PROCEDURE spBrRadnjiPoPovrsini
    @PovrsinaMin int,
    @PovrsinaMax int,
    @Broj int output
    AS
    BEGIN
      SELECT @Broj = count(*)
      from Radnja
      where Povrsina>=@PovrsinaMin and Povrsina<=@PovrsinaMax
    END
    GO
  
### Skalarna funkcija

    create function fBrojRadnji ()
    returns int
    as
    begin
    return 
      (select count(*)
      from Radnja)
    end

### Inline funkcija koja vraca tabelu

    CREATE FUNCTION fRadnjaPoPovrsini
    (	
      @PovrsinaMin int,
      @PovrsinaMax int
    )
    RETURNS TABLE 
    AS
    RETURN 
    (
      SELECT *
      from Radnja
      where Povrsina>=@PovrsinaMin and Povrsina<=@PovrsinaMax
    )
    GO

### Select upit

    USE [TrzniCentar]
    GO

    SELECT * FROM [dbo].[fRadnjaPoPovrsini] (30,100)
    GO

### Update upit

    USE [TrzniCentar]
    GO

    update [dbo].[fRadnjaPoPovrsini] (100,100)
    set Povrsina = 110
    GO


### Multi statement funkcija (vraca tabelu cije kolone definisemo u funkciji)

    CREATE FUNCTION fBrSprataRadnjeSaPovrsinom
    (
      @PovrsinaMin int,
      @PovrsinaMax int
    )
    RETURNS 
    @Table TABLE
    (
      ImeRadnje varchar(20),
      Povrsina int,
      BrSprata int
    )
    AS
    BEGIN
      Insert into @Table

      select Naziv, Povrsina, BrSprata
      from Radnja
      where Povrsina>=@PovrsinaMin and Povrsina<=@PovrsinaMax

      RETURN 
    END
    GO
