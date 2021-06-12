Use DOGADJAJI
go

EXEC sp_MSForEachTable 'DISABLE TRIGGER ALL ON ?'
GO
EXEC sp_MSForEachTable 'ALTER TABLE ? NOCHECK CONSTRAINT ALL'
GO
EXEC sp_MSForEachTable 'DELETE FROM ?'
GO
EXEC sp_MSForEachTable 'ALTER TABLE ? CHECK CONSTRAINT ALL'
GO
EXEC sp_MSForEachTable 'ENABLE TRIGGER ALL ON ?'
GO

-- Kupci
SET IDENTITY_INSERT KUPAC ON
INSERT INTO KUPAC(SifK, Ime) VALUES( 1, 'K1')
INSERT INTO KUPAC(SifK, Ime) VALUES( 2, 'K2')
INSERT INTO KUPAC(SifK, Ime) VALUES( 3, 'K3')
INSERT INTO KUPAC(SifK, Ime) VALUES( 4, 'K4')
INSERT INTO KUPAC(SifK, Ime) VALUES( 5, 'K5')
SET IDENTITY_INSERT KUPAC OFF


--Popust
INSERT INTO POPUST(BrojUlaznica, Popust) VALUES(10,5)
INSERT INTO POPUST(BrojUlaznica, Popust) VALUES(25,10)
INSERT INTO POPUST(BrojUlaznica, Popust) VALUES(50,15)
INSERT INTO POPUST(BrojUlaznica, Popust) VALUES(100,20)


--Objekat O1
SET IDENTITY_INSERT OBJEKAT ON
INSERT INTO OBJEKAT(SifO, Naziv) VALUES (1,'O1')
SET IDENTITY_INSERT OBJEKAT OFF

SET IDENTITY_INSERT SEKTOR ON
INSERT INTO SEKTOR(SifS, Oznaka, FaktorS, BrojRedova, SifO) VALUES (1,'O1S1', 1, 3, 1)
SET IDENTITY_INSERT SEKTOR OFF
SET IDENTITY_INSERT RED ON
INSERT INTO RED(SifR, Broj, FaktorR, BrojSedista, SifS) VALUES (1, 1, 1.5, 5, 1)
INSERT INTO RED(SifR, Broj, FaktorR, BrojSedista, SifS) VALUES (2, 2, 1, 5, 1)
INSERT INTO RED(SifR, Broj, FaktorR, BrojSedista, SifS) VALUES (3, 3, 2, 5, 1)
SET IDENTITY_INSERT RED OFF

SET IDENTITY_INSERT SEKTOR ON
INSERT INTO SEKTOR(SifS, Oznaka, FaktorS, BrojRedova, SifO) VALUES (2,'O1S2', 1.5, 2, 1)
SET IDENTITY_INSERT SEKTOR OFF
SET IDENTITY_INSERT RED ON
INSERT INTO RED(SifR, Broj, FaktorR, BrojSedista, SifS) VALUES (4, 1, 1, 5, 2)
INSERT INTO RED(SifR, Broj, FaktorR, BrojSedista, SifS) VALUES (5, 2, 0.5, 5, 2)
SET IDENTITY_INSERT RED OFF

--Objekat O2
SET IDENTITY_INSERT OBJEKAT ON
INSERT INTO OBJEKAT(SifO, Naziv) VALUES (2,'O2')
SET IDENTITY_INSERT OBJEKAT OFF

SET IDENTITY_INSERT SEKTOR ON
INSERT INTO SEKTOR(SifS, Oznaka, FaktorS, BrojRedova, SifO) VALUES (3,'O2S1', 1, 3, 2)
SET IDENTITY_INSERT SEKTOR OFF
SET IDENTITY_INSERT RED ON
INSERT INTO RED(SifR, Broj, FaktorR, BrojSedista, SifS) VALUES (6, 1, 1.5, 4, 3)
INSERT INTO RED(SifR, Broj, FaktorR, BrojSedista, SifS) VALUES (7, 2, 0.5, 4, 3)
INSERT INTO RED(SifR, Broj, FaktorR, BrojSedista, SifS) VALUES (8, 3, 1, 4, 3)
SET IDENTITY_INSERT RED OFF

