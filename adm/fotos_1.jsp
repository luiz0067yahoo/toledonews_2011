<%@page import="Until.functions"%>
<%@page import="BD.Conexao"%>
<%
    response.setContentType("application/octet-stream");
    response.setHeader("Content-Disposition","attachment;filename=backup.sql");

    Conexao MinhaConexao=new Conexao(Until.functions.CreateDataConection()); 
    try{
        session.setMaxInactiveInterval(60000);

        out.write("\n/*inicio fotos*/\n");
        out.write((new DAO.categoriaFotosDAO(MinhaConexao)).exportar());
        out.write("\n/*categoria videos*/\n");
        out.write((new DAO.fotosDAO(MinhaConexao)).exportar());
        out.write("\n/*fotos*/\n");
        out.write("\n/*fim fotos*/\n");

        out.write("\n");


        out.write("\n");
    }
    catch(Exception erro){
    }
    try{MinhaConexao.Fechar();}
    catch(Exception erro){}
%>