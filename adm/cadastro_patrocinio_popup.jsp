<%@page import="java.awt.Dimension"%>
<%@page import="java.util.Date"%>
<%@page import="DAO.tipoDAO"%>
<%@page import="BEAN.menusBEAN"%>
<%@page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@page import="POJO.tipoPOJO"%>
<%@page import="POJO.patrocinioPOJO"%>
<%@page import="DAO.patrocinioDAO"%>
<%@page import="BEAN.tipoBEAN"%>
<%@page import="BEAN.patrocinioBEAN"%>
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
        <title>Cadastro patrocinio</title>
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
                
                patrocinioBEAN patrocinio_BEAN=new patrocinioBEAN();
                patrocinioDAO patrocinio_DAO=new patrocinioDAO(minhaConexao);
                Vector registros_patrocinio=new Vector();
                Until.fileUpload request2=new Until.fileUpload();
                request2.setRequest(request);

                String id=request2.getParameter("id");
                id=((id!=null)&&(!id.equals("null")))?id:request.getParameter("id");
                String id_tipo=request.getParameter("id_tipo");
                String id_paginas=request.getParameter("id_paginas");
                id_paginas=((id_paginas!=null)&&(!id_paginas.equals("null")))?id_paginas:request.getParameter("id_paginas");
                String id_menus=request.getParameter("id_menus");
                id_menus=((id_menus!=null)&&(!id_menus.equals("null")))?id_menus:request.getParameter("id_menus");
                String url=request2.getParameter("url");
         
                String titulo=request2.getParameter("titulo");
                String popup="";
                String acao=request2.getParameter("acao");                
                
                String mensagem_id="";
                String mensagem_id_paginas="";
                String mensagem_id_menus="";
                String mensagem_id_tipo="";
                String mensagem_acao="";
                String mensagem_titulo="";
                
                String mensagem_url="";
                String mensagem_popup="";
                     
                try{patrocinio_BEAN.setid(id);}catch(Exception erro){mensagem_id="a patrocinio selecionado não existe";};
                try{patrocinio_BEAN.setid_tipo(id_tipo);}catch(Exception erro){mensagem_id_tipo=erro.getMessage();};
                try{patrocinio_BEAN.setid_paginas(id_paginas);}catch(Exception erro){mensagem_id_paginas=erro.getMessage();};
                try{patrocinio_BEAN.setid_menus(id_menus);}catch(Exception erro){mensagem_id_menus=erro.getMessage();};
                                    
                if((acao!=null)&&(acao.length()>0)){
                        try{patrocinio_BEAN.settitulo(titulo);}catch(Exception erro){mensagem_titulo=erro.getMessage();};
                        try{patrocinio_BEAN.seturl(url);}catch(Exception erro){mensagem_url=erro.getMessage();};
                        
                       if(acao.equals("Salvar")){
                                if (mensagem_titulo.length()==0){                             
                                    try{
                                         popup=request2.upload(//mostro o nome do arquivo enviado
                                                "popup",//name do input type file
                                                "publicidadeinicial",//pasta sub sequente da pasta upload
                                                new String[]{"jpg","gif","png","bmp"},//extesoes de arquivos 
                                                10*1024*1024//10 mb
                                        );
                                        popup=request2.redimensionarImagem(
                                            "publicidadeinicial"//pasta sub sequente da pasta upload
                                            ,popup//nome do arquivo enviado
                                            ,new String[]{""}//prefixos
                                            ,new Dimension[]{
                                                new Dimension(1024,768)//tamanho m_ 360px de largura e 240px de altura
                                            }
                                        );
                                        try{patrocinio_BEAN.setpopup(popup);}catch(Exception erro){mensagem_popup=erro.getMessage();};
                                        
                                        
                                        
                                        if ((id!=null)&&(id.length()!=0))
                                            
                                        if(mensagem_popup.length()==0){
                                            patrocinio_BEAN=patrocinio_DAO.alterar2(patrocinio_BEAN,functions.path_upload);
                                            registros_patrocinio.add(patrocinio_BEAN);
                                            if((patrocinio_BEAN!=null)&&(patrocinio_BEAN.getidStr()!=null)){
                                                mensagem_acao="Foto salva com sucesso";
                                            }
                                            else
                                                mensagem_acao="Não foi possível cadastrar";
                                        }
                                        else{
                                            functions.deletaImagensRedimencionadas(popup,functions.path_upload);
                                        }
                                        mensagem_id=""; 
                                    }
                                    catch(Exception erro){
                                        mensagem_acao=erro.getMessage();
                                    }
                                }
                                else
                                    patrocinio_BEAN.Clear();
                            }                        
                            else if(acao.equals("Excluir")){
                                if (
                                    (mensagem_id.length()==0)                                                                                  
                                ){
                                     patrocinio_BEAN=patrocinio_DAO.excluirpopup(patrocinio_BEAN,functions.path_upload); 
                                    if(
                                            (patrocinio_BEAN!=null)
                                            &&(patrocinio_BEAN.getidStr()!=null)
                                            &&(patrocinio_BEAN.getpopup()==null)
                                    ){
                                        mensagem_acao="Foto excluída com sucesso";
                                    }
                                    else{
                                        mensagem_acao="Foto não encontrada";
                                    }                                  
                                }
                                mensagem_id="";
                                mensagem_acao="";
                                mensagem_titulo="";
                                mensagem_id_paginas="";
                                mensagem_id_menus="";
                                mensagem_url="";
                                mensagem_id_tipo="";
                                patrocinio_BEAN.Clear();
                            }
                            
                    }
                    mensagem_id="";
                    mensagem_id_paginas="";
                    mensagem_id_tipo="";
                    mensagem_id_menus="";
                    try{registros_patrocinio.add(patrocinio_DAO.buscarid(patrocinio_BEAN));}catch(Exception erro){}
                    patrocinio_BEAN.Clear();
            %>
            <a class="texto1">Cadastro Patrocinio</a><br><br>
            <form method="post" enctype="multipart/form-data">
                <input type="hidden" name="id" value="<%=id%>" id="id">
                <input type="hidden" name="id_paginas" value="<%=id_paginas%>">
                <input type="hidden" name="id_menus" value="<%=id_menus%>">
                <input type="hidden" name="id_tipo" value="<%=id_tipo%>">
                <input type="hidden" name="titulo" value="toledonews">
               <input type="hidden" name="url" value="<%=functions.removenull(patrocinio_BEAN.geturl())%>">
             <a class="texto3">popup</a>: <input type="file" name="popup" value="<%=functions.removenull(patrocinio_BEAN.getsrc())%>"><br>
               <div style="clear:both;color:red"><%=mensagem_popup%></div>
               <input type="submit" value="atualizar">
               <input type="submit" value="Salvar" name="acao">              
               <input type="submit" value="Buscar" name="acao"><br>
               <a href="cadastro_patrocinio.jsp?id_menus=<%=id_menus%>&id_tipo=<%=id_tipo%>" > << voltar para patrocineo </a>
               <div style="clear:both;color:red"><%=mensagem_acao%></div>
            </form>
 
                <table cellpadding= "4" cellspacing = "0" border= "1" width= "400px">
                    <tr bgcolor="#CCCCCC"> 
                        <td><a class="texto3">Titulo </a> </td>
                        <td><a class="texto3"> URL </a> </td>
                        <td><a class="texto3"> acao </a> </td>
		    </tr>
