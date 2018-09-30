<%-- 
    Document   : store
    Created on : Aug 28, 2018, 3:40:57 PM
    Author     : anci
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="db.Base"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta charset="UTF-8">
        <title>Store | BeautyLook</title>
        <link rel="stylesheet" href="css/style.css" type="text/css">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css" integrity="sha384-hWVjflwFxL6sNzntih27bfxkr27PmbbK/iSvJ+a4+0owXq79v+lsFkW54bOGbiDQ" crossorigin="anonymous">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
    </head>
    <body>
        <%
            if (request.getParameter("poruka") != null)
            {
                if(request.getParameter("poruka").equals("1"))
                {
                    %><script>alert('Uspesno ste izvrsili kupovinu! Hvala vam na poverenju!');</script><%
                }
            }
        %>
        <div style="font-size: 1.1em; margin-top: 35px; height: 40px; line-height: 40px; border-radius: 10px; width: 200px; float: right; margin-right: 25px; text-align: center; background: rgba(255,255,255, 0.9);" class="text-success">
            <%=session.getAttribute("username")%>
            <% if (session.getAttribute("tip").toString().equals("2")) { %>
            <% // ako nije admin nego korisnik prebroj sve sto ima u korpi i ispisi
                int u_korpi = 0;
                
                ResultSet rs_artikli2 = Base.getConnection().createStatement().executeQuery("SELECT * FROM Artikal");

                 while(rs_artikli2.next()) {

                     ResultSet rs_ukorpi2 = Base.getConnection().createStatement().executeQuery("SELECT * FROM"
                             + " Korpa JOIN StavkaKorpe ON Korpa.korpa_id = StavkaKorpe.korpa_id WHERE"
                             + " Korpa.placeno = 0 AND StavkaKorpe.art_id = " + rs_artikli2.getInt("art_id") + " AND"
                                     + " Korpa.kor_id = " + session.getAttribute("id"));

                     while(rs_ukorpi2.next())
                     {
                         u_korpi++;
                     }
                 }
            %>
            <a href="cart.jsp" style="margin-left: 15px;" class="text-success"> <%=u_korpi%> <i class="fa fa-shopping-cart text-success"></i></a>
            <% } else { %>
            <a href="panel.jsp" style="margin-left: 15px"><i class="fa fa-chalkboard-teacher text-success"></i></a>
            <% } %>
            <a href="logout" style="margin-left: 15px"><i class="fa fa-sign-out-alt text-success"></i></a>
        </div>
            
            <nav style="padding: 20px; background-color: rgba(255,240,207,0.5); height: 120px; display: block; clear: left">
            <h1 style="width: 40%; float: left; text-decoration: blink; font-family: fantasy; font-style: oblique;">BeautyLook</h1>
            <div class="btn-group" style="clear: left; float: left; margin-bottom: 5px">

            <a class="btn btn-light dropdown-toggle" href="#" role="button" id="dropdownMenuLink1" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                Brendovi
            </a>

            <div class="dropdown-menu" aria-labelledby="dropdownMenuLink1">
                <%
                    Connection con = Base.getConnection();
                    
                    ResultSet rs_brendovi = con.createStatement().executeQuery("SELECT * FROM Brendovi");
                    
                    while(rs_brendovi.next())
                    {
                %>
                    <a class="dropdown-item" href="store.jsp?brend=<%=rs_brendovi.getInt("brend_id")%>"> <%=rs_brendovi.getString("naziv")%> </a>
                <%
                    }
                %>
            </div>

        </div>

        <div class="btn-group" style="float: left">
            <a class="btn btn-light dropdown-toggle" href="#" role="button" id="dropdownMenuLink2" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="margin-left: 8px">
                Kategorije
            </a>

            <div class="dropdown-menu" aria-labelledby="dropdownMenuLink2">
                <%
                    ResultSet rs_kategorije = con.createStatement().executeQuery("SELECT * FROM Kategorija");
                    
                    while(rs_kategorije.next())
                    {
                %>
                    <a class="dropdown-item" href="store.jsp?kat=<%=rs_kategorije.getInt("kat_id")%>"> <%=rs_kategorije.getString("opis")%> </a>
                <%
                    }
                %>
             </div>

        </div>
        
        <div class="btn-group" style="float: left">
            <a class="btn btn-light dropdown-toggle" href="#" role="button" id="dropdownMenuLink2" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="margin-left: 8px">
                Podkategorije
            </a>

            <div class="dropdown-menu" aria-labelledby="dropdownMenuLink2">
                <%
                    ResultSet rs_podkategorije = con.createStatement().executeQuery("SELECT * FROM Podkategorija");
                    
                    while(rs_podkategorije.next())
                    {
                %>
                    <a class="dropdown-item" href="store.jsp?podk=<%=rs_podkategorije.getInt("podk_id")%>"> <%=rs_podkategorije.getString("opis")%> </a>
                <%
                    }
                %>
             </div>

        </div>

        <div style="float: left; margin-left: 10px;">
            <a href="store.jsp" class="btn btn-light">Svi artikli</a>
        </div>
    </nav>
             
             <div class="container">
                 <div class="row" style="margin-top:35px; border: 2px inset #5cb85c; border-radius: 10px; padding: 30px; background: rgba(255,255,255,0.9); text-align: center;">
                     <h4 style="width:100%; text-align: center; margin-bottom: 20px; color: #5cb85c;">Najpopularnije!</h4>
                     <%
                         ResultSet rs_naj = con.createStatement().executeQuery("SELECT * FROM najpopularnije"); // uzima sve iz najpopularnijih
                         
                         while(rs_naj.next()){ // za svaki od najpopularnjih artikala
                            // izvuci sve informacije o artiklu sa tim id-jem
                            ResultSet rs_artikal = con.createStatement().executeQuery("SELECT * FROM artikal WHERE art_id = " + rs_naj.getInt("art_id"));
                             
                            rs_artikal.first();

                            // izvuci na osnovu brend_id naziv brenda artikla
                            String brend = "";

                            rs_brendovi = con.createStatement().executeQuery("SELECT * FROM Brendovi WHERE brend_id = " + rs_artikal.getInt("brend_id"));

                            while (rs_brendovi.next()) { brend = rs_brendovi.getString("naziv"); }
                            
                     %>
                        <!-- data-toggle="tooltip" i title="opis" sluze da na hover artikla izace mali popup sa opisom -->
                        <div class="col-md-3"  data-toggle="tooltip" title="<%=rs_artikal.getString("opis")%>" style="text-align: center;">
                            <%=rs_artikal.getString("naziv")%>
                            <br/>
                            <%=brend%>
                            <br/><br/>
                            <img src="images/<%=rs_artikal.getString("slika")%>" style="width: 60%; max-width: 150px; max-height: 150px; min-width: 143px; min-height: 143px; height: auto;">
                            <br/><br/>
                            <% 
                                // Da li vec postoji artikal u korpi ulogovanog korisnika
                                ResultSet rs_ukorpii = con.createStatement().executeQuery("SELECT * FROM"
                                         + " Korpa JOIN StavkaKorpe ON Korpa.korpa_id = StavkaKorpe.korpa_id WHERE"
                                         + " Korpa.placeno = 0 AND StavkaKorpe.art_id = " + rs_artikal.getInt("art_id") + " AND"
                                         + " Korpa.kor_id = " + session.getAttribute("id"));

                                 boolean ima_u_korpi = false; // ne postoji u korpi

                                 while(rs_ukorpii.next()) // ako je baza vratila nesto
                                 {
                                     ima_u_korpi = true; // ocigledno postoji u korpi
                                 }
                                if (ima_u_korpi) { //dugme na kome pise u korpi je  
                            %>
                                <button class="btn btn-success" disabled="" style="width: 200px;">U korpi</button>
                            <% } else { 
                                if (session.getAttribute("tip").toString().equals("2")) {// da li je korisnik admin ili ne 
                                // ako nije admin onda se pojavljuje dugme da doda u korpu
                            %>
                                <button onclick="return addToCart(<%=rs_artikal.getInt("art_id")%>)" class="btn btn-outline-success" style="width: 200px;"><i class="fa fa-cart-plus" style="margin-right: 5px"></i> <%=rs_artikal.getInt("cena")%> RSD</button>
                            <%
                                } else { // ako je admin onda se pojavljuje dugme sa cenom koje ne reguje
                            %>  
                            <button class="btn btn-outline-success" style="width: 200px;" disabled=""><%=rs_artikal.getInt("cena")%> RSD</button>
                            <%  }
                            }
                            %>
                        </div>
                     <%}%>
                 </div>
                 <div class="row" style="margin-top: 35px;">
                     <%
                         int i = 0;
                         
                         // isto ispisivanje artikala kao najpopularnijih ali sad svi artikli treba da se ispisu
                         ResultSet rs_artikli = con.createStatement().executeQuery("SELECT * FROM Artikal");
                         
                         while(rs_artikli.next()) {
                             String brendfilter = request.getParameter("brend"); // izvlacimo iz URL adrese parametre za filtriranje
                             String katfilter = request.getParameter("kat");
                             String podkfilter = request.getParameter("podk");
                             
                             ResultSet rs_ukorpi = con.createStatement().executeQuery("SELECT * FROM"
                                     + " Korpa JOIN StavkaKorpe ON Korpa.korpa_id = StavkaKorpe.korpa_id WHERE"
                                     + " Korpa.placeno = 0 AND StavkaKorpe.art_id = " + rs_artikli.getInt("art_id") + " AND"
                                             + " Korpa.kor_id = " + session.getAttribute("id"));
                             
                             boolean ima_u_korpi = false;
                             
                             while(rs_ukorpi.next())
                             {
                                 ima_u_korpi = true;
                             }
                             
                             boolean dobra = true;//  promenljiva oznacava dal je trenutni artikal odgivara filterima
                             
                             if (brendfilter != null){ // ako neki od filtera nije null .. ako nijedan od filtera ne postoji
                                 if (Integer.parseInt(brendfilter) != rs_artikli.getInt("brend_id")) // poredimo vrednost filtera i artikla
                                 {
                                     dobra = false;
                                 }
                             }
                             
                             if (katfilter != null){
                                 if (Integer.parseInt(katfilter) != rs_artikli.getInt("kat_id"))
                                 {
                                     dobra = false;
                                 }
                             }
                             
                             if (podkfilter != null){
                                 if (Integer.parseInt(podkfilter) != rs_artikli.getInt("podk_id"))
                                 {
                                     dobra = false;
                                 }
                             }
                             
                             if (dobra == true)
                             {
                             String brend = "";
                             
                             rs_brendovi = con.createStatement().executeQuery("SELECT * FROM Brendovi WHERE brend_id = " + rs_artikli.getInt("brend_id"));
                             
                             while (rs_brendovi.next()) { brend = rs_brendovi.getString("naziv"); }
                            %> 
                             <div data-toggle="tooltip" title="<%=rs_artikli.getString("opis")%>" class="artikal col-md-3" style="border-radius: 10px; border: 1px inset pink; padding: 10px; height: 320px; text-align: center; background: rgba(255,255,255, 0.9); color: black">
                                 <%=rs_artikli.getString("naziv")%>
                                 <br/>
                                 <%=brend%>
                                 <br/><br/>
                                 <img src="images/<%=rs_artikli.getString("slika")%>" style="width: 60%; max-width: 150px; max-height: 150px; min-width: 143px; min-height: 143px; height: auto;">
                                 <br/><br/>
                                 <% if (ima_u_korpi) { %>
                                 <button class="btn btn-success" disabled="" style="width: 200px;">U korpi</button>
                                 <% } else { 
                                    if (session.getAttribute("tip").toString().equals("2")) {
                                 %>
                                 <button onclick="return addToCart(<%=rs_artikli.getInt("art_id")%>)" class="btn btn-outline-success" style="width: 200px;"><i class="fa fa-cart-plus" style="margin-right: 5px"></i> <%=rs_artikli.getInt("cena")%> RSD</button>
                                 <% } else {
                                %>  <button class="btn btn-outline-success" style="width: 200px;" disabled=""><%=rs_artikli.getInt("cena")%> RSD</button><%
                                    }
                                }
                                 %>
                             </div> 
                            <%
                             i++;
                             if (i == 4)
                             {
                                 %></div><div class="row" style="margin-top: 20px;"><% //novi red bootstrap nakon 4 artikla
                                 i = 0;
                             }
                            }
                         }
                     %>
                </div>
             </div>
            
    <script src="https://code.jquery.com/jquery-3.3.1.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
    <script src="https://getbootstrap.com/docs/4.0/dist/js/bootstrap.min.js"></script>

    <script>
        var addToCart = function(id)
        {
            $.post(
                    "AddCart", // sa servletom add to cart
                    {"art_id": id}, // kao parametar servletu salje se id artikla
                    function(odgovor){ alert(odgovor); window.location.href = "store.jsp"; } // kad srvlet odgovvori prikazi poruku na ekranu i osvezi stranicu
                );
        }

        // omogucava sve popup-e
        $(document).ready(function(){
            $('[data-toggle="tooltip"]').tooltip(); 
        });

    </script>
    </body>
</html>