--Objekat O3
SET IDENTITY_INSERT OBJEKAT ON
INSERT INTO OBJEKAT(SifO, Naziv) VALUES (3,'O3')
SET IDENTITY_INSERT OBJEKAT OFF

SET IDENTITY_INSERT SEKTOR ON
INSERT INTO SEKTOR(SifS, Oznaka, FaktorS, BrojRedova, SifO) VALUES (4,'O3S1', 1.5, 1, 3)
SET IDENTITY_INSERT SEKTOR OFF
SET IDENTITY_INSERT RED ON
INSERT INTO RED(SifR, Broj, FaktorR, BrojSedista, SifS) VALUES (9, 1, 1, 20, 4)
SET IDENTITY_INSERT RED OFF

SET IDENTITY_INSERT SEKTOR ON
INSERT INTO SEKTOR(SifS, Oznaka, FaktorS, BrojRedova, SifO) VALUES (5,'O3S2', 0.8, 4, 3)
SET IDENTITY_INSERT SEKTOR OFF
SET IDENTITY_INSERT RED ON
INSERT INTO RED(SifR, Broj, FaktorR, BrojSedista, SifS) VALUES (10, 1, 1.5, 5, 5)
INSERT INTO RED(SifR, Broj, FaktorR, BrojSedista, SifS) VALUES (11, 2, 0.5, 7, 5)
INSERT INTO RED(SifR, Broj, FaktorR, BrojSedista, SifS) VALUES (12, 3, 2, 8, 5)
INSERT INTO RED(SifR, Broj, FaktorR, BrojSedista, SifS) VALUES (13, 4, 1, 5, 5)
SET IDENTITY_INSERT RED OFF

SET IDENTITY_INSERT SEKTOR ON
INSERT INTO SEKTOR(SifS, Oznaka, FaktorS, BrojRedova, SifO) VALUES (6,'O3S3', 1, 1, 3)
SET IDENTITY_INSERT SEKTOR OFF
SET IDENTITY_INSERT RED ON
INSERT INTO RED(SifR, Broj, FaktorR, BrojSedista, SifS) VALUES (14, 1, 1, 7, 6)
SET IDENTITY_INSERT RED OFF

--Objekat O4
SET IDENTITY_INSERT OBJEKAT ON
INSERT INTO OBJEKAT(SifO, Naziv) VALUES (4,'O4')
SET IDENTITY_INSERT OBJEKAT OFF

SET IDENTITY_INSERT SEKTOR ON
INSERT INTO SEKTOR(SifS, Oznaka, FaktorS, BrojRedova, SifO) VALUES (7,'O4S1', 1, 2, 4)
SET IDENTITY_INSERT SEKTOR OFF
SET IDENTITY_INSERT RED ON
INSERT INTO RED(SifR, Broj, FaktorR, BrojSedista, SifS) VALUES (15, 1, 1, 2, 7)
INSERT INTO RED(SifR, Broj, FaktorR, BrojSedista, SifS) VALUES (16, 2, 1, 5, 7)
SET IDENTITY_INSERT RED OFF

SET IDENTITY_INSERT SEKTOR ON
INSERT INTO SEKTOR(SifS, Oznaka, FaktorS, BrojRedova, SifO) VALUES (8,'O4S2', 1, 3, 4)
SET IDENTITY_INSERT SEKTOR OFF
SET IDENTITY_INSERT RED ON
INSERT INTO RED(SifR, Broj, FaktorR, BrojSedista, SifS) VALUES (17, 1, 1, 3, 8)
INSERT INTO RED(SifR, Broj, FaktorR, BrojSedista, SifS) VALUES (18, 2, 1, 2, 8)
INSERT INTO RED(SifR, Broj, FaktorR, BrojSedista, SifS) VALUES (19, 3, 1, 3, 8)
SET IDENTITY_INSERT RED OFF

