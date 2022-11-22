<%-- 
    Document   : trancasite
    Created on : 30/10/2012, 11:20:26
    Author     : usuario
--%>

<%@page import="Until.trancar"%>
<%@page import="BEAN.usuarioBEAN"%>
<%@page import="Until.functions"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <form>
            login:<input type="text" name="login"><br>
            senha:<input type="text" name="senha"><br>
            <input type="submit" name="acao" value="ok"><br>
        </form>
        <%
            String login=request.getParameter("login");
            String senha=request.getParameter("senha");
            trancar.iniciar();
            //trancar.trancar(login, senha);
            
        %>
    </body>
</html>
