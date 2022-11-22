<%@page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="DAO.contagemDAO"%>
<%@page import="DAO.menusDAO"%>
<%@page import="BEAN.menusBEAN"%>
<%@page import="java.util.Date"%>
<%@page import="net.fckeditor.FCKeditor"%>
<%@page import="POJO.paginasPOJO"%>
<%@page import="java.util.Vector"%>
<%@page import="DAO.paginasDAO"%>
<%@page import="BEAN.paginasBEAN"%>
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
<html>
    <head>        
        <meta http-equiv="Content-Type" content="text/html;charset=UTF-8"/>
        <title>Cadastro Página Toledo news</title>

        <script type="text/javascript" src="./js/home.js"></script>
        <script src="../SpryAssets/SpryTabbedPanels.js" type="text/javascript"></script>
        <script src="../slideshow/script.js" type="text/javascript"></script>
        <script src="../Scripts/swfobject_modified.js" type="text/javascript"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.4.4/jquery.min.js" type="text/javascript" charset="utf-8"></script>
        <script src="../fonts/specimen_files/easytabs.js" type="text/javascript" charset="utf-8"></script>

        <link rel="shortcut icon" href="./midia_mix.png"  type="image/x-icon"/>
        <link rel="stylesheet"    href="./estilosadm.css" type="text/css"/>
        <link rel="stylesheet"    href="../fonts/specimen_files/specimen_stylesheet.css" type="text/css" charset="utf-8" />
        <link rel="stylesheet"    href="../fonts/stylesheet.css" type="text/css" charset="utf-8" />
        <link rel="stylesheet"    href="../SpryAssets/SpryTabbedPanels.css" type="text/css" />
        <link rel="stylesheet"    href="../slideshow/style.css" type="text/css" />
        <link rel="shortcut icon" href="../images/home/favicon.ico"/>
        
        <style type="text/css">
            @import url('./css/home.css');
            @font-face{
                font-family:'MirageRegular';
                src: url('./fonts/magenta_bbt-webfont.eot');
                src: url('./fonts/magenta_bbt-webfont.eot?#iefix') format('embedded-opentype'), url('fonts/magenta_bbt-webfont.woff') format('woff'), url('fonts/magenta_bbt-webfont.ttf') format('truetype'), url('fonts/magenta_bbt-webfont.svg#MirageRegular') format('svg');
                font-weight: normal;
                font-style: normal;
            }
            #apDiv1{
                position:absolute;
                left:1263px;
                top:109px;
                width:41px;
                height:23px;
                z-index:1;
            }
            #apDiv2{
                position:absolute;
                left:728px;
                top:568px;
                width:248px;
                height:32px;
                z-index:1;
            }
        </style>
    </head>
    <body onload="relogio();">
            
        <center>
        <a class="texto1">Cadastro Páginas</a><br>
        <br>
        <%@include file="menu_submenu.jsp"%>
             
        
        
        <%
        Conexao minhaConexao=null;
        Until.functions request2=new Until.functions(); 
        minhaConexao=(Conexao)session.getAttribute("minhaConexaoadm");
        minhaConexao=new Conexao(Until.functions.CreateDataConection());
        paginasBEAN paginas_BEAN=new paginasBEAN();
        Vector registros_Paginas=new Vector();
        menusBEAN menus_BEAN__44=new menusBEAN();
        paginasDAO paginas_DAO = new paginasDAO(minhaConexao); 
        Vector registros_Menus_44=new Vector();

        request2.setRequest(request); 
        String acc="";
        if ((functions.path_upload!=null)&&(functions.path_upload.indexOf("\\")!=-1))
            acc="\\";
        else
            acc="/";

        String path=functions.path_upload+acc+"conteudo";
        String id=request2.getParameter("id");
        if((id!=null)&&(id.length()!=0)&&(!id.equals("null")))
            id=id;
        else
            id=request.getParameter("id");
        String id_menu=request.getParameter("id_menu");




        registros_Paginas.clear();
        try{menus_BEAN__44.setID(id_menu);}catch(Exception erro){}
        registros_Paginas=paginas_DAO.buscarPaginasMaisAcessadas(menus_BEAN__44,1,20);
        paginas_BEAN.Clear();
        
%>
        <br>
        <br>            
            
            acesso total por menu:<%=new contagemDAO(minhaConexao).contarTodosPorMenu(menus_BEAN__44)%>
            <br>
            <br>
            <table cellpadding= "4" cellspacing = "0" border= "1" width= "400px">
                <tr bgcolor="#CCCCCC">                           
                        <td><a class="texto3"> Titulo </a></td>
                        <td><a class="texto3"> Data </a></td>
                        <td><a class="texto3"> Acessos </a></td>
                </tr>
                    <%
                        if((registros_Paginas!=null)&&(registros_Paginas.size()>0)){
                            for(int i=0;i<registros_Paginas.size();i++){
                                paginas_BEAN=((paginasBEAN)registros_Paginas.get(i));
                    %>
                <tr>
                    <td><%=paginas_BEAN.getTitulo()%></td>
                    <td><%=paginas_BEAN.getInicioStr("dd/MM/yyyy HH:mm:ss")%></td>
                    <td>
                        <%=paginas_BEAN.getContador()%>
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