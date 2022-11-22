<%@page import="Until.functions"%>
<%@page import="BD.Conexao"%>
<%
    response.setContentType("application/octet-stream");
    response.setHeader("Content-Disposition","attachment;filename=backup.sql");

    Conexao MinhaConexao=new Conexao(Until.functions.CreateDataConection()); 
    try{
        session.setMaxInactiveInterval(60000);
        out.write("\n/*inicio videos*/\n");
        out.write((new DAO.categoriaVideosDAO(MinhaConexao)).exportar());
        out.write("\n/*categoria videos*/\n");
        out.write((new DAO.videosDAO(MinhaConexao)).exportar());
        out.write("\n/*videos*/\n");
        out.write("\n/*fim videos*/\n");
        out.write("\n");

        out.write("\n/*inicio fotos*/\n");
        out.write((new DAO.categoriaFotosDAO(MinhaConexao)).exportar());
        out.write("\n/*categoria videos*/\n");
        out.write((new DAO.fotosDAO(MinhaConexao)).exportar());
        out.write("\n/*fotos*/\n");
        out.write("\n/*fim fotos*/\n");

        out.write("\n");

        out.write("\n/*inicio servicos*/\n");
        out.write((new DAO.categoriaServicosDAO(MinhaConexao)).exportar());
        out.write("\n/*categoria servicos*/\n");
        out.write((new DAO.fotosServicosDAO(MinhaConexao)).exportar());
        out.write("\n/*servicos*/\n");
        out.write("\n/*fim servicos*/\n");

        out.write("\n");

        out.write("\n/*inicio ensaio*/\n");
        out.write((new DAO.menuEnsaioDAO(MinhaConexao)).exportar());
        out.write("\n/*menu ensaio*/\n");
        out.write((new DAO.ensaioDAO(MinhaConexao)).exportar());
        out.write("\n/*ensaio*/\n");
        out.write((new DAO.fotosEnsaioDAO(MinhaConexao)).exportar());
        out.write("\n/*fotos ensaio*/\n");
        out.write("\n/*fim ensaio*/\n");


        out.write("\n");
        out.write("\n/*inicio noticias*/\n");
        out.write((new DAO.menusDAO(MinhaConexao)).exportar());
        out.write("\n/*menu*/\n");
        DAO.paginasDAO paginas_DAO =new DAO.paginasDAO(MinhaConexao);
        int numero_registros=1;
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
        DAO.fotosPaginasDAO fotosPaginas_DAO =new DAO.fotosPaginasDAO(MinhaConexao);
        out.write(fotosPaginas_DAO.SQLExcluirTabela());
        out.write(fotosPaginas_DAO.SQLCriarTabela());
        out.write(fotosPaginas_DAO.SQLexcluirTodos());
        limite=fotosPaginas_DAO.contarTodos(numero_registros);
        for(int x=0;x<limite;x++){
            out.write(fotosPaginas_DAO.exportar(x,numero_registros));
        }
        out.write("\n/*fotos paginas*/\n");
        out.write((new DAO.tipoDAO(MinhaConexao)).exportar());
        out.write("\n/*tipo*/\n");
        out.write((new DAO.patrocinioDAO(MinhaConexao)).exportar());
        out.write("\n/*patrocinio*/\n");
        out.write((new DAO.comentariosDAO(MinhaConexao)).exportar());
        out.write("\n/*comentarios*/\n");
        DAO.contagemDAO contagem_DAO =new DAO.contagemDAO(MinhaConexao);
        out.write(contagem_DAO.SQLExcluirTabela());
        out.write(contagem_DAO.SQLCriarTabela());
        out.write(contagem_DAO.SQLexcluirTodos());
        limite=contagem_DAO.contarTodos(numero_registros);
        //  limite=10;
        for(int x=0;x<limite;x++){
            try{out.write(contagem_DAO.exportar(x,numero_registros));}catch(Exception erro){};
        }
        out.write("\n/*contagem*/\n");
        out.write("\n/*fim noticias*/\n");

        out.write("\n");

        out.write("\n/*inicio usuario*/\n");
        out.write((new DAO.usuarioDAO(MinhaConexao)).exportar());
        out.write("\n/*menu usuario*/\n");
        out.write((new DAO.restricaoDAO(MinhaConexao)).exportar());
        out.write("\n/*restricao*/\n");

        out.write("\n");
    }
    catch(Exception erro){
    }
    try{MinhaConexao.Fechar();}
    catch(Exception erro){}
%>