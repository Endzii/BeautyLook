<%-- 
    Document   : register
    Created on : Aug 28, 2018, 3:52:47 PM
    Author     : anci
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Register | BeautyLook</title>
        <link rel="stylesheet" type="text/css" href="css/style.css">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css" integrity="sha384-hWVjflwFxL6sNzntih27bfxkr27PmbbK/iSvJ+a4+0owXq79v+lsFkW54bOGbiDQ" crossorigin="anonymous">
        
        <script>
            var back = function()
            {
                window.location.href = 'index.jsp'; // preusmeravanje na login putem javascript-a
            }
       </script>
        
    </head>
    <body>
        <h1>BeautyLook</h1>
        
        <%
            if(request.getParameter("greska") != null) //?
            {
                if (request.getParameter("greska").equals("1"))
                {
                %><script> alert('Unete sifre se ne podudaraju!'); </script><%
                } else {
                %><script> alert('Korisnicko ime je zauzeto!'); </script><%    
                }
            }
        %>
        
        <form action="register" method="POST" style="height: 80px;">
        	
            <input type="text" placeholder="Username" name="username"> <br><br>
            <input type="email" placeholder="Email" name="email"> <br><br>
            <input type="password" placeholder="Password" name="pass"> <br><br>
            <input type="password" placeholder="Repeat Password" name="rpass"> <br><br>
            <button type="submit" style="padding: 10px 0"><i class="fas fa-angle-double-right" style="margin-right:  5px"></i>Register</button>
            
        </form>
        <button onclick="back()" style="margin-left: 68px; margin-top: 30px; padding: 10px 0"><i style="margin-right:  5px" class="fas fa-angle-double-left"></i>Back</button>
    </body>
</html>
