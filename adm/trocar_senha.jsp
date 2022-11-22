<%@include file="valida.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@page import="DAO.usuarioDAO"%>
<%@page import="BEAN.usuarioBEAN"%>
<%@page import="BD.Conexao"%>
<%@page import="BD.DadosConexao"%>
<!DOCTYPE html>
<link rel="stylesheet" type="text/css" href="estilosadm.css">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script type="text/javascript">
            function valida_senha(){
               var nova_senha=document.getElementById("nova_senha").value;
               var repete_senha=document.getElementById("repete_senha").value;
                
                if(nova_senha==repete_senha){ 
                    document.getElementById("nova_senha").style.color="#000000";
                    document.getElementById("repete_senha").style.color="#000000";
                    return true;
                }              
                document.getElementById("nova_senha").style.color="#ff0000";
                document.getElementById("repete_senha").style.color="#ff0000";
                alert("As duas senhas em vermelho não conferem");
                return false;                
            }
        </script>
    </head>
    <body>
        <center>
        <%
                Conexao minhaConexao=null;
                minhaConexao=(Conexao)session.getAttribute("minhaConexaoadm");

                usuarioBEAN usuario_BEAN=(usuarioBEAN)session.getAttribute("usuario");
                usuarioDAO usuario_DAO=new usuarioDAO(minhaConexao);
            
                String senha_antiga=request.getParameter("senha_antiga");
                String senha=request.getParameter("nova_senha");
                String acao=request.getParameter("acao");
                
                if(acao!=null){
                    if(acao.equals("trocar"))
                    usuario_DAO.alterarSenha(usuario_BEAN,senha_antiga);
                        
                            
                }
        %>
        	<a class="texto1">Trocar Senha</a>
            <form onsubmit="return valida_senha()">
                <a class="texto3">Senha Antiga:</a><input type="password" name="senha_antiga"><br>
                <a class="texto3">Nova Senha:</a><input type="password" name="nova_senha" id="nova_senha"><br>
                <a class="texto3">Repita a Senha:</a><input type="password" name="repete_senha" id="repete_senha"><br>
                <input type="submit" value="trocar" name="acao">
            </form>
        </center>
    </body>
</html>
