<%-- 
    Document   : VistaVotar
    Created on : 20-dic-2018, 17:42:47
    Author     : BORJA
--%>

<%@page import="Modelos.Partido"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Votar</title>
        
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
            ArrayList<Partido> listaPartidos = (ArrayList<Partido>) session.getAttribute("partidos");
            %>
        <center>
            <h2>Seleccione un partido</h2>
            
            <form class="form-signin" method="post" action="../ControladorVotar">
            
            <%
                for(int i = 0; i < listaPartidos.size(); i++) {
                    %>
                    
                    <div class="radio">
                        <img style="width:200px; height:70px; margin:20px;" src="Imagenes/<% out.print(listaPartidos.get(i).getLogo()); %>"/>
                        <input type="radio" name="idvoto" id="idvoto" value="<%out.print(listaPartidos.get(i).getId());%>">
                    </div>
                
                <%}%>
                
                <button class="btn btn-lg btn-primary btn-block btn-signin" style="width:150px; height:50px; margin:20px;" type="submit">Votar</button>

                </form>
        </center>
    </body>
</html>
