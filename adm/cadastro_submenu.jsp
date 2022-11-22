<%@page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@page import="POJO.menusPOJO"%>
<%@page import="Until.functions"%>
<%@page import="java.util.Vector"%>
<%@page import="DAO.menusDAO"%>
<%@page import="BEAN.menusBEAN"%>
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
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cadastro sub menus</title>
        <link rel="shortcut icon" href="./midia_mix.png" 	type="image/x-icon" />
        <style type="text/css">
                .texto1{font-family:Arial, Helvetica, sans-serif; font-size:14px; text-align:center;  font-size:16px; text-align:center; width:800px; height:auto; margin-right:auto; margin-left:auto; float:center; line-height:23px;}

                .texto2{font-family:Arial, Helvetica, sans-serif; font-size:14px; text-align:center; font-size:26px; text-align:center; width:800px; height:auto; margin-right:auto; margin-left:auto; float:center; line-height:29px;}

                .texto3{font-family:Arial, Helvetica, sans-serif; font-size:14px; text-align:center; font-size:15px; text-align:center; width:800px; height:auto; margin-right:auto; margin-left:auto; float:center; line-height:29px;}
        </style>
        <script type="text/javascript" src="./js/relogio.js"></script>
    </head>
    <body>
        <center>
            <%
                Conexao minhaConexao=null;
                minhaConexao=(Conexao)session.getAttribute("minhaConexaoadm");
                
                
                menusBEAN sub_menus_BEAN=new menusBEAN();
                menusBEAN menus_BEAN=new menusBEAN();
                menusDAO sub_menus_DAO=new menusDAO(minhaConexao);
                Vector registros_sub_menus=new Vector();
                
                String ID=request.getParameter("id");
                String Titulo=request.getParameter("Titulo");
                String id_menus=request.getParameter("id_menus");
                String acao=request.getParameter("acao");
                
                String mensagem_ID="";
                String mensagem_Titulo="";
                String mensagem_acao="";
                String mensagem_id_menus="";
                
                try{sub_menus_BEAN.setID(ID);}catch(Exception erro){mensagem_ID="O sub_menus selecionado não existe";};
                try{sub_menus_BEAN.setID_menu(id_menus);}catch(Exception erro){mensagem_id_menus=erro.getMessage();};                
                if((acao!=null)&&(acao.length()>0)){  
                    try{sub_menus_BEAN.setTitulo(Titulo);}catch(Exception erro){mensagem_Titulo=erro.getMessage();};
                    if(acao.equals("Buscar")){
                        menusPOJO  sub_menus_POJO=new menusPOJO();
                        sub_menus_POJO.setTitulo(Titulo);
                        sub_menus_BEAN=new menusBEAN(sub_menus_POJO);
                        try{registros_sub_menus=sub_menus_DAO.buscarTitulo(sub_menus_BEAN.getTitulo());}catch(Exception erro){mensagem_acao=erro.getMessage();};                            
                        mensagem_ID="";
                        mensagem_Titulo="";
                        mensagem_acao="";                        
                    }
                    else if(acao.equals("Salvar")){
                        if (
                            (mensagem_Titulo.length()==0)
                            &&
                            (mensagem_id_menus.length()==0)
                        ){
                            try{
                                sub_menus_BEAN=sub_menus_DAO.salvar(sub_menus_BEAN);
                                registros_sub_menus.add(sub_menus_BEAN);
                                mensagem_acao="Menu salva com sucesso";
                            }
                            catch(Exception erro){
                                mensagem_acao=erro.getMessage();
                            } 
                        }
                        else
                            sub_menus_BEAN.Clear();
                        mensagem_ID="";
                        mensagem_id_menus="";
                    }
                    else if (acao.equals("editar")){
                        mensagem_ID="";
                        mensagem_Titulo="";
                        mensagem_acao="";
                        mensagem_id_menus="";
                        sub_menus_BEAN=((menusBEAN)sub_menus_DAO.buscarID(sub_menus_BEAN));
                        if((sub_menus_BEAN!=null)&&(sub_menus_BEAN.getIDStr()!=null)){
                            registros_sub_menus.add(sub_menus_BEAN);
                        }                        
                    }
                    else if(acao.equals("Excluir")){
                        mensagem_Titulo="";
                        if (
                            (mensagem_ID.length()==0)                                                                                  
                        )
                        {
                            try{
                                sub_menus_BEAN=sub_menus_DAO.excluir(sub_menus_BEAN);
                                if((sub_menus_BEAN!=null)&&(sub_menus_BEAN.getIDStr()!=null)){
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
                else {
                    mensagem_ID="";
                    registros_sub_menus.clear();
                    if ((sub_menus_BEAN!=null)&&(sub_menus_BEAN.getID_menusStr()!=null)){
                        try{menus_BEAN.setID(sub_menus_BEAN.getID_menusStr());}catch(Exception erro){}
                    }
                    else{
                        menus_BEAN=sub_menus_DAO.buscarPrimeiroPai();
                    }                    
                    registros_sub_menus=sub_menus_DAO.buscarTodosSubMenus(menus_BEAN);
                                       
                }
            %>
                <a class="texto1">Cadastro Menu</a><br><br>
                <form method="post">
                    <input type="hidden" value="<%=sub_menus_BEAN.getIDStr()%>" name="id" id="id">
                    menus:
                    <select name="id_menus" onchange="menuJump(this)">
                    <%
                       Vector registros_menus=(new menusDAO(minhaConexao)).buscarTodosMenus(1,5);
                       if((registros_menus!=null)&&(registros_menus.size()>0)){
                         for(int i=0;i<registros_menus.size();i++){
                            menus_BEAN=((menusBEAN)registros_menus.get(i));      
                    %>
                        <option value="<%=menus_BEAN.getIDStr()%>" <%
                            if(functions.equals(id_menus,menus_BEAN.getIDStr())) 
                                out.write("selected");
                        %>><%=menus_BEAN.getTitulo()%></option>
                     <%
                                }
                            }
                     %> 
                    </select> 
                    <div style="clear:both;color:red"><%=mensagem_ID%></div>
                    <a class="texto3">Titulo:</a> <input type="text" name="Titulo" value="<%=functions.removenull(sub_menus_BEAN.getTitulo())%>"><br>
                    <div style="clear:both;color:red"><%=mensagem_Titulo%></div>
                    <input type="submit" value="Novo" onclick="document.getElementById('id').value=''">
                    <input type="submit" value="Salvar" name="acao">
                    <input type="submit" value="Buscar" name="acao">
                    <div style="clear:both;color:red"><%=mensagem_acao%></div><br>
                </form> 
                <table cellpadding= "4" cellspacing = "0" border= "1" width= "400px">
                    <tr bgcolor="#CCCCCC">                           
                        <td><a class="texto3">Titulo</a></td>
                        <td><a class="texto3">Ação</a></td>
		    </tr>
                        <%
                            if((registros_sub_menus!=null)&&(registros_sub_menus.size()>0)){
                                for(int i=0;i<registros_sub_menus.size();i++){
                                    sub_menus_BEAN=((menusBEAN)registros_sub_menus.get(i));
                        %>
                        <tr>
                            <td><%=sub_menus_BEAN.getTitulo()%></td>
                            <td>
                                <form method="post" >
                                    <input type="hidden" name="id" value="<%=sub_menus_BEAN.getIDStr()%>">
                                    <input type="submit" name="acao" value="editar">
                                    <input type="submit" value="Excluir" name="acao">
                                </form>
                            </td>
                        </tr>
                        <%
                                }
                            }
                            sub_menus_BEAN.Clear(); 
                            minhaConexao.Fechar();
                        %>
                </table>
        </center>
    </body>
</html>
<%}%>