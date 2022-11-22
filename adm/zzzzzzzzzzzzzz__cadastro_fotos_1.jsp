<%@page import="java.awt.Dimension"%>
<%@page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@page import="POJO.fotosPOJO"%>
<%@page import="DAO.categoriaFotosDAO"%>
<%@page import="BEAN.categoriaFotosBEAN"%>
<%@page import="DAO.categoriaFotosDAO"%>
<%@page import="DAO.fotosDAO"%>
<%@page import="DAO.categoriaFotosDAO"%>
<%@page import="BEAN.categoriaFotosBEAN"%>
<%@page import="Until.functions"%>
<%@page import="java.util.Vector"%>
<%@page import="DAO.fotosDAO"%>
<%@page import="BEAN.fotosBEAN"%>
<%@page import="BD.Conexao"%>
<%@page import="BD.DadosConexao"%>
<!DOCTYPE html>
<link rel="stylesheet" type="text/css" href="estilosadm.css">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <title>Cadastro fotos</title>
        <link rel="shortcut icon" href="./midia_mix.png" type="image/x-icon"/>
        <script type="text/javascript" src="./js/relogio.js"></script>
    </head>
    <body onload="relogio();">
        <center>
            <%
                Until.fileUpload request2=new Until.fileUpload();
                request2.setRequest(request);
                String Src=request2.upload("Src","arquivos",new String[]{"jpg","gif","png","bmp"},3*1024*1024);
                Src=request2.redimensionarImagem(
                    "arquivos"
                    ,Src
                    ,new String[]{"p_","m_","g_","h_"}
                    ,new Dimension[]{
                         new Dimension(100,100)
                        ,new Dimension(360,240)
                        ,new Dimension(640,480)
                        ,new Dimension(800,600)
                    }
                );
            %>
            <a class="texto1">Cadastro fotos</a><br><br>
            <form method="post" enctype="multipart/form-data">
                <a class="texto3">Foto</a>: <input type="file" name="Src"><br>
                <input type="submit" value="Salvar" name="acao">              
            </form>
            
        </center>
    </body>
</html>
