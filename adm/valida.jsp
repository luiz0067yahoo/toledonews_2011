<%@page import="Until.trancar"%>
<%@page import="DAO.paginas_administrativasDAO"%>
<%@page import="BEAN.paginas_administrativasBEAN"%>
<%@page import="DAO.restricaoDAO"%>
<%@page import="BEAN.restricaoBEAN"%>
<%@page import="DAO.usuarioDAO"%>
<%@page import="BD.Conexao"%>
<%@page import="java.util.Date"%>
<%@page import="BEAN.usuarioBEAN"%>
<%
    boolean autenticar____=true;
    try{
        Conexao minhaConexao=new Conexao(Until.functions.CreateDataConection());
        session.setAttribute("minhaConexaoadm",minhaConexao);        
        usuarioBEAN usuario_BEAN2=new usuarioBEAN();
        autenticar____=true;
        int minutos=10;
        Date entrada=(Date)session.getAttribute("entrada");
        long diferenca = (new Date()).getTime() -entrada.getTime();
        if(diferenca>(minutos*60*1000)){
             autenticar____=false;
             //autenticar____=true;
        }
        usuario_BEAN2=(usuarioBEAN)session.getAttribute("usuario");
        
        
        
        
        usuarioDAO usuario_DAO=new usuarioDAO(minhaConexao);
        usuario_BEAN2 = usuario_DAO.login(usuario_BEAN2);
        if((usuario_BEAN2!=null)&&(usuario_BEAN2.getIDStr()!=null)){
            session.setAttribute("usuario",usuario_BEAN2);
            session.setAttribute("entrada", new Date());
            session.setAttribute("minhaConexaoadm",minhaConexao);
        }
        else{            
            autenticar____=false;
            //autenticar____=true;
        }
        if(autenticar____){
            try{
                restricaoBEAN restricao_BEAN2=new restricaoBEAN();
                restricaoDAO restricao_DAO2=new restricaoDAO(minhaConexao);
                String pagina_atual=request.getRequestURI();
                pagina_atual=pagina_atual.substring(pagina_atual.lastIndexOf("/")+1);
                pagina_atual=pagina_atual;
                paginas_administrativasBEAN paginas_administrativas_BEAN2=new paginas_administrativasBEAN();
                paginas_administrativasDAO paginas_administrativas_DAO2=new paginas_administrativasDAO(minhaConexao);
                restricao_BEAN2.setId_usuario(usuario_BEAN2.getID());
                restricao_BEAN2.setBuscar(true);
                restricao_BEAN2.setEditar(true);
                restricao_BEAN2.setVer(true);
                restricao_BEAN2.setSalvar(true);
                restricao_BEAN2.setExcluir(true);
                try{
                    paginas_administrativas_BEAN2=paginas_administrativas_DAO2.buscarPaginaPorNome(pagina_atual);
                }
                catch(Exception erro_buscar_pagina){
                }
                if((paginas_administrativas_BEAN2!=null)&&(paginas_administrativas_BEAN2.getIDStr()!=null)){
                    restricao_BEAN2.setId_pagina(paginas_administrativas_BEAN2.getID());
                    restricao_BEAN2=restricao_DAO2.buscarPorUsuarioEPagina(restricao_BEAN2);
                }
                else{
                    paginas_administrativas_BEAN2.setnome(pagina_atual);
                    paginas_administrativas_BEAN2=paginas_administrativas_DAO2.salvar(paginas_administrativas_BEAN2);
                    restricao_BEAN2.setId_pagina(paginas_administrativas_BEAN2.getID());
                    restricao_BEAN2=restricao_DAO2.salvar(restricao_BEAN2);

                }                    
                session.setAttribute("restricao_acesso", restricao_BEAN2);
            }
            catch(Exception erro_autentica){
            }
        }
    }
    catch(Exception erro){
        autenticar____=false;
        //autenticar____=true;
    }

    if (!autenticar____){
        session.invalidate();   
        %>
            <script type="text/javascript">
                top.location='./logout.jsp'
            </script>
        <%
    }
    
%>                