<%@page import="DAO.paginas_administrativasDAO"%>
<%@page import="BEAN.paginas_administrativasBEAN"%>
<%@page import="DAO.paginasDAO"%>
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
           
            paginas_administrativasBEAN paginas_administrativas_BEAN=new paginas_administrativasBEAN();
            paginas_administrativasDAO paginas_administrativas_DAO=new paginas_administrativasDAO(minhaConexao);
            
            restricaoBEAN restricao_BEAN=new restricaoBEAN();
            restricaoDAO restricao_DAO=new restricaoDAO(minhaConexao);
            Until.functions request2=new Until.functions();
            request2.setRequest(request);

            String id_usuario=request2.getParameter("id_usuario");
            String id_pagina=request2.getParameter("id_pagina");
            
            String acao=request2.getParameter("acao");                

            String mensagem_acao="";
            String mensagem_id_usuario="";
             
            Vector paginas=paginas_administrativas_DAO.buscarTodos();
            
            

            try{restricao_BEAN.setId_usuario(id_usuario);}catch(Exception erro){}; 
            if((acao!=null)&&(acao.length()>0)&&(acao.equals("Salvar"))){     
                if((paginas!=null)&&(paginas.size()>0)){
                    for(int i=0;i<paginas.size();i++){
                        paginas_administrativas_BEAN=((paginas_administrativasBEAN)paginas.get(i));
                        String ver=request2.getParameter(paginas_administrativas_BEAN.getnome()+"_ver");
                        String editar=request2.getParameter(paginas_administrativas_BEAN.getnome()+"_editar");
                        String excluir=request2.getParameter(paginas_administrativas_BEAN.getnome()+"_excluir");
                        String buscar=request2.getParameter(paginas_administrativas_BEAN.getnome()+"_buscar");
                        String salvar=request2.getParameter(paginas_administrativas_BEAN.getnome()+"_salvar");

                        try{						
                            try{restricao_BEAN.setId_pagina(paginas_administrativas_BEAN.getID());}catch(Exception erro){}; 
                            try{restricao_BEAN.setVer(ver!=null);}catch(Exception erro){}; 
                            try{restricao_BEAN.setEditar(editar!=null);}catch(Exception erro){}; 
                            try{restricao_BEAN.setExcluir(excluir!=null);}catch(Exception erro){}; 
                            try{restricao_BEAN.setBuscar(buscar!=null);}catch(Exception erro){}; 
                            try{restricao_BEAN.setSalvar(salvar!=null);}catch(Exception erro){};
                            String acc=restricao_BEAN.getId_paginaStr();						
                            restricao_BEAN=restricao_DAO.salvarPagina(restricao_BEAN);
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
                        <td><a class="texto3">pagina</a></td>
                        <td><a class="texto3">ver</a></td>
                        <td><a class="texto3">editar</a></td>
                        <td><a class="texto3">salvar</a></td>
                        <td><a class="texto3">Excluir</a></td>
                        <td><a class="texto3">buscar</a></td>
                    </tr>
                    <%
                        if((paginas!=null)&&(paginas.size()>0)){
                            for(int i=0;i<paginas.size();i++){
                                paginas_administrativas_BEAN=((paginas_administrativasBEAN)paginas.get(i));
                                
                                restricao_BEAN.setId_pagina(paginas_administrativas_BEAN.getIDStr());
                                restricaoBEAN acc_restricao_BEAN=null;
                                try{acc_restricao_BEAN=restricao_DAO.buscarPorUsuarioEPagina(restricao_BEAN);}catch(Exception erro){}
                    %>
                    <tr>    
                        <td><%=paginas_administrativas_BEAN.getnome( )%> </td>     
                        <td><input type="checkbox" value="true"  name="<%=paginas_administrativas_BEAN.getnome( )%>_ver" <%=(acc_restricao_BEAN.getVer())?"checked":""%> ></td>     
                        <td><input type="checkbox" value="true"  name="<%=paginas_administrativas_BEAN.getnome( )%>_editar" <%=(acc_restricao_BEAN.getEditar())?"checked":""%> ></td>     
                        <td><input type="checkbox" value="true"  name="<%=paginas_administrativas_BEAN.getnome( )%>_salvar" <%=(acc_restricao_BEAN.getSalvar())?"checked":""%> ></td>     
                        <td><input type="checkbox" value="true"  name="<%=paginas_administrativas_BEAN.getnome( )%>_excluir" <%=(acc_restricao_BEAN.getExcluir())?"checked":""%> ></td>     
                        <td><input type="checkbox" value="true"  name="<%=paginas_administrativas_BEAN.getnome( )%>_buscar" <%=(acc_restricao_BEAN.getBuscar())?"checked":""%> ></td>     
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