<%-- 
    Document   : panel
    Created on : Sep 3, 2018, 6:57:26 PM
    Author     : anci
--%>

<%@page import="db.Base"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Panel | BeautyLook</title>
        <link rel="stylesheet" type="text/css" href="css/style.css">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css" integrity="sha384-hWVjflwFxL6sNzntih27bfxkr27PmbbK/iSvJ+a4+0owXq79v+lsFkW54bOGbiDQ" crossorigin="anonymous">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
    
        
        <script src="https://code.jquery.com/jquery-3.3.1.js"></script>
        <script>
            function najpopularniji()
            {
                var total=$("input[type=checkbox]:checked").length; // koliko ima chekiranih checkboxova
                
                if (total != 4) // ako nije 4
                {
                    alert('Morate izabrati tacno 4 artikla!'); // poruka
                } else {
                    // ako jeste cetiri, iz njihovih id-jeva izvuci id artikla za koji su vezani
                    var box1 = $("input[type=checkbox]:checked")[0].id.replace('chk-','');
                    
                    var box2 = $("input[type=checkbox]:checked")[1].id.replace('chk-','');
                    
                    var box3 = $("input[type=checkbox]:checked")[2].id.replace('chk-','');
                    
                    var box4 = $("input[type=checkbox]:checked")[3].id.replace('chk-','');
                    
                    $.post(
                            "Create",
                            {"tip": "naj", "b1" : box1, "b2" : box2, "b3" : box3, "b4" : box4},
                            function(odgovor)
                            {
                                alert(odgovor);
                            }
                    );
                }
            }
        </script>
        <script> <!-- da prikaze izabrano iz nav bara -->
            function showBrendovi(){
                document.getElementById('divBrendovi').hidden = false;
                document.getElementById('divKategorije').hidden = true;
                document.getElementById('divPodkategorije').hidden = true;
                document.getElementById('divArtikli').hidden = true;
                document.getElementById('divNajprodavaniji').hidden = true;
            }
            function showKategorije(){
                document.getElementById('divBrendovi').hidden = true;
                document.getElementById('divKategorije').hidden = false;
                document.getElementById('divPodkategorije').hidden = true;
                document.getElementById('divArtikli').hidden = true;
                document.getElementById('divNajprodavaniji').hidden = true;
            }
            function showPodkategorije(){
                document.getElementById('divBrendovi').hidden = true;
                document.getElementById('divKategorije').hidden = true;
                document.getElementById('divPodkategorije').hidden = false;
                document.getElementById('divArtikli').hidden = true;
                document.getElementById('divNajprodavaniji').hidden = true;
            }
            function showArtikli(){
                document.getElementById('divBrendovi').hidden = true;
                document.getElementById('divKategorije').hidden = true;
                document.getElementById('divPodkategorije').hidden = true;
                document.getElementById('divArtikli').hidden = false;
                document.getElementById('divNajprodavaniji').hidden = true;
            }
            function showNajprodavaniji(){
                document.getElementById('divBrendovi').hidden = true;
                document.getElementById('divKategorije').hidden = true;
                document.getElementById('divPodkategorije').hidden = true;
                document.getElementById('divArtikli').hidden = true;
                document.getElementById('divNajprodavaniji').hidden = false;
            }
        </script>
    </head>
    <body> <!-- Poruke hvatamo, uspesno si dodao, uspesno si obrisao... -->
        <%
            if (request.getParameter("poruka") != null)
            {
                if (request.getParameter("poruka").equals("1"))
                {
                    %><script>alert("Uspesno ste obrisali stavku!");</script><%
                } else if (request.getParameter("poruka").equals("2"))
                {
                    %><script>alert("Greska pri brisanju stavke!");</script><%
                }
            }

            if (request.getParameter("porukaa") != null)
            {
                if (request.getParameter("porukaa").equals("1"))
                {
                    %><script>alert("Uspesno ste dodali stavku!");</script><%
                } else if (request.getParameter("porukaa").equals("2"))
                {
                    %><script>alert("Greska pri dodavanju stavke!");</script><%
                }
            }
        %>
        
        <!--  desno u cosku -->
        <div style="font-size: 1.1em; margin-top: 35px; height: 40px; line-height: 40px; border-radius: 10px; width: 200px; float: right; margin-right: 25px; text-align: center; background: rgba(255,255,255, 0.9);" class="text-success">
            <a href="store.jsp" style="margin-right: 30px"><i class="fa fa-arrow-circle-left text-success"></i></a>
            <%=session.getAttribute("username")%>
            <a href="panel.jsp" style="margin-left: 15px"><i class="fa fa-chalkboard-teacher text-success"></i></a>
            <a href="logout" style="margin-left: 15px"><i class="fa fa-sign-out-alt text-success"></i></a>
        </div>
            
            <nav style="padding: 20px; background-color: rgba(255,240,207,0.5); height: 120px; display: block; clear: left">
            <a href="store.jsp" style="text-decoration: none; color: black"><h1 style="width: 40%; float: left; text-decoration: blink; font-family: fantasy; font-style: oblique;">BeautyLook</h1></a>
            
            <button onclick="showBrendovi()" class="btn btn-light" style="clear:left; float: left; margin-left: 8px; width: 150px">Brendovi</button>
            
            <button onclick="showKategorije()" class="btn btn-light" style="float: left; margin-left: 8px; width: 150px">Kategorije</button>
            
            <button onclick="showPodkategorije()" class="btn btn-light" style="float: left; margin-left: 8px; width: 150px">Podkategorije</button>
            
            <button onclick="showArtikli()" class="btn btn-light" style="float: left; margin-left: 8px; width: 150px">Artikli</button>
            
            <button onclick="showNajprodavaniji()" class="btn btn-light" style="float: left; margin-left: 8px; width: 150px">Najpopularniji</button>
            </nav>
            <div class="container">
            <div id="divBrendovi" hidden>
                <h2 style="margin-top: 20px; margin-left: 20px;">Brendovi:</h2>
                <hr/>
                <form method="post" action="Create" style="height: 200px; width: 100%; margin: 0; padding: 15px; border: 1px solid pink; text-align: center; background: rgba(255, 255, 255, 0.9); border-radius: 12px;">
                    <b>Naziv brenda:</b><br/><br/>
                    <input type="text" name="tip" value="brend" hidden/>
                    <input type="text" name="brend_naziv" placeholder="Naziv brenda" style="text-align: center"/><br/><br/>
                    <input type="submit" class="btn btn-outline-primary" style="width: 250px;" value="Dodaj brend"/>
                </form>
                <hr/>
                <% ResultSet rs_brendovi = Base.getConnection().createStatement().executeQuery("SELECT * FROM brendovi");
                    while (rs_brendovi.next()) { // brndovi iz baze, za svaki novi red
                %>
                <div class="row">
                    <div class="col-md-11" style="padding: 15px; border: 1px solid pink; text-align: center; background: rgba(255, 255, 255, 0.9); height: 60px; margin-top: 5px; border-radius: 12px;">
                        <%=rs_brendovi.getString("naziv")%>
                    </div>
                    <div class="col-md-1" style="font-size: 1.5em; line-height: 60px; border: 1px solid pink; text-align: center; background: rgba(255, 255, 255, 0.9); height: 60px; margin-top: 5px; border-radius: 12px;">
                        <a href="Delete?tip=brend&brend_id=<%=rs_brendovi.getInt("brend_id")%>"><i class="fa fa-times-circle text-danger"></i></a>
                    </div>
                </div> 
                <%
                    }
                %>
            </div>
            
            <div id="divKategorije" hidden>
                <h2 style="margin-top: 20px; margin-left: 20px;">Kategorije:</h2>
                <hr/>
                <form method="post" action="Create" style="height: 200px; width: 100%; margin: 0; padding: 15px; border: 1px solid pink; text-align: center; background: rgba(255, 255, 255, 0.9); border-radius: 12px;">
                    <b>Naziv kategorije:</b><br/><br/>
                    <input type="text" name="tip" value="kat" hidden/>
                    <input type="text" name="kat_naziv" placeholder="Naziv kategorije" style="text-align: center"/><br/><br/>
                    <input type="submit" class="btn btn-outline-primary" style="width: 250px;" value="Dodaj kategoriju"/>
                </form>
                <hr/>
                 <% ResultSet rs_kategorije = Base.getConnection().createStatement().executeQuery("SELECT * FROM kategorija");
                    while (rs_kategorije.next()) {
                %>
                <div class="row">
                    <div class="col-md-11" style="padding: 15px; border: 1px solid pink; text-align: center; background: rgba(255, 255, 255, 0.9); height: 60px; margin-top: 5px; border-radius: 12px;">
                        <%=rs_kategorije.getString("opis")%>
                    </div>
                    <div class="col-md-1" style="font-size: 1.5em; line-height: 60px; border: 1px solid pink; text-align: center; background: rgba(255, 255, 255, 0.9); height: 60px; margin-top: 5px; border-radius: 12px;">
                        <a href="Delete?tip=kat&kat_id=<%=rs_kategorije.getInt("kat_id")%>"><i class="fa fa-times-circle text-danger"></i></a>
                    </div>
                </div> 
                <%
                    }
                %>
            </div>
            
            <div id="divPodkategorije" hidden>
                <h2 style="margin-top: 20px; margin-left: 20px;">Podkategorije:</h2>
                <hr/>
                
                <form method="post" action="Create" style="height: 200px; width: 100%; margin: 0; padding: 15px; border: 1px solid pink; text-align: center; background: rgba(255, 255, 255, 0.9); border-radius: 12px;">
                    <b>Naziv podkategorije:</b><br/><br/>
                    <input type="text" name="tip" value="podk" hidden/>
                    <input type="text" name="podk_naziv" placeholder="Naziv podkategorije" style="text-align: center"/><br/><br/>
                    <input type="submit" class="btn btn-outline-primary" style="width: 250px;" value="Dodaj podkategoriju"/>
                </form>
                <hr/>
                 <% ResultSet rs_podkategorije = Base.getConnection().createStatement().executeQuery("SELECT * FROM podkategorija");
                    while (rs_podkategorije.next()) {
                %>
                <div class="row">
                    <div class="col-md-11" style="padding: 15px; border: 1px solid pink; text-align: center; background: rgba(255, 255, 255, 0.9); height: 60px; margin-top: 5px; border-radius: 12px;">
                        <%=rs_podkategorije.getString("opis")%>
                    </div>
                    <div class="col-md-1" style="font-size: 1.5em; line-height: 60px; border: 1px solid pink; text-align: center; background: rgba(255, 255, 255, 0.9); height: 60px; margin-top: 5px; border-radius: 12px;">
                        <a href="Delete?tip=podk&podk_id=<%=rs_podkategorije.getInt("podk_id")%>"><i class="fa fa-times-circle text-danger"></i></a>
                    </div>
                </div> 
                <%
                    }
                %>
            </div>
            
            <div id="divArtikli" hidden style="overflow: hidden;">
                <h2 style="margin-top: 20px; margin-left: 20px;">Artikli:</h2>
                <hr/>    
                <form id="forma" method="post" action="Create" style="width: 100%; height:auto; margin: 0; padding: 15px; border: 1px solid pink; text-align: center; background: rgba(255, 255, 255, 0.9); border-radius: 12px;">
                    <div style="float: left; margin-left: 30%">
                        <b>Naziv artikla:</b><br/><br/>
                        <input type="text" name="tip" value="art" hidden/>
                        <input type="text" name="art_naziv" placeholder="Naziv artikla" style="text-align: center"/>
                    </div>
                    <div style="float: right; margin-right: 30%">
                        <b>Cena artikla:</b><br/><br/>
                        <input type="text" name="art_cena" placeholder="0" style="text-align:center"/>
                    </div>
                    
                    <div style="float: left; margin-left: 20%; width: 201px; margin-top: 20px;">
                        <b>Brend:</b><br/><br/>
                        <select name="art_brend" style="text-align:center">
                            <% rs_brendovi.beforeFirst();
                                while(rs_brendovi.next()) {
                            %>
                            <option value="<%=rs_brendovi.getInt("brend_id")%>"><%=rs_brendovi.getString("naziv")%></option>
                            <%}%>
                        </select>
                    </div>
                    <div style="float: left; margin-left: 30px; width: 201px; margin-top: 20px;">
                        <b>Kategorija:</b><br/><br/>
                        <select name="art_kat" style="text-align:center">
                            <% rs_kategorije.beforeFirst();
                                while(rs_kategorije.next()) {
                            %>
                            <option value="<%=rs_kategorije.getInt("kat_id")%>"><%=rs_kategorije.getString("opis")%></option>
                            <%}%>
                        </select>
                    </div>
                    <div style="float: left; margin-left: 30px; width: 201px; margin-top: 20px;">
                        <b>Podkategorija:</b><br/><br/>
                        <select name="art_podk" style="text-align:center">
                            <% rs_podkategorije.beforeFirst();// ponovo citamo iste rez iz baze
                                while(rs_podkategorije.next()) {// za svaku podk dodajemo novu opciju u padajucem meniju za nov artikl
                            %>
                            
                            <option value="<%=rs_podkategorije.getInt("podk_id")%>"><%=rs_podkategorije.getString("opis")%></option>
                            <%}%>
                        </select>
                    </div>
                        <textarea name="art_opis" form="forma" placeholder="Opis artikla" style="margin-top: 30px; margin-bottom: 0; height: 100px; width: 60%;"></textarea>
                        <input type="file" name="art_slika" style="text-align:center; margin-top: 30px; margin-bottom: 50px; width: 100%; padding-left: 40%"/>
                    <input type="submit" class="btn btn-outline-primary" style="width: 250px;" value="Dodaj artikal"/>
                </form>
                <hr/>
                <% ResultSet rs_artikli = Base.getConnection().createStatement().executeQuery("SELECT * FROM artikal");
                    while (rs_artikli.next()) {
                        ResultSet rs_brend = Base.getConnection().createStatement().executeQuery("SELECT * FROM brendovi WHERE brend_id = " + rs_artikli.getInt("brend_id"));
                        rs_brend.first();
                        
                        ResultSet rs_kat = Base.getConnection().createStatement().executeQuery("SELECT * FROM kategorija WHERE kat_id = " + rs_artikli.getInt("kat_id"));
                        rs_kat.first();
                %>
                <div class="row">
                    <div class="col-md-11" style="padding: 15px; border: 1px solid pink; text-align: center; background: rgba(255, 255, 255, 0.9); height: 60px; margin-top: 5px; border-radius: 12px;">
                        <b><%=rs_artikli.getString("naziv")%></b> | <%=rs_brend.getString("naziv")%> | <%=rs_kat.getString("opis")%> | <i class="text-success"><%=rs_artikli.getInt("cena")%> RSD</i>
                    </div>
                    <div class="col-md-1" style="font-size: 1.5em; line-height: 60px; border: 1px solid pink; text-align: center; background: rgba(255, 255, 255, 0.9); height: 60px; margin-top: 5px; border-radius: 12px;">
                        <a href="Delete?tip=art&art_id=<%=rs_artikli.getInt("art_id")%>"><i class="fa fa-times-circle text-danger"></i></a>
                    </div>
                </div> 
                <%
                    }
                %>
            </div>
            
            <div id="divNajprodavaniji" hidden>
                <h2 style="margin-top: 20px; margin-left: 20px;">Najpopularniji artikli:</h2><hr/>
                <%  rs_artikli.beforeFirst();
                    while (rs_artikli.next()) {
                        ResultSet rs_brend = Base.getConnection().createStatement().executeQuery("SELECT * FROM brendovi WHERE brend_id = " + rs_artikli.getInt("brend_id"));
                        rs_brend.first();
                        
                        ResultSet rs_kat = Base.getConnection().createStatement().executeQuery("SELECT * FROM kategorija WHERE kat_id = " + rs_artikli.getInt("kat_id"));
                        rs_kat.first();
                %>
                <div class="row">
                    <div class="col-md-11" style="padding: 15px; border: 1px solid pink; text-align: center; background: rgba(255, 255, 255, 0.9); height: 60px; margin-top: 5px; border-radius: 12px;">
                        <b><%=rs_artikli.getString("naziv")%></b> | <%=rs_brend.getString("naziv")%> | <%=rs_kat.getString("opis")%> | <i class="text-success"><%=rs_artikli.getInt("cena")%> RSD</i>
                    </div> <!-- stil za checkbox -->
                    <style> 
                        input[type='checkbox'] {
                            -webkit-appearance:none;
                            width:30px;
                            height:30px;
                            background:white;
                            border-radius:5px;
                            border:1px outset #555;
                            margin-top: 15px;
                        }
                        input[type='checkbox']:checked {
                            background: #5cb85c;
                        }
                    </style>
                    <div class="col-md-1" style="font-size: 1.5em; line-height: 60px; border: 1px solid pink; text-align: center; background: rgba(255, 255, 255, 0.9); height: 60px; margin-top: 5px; border-radius: 12px;">
                        <input type="checkbox" id="chk-<%=rs_artikli.getInt("art_id")%>"/>
                    </div>
                </div>
                <%}%>
                <div class="row">
                    <div class="col-md-12" style="font-size: 1.5em; line-height: 60px; border: 1px solid pink; text-align: center; background: rgba(255, 255, 255, 0.9); height: 70px; margin-top: 5px; border-radius: 12px;">
                        <button onclick="najpopularniji()" class="btn btn-outline-primary" style="width: 400px">Sacuvaj najpopularnije proizvode</button>
                    </div>
                </div>
            </div>
            </div>
    </body>
</html>
