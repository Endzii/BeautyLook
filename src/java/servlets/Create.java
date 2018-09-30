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
@WebServlet(name = "Create", urlPatterns = {"/Create"})
public class Create extends HttpServlet {

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
        
        request.setCharacterEncoding("UTF-8");
        String tip = request.getParameter("tip");
        
        if (tip.equals("brend"))
        {
            try {
                String brend_naziv = request.getParameter("brend_naziv");
                
                Base.getConnection().createStatement().execute("INSERT INTO brendovi (naziv) VALUE ('"+brend_naziv+"')");
            
                RequestDispatcher dispatcher = request.getRequestDispatcher("panel.jsp?porukaa=1");
                dispatcher.forward(request, response);
            } catch (Exception ex) {
                Logger.getLogger(Create.class.getName()).log(Level.SEVERE, null, ex);
            
                RequestDispatcher dispatcher = request.getRequestDispatcher("panel.jsp?porukaa=2");
                dispatcher.forward(request, response);
            } 
        } else if(tip.equals("kat"))
        {
            try {
                String kat_naziv = request.getParameter("kat_naziv");
                
                Base.getConnection().createStatement().execute("INSERT INTO kategorija (opis) VALUE ('"+kat_naziv+"')");
            
                RequestDispatcher dispatcher = request.getRequestDispatcher("panel.jsp?porukaa=1");
                dispatcher.forward(request, response);
            } catch (Exception ex) {
                Logger.getLogger(Create.class.getName()).log(Level.SEVERE, null, ex);
            
                RequestDispatcher dispatcher = request.getRequestDispatcher("panel.jsp?porukaa=2");
                dispatcher.forward(request, response);
            } 
        } else if(tip.equals("podk"))
        {
            try {
                String podk_naziv = request.getParameter("podk_naziv");
                
                Base.getConnection().createStatement().execute("INSERT INTO podkategorija (opis) VALUE ('"+podk_naziv+"')");
            
                RequestDispatcher dispatcher = request.getRequestDispatcher("panel.jsp?porukaa=1");
                dispatcher.forward(request, response);
            } catch (Exception ex) {
                Logger.getLogger(Create.class.getName()).log(Level.SEVERE, null, ex);
            
                RequestDispatcher dispatcher = request.getRequestDispatcher("panel.jsp?porukaa=2");
                dispatcher.forward(request, response);
            } 
        }else if(tip.equals("art"))
        {
            try {
                String art_naziv = request.getParameter("art_naziv");
                String cena = request.getParameter("art_cena");                
                String slika = request.getParameter("art_slika");
                String brend = request.getParameter("art_brend");
                String kat = request.getParameter("art_kat");
                String podk = request.getParameter("art_podk");
                String opis = request.getParameter("art_opis");
                
                System.out.println("INSERT INTO artikal (naziv, brend_id, kat_id, cena, podk_id, opis, slika)"
                        + " VALUE ('"+art_naziv+"',"+brend+","+kat+","+cena+","+podk+",'"+opis+"','"+slika+"')");
                
                Base.getConnection().createStatement().execute("INSERT INTO artikal (naziv, brend_id, kat_id, cena, podk_id, opis, slika)"
                        + " VALUE ('"+art_naziv+"',"+brend+","+kat+","+cena+","+podk+",'"+opis+"','"+slika+"')");
            
                RequestDispatcher dispatcher = request.getRequestDispatcher("panel.jsp?porukaa=1");
                dispatcher.forward(request, response);
            } catch (Exception ex) {
                Logger.getLogger(Create.class.getName()).log(Level.SEVERE, null, ex);
            
                RequestDispatcher dispatcher = request.getRequestDispatcher("panel.jsp?porukaa=2");
                dispatcher.forward(request, response);
            } 
        } else if (tip.equals("naj"))
        {
            try {
                String b1 = request.getParameter("b1");
                String b2 = request.getParameter("b2");
                String b3 = request.getParameter("b3");
                String b4 = request.getParameter("b4");
                
                // Ocisti stare najpopularnije proizvode
                Base.getConnection().createStatement().execute("TRUNCATE najpopularnije");
                
                // Popuni tabelu najpopularniji sa cetiri nova najpopularnija predmeta
                Base.getConnection().createStatement().execute("INSERT INTO najpopularnije (art_id) VALUES ("+b1+")");
                Base.getConnection().createStatement().execute("INSERT INTO najpopularnije (art_id) VALUES ("+b2+")");
                Base.getConnection().createStatement().execute("INSERT INTO najpopularnije (art_id) VALUES ("+b3+")");
                Base.getConnection().createStatement().execute("INSERT INTO najpopularnije (art_id) VALUES ("+b4+")");
                
                response.setContentType("text/plain");
                response.getWriter().write("Uspesno ste postavili nove najprodavanije proizvode!");
            } catch (Exception ex) {
                Logger.getLogger(Create.class.getName()).log(Level.SEVERE, null, ex);
                
                response.setContentType("text/plain");
                response.getWriter().write("Greska pri postavljanju novih najprodavanijih proizvoda!");
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
