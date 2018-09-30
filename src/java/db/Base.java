/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 *
 * @author anci
 */
public class Base {
    private static Connection con = null;
    
    public static Connection getConnection() throws ClassNotFoundException, SQLException, InstantiationException, IllegalAccessException
    {
        if (con == null) {
            Class.forName("com.mysql.jdbc.Driver").newInstance();
            con = (Connection) DriverManager.getConnection("jdbc:mysql://localhost/BeutyLook1?user=root&password=hektorcar1.&useSSL=false");
        }
        
        return con;
    }
}
