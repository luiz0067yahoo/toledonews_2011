<%@page import="java.awt.Dimension"%>
<%@page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="DAO.menusBairrosDAO"%>
<%@page import="BEAN.menusBairrosBEAN"%>
<%@page import="java.util.Date"%>
<%@page import="net.fckeditor.FCKeditor"%>
<%@page import="POJO.paginasBairrosPOJO"%>
<%@page import="java.util.Vector"%>
<%@page import="DAO.paginasBairrosDAO"%>
<%@page import="BEAN.paginasBairrosBEAN"%>
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
        <meta http-equiv="Content-Type" content="text/html;charset=UTF-8"/>
        <title>Cadastro Página Toledo news</title>

        <script type="text/javascript" src="./js/home.js"></script>
        <script src="../SpryAssets/SpryTabbedPanels.js" type="text/javascript"></script>
        <script src="../slideshow/script.js" type="text/javascript"></script>
        <script src="../Scripts/swfobject_modified.js" type="text/javascript"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.4.4/jquery.min.js" type="text/javascript" charset="utf-8"></script>
        <script src="../fonts/specimen_files/easytabs.js" type="text/javascript" charset="utf-8"></script>

        <link rel="shortcut icon" href="./midia_mix.png"  type="image/x-icon"/>
        <link rel="stylesheet"    href="./estilosadm.css" type="text/css"/>
        <link rel="stylesheet"    href="../fonts/specimen_files/specimen_stylesheet.css" type="text/css" charset="utf-8" />
        <link rel="stylesheet"    href="../fonts/stylesheet.css" type="text/css" charset="utf-8" />
        <link rel="stylesheet"    href="../SpryAssets/SpryTabbedPanels.css" type="text/css" />
        <link rel="stylesheet"    href="../slideshow/style.css" type="text/css" />
        <link rel="shortcut icon" href="../images/home/favicon.ico"/>
        
        <style type="text/css">
            @import url('./css/home.css');
            @font-face{
                font-family:'MirageRegular';
                src: url('./fonts/magenta_bbt-webfont.eot');
                src: url('./fonts/magenta_bbt-webfont.eot?#iefix') format('embedded-opentype'), url('fonts/magenta_bbt-webfont.woff') format('woff'), url('fonts/magenta_bbt-webfont.ttf') format('truetype'), url('fonts/magenta_bbt-webfont.svg#MirageRegular') format('svg');
                font-weight: normal;
                font-style: normal;
            }
            #apDiv1{
                position:absolute;
                left:1263px;
                top:109px;
                width:41px;
                height:23px;
                z-index:1;
            }
            #apDiv2{
                position:absolute;
                left:728px;
                top:568px;
                width:248px;
                height:32px;
                z-index:1;
            }
        </style>
    </head>
    <body onload="relogio();">
            <%

                Conexao minhaConexao=null;
                //try{minhaConexao=(Conexao)session.getAttribute("minhaConexaoadm");}
                //catch(Exception erro){minhaConexao=new Conexao(Until.functions.CreateDataConection());}
                minhaConexao=new Conexao(Until.functions.CreateDataConection());
                                  
                paginasBairrosBEAN paginas_BEAN=new paginasBairrosBEAN();
                menusBEAN menus_BEAN=new menusBEAN();
                paginasBairrosDAO paginas_DAO = new paginasBairrosDAO(minhaConexao); 
                Vector registros_Paginas=new Vector();
                Vector registros_Menus=new Vector();
                Until.fileUpload request2=new Until.fileUpload(); 
                
                request2.setRequest(request); 
                String acc="";
                if ((functions.path_upload!=null)&&(functions.path_upload.indexOf("\\")!=-1))
                    acc="\\";
                else
                    acc="/";
                 
                String path=functions.path_upload+acc+"conteudo";
                String id=request2.getParameter("id");
                if((id!=null)&&(id.length()!=0)&&(!id.equals("null")))
                    id=id;
                else
                    id=request.getParameter("id");
                String id_menu=request.getParameter("id_menu");
                String Src="";
                String Titulo=request2.getParameter("Titulo");
                String SubTitulo=request2.getParameter("SubTitulo");
                String Conteudo=request2.getParameter("conteudo");
                String Fonte=request2.getParameter("Fonte");
                String acao=request2.getParameter("acao");
                
                String mensagem_ID="";
                String mensagem_ID_menus="";
                String mensagem_acao="";
                String mensagem_Src="";
                String mensagem_Titulo="";
                String mensagem_SubTitulo="";
                String mensagem_Conteudo="";
                String mensagem_Fonte="";
                
                if((acao!=null)&&(acao.length()>0)){
                    try{paginas_BEAN.setID(id);}catch(Exception erro){mensagem_ID=erro.getMessage();}; 
                    try{paginas_BEAN.setIDMenus(id_menu);}catch(Exception erro){mensagem_ID_menus=erro.getMessage();}; 
                    if(acao.equals("Buscar")){
                        paginasBairrosPOJO  paginas_POJO=new paginasBairrosPOJO();
                        paginas_POJO.setTitulo(Titulo);
                        paginas_BEAN=new paginasBairrosBEAN(paginas_POJO);
                        try{registros_Paginas=paginas_DAO.buscar(paginas_BEAN,menus_BEAN);}catch(Exception erro){mensagem_acao=erro.getMessage();};                            
                        mensagem_ID="";
                        mensagem_ID_menus="";
                        mensagem_Titulo="";
                        mensagem_acao="";
                        mensagem_Fonte="";                                               
                    }
                    else if(acao.equals("Salvar")){
                        try{
                            try{paginas_BEAN.setTitulo(Titulo);}catch(Exception erro){mensagem_Titulo=erro.getMessage();}; 
                            try{paginas_BEAN.setSubTitulo(SubTitulo);}catch(Exception erro){mensagem_SubTitulo=erro.getMessage();}; 
                            try{paginas_BEAN.setConteudo(Conteudo);}catch(Exception erro){mensagem_Conteudo=erro.getMessage();}; 
                            try{paginas_BEAN.setFonte(Fonte);}catch(Exception erro){mensagem_Fonte=erro.getMessage();}; 
                            try{
                                Src=request2.upload("src","conteudo",new String[]{"jpg","gif","png","bmp"},3*1024*1024);
                                Src=request2.redimensionarImagem(
                                    "conteudo"
                                    ,Src
                                    ,new String[]{"p_","m_","g_","h_"}
                                    ,new Dimension[]{
                                         new Dimension( 69, 52)
                                        ,new Dimension(230,111)
                                        ,new Dimension(445,260)
                                        ,new Dimension(510,279)       
                                    }
                                );
                                try{paginas_BEAN.setSrc(Src);}catch(Exception erro){mensagem_Src=erro.getMessage();};
                            }
                            catch(Exception erro1){}
                                           
                            paginas_BEAN.setInicio(new Date());
                            paginas_BEAN=paginas_DAO.salvar(paginas_BEAN,path);
                            if ((paginas_BEAN!=null)&&(paginas_BEAN.getIDStr()!=null))
                                mensagem_acao="Página salva com sucesso";
                            registros_Paginas.clear();
                            registros_Paginas.add(paginas_BEAN);
                        }
                        catch(Exception erro){
                            mensagem_acao=erro.getMessage();
                        }
                    }
                    else if (acao.equals("editar")){
                        mensagem_ID="";
                        mensagem_ID_menus="";
                        mensagem_Titulo="";
                        mensagem_acao="";
                        mensagem_Conteudo="";
                        mensagem_Fonte="";
                        paginas_BEAN=((paginasBairrosBEAN)paginas_DAO.buscarID(paginas_BEAN));
                        if((paginas_BEAN!=null)&&(paginas_BEAN.getIDStr()!=null)){
                            registros_Paginas.add(paginas_BEAN);
                        }
                    }
                    else{
                        if(acao.equals("Excluir")){
                            mensagem_Titulo="";
                            if (
                                (mensagem_ID.length()==0)  
                                &&                                                                                                           
                                (mensagem_ID_menus.length()==0)                                                                                  
                            )
                            {
                                try{
                                    paginas_BEAN=paginas_DAO.excluir(paginas_BEAN,path+Src);
                                    if((paginas_BEAN!=null)&&(paginas_BEAN.getIDStr()!=null)){
                                        mensagem_acao="Página excluída com sucesso";
                                    }
                                    else{
                                        mensagem_acao="Página não encontrada";
                                    }
                                }
                                catch(Exception erro){
                                    mensagem_acao=erro.getMessage();
                                }
                            }
                        }
                        else if(acao.equals("Desativar")){
                            mensagem_Titulo="";
                            if (
                                (mensagem_ID_menus.length()==0)                                                                                  
                                &&
                                (mensagem_ID.length()==0)                                                                                  
                            )
                            {
                                try{
                                    paginas_BEAN=paginas_DAO.Desativar(paginas_BEAN);
                                }
                                catch(Exception erro){
                                    mensagem_acao=erro.getMessage();
                                }
                            }
                        }
                        else if(acao.equals("Ativar")){
                            mensagem_Titulo="";
                            if (
                                (mensagem_ID_menus.length()==0)                                                                                  
                                &&
                                (mensagem_ID.length()==0)                                                                                  
                            )
                            {
                                try{
                                    paginas_BEAN=paginas_DAO.Ativar(paginas_BEAN);
                                }
                                catch(Exception erro){
                                    mensagem_acao=erro.getMessage();
                                }
                            }
                        }
                        else if(acao.equals("DesativarSlideShow")){
                            mensagem_Titulo="";
                            if (
                                (mensagem_ID_menus.length()==0)                                                                                  
                                &&
                                (mensagem_ID.length()==0)                                                                                  
                            )
                            {
                                try{
                                    paginas_BEAN=paginas_DAO.DesativarSlideShow(paginas_BEAN);
                                }
                                catch(Exception erro){
                                    mensagem_acao=erro.getMessage();
                                }
                            }
                        }
                        else if(acao.equals("DesativarTodosSlideShows")){
                            mensagem_Titulo="";
                            if (
                                (mensagem_ID_menus.length()==0)                                                                                  
                                &&
                                (mensagem_ID.length()==0)                                                                                  
                            )
                            {
                                try{
                                    paginas_DAO.DesativarTodosSlideShows();
                                }
                                catch(Exception erro){
                                    mensagem_acao=erro.getMessage();
                                }
                            }
                        }
                        else if(acao.equals("AtivarSlideShow")){
                            mensagem_Titulo="";
                            if (
                                (mensagem_ID_menus.length()==0)                                                                                  
                                &&
                                (mensagem_ID.length()==0)                                                                                  
                            )
                            {
                                try{
                                    paginas_BEAN=paginas_DAO.AtivarSlideShow(paginas_BEAN);
                                }
                                catch(Exception erro){mensagem_acao=erro.getMessage();}
                            }
                        }
                        mensagem_ID="";
                        mensagem_ID_menus="";
                        registros_Paginas.clear();
                        try{menus_BEAN.setID(id_menu);}catch(Exception erro){}
                        registros_Paginas=paginas_DAO.buscarUltimasPaginasPorSubMenus(menus_BEAN,1,20);
                        paginas_BEAN.Clear();
                    }                                       
                }
                else{
                    mensagem_ID="";
                    mensagem_ID_menus="";
                    registros_Paginas.clear();
                    try{menus_BEAN.setID(id_menu);}catch(Exception erro){}
                    registros_Paginas=paginas_DAO.buscarUltimasPaginasPorSubMenus(menus_BEAN,1,20);
                    paginas_BEAN.Clear();
                }
        %>
        <center>
        <a class="texto1">Cadastro Páginas</a><br>
        <br>
        <%@include file="menu_submenu.jsp"%>
        <br>
        <br>
            <form method="post" enctype="multipart/form-data"> 
                <a class="texto3">Foto Em Destaque:</a> <input type="file" name="src"><br>
                <div style="clear:both;color:red;"></div>
                <input type="hidden" value="<%=paginas_BEAN.getIDStr()%>" name="id" id="id">
                <table cellpadding= "4" cellspacing = "0" border= "1" height="303" width="100%">
                    <tr>
                        <td  align="center">
                            <a target="_black" href="../upload/conteudo/h_<%=paginas_BEAN.getSrc()%>" >
                                <img align="center" src="../upload/conteudo/h_<%=paginas_BEAN.getSrc()%>" height="303" width="404">
                            </a>
                        </td>
                    </tr>
                </table>
                <br>
                <br>        
                <br>
                <a class="texto3">Titulo:       </a><input type="text" name="Titulo"    value="<%=Until.functions.removenull(paginas_BEAN.getTitulo())%>"    style="width:400px"><br>                
                <a class="texto3">SubTitulo:    </a><input type="text" name="SubTitulo" value="<%=Until.functions.removenull(paginas_BEAN.getSubTitulo())%>" style="width:400px"><br>                
                <div style="clear:both;color:red"><%=mensagem_Titulo%></div>
