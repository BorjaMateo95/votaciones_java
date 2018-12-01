<%-- 
    Document   : VistaModificacionUsuario
    Created on : 27-nov-2018, 17:04:19
    Author     : CURILLA
--%>

<%@page import="Modelos.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Baja Usuario</title>
        
        <link href="Estilos/Estilo.css" type="text/css" rel="stylesheet">
        <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
        <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
        <script src="//code.jquery.com/jquery-1.11.1.min.js"></script>

    </head>
    <body>
            
        <div class="container">
            <div class="card card-container">                
                <form class="form-signin" method="post" action="../ControladorBaja">
                    <span id="reauth-email" class="reauth-email"></span>
                    <input type="text" id="dni" name="dni" class="form-control" placeholder="DNI" 
                           required autofocus>
                    <input type="password" id="password1" name="password1" class="form-control" placeholder="Contraseña"
                           required>

                    <button class="btn btn-lg btn-primary btn-block btn-signin" type="submit">Darse de Baja</button>
                </form>

            </div>
        </div>
    </body>
</html>
