<%@page import="java.util.Date"%>
<%@page import="DAO.comentariosDAO"%>
<%@page import="BEAN.comentariosBEAN"%>
<%@page import="POJO.comentariosPOJO"%>
<%@page import="BEAN.menusBEAN"%>
<%@page import="Until.functions"%>
<%@page import="java.util.Vector"%>
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
        <title>Cadastro comentarios</title>
        <link rel="shortcut icon" href="./midia_mix.png" type="image/x-icon"/>
        <script type="text/javascript" src="./js/relogio.js"></script>
    </head>                                        
    <body onload="relogio();">                      
        <center> 
<%
                Conexao minhaConexao=null;
                minhaConexao=(Conexao)session.getAttribute("minhaConexaoadm");
                
                String acc="/";
                if (functions.path_upload.indexOf(acc)==-1)
                    acc="\\";
                
                String path=functions.path_upload+acc+"publicidadeinicial";
                
                comentariosBEAN comentarios_BEAN=new comentariosBEAN();
                comentariosDAO comentarios_DAO=new comentariosDAO(minhaConexao);
                Vector registros_comentarios=new Vector();
                Until.functions request2=new Until.functions();
                request2.setRequest(request);

                String id=request2.getParameter("id");
                String id_paginas=request2.getParameter("id_paginas");
                id_paginas=((id_paginas!=null)&&(!id_paginas.equals("null")))?id_paginas:request.getParameter("id_paginas");
                String id_menus=request2.getParameter("id_menus");
                id_menus=((id_menus!=null)&&(!id_menus.equals("null")))?id_menus:request.getParameter("id_menus");
                String comentario=request2.getParameter("comentario");
                String autor=request2.getParameter("autor");
                String acao=request2.getParameter("acao");                
                
                String mensagem_id="";
                String mensagem_id_paginas="";
                String mensagem_id_menus="";
                String mensagem_acao="";
                String mensagem_autor="";
                String mensagem_comentario="";
                String mensagem_popup="";
                     
                try{comentarios_BEAN.setID(id);}catch(Exception erro){mensagem_id="a comentarios selecionado não existe";};
                try{comentarios_BEAN.setid_paginas(id_paginas);}catch(Exception erro){mensagem_id_paginas=erro.getMessage();};
                try{comentarios_BEAN.setId_menus(id_menus);}catch(Exception erro){mensagem_id_menus=erro.getMessage();};
                                    
                if((acao!=null)&&(acao.length()>0)){
                        try{comentarios_BEAN.setAutor(autor);}catch(Exception erro){mensagem_autor=erro.getMessage();};
                        try{comentarios_BEAN.setComentario(comentario);}catch(Exception erro){mensagem_comentario=erro.getMessage();};
                        
                        if(acao.equals("Buscar")){
                            comentariosPOJO comentarios_POJO = new comentariosPOJO();
                            comentarios_POJO.setautor(autor);
                            comentarios_POJO.setComentario(comentario);
                            comentarios_BEAN= new comentariosBEAN(comentarios_POJO);
                            try{comentarios_BEAN.setId_menus(id_menus);}catch(Exception erro){mensagem_id_menus=erro.getMessage();};
                            try{comentarios_BEAN.setid_paginas(id_paginas);}catch(Exception erro){mensagem_id_paginas=erro.getMessage();};
                            try{comentarios_BEAN.setExibir(false);}catch(Exception erro){};
                            try{registros_comentarios=comentarios_DAO.buscarComentarios(comentarios_BEAN);}catch(Exception erro){mensagem_acao=erro.getMessage();};                            
                            mensagem_id="";
                            mensagem_acao="";
                            mensagem_id_paginas="";
                            mensagem_id_menus="";
                            mensagem_autor="";
                            mensagem_comentario="";
                        }
                        else if(acao.equals("Salvar")){
                                if (mensagem_autor.length()==0){                             
                                    try{
                                            comentarios_BEAN=comentarios_DAO.salvar(comentarios_BEAN);
                                            registros_comentarios.add(comentarios_BEAN);
                                            if((comentarios_BEAN!=null)&&(comentarios_BEAN.getIDStr()!=null)){
                                                mensagem_acao="Foto salva com sucesso";
                                            }
                                            else
                                                mensagem_acao="Não foi possível cadastrar";
                                        mensagem_id=""; 
                                    }
                                    catch(Exception erro){
                                        mensagem_acao=erro.getMessage();
                                    }
                                }
                                else
                                    comentarios_BEAN.Clear();
                            }                        
                            else if(acao.equals("Excluir")){
                                if (
                                    (mensagem_id.length()==0)                                                                                  
                                ){
                                    comentarios_BEAN=comentarios_DAO.excluir(comentarios_BEAN); 
                                    if((comentarios_BEAN!=null)&&(comentarios_BEAN.getIDStr()!=null)){
                                        mensagem_acao="Foto excluída com sucesso";
                                    }
                                    else{
                                        mensagem_acao="Foto não encontrada";
                                    }                                    
                                }
                                mensagem_id="";
                                mensagem_acao="";
                                mensagem_autor="";
                                mensagem_id_paginas="";
                                mensagem_id_menus="";
                                mensagem_comentario="";
                                comentarios_BEAN.Clear();
                            }
                            else if(acao.equals("editar")){
                                comentarios_BEAN=((comentariosBEAN)comentarios_DAO.buscarid(comentarios_BEAN));
                                if((comentarios_BEAN!=null)&&(comentarios_BEAN.getIDStr()!=null)){
                                    registros_comentarios.add(comentarios_BEAN);
                                }
                                else{
                                    comentarios_BEAN.Clear();
                                }
                                mensagem_id="";
                                mensagem_acao="";
                                mensagem_autor="";
                                mensagem_id_paginas="";
                                mensagem_comentario="";                                                    
                                mensagem_id_menus="";                                                          
                            }
                            else if(acao.equals("novo")){
                                mensagem_id="";
                                mensagem_acao="";
                                mensagem_autor="";
                                mensagem_id_paginas="";
                                mensagem_id_menus="";
                                mensagem_comentario="";
                                comentarios_BEAN.Clear();
                            }else if(acao.equals("Ativar")){
                                if (
                                    (mensagem_id.length()==0)                                                                                  
                                )
                                {
                                    comentarios_BEAN=comentarios_DAO.Ativar(comentarios_BEAN); 
                                }
                                mensagem_id=""; 
                                mensagem_acao="";
                                mensagem_autor="";
                                mensagem_id_paginas="";
                                mensagem_comentario="";                                                    
                                mensagem_id_menus="";
                                try{registros_comentarios=comentarios_DAO.buscarUltimosDesativos(50);}catch(Exception erro){}
                                comentarios_BEAN.Clear();
                            }
                            else if(acao.equals("Desativar")){
                                    if (
                                        (mensagem_id.length()==0)                                                                                  
                                    )
                                    {
                                        comentarios_BEAN=comentarios_DAO.Desativar(comentarios_BEAN); 
                                    }
                                    mensagem_id=""; 
                                    mensagem_acao="";
                                    mensagem_autor="";
                                    mensagem_id_paginas="";
                                    mensagem_comentario="";                                                    
                                    mensagem_id_menus="";
                                    try{registros_comentarios=comentarios_DAO.buscarUltimosDesativos(50);}catch(Exception erro){}
                                    comentarios_BEAN.Clear();
                            }
                    }
                    else {
                        mensagem_id="";
                        mensagem_id_paginas="";
                        mensagem_id_menus="";
                        try{registros_comentarios=comentarios_DAO.buscarUltimosDesativos(50);}catch(Exception erro){}
                        comentarios_BEAN.Clear();
                    }
            %>
            <a class="texto1">Cadastro comentarios</a><br><br>
            <form method="post" enctype="multipart/form-data">
                <div style="clear:both;color:red"><%=mensagem_id%></div>
               <br>
                <input type="hidden" name="id" value="<%=functions.removenull(comentarios_BEAN.getIDStr())%>" id="id"><br>
                <input type="hidden" name="id_paginas" value="<%=id_paginas%>"><br>
                <input type="hidden" name="id_menus" value="<%=id_menus%>"><br>

               <a class="texto3">autor:</a> 
                <input type="text" name="autor" value="<%=functions.removenull(comentarios_BEAN.getAutor())%>"><br>
               <div style="clear:both;color:red"><%=mensagem_autor%></div>
               <a class="texto3">comentario:</a> <input type="text" name="comentario" value="<%=functions.removenull(comentarios_BEAN.getComentario())%>"><br>
               <div style="clear:both;color:red"><%=mensagem_comentario%></div>
               
               <div style="clear:both;color:red"><%=mensagem_popup%></div>
               <input type="submit" value="novo" onclick="document.getElementById('id').value=''">
               <input type="submit" value="Salvar" name="acao">              
               <input type="submit" value="Buscar" name="acao">
               <div style="clear:both;color:red"><%=mensagem_acao%></div>
            </form>
 
                <table cellpadding= "4" cellspacing = "0" border= "1" width= "400px">
                    <tr bgcolor="#CCCCCC"> 
                        <td><a class="texto3">autor </a> </td>
                        <td><a class="texto3"> comentario </a> </td>
                        <td><a class="texto3"> menu </a> </td>
                        <td><a class="texto3"> pagina </a> </td>
                        <td><a class="texto3"> acao </a> </td>
		    </tr>
