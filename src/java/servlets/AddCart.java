/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import db.Base;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author anci
 */
@WebServlet(name = "AddCart", urlPatterns = {"/AddCart"})
public class AddCart extends HttpServlet {

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
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet AddCart</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddCart at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
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
        
        response.setContentType("text/plain");
        
        try {
            int korisnik = Integer.parseInt(request.getSession().getAttribute("id").toString());
            int art_id = Integer.parseInt(request.getParameter("art_id"));
            
            ResultSet rs_korpa = Base.getConnection().createStatement().executeQuery("SELECT * FROM Korpa WHERE kor_id = " + korisnik + " AND placeno = false");
            
            int id_korpe = -1; // pretpostavljamo da ne postoji korpa
            
            while(rs_korpa.next())
            {
                id_korpe = rs_korpa.getInt("korpa_id"); // ako postoji uzmi njen id
            }
            
            if (id_korpe == -1) // ako ne postoji napravi
            {
                Base.getConnection().createStatement().execute("INSERT INTO Korpa (kor_id, placeno) VALUES ("+korisnik+", false)"); // pravi je
                
               // nakon ston je napravis uzmi njen id
                
                rs_korpa = Base.getConnection().createStatement().executeQuery("SELECT * FROM Korpa WHERE kor_id = " + korisnik + " AND placeno = false");
                while(rs_korpa.next())
                {
                    id_korpe = rs_korpa.getInt("korpa_id");
                }
            }
            
            Base.getConnection().createStatement().execute("INSERT INTO StavkaKorpe (korpa_id, art_id) VALUES ("+id_korpe+","+art_id+")");// dodaj novu stavku korpe
          
            response.getWriter().write("Artikal uspesno dodat u korpu!");
             // ispisi poruku
        } catch (Exception ex) {
           response.getWriter().write("Doslo je do greske, molimo probajte kasnije!");
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