SET IDENTITY_INSERT SEKTOR ON
INSERT INTO SEKTOR(SifS, Oznaka, FaktorS, BrojRedova, SifO) VALUES (9,'O4S3', 1, 2, 4)
SET IDENTITY_INSERT SEKTOR OFF
SET IDENTITY_INSERT RED ON
INSERT INTO RED(SifR, Broj, FaktorR, BrojSedista, SifS) VALUES (20, 1, 1, 2, 9)
INSERT INTO RED(SifR, Broj, FaktorR, BrojSedista, SifS) VALUES (21, 2, 1, 2, 9)
SET IDENTITY_INSERT RED OFF

--Dogadjaj 1
SET IDENTITY_INSERT DOGADJAJ ON
INSERT INTO DOGADJAJ(SifD, Naziv, Opis, Datum, OsnovnaCena, BrojPreostalihUlaznica) VALUES (1,'D1','D1 opis','2019-06-13', 1000,7)
SET IDENTITY_INSERT DOGADJAJ OFF

SET IDENTITY_INSERT ULAZNICA ON
INSERT INTO ULAZNICA( SifU, SedisteBr, ZvanicnaCena, Status, SifR) VALUES(1,1,1500,'S',6)
INSERT INTO ULAZNICA( SifU, SedisteBr, ZvanicnaCena, Status, SifR) VALUES(2,2,1500,'S',6)
INSERT INTO ULAZNICA( SifU, SedisteBr, ZvanicnaCena, Status, SifR) VALUES(3,3,1500,'P',6)
INSERT INTO ULAZNICA( SifU, SedisteBr, ZvanicnaCena, Status, SifR) VALUES(4,4,1500,'P',6)

INSERT INTO ULAZNICA( SifU, SedisteBr, ZvanicnaCena, Status, SifR) VALUES(5,1,500,'S',7)
INSERT INTO ULAZNICA( SifU, SedisteBr, ZvanicnaCena, Status, SifR) VALUES(6,2,500,'S',7)
INSERT INTO ULAZNICA( SifU, SedisteBr, ZvanicnaCena, Status, SifR) VALUES(7,3,500,'S',7)
INSERT INTO ULAZNICA( SifU, SedisteBr, ZvanicnaCena, Status, SifR) VALUES(8,4,500,'P',7)

INSERT INTO ULAZNICA( SifU, SedisteBr, ZvanicnaCena, Status, SifR) VALUES(9,1,1000,'P',8)
INSERT INTO ULAZNICA( SifU, SedisteBr, ZvanicnaCena, Status, SifR) VALUES(10,2,1000,'P',8)
INSERT INTO ULAZNICA( SifU, SedisteBr, ZvanicnaCena, Status, SifR) VALUES(11,3,1000,'S',8)
INSERT INTO ULAZNICA( SifU, SedisteBr, ZvanicnaCena, Status, SifR) VALUES(12,4,1000,'S',8)
SET IDENTITY_INSERT ULAZNICA OFF

INSERT INTO VAZI(SifU, SifD) VALUES(1, 1)
INSERT INTO VAZI(SifU, SifD) VALUES(2, 1)
INSERT INTO VAZI(SifU, SifD) VALUES(3, 1)
INSERT INTO VAZI(SifU, SifD) VALUES(4, 1)

INSERT INTO VAZI(SifU, SifD) VALUES(5, 1)
INSERT INTO VAZI(SifU, SifD) VALUES(6, 1)
INSERT INTO VAZI(SifU, SifD) VALUES(7, 1)
INSERT INTO VAZI(SifU, SifD) VALUES(8, 1)

INSERT INTO VAZI(SifU, SifD) VALUES(9, 1)
INSERT INTO VAZI(SifU, SifD) VALUES(10, 1)
INSERT INTO VAZI(SifU, SifD) VALUES(11, 1)
INSERT INTO VAZI(SifU, SifD) VALUES(12, 1)

