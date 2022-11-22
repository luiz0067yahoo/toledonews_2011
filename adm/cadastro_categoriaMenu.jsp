<%@page import="DAO.menusDAO"%>
<%@page import="BEAN.menusBEAN"%>
<%@page import="java.util.Date"%>
<%@page import="DAO.usuarioDAO"%>
<%@page import="BEAN.usuarioBEAN"%>
<%@page import="POJO.restricaoPOJO"%>
<%@page import="DAO.restricaoDAO"%>
<%@page import="Until.functions"%>
<%@page import="java.util.Vector"%>
<%@page import="DAO.restricaoDAO"%>
<%@page import="BEAN.restricaoBEAN"%>
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
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cadastro restricao</title>
        <link rel="shortcut icon" href="./midia_mix.png" type="image/x-icon" />
        <script type="text/javascript" src="./js/relogio.js"></script>
        <script type="text/javascript" src="./js/home.js"></script>
        <script type="text/javascript" src="./js/jquery.maskedinput-1.1.4.pack.js"></script>
        <script type="text/javascript" src="./js/plsql.js"></script>
    </head>
    <body onload="relogio();">
        <center>
<%
            Conexao minhaConexao=null;
            minhaConexao=(Conexao)session.getAttribute("minhaConexaoadm");
           
            menusBEAN menus_BEAN=new menusBEAN();
            menusDAO menus_DAO=new menusDAO(minhaConexao);
            
            restricaoBEAN restricao_BEAN=new restricaoBEAN();
            restricaoDAO restricao_DAO=new restricaoDAO(minhaConexao);
            Until.functions request2=new Until.functions();
            request2.setRequest(request);

            String id_usuario=request2.getParameter("id_usuario");
            String id_menu=request2.getParameter("id_menu");
            
            String acao=request2.getParameter("acao");                

            String mensagem_acao="";
            String mensagem_id_usuario="";
             
            Vector menus=menus_DAO.buscarTodos();
           
            
            try{restricao_BEAN.setId_usuario(id_usuario);}catch(Exception erro){}; 
            if((acao!=null)&&(acao.length()>0)&&(acao.equals("Salvar"))){  
                //tamanaho=1;
                if((menus!=null)&&(menus.size()>0)){
                    for(int i=0;i<menus.size();i++){
                        menus_BEAN=((menusBEAN)menus.get(i));
                        String ver=request2.getParameter(menus_BEAN.getTitulo()+"_ver");
                        String editar=request2.getParameter(menus_BEAN.getTitulo()+"_editar");
                        String excluir=request2.getParameter(menus_BEAN.getTitulo()+"_excluir");
                        String buscar=request2.getParameter(menus_BEAN.getTitulo()+"_buscar");
                        String salvar=request2.getParameter(menus_BEAN.getTitulo()+"_salvar");

                        try{						
                            try{restricao_BEAN.setId_menu(menus_BEAN.getID());}catch(Exception erro){}; 
                            try{restricao_BEAN.setVer(ver!=null);}catch(Exception erro){}; 
                            try{restricao_BEAN.setEditar(editar!=null);}catch(Exception erro){}; 
                            try{restricao_BEAN.setExcluir(excluir!=null);}catch(Exception erro){}; 
                            try{restricao_BEAN.setBuscar(buscar!=null);}catch(Exception erro){}; 
                            try{restricao_BEAN.setSalvar(salvar!=null);}catch(Exception erro){};
                            String acc=restricao_BEAN.getId_menuStr();
                            restricao_BEAN.setId_menu(acc);					
                            restricao_BEAN=restricao_DAO.salvarMenu(restricao_BEAN);
                            mensagem_acao="salvo com sucesso";
                            try{restricao_BEAN.setId_usuario(id_usuario);}catch(Exception erro){};
                        }
                        catch(Exception erro){
                            mensagem_acao=erro.getMessage();
                        }
                    }
                }
            }
%>
            <a class="texto1">Cadastro restricao</a><br><br>
            <form method="post" enctype="multipart/form-data">
                usuario:<select name="id_usuario" onchange="menuJump(this)">
                <%
                    Vector registros_usuario=(new usuarioDAO(minhaConexao)).buscarTodos();
                    if((registros_usuario!=null)&&(registros_usuario.size()>0)){
                    for(int i=0;i<registros_usuario.size();i++){
                        usuarioBEAN usuario_BEAN=((usuarioBEAN)registros_usuario.get(i)); 
                        if(i==0)                           
                            restricao_BEAN.setId_usuario(usuario_BEAN.getID());
                %>
                <option value="<%=usuario_BEAN.getIDStr()%>" <%
                if(functions.equals(id_usuario,usuario_BEAN.getIDStr())){
                    out.write("selected");
                    restricao_BEAN.setId_usuario(usuario_BEAN.getID());
                }
                %>>
                   <%=usuario_BEAN.getNome()%> 
                   ,
                   <%=usuario_BEAN.getLogin()%> 
                </option>
                <%
                        }
                    }
                %>
                </select>
                <br>
                <table cellpadding= "4" cellspacing = "0" border= "1" width= "400px">
                    <tr bgcolor="#CCCCCC">
                        <td><a class="texto3">menu</a></td>
                        <td><a class="texto3">ver</a></td>
                        <td><a class="texto3">editar</a></td>
                        <td><a class="texto3">salvar</a></td>
                        <td><a class="texto3">Excluir</a></td>
                        <td><a class="texto3">buscar</a></td>
                    </tr>
                    <%
                        if((menus!=null)&&(menus.size()>0)){
                            for(int i=0;i<menus.size();i++){
                                menus_BEAN=((menusBEAN)menus.get(i));
                                restricao_BEAN.setId_menu(menus_BEAN.getIDStr());
                                restricaoBEAN acc_restricao_BEAN=null;
                                try{acc_restricao_BEAN=restricao_DAO.buscarPorUsuarioEMenu(restricao_BEAN);}catch(Exception erro){}
                    %>
                    <tr>    
                        <td><%=menus_BEAN.getTitulo()%> </td>     
                        <td><input type="checkbox" value="true"  name="<%=menus_BEAN.getTitulo()%>_ver" <%=(acc_restricao_BEAN.getVer())?"checked":""%> ></td>     
                        <td><input type="checkbox" value="true"  name="<%=menus_BEAN.getTitulo()%>_editar" <%=(acc_restricao_BEAN.getEditar())?"checked":""%> ></td>     
                        <td><input type="checkbox" value="true"  name="<%=menus_BEAN.getTitulo()%>_salvar" <%=(acc_restricao_BEAN.getSalvar())?"checked":""%> ></td>     
                        <td><input type="checkbox" value="true"  name="<%=menus_BEAN.getTitulo()%>_excluir" <%=(acc_restricao_BEAN.getExcluir())?"checked":""%> ></td>     
                        <td><input type="checkbox" value="true"  name="<%=menus_BEAN.getTitulo()%>_buscar" <%=(acc_restricao_BEAN.getBuscar())?"checked":""%> ></td>     
                    </tr>
                    <%  
                            }
                        }
                        minhaConexao.Fechar();
                    %>                   
                    <tr>
                        <td colspan="6"><%if(restricao_acesso.getSalvar()){%><input type="submit" value="Salvar"  name="acao" ><%}%></td>     
                    </tr>
                </table>
            </form>
        </center>
    </body>
</html>
<%}%>