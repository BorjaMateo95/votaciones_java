<%-- 
    Document   : VistaListadoCenso
    Created on : 18-dic-2018, 19:21:04
    Author     : BORJA
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="Modelos.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
    <head>
        <meta charset="UTF-8">
        <title>Censo</title>
        
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>        
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" 
              integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" 
        integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
        
        <style>
		.content {
			margin-top: 80px;
		}
                
	</style>
    </head>
    <body>
        <%
            ArrayList<Usuario> listadoUsuarios = (ArrayList<Usuario>) session.getAttribute("usuarios");
            %>
        
    <center>
        
        <h2>Censo</h2>
        </br>
        
        <!--<a href="menu.php">
            <button type="button" class="btn btn-primary">Volver al inicio</button>
        </a>-->
                
        <div class="table-responsive" style="width:80%;">
            <table class="table table-striped table-hover">
                <tr style="background-color:#343a40">
                    <th style="color:#F7F9F9"><b>Dni</b></th>
                    <th style="color:#F7F9F9"><b>Nombre</b></th>
                    <th style="color:#F7F9F9"><b>Apellidos</b></th>
                    <th style="color:#F7F9F9"><b>Domicilio</b></th>
                    <th style="color:#F7F9F9"><b>Email</b></th>
                    <th style="color:#F7F9F9"><b>Fecha de Nacimiento</b></th>
                    <th style="color:#F7F9F9"><b>Votado</b></th>
		</tr>

                <%
                    for(int i = 0; i < listadoUsuarios.size(); i++ ){
                        %>
                            <tr>
                               <td><%out.print(listadoUsuarios.get(i).getDni());%></td>
                               <td><%out.print(listadoUsuarios.get(i).getNombre());%></td>
                               <td><%out.print(listadoUsuarios.get(i).getApellidos());%></td>
                               <td><%out.print(listadoUsuarios.get(i).getDomicilio());%></td>
                               <td><%out.print(listadoUsuarios.get(i).getEmail());%></td>
                               <td><%out.print(listadoUsuarios.get(i).getFechaNacimiento());%></td>
                               <td><%out.print(listadoUsuarios.get(i).getVotado());%></td>                                             
                            </tr>
                            
                            <%
                    }
                    
                %>
            </table>
        </div>
        </center>
    </body>
</html>

