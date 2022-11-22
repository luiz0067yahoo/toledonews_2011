<%@page import="java.awt.Dimension"%>
<%@page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@page import="POJO.patrocinadoresPOJO"%>
<%@page import="DAO.categoriaPatrocinadoresDAO"%>
<%@page import="BEAN.categoriaPatrocinadoresBEAN"%>
<%@page import="DAO.categoriaPatrocinadoresDAO"%>
<%@page import="DAO.patrocinadoresDAO"%>
<%@page import="Until.functions"%>
<%@page import="java.util.Vector"%>
<%@page import="DAO.patrocinadoresDAO"%>
<%@page import="BEAN.patrocinadoresBEAN"%>
<%@page import="BD.Conexao"%>
<%@page import="BD.DadosConexao"%>
<link rel="stylesheet" type="text/css" href="estilosadm.css">
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
        <title>Cadastro patrocinadores</title>
        <link rel="shortcut icon" href="./midia_mix.png" type="image/x-icon" />
        <style type="text/css">
	.texto1{font-family:Arial, Helvetica, sans-serif; font-size:14px; text-align:center;  font-size:16px; text-align:center; width:800px; height:auto; margin-right:auto; margin-left:auto; float:center; line-height:23px;}
	
	.texto2{font-family:Arial, Helvetica, sans-serif; font-size:14px; text-align:center; font-size:26px; text-align:center; width:800px; height:auto; margin-right:auto; margin-left:auto; float:center; line-height:29px;}
	
	.texto3{font-family:Arial, Helvetica, sans-serif; font-size:14px; text-align:center; font-size:15px; text-align:center; width:800px; height:auto; margin-right:auto; margin-left:auto; float:center; line-height:29px;}
