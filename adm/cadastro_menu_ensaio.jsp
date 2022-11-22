<%@page import="java.awt.Dimension"%>
<%@page import="java.util.Date"%>
<%@page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@page import="POJO.menuEnsaioPOJO"%>
<%@page import="DAO.menuEnsaioDAO"%>
<%@page import="Until.functions"%>
<%@page import="java.util.Vector"%>
<%@page import="DAO.menuEnsaioDAO"%>
<%@page import="BEAN.menuEnsaioBEAN"%>
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
        <title>Cadastro menuEnsaio</title>
        <link rel="shortcut icon" href="./midia_mix.png" type="image/x-icon" />
    </head>
    <body onload="relogio();">
        <center>
            <%  

                Conexao minhaConexao=null;
                minhaConexao=(Conexao)session.getAttribute("minhaConexaoadm");



                menuEnsaioBEAN menuEnsaio_BEAN=new menuEnsaioBEAN();
                menuEnsaioDAO menuEnsaio_DAO=new menuEnsaioDAO(minhaConexao);
                Vector registros_menuEnsaio=new Vector();
                
                Until.fileUpload request2=new Until.fileUpload();
                
                request2.setRequest(request);
                String ID=request2.getParameter("id");
                String acao=request2.getParameter("acao");
                String mensagem_ID="";
                String mensagem_acao="";
                String mensagem_Titulo="";
                String mensagem_descricao="";
                String mensagem_Src="";
                String mensagem_Srcs="";
                String acc="";
                if ((functions.path_upload!=null)&&(functions.path_upload.indexOf("\\")!=-1))
                    acc="\\";
                else
                    acc="/";
                String path=functions.path_upload+acc+"ensaio";
                try{menuEnsaio_BEAN.setID(ID);}catch(Exception erro){mensagem_ID=" A foto selecionada não existe";};                    
                if((acao!=null)&&(acao.length()>0)){
                        String Titulo=request2.getParameter("Titulo");
                        try{menuEnsaio_BEAN.setTitulo(Titulo);}catch(Exception erro){mensagem_Titulo=erro.getMessage();};                        
                        if(acao.equals("Buscar")){
                            menuEnsaioPOJO  menuEnsaio_POJO = new menuEnsaioPOJO();
                            menuEnsaio_POJO.setTitulo(Titulo);
                            menuEnsaio_BEAN= new menuEnsaioBEAN(menuEnsaio_POJO);
                            try{registros_menuEnsaio=menuEnsaio_DAO.buscarTitulo(menuEnsaio_POJO.getTitulo());}catch(Exception erro){mensagem_acao=erro.getMessage();};                            
                            mensagem_ID="";
                            mensagem_acao="";
                            mensagem_Titulo="";
                            mensagem_descricao="";
                            mensagem_Src="";
                            mensagem_Srcs="";
                        }
                        else if(acao.equals("Salvar")){
                                if (
                                    (mensagem_Titulo.length()==0)
                                    &&
                                    (mensagem_descricao.length()==0)
                                                                                                                                                          
                                ){                             
                                    try{
                                        String Src=request2.upload(//mostro o nome do arquivo enviado
                                                "Src",//name do input type file
                                                "ensaio",//pasta sub sequente da pasta upload
                                                new String[]{"jpg","gif","png","bmp"},//extesoes de arquivos 
                                                10*1024*1024//10 mb
                                        );
                                        Src=request2.redimensionarImagem(
                                            "ensaio"//pasta sub sequente da pasta upload
                                            ,Src//nome do arquivo enviado
                                            ,new String[]{""}//prefixos
                                            ,new Dimension[]{
                                                new Dimension(707,400)//tamanho m_ 360px de largura e 240px de altura
                                            }
                                        );							
                                        try{menuEnsaio_BEAN.setSRC(Src);}catch(Exception erro){mensagem_Src=erro.getMessage();}; 
                                        
                                        
                                        String Srcs=request2.upload(//mostro o nome do arquivo enviado
                                                "Srcs",//name do input type file
                                                "ensaio",//pasta sub sequente da pasta upload
                                                new String[]{"jpg","gif","png","bmp"},//extesoes de arquivos 
                                                10*1024*1024//10 mb
                                        );
                                        Srcs=request2.redimensionarImagem(
                                            "ensaio"//pasta sub sequente da pasta upload
                                            ,Src//nome do arquivo enviado
                                            ,new String[]{""}//prefixos
                                            ,new Dimension[]{
                                                new Dimension(70,70)//tamanho m_ 360px de largura e 240px de altura
                                            }
                                        );							
                                        try{menuEnsaio_BEAN.setsrcs(Srcs);}catch(Exception erro){mensagem_Src=erro.getMessage();}; 
                                        
                                        
                                        if ((ID!=null)&&(ID.length()!=0))
                                            mensagem_Src="";
                                        
                                        if(mensagem_Src.length()==0){
                                            menuEnsaio_BEAN=menuEnsaio_DAO.salvar(menuEnsaio_BEAN,functions.path_upload);
                                            registros_menuEnsaio.add(menuEnsaio_BEAN);
                                        }
                                        else{
                                            functions.deletaImagensRedimencionadas(Src,functions.path_upload);
                                        }
                                        mensagem_acao="Foto salva com sucesso";
                                        mensagem_ID=""; 
                                    }
                                    catch(Exception erro){
                                        mensagem_acao=erro.getMessage();
                                    }
                                }
                                else
                                    menuEnsaio_BEAN.Clear();
                            }                        
                            else if(acao.equals("Excluir")){
                                if (
                                    (mensagem_ID.length()==0)                                                                                  
                                )
                                {
                                    menuEnsaio_BEAN=menuEnsaio_DAO.excluir(menuEnsaio_BEAN,functions.path_upload); 
                                    if((menuEnsaio_BEAN!=null)&&(menuEnsaio_BEAN.getIDStr()!=null)){
                                        mensagem_acao="Foto excluída com sucesso";
                                    }
                                    else{
                                        mensagem_acao="Foto não encontrada";
                                    }                                    
                                }
                                mensagem_ID=""; 
                                mensagem_Titulo="";
                                mensagem_descricao="";
                                mensagem_Src="";
                                menuEnsaio_BEAN.Clear();
                            }
                            else if(acao.equals("editar")){
                                menuEnsaio_BEAN=((menuEnsaioBEAN)menuEnsaio_DAO.buscarID(menuEnsaio_BEAN));
                                if((menuEnsaio_BEAN!=null)&&(menuEnsaio_BEAN.getIDStr()!=null)){
                                    registros_menuEnsaio.add(menuEnsaio_BEAN);
                                }
                                else{
                                    menuEnsaio_BEAN.Clear();
                                    registros_menuEnsaio=menuEnsaio_DAO.buscarTodos();
                                }
                                mensagem_ID=""; 
                                mensagem_Titulo="";
                                mensagem_descricao="";
                                mensagem_Src="";
                            }
                            else if(acao.equals("novo")){
                                mensagem_ID=""; 
                                mensagem_Titulo="";
                                mensagem_descricao="";
                                mensagem_Src="";
                                menuEnsaio_BEAN.Clear();
                            }
                    }
                    else{
                            mensagem_ID="";
                            menuEnsaio_BEAN.Clear();
                            try{registros_menuEnsaio=menuEnsaio_DAO.buscarTodos();}catch(Exception erro){}
                    }
            %>
            <a class="texto1">Cadastro menuEnsaio</a><br><br>
            <form method="post" enctype="multipart/form-data">
                <div style="clear:both;color:red;"><%=mensagem_ID%></div>
                <input type="hidden" name="id" value="<%=menuEnsaio_BEAN.getIDStr()%>" id="id"><br>
                <a class="texto3">Titulo:</a> <input type="text" name="Titulo" value="<%=menuEnsaio_BEAN.getTitulo()%>"><br>
                <div style="clear:both;color:red"><%=mensagem_Titulo%></div>
                <a class="texto3">SRC</a>: <input type="file" name="Src" value="<%=menuEnsaio_BEAN.getSRC()%>"><br>
                <div style="clear:both;color:red"><%=mensagem_Src%></div>
                <a class="texto3">SRCS</a>: <input type="file" name="Srcs" value="<%=menuEnsaio_BEAN.getsrcs()%>"><br>
                <div style="clear:both;color:red"><%=mensagem_Srcs%></div>
                <input type="submit" value="novo" onclick="document.getElementById('id').value=''">
                <input type="submit" value="Salvar" name="acao">              
                <input type="submit" value="Buscar" name="acao">
                <div style="clear:both;color:red;"><%=mensagem_acao%></div>
            </form>
            <table cellpadding="4" cellspacing="0" border="1" width="400px">
                <tr bgcolor="#CCCCCC">    
                    <td> <a class="texto3">Titulo</a> </td>
                    <td><a class="texto3"> acao </a> </td>
                </tr>
