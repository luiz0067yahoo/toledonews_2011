<%@page import="java.util.Date"%>
<%@page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@page import="POJO.menusPOJO"%>
<%@page import="Until.functions"%>
<%@page import="java.util.Vector"%>
<%@page import="DAO.menusDAO"%>
<%@page import="BEAN.menusBEAN"%>
<%@page import="BD.Conexao"%>
<%@page import="BD.DadosConexao"%>
<!DOCTYPE html>
<%@include file="valida.jsp" %>
<%
    restricaoBEAN restricao_acesso=new restricaoBEAN();
    try{if(session.getAttribute("restricao_acesso")!=null)restricao_acesso=(restricaoBEAN)session.getAttribute("restricao_acesso");}catch(Exception erro_acesso){}
    if(!restricao_acesso.getVer()){
        %><%@include file="permisao_negada.jsp" %><%
    }
    else{
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cadastro Menus</title>
        <link rel="shortcut icon" href="./midia_mix.png" 	type="image/x-icon" />
        <style type="text/css">
            .texto1{font-family:Arial, Helvetica, sans-serif; font-size:14px; text-align:center;  font-size:16px; text-align:center; width:800px; height:auto; margin-right:auto; margin-left:auto; float:center; line-height:23px;}

            .texto2{font-family:Arial, Helvetica, sans-serif; font-size:14px; text-align:center; font-size:26px; text-align:center; width:800px; height:auto; margin-right:auto; margin-left:auto; float:center; line-height:29px;}

            .texto3{font-family:Arial, Helvetica, sans-serif; font-size:14px; text-align:center; font-size:15px; text-align:center; width:800px; height:auto; margin-right:auto; margin-left:auto; float:center; line-height:29px;}
        </style> 
    </head>
    <body onload="relogio();">
        <center>
            <%  
                Conexao minhaConexao=null;
                minhaConexao=(Conexao)session.getAttribute("minhaConexaoadm");

                
                menusBEAN menus_BEAN=new menusBEAN();
                menusDAO menus_DAO=new menusDAO(minhaConexao);
                Vector registros_menus=new Vector();
                
                String ID=request.getParameter("id");
                String Titulo=request.getParameter("Titulo");
                String acao=request.getParameter("acao");
                
                String mensagem_ID="";
                String mensagem_Titulo="";
                String mensagem_acao="";
                
                try{menus_BEAN.setID(ID);}catch(Exception erro){mensagem_ID="O menus selecionado não existe";};
                if((acao!=null)&&(acao.length()>0)){  
                    try{menus_BEAN.setTitulo(Titulo);}catch(Exception erro){mensagem_Titulo=erro.getMessage();};
                    if(acao.equals("Buscar")){
                        menusPOJO  menus_POJO=new menusPOJO();
                        menus_POJO.setTitulo(Titulo);
                        menus_BEAN=new menusBEAN(menus_POJO);
                        try{registros_menus=menus_DAO.buscarTitulo(menus_BEAN.getTitulo());}catch(Exception erro){mensagem_acao=erro.getMessage();};                            
                        mensagem_ID="";
                        mensagem_Titulo="";
                        mensagem_acao="";                        
                    }
                    else if(acao.equals("Salvar")){
                        if (
                            (mensagem_Titulo.length()==0)
                        ){
                            try{
                                menus_BEAN=menus_DAO.salvar(menus_BEAN);
                                registros_menus.add(menus_BEAN);
                                mensagem_acao="Menu salvo com sucesso";
                            }
                            catch(Exception erro){
                                mensagem_acao=erro.getMessage();
                            } 
                        }
                        else
                            menus_BEAN.Clear();
                        mensagem_ID="";
                    }
                    else if (acao.equals("editar")){
                        mensagem_ID="";
                        mensagem_Titulo="";
                        mensagem_acao="";
                        menus_BEAN=((menusBEAN)menus_DAO.buscarID(menus_BEAN));
                        if((menus_BEAN!=null)&&(menus_BEAN.getIDStr()!=null)){
                            registros_menus.add(menus_BEAN);
                        }
                    }
                    else if(acao.equals("Excluir")){
                        mensagem_Titulo="";
                        if (
                            (mensagem_ID.length()==0)                                                                                  
                        )
                        {
                            try{
                                menus_BEAN=menus_DAO.excluir(menus_BEAN);
                                if((menus_BEAN!=null)&&(menus_BEAN.getIDStr()!=null)){
                                    mensagem_acao="Menu não encontrada";
                                }
                                else{
                                    mensagem_acao="Menu excluído com sucesso";
                                }
                            }
                            catch(Exception erro){
                                mensagem_acao=erro.getMessage();
                            }
                        }
                    }                                                          
                }
                else{
                    mensagem_ID="";
                    registros_menus.clear();
                    registros_menus=menus_DAO.buscarTodosMenus(0,5);
                    menus_BEAN.Clear();
                }
            %>
        <a class="texto1">Cadastro Menu Fotos</a><br><br>
            <form method="post">
                <input type="hidden" value="<%=menus_BEAN.getIDStr()%>" name="id" id="id">
               <div style="clear:both;color:red"><%=mensagem_ID%></div>
             <a class="texto3">Titulo:</a> <input type="text" name="Titulo" value="<%=menus_BEAN.getTitulo()%>"><br>
               <div style="clear:both;color:red"><%=mensagem_Titulo%></div>
               <input type="submit" value="Novo" onclick="document.getElementById('id').value=''">
               <input type="submit" value="Salvar" name="acao">
               <input type="submit" value="Buscar" name="acao">
               <div style="clear:both;color:red"><%=mensagem_acao%></div><br>
            </form>
 
                <table cellpadding= "4" cellspacing = "0" border= "1" width= "400px">
                    <tr bgcolor="#CCCCCC">                           
                            <td><a class="texto3"> Titulo </a></td>
                            <td><a class="texto3"> acao </a></td>
		    </tr>
                        <%
                            if((registros_menus!=null)&&(registros_menus.size()>0)){
                                for(int i=0;i<registros_menus.size();i++){
                                    menus_BEAN=((menusBEAN)registros_menus.get(i));
                        %>
                        <tr>
                            <td><%=menus_BEAN.getTitulo()%></td>
                            <td>
                                <form method="post" >
                                    <input type="hidden" name="id" value="<%=menus_BEAN.getIDStr()%>">
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