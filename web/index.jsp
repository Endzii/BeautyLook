<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
    <head>
        <title>Welcome | BeautyLook</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" type="text/css" href="css/style.css">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css" integrity="sha384-hWVjflwFxL6sNzntih27bfxkr27PmbbK/iSvJ+a4+0owXq79v+lsFkW54bOGbiDQ" crossorigin="anonymous">
        
        <script>
            var register = function()
            {
                window.location.href = 'register.jsp'; // preusmeravanje na register stranicu javascript-om
            } 
       </script>

    </head>
    <body>
    	<h1>BeautyLook</h1>

        <%
            if(request.getParameter("greska") != null)
            {
                %><script> alert('Losi podaci, pokusaj ponovo!'); </script><%
            }

            if(request.getParameter("poruka") != null)
            {
                %><script> alert('Uspesno ste se registrovali, mozete nastaviti sa logovanjem!'); </script><%
            }
        %>
       
        <form action="logIn" method="POST" style="height: 80px;">
        	
            <input type="text" placeholder="Username" name="username"> <br><br>
            <input type="password" placeholder="Password" name="pass"> <br><br><br>
            <button type="submit" style="padding: 10px 0"><i class="fas fa-angle-double-right" style="margin-right:  5px"></i>Login</button>
            
        </form>
       <button onclick="register()" style="margin-left: 70px; margin-top: -400px; padding: 10px 0"><i class="fas fa-angle-double-right" style="margin-right:  5px"></i>Register</button>
    </body>
</html>
