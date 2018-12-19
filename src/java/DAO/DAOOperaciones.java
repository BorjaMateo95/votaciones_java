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
import java.util.ArrayList;
import java.util.Date;



public class DAOOperaciones {
    
    public void insertaUsuario(Connection con, Usuario usuario, String password2) throws SQLException, Exception {
        
        if (!usuario.getPassword().equals(password2)) {
            throw new Exception("Las contraseñas no coinciden");
        }
                      
        String sql = "INSERT INTO usuarios (dni, nombre, apellidos, domicilio, email,"
                + " fechaNacimiento, password, rol, votado) VALUES(?,?,?,?,?,?, AES_ENCRYPT(?,'borja'), ?,?)";
         
        PreparedStatement st = con.prepareStatement(sql);
        st.setString(1, usuario.getDni());
        st.setString(2, usuario.getNombre());
        st.setString(3, usuario.getApellidos());
        st.setString(4, usuario.getDomicilio());
        st.setString(5, usuario.getEmail());
        st.setDate(6, java.sql.Date.valueOf(usuario.getFechaNacimiento()));
        st.setString(7, usuario.getPassword());
        st.setString(8, usuario.getRol());
        st.setString(9, usuario.getVotado());

        st.execute();
        
    }

    public Usuario loginUsuario(Connection con, String dni, String password) throws SQLException, Exception {
                
        PreparedStatement st = con.prepareStatement("SELECT * FROM usuarios WHERE dni =? AND AES_DECRYPT(password, 'borja')=?");
        st.setString(1, dni);
        st.setString(2, password);
        ResultSet rs = st.executeQuery();
            
        if(rs.next()) {
            return new Usuario(rs.getString("dni"), rs.getString("nombre"), 
            rs.getString("apellidos"), rs.getString("domicilio"), rs.getString("email"),
            rs.getDate("fechaNacimiento").toLocalDate(), rs.getString("password"),
                    rs.getString("rol"), rs.getString("votado"));
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

    public void bajaUsuario(Connection conn, Usuario usuario) throws SQLException, Exception {
        
        //comprobar si el usuario a votado, si ha votado no dejamos que se de de baja
        PreparedStatement st1 = conn.prepareStatement("SELECT * FROM usuarios WHERE dni=?");
        st1.setString(1, usuario.getDni());
        
        ResultSet result = st1.executeQuery();
            
        if(result.next()) {
            if(result.getString("votado").equals("S")){
                throw new Exception("No puedes darte de baja porque has votado");
            }
        }else{
            throw new Exception("Usuario o contraseña incorrectos");
        }
        
                
        PreparedStatement st = conn.prepareStatement("DELETE FROM usuarios WHERE dni=? AND AES_DECRYPT(password, 'borja')=?");
        st.setString(1, usuario.getDni());
        st.setString(2, usuario.getPassword());

        if(st.executeUpdate() == 0){
            throw new Exception("Error, no se ha podido dar de baja el usuario.");//preguntar
        }
        
    }

    public ArrayList<Usuario> dameCenso(Connection conn) throws SQLException, Exception {
        String sql = "SELECT * FROM usuarios;";
        PreparedStatement st = conn.prepareStatement(sql);
        ResultSet rs = st.executeQuery(sql);
        int contador = 0;
        
        ArrayList<Usuario> listaUsuarios = new ArrayList<Usuario>();
                        
        while (rs.next()){
            contador++;
            listaUsuarios.add(new Usuario(rs.getString(2), rs.getString(3), rs.getString(4),rs.getString(5), 
                    rs.getString(6), rs.getDate(7).toLocalDate(), rs.getString(10)));
        }
        
        if(contador == 0){
            throw new Exception("No hay usuarios registrados");
        }
               
        return listaUsuarios;
    }
    
}
