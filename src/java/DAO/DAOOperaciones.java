/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import Excepciones.MiException;
import Modelos.Candidato;
import Modelos.Escano;
import Modelos.Partido;
import Modelos.Usuario;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Arrays;



public class DAOOperaciones {
    
    public void insertaUsuario(Connection con, Usuario usuario, String password2) throws SQLException, Exception {
        
        if (!usuario.getPassword().equals(password2)) {
            throw new MiException("Las contraseñas no coinciden");
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
            throw new MiException("Usuario o contraseña incorrectos");
        }
              
    }

    public void modificacionUsuario(Connection conn, Usuario usuario, String password2) throws SQLException, Exception{
        if (!usuario.getPassword().equals(password2)) {
            throw new MiException("Las contraseñas no coinciden");
        }
        
        PreparedStatement stV = conn.prepareStatement("SELECT * FROM usuarios WHERE dni=?");
        stV.setString(1, usuario.getDni());
        
        ResultSet result = stV.executeQuery();
            
        if(result.next()) {
            if(result.getString("votado").equals("S")){
                throw new MiException("No puedes modificar los datos porque has votado");
            }
        }else{
            throw new MiException("Usuario o contraseña incorrectos");
        }
        
        String sql = "UPDATE usuarios SET nombre=?, apellidos =?, domicilio=?, email=?,"
        + " fechaNacimiento=?, password=AES_ENCRYPT(?,'borja') WHERE dni=?";
         
        PreparedStatement st = conn.prepareStatement(sql);
        st.setString(1, usuario.getNombre());
        st.setString(2, usuario.getApellidos());
        st.setString(3, usuario.getDomicilio());
        st.setString(4, usuario.getEmail());
        st.setDate(5, java.sql.Date.valueOf(usuario.getFechaNacimiento()));
        st.setString(6, usuario.getPassword());
        st.setString(7, usuario.getDni());

        if(st.executeUpdate() == 0){
            throw new MiException("Error al actualizar los datos");
        }
              
        
    }

    public void bajaUsuario(Connection conn, Usuario usuario) throws SQLException, Exception {
        
        PreparedStatement st1 = conn.prepareStatement("SELECT * FROM usuarios WHERE dni=?");
        st1.setString(1, usuario.getDni());
        
        ResultSet result = st1.executeQuery();
            
        if(result.next()) {
            if(result.getString("votado").equals("S")){
                throw new MiException("No puedes darte de baja porque has votado");
            }
        }else{
            throw new MiException("Usuario o contraseña incorrectos");
        }
        
                
        PreparedStatement st = conn.prepareStatement("DELETE FROM usuarios WHERE dni=? AND AES_DECRYPT(password, 'borja')=?");
        st.setString(1, usuario.getDni());
        st.setString(2, usuario.getPassword());

        if(st.executeUpdate() == 0){
            throw new MiException("Error, no se ha podido dar de baja el usuario.");
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
            throw new MiException("No hay usuarios registrados");
        }
               
        return listaUsuarios;
    }

    public void abrirCerrarEscrutinio(Connection conn, int i) throws SQLException, Exception {
        
        String sql = "UPDATE configuracion SET situacion_escrutinio=?";
         
        PreparedStatement st = conn.prepareStatement(sql);
        st.setInt(1, i);
      

        if(st.executeUpdate() == 0){
            if(i==1) {
               throw new MiException("Error al abrir el Escrutinio"); 
            }else{
               throw new MiException("Error al cerrar el Escrutinio"); 
            }
            
        }
        
    }

