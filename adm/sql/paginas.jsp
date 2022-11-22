<%@page import="Until.functions"%>
<%@page import="BD.Conexao"%>
<%
    response.setContentType("application/octet-stream");
    response.setHeader("Content-Disposition","attachment;filename=backup.sql");

    Conexao MinhaConexao=new Conexao(Until.functions.CreateDataConection()); 
    try{
        session.setMaxInactiveInterval(60000);

        int numero_registros=1;
        DAO.paginasDAO paginas_DAO =new DAO.paginasDAO(MinhaConexao);
        int limite=paginas_DAO.contarTodos(numero_registros);
        out.write(paginas_DAO.SQLExcluirTabela());
        out.write(paginas_DAO.SQLCriarTabela());
        out.write(paginas_DAO.SQLexcluirTodos());
        try{
            for(int x=0;x<limite;x++){
                try{out.write(paginas_DAO.exportar(x,numero_registros));}catch(Exception erro__){}
            }
        }catch(Exception erro__){}
        out.write("\n/*paginas*/\n");
    }
    catch(Exception erro){
    }
    try{MinhaConexao.Fechar();}
    catch(Exception erro){}
%>