<%@page import="java.awt.Dimension"%>
<%@page import="java.util.Date"%>
<%@page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@page import="POJO.ensaioPOJO"%>
<%@page import="DAO.menuEnsaioDAO"%>
<%@page import="BEAN.menuEnsaioBEAN"%>
<%@page import="DAO.ensaioDAO"%>
<%@page import="DAO.menuEnsaioDAO"%>
<%@page import="BEAN.menuEnsaioBEAN"%>
<%@page import="Until.functions"%>
<%@page import="java.util.Vector"%>
<%@page import="DAO.ensaioDAO"%>
<%@page import="BEAN.ensaioBEAN"%>
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
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <title>Cadastro Ensaio</title>
        <link rel="shortcut icon" href="./midia_mix.png" type="image/x-icon" />
        <script type="text/javascript" src="./js/relogio.js"></script>
    </head>
    <body onload="relogio();">
        <center>
            <%
               
                Conexao minhaConexao2=null;
                minhaConexao2=(Conexao)session.getAttribute("minhaConexaoadm");
                
                session.setAttribute("numero_registros",20);
                session.setAttribute("total",0);
                
                int posicao____=1;
                int numero_registros____=1;
                
                try{posicao____=Integer.parseInt(session.getAttribute("posicao").toString());}catch(Exception erro_teste){}       
                try{numero_registros____=Integer.parseInt(session.getAttribute("numero_registros").toString());}catch(Exception erro_teste){}       

                ensaioBEAN ensaio_BEAN=new ensaioBEAN();
                ensaioDAO ensaio_DAO=new ensaioDAO(minhaConexao2);
                Vector registros_ensaio=new Vector();
                Until.fileUpload request2=new Until.fileUpload();
                request2.setRequest(request);

                String ID=request2.getParameter("id");
                String id_menuEnsaio=request2.getParameter("id_menuEnsaio");
                String creditos=request2.getParameter("creditos");                
                String titulo=request2.getParameter("titulo");                
                String acao=request2.getParameter("acao");                
                
                String mensagem_ID="";
                String mensagem_acao="";
                String mensagem_Titulo="";
                String mensagem_creditos="";
                String mensagem_Src="";
                String mensagem_id_menu="";
                         
                String acc="";
                if ((functions.path_upload!=null)&&(functions.path_upload.indexOf("\\")!=-1))
                    acc="\\";
                else
                    acc="/";
                String path=functions.path_upload+acc+"ensaio";
                   
                try{ensaio_BEAN.setID(ID);}catch(Exception erro){mensagem_ID="A foto selecionada não existe";};
                try{ensaio_BEAN.setID_menu(id_menuEnsaio);}catch(Exception erro){mensagem_id_menu=erro.getMessage();}; 
                    
                if((acao!=null)&&(acao.length()>0)){
                    String Titulo=request2.getParameter("Titulo");
                    

                    try{ensaio_BEAN.setTitulo(Titulo);}catch(Exception erro){mensagem_Titulo=erro.getMessage();};
                    try{ensaio_BEAN.setCreditos(creditos);}catch(Exception erro){mensagem_creditos=erro.getMessage();}; 

                    if(acao.equals("Buscar")){
                        ensaioPOJO  ensaio_POJO = new ensaioPOJO();
                        ensaio_POJO.setTitulo(Titulo);
                        ensaio_POJO.setCreditos(creditos);
                        ensaio_BEAN= new ensaioBEAN(ensaio_POJO);
                        try{registros_ensaio=ensaio_DAO.buscar(ensaio_BEAN);}catch(Exception erro){mensagem_acao=erro.getMessage();};                            
                        mensagem_ID="";
                        mensagem_acao="";
                        mensagem_Titulo="";
                        mensagem_creditos="";
                        mensagem_Src="";
                        mensagem_id_menu="";
                    }
                    else if(acao.equals("Salvar")){
                        if(
                            (mensagem_Titulo.length()==0)
                            &&  
                            (mensagem_creditos.length()==0)
                            && 
                            (mensagem_id_menu.length()==0)                                                                                                                           
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
                                    ,new String[]{"p_","h_"}//prefixos
                                    ,new Dimension[]{
                                        new Dimension(100,100)//tamanho m_ 360px de largura e 240px de altura
                                        ,new Dimension(800,750)//tamanho m_ 360px de largura e 240px de altura
                                    }
                                );	
                                try{ensaio_BEAN.setSRC(Src);}catch(Exception erro){mensagem_Src=erro.getMessage();}; 
                                if ((ID!=null)&&(ID.length()!=0))
                                    mensagem_Src="";
                                if(mensagem_Src.length()==0){
                                    ensaio_BEAN=ensaio_DAO.salvar(ensaio_BEAN,path);
                                    registros_ensaio.add(ensaio_BEAN);
                                }
                                else{
                                    functions.deletaImagensRedimencionadas(Src,path);
                                }
                                mensagem_acao="Foto salva com sucesso";
                                mensagem_ID=""; 
                            }
                            catch(Exception erro){
                                mensagem_acao=erro.getMessage();
                            }
                        }
                        else
                            ensaio_BEAN.Clear();
                    }                        
                    else if(acao.equals("Excluir")){
                        if (
                            (mensagem_ID.length()==0)                                                                                  
                        )
                        {
                            ensaio_BEAN=ensaio_DAO.excluir(ensaio_BEAN,path); 
                            if((ensaio_BEAN!=null)&&(ensaio_BEAN.getIDStr()!=null)){
                                mensagem_acao="Foto excluída com sucesso";
                            }
                            else{
                                mensagem_acao="Foto não encontrada";
                            }                                    
                        }
                        mensagem_ID=""; 
                        mensagem_Titulo="";
                        mensagem_creditos="";
                        mensagem_Src="";
                        mensagem_id_menu="";
                        ensaio_BEAN.Clear();
                    }
                    else if(acao.equals("editar")){                                
                        ensaio_BEAN=((ensaioBEAN)ensaio_DAO.buscarID(ensaio_BEAN));
                        if((ensaio_BEAN!=null)&&(ensaio_BEAN.getIDStr()!=null)){
                            registros_ensaio.add(ensaio_BEAN);
                            mensagem_id_menu="";
                        }
                        else{
                            ensaio_BEAN.Clear();
                            menuEnsaioBEAN menuEnsaio_BEAN = new menuEnsaioBEAN();
                            try{menuEnsaio_BEAN.setID(id_menuEnsaio);}catch(Exception erro){mensagem_id_menu=erro.getMessage();}; 
                            mensagem_id_menu="";
                            session.setAttribute("total",ensaio_DAO.contarPorMenuEnsaio(menuEnsaio_BEAN,posicao____,numero_registros____));
                            registros_ensaio=ensaio_DAO.buscarPorMenuEnsaio(menuEnsaio_BEAN,posicao____,numero_registros____);
                        }
                        mensagem_ID=""; 
                        mensagem_Titulo="";
                        mensagem_creditos="";
                        mensagem_Src="";
                        mensagem_id_menu="";                                                               
                    }
                    else if(acao.equals("novo")){
                        mensagem_ID=""; 
                        mensagem_Titulo="";
                        mensagem_creditos="";
                        mensagem_Src="";
                        mensagem_id_menu="";
                        ensaio_BEAN.Clear();
                    }
                }
                else{
                    ensaio_BEAN.Clear();
                    mensagem_ID="";
                    menuEnsaioBEAN menuEnsaio_BEAN = new menuEnsaioBEAN();
                    try{menuEnsaio_BEAN.setID(id_menuEnsaio);}catch(Exception erro){mensagem_id_menu=erro.getMessage();}; 
                    mensagem_id_menu="";
                    session.setAttribute("total",ensaio_DAO.contarPorMenuEnsaio(menuEnsaio_BEAN,posicao____,numero_registros____));
                    registros_ensaio=ensaio_DAO.buscarPorMenuEnsaio(menuEnsaio_BEAN,posicao____,numero_registros____);
                } 
            %>
            <a class="texto1">Cadastro Ensaio</a><br><br>
            <form method="post" enctype="multipart/form-data">
            <div style="clear:both;color:red"><%=mensagem_ID%></div>
            menu: <select name="id_menuEnsaio" onchange="menuJump(this)">
            <%
                Vector registros_menuEnsaio=(new menuEnsaioDAO(minhaConexao2)).buscarTodos();
                if((registros_menuEnsaio!=null)&&(registros_menuEnsaio.size()>0)){
                    for(int i=0;i<registros_menuEnsaio.size();i++){
                        menuEnsaioBEAN menu_BEAN=((menuEnsaioBEAN)registros_menuEnsaio.get(i));      
            %>
                <option value="<%=menu_BEAN.getIDStr()%>" <%
                    if(functions.equals(id_menuEnsaio,menu_BEAN.getIDStr())) 
                        out.write("selected");
                %>>
                       <%=menu_BEAN.getTitulo()%>
                </option>
             <%
                        }
                    }
             %>
               </select><br>
               <div style="clear:both;color:red"><%=mensagem_id_menu%></div>
               <input type="hidden" name="id" value="<%=ensaio_BEAN.getIDStr()%>" id="id"><br>
             <a class="texto3">Titulo:</a> <input type="text" name="Titulo" value="<%=ensaio_BEAN.getTitulo()%>"><br>
               <div style="clear:both;color:red"><%=mensagem_Titulo%></div>
               <a class="texto3">Creditos:</a> 
               
               <textarea name="creditos"><%=ensaio_BEAN.getCreditos()%></textarea> 
               
               <br>
               <div style="clear:both;color:red"><%=mensagem_creditos%></div>
             <a class="texto3">Foto</a>: <input type="file" name="src" value="<%=ensaio_BEAN.getSRC()%>"><br>
               <div style="clear:both;color:red"><%=mensagem_Src%></div>
               <input type="submit" value="novo" onclick="document.getElementById('id').value=''">
               <%if(restricao_acesso.getSalvar()){%><input type="submit" value="Salvar" name="acao"><%}%>              
               <%if(restricao_acesso.getBuscar()){%><input type="submit" value="Buscar" name="acao"><%}%>
               <div style="clear:both;color:red"><%=mensagem_acao%></div>
               <br>
               
               <br>
            </form>
                <table cellpadding= "4" cellspacing = "0" border= "1" width= "400px">
                    <tr bgcolor="#CCCCCC">
                        <td> <a class="texto3">Titulo</a></td>
                        <td><a class="texto3"> Creditos</a></td>
                        <td><a class="texto3"> acao </a></td>
		    </tr>
