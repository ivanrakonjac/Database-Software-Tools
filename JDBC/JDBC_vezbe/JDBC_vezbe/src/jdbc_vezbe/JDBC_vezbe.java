/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package jdbc_vezbe;

import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Ika
 */
public class JDBC_vezbe {

    public static void ispisiRadnike(){
        
        Connection connection = DB.getInstance().getConnection();
        
        try(
            Statement stmt = connection.createStatement();
            ResultSet rs = stmt.executeQuery("select * from Radnik");
        )
        {
                
            while(rs.next()){
                System.out.println(rs.getString(2) + " " + rs.getString("Prezime"));
            }
            
        }catch (SQLException ex) {
            Logger.getLogger(JDBC_vezbe.class.getName()).log(Level.SEVERE, null, ex);
        }
    }  
    
    public static void izmeniImeRadnicima(){
        
        Connection connection = DB.getInstance().getConnection();
        
        try(
            PreparedStatement stmt = connection.prepareStatement("select * from Radnik", ResultSet.TYPE_FORWARD_ONLY, ResultSet.CONCUR_UPDATABLE);
            ResultSet rs = stmt.executeQuery();
        )
        {
                
            if (rs.next()){
                System.out.println(rs.getString(2) + " " + rs.getString("Prezime"));
                rs.updateString(2, "Test");
                rs.updateRow();
            }
            
        }catch (SQLException ex) {
            Logger.getLogger(JDBC_vezbe.class.getName()).log(Level.SEVERE, null, ex);
        }
    }  
    
    public static int brRadnikaSaImenom(String ime)
    {
        Connection conn=DB.getInstance().getConnection();
        String query="{ call SPBrojRadnikaSaImenom (?,?) }"; 
        try (CallableStatement cs= conn.prepareCall(query)){
            cs.setString(1, ime);
            cs.registerOutParameter(2, java.sql.Types.INTEGER);
            cs.execute();
            return cs.getInt(2);
        } catch (SQLException ex) {
            Logger.getLogger(JDBC_vezbe.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }
    
    public static void radniciSaImenom(String ime)
    {
        Connection conn=DB.getInstance().getConnection();
        String query="{ call SPRadniciSaImenom (?) }";
        try (CallableStatement cs= conn.prepareCall(query)){     
            cs.setString(1, ime);
            try (ResultSet rs=cs.executeQuery()){
                System.out.println("Radnici sa imenom "+ime);
                while(rs.next())
                    System.out.println("BrLK:"+rs.getInt("BrLK")+
                            " prezime:"+rs.getString("Prezime"));
            } catch (SQLException ex) {
                Logger.getLogger(JDBC_vezbe.class.getName()).log(Level.SEVERE, null, ex);
            }
        } catch (SQLException ex) {
            Logger.getLogger(JDBC_vezbe.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    /**
     *
     * @param args
     */
    public static void main(String[] args) {
        
        izmeniImeRadnicima();
        ispisiRadnike();
        //System.out.println("Broj radnika sa imenom: " + brRadnikaSaImenom("Marko"));
        //radniciSaImenom("Marko");
    }
    
}
