<%@page import="POJO.usuarioPOJO"%>
<%@page import="Until.functions"%>
<%@page import="java.util.Vector"%>
<%@page import="DAO.usuarioDAO"%>
<%@page import="BEAN.usuarioBEAN"%>
<%@page import="BD.Conexao"%>
<%@page import="BD.DadosConexao"%>
<%@include file="valida.jsp" %>
<%
    restricaoBEAN restricao_acesso=new restricaoBEAN();
    try{if(session.getAttribute("restricao_acesso")!=null)restricao_acesso=(restricaoBEAN)session.getAttribute("restricao_acesso");}catch(Exception erro_acesso){}
    if(!restricao_acesso.getVer()){
        %><%@include file="permisao_negada.jsp" %><%
    }
    else{
%>
<!DOCTYPE html>
<link rel="stylesheet" type="text/css" href="estilosadm.css">
<style type="text/css">
	.texto1{font-family:Arial, Helvetica, sans-serif; font-size:14px; text-align:center;  font-size:16px; text-align:center; width:800px; height:auto; margin-right:auto; margin-left:auto; float:center; line-height:23px;}
	
	.texto2{font-family:Arial, Helvetica, sans-serif; font-size:14px; text-align:center; font-size:26px; text-align:center; width:800px; height:auto; margin-right:auto; margin-left:auto; float:center; line-height:29px;}
	
	.texto3{font-family:Arial, Helvetica, sans-serif; font-size:14px; text-align:center; font-size:15px; text-align:center; width:800px; height:auto; margin-right:auto; margin-left:auto; float:center; line-height:29px;}
</style>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cadastro usuario</title>
        <link rel="shortcut icon" href="./midia_mix.png" 	type="image/x-icon" />
    </head>
    <body onload="relogio();">
        <center>
            <%
                Conexao minhaConexao=null;
                minhaConexao=(Conexao)session.getAttribute("minhaConexaoadm");

                usuarioBEAN usuario_BEAN=new usuarioBEAN();
                usuarioDAO usuario_DAO=new usuarioDAO(minhaConexao);
                Vector registros_usuario=new Vector();
                
                String ID=request.getParameter("id");
                String nome=request.getParameter("nome");
                String login=request.getParameter("login");
                String senha=request.getParameter("senha");
                String acao=request.getParameter("acao");
                
                String mensagem_ID="";
                String mensagem_nome="";
                String mensagem_login="";
                String mensagem_senha="";
                String mensagem_acao="";
                
                try{usuario_BEAN.setID(ID);}catch(Exception erro){mensagem_ID="O usuario selecionado não existe";};
                if((acao!=null)&&(acao.length()>0)){  
                    try{usuario_BEAN.setNome(nome);}catch(Exception erro){mensagem_nome=erro.getMessage();};
                    try{usuario_BEAN.setLogin(login);}catch(Exception erro){mensagem_login=erro.getMessage();}; 
                    try{usuario_BEAN.setSenha(senha);}catch(Exception erro){mensagem_senha=erro.getMessage();}; 
                    if(acao.equals("Buscar")){
                        usuarioPOJO  usuario_POJO = new usuarioPOJO();
                        usuario_POJO.setNome(nome);
                        usuario_POJO.setLogin(login);
                        usuario_POJO.setSenha(senha);
                        usuario_BEAN=new usuarioBEAN(usuario_POJO);
                        try{registros_usuario=usuario_DAO.buscar(usuario_BEAN);}catch(Exception erro){mensagem_acao=erro.getMessage();};                            
                        mensagem_ID="";
                        mensagem_nome="";
                        mensagem_login="";
                        mensagem_senha="";
                        mensagem_acao="";                        
                    }
                    else if(acao.equals("Salvar")){
                        if (
                            (mensagem_nome.length()==0)
                            &&
                            (mensagem_login.length()==0)
                            && 
                            (mensagem_senha.length()==0)                                                                                        
                        ){
                            try{
                                usuario_BEAN=usuario_DAO.salvar(usuario_BEAN);
                                registros_usuario.add(usuario_BEAN);
                                mensagem_acao="Usuário salvo com sucesso";
								
                            }
                            catch(Exception erro){
                                mensagem_acao=erro.getMessage();
                            }
                       }
                        else
                            usuario_BEAN.Clear();
						mensagem_ID="";	
                    }
                    else if(acao.equals("Excluir")){
                        if (
                            (mensagem_ID.length()==0)                                                                                  
                        )
                        {
                            try{
                                usuario_BEAN=usuario_DAO.excluir(usuario_BEAN);
                                if((usuario_BEAN!=null)&&(usuario_BEAN.getIDStr()!=null)){
                                    mensagem_acao="Usuário excluído com sucesso";
                                }
                                else{
                                    mensagem_acao="Usuário não encontrado";
                                }
                            }
                            catch(Exception erro){
                                mensagem_acao=erro.getMessage();
                            }
                        }
                        mensagem_ID=""; 
                        mensagem_senha="";                         
                        mensagem_login="";                         
                        mensagem_nome="";                         
                    }
                    else if(acao.equals("editar")){                                
                        usuario_BEAN=((usuarioBEAN)usuario_DAO.buscarID(usuario_BEAN));
                        if((usuario_BEAN!=null)&&(usuario_BEAN.getIDStr()!=null)){
                            registros_usuario.add(usuario_BEAN);
                        }
                        else{
                            usuario_BEAN.Clear();
                            registros_usuario=usuario_DAO.buscarTodos();
                        }
                        mensagem_ID=""; 
                        mensagem_nome="";
                        mensagem_login="";
                        mensagem_senha="";
                    }
                    else if(acao.equals("novo")){
                        mensagem_ID=""; 
                        mensagem_nome="";
                        mensagem_login="";
                        mensagem_senha="";
                        usuario_BEAN.Clear();
                    }                                                                                
                }
                else{
                            mensagem_ID="";
                            usuario_BEAN.Clear();
                            try{registros_usuario=usuario_DAO.buscarTodos();}catch(Exception erro){}
                }
            %>
            <a class="texto1">Cadastro usuário</a><br><br>
            <form method="post">
                <input type="hidden" name="id" value="<%=usuario_BEAN.getIDStr()%>" id="id">  
               <div style="clear:both;color:red"><%=mensagem_ID%></div>
               <a class="texto3">Nome:</a> <input type="text" name="nome" value="<%=usuario_BEAN.getNome()%>"><br>
               <div style="clear:both;color:red"><%=mensagem_nome%></div>
               <a class="texto3">Login:</a> <input type="text" name="login" value="<%=usuario_BEAN.getLogin()%>"><br>
               <div style="clear:both;color:red"><%=mensagem_login%></div>
            <a class="texto3">Senha:</a> <input type="password" name="senha"><br>
               <div style="clear:both;color:red"><%=mensagem_senha%></div>
               <input type="submit" value="novo"  onclick="document.getElementById('id').value=''">
               <input type="submit" value="Salvar" name="acao">
               <input type="submit" value="Buscar" name="acao">
               <div style="clear:both;color:red"><%=mensagem_acao%></div>
            </form>
 
                <table cellpadding= "4" cellspacing = "0" border= "1" width= "400px">
                    <tr bgcolor="#CCCCCC">                           
                           
                            <td> <a class="texto3">Nome</a> </td>
                            <td> <a class="texto3">Login</a> </td>
                            <td> <a class="texto3">Senha</a> </td>
                            <td> <a class="texto3"> acao</a> </td>
		    </tr>
                        <%
                            if((registros_usuario!=null)&&(registros_usuario.size()>0)){
                                for(int i=0;i<registros_usuario.size();i++){
                                    usuario_BEAN=((usuarioBEAN)registros_usuario.get(i));
                        %>
                        <tr bgcolor="#FFFFFF">
                            
                            <td><%=usuario_BEAN.getNome()%></td>
                        <td><%=usuario_BEAN.getLogin()%></td>
                          <td>********</td>
                            <td>
                              <form method="post" >
                                    <input type="hidden" name="id" value="<%=usuario_BEAN.getIDStr()%>">
                                    <input type="submit" name="acao" value="editar">
                                    <input type="submit" value="Excluir" name="acao">
                                </form>
                            </td>
                        </tr>
                        <%
                                }
                            }
                            minhaConexao.Fechar();
                        %>
                </table>
        </center>
    </body>
</html>
<%}%>