    public ArrayList<Partido> comprobarEscrutinioUsuario(Connection conn, Usuario usu) throws SQLException, Exception {
        
        PreparedStatement st = conn.prepareStatement("SELECT situacion_escrutinio FROM configuracion");
        ResultSet rs = st.executeQuery();
            
        if(rs.next()) {
            if(rs.getInt("situacion_escrutinio") == 0) {
                throw new MiException("No puede Votar, el escrutinio esta cerrado");
            }
        }else{
            throw new MiException("ERROR al leer la tabla configuracion");
        }
        
        PreparedStatement stusu = conn.prepareStatement("SELECT votado FROM usuarios WHERE dni=?");
        stusu.setString(1, usu.getDni());
        ResultSet rsusu = stusu.executeQuery();
            
        if(rsusu.next()) {
            if(rsusu.getString("votado").equals("S")) {
                throw new MiException("Ya ha votado");
            }
        }else{
            throw new MiException("ERROR al leer el usuario");
        }
                
        PreparedStatement stpar = conn.prepareStatement("SELECT * FROM partidos");
        ResultSet rspar = stpar.executeQuery();
        int contador = 0;
        
        ArrayList<Partido> listaPartidos = new ArrayList<Partido>();
                    
        while (rspar.next()){
            contador++;
            listaPartidos.add(new Partido(rspar.getInt(1), rspar.getString(2), rspar.getString(3), rspar.getInt(4)));
        }
        
        if(contador == 0) {
            throw new MiException("ERROR no hay partidos en la BD");
        }

        return listaPartidos;
    }

    public void votar(Connection conn, Usuario usu, int voto) throws SQLException, MiException {
        
        PreparedStatement stc = conn.prepareStatement("SELECT * FROM usuarios WHERE dni=?");
        stc.setString(1, usu.getDni());
        ResultSet rsu = stc.executeQuery();
        
        if (rsu.next()) {
            if(rsu.getString("votado").equals("S")) {
                throw new MiException("ERROR usted ya ha votado");
            }
        }else{
            throw new MiException("ERROR al leer el usuario");
        }
        
        
        PreparedStatement st = conn.prepareStatement("SELECT * FROM partidos WHERE ID=?");
        st.setInt(1, voto);
        ResultSet rs = st.executeQuery();
        
        int numVotos = 0;
        
        if (rs.next()) {
            numVotos = rs.getInt("VOTOS");
        }else{
            throw new MiException("ERROR al leer el partido");
        }
        
        numVotos++;
        
        PreparedStatement std = conn.prepareStatement("UPDATE partidos SET VOTOS=? WHERE ID=?");
        std.setInt(1, numVotos);
        std.setInt(2, voto);
      

        if(std.executeUpdate() == 0){
            throw new MiException("ERROR al votar");
        }
        
        
        PreparedStatement stu = conn.prepareStatement("UPDATE usuarios SET votado=? WHERE dni=?");
        stu.setString(1, "S");
        stu.setString(2, usu.getDni());
      

        if(stu.executeUpdate() == 0){
            throw new MiException("ERROR al actualizar el usuario");
        }
               
        
    }

    public ArrayList<Partido> comprobarEscrutinio(Connection conn) throws SQLException, MiException {
        PreparedStatement stc = conn.prepareStatement("SELECT * FROM configuracion WHERE id=?");
        stc.setInt(1, 1);
        ResultSet rsu = stc.executeQuery();
        
        if (rsu.next()) {
            if(rsu.getInt("situacion_escrutinio") == 1) {
                throw new MiException("ERROR no puede ver los resultados el escrutinio esta abierto");
            }
        }else{
            throw new MiException("ERROR al leer la configuracion de la votación");
        }
        
        PreparedStatement stpar = conn.prepareStatement("SELECT * FROM partidos");
        ResultSet rspar = stpar.executeQuery();
        int contador = 0;
        
        ArrayList<Partido> listaPartidos = new ArrayList<Partido>();
                    
        while (rspar.next()){
            contador++;
            listaPartidos.add(new Partido(rspar.getInt(1), rspar.getString(2), rspar.getString(3), rspar.getInt(4)));
        }
        
        if(contador == 0) {
            throw new MiException("ERROR no hay partidos en la BD");
        }

        return listaPartidos;       
        
    }
    
