<%@page import="Until.functions"%>
<%@page import="BD.Conexao"%>
<!DOCTYPE html>
<html><head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta charset="utf-8">
    <title>backup</title>
    <link rel="stylesheet" href="./css/codemirror.css">
    <link rel="stylesheet" href="./css/docs.css">
    <script src="./js/codemirror.js"></script>
    <script src="./js/plsql.js"></script>
    <style>.CodeMirror {border: 2px inset #dee;}</style>
  </head>
  <body>
    <h1>Backup de dados</h1>

<form>
    <textarea style="display: none;" id="code" name="code"><%
                Conexao MinhaConexao=new Conexao(Until.functions.CreateDataConection()); 
                try{
                    session.setMaxInactiveInterval(6000);
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
                    int numero_registros=10;
                    int limite=paginas_DAO.contarTodos(numero_registros);
                    for(int x=0;x<limite;x++){
                        out.write(paginas_DAO.exportar(x,numero_registros));
                    }
                    out.write("\n/*paginas*/\n");
                    DAO.fotosPaginasDAO fotosPaginas_DAO =new DAO.fotosPaginasDAO(MinhaConexao);
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
                    limite=contagem_DAO.contarTodos(numero_registros);
                    for(int x=0;x<limite;x++){
                        out.write(contagem_DAO.exportar(x,numero_registros));
                    }
                    out.write("\n/*contagem*/\n");
                    out.write("\n/*fim noticias*/\n");
                    
                    out.write("\n");
                    
                    out.write("\n/*inicio usuario*/\n");
                    out.write((new DAO.usuarioDAO(MinhaConexao)).exportar());
                    out.write("\n/*menu usuario*/\n");
                    out.write((new DAO.restricaoDAO(MinhaConexao)).exportar());
                    out.write("\n/*restricao*/\n");
                    out.write("\n/*fim ensaio*/\n");
                    
                    out.write("\n");
                }
                catch(Exception erro){
                }
                try{
                    MinhaConexao.Fechar();
                }
                catch(Exception erro){
                }
            %></textarea>
    
</form>

    <script>
      /*var editor = CodeMirror.fromTextArea(document.getElementById("code"), {
        lineNumbers: true,
        matchBrackets: true,
        indentUnit: 4,
        mode: "text/x-plsql"
      });
      */
    </script>
    </body>
</html>




















