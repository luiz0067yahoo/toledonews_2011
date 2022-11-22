<%@page import="java.util.Date"%>
<%@page language="java" contentType="text/html;charset=UTF-8"	pageEncoding="UTF-8" %>
<%@page import="BEAN.categoriaVideosBEAN"%>
<%@page import="DAO.categoriaVideosDAO"%>
<%@page import="POJO.videosPOJO"%>
<%@page import="BEAN.videosBEAN"%>
<%@page import="DAO.videosDAO"%>
<%@page import="BEAN.videosBEAN"%>
<%@page import="DAO.videosDAO"%>
<%@page import="DAO.videosDAO"%>
<%@page import="Until.functions"%>
<%@page import="java.util.Vector"%>
<%@page import="DAO.videosDAO"%>
<%@page import="BEAN.videosBEAN"%>
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
        <title>Cadastro vídeos</title>
        <link rel="shortcut icon" href="./midia_mix.png" 	type="image/x-icon" />
        <script type="text/javascript" src="./js/relogio.js"></script>
    </head>
    <body >    
        <center>
<%
                Conexao minhaConexao=null;
                minhaConexao=(Conexao)session.getAttribute("minhaConexaoadm");
                
                
                
                videosBEAN videos_BEAN=new videosBEAN();
                videosDAO videos_DAO=new videosDAO(minhaConexao);
                Vector registros_videos=new Vector();

                String ID=request.getParameter("id");
                String id_categoria=request.getParameter("id_categoria");
                String acao=request.getParameter("acao");                
                
                String mensagem_ID="";
                String mensagem_acao="";
                String mensagem_Titulo="";
                String mensagem_descricao="";
                String mensagem_id_categoria="";          
                String mensagem_Src="";
                     
                try{videos_BEAN.setID(ID);}catch(Exception erro){mensagem_ID="a Videos selecionada não existe";};
                try{videos_BEAN.setId_Categoria(id_categoria);}catch(Exception erro){mensagem_id_categoria=erro.getMessage();}; 
                    
                if((acao!=null)&&(acao.length()>0)){                       
                        String Titulo=request.getParameter("Titulo");
                        String descricao=request.getParameter("descricao");

                        try{videos_BEAN.setTitulo(Titulo);}catch(Exception erro){mensagem_Titulo=erro.getMessage();};
                        try{videos_BEAN.setDescricao(descricao);}catch(Exception erro){mensagem_descricao=erro.getMessage();}; 
                        
                        if(acao.equals("Buscar")){
                            videosPOJO  videos_POJO = new videosPOJO();
                            videos_POJO.setTitulo(Titulo);
                            videos_POJO.setDescricao(descricao);
                            videos_BEAN= new videosBEAN(videos_POJO);
                            try{registros_videos=videos_DAO.buscar(videos_BEAN);}catch(Exception erro){mensagem_acao=erro.getMessage();};                            
                            mensagem_ID="";
                            mensagem_acao="";
                            mensagem_Titulo="";
                            mensagem_descricao="";
                            mensagem_Src="";
                            mensagem_id_categoria=""; 
                        }
                        else if(acao.equals("Salvar")){
                                if (
                                    (mensagem_Titulo.length()==0)
                                    &&
                                    (mensagem_descricao.length()==0)
                                    && 
                                    (mensagem_id_categoria.length()==0)                                                                                                                           
                                ){
                                    //insert                               
                                    try{
                                        String Src=request.getParameter("Src");
                                        try{videos_BEAN.setSrc(Src);}catch(Exception erro){mensagem_Src=erro.getMessage();}; 
                                        if(mensagem_Src.length()==0){
                                            videos_BEAN=videos_DAO.salvar(videos_BEAN);
                                            registros_videos.add(videos_BEAN);
                                        }
                                    }
                                    catch(Exception erro){
                                        mensagem_acao=erro.getMessage();
                                        mensagem_acao="Videos salva com sucesso";
                                    }
                                    mensagem_ID="";
                                    mensagem_id_categoria="";
                                }
                            }                        
                            else if(acao.equals("Excluir")){
                                if (
                                    (mensagem_ID.length()==0)                                                                                  
                                )
                                {
                                    videos_BEAN=videos_DAO.excluir(videos_BEAN); 
                                    if((videos_BEAN!=null)&&(videos_BEAN.getIDStr()!=null)){
                                        mensagem_acao="Videos excluído com sucesso";
                                    }
                                    else{
                                        mensagem_acao="Videos não encontrado";
                                    }                                    
                                }
                                mensagem_ID=""; 
                                mensagem_Titulo="";
                                mensagem_descricao="";
                                mensagem_Src="";
                                mensagem_id_categoria="";
                            }
                            else if(acao.equals("editar")){                                
                                videos_BEAN=((videosBEAN)videos_DAO.buscarID(videos_BEAN));
                                if((videos_BEAN!=null)&&(videos_BEAN.getIDStr()!=null)){
                                    registros_videos.add(videos_BEAN);
                                    mensagem_id_categoria="";
                                }
                                else{
                                    try{videos_BEAN.setId_Categoria(id_categoria);}catch(Exception erro){mensagem_id_categoria=erro.getMessage();}; 
                                    mensagem_id_categoria="";
                                    registros_videos=videos_DAO.buscarPorCategoria(videos_BEAN);
                                }
                                mensagem_ID=""; 
                                mensagem_Titulo="";
                                mensagem_descricao="";
                                mensagem_Src="";
                                mensagem_id_categoria="";                                                               
                            }
                            else if(acao.equals("novo")){
                                mensagem_ID=""; 
                                mensagem_Titulo="";
                                mensagem_descricao="";
                                mensagem_Src="";
                                mensagem_id_categoria="";
                            }
                    }
                    else{
                        mensagem_ID="";
                        try{videos_BEAN.setId_Categoria(id_categoria);}catch(Exception erro){mensagem_id_categoria=erro.getMessage();}; 
                        mensagem_id_categoria="";
                        registros_videos=videos_DAO.buscarPorCategoria(videos_BEAN);
                    }
