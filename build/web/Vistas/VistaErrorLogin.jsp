<%-- 
    Document   : VistaErrorLogin
    Created on : 27-nov-2018, 13:13:40
    Author     : BORJA
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Error Login</title>
        
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>        
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" 
              integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" 
        integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
        
    </head>
    <body>
        <center>
            <div class="card text-white bg-danger mb-3" style="max-width: 18rem;">
                <div class="card-header">ATENCIÓN</div>
                <div class="card-body">
                    <p class="card-text"><% out.print(session.getAttribute("msg").toString()); session.invalidate();%></p>
                    <a href="../index.jsp">
                        <button type="button" class="btn btn-default">Volver al Login</button>
                    </a>
                </div>
            </div>
        </center>
    </body>
</html>

