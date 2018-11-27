/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;
import java.sql.*;


public class ConexionBD {
    
    private static ConexionBD UnicaConexion = null;
    private Connection Conex;

    private ConexionBD() throws ClassNotFoundException, SQLException {
        Class.forName("com.mysql.jdbc.Driver");
        String connectionUrl = "jdbc:mysql://localhost:3306/bd_votaciones_bml";
        Conex = DriverManager.getConnection(connectionUrl, "root", "");
    }

    public synchronized static ConexionBD GetConexion()
        throws ClassNotFoundException, SQLException {
        if (UnicaConexion == null) {
            UnicaConexion = new ConexionBD();
        }
        return UnicaConexion;
    }

    public Connection GetCon() {
        return Conex;
    }

    public void Destroy() throws SQLException {
        Conex.close();
    }
    
}