INSERT INTO KUPIO(SifU, SifK, Cena) VALUES(9,1,1000)
INSERT INTO KUPIO(SifU, SifK, Cena) VALUES(10,2,1000)


--Dogadjaj 2
SET IDENTITY_INSERT DOGADJAJ ON
INSERT INTO DOGADJAJ(SifD, Naziv, Opis, Datum, OsnovnaCena, BrojPreostalihUlaznica) VALUES (2,'D2','D2 opis','2019-06-13', 100,15)
SET IDENTITY_INSERT DOGADJAJ OFF

SET IDENTITY_INSERT ULAZNICA ON
INSERT INTO ULAZNICA( SifU, SedisteBr, ZvanicnaCena, Status, SifR) VALUES(13,1,150,'S',1)
INSERT INTO ULAZNICA( SifU, SedisteBr, ZvanicnaCena, Status, SifR) VALUES(14,2,150,'S',1)
INSERT INTO ULAZNICA( SifU, SedisteBr, ZvanicnaCena, Status, SifR) VALUES(15,3,150,'P',1)
INSERT INTO ULAZNICA( SifU, SedisteBr, ZvanicnaCena, Status, SifR) VALUES(16,4,150,'P',1)
INSERT INTO ULAZNICA( SifU, SedisteBr, ZvanicnaCena, Status, SifR) VALUES(17,5,150,'P',1)

INSERT INTO ULAZNICA( SifU, SedisteBr, ZvanicnaCena, Status, SifR) VALUES(18,1,100,'S',2)
INSERT INTO ULAZNICA( SifU, SedisteBr, ZvanicnaCena, Status, SifR) VALUES(19,2,100,'S',2)
INSERT INTO ULAZNICA( SifU, SedisteBr, ZvanicnaCena, Status, SifR) VALUES(20,3,100,'S',2)
INSERT INTO ULAZNICA( SifU, SedisteBr, ZvanicnaCena, Status, SifR) VALUES(21,4,100,'P',2)
INSERT INTO ULAZNICA( SifU, SedisteBr, ZvanicnaCena, Status, SifR) VALUES(22,5,100,'P',2)

INSERT INTO ULAZNICA( SifU, SedisteBr, ZvanicnaCena, Status, SifR) VALUES(23,1,200,'P',3)
INSERT INTO ULAZNICA( SifU, SedisteBr, ZvanicnaCena, Status, SifR) VALUES(24,2,200,'S',3)
INSERT INTO ULAZNICA( SifU, SedisteBr, ZvanicnaCena, Status, SifR) VALUES(25,3,200,'S',3)
INSERT INTO ULAZNICA( SifU, SedisteBr, ZvanicnaCena, Status, SifR) VALUES(26,4,200,'S',3)
INSERT INTO ULAZNICA( SifU, SedisteBr, ZvanicnaCena, Status, SifR) VALUES(27,5,200,'P',3)

INSERT INTO ULAZNICA( SifU, SedisteBr, ZvanicnaCena, Status, SifR) VALUES(28,1,100,'S',4)
INSERT INTO ULAZNICA( SifU, SedisteBr, ZvanicnaCena, Status, SifR) VALUES(29,2,100,'S',4)
INSERT INTO ULAZNICA( SifU, SedisteBr, ZvanicnaCena, Status, SifR) VALUES(30,3,100,'S',4)
INSERT INTO ULAZNICA( SifU, SedisteBr, ZvanicnaCena, Status, SifR) VALUES(31,4,100,'S',4)
INSERT INTO ULAZNICA( SifU, SedisteBr, ZvanicnaCena, Status, SifR) VALUES(32,5,100,'P',4)

