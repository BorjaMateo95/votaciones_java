
<%@page import="Modelos.Escano"%>
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
            ArrayList<Escano> listadoEscanos = (ArrayList<Escano>) session.getAttribute("listadoEscanos");
            %>
        
    <center>
        
        <h2>Escaños y Resultados</h2>
        
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
                       
        <div class="table-responsive" style="width:60%;">
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
            
        </br>
        
        <table class="table table-striped table-hover" style="text-align:center; width: 60%;">
                                
               <%
                    for(int i = 0; i < listadoEscanos.size(); i++ ){
                %>
                <tr style="background-color:#343a40">
                    <th colspan="2" style="color:#F7F9F9"><b>Nombre</b></th>
                    <th colspan="2" style="color:#F7F9F9"><b>Votos</b></th>
		</tr>
                    <tr>
                        <td colspan="2"><% out.print(listadoEscanos.get(i).getPartido().getNombre()); %></td>
                        <td colspan="2"><% out.print(listadoEscanos.get(i).getPartido().getVotos()); %></td>                                             
                    </tr>
                    
                    <tr style="background-color:#566573">
                        <th colspan="2" style="color:#F7F9F9"><b>Nombre</b></th>
                        <th colspan="2" style="color:#F7F9F9"><b>Orden</b></th>
                    </tr>
                    
                <%
                    for(int e = 0; e < listadoEscanos.get(i).getListCandidatos().size(); e++ ){
                %>
                        <tr>
                            <td colspan="2"><% out.print(listadoEscanos.get(i).getListCandidatos().get(e).getNombre()); %></td>
                            <td colspan="2"><% out.print(listadoEscanos.get(i).getListCandidatos().get(e).getOrden()); %></td>
                        </tr>
                       <%}%>

                <%}%>
            
            </table>
        </center>
    </body>
</html>