    public ArrayList<Escano> presentarResultados(Connection conn) throws SQLException, MiException {
        
        ArrayList<Partido> listPartidos = comprobarEscrutinio(conn);
        
        int votosTotales = 0;
        int numeroEscanos = dimeNumeroEscanos(conn);
        
        for (int i = 0; i < listPartidos.size(); i++) {
            votosTotales += listPartidos.get(i).getVotos();
        }
        
        //eliminamos los partidos que no llegen al 3%
        for (int i = 0; i < listPartidos.size(); i++) {
            int n = listPartidos.get(i).getVotos() * 100;
            
            double result = n / votosTotales;
            
            if (result < 3) {
                listPartidos.remove(i);
            }
            
        }

        double array[][] = new double[listPartidos.size()][numeroEscanos];
        
        for (int i = 0; i < listPartidos.size(); i++) {
            double votos = listPartidos.get(i).getVotos();
            
            for (int e = 1; e <= numeroEscanos; e++) {
                double resul = votos / e;
                array[i][e-1] = resul;
            }
            
        }
        
        int numeroA = listPartidos.size() * numeroEscanos;
        double arrayTodos[] = new double[numeroA];
        
        int cont = 0;
        for(int i = 0; i < listPartidos.size(); i++) {

            for (int e = 0; e < numeroEscanos; e++) {
                arrayTodos[cont] = array[i][e];
                cont++;
            }

        }
        
        Arrays.sort(arrayTodos);
        double arrayFinal[] = new double[numeroEscanos];
        
        int a = 1;
        for(int i = 0; i < numeroEscanos; i++) {
            arrayFinal[i] = arrayTodos[numeroA-a];
            a++;
        }        


        //escaños
        for (int i = 0; i < listPartidos.size(); i++) {
            int esc = (int) (listPartidos.get(i).getVotos() / arrayFinal[numeroEscanos-1]);
            listPartidos.get(i).setEscanos(esc);
            
        }
        
        ArrayList<Escano> listEscano = new ArrayList<Escano>();
        for(int i= 0; i < listPartidos.size(); i++) {
                if(listPartidos.get(i).getEscanos() != 0) {
                    ArrayList<Candidato> listCandidatos = dameCandidatos(conn, listPartidos.get(i).getId(), listPartidos.get(i).getEscanos());
                    listEscano.add(new Escano(listPartidos.get(i), listCandidatos));
            
                    for(int e = 0; e < listCandidatos.size(); e++) {
                        guardaEscano(conn, listPartidos.get(i).getId(), listCandidatos.get(e).getId());
                    }
                }else{
                    listPartidos.remove(i);
                }

        }
        
        return listEscano;
 
    }
    
    
    private void guardaEscano(Connection conn, int idPartido, int idCandidato) throws SQLException {
        String sql = "INSERT INTO escanos (idPartido, idCandidato) VALUES(?,?)";
        PreparedStatement st = conn.prepareStatement(sql);
        st.setInt(1, idPartido);
        st.setInt(2, idCandidato);
        st.execute();
    }
    
    
    private ArrayList<Candidato> dameCandidatos(Connection conn, int id, int tope) throws SQLException, MiException {
        PreparedStatement stpar = conn.prepareStatement("SELECT * FROM candidatos WHERE ID_PARTIDO=? ORDER BY ORDEN LIMIT ?");
        stpar.setInt(1, id);
        stpar.setInt(2, tope);
        ResultSet rspar = stpar.executeQuery();
        int contador = 0;
                
        ArrayList<Candidato> listaCandidatos = new ArrayList<Candidato>();
                    
        while (rspar.next()){
            contador++;
            listaCandidatos.add(new Candidato(rspar.getInt(1), rspar.getString(2), rspar.getInt(3), rspar.getInt(4)));
        }
        
        if(contador == 0) {
            throw new MiException("ERROR no hay partidos en la BD");
        }

        return listaCandidatos;
    }
    
    
    public int dimeNumeroEscanos(Connection conn) throws SQLException, MiException {
        
        PreparedStatement stc = conn.prepareStatement("SELECT * FROM configuracion WHERE id=?");
        stc.setInt(1, 1);
        ResultSet rsu = stc.executeQuery();
        
        if (rsu.next()) {
              return rsu.getInt("n_escanos");
        }else{
            throw new MiException("ERROR al leer la configuracion de la votación");
        }
        
    }
    
}
