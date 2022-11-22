<%@page import="java.awt.Dimension"%>
<%@page import="java.util.Date"%>
<%@page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@page import="POJO.fotosShoppingPOJO"%>
<%@page import="DAO.categoriaShoppingDAO"%>
<%@page import="BEAN.categoriaShoppingBEAN"%>
<%@page import="DAO.categoriaShoppingDAO"%>
<%@page import="DAO.categoriaShoppingDAO"%>
<%@page import="BEAN.categoriaShoppingBEAN"%>
<%@page import="Until.functions"%>
<%@page import="java.util.Vector"%>
<%@page import="DAO.fotosShoppingDAO"%>
<%@page import="BEAN.fotosShoppingBEAN"%>
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
        <title>Cadastro fotos</title>
        <link rel="shortcut icon" href="./midia_mix.png" type="image/x-icon" />
        <script type="text/javascript" src="./js/relogio.js"></script>
    </head>
    <body onload="relogio();">
        <center>
            <%
                
                Conexao minhaConexao=null;
                minhaConexao=(Conexao)session.getAttribute("minhaConexaoadm");
                
                String acc="";
                if ((functions.path_upload!=null)&&(functions.path_upload.indexOf("\\")!=-1))
                    acc="\\";
                else
                    acc="/";
                String path=functions.path_upload+acc+"shopping";
            
                fotosShoppingBEAN fotos_Shopping_BEAN=new fotosShoppingBEAN();
                fotosShoppingDAO fotos_Shopping_DAO=new fotosShoppingDAO(minhaConexao);
                Vector registros_fotos=new Vector();
                Until.fileUpload request2=new Until.fileUpload();
                request2.setRequest(request);

                String ID=request2.getParameter("id");
                String id_categoria=request2.getParameter("id_categoria");
                String acao=request2.getParameter("acao");                
                
                String mensagem_ID="";
                String mensagem_acao="";
                String mensagem_Titulo="";
                String mensagem_descricao="";
                String mensagem_Src="";
                String mensagem_id_categoria="";          
                     
                try{fotos_Shopping_BEAN.setID(ID);}catch(Exception erro){mensagem_ID="a foto selecionada não existe";};
                try{fotos_Shopping_BEAN.setId_Categoria(id_categoria);}catch(Exception erro){mensagem_id_categoria=erro.getMessage();}; 
                    
                if((acao!=null)&&(acao.length()>0)){     
						
                        String Titulo=request2.getParameter("Titulo");
                        String descricao=request2.getParameter("descricao");
						
                        try{fotos_Shopping_BEAN.setTitulo(Titulo);}catch(Exception erro){mensagem_Titulo=erro.getMessage();};
                        try{fotos_Shopping_BEAN.setDescricao(descricao);}catch(Exception erro){mensagem_descricao=erro.getMessage();}; 
                        
                        if(acao.equals("Buscar")){
                            fotosShoppingPOJO  fotos_Shopping_POJO = new fotosShoppingPOJO();
                            fotos_Shopping_POJO.setTitulo(Titulo);
                            fotos_Shopping_POJO.setDescricao(descricao);
                            fotos_Shopping_BEAN= new fotosShoppingBEAN(fotos_Shopping_POJO);
                            try{registros_fotos=fotos_Shopping_DAO.buscar(fotos_Shopping_BEAN);}catch(Exception erro){mensagem_acao=erro.getMessage();};                            
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
                                    try{										
                                        
                                        String Src=request2.upload(//mostro o nome do arquivo enviado
                                                "Src",//name do input type file
                                                "shopping",//pasta sub sequente da pasta upload
                                                new String[]{"jpg","gif","png","bmp"},//extesoes de arquivos 
                                                10*1024*1024//10 mb
                                        );
                                        Src=request2.redimensionarImagem(
                                            "shopping"//pasta sub sequente da pasta upload
                                            ,Src//nome do arquivo enviado
                                            ,new String[]{""}//prefixos
                                            ,new Dimension[]{
                                                new Dimension(120,146)//tamanho p_ 100px de largura e 100px de altura
                                            }
                                        );
                                        
                                        
                                        try{fotos_Shopping_BEAN.setSrc(Src);}catch(Exception erro){mensagem_Src=erro.getMessage();};
                                        if ((ID!=null)&&(ID.length()!=0))
                                            mensagem_Src="";
                                        if(mensagem_Src.length()==0){
                                            fotos_Shopping_BEAN=fotos_Shopping_DAO.salvar(fotos_Shopping_BEAN,path);
                                            registros_fotos.add(fotos_Shopping_BEAN);
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
                                    fotos_Shopping_BEAN.Clear();
                            }                        
                            else if(acao.equals("Excluir")){
                                if (
                                    (mensagem_ID.length()==0)                                                                                  
                                )
                                {
                                    fotos_Shopping_BEAN=fotos_Shopping_DAO.excluir(fotos_Shopping_BEAN,path); 
                                    if((fotos_Shopping_BEAN!=null)&&(fotos_Shopping_BEAN.getIDStr()!=null)){
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
                                mensagem_id_categoria="";
                                fotos_Shopping_BEAN.Clear();
                            }
                            else if(acao.equals("editar")){                                
                                fotos_Shopping_BEAN=((fotosShoppingBEAN)fotos_Shopping_DAO.buscarID(fotos_Shopping_BEAN));
                                if((fotos_Shopping_BEAN!=null)&&(fotos_Shopping_BEAN.getIDStr()!=null)){
                                    registros_fotos.add(fotos_Shopping_BEAN);
                                    mensagem_id_categoria="";
                                }
                                else{
                                    fotos_Shopping_BEAN.Clear();
                                    try{fotos_Shopping_BEAN.setId_Categoria(id_categoria);}catch(Exception erro){mensagem_id_categoria=erro.getMessage();}; 
                                    mensagem_id_categoria="";
                                    registros_fotos=fotos_Shopping_DAO.buscarPorCategoria(fotos_Shopping_BEAN);
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
                                fotos_Shopping_BEAN.Clear();
                            }
                            
                    }
                    else{
                        mensagem_ID="";
                        fotos_Shopping_BEAN.Clear();
                        try{fotos_Shopping_BEAN.setId_Categoria(id_categoria);}catch(Exception erro){mensagem_id_categoria=erro.getMessage();}; 
                        mensagem_id_categoria="";
                        try{registros_fotos=fotos_Shopping_DAO.buscarPorCategoria(fotos_Shopping_BEAN);}catch(Exception erro){}
                    }
                   
            %>
            <a class="texto1">Cadastro fotos</a><br><br>
            <form method="post" enctype="multipart/form-data">
            <div style="clear:both;color:red"><%=mensagem_ID%></div>
            Categoria:<select name="id_categoria" onchange="menuJump(this)">
            <%
                Vector registros_categoria=(new categoriaShoppingDAO(minhaConexao)).buscarTodos();
               if((registros_categoria!=null)&&(registros_categoria.size()>0)){
                 for(int i=0;i<registros_categoria.size();i++){
                              categoriaShoppingBEAN categoria_BEAN=((categoriaShoppingBEAN)registros_categoria.get(i));      
            %>
                <option value="<%=categoria_BEAN.getIDStr()%>" <%
                    if(functions.equals(fotos_Shopping_BEAN.getId_CategoriaStr(),categoria_BEAN.getIDStr())) 
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
                <input type="hidden" name="id" value="<%=fotos_Shopping_BEAN.getIDStr()%>" id="id"><br>
                <a class="texto3">link</a> <input type="text" name="Titulo" value="<%=fotos_Shopping_BEAN.getTitulo()%>"><br>
               <div style="clear:both;color:red"><%=mensagem_Titulo%></div>
               <a class="texto3">Descrição:</a> <input type="text" name="descricao" value="<%=fotos_Shopping_BEAN.getDescricao()%>"><br>
               <div style="clear:both;color:red"><%=mensagem_descricao%></div>
             <a class="texto3">Foto</a>: <input type="file" name="Src" value="<%=fotos_Shopping_BEAN.getSrc()%>"><br>
               <div style="clear:both;color:red"><%=mensagem_Src%></div>
               <input type="submit" value="novo" onclick="document.getElementById('id').value=''">
               <input type="submit" value="Salvar" name="acao">              
               <input type="submit" value="Buscar" name="acao">
               <div style="clear:both;color:red"><%=mensagem_acao%></div>
            </form>
 
                <table cellpadding= "4" cellspacing = "0" border= "1" width= "400px">
                    <tr bgcolor="#CCCCCC">
                        <td><a class="texto3"> Titulo   </a> </td>
                        <td><a class="texto3"> Descrição</a> </td>
                        <td><a class="texto3"> acao     </a> </td>
		    </tr>
<%
                            if((registros_fotos!=null)&&(registros_fotos.size()>0)){
                                for(int i=0;i<registros_fotos.size();i++){
                                    fotos_Shopping_BEAN=((fotosShoppingBEAN)registros_fotos.get(i));
                                    if(fotos_Shopping_BEAN.getIDStr()==null)
                                        break;
%>
                        <tr>
                            <td> <%=Until.functions.removenull(fotos_Shopping_BEAN.getTitulo())%> </td>     
                            <td> <%=Until.functions.removenull(fotos_Shopping_BEAN.getDescricao())%> </td> 
                            <td width="150px">
                                <form method="post" >
                                    <input type="hidden" name="id" value="<%=fotos_Shopping_BEAN.getIDStr()%>">
                                    <input type="submit" name="acao" value="editar">
                                    <input type="submit" value="Excluir" name="acao">
                                </form>
                            </td>
                        </tr>
                        <tr>
                            <td COLSpan="3" align="center">
                                <a target="_black" href="./arquivo.jsp?nome=<%=fotos_Shopping_BEAN.getSrc()%>&pasta=shopping" ><img align="center" src="./arquivo.jsp?nome=<%=fotos_Shopping_BEAN.getSrc()%>&pasta=shopping"></a>
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