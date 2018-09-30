/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import db.Base;
import java.sql.Statement;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author anci
 */
@WebServlet(name = "LogIn", urlPatterns = {"/logIn"})
public class LogIn extends HttpServlet {

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
            throws ServletException, IOException, ClassNotFoundException, InstantiationException, IllegalAccessException, SQLException {
        String user = request.getParameter("username"); // username i pass parametri iz polja u formi sa index.jsp
        String pass = request.getParameter("pass");
        
        String poruka = "Losi podaci, probaj ponovo!"; // poruka za slucaj da logovanje bude neuspesno
        
        Statement s = (Statement) Base.getConnection().createStatement(); // dobijemo konekciju od klase Base i napravimo Statement objekat za upit bazi
        
        ResultSet rs = s.executeQuery("Select * from korisnik where username = '" + user + "' and password = '" + pass + "'");

        if(rs.first()){ // Samo ako postoji jedan korisnik sa tom user i pass kombinacijom 
            poruka=rs.getString("username");

            HttpSession session = request.getSession(); // Cuvamo podatke ulogovanog korisnika u Http sesiji
            session.setAttribute("id", rs.getInt("kor_id"));
            session.setAttribute("username", user);
            session.setAttribute("password", pass);
            session.setAttribute("tip", rs.getInt("tipk_id"));
        }
        
       if (poruka.equals("Losi podaci, probaj ponovo!"))
       {
           RequestDispatcher dispatcher = request.getRequestDispatcher("index.jsp?greska=1"); // Lose logovanje, vrati na login stranicu sa porukom o gresci
           dispatcher.forward(request, response);
           // preusmerava nazad na log in, sa servrleta..   
       } else {
           RequestDispatcher dispatcher = request.getRequestDispatcher("store.jsp"); // Ako se dobro ulogovao posalji ga na store
           dispatcher.forward(request, response);
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
        try {
            processRequest(request, response);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(LogIn.class.getName()).log(Level.SEVERE, null, ex);
        } catch (InstantiationException ex) {
            Logger.getLogger(LogIn.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IllegalAccessException ex) {
            Logger.getLogger(LogIn.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(LogIn.class.getName()).log(Level.SEVERE, null, ex);
        }
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
        try {
            processRequest(request, response);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(LogIn.class.getName()).log(Level.SEVERE, null, ex);
        } catch (InstantiationException ex) {
            Logger.getLogger(LogIn.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IllegalAccessException ex) {
            Logger.getLogger(LogIn.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(LogIn.class.getName()).log(Level.SEVERE, null, ex);
        }
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
