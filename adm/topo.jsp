<%@page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@page import="DAO.usuarioDAO"%>
<%@page import="BD.Conexao"%>
<%@page import="java.util.Date"%>
<%@page import="BEAN.usuarioBEAN"%>
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <title>Crm Midiamix</title>
        <script type="text/javascript" src="./js/relogio.js"></script>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <link rel="stylesheet" type="text/css" href="estilocrm.css" />
    </head>
    <body onLoad="MM_preloadImages('imagenscrm/senha1.gif','imagenscrm/suporte1.gif')">
        <div class="linhastotal" style="background-color:#000;">
            <div id="barrasair">
                <div id="sair">
                    <div id="botaooff"><img src="imagenscrm/off.gif" width="26" height="30" border="0" /></div>
                    <div id="divtextosair"><a class="textosair" href="./logout.jsp">SAIR</a></div>
                </div>
                <div class="branco" style="width:750px; height:30px;"></div>
                <div id="encerramento">SESSÃO ENCERRA EM:
                &nbsp;<a id="cronometro"></a></div>
            </div>
        </div>
        <div class="linhastotal" style="background-color:#E8E8E8;">
            <div class="linhascentro">
                <div id="barrabanner">
                    <div id="containercrm">
                        <div id="crmmidiamix"><img src="imagenscrm/crmmidiamix.jpg" width="210" height="84" /></div>
                    </div>
                    <div id="containercliente">
                        <div id="fotocliente"><img src="imagenscrm/inove.jpg" width="204" height="76" border="0"></div>
                    </div>
                    <div class="branco" style="height:140px; width:300px;"></div>
                    <div id="riscobarra"></div>
                    <div id="containerjava">
                        <div class="branco" style="width:197px; height:76px; margin-top:14px; display:inline;">
                            <div class="branco" style="height:71px; width:80px; font-family:Verdana, Geneva, sans-serif; font-size:14px; padding-top:5px; color:#666666;">Tecnologia</div>
                            <div id="logojava"></div>
                        </div>
                        <div class="branco" style="width:197px; height:50px;">
                            <div id="logomix"></div>
                            <div class="branco" style="width:153px; height:50px; display:block; overflow:hidden; font-family:Verdana, Geneva, sans-serif; font-size:08px; color:#666666;">
                                Developed by<br>
                                <a style="font-size:10px;">Studio Midiamix</a><br>
                                Todos os direitos reservados&copy;
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="linhastotal" style="background-image:url(imagenscrm/risco1.gif); background-repeat:repeat-x;">
            <div class="linhascentro">
                <div id="risco1"></div>
            </div>
        </div>
        <div class="linhastotal">
            <div class="linhascentro">
                <div id="barrausuario">
                    <div id="bemvindo">Bem - Vindo,
<%
    usuarioBEAN usuario_BEAN=new usuarioBEAN();
    boolean autentica=true;
    try{
        int minutos=10;
        Date entrada=(Date)session.getAttribute("entrada");
        long diferenca = (new Date()).getTime() -entrada.getTime();
        if(diferenca>(minutos*60*1000)){
             autentica=false;
        }
        usuario_BEAN=(usuarioBEAN)session.getAttribute("usuario");
        
        Conexao minhaConexao=null;
        minhaConexao=(Conexao)session.getAttribute("minhaConexaoadm");
        
        usuarioDAO usuario_DAO=new usuarioDAO(minhaConexao);
        usuario_BEAN = usuario_DAO.login(usuario_BEAN);
        if((usuario_BEAN!=null)&&(usuario_BEAN.getIDStr()!=null)){
            session.setAttribute("usuario",usuario_BEAN);
            session.setAttribute("entrada", new Date());
        }
        else{            
            autentica=false;
        }
        out.write(usuario_BEAN.getNome());
    }
    catch(Exception erro){
        autentica=false;
    }
    if (!autentica){
        %>
            <script type="text/javascript">
                top.location='./logout.jsp'
            </script>
        <%
    }
 %>
                    </div>
                    <div class="branco" style="width:511px; height:45px; float:left;"></div>
                    <div id="ferramentas">
                        <div id="trocarsenha"><a href="./cadastro_usuario.jsp" target="conteudomeio" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image2','','imagenscrm/senha1.gif',1)"><img src="imagenscrm/senha2.gif" alt="Trocar Senha" name="Image2" width="124" height="45" border="0" id="Image2" /></a></div>
                        <div id="suporte"><a href="suporte.jsp" target="conteudomeio" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','imagenscrm/suporte1.gif',1)"><img src="imagenscrm/suporte2.gif" alt="Suporte" name="Image3" width="114" height="45" border="0" id="Image3" /></a></div>
                    </div>
                </div>
            </div>
        </div>
        <div class="linhastotal" style="background-image:url(imagenscrm/risco1.gif); background-repeat:repeat-x;">
            <div class="linhascentro">
                <div id="risco1"></div>
            </div>
        </div>
    </body>
</html>