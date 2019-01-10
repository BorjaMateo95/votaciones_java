<%-- 
    Document   : MenuAdministrador
    Created on : 27-nov-2018, 16:17:43
    Author     : BORJA
--%>

<%@page import="Modelos.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>E-Votaciones</title>
        <link href="Vistas/Estilos/Estilo.css" type="text/css" rel="stylesheet">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    </head>
    <body>
        <%
            Usuario usuario = (Usuario) session.getAttribute("usuario");
        %>
        <nav class="navbar navbar-inverse">
            <div class="container-fluid">
                <div class="navbar-header">
                    <a class="navbar-brand" href="MenuAdministrador.jsp">E-Votaciones</a>
                </div>
                <ul class="nav navbar-nav">

                    <li><a href="../ControladorVoto">Votar</a></li>
                    <li><a href="../ControladorResultados">Ver Resultados</a></li>
                    <li><a href="../ControladorListadoCenso">Listar Censo</a></li>
                    
                    <li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" 
                                            href="#">Abrir/Cerrar Escrutinio<span class="caret"></span></a>
                        <ul class="dropdown-menu">
                            <li><a href="../ControladorAbrirEscrutinio">Abrir Escrutinio</a></li>
                            <li><a href="../ControladorCerrarEscrutinio">Cerrar Escrutinio</a></li>
                        </ul>
                        
                    </li>
                    
                    <li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" 
                                            href="#">Resultados<span class="caret"></span></a>
                        <ul class="dropdown-menu">
                            <li><a href="../ControladorEscanos">Presentar Resultados</a></li>
                            <li><a href="../ControladorResultadosVotantes">Ver Resultados</a></li>
                        </ul>
                        
                    </li>
                    
                    <li><a href="VistaModificacionUsuario.jsp">Modificar Datos</a></li>
                    <li><a href="VistaDarDeBajaUsuario.jsp">Darse de Baja</a></li>
                    <li><a href="../ControladorCerrarSesion">Cerrar Sesion</a></li>
                </ul>
            </div>
        </nav>
        
        <div class="container" style="width: 50%; margin-top: 7rem;">
            <div class="panel-group">
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <h4><% out.print(usuario.getNombre() + " " + usuario.getApellidos()); %></h4>
                    </div>
                    <div class="panel-body">
                        <p><b>DNI: </b><% out.print(usuario.getDni()); %></p>
                        <p><b>Domicilio: </b><% out.print(usuario.getDomicilio()); %></p>
                        <p><b>Email: </b><% out.print(usuario.getEmail()); %></p>
                        <p><b>Fecha Nacimiento: </b><% out.print(usuario.getFechaNacimiento()); %></p>
                    </div>
                </div>
            </div>
        </div>

    </body>
</html>

