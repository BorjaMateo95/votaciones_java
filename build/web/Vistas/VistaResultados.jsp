
<%@page import="Modelos.Partido"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
    <head>
        <meta charset="UTF-8">
        <title>Resultados</title>
        
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
            ArrayList<Partido> listadoPartidos = (ArrayList<Partido>) session.getAttribute("partidos");
            %>
        
    <center>
        
        <h2>Resultados</h2>
        
        </br>
        
        <% if (session.getAttribute("rol").toString().equals("V")) {%>
            <a href="MenuVotante.jsp">
                <button type="button" class="btn btn-primary">Volver al inicio</button>
            </a>
        <%} else {%>
            <a href="MenuAdministrador.jsp">
                <button type="button" class="btn btn-primary">Volver al inicio</button>
            </a>
        <%}%>
        
        </br>
                
        <div class="table-responsive" style="width:80%;">
            <table class="table table-striped table-hover">
                <tr style="background-color:#343a40">
                    <th style="color:#F7F9F9"><b>Nombre</b></th>
                    <th style="color:#F7F9F9"><b>Votos</b></th>
		</tr>

                <%
                    for(int i = 0; i < listadoPartidos.size(); i++ ){
                        %>
                            <tr>
                               <td><%out.print(listadoPartidos.get(i).getNombre());%></td>
                               <td><%out.print(listadoPartidos.get(i).getVotos());%></td>                                         
                            </tr>
                            
                            <%
                    }
                    
                %>
            </table>
        </div>
        </center>
    </body>
</html>


