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
        <title>Modificacion Usuario</title>
        
        <link href="Estilos/Estilo.css" type="text/css" rel="stylesheet">
        <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
        <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
        <script src="//code.jquery.com/jquery-1.11.1.min.js"></script>

    </head>
    <body>
        <%
            Usuario usuario = (Usuario) session.getAttribute("usuario");
            %>
            
        <div class="container">
            <div class="card card-container">                
                <form class="form-signin" method="post" action="../ControladorModificacion">
                    <span id="reauth-email" class="reauth-email"></span>
                    <input type="text" id="nombre" name="nombre" class="form-control" placeholder="Nombre" 
                           value="<% out.print(usuario.getNombre());%>" required autofocus>
                    <input type="text" id="apellidos" name="apellidos" class="form-control" placeholder="Apellidos"
                           value="<% out.print(usuario.getApellidos());%>" required>
                    <input type="text" id="dni" name="dni" class="form-control" placeholder="DNI" 
                           value="<% out.print(usuario.getDni());%>" required>
                    <input type="text" id="domicilio" name="domicilio" class="form-control" placeholder="Domicilio"
                           value="<% out.print(usuario.getDomicilio());%>" required>
                    <input type="date" id="fechaNac" name="fechaNac" class="form-control" placeholder="Fecha Nacimiento"
                           value="<% out.print(usuario.getFechaNacimiento());%>" required>
                    <input type="email" id="email" name="email" class="form-control" placeholder="Email"
                           value="<% out.print(usuario.getEmail());%>" required>
                    <input type="password" id="password1" name="password1" class="form-control" placeholder="Contraseña"
                           required>
                    <input type="password" id="password2" name="password2" class="form-control" 
                           placeholder="Repite la Contraseña" required>
                    
                    <button class="btn btn-lg btn-primary btn-block btn-signin" type="submit">Actualizar Datos</button>
                </form>

            </div>
        </div>
    </body>
</html>
