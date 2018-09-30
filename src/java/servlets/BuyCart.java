/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import db.Base;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author anci
 */
@WebServlet(name = "BuyCart", urlPatterns = {"/BuyCart"})
public class BuyCart extends HttpServlet {

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
        
        int korpa_id = Integer.parseInt(request.getParameter("korpa_id")); // id korpe iz parametara se izvlaci
        
        try {
            Connection con = Base.getConnection(); // konektuje se na bazu
            
            con.createStatement().execute("UPDATE Korpa SET placeno = 1 WHERE korpa_id = " + korpa_id); // updejtuje se korpa da je placena
            
            // otvaramo korisniku novu korpu za dalju kupovinu
            con.createStatement().execute("INSERT INTO Korpa (kor_id, placeno) VALUES"
                    + " ("+ request.getSession().getAttribute("id") +", 0)");
            
            // preusmeri na stranicu store i prikazi poruku da je placanje uspelo
            RequestDispatcher dispatcher = request.getRequestDispatcher("store.jsp?poruka=1");
            dispatcher.forward(request, response);
            
        } catch (Exception ex) {
            // ako se desi greska vrati nas na korpu sa porukom
            RequestDispatcher dispatcher = request.getRequestDispatcher("cart.jsp?greska=2");
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