<%
                            if((registros_ensaio!=null)&&(registros_ensaio.size()>0)){
                                for(int i=0;i<registros_ensaio.size();i++){
                                    ensaio_BEAN=((ensaioBEAN)registros_ensaio.get(i));
                                    if(ensaio_BEAN.getIDStr()==null)
                                        break;
%>
                        <tr>
                            <td> <%=Until.functions.removenull(ensaio_BEAN.getTitulo())%> </td>     
                            <td> <%=Until.functions.removenull(ensaio_BEAN.getCreditos())%> </td> 
                            <td width="150px">
                                <form method="post" >
                                    <input type="hidden" name="id" value="<%=ensaio_BEAN.getIDStr()%>">
                                    <%if(restricao_acesso.getEditar()){%><input type="submit" name="acao" value="editar"><%}%>
                                    <%if(restricao_acesso.getExcluir()){%><input type="submit" value="Excluir" name="acao"><%}%>
                                    <a href="./cadastro_fotos_ensaio.jsp?id_ensaio=<%=ensaio_BEAN.getIDStr()%>" target="_black" ><input type="button" value="Mais fotos" name="acao"></a>
                                </form>
                            </td>
                        </tr>
                        <tr>
                            <td COLSpan="3" align="center">
                                <a target="_black" src="./arquivo.jsp?nome=h_<%=ensaio_BEAN.getSRC()%>&pasta=ensaio" ><img align="center" src="./arquivo.jsp?nome=h_<%=ensaio_BEAN.getSRC()%>&pasta=ensaio"></a>
                            </td>
                        </tr>
<%
                                }
                            }
                            minhaConexao2.Fechar();
                            session.removeAttribute("numero_registros");
                            session.removeAttribute("total");
%>
                    <%@include file="paginacao.jsp" %>
                </table>
        </center>
    </body>
</html>
<%}%>