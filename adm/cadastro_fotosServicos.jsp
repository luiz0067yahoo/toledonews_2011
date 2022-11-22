<%@page import="java.util.Date"%>
<%@page import="java.awt.Dimension"%>
<%@page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@page import="POJO.fotosServicosPOJO"%>
<%@page import="DAO.categoriaServicosDAO"%>
<%@page import="BEAN.categoriaServicosBEAN"%>
<%@page import="DAO.categoriaServicosDAO"%>
<%@page import="DAO.fotosServicosDAO"%>
<%@page import="DAO.categoriaServicosDAO"%>
<%@page import="BEAN.categoriaServicosBEAN"%>
<%@page import="Until.functions"%>
<%@page import="java.util.Vector"%>
<%@page import="DAO.fotosServicosDAO"%>
<%@page import="BEAN.fotosServicosBEAN"%>
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
        <title>Cadastro fotosServicos</title>
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
                String path=functions.path_upload+acc+"servicos";
            
                fotosServicosBEAN fotosServicos_BEAN=new fotosServicosBEAN();
                fotosServicosDAO fotosServicos_DAO=new fotosServicosDAO(minhaConexao);
                Vector registros_fotosServicos=new Vector();
                Until.fileUpload request2=new Until.fileUpload();
                request2.setRequest(request);

                String ID=request2.getParameter("id");
                String id_categoria=request2.getParameter("id_categoria");
                String acao=request2.getParameter("acao");                
                
                String mensagem_ID="";
                String mensagem_acao="";
                String mensagem_Titulo="";
                String mensagem_Telefone="";
                String mensagem_Endereco="";
                String mensagem_Site="";
                String mensagem_Email="";
                String mensagem_Atividade="";
                String mensagem_Src="";
                String mensagem_id_categoria="";          
                     
                try{fotosServicos_BEAN.setID(ID);}catch(Exception erro){mensagem_ID="a foto selecionada não existe";};
                try{fotosServicos_BEAN.setId_Categoria(id_categoria);}catch(Exception erro){mensagem_id_categoria=erro.getMessage();}; 
                    
                if((acao!=null)&&(acao.length()>0)){     
						
                        String Titulo=request2.getParameter("Titulo");
                        String Telefone=request2.getParameter("Telefone");
                        String Endereco=request2.getParameter("endereco");
                        String Email=request2.getParameter("email");
                        String Site=request2.getParameter("site");
						
                        try{fotosServicos_BEAN.setTitulo(Titulo);}catch(Exception erro){mensagem_Titulo=erro.getMessage();};
                        try{fotosServicos_BEAN.setTelefone(Telefone);}catch(Exception erro){mensagem_Telefone=erro.getMessage();}; 
                        try{fotosServicos_BEAN.setEndereco(Endereco);}catch(Exception erro){mensagem_Endereco=erro.getMessage();}; 
                        try{fotosServicos_BEAN.setEmail(Email);}catch(Exception erro){mensagem_Email=erro.getMessage();}; 
                        try{fotosServicos_BEAN.setSite(Site);}catch(Exception erro){mensagem_Site=erro.getMessage();}; 
                        
                        if(acao.equals("Buscar")){
                            fotosServicosPOJO  fotosServicos_POJO = new fotosServicosPOJO();
                            fotosServicos_POJO.setTitulo(Titulo);
                            fotosServicos_POJO.setTelefone(Telefone);
                            fotosServicos_POJO.setEndereco(Endereco);
                            fotosServicos_POJO.setEmail(Email);
                            fotosServicos_POJO.setSite(Site);
                            fotosServicos_BEAN= new fotosServicosBEAN(fotosServicos_POJO);
                            try{registros_fotosServicos=fotosServicos_DAO.buscar(fotosServicos_BEAN);}catch(Exception erro){mensagem_acao=erro.getMessage();};                            
                            mensagem_ID="";
                            mensagem_acao="";
                            mensagem_Titulo="";
                            mensagem_Telefone="";
                            mensagem_Endereco="";
                            mensagem_Email="";
                            mensagem_Src="";
                            mensagem_id_categoria="";
                        }
                        else if(acao.equals("Salvar")){
                                if (
                                    (mensagem_Titulo.length()==0)
                                    &&
                                    (mensagem_Telefone.length()==0)
                                    && 
                                    (mensagem_id_categoria.length()==0)                                                                                                                           
                                ){                             
                                    try{										
                                        String Src=request2.upload(//mostro o nome do arquivo enviado
                                                "Src",//name do input type file
                                                "servicos",//pasta sub sequente da pasta upload
                                                new String[]{"jpg","gif","png","bmp"},//extesoes de arquivos 
                                                10*1024*1024//10 mb
                                        );
                                        Src=request2.redimensionarImagem(
                                            "servicos"//pasta sub sequente da pasta upload
                                            ,Src//nome do arquivo enviado
                                            ,new String[]{"p_","m_","g_","h_"}//prefixos
                                            ,new Dimension[]{
                                                new Dimension(100,100)//tamanho p_ 100px de largura e 100px de altura
                                                ,new Dimension(360,240)//tamanho m_ 360px de largura e 240px de altura
                                                ,new Dimension(640,480)//tamanho g_ 640px de largura e 480px de altura
                                                ,new Dimension(800,600)//tamanho h_ 100px de largura e 600px de altura
                                            }
                                        );
                                        
                                        
                                        try{fotosServicos_BEAN.setSrc(Src);}catch(Exception erro){mensagem_Src=erro.getMessage();};
                                        if ((ID!=null)&&(ID.length()!=0))
                                            mensagem_Src="";
                                        if(mensagem_Src.length()==0){
                                            fotosServicos_BEAN=fotosServicos_DAO.salvar(fotosServicos_BEAN,path);
                                            registros_fotosServicos.add(fotosServicos_BEAN);
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
                                    fotosServicos_BEAN.Clear();
                            }                        
                            else if(acao.equals("Excluir")){
                                if (
                                    (mensagem_ID.length()==0)                                                                                  
                                )
                                {
                                    fotosServicos_BEAN=fotosServicos_DAO.excluir(fotosServicos_BEAN,path); 
                                    if((fotosServicos_BEAN!=null)&&(fotosServicos_BEAN.getIDStr()!=null)){
                                        mensagem_acao="Foto excluída com sucesso";
                                    }
                                    else{
                                        mensagem_acao="Foto não encontrada";
                                    }                                    
                                }
                                mensagem_ID=""; 
                                mensagem_Titulo="";
                                mensagem_Telefone="";
                                mensagem_Endereco="";
                                mensagem_Email="";
                                mensagem_Src="";
                                mensagem_Site="";
                                mensagem_id_categoria="";
                                fotosServicos_BEAN.Clear();
                            }
                            else if(acao.equals("editar")){                                
                                fotosServicos_BEAN=((fotosServicosBEAN)fotosServicos_DAO.buscarID(fotosServicos_BEAN));
                                if((fotosServicos_BEAN!=null)&&(fotosServicos_BEAN.getIDStr()!=null)){
                                    registros_fotosServicos.add(fotosServicos_BEAN);
                                    mensagem_id_categoria="";
                                }
                                else{
                                    fotosServicos_BEAN.Clear();
                                    try{fotosServicos_BEAN.setId_Categoria(id_categoria);}catch(Exception erro){mensagem_id_categoria=erro.getMessage();}; 
                                    mensagem_id_categoria="";
                                    registros_fotosServicos=fotosServicos_DAO.buscarPorCategoria(fotosServicos_BEAN);
                                }
                                mensagem_ID=""; 
                                mensagem_Titulo="";
                                mensagem_Telefone="";
                                mensagem_Endereco="";
                                mensagem_Email="";
                                mensagem_Src="";
                                mensagem_Site="";
                                mensagem_id_categoria="";                                                               
                            }
                            else if(acao.equals("novo")){
                                mensagem_ID=""; 
                                mensagem_Titulo="";
                                mensagem_Telefone="";
                                mensagem_Endereco="";
                                mensagem_Email="";
                                mensagem_Src="";
                                mensagem_id_categoria="";
                                mensagem_Site="";
                                fotosServicos_BEAN.Clear();
                            }
                            
                    }
                    else{
                        mensagem_ID="";
                        fotosServicos_BEAN.Clear();
                        try{fotosServicos_BEAN.setId_Categoria(id_categoria);}catch(Exception erro){mensagem_id_categoria=erro.getMessage();}; 
                        mensagem_id_categoria="";
                        try{registros_fotosServicos=fotosServicos_DAO.buscarPorCategoria(fotosServicos_BEAN);}catch(Exception erro){}
                    }
                   
            %>
            <a class="texto1">Cadastro fotosServicos</a><br><br>
            <form method="post" enctype="multipart/form-data">
            <div style="clear:both;color:red"><%=mensagem_ID%></div>
            Categoria:<select name="id_categoria" onchange="menuJump(this)">
            <%
                Vector registros_categoria=(new categoriaServicosDAO(minhaConexao)).buscarTodos();
               if((registros_categoria!=null)&&(registros_categoria.size()>0)){
                 for(int i=0;i<registros_categoria.size();i++){
                              categoriaServicosBEAN categoria_BEAN=((categoriaServicosBEAN)registros_categoria.get(i));      
            %>
                <option value="<%=categoria_BEAN.getIDStr()%>" <%
                    if(functions.equals(fotosServicos_BEAN.getId_CategoriaStr(),categoria_BEAN.getIDStr())) 
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
                <input type="hidden" name="id" value="<%=fotosServicos_BEAN.getIDStr()%>" id="id"><br>
                <a class="texto3">Titulo:</a> <input type="text" name="Titulo" value="<%=Until.functions.removenull(fotosServicos_BEAN.getTitulo())%>"><br>
               <div style="clear:both;color:red"><%=mensagem_Titulo%></div>
               <a class="texto3">Telefone:</a> <input type="text" name="Telefone" value="<%=Until.functions.removenull(fotosServicos_BEAN.getTelefone())%>"><br>
               <div style="clear:both;color:red"><%=mensagem_Telefone%></div>
               <a class="texto3">Endereço:</a> <input type="text" name="endereco" value="<%=Until.functions.removenull(fotosServicos_BEAN.getEndereco())%>"><br>
               <div style="clear:both;color:red"><%=mensagem_Endereco%></div>
               <a class="texto3">Site:</a> <input type="text" name="site" value="<%=Until.functions.removenull(fotosServicos_BEAN.getEndereco())%>"><br>
               <div style="clear:both;color:red"><%=mensagem_Site%></div>
               <a class="texto3">Email</a> <input type="text" name="email" value="<%=Until.functions.removenull(fotosServicos_BEAN.getEmail())%>"><br>
               <div style="clear:both;color:red"><%=mensagem_Email %></div>
               <a class="texto3">Atividade</a> <input type="text" name="Atividade" value="<%=Until.functions.removenull(fotosServicos_BEAN.getAtividade())%>"><br>
               <div style="clear:both;color:red"><%=mensagem_Atividade %></div>
             <a class="texto3">Foto</a>: <input type="file" name="Src" value="<%=fotosServicos_BEAN.getSrc()%>"><br>
               <div style="clear:both;color:red"><%=mensagem_Src%></div>
               <input type="submit" value="novo" onclick="document.getElementById('id').value=''">
               <input type="submit" value="Salvar" name="acao">              
               <input type="submit" value="Buscar" name="acao">
               <div style="clear:both;color:red"><%=mensagem_acao%></div>
            </form>
 
                <table cellpadding= "4" cellspacing = "0" border= "1" width= "400px">
                    <tr bgcolor="#CCCCCC">
                        <td><a class="texto3"> Titulo   </a> </td>
                        <td><a class="texto3"> Telefone</a> </td>
                        <td><a class="texto3"> Endereço</a> </td>
                        <td><a class="texto3"> Site</a> </td>
                        <td><a class="texto3"> Email</a> </td>
                        <td><a class="texto3"> atividade</a> </td>
                        <td><a class="texto3"> acao     </a> </td>
		    </tr>
<%
                            if((registros_fotosServicos!=null)&&(registros_fotosServicos.size()>0)){
                                for(int i=0;i<registros_fotosServicos.size();i++){
                                    fotosServicos_BEAN=((fotosServicosBEAN)registros_fotosServicos.get(i));
                                    if(fotosServicos_BEAN.getIDStr()==null)
                                        break;
%>
                        <tr>
                            <td> <%=Until.functions.removenull(fotosServicos_BEAN.getTitulo())%> </td>     
                            <td> <%=Until.functions.removenull(fotosServicos_BEAN.getTelefone())%> </td> 
                            <td> <%=Until.functions.removenull(fotosServicos_BEAN.getEndereco())%> </td> 
                            <td> <%=Until.functions.removenull(fotosServicos_BEAN.getSite())%> </td> 
                            <td> <%=Until.functions.removenull(fotosServicos_BEAN.getEmail())%> </td> 
                            <td> <%=Until.functions.removenull(fotosServicos_BEAN.getAtividade())%> </td> 
                            <td width="150px">
                                <form method="post" >
                                    <input type="hidden" name="id" value="<%=fotosServicos_BEAN.getIDStr()%>">
                                    <input type="submit" name="acao" value="editar">
                                    <input type="submit" value="Excluir" name="acao">
                                </form>
                            </td>
                        </tr>
                        <tr>
                            <td COLSpan="5" align="center">
                                <a target="_black" href="../upload/servicos/h_<%=fotosServicos_BEAN.getSrc()%>" ><img align="center" src="../upload/servicos/h_<%=fotosServicos_BEAN.getSrc()%>"></a>
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