INSERT INTO ULAZNICA( SifU, SedisteBr, ZvanicnaCena, Status, SifR) VALUES(33,1,50,'P',5)
INSERT INTO ULAZNICA( SifU, SedisteBr, ZvanicnaCena, Status, SifR) VALUES(34,2,50,'P',5)
INSERT INTO ULAZNICA( SifU, SedisteBr, ZvanicnaCena, Status, SifR) VALUES(35,3,50,'S',5)
INSERT INTO ULAZNICA( SifU, SedisteBr, ZvanicnaCena, Status, SifR) VALUES(36,4,50,'S',5)
INSERT INTO ULAZNICA( SifU, SedisteBr, ZvanicnaCena, Status, SifR) VALUES(37,5,50,'S',5)
SET IDENTITY_INSERT ULAZNICA OFF

INSERT INTO VAZI(SifU, SifD) VALUES(13, 2)
INSERT INTO VAZI(SifU, SifD) VALUES(14, 2)
INSERT INTO VAZI(SifU, SifD) VALUES(15, 2)
INSERT INTO VAZI(SifU, SifD) VALUES(16, 2)
INSERT INTO VAZI(SifU, SifD) VALUES(17, 2)

INSERT INTO VAZI(SifU, SifD) VALUES(18, 2)
INSERT INTO VAZI(SifU, SifD) VALUES(19, 2)
INSERT INTO VAZI(SifU, SifD) VALUES(20, 2)
INSERT INTO VAZI(SifU, SifD) VALUES(21, 2)
INSERT INTO VAZI(SifU, SifD) VALUES(22, 2)

INSERT INTO VAZI(SifU, SifD) VALUES(23, 2)
INSERT INTO VAZI(SifU, SifD) VALUES(24, 2)
INSERT INTO VAZI(SifU, SifD) VALUES(25, 2)
INSERT INTO VAZI(SifU, SifD) VALUES(26, 2)
INSERT INTO VAZI(SifU, SifD) VALUES(27, 2)

INSERT INTO VAZI(SifU, SifD) VALUES(28, 2)
INSERT INTO VAZI(SifU, SifD) VALUES(29, 2)
INSERT INTO VAZI(SifU, SifD) VALUES(30, 2)
INSERT INTO VAZI(SifU, SifD) VALUES(31, 2)
INSERT INTO VAZI(SifU, SifD) VALUES(32, 2)

INSERT INTO VAZI(SifU, SifD) VALUES(33, 2)
INSERT INTO VAZI(SifU, SifD) VALUES(34, 2)
INSERT INTO VAZI(SifU, SifD) VALUES(35, 2)
INSERT INTO VAZI(SifU, SifD) VALUES(36, 2)
INSERT INTO VAZI(SifU, SifD) VALUES(37, 2)

INSERT INTO KUPIO(SifU, SifK, Cena) VALUES(34,3,50)
INSERT INTO KUPIO(SifU, SifK, Cena) VALUES(17,4,150)
INSERT INTO KUPIO(SifU, SifK, Cena) VALUES(16,5,150)



--Dogadjaj 3
SET IDENTITY_INSERT DOGADJAJ ON
INSERT INTO DOGADJAJ(SifD, Naziv, Opis, Datum, OsnovnaCena, BrojPreostalihUlaznica) VALUES (3,'D3','D3 opis','2019-06-15', 200,17)
SET IDENTITY_INSERT DOGADJAJ OFF

SET IDENTITY_INSERT ULAZNICA ON
INSERT INTO ULAZNICA( SifU, SedisteBr, ZvanicnaCena, Status, SifR) VALUES(38,1,200,'S',15)
INSERT INTO ULAZNICA( SifU, SedisteBr, ZvanicnaCena, Status, SifR) VALUES(39,2,200,'S',15)

