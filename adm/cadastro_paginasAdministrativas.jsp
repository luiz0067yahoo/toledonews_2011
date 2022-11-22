<%@page import="java.util.Date"%>
<%@page import="BEAN.paginas_administrativasBEAN"%>
<%@page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@page import="POJO.paginas_administrativasPOJO"%>
<%@page import="Until.functions"%>
<%@page import="java.util.Vector"%>
<%@page import="DAO.paginas_administrativasDAO"%>
<%@page import="BEAN.paginas_administrativasBEAN"%>
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
        <title>Cadastro categoria Videos</title>
        <link rel="shortcut icon" href="./midia_mix.png" 	type="image/x-icon" />
    </head>
    <body onload="relogio();">
        <center>
            <%
                
                
                Conexao minhaConexao=null;
                minhaConexao=(Conexao)session.getAttribute("minhaConexaoadm");

            
                
                paginas_administrativasBEAN paginas_administrativas_BEAN=new paginas_administrativasBEAN();
                paginas_administrativasDAO paginas_administrativas_DAO=new paginas_administrativasDAO(minhaConexao);
                Vector paginas_administrativas=new Vector();
                
                String ID=request.getParameter("id");
                String nome=request.getParameter("nome");
                String acao=request.getParameter("acao");
                
                String mensagem_ID="";
                String mensagem_nome="";
                String mensagem_acao="";
                
                try{paginas_administrativas_BEAN.setID(ID);}catch(Exception erro){mensagem_ID="O Paginas Administrativas selecionado não existe";};
                if((acao!=null)&&(acao.length()>0)){  
                    try{paginas_administrativas_BEAN.setnome(nome);}catch(Exception erro){mensagem_nome=erro.getMessage();};
                    if(acao.equals("Buscar")){
                        paginas_administrativasPOJO  menus_POJO=new paginas_administrativasPOJO();
                        menus_POJO.setnome(nome);
                        paginas_administrativas_BEAN=new paginas_administrativasBEAN(menus_POJO);
                        try{paginas_administrativas=paginas_administrativas_DAO.buscarnome(paginas_administrativas_BEAN.getnome());}catch(Exception erro){mensagem_acao=erro.getMessage();};                            
                        mensagem_ID="";
                        mensagem_nome="";
                        mensagem_acao="";                     
                    }
                    else if(acao.equals("Salvar")){
                        if (
                            (mensagem_nome.length()==0)
                        ){
                            try{
                                paginas_administrativas_BEAN=paginas_administrativas_DAO.salvar(paginas_administrativas_BEAN);
                                paginas_administrativas.add(paginas_administrativas_BEAN);
                                mensagem_acao="Categoria salva com sucesso";
                            }
                            catch(Exception erro){
                                mensagem_acao=erro.getMessage();
                            } 
                        }
                        else
                            paginas_administrativas_BEAN.Clear();
                        mensagem_ID="";
                    }
                    else if (acao.equals("editar")){
                        mensagem_ID="";
                        mensagem_nome="";
                        mensagem_acao="";
                        paginas_administrativas_BEAN=((paginas_administrativasBEAN)paginas_administrativas_DAO.buscarID(paginas_administrativas_BEAN));
                        if((paginas_administrativas_BEAN!=null)&&(paginas_administrativas_BEAN.getIDStr()!=null)){
                            paginas_administrativas.add(paginas_administrativas_BEAN);
                        }
                    }
                    else if(acao.equals("Excluir")){
                        if (
                            (mensagem_ID.length()==0)                                                                                  
                        )
                        {
                            try{
                                paginas_administrativas_BEAN=paginas_administrativas_DAO.excluir(paginas_administrativas_BEAN);
                                if((paginas_administrativas_BEAN!=null)&&(paginas_administrativas_BEAN.getIDStr()!=null)){
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
                        paginas_administrativas.clear();
                        paginas_administrativas=paginas_administrativas_DAO.buscarTodos();
                        paginas_administrativas_BEAN.Clear();
                    
                }
            %>
        <a class="texto1">Cadastro categoria Videos</a><br><br>
            <form method="post">
                <input type="hidden" value="<%=paginas_administrativas_BEAN.getIDStr()%>" name="id" id="id">
               <div style="clear:both;color:red"><%=mensagem_ID%></div>
             <a class="texto3">nome:</a> <input type="text" name="nome" value="<%=paginas_administrativas_BEAN.getnome()%>"><br>
               <div style="clear:both;color:red"><%=mensagem_nome%></div>
               <input type="submit" value="Novo" onclick="document.getElementById('id').value=''">
               <input type="submit" value="Salvar" name="acao">
               <input type="submit" value="Buscar" name="acao">
               <div style="clear:both;color:red"><%=mensagem_acao%></div><br>
            </form>
 
                <table cellpadding= "4" cellspacing = "0" border= "1" width= "400px">
                    <tr bgcolor="#CCCCCC">                           
                            <td><a class="texto3"> Nome </a></td>
                            <td><a class="texto3"> acao </a></td>
		    </tr>
                  <%
                            if((paginas_administrativas!=null)&&(paginas_administrativas.size()>0)){
                                for(int i=0;i<paginas_administrativas.size();i++){
                                    paginas_administrativas_BEAN=((paginas_administrativasBEAN)paginas_administrativas.get(i));
                        %>
                        <tr>
                            
                            <td><%=paginas_administrativas_BEAN.getnome()%></td>
                            <td>
                                <form method="post" >
                                    <input type="hidden" name="id" value="<%=paginas_administrativas_BEAN.getIDStr()%>">
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