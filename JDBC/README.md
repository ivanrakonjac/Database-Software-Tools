# Beleske

Objekat Connection koji se dobija kao rezultat poziva predstavlju otvorenu vezu koja se može koristiti za kreiranje JDBC iskaza i prosleđivanje SQL iskaza do ciljne DBMS. Da bi se DBMS prosledio željeni SQL iskaz neophodno je kreirati Statement objekat, za šta će biti iskorišćen prethodno kreiran Connection objekat.

	Statement stmt = con.createStatement();

U ovom trenutku postoji iskaz, ali on ne sadrži potrebni SQL koji bi trebao da se prosledi do ciljnog DBMS. Potrebno je definisati SQL iskaz koji želimo da bude izvršen na DMBS, a potom ga pokrenuti. Ukoliko SQL iskaz ne vraća rezultat (CREATE, INSERT, UPDATE, DELETE) onda se za njegovo izvršavanje koristi executeUpdate metoda (ova metoda vraća celobrojnu  vrednost  koja  predstavlja  koliko  je  redova  promenjeno  izvršavanjem  SQL  iskaza.  U slučaju  DDL  naredbi povratna vrednost je 0).

	String SQLStm = "DELETE FROM ...";
	stmt.executeUpdate(SQLStm);

Ukoliko SQL iskaz vraća rezultat, što je u slučaju SELECT naredbe, onda je potrebno koristiti objekat za prihvatanje rezultata ResultSet:

	String SQLStmQuery = "SELECT * ...";
	ResultSet rs = stmt.executeQuery(SQLStmQuery);

Dobijeni rezultat se obrađuje red po red, a za dohvatanje vrednosti pojedinih kolona u posmatranom redu se koriste odgovarajuće get metode (getString, getInt, itd.). Obično se obrada vrši u petlji:

	while (rs.next()) {
		String s = rs.getString("column1");
		float n = rs.getFloat("column2");
		int m = rs.getInt("column3");
		Boolean b = rs.getBoolean("column4");
	}

U slučaju kada se želi obrada različita od obrade red po red, potrebno je definisati parametre kursora pri kreiranju Statement objekta:

	Statement stmt = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_READ_ONLY);

To će omogućiti kretanje kroz rezultat ne samo next metodom, već i sa previous, absolute, relative metodama. Za dohvatanje se može koristiti naziv kolone kao "column1" (String), ili pak redni broj kolone (int):

	String s = rs.getString(1);

Upotrebom rezultata moguće je vršiti promene u posmatranoj tabeli (ukoliko se radi o upitu koji odgovara pravilima ažurabilnog pogleda), ali je pre toga neophodno definisati tip rezultata (tip kursora). Za potrebe promena se koriste odgovarajuće update metode (updateString, updateFloat, updateInt, itd.)

	Statement stmt = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
	ResultSet uprs = stmt.executeQuery(SQlString);
	uprs.updateFloat("Column1", 102.45f);
	uprs.updateRow();

U slučaju kada se u rezultat želi dodati novi red, onda se to radi sa:

	uprs.moveToInsertRow();
	...
	uprs.updateFloat("Column1", 102.45f);
	uprs.insertRow();

Ukoliko se želi obrisati određeni red onda se to može uraditi sa: 
	
	uprs.deleteRow();

U nekim slučajevima je potrebno izvršavati neki SQL iskaz više puta. U tim slučajevima je korisno napraviti pripremljeni SQL iskaz, tj. PreparedStatement objekat. Pripremljen iskaz se može koristitibez parametara, mada je u najvećem broju slučajeva njegova upotreba upravo takva da se parametri koriste.

Prametri su u SQL iskazu obeleženi znakom pitanja. Parametri moraju pre samog izvršavanja iskaza biti prosleđeni odgovarajućim set metodama (setInt, setString, itd.)

	PreparedStatement updTab = con.prepareStatement("UPDATE Tabela1 SET Atribute1 = ? WHERE Atribute2 LIKE ?");
	updTab.setInt(1, 43);
	updTab.setString(2, "TestString");
	updTab.executeUpdate():

## Stored Procedures

Pozivi  uskladištenih  procedura  obavljaju  se  upotrebom  CallableStatement  objekta,  koji  poput  PreparedStatement objekta može da prihvata ulazne parametre, ali takođe i izlazne odnosno ulazno-izlazne paramtere takođe.

	CallableStatement cs = con.prepareCall("{call Procedura1}");
	ResultSet rs = cs. executeUpdate ();

Primeri poziva bi mogli biti:{call procedura2(?, ?, ?)}ili prilikom poziva funkcije {?= call funkcija3(?)}.Numeracija pozicija za smeštanje vrednosti kreće uvek od 1. Pozicije za Izlazne parametre u slučaju procedura, odnosno rezultat u slučaju funkcijatreba registrovati pozivom metode registerOutParameter.

## Transakcije

Nakon kreiranja konekcije, odnodno Connectionobjekta, onase nalazi u auto-commit modu rada, što znači da se svaki SQL iskaz posmatra kao zasebna transakcija. Ukoliko se želi postići da veći broj SQL iskaza predstavljaju jednu transakciju, onda je potrebno eksplicitno isključiti auto-commit režim rada. Međutim u tom slučaju je neophodno eksplicitno izvršiti commit u cilju završavanja transakcije.

con.setAutoCommit(false);
...
con.commit();
con.setAutoCommit(true);

Transakcijom se smatraju svi SQL iskazi u periodu između dva poziva metode commit. U slučajevima kada je to potrebno moguće je anulirati efekte tekuće transakcije pozivom metode rollback. Nivo izolacije transakcija se postavlja sa:
	
	con.setTransactionIsolation(TRANSACTION_READ_COMMITTED);