<%
                            if((registros_patrocinio!=null)&&(registros_patrocinio.size()>0)){
                                for(int i=0;i<registros_patrocinio.size();i++){
                                    patrocinio_BEAN=((patrocinioBEAN)registros_patrocinio.get(i));
                                    if(patrocinio_BEAN.getidStr()==null)
                                        break;
%>
                        <tr>
                            <td> <%=Until.functions.removenull(patrocinio_BEAN.gettitulo())%> </td>
                            <td> <%=Until.functions.removenull(patrocinio_BEAN.geturl())%> </td>
                            <td width="150px">
                                <form method="post" >
                                    <input type="hidden" name="id" value="<%=patrocinio_BEAN.getidStr()%>">
                                    <input type="hidden" name="id_tipo" value="<%=patrocinio_BEAN.getid_tipoStr()%>">
                                    <input type="hidden" name="id_pagina" value="<%=patrocinio_BEAN.getid_paginasStr()%>">
                                    <input type="hidden" name="id_menus" value="<%=patrocinio_BEAN.getid_menusStr()%>">
                                    <input type="submit" value="Excluir" name="acao">
                                </form>
                            </td>
                        </tr>
                        <tr>
                            <td COLSpan="3" align="center">
                                <h1>Anuncio</h1>
                            </td>
                        </tr>
                        <tr>
                            <td COLSpan="3" align="center">
                                <a target="_black" href="./arquivo.jsp?nome=<%=patrocinio_BEAN.getsrc()%>&pasta=publicidadeinicial" ><img align="center" src="./arquivo.jsp?nome=<%=patrocinio_BEAN.getsrc()%>&pasta=publicidadeinicial"></a>
                            </td>
                        </tr>
                        <tr>
                            <td COLSpan="3" align="center">
                                <h1>POPUP</h1>
                            </td>
                        </tr>

                        <tr>
                            <td COLSpan="3" align="center">
                                <a target="_black" href="./arquivo.jsp?nome=<%=patrocinio_BEAN.getpopup()%>&pasta=publicidadeinicial" ><img align="center" src="./arquivo.jsp?nome=<%=patrocinio_BEAN.getpopup()%>&pasta=publicidadeinicial"></a>
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