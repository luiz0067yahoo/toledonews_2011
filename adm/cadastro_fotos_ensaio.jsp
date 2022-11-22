<%@page import="java.awt.Dimension"%>
<%@page import="java.util.Date"%>
<%@page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@page import="POJO.fotosEnsaioPOJO"%>
<%@page import="DAO.ensaioDAO"%>
<%@page import="BEAN.ensaioBEAN"%>
<%@page import="DAO.ensaioDAO"%>
<%@page import="DAO.fotosEnsaioDAO"%>
<%@page import="DAO.ensaioDAO"%>
<%@page import="BEAN.ensaioBEAN"%>
<%@page import="Until.functions"%>
<%@page import="java.util.Vector"%>
<%@page import="DAO.fotosEnsaioDAO"%>
<%@page import="BEAN.fotosEnsaioBEAN"%>
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
        <meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
        <title>Cadastro fotosensaio</title>
        <link rel="shortcut icon" href="./midia_mix.png" type="image/x-icon" />
    </head>
    <body onload="relogio();">
        <center>
            <%
                Conexao minhaConexao=null;
                minhaConexao=(Conexao)session.getAttribute("minhaConexaoadm");
            
                fotosEnsaioBEAN fotosensaio_BEAN=new fotosEnsaioBEAN();
                fotosEnsaioDAO fotosensaio_DAO=new fotosEnsaioDAO(minhaConexao);
                Vector registros_fotosensaio=new Vector();
                Until.fileUpload request2=new Until.fileUpload();
                request2.setRequest(request);

                String ID=request2.getParameter("id");
                String id_ensaio=request2.getParameter("id_ensaio");
                String acao=request2.getParameter("acao");                
                
                String mensagem_ID="";
                String mensagem_acao="";
                String mensagem_Src="";
                String mensagem_id_ensaio="";          
                  
                if ((id_ensaio==null)||((id_ensaio!=null)&&(id_ensaio.equals("null"))))
                    id_ensaio=request.getParameter("id_ensaio");
                
                try{fotosensaio_BEAN.setID(ID);}catch(Exception erro){mensagem_ID="a foto selecionada não existe";};
                try{fotosensaio_BEAN.setID_ensaio(id_ensaio);}catch(Exception erro){mensagem_id_ensaio=erro.getMessage();}; 
                if((acao!=null)&&(acao.length()>0)){ 
						
                        
                        if(acao.equals("Salvar")){
                                if (
                                    (mensagem_id_ensaio.length()==0)                                                                                                                           
                                ){                             
                                    try{
                                        String acc="";
                                        if ((functions.path_upload!=null)&&(functions.path_upload.indexOf("\\")!=-1))
                                            acc="\\";
                                        else
                                            acc="/";
                                        String path=functions.path_upload+acc+"ensaio"+acc;
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
                                        try{fotosensaio_BEAN.setsrc(Src);}catch(Exception erro){mensagem_Src=erro.getMessage();}; 
                                        if ((ID!=null)&&(ID.length()!=0))
                                            mensagem_Src="";
                                        if(mensagem_Src.length()==0){
                                            fotosensaio_BEAN=fotosensaio_DAO.salvar(fotosensaio_BEAN,functions.path_upload);
                                            registros_fotosensaio.add(fotosensaio_BEAN);
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
                                    fotosensaio_BEAN.Clear();
                            }                        
                            else if(acao.equals("Excluir")){
                                if (
                                    (mensagem_ID.length()==0)                                                                                  
                                )
                                {
                                    fotosensaio_BEAN=fotosensaio_DAO.excluir(fotosensaio_BEAN,functions.path_upload); 
                                    if((fotosensaio_BEAN!=null)&&(fotosensaio_BEAN.getIDStr()!=null)){
                                        mensagem_acao="Foto excluída com sucesso";
                                    }
                                    else{
                                        mensagem_acao="Foto não encontrada";
                                    }                                    
                                }
                                mensagem_ID=""; 
                                
                                mensagem_Src="";
                                mensagem_id_ensaio="";
                                fotosensaio_BEAN.Clear();
                            }
                            else if(acao.equals("editar")){                                
                                fotosensaio_BEAN=((fotosEnsaioBEAN)fotosensaio_DAO.buscarID(fotosensaio_BEAN));
                                if((fotosensaio_BEAN!=null)&&(fotosensaio_BEAN.getIDStr()!=null)){
                                    registros_fotosensaio.add(fotosensaio_BEAN);
                                    mensagem_id_ensaio="";
                                }
                                else{
                                    fotosensaio_BEAN.Clear();
                                    try{fotosensaio_BEAN.setID_ensaio(id_ensaio);}catch(Exception erro){mensagem_id_ensaio=erro.getMessage();}; 
                                    mensagem_id_ensaio="";
                                    registros_fotosensaio=fotosensaio_DAO.buscarPorEnsaio(fotosensaio_BEAN);
                                }
                                mensagem_ID=""; 
                                mensagem_Src="";
                                mensagem_id_ensaio="";                                                               
                            }
                            else if(acao.equals("novo")){
                                mensagem_ID=""; 
                                mensagem_Src="";
                                mensagem_id_ensaio="";
                                fotosensaio_BEAN.Clear();
                            }
                    }
                    else{
                        mensagem_ID="";
                        fotosensaio_BEAN.Clear();
                        try{fotosensaio_BEAN.setID_ensaio(id_ensaio);}catch(Exception erro){mensagem_id_ensaio=erro.getMessage();}; 
                        mensagem_id_ensaio="";
                        try{registros_fotosensaio=fotosensaio_DAO.buscarPorEnsaio(fotosensaio_BEAN);}catch(Exception erro){}
                    }
                   
            %>
            <a class="texto1">Cadastro fotos Ensaio</a><br><br>
            <form method="post" enctype="multipart/form-data" >
                <div style="clear:both;color:red"><%=mensagem_ID%></div>
                <input type="hidden" name="id_categoria" value="<%=id_ensaio%>"><br>
                <div style="clear:both;color:red"><%=mensagem_id_ensaio%></div>
                <input type="hidden" name="id" value="<%=fotosensaio_BEAN.getIDStr()%>" id="id"><br>
                <a class="texto3">Foto</a>: <input type="file" name="Src"><br>
                <div style="clear:both;color:red"><%=mensagem_Src%></div>
                <input type="submit" value="novo" onclick="document.getElementById('id').value=''">
                <input type="submit" value="Salvar" name="acao">              
                <input type="submit" value="Buscar" name="acao">
                <div style="clear:both;color:red"><%=mensagem_acao%></div>
            </form>
 
            <table cellpadding= "4" cellspacing = "0" border= "1" width= "400px">
                <tr bgcolor="#CCCCCC">
                    <td><a class="texto3"> acao </a> </td>
                </tr>
                    <%
                        if((registros_fotosensaio!=null)&&(registros_fotosensaio.size()>0)){
                            for(int i=0;i<registros_fotosensaio.size();i++){
                                fotosensaio_BEAN=((fotosEnsaioBEAN)registros_fotosensaio.get(i));
                                if(fotosensaio_BEAN.getIDStr()==null)
                                    break;
                    %>
                    <tr>
                        <td width="150px">
                            <form method="post" >
                                <input type="hidden" name="id" value="<%=fotosensaio_BEAN.getIDStr()%>">
                                <input type="submit" name="acao" value="editar">
                                <input type="submit" value="Excluir" name="acao">
                            </form>
                        </td>
                    </tr>
                    <tr>
                        <td align="center">
                            <a target="_black" href="../upload/ensaio/h_<%=fotosensaio_BEAN.getsrc()%>" ><img align="center" src="../upload/ensaio/h_<%=fotosensaio_BEAN.getsrc()%>"></a>
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