%>
            Cadastro vídeos<br><br>
            <form method="post" >
                <div style="clear:both;color:red"><%=mensagem_ID%></div>
                Categoria: <select name="id_categoria" onchange="menuJump(this)">
<%
                Vector registros_categoria=(new categoriaVideosDAO(minhaConexao)).buscarTodos();
               if((registros_categoria!=null)&&(registros_categoria.size()>0)){
                 for(int i=0;i<registros_categoria.size();i++){
                              categoriaVideosBEAN categoria_BEAN=((categoriaVideosBEAN)registros_categoria.get(i));      
%>
                <option value="<%=categoria_BEAN.getIDStr()%>" <%
                    if(functions.equals(videos_BEAN.getId_CategoriaStr(),categoria_BEAN.getIDStr())) 
                        out.write("selected");
                %>>
                       <%=categoria_BEAN.getTitulo()%>
                </option>
<%
                        }
                    }
%>
               </select><br>
               <div style="clear:both;color:red"><%=mensagem_id_categoria%></div>
               <input type="hidden" name="id" value="<%=Until.functions.removenull(videos_BEAN.getIDStr())%>"><br>
               Titulo: <input type="text" name="Titulo" value="<%=Until.functions.removenull(videos_BEAN.getTitulo())%>"><br>
               <div style="clear:both;color:red"><%=mensagem_Titulo%></div>
               Descrição: <input type="text" name="descricao" value="<%=Until.functions.removenull(videos_BEAN.getDescricao())%>"><br>
               <div style="clear:both;color:red"><%=mensagem_descricao%></div>
               Vídeos: <input type="text" name="Src" value="<%=Until.functions.removenull(videos_BEAN.getSrc())%>"><br>
               <div style="clear:both;color:red"><%=mensagem_Src%></div>
               <a href="?id_categoria=<%=videos_BEAN.getId_CategoriaStr()%>"><input type="button" value="novo" ></a>
               <%if(restricao_acesso.getSalvar()){%><input type="submit" value="Salvar" name="acao"><%}%>              
               <%if(restricao_acesso.getBuscar()){%><input type="submit" value="Buscar" name="acao"><%}%>
               <div style="clear:both;color:red"><%=mensagem_acao%></div>
            </form>
 
                <table cellpadding= "4" cellspacing = "0" border= "1" width= "400px">
                    <tr>   
                        <td> Titulo </td>
                        <td> descrição </td>
                        <td> acao </td>
		    </tr>
<%
                            if((registros_videos!=null)&&(registros_videos.size()>0)){
                                for(int i=0;i<registros_videos.size();i++){
                                    videos_BEAN=((videosBEAN)registros_videos.get(i));
                                    if(videos_BEAN.getIDStr()==null)
                                        break;
%>
                        <tr>
                            <td> <%=Until.functions.removenull(videos_BEAN.getTitulo())%> </td>     
                            <td> <%=Until.functions.removenull(videos_BEAN.getDescricao())%> </td> 
                            <td width="150px">
                                <form method="post">
                                    <input type="hidden" name="id" value="<%=videos_BEAN.getIDStr()%>">
                                    <%if(restricao_acesso.getEditar()){%><input type="submit" name="acao" value="editar"><%}%>
                                    <%if(restricao_acesso.getExcluir()){%><input type="submit" value="Excluir" name="acao"><%}%>
                                </form>
                            </td>
                        </tr>
                        <tr>
                            <td COLSpan="3" align="center">

                                <object width="560" height="315">
                                    <param name="movie" value="http://www.youtube.com/v/<%=Until.functions.getFile(videos_BEAN.getSrc())%>?version=3&amp;hl=pt_BR"></param>
                                    <param name="allowFullScreen" value="true"></param>
                                    <param name="allowscriptaccess" value="always"></param>
                                    <embed src="http://www.youtube.com/v/<%=Until.functions.getFile(videos_BEAN.getSrc())%>?version=3&amp;hl=pt_BR" type="application/x-shockwave-flash" width="560" height="315" allowscriptaccess="always" allowfullscreen="true">

                                    </embed>
                                </object>    
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