INSERT INTO ULAZNICA( SifU, SedisteBr, ZvanicnaCena, Status, SifR) VALUES(40,1,200,'S',16)
INSERT INTO ULAZNICA( SifU, SedisteBr, ZvanicnaCena, Status, SifR) VALUES(41,2,200,'S',16)
INSERT INTO ULAZNICA( SifU, SedisteBr, ZvanicnaCena, Status, SifR) VALUES(42,3,200,'P',16)
INSERT INTO ULAZNICA( SifU, SedisteBr, ZvanicnaCena, Status, SifR) VALUES(43,4,200,'S',16)
INSERT INTO ULAZNICA( SifU, SedisteBr, ZvanicnaCena, Status, SifR) VALUES(44,5,200,'S',16)

INSERT INTO ULAZNICA( SifU, SedisteBr, ZvanicnaCena, Status, SifR) VALUES(45,1,200,'S',17)
INSERT INTO ULAZNICA( SifU, SedisteBr, ZvanicnaCena, Status, SifR) VALUES(46,2,200,'S',17)
INSERT INTO ULAZNICA( SifU, SedisteBr, ZvanicnaCena, Status, SifR) VALUES(47,3,200,'S',17)

INSERT INTO ULAZNICA( SifU, SedisteBr, ZvanicnaCena, Status, SifR) VALUES(48,1,200,'S',18)
INSERT INTO ULAZNICA( SifU, SedisteBr, ZvanicnaCena, Status, SifR) VALUES(49,2,200,'S',18)

INSERT INTO ULAZNICA( SifU, SedisteBr, ZvanicnaCena, Status, SifR) VALUES(50,1,200,'S',19)
INSERT INTO ULAZNICA( SifU, SedisteBr, ZvanicnaCena, Status, SifR) VALUES(51,2,200,'S',19)
INSERT INTO ULAZNICA( SifU, SedisteBr, ZvanicnaCena, Status, SifR) VALUES(52,3,200,'S',19)

INSERT INTO ULAZNICA( SifU, SedisteBr, ZvanicnaCena, Status, SifR) VALUES(53,1,200,'P',20)
INSERT INTO ULAZNICA( SifU, SedisteBr, ZvanicnaCena, Status, SifR) VALUES(54,2,200,'S',20)

INSERT INTO ULAZNICA( SifU, SedisteBr, ZvanicnaCena, Status, SifR) VALUES(55,1,200,'S',21)
INSERT INTO ULAZNICA( SifU, SedisteBr, ZvanicnaCena, Status, SifR) VALUES(56,2,200,'S',21)
SET IDENTITY_INSERT ULAZNICA OFF

INSERT INTO VAZI(SifU, SifD) VALUES(38, 3)
INSERT INTO VAZI(SifU, SifD) VALUES(39, 3)
INSERT INTO VAZI(SifU, SifD) VALUES(40, 3)
INSERT INTO VAZI(SifU, SifD) VALUES(41, 3)
INSERT INTO VAZI(SifU, SifD) VALUES(42, 3)
INSERT INTO VAZI(SifU, SifD) VALUES(43, 3)
INSERT INTO VAZI(SifU, SifD) VALUES(44, 3)
INSERT INTO VAZI(SifU, SifD) VALUES(45, 3)
INSERT INTO VAZI(SifU, SifD) VALUES(46, 3)
INSERT INTO VAZI(SifU, SifD) VALUES(47, 3)
INSERT INTO VAZI(SifU, SifD) VALUES(48, 3)
INSERT INTO VAZI(SifU, SifD) VALUES(49, 3)
INSERT INTO VAZI(SifU, SifD) VALUES(50, 3)
INSERT INTO VAZI(SifU, SifD) VALUES(51, 3)
INSERT INTO VAZI(SifU, SifD) VALUES(52, 3)
INSERT INTO VAZI(SifU, SifD) VALUES(53, 3)
INSERT INTO VAZI(SifU, SifD) VALUES(54, 3)
INSERT INTO VAZI(SifU, SifD) VALUES(55, 3)
INSERT INTO VAZI(SifU, SifD) VALUES(56, 3)

INSERT INTO KUPIO(SifU, SifK, Cena) VALUES(42,1,200)
INSERT INTO KUPIO(SifU, SifK, Cena) VALUES(53,2,200)



