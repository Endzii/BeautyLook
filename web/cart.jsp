<%-- 
    Document   : cart.jsp
    Created on : Sep 2, 2018, 1:11:47 PM
    Author     : anci
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="db.Base"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cart | BeautyLook</title>
        <link rel="stylesheet" href="css/style.css" type="text/css">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css" integrity="sha384-hWVjflwFxL6sNzntih27bfxkr27PmbbK/iSvJ+a4+0owXq79v+lsFkW54bOGbiDQ" crossorigin="anonymous">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
    </head>
    <body>        
        <% // ako u parametrima postoji parametar greska  proveri njegovu vrednost i ispisi odg poruku
            if(request.getParameter("greska") != null)
            {
                if (request.getParameter("greska").equals("1"))
                {
                    %><script>alert("Greska pri brisanju iz korpe! Molimo pokusajte kasnije!");</script><%
                } else if (request.getParameter("greska").equals("2")) {
                    %><script>alert("Greska pri placanju! Molimo pokusajte kasnije!");</script><%
                }
            }
        %>
        <div style="font-size: 1.1em; margin-top: 35px; height: 40px; line-height: 40px; border-radius: 10px; width: 200px; float: right; margin-right: 25px; text-align: center; background: rgba(255,255,255, 0.9);" class="text-success">
            <a href="store.jsp" style="margin-right: 30px"><i class="fa fa-arrow-circle-left text-success"></i></a>
            <%=session.getAttribute("username")%>
            <a href="cart.jsp" style="margin-left: 15px"><i class="fa fa-shopping-cart text-success"></i></a>
            <a href="logout" style="margin-left: 15px"><i class="fa fa-sign-out-alt text-success"></i></a>
        </div>
            
            <nav style="padding: 20px; background-color: rgba(255,240,207,0.5); height: 120px; display: block; clear: left">
            <a href="store.jsp" style="text-decoration: none; color: black"><h1 style="width: 40%; float: left; text-decoration: blink; font-family: fantasy; font-style: oblique; font-size: 4.5em">BeautyLook</h1></a>
            </nav>
            
            <div class="container">
                <% 
                    Connection con = Base.getConnection();
                    // pronadji korpu korisnika
                    ResultSet rs_korpa = con.createStatement().executeQuery("SELECT * FROM Korpa WHERE kor_id = " + session.getAttribute("id") + " AND placeno = false");
            
                    int id_korpe = -1;

                    while(rs_korpa.next())
                    {
                        id_korpe = rs_korpa.getInt("korpa_id");
                    }
                    
                    if (id_korpe == -1) // ukoliko nema korpe korisnika, ispisi poruku da mu je korpa prazna
                    {
                %>
                <div class="row">
                        <div class="col-md-12" style="padding: 15px; border: 1px solid pink; text-align: center; background: rgba(255, 255, 255, 0.9); height: 70px; margin-top: 20px; border-radius: 12px;">
                            <h3>Vasa korpa je prazna, posetite stranicu <a href="store.jsp">store</a> da biste poceli sa kupovinom!</h3>
                        </div>
                </div>
                <%  } else { // ako postoji korpa korisnika
                        // ucitaj stavke korisnikove korpe
                        ResultSet rs_stavke = con.createStatement().executeQuery("SELECT * FROM StavkaKorpe WHERE korpa_id = " + id_korpe);

                        boolean prazna = true; // proverava da li je korpa prazna
                        
                        int ukupno = 0;

                        while(rs_stavke.next()) // za svaku stavku
                        {
                            prazna = false; // cim postoji makar jedna stavka, korpa nije prazna
                            // ucitaj podatke o artiklu te stavke
                            ResultSet rs_artikal = con.createStatement().executeQuery("SELECT * FROM Artikal WHERE art_id = " + rs_stavke.getInt("art_id"));
                            
                            rs_artikal.first(); // daje nam da citamo samo podatke prvog reda (artikla) iz baze

                            ukupno += rs_artikal.getInt("cena"); // cenu artikla sabiramo na ukupno za kasniji prikaz
                            // ucitaj podatke o brendu tog artikla
                            ResultSet rs_brend = con.createStatement().executeQuery("SELECT * FROM Brendovi WHERE brend_id = " + rs_artikal.getInt("brend_id"));

                            rs_brend.first();
                            %> 
                            <div class="row">
                                <div class="col-md-8" style="padding: 15px; border: 1px solid pink; text-align: center; background: rgba(255, 255, 255, 0.9); height: 60px; margin-top: 20px; border-radius: 12px;">
                                    <b style="float: left;"><%=rs_artikal.getString("naziv")%></b>
                                    <i style="float: left; margin-left: 50px;"><%=rs_brend.getString("naziv")%></i>
                                    <b class="text-success" style="float: right;"><%=rs_artikal.getInt("cena")%> RSD</b>
                                </div>
                                <div class="col-md-1" style="font-size: 1.5em; line-height: 60px; border: 1px solid pink; text-align: center; background: rgba(255, 255, 255, 0.9); height: 60px; margin-top: 20px; border-radius: 12px;">
                                    <a href="RemoveCart?art_id=<%=rs_artikal.getInt("art_id")%>&korpa_id=<%=id_korpe%>"><i class="fa fa-times-circle text-danger"></i></a>
                                </div> <!-- iksic -->
                            </div>
                            <%
                        }

                        if (prazna) // ako je prazna korpa opet ispisi poruku
                        {
                        %>
                        <div class="row">
                                <div class="col-md-12" style="padding: 15px; border: 1px solid pink; text-align: center; background: rgba(255, 255, 255, 0.9); height: 70px; margin-top: 20px; border-radius: 12px;">
                                    <h3>Vasa korpa je prazna, posetite stranicu <a href="store.jsp">store</a> da biste poceli sa kupovinom!</h3>
                                </div>
                        </div>
                        <%
                        } else { // ako nije prazna ispisi i dugme za dovrsavanje kupovine
                            %>
                            <div class="row">
                                <div class="col-md-9" style="padding: 15px; border: 1px solid pink; text-align: center; background: rgba(255, 255, 255, 0.9); height: 110px; margin-top: 20px; border-radius: 12px;">
                                    <h4 class="text-success">Ukupno: <%=ukupno%> RSD</h4>
                                    <a href="BuyCart?korpa_id=<%=id_korpe%>" class="btn btn-outline-success" style="width: 300px; height: 40px" >Dovrsi kupovinu</a>
                                </div>
                            </div>
                            <%
                        }
                    }
                %>
            </div>
    </body>
</html>
