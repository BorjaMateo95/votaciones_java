/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import Modelos.Usuario;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.Date;



public class DAOOperaciones {
    
    public void insertaUsuario(Connection con, Usuario usuario, String password2) throws SQLException {
        if (!usuario.getPassword().equals(password2)) {
            //lanzar exception propia
        }
                      
        String sql = "INSERT INTO usuarios (dni, nombre, apellidos, domicilio, email,"
                + " fechaNacimiento, password, rol) VALUES(?,?,?,?,?,?, AES_ENCRYPT(?,'borja'), ?)";
         
        PreparedStatement st = con.prepareStatement(sql);
        st.setString(1, usuario.getDni());
        st.setString(2, usuario.getNombre());
        st.setString(3, usuario.getApellidos());
        st.setString(4, usuario.getDomicilio());
        st.setString(5, usuario.getEmail());
        st.setDate(6, java.sql.Date.valueOf(usuario.getFechaNacimiento()));
        st.setString(7, usuario.getPassword());
        st.setString(8, usuario.getRol());

        st.execute();
        
    }

    public Usuario loginUsuario(Connection con, String dni, String password) throws SQLException, Exception {
        
        String sql = "SELECT * FROM usuarios WHERE dni =? AND AES_DECRYPT(password, 'borja')=?";
        
        PreparedStatement st = con.prepareStatement("SELECT * FROM usuarios WHERE dni =? AND AES_DECRYPT(password, 'borja')=?");
        st.setString(1, dni);
        st.setString(2, password);
        ResultSet rs = st.executeQuery();
            
        if(rs.next()) {
            return new Usuario(rs.getString("dni"), rs.getString("nombre"), 
            rs.getString("apellidos"), rs.getString("domicilio"), rs.getString("email"),
            rs.getDate("fechaNacimiento").toLocalDate(), rs.getString("password"), rs.getString("rol"));
        }else{
            //exception
            throw new Exception("Usuario o contraseña incorrectos");
        }
              
    }

    public void modificacionUsuario(Connection conn, Usuario usuario, String password2) throws SQLException, Exception{
        if (!usuario.getPassword().equals(password2)) {
            //lanzar exception propia
        }
        
        String sql = "UPDATE usuarios SET dni=? , nombre=?, apellidos =?, domicilio=?, email=?,"
        + " fechaNacimiento=?, password=AES_ENCRYPT(?,'borja') WHERE dni=?";
         
        PreparedStatement st = conn.prepareStatement(sql);
        st.setString(1, usuario.getDni());
        st.setString(2, usuario.getNombre());
        st.setString(3, usuario.getApellidos());
        st.setString(4, usuario.getDomicilio());
        st.setString(5, usuario.getEmail());
        st.setDate(6, java.sql.Date.valueOf(usuario.getFechaNacimiento()));
        st.setString(7, usuario.getPassword());
        st.setString(8, usuario.getDni());

        if(st.executeUpdate() == 0){
            throw new Exception("Error al actualizar los datos");//preguntar
        }
              
        
    }
    
}