<%             
                    FCKeditor fckEditor = new FCKeditor(request,"conteudo");
                    fckEditor.setConfig("SkinPath","skins/office2003/");
                    fckEditor.setConfig("DefaultLanguage","pt-br/");
                    fckEditor.setValue(Until.functions.removenull(paginas_BEAN.getConteudo()));
                    fckEditor.setBasePath("/fckeditor");
                    fckEditor.setHeight("400px");
                    fckEditor.createHtml();
                    out.println(fckEditor);
%>
                    <br>
                   <a class="texto3">Fonte:</a><input type="text" name="Fonte" value="<%=Until.functions.removenull(paginas_BEAN.getFonte())%>"><br>                
                   <div style="clear:both;color:red"><%=mensagem_acao%></div>
                   <input type="submit" value="Novo" onclick="document.getElementById('id').value=''">
                   <%if(restricao_acesso.getSalvar()){%><input type="submit" value="Salvar" name="acao"><%}%>
                   <%if(restricao_acesso.getBuscar()){%><input type="submit" value="Buscar" name="acao"><%}%>
                   <%if(restricao_acesso.getEditar()){%><input type="submit" value="DesativarTodosSlideShows" name="acao"><%}%>
                <br>
            </form>
            <table cellpadding= "4" cellspacing = "0" border= "1" width= "400px">
                <tr bgcolor="#CCCCCC">                           
                        <td><a class="texto3"> Titulo </a></td>
                        <td><a class="texto3"> Data </a></td>
                        <td><a class="texto3"> acao </a></td>
                </tr>
                    <%
                        if((registros_Paginas!=null)&&(registros_Paginas.size()>0)){
                            for(int i=0;i<registros_Paginas.size();i++){
                                paginas_BEAN=((paginasBairrosBEAN)registros_Paginas.get(i));
                    %>
                <tr>
                    <td><%=paginas_BEAN.getTitulo()%></td>
                    <td><%=paginas_BEAN.getInicioStr("dd/MM/yyyy HH:mm:ss")%></td>
                    <td>
                        <form method="post" >
                            <input type="hidden" name="id" value="<%=paginas_BEAN.getIDStr()%>">
                            <%if(restricao_acesso.getEditar()){%><input type="submit" name="acao" value="editar"><%}%>
                            <%if(restricao_acesso.getExcluir()){%><input type="submit" value="Excluir" name="acao"><%}%>
                            <%if(paginas_BEAN.getFim()!=null){%>
                            <%if(restricao_acesso.getEditar()){%><input type="submit" value="Ativar" name="acao"><%}%>
                            <%}
                            else{%>
                            <%if(restricao_acesso.getEditar()){%><input type="submit" value="Desativar" name="acao"><%}%>
                            <%}%>
                            <br>
                            <%if(paginas_BEAN.getSlideShow()){%>
                            <%if(restricao_acesso.getEditar()){%><input type="submit" value="DesativarSlideShow" name="acao"><%}%>
                            <%}
                            else{%>    
                            <%if(restricao_acesso.getEditar()){%><input type="submit" value="AtivarSlideShow" name="acao"><%}%>
                            <%}%>
                            <a href="./cadastro_fotos_paginas_bairros.jsp?id_paginas_bairros=<%=paginas_BEAN.getIDStr()%>" target="_black" ><input type="button" value="Mais fotos"    name="acao"></a>
                        </form>
                    </td>
                </tr>
<%
                            }
                        }
                        session.removeAttribute("minhaConexaoadm");
                        minhaConexao.Fechar();
%>
            </table>                
        </center>
    </body>
</html>
<%}%>