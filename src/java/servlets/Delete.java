/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import db.Base;
import java.io.IOException;
import java.io.PrintWriter;
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
@WebServlet(name = "Delete", urlPatterns = {"/Delete"})
public class Delete extends HttpServlet {

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
        
        String tip = request.getParameter("tip"); // tip sta brisemo
        
        if (tip.equals("brend"))
        {
            try {
                int brend_id = Integer.parseInt(request.getParameter("brend_id"));
                
                Base.getConnection().createStatement().execute("DELETE FROM brendovi WHERE brend_id = " + brend_id);
            
                RequestDispatcher dispatcher = request.getRequestDispatcher("panel.jsp?poruka=1");
                dispatcher.forward(request, response);
                
            } catch (Exception ex) {
                Logger.getLogger(Delete.class.getName()).log(Level.SEVERE, null, ex);
                
                RequestDispatcher dispatcher = request.getRequestDispatcher("panel.jsp?poruka=2");
                dispatcher.forward(request, response);
            }
        } else if (tip.equals("kat"))
        {
            try{
                int kat_id = Integer.parseInt(request.getParameter("kat_id")); // uzmi id onoga sto brisemo i obrisi ga
            
                Base.getConnection().createStatement().execute("DELETE FROM kategorija WHERE kat_id = " + kat_id); // tu se brise
            
                RequestDispatcher dispatcher = request.getRequestDispatcher("panel.jsp?poruka=1");
                dispatcher.forward(request, response);
                
            } catch (Exception ex) {
                Logger.getLogger(Delete.class.getName()).log(Level.SEVERE, null, ex);
                
                RequestDispatcher dispatcher = request.getRequestDispatcher("panel.jsp?poruka=2");
                dispatcher.forward(request, response);
            }
        } else if (tip.equals("podk"))
        {
            try{
                int podk_id = Integer.parseInt(request.getParameter("podk_id"));
            
                Base.getConnection().createStatement().execute("DELETE FROM podkategorija WHERE podk_id = " + podk_id);
            
                RequestDispatcher dispatcher = request.getRequestDispatcher("panel.jsp?poruka=1");
                dispatcher.forward(request, response);
                
            } catch (Exception ex) {
                Logger.getLogger(Delete.class.getName()).log(Level.SEVERE, null, ex);
                
                RequestDispatcher dispatcher = request.getRequestDispatcher("panel.jsp?poruka=2");
                dispatcher.forward(request, response);
            }
        } else if (tip.equals("art"))
        {
            try{
                int art_id = Integer.parseInt(request.getParameter("art_id"));
            
                Base.getConnection().createStatement().execute("DELETE FROM artikal WHERE art_id = " + art_id);
            
                RequestDispatcher dispatcher = request.getRequestDispatcher("panel.jsp?poruka=1");
                dispatcher.forward(request, response);
                
            } catch (Exception ex) {
                Logger.getLogger(Delete.class.getName()).log(Level.SEVERE, null, ex);
                
                RequestDispatcher dispatcher = request.getRequestDispatcher("panel.jsp?poruka=2");
                dispatcher.forward(request, response);
            }
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