<%
                            if((registros_comentarios!=null)&&(registros_comentarios.size()>0)){
                                for(int i=0;i<registros_comentarios.size();i++){
                                    comentarios_BEAN=((comentariosBEAN)registros_comentarios.get(i));
                                    if(comentarios_BEAN.getIDStr()==null)
                                        break;
%>
                        <tr>
                            <td> <%=Until.functions.removenull(comentarios_BEAN.getAutor())%> </td>
                            <td> <%=Until.functions.removenull(comentarios_BEAN.getComentario())%> </td>
                            <td> <%=((comentarios_BEAN.getMenu()!=null)&&(comentarios_BEAN.getMenu().length()!=0))?comentarios_BEAN.getMenu():"home"%> </td>
                            <td> <%=((comentarios_BEAN.getPagina()!=null)&&(comentarios_BEAN.getPagina().length()!=0))?comentarios_BEAN.getPagina():"home"%> </td>
                            <td width="150px">
                                <form method="post" >
                                    <input type="hidden" name="id" value="<%=comentarios_BEAN.getIDStr()%>">
                                    <input type="hidden" name="id_pagina" value="<%=comentarios_BEAN.getid_paginasStr()%>">
                                    <input type="hidden" name="id_menus" value="<%=comentarios_BEAN.getId_menusStr()%>">
                                    <input type="submit" name="acao" value="editar">
                                    <input type="submit" value="Excluir" name="acao">
                                    <%if(comentarios_BEAN.getExibir()){%>
                                    <input type="submit" value="Desativar" name="acao">
                                    <%}
                                    else{%>    
                                    <input type="submit" value="Ativar" name="acao">
                                    <%}%>
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