</style>
    </head>
    <body onload="relogio();">
        <center>
            <%
                Conexao minhaConexao=new Conexao(Until.functions.CreateDataConection()); 
                patrocinadoresBEAN patrocinadores_BEAN=new patrocinadoresBEAN();
                patrocinadoresDAO patrocinadores_DAO=new patrocinadoresDAO(minhaConexao);
                Vector registros_patrocinadores=new Vector();
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
                     
                try{patrocinadores_BEAN.setID(ID);}catch(Exception erro){mensagem_ID="a foto selecionada não existe";};
                try{patrocinadores_BEAN.setId_Categoria(id_categoria);}catch(Exception erro){mensagem_id_categoria=erro.getMessage();}; 
                    
                if((acao!=null)&&(acao.length()>0)){     
						
                        String Titulo=request2.getParameter("Titulo");
                        String descricao=request2.getParameter("descricao");
						
                        try{patrocinadores_BEAN.setTitulo(Titulo);}catch(Exception erro){mensagem_Titulo=erro.getMessage();};
                        try{patrocinadores_BEAN.setDescricao(descricao);}catch(Exception erro){mensagem_descricao=erro.getMessage();}; 
                        
                        if(acao.equals("Salvar")){
                                if (
                                    (mensagem_Titulo.length()==0)
                                    &&
                                    (mensagem_descricao.length()==0)
                                    && 
                                    (mensagem_id_categoria.length()==0)                                                                                                                           
                                ){                             
                                    try{
                                        
                                        
                                        String acc="";
                                        if ((functions.path_upload!=null)&&(functions.path_upload.indexOf("\\")!=-1))
                                            acc="\\";
                                        else
                                            acc="/";
                                        
                                        String path=functions.path_upload+acc+"jogos"+acc;
                                        
                                        String Src=request2.upload(//mostro o nome do arquivo enviado
                                                "Src",//name do input type file
                                                "jogos",//pasta sub sequente da pasta upload
                                                new String[]{"jpg","gif","png","bmp"},//extesoes de arquivos 
                                                10*1024*1024//10 mb
                                        );
                                        Src=request2.redimensionarImagem(
                                            "jogos"//pasta sub sequente da pasta upload
                                            ,Src//nome do arquivo enviado
                                            ,new String[]{""}//prefixos
                                            ,new Dimension[]{
                                                new Dimension(143,93)//tamanho p_ 100px de largura e 100px de altura
                                            }
                                        );
                                        try{patrocinadores_BEAN.setSrc(Src);}catch(Exception erro){mensagem_Src=erro.getMessage();}; 
                                        if ((ID!=null)&&(ID.length()!=0))
                                            mensagem_Src="";
                                        if(mensagem_Src.length()==0){
                                            patrocinadores_BEAN=patrocinadores_DAO.inserir(patrocinadores_BEAN);
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
                                    patrocinadores_BEAN.Clear();
                            }                        
                            else if(acao.equals("Excluir")){
                                if (
                                    (mensagem_ID.length()==0)                                                                                  
                                )
                                {
                                    patrocinadores_BEAN=patrocinadores_DAO.excluir(patrocinadores_BEAN,functions.path_upload); 
                                    if((patrocinadores_BEAN!=null)&&(patrocinadores_BEAN.getIDStr()!=null)){
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
                                patrocinadores_BEAN.Clear();
                            }
                    }
                    mensagem_ID="";
                    patrocinadores_BEAN.Clear();
                    try{patrocinadores_BEAN.setId_Categoria(id_categoria);}catch(Exception erro){mensagem_id_categoria=erro.getMessage();}; 
                    mensagem_id_categoria="";
                    try{registros_patrocinadores=patrocinadores_DAO.buscarPorCategoria(patrocinadores_BEAN);}catch(Exception erro){}
                   
            %>
            <a class="texto1">Cadastro Jogo</a><br><br>
            <form method="post" enctype="multipart/form-data">
            <div style="clear:both;color:red"><%=mensagem_ID%></div>
            <a class="texto3">Categoria do Jogo:</a> <select name="id_categoria" onchange="menuJump(this)">
            <%
                Vector registros_categoria=(new categoriaPatrocinadoresDAO(minhaConexao)).buscarTodos();
               if((registros_categoria!=null)&&(registros_categoria.size()>0)){
                 for(int i=0;i<registros_categoria.size();i++){
                              categoriaPatrocinadoresBEAN categoria_BEAN=((categoriaPatrocinadoresBEAN)registros_categoria.get(i));      
            %>
                <option value="<%=categoria_BEAN.getIDStr()%>" <%
                    if(functions.equals(patrocinadores_BEAN.getId_CategoriaStr(),categoria_BEAN.getIDStr())) 
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
               <input type="hidden" name="id" value="<%=patrocinadores_BEAN.getIDStr()%>"><br>
                <a class="texto3">Nome:</a><input type="text" name="Titulo" value="<%=patrocinadores_BEAN.getTitulo()%>">
               <div style="clear:both;color:red"><%=mensagem_Titulo%></div>
                <a class="texto3">URL:</a><input type="text" name="descricao" value="<%=patrocinadores_BEAN.getDescricao()%>">
               <div style="clear:both;color:red"><%=mensagem_descricao%></div>
               <a class="texto3">Foto:</a> <input type="file" name="Src" value="<%=patrocinadores_BEAN.getSrc()%>"><br>(largura:74px  altura:48px; Extensão .jpg) Adicione no máximo 6 imagens para não estourar o layout
               <div style="clear:both;color:red"><%=mensagem_Src%></div>
                <input type="submit" value="Novo" onclick="document.getElementById('id').value=''" >
               <input type="submit" value="Salvar" name="acao">
               <input type="submit" value="Buscar" name="acao">
               <div style="clear:both;color:red"><%=mensagem_acao%></div><br>
            </form>
             <table cellpadding= "4" cellspacing = "0" border= "1" width= "400px">
                    <tr bgcolor="#CCCCCC">                           
                            <td><a class="texto3"> Nome </a></td>
                            <td><a class="texto3"> URL </a></td>
                            <td><a class="texto3"> acao </a></td>
		    </tr>
                
                        <%
                            if((registros_patrocinadores!=null)&&(registros_patrocinadores.size()>0)){
                                for(int i=0;i<registros_patrocinadores.size();i++){
                                    patrocinadores_BEAN=((patrocinadoresBEAN)registros_patrocinadores.get(i));
                                    if(patrocinadores_BEAN.getIDStr()==null)
                                        break;
                        %>
                        <tr bgcolor="#CCCCCC">
                            <td><a class="texto3"><%=patrocinadores_BEAN.getTitulo()%></a></td>
                            <td><a class="texto3"><%=patrocinadores_BEAN.getDescricao()%></a></td>
                            <td width="150px">
                                <form method="post" enctype="multipart/form-data">
                                    <input type="hidden" name="id" value="<%=patrocinadores_BEAN.getIDStr()%>">
                                    <input type="submit" name="acao" value="editar">
                                    <input type="submit" value="Excluir" name="acao">
                                </form>
                            </td>
                        </tr>
                        <tr>
                            <td COLSpan="3" align="center">
                                <a target="_black" src="./arquivo.jsp?nome=<%=patrocinadores_BEAN.getSrc()%>&pasta=jogos" >
                                    <img align="center" src="./arquivo.jsp?nome=<%=patrocinadores_BEAN.getSrc()%>&pasta=jogos" height="94" width="143">
                                </a>
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
