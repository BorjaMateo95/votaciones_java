<%-- 
    Document   : index
    Created on : 23-nov-2018, 0:02:15
    Author     : BORJA
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->
<html>
    <head>
        <meta charset="UTF-8">
        <title>Login</title>
        
        <link href="Vistas/Estilos/Estilo.css" type="text/css" rel="stylesheet">
        <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
        <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
        <script src="//code.jquery.com/jquery-1.11.1.min.js"></script>


    </head>
    <body>
        <div class="container">
            <div class="card card-container">
                <img id="profile-img" class="profile-img-card" src="//ssl.gstatic.com/accounts/ui/avatar_2x.png"/>
                <p id="profile-name" class="profile-name-card"></p>
                
                <form class="form-signin" method="post" action="ControladorLogin">
                    <span id="reauth-email" class="reauth-email"></span>
                    <input type="text" id="dni" name="dni" class="form-control" placeholder="DNI" required autofocus>
                    <input type="password" id="password" name="password" class="form-control" placeholder="Contraseña" required>

                    <button class="btn btn-lg btn-primary btn-block btn-signin" type="submit">Iniciar Sesión</button>
                    <a href="Vistas/VistaRegistro.jsp">Registrate</a>
                </form>

            </div>
        </div>
    </body>
</html>

