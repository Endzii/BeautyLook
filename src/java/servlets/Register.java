/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import db.Base;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
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
@WebServlet(name = "register", urlPatterns = {"/register"})
public class Register extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     * @throws java.lang.ClassNotFoundException
     * @throws java.sql.SQLException
     * @throws java.lang.InstantiationException
     * @throws java.lang.IllegalAccessException
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException, SQLException, InstantiationException, IllegalAccessException {
        String user = request.getParameter("username"); // Citamo zapakovane podatke iz forme sa register.jsp
        String pass = request.getParameter("pass");
        String email = request.getParameter("email");
        String rpass = request.getParameter("rpass");
        
        boolean sve_ok = true; // promenljiva sve_ok koja pokazuje da li je nakon provera sve dobro
        
        // ako se NE podudaraju
        if (!pass.equals(rpass)) // provera da li se sifre iz forme podudaraju (ovo je true ako se NE podudaraju)
        {
            sve_ok = false; // nije sve ok
            RequestDispatcher dispatcher = request.getRequestDispatcher("register.jsp?greska=1"); // vrati na stranu register sa porukom sta ne valja
            dispatcher.forward(request, response);
        }
        
        // probaj da selektujes sve korisnike sa istim username-om iz baze
        ResultSet rs = Base.getConnection().createStatement().executeQuery("SELECT * FROM korisnik WHERE username = '" + user + "'");
    
        if(rs.first()) // ako postoji makar jedan (a trebalo bi samo jedan) korisnik sa tim username-om
        {
            sve_ok = false; // nije sve ok
            RequestDispatcher dispatcher = request.getRequestDispatcher("register.jsp?greska=2"); // vrati na stranu register sa porukom sta ne valja
            dispatcher.forward(request, response);
        }
        
        if (sve_ok){ // ako je nakon provera sve ok
            Base.getConnection().createStatement().execute("INSERT INTO korisnik (username, password, email, tipk_id) "
                    + "VALUES ('"+user+"','"+pass+"','"+email+"', 2)"); // dodaj novog korisnika u bazu
            //                                                    ^ ovo dva oznacava da je nov korisnik uvek samo posetilac a ne admin
            RequestDispatcher dispatcher = request.getRequestDispatcher("index.jsp?poruka=1"); // preusmeri korisnika na login sa porukom da se uspesno registrovao
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
        try{
        processRequest(request, response);
        } catch (Exception ex)
        {}
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
        try{
        processRequest(request, response);
        } catch (Exception ex)
        {}
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
