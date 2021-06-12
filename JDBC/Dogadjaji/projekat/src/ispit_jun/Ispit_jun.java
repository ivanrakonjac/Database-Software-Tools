/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ispit_jun;

import java.lang.ref.Cleaner;
import java.sql.Array;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Tasha
 */
public class Ispit_jun {

    private Connection connection=DB.getInstance().getConnection();
    
    public static int RedBrojMesta(int red)
    {
        Connection conn=DB.getInstance().getConnection();
        String query="{?= call [fRedBrojMesta] (?) }"; 
        try (CallableStatement cs= conn.prepareCall(query)){
            cs.registerOutParameter(1, java.sql.Types.ARRAY);
            cs.setInt(2, 1);
            cs.execute();
            return cs.getInt(2);
        } catch (SQLException ex) {
            Logger.getLogger(Ispit_jun.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }
    
    /**
     * Funkcija koja vraca Id dogadjaja za njegovo prosledjeno ine
     * @param NazivDogadjaja String 
     * @return int - Id proslednjenog dogadjaja
     */
    public static int NazivDogadjajaToRedniBroj(String NazivDogadjaja){
        
        Connection connection = DB.getInstance().getConnection();
        
        String query =  "select * from DOGADJAJ where Naziv = ?";
        
        try(
            PreparedStatement stmt=connection.prepareStatement(query);  
        )
        {
            stmt.setString(1,NazivDogadjaja);
            
            try(ResultSet rs = stmt.executeQuery();){
                if(rs.next()){
                    //System.out.println("Id dogadjaja " + NazivDogadjaja + " je " + rs.getString(1));
                    return Integer.parseInt(rs.getString(1));
                } 
            }
            
        } catch (SQLException ex) {
            Logger.getLogger(Ispit_jun.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return -1;
    }
       

    public static void SlobodnaProdajaUlaznica(String NazivDogadjaja, int BrojUlaznica){
        
        Connection connection = DB.getInstance().getConnection();
        
        int idDogadjaja = NazivDogadjajaToRedniBroj(NazivDogadjaja);
        
        class SektorRedBrUlaznica {

        public SektorRedBrUlaznica(int sektor, int red, int brojUlaznica) {
            this.sektor = sektor;
            this.red = red;
            this.brojUlaznica = brojUlaznica;
        }
        
        
        public int sektor;
        public int red;
        public int brojUlaznica;
        };
        
        class PovratnaVrednost{

            public PovratnaVrednost(SektorRedBrUlaznica sektorRedBrUlaznica1, SektorRedBrUlaznica sektorRedBrUlaznica2, boolean trebaLiDvaReda) {
                this.sektorRedBrUlaznica1 = sektorRedBrUlaznica1;
                this.sektorRedBrUlaznica2 = sektorRedBrUlaznica2;
                this.trebaLiDvaReda = trebaLiDvaReda;
            }
            
            public SektorRedBrUlaznica sektorRedBrUlaznica1;
            public SektorRedBrUlaznica sektorRedBrUlaznica2;
            public boolean trebaLiDvaReda;
        }
        
        
        PovratnaVrednost povratnaVrednost = null;
        
        LinkedList<SektorRedBrUlaznica> brojSedistaPoRedu = new LinkedList<SektorRedBrUlaznica>();
     
        //Koliko slobodnih ulaznica u kom redu ima
        String query =  "select V.SifD, R.SifS, U.SifR, count(*) as BrojUlaznica, S.FaktorS, R.FaktorR\n" +
                        "from ULAZNICA U \n" +
                        "join Vazi V\n" +
                        "on V.SifU = U.SifU\n" +
                        "join RED R\n" +
                        "on R.SifR = U.SifR\n" +
                        "join SEKTOR S\n" +
                        "on R.SifS = S.SifS\n" +
                        "where U.Status = 'S' and V.SifD=?\n" +
                        "group by V.SifD,R.SifS, U.SifR, S.FaktorS, R.FaktorR\n" +
                        "order by FaktorS desc, FaktorR desc";
        
        try(
            PreparedStatement stmt=connection.prepareStatement(query);      
        )
        {
            stmt.setInt(1, idDogadjaja);
            ResultSet rs = stmt.executeQuery();
            
            System.out.println();
            
            while(rs.next()){
                int sektor = Integer.parseInt(rs.getString("SifS"));
                int red = Integer.parseInt(rs.getString("SifR"));
                int brSedista = Integer.parseInt(rs.getString("BrojUlaznica"));
                if(brSedista > 0){
                    brojSedistaPoRedu.add(new SektorRedBrUlaznica(sektor,red,brSedista));
                }
            }
            
        }catch (SQLException ex) {
            Logger.getLogger(Ispit_jun.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        // Proverim da li trazeni broj moze da stane u 1 red
        for (int i = 0; i < brojSedistaPoRedu.size(); i++) {
            if(brojSedistaPoRedu.get(i).brojUlaznica >= BrojUlaznica ){
                povratnaVrednost = new PovratnaVrednost(brojSedistaPoRedu.get(i), null, false);
                break;
            }
        }
        
        // Ako ne moze, proveravam da li moze u 2 susedna
        if(povratnaVrednost == null){
           for (int i = 0; i < brojSedistaPoRedu.size() - 1; i++) {
                if(brojSedistaPoRedu.get(i).brojUlaznica + brojSedistaPoRedu.get(i+1).brojUlaznica >= BrojUlaznica){
                    povratnaVrednost = new PovratnaVrednost(brojSedistaPoRedu.get(i), brojSedistaPoRedu.get(i + 1), true);
                    break;
                }
            } 
        }

           /*for (int i = 0; i < brojSedistaPoRedu.size() - 1; i++) {
               //if(brojSedistaPoRedu.get(i).brojUlaznica + brojSedistaPoRedu.get(i+1).brojUlaznica >= BrojUlaznica ) return true;
               System.out.println(brojSedistaPoRedu.get(i).sektor + " | " + brojSedistaPoRedu.get(i).red + " | " + brojSedistaPoRedu.get(i).brojUlaznica);
           }*/

        if(povratnaVrednost==null){
            System.out.println("Nema mesta...");
        }
        else if(povratnaVrednost.trebaLiDvaReda){ //Ako treba 2 reda
            System.out.println(povratnaVrednost.sektorRedBrUlaznica1.sektor + " | " + povratnaVrednost.sektorRedBrUlaznica1.red + " | " + povratnaVrednost.sektorRedBrUlaznica1.brojUlaznica);
            System.out.println(povratnaVrednost.sektorRedBrUlaznica2.sektor + " | " + povratnaVrednost.sektorRedBrUlaznica2.red + " | " + povratnaVrednost.sektorRedBrUlaznica2.brojUlaznica);
            
            /*
                Ovde treba broj karata podeliti ravnomerno na 2 reda
            */

        }else{ // Ako sve staje u jedan red
            System.out.println(povratnaVrednost.sektorRedBrUlaznica1.sektor + " | " + povratnaVrednost.sektorRedBrUlaznica1.red + " | " + povratnaVrednost.sektorRedBrUlaznica1.brojUlaznica);

             query = "{ call getUlazniceFromRed (?) }";

             try (CallableStatement cs = connection.prepareCall(query)){    
                 cs.setInt(1, povratnaVrednost.sektorRedBrUlaznica1.red);
                 try (ResultSet rs = cs.executeQuery()){
                     for (int i = 0; i < BrojUlaznica; i++) {
                         rs.next();
                         System.out.println(rs.getString("SifU") + " | " +  rs.getString("Status"));
                         
                        query = "update ULAZNICA\n" +
                                "	set Status = 'P'\n" +
                                "	where SifU=?";
                        
                        try(PreparedStatement stmt=connection.prepareStatement(query)){
                            stmt.setInt(1, Integer.parseInt(rs.getString("SifU")));
                            stmt.executeUpdate();
                        }

                         /*
                            
                            II nacin da se pozove fja
                        
                         query = "{ call spChangeStatus (?) }";

                         try(CallableStatement cs2 = connection.prepareCall(query)){
                             cs2.setInt(1, Integer.parseInt(rs.getString("SifU")));
                             cs2.executeQuery();
                         }*/

                         //rs.updateCharacterStream(4, new Reader);
                     }
                 }catch (SQLException ex) {
                     Logger.getLogger(Ispit_jun.class.getName()).log(Level.SEVERE, null, ex);
                 }
             } catch (SQLException ex) {   
             Logger.getLogger(Ispit_jun.class.getName()).log(Level.SEVERE, null, ex);
             }   
         }
    }
    
        
    
    /* TEST CRUD OPERACIJA */
    
    public static void selectAllFromDogadjaj(){
        Connection conn = DB.getInstance().getConnection();
        String query = "select * from Dogadjaj";
        
        try(
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(query);)
        {
            while(rs.next()){
                System.out.println(rs.getString(1) + " | " + rs.getString(2) + " | " + rs.getString("Opis"));
            }
            
        } catch (SQLException ex) {
            Logger.getLogger(Ispit_jun.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public static void selectDogadjajWithSifD(int SifD){
        Connection conn = DB.getInstance().getConnection();
        String query = "select * from Dogadjaj where SifD=?";
        
        try(PreparedStatement stmt = conn.prepareCall(query)){
            
            stmt.setInt(1, SifD);
            
            try(ResultSet rs = stmt.executeQuery();){
                while(rs.next()){
                    System.out.println(rs.getString(1) + " | " + rs.getString(2) + " | " + rs.getString("Opis"));
                }
            }
            
        } catch (SQLException ex) {
            Logger.getLogger(Ispit_jun.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public static void updateDatumDogadjaja(int SifD){
        Connection conn = DB.getInstance().getConnection();
        String query = "select * from Dogadjaj where SifD=?";
        
        try(PreparedStatement stmt = conn.prepareCall(query,ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE)){
            
            stmt.setInt(1, SifD);
            
            try(ResultSet rs = stmt.executeQuery();){
                rs.next();
                rs.first();
                
                java.util.Date dateUtil = new java.util.Date();
                Date date = new Date(dateUtil.getTime());
                rs.updateDate("Datum", date);
                
                rs.updateRow();
            }
            
        } catch (SQLException ex) {
            Logger.getLogger(Ispit_jun.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public static void updateImeKupca(int SifK, String Ime){
        Connection conn = DB.getInstance().getConnection();
        String query = "select * from Kupac where SifK=?";
        
        try(PreparedStatement stmt = conn.prepareCall(query,ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE)){
            
            stmt.setInt(1, SifK);
            
            try(ResultSet rs = stmt.executeQuery();){
                rs.next();
                rs.first();
                
                rs.updateString("Ime", Ime);
                rs.updateRow();
            }
            
        } catch (SQLException ex) {
            Logger.getLogger(Ispit_jun.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public static void insertKupca(String Ime){
        Connection conn = DB.getInstance().getConnection();
        String query = "select * from Kupac";
        
        try(PreparedStatement stmt = conn.prepareCall(query,ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
            ResultSet rs = stmt.executeQuery();)
        {
            rs.moveToInsertRow();
            rs.updateString("Ime",Ime);
            rs.insertRow();
        } catch (SQLException ex) {
            Logger.getLogger(Ispit_jun.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public static void deleteVazi(int SifU){
        Connection conn = DB.getInstance().getConnection();
        String query = "select * from Vazi where SifU=?";
        
        try(PreparedStatement stmt = conn.prepareCall(query,ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE)){
            
            stmt.setInt(1, SifU);
            
            try(ResultSet rs = stmt.executeQuery();){
                rs.next();
                rs.first();
                
                rs.deleteRow();
            }
            
        } catch (SQLException ex) {
            Logger.getLogger(Ispit_jun.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public static void kolikoJeKarataKupio (int SifK){
        Connection conn = DB.getInstance().getConnection();
        
        try(CallableStatement cstmt = conn.prepareCall("{ call dbo.numOfBuyedTickets (?, ?) }")){
            cstmt.setInt(1, SifK);
            cstmt.registerOutParameter(2, java.sql.Types.INTEGER);
            cstmt.execute();
            System.out.println("Kupac sa IDjem: " + SifK + " je kupio " + cstmt.getInt(2) + " karata");
        } catch (SQLException ex) {
            Logger.getLogger(Ispit_jun.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
   
    
    /***
     * 
     * main metoda nece biti testirana, u njoj mozete pisati vase testove
	 *
     */
    public static void main(String[] args) {
        kolikoJeKarataKupio(2);
    }
    
}
