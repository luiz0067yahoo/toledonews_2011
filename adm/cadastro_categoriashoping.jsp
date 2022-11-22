<%@page import="DAO.usuarioDAO"%>
<%@page import="java.util.Date"%>
<%@page import="BEAN.usuarioBEAN"%>
<%@page import="DAO.restricaoDAO"%>
<%@page import="BEAN.restricaoBEAN"%>
<%@page import="POJO.categoriaShoppingPOJO"%>
<%@page import="Until.functions"%>
<%@page import="java.util.Vector"%>
<%@page import="DAO.categoriaShoppingDAO"%>
<%@page import="BEAN.categoriaShoppingBEAN"%>
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
<style type="text/css">
	.texto1{font-family:Arial, Helvetica, sans-serif; font-size:14px; text-align:center;  font-size:16px; text-align:center; width:800px; height:auto; margin-right:auto; margin-left:auto; float:center; line-height:23px;}
	
	.texto2{font-family:Arial, Helvetica, sans-serif; font-size:14px; text-align:center; font-size:26px; text-align:center; width:800px; height:auto; margin-right:auto; margin-left:auto; float:center; line-height:29px;}
	
	.texto3{font-family:Arial, Helvetica, sans-serif; font-size:14px; text-align:center; font-size:15px; text-align:center; width:800px; height:auto; margin-right:auto; margin-left:auto; float:center; line-height:29px;}
</style>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cadastro categoria Shopping</title>
        <link rel="shortcut icon" href="./midia_mix.png" 	type="image/x-icon" />
    </head>
    <body onload="relogio();">
        <center>
            <%
                   
                Conexao minhaConexao=null;
                minhaConexao=(Conexao)session.getAttribute("minhaConexaoadm");
        
                categoriaShoppingBEAN categoriaShopping_BEAN=new categoriaShoppingBEAN();
                categoriaShoppingDAO categoriaShopping_DAO=new categoriaShoppingDAO(minhaConexao);
                Vector registros_categoriaShopping=new Vector();
                
                String ID=request.getParameter("id");
                String Titulo=request.getParameter("Titulo");
                String acao=request.getParameter("acao");
                
                String mensagem_ID="";
                String mensagem_Titulo="";
                String mensagem_acao="";
                
                try{categoriaShopping_BEAN.setID(ID);}catch(Exception erro){mensagem_ID="O categoriaShopping selecionado não existe";};
                if((acao!=null)&&(acao.length()>0)){  
                    try{categoriaShopping_BEAN.setTitulo(Titulo);}catch(Exception erro){mensagem_Titulo=erro.getMessage();};
                    if(acao.equals("Buscar")){
                        categoriaShoppingPOJO  categoriaShopping_POJO=new categoriaShoppingPOJO();
                        categoriaShopping_POJO.setTitulo(Titulo);
                        categoriaShopping_BEAN=new categoriaShoppingBEAN(categoriaShopping_POJO);
                        try{registros_categoriaShopping=categoriaShopping_DAO.buscar(categoriaShopping_BEAN);}catch(Exception erro){mensagem_acao=erro.getMessage();};                            
                        mensagem_ID="";
                        mensagem_Titulo="";
                        mensagem_acao="";                        
                    }
                    else if(acao.equals("Salvar")){
                        if (
                            (mensagem_Titulo.length()==0)
                        ){
                            try{
                                categoriaShopping_BEAN=categoriaShopping_DAO.salvar(categoriaShopping_BEAN);
                                registros_categoriaShopping.add(categoriaShopping_BEAN);
                                mensagem_acao="Categoria salva com sucesso";
                            }
                            catch(Exception erro){
                                mensagem_acao=erro.getMessage();
                            } 
                        }
                        else
                            categoriaShopping_BEAN.Clear();
                        mensagem_ID="";
                    }
                    else if (acao.equals("editar")){
                        mensagem_ID="";
                        mensagem_Titulo="";
                        mensagem_acao="";
                        categoriaShopping_BEAN=((categoriaShoppingBEAN)categoriaShopping_DAO.buscarID(categoriaShopping_BEAN));
                        if((categoriaShopping_BEAN!=null)&&(categoriaShopping_BEAN.getIDStr()!=null)){
                            registros_categoriaShopping.add(categoriaShopping_BEAN);
                        }
                    }
                    else if(acao.equals("Excluir")){
                        mensagem_Titulo="";
                        if (
                            (mensagem_ID.length()==0)                                                                                  
                        )
                        {
                            try{
                                categoriaShopping_BEAN=categoriaShopping_DAO.excluir(categoriaShopping_BEAN);
                                if((categoriaShopping_BEAN!=null)&&(categoriaShopping_BEAN.getIDStr()!=null)){
                                    mensagem_acao="Categoria excluído com sucesso";
                                }
                                else{
                                    mensagem_acao="Categoria não encontrada";
                                }
                            }
                            catch(Exception erro){
                                mensagem_acao=erro.getMessage();
                            }
                        }
                        
                    }
                                                                                
                }
                else {
                    
                    
                    
                        mensagem_ID="";
                        registros_categoriaShopping.clear();
                        registros_categoriaShopping=categoriaShopping_DAO.buscarTodos();
                        categoriaShopping_BEAN.Clear();
                    
                }
            %>
        <a class="texto1">Cadastro categoria Shopping</a><br><br>
            <form method="post">
                <input type="hidden" value="<%=categoriaShopping_BEAN.getIDStr()%>" name="id" id="id">
               <div style="clear:both;color:red"><%=mensagem_ID%></div>
             <a class="texto3">Titulo:</a> <input type="text" name="Titulo" value="<%=categoriaShopping_BEAN.getTitulo()%>"><br>
               <div style="clear:both;color:red"><%=mensagem_Titulo%></div>
               <input type="submit" value="Novo" onclick="document.getElementById('id').value=''">
               <%if(restricao_acesso.getSalvar()){%><input type="submit" value="Salvar" name="acao"><%}%>
               <%if(restricao_acesso.getBuscar()){%><input type="submit" value="Buscar" name="acao"><%}%>
               <div style="clear:both;color:red"><%=mensagem_acao%></div><br>
            </form>
 
                <table cellpadding= "4" cellspacing = "0" border= "1" width= "400px">
                    <tr bgcolor="#CCCCCC">                           
                            <td><a class="texto3"> Titulo </a></td>
                            <td><a class="texto3"> acao </a></td>
		    </tr>
                  <%
                            if((registros_categoriaShopping!=null)&&(registros_categoriaShopping.size()>0)){
                                for(int i=0;i<registros_categoriaShopping.size();i++){
                                    categoriaShopping_BEAN=((categoriaShoppingBEAN)registros_categoriaShopping.get(i));
                        %>
                        <tr>
                            
                            <td><%=categoriaShopping_BEAN.getTitulo()%></td>
                            <td>
                                <form method="post" >
                                    <input type="hidden" name="id" value="<%=categoriaShopping_BEAN.getIDStr()%>">
                                    <%if(restricao_acesso.getEditar()){%><input type="submit" name="acao" value="editar"><%}%>
                                    <%if(restricao_acesso.getExcluir()){%><input type="submit" value="Excluir" name="acao"><%}%>
                                </form>
                            </td>
                        </tr>
                        <%
                                }
                                minhaConexao.Fechar();
                            }
                        %>
                     
                </table>
        </center>
    </body>
</html>
<%}%>