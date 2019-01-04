/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controladores;

import DAO.ConexionBD;
import DAO.DAOOperaciones;
import Modelos.Usuario;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author BORJA
 */
@WebServlet(name = "ControladorVotar", urlPatterns = {"/ControladorVotar"})
public class ControladorVotar extends HttpServlet {
    
    private Connection conn;

    @Override
    public void init() throws ServletException {
        super.init();
        
        try {
            conn = ConexionBD.GetConexion().GetCon();
            
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(ControladorRegistro.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(ControladorRegistro.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        
    }

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        DAOOperaciones dao = new DAOOperaciones();
        int voto = Integer.parseInt(request.getParameter("idvoto"));
        HttpSession httpSession = request.getSession();
        Usuario usu = (Usuario) httpSession.getAttribute("usuario");
                
        try {
            conn.setAutoCommit(false);
            dao.votar(conn, usu, voto);
            conn.commit();
            httpSession.setAttribute("msg", "Voto registrado");
            httpSession.setAttribute("rol", usu.getRol());
            response.sendRedirect("/Proyecto_Votaciones_Borja/Vistas/VistaMensajes.jsp");
        } catch (Exception ex) {
            if(conn!=null) {
                try {
                    conn.rollback();
                } catch (SQLException ex1) {
                    Logger.getLogger(ControladorVotar.class.getName()).log(Level.SEVERE, null, ex1);
                }
            }
            
            httpSession.setAttribute("msg", ex.getMessage());
            httpSession.setAttribute("rol", usu.getRol());
            response.sendRedirect("/Proyecto_Votaciones_Borja/Vistas/VistaError.jsp");
        }

        
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