<%
                            if((registros_menuEnsaio!=null)&&(registros_menuEnsaio.size()>0)){
                                for(int i=0;i<registros_menuEnsaio.size();i++){
                                    menuEnsaio_BEAN=((menuEnsaioBEAN)registros_menuEnsaio.get(i));
                                    if(menuEnsaio_BEAN.getIDStr()==null)
                                        break;
%>
                <tr>
                    <td><%=Until.functions.removenull(menuEnsaio_BEAN.getTitulo())%></td>     
                    <td width="150px">
                        <form method="post" >
                            <input type="hidden" name="id"   value="<%=menuEnsaio_BEAN.getIDStr()%>">
                            <input type="submit" name="acao" value="editar">
                            <input type="submit" name="acao" value="Excluir">
                        </form>
                    </td>
                </tr>
                <tr>
                    <td COLSpan="3" align="center">
                        <a target="_blank" src="./arquivo.jsp?nome=<%=menuEnsaio_BEAN.getSRC()%>&pasta=ensaio" ><img align="center" src="./arquivo.jsp?nome=<%=menuEnsaio_BEAN.getSRC()%>&pasta=ensaio"></a>
                    </td>
                </tr>
                <tr>
                    <td COLSpan="3" align="center">
                        <a target="_blank" src="./arquivo.jsp?nome=<%=menuEnsaio_BEAN.getsrcs()%>&pasta=ensaio" ><img align="center" src="./arquivo.jsp?nome=<%=menuEnsaio_BEAN.getsrcs()%>&pasta=ensaio"></a>
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