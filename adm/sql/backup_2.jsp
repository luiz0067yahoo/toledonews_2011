<%@page import="Until.functions"%>
<%@page import="BD.Conexao"%>
<%
                response.setContentType("application/octet-stream");
                response.setHeader("Content-Disposition","attachment;filename=backup.sql");

                Conexao MinhaConexao=new Conexao(Until.functions.CreateDataConection()); 
                try{
                    session.setMaxInactiveInterval(6000);
                    DAO.paginasDAO paginas_DAO =new DAO.paginasDAO(MinhaConexao);
                    int numero_registros=1;
                    int limite=paginas_DAO.contarTodos(numero_registros);
                    session.setAttribute("total_paginas", limite);
                    out.write(paginas_DAO.SQLExcluirTabela());
                    out.write(paginas_DAO.SQLCriarTabela());
                    out.write(paginas_DAO.SQLexcluirTodos());
                    for(int x=0;x<limite;x++){
                        session.setAttribute("paginas_atual",x);
                        try{out.write(paginas_DAO.exportar(x,numero_registros));}catch(Exception erro__){}
                    }
                    
                }
                catch(Exception erro){
                }
                try{
                    MinhaConexao.Fechar();
                }
                catch(Exception erro){
                }
%>