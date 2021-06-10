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
    /**
     *
     * @param args
     */
    public static void main(String[] args) {
        ispisiRadnike();
    }
    
}
