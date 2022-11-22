<%@page import="java.util.List"%>
<%@page import="DAO.usuarioDAO"%>
<%@page import="java.util.Date"%>
<%@page import="BEAN.usuarioBEAN"%>
<%@page import="DAO.restricaoDAO"%>
<%@page import="BEAN.restricaoBEAN"%>
<%@page import="POJO.categoriaFotosPOJO"%>
<%@page import="Until.functions"%>
<%@page import="java.util.Vector"%>
<%@page import="DAO.categoriaFotosDAO"%>
<%@page import="BEAN.categoriaFotosBEAN"%>
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
<style type="text/css">
	.texto1{font-family:Arial, Helvetica, sans-serif; font-size:14px; text-align:center;  font-size:16px; text-align:center; width:800px; height:auto; margin-right:auto; margin-left:auto; float:center; line-height:23px;}
	
	.texto2{font-family:Arial, Helvetica, sans-serif; font-size:14px; text-align:center; font-size:26px; text-align:center; width:800px; height:auto; margin-right:auto; margin-left:auto; float:center; line-height:29px;}
	
	.texto3{font-family:Arial, Helvetica, sans-serif; font-size:14px; text-align:center; font-size:15px; text-align:center; width:800px; height:auto; margin-right:auto; margin-left:auto; float:center; line-height:29px;}
</style>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cadastro categoria Fotos</title>
        <link rel="shortcut icon" href="./midia_mix.png" 	type="image/x-icon" />
        <script type="text/javascript" src="js/relogio.js"></script>
        <script type="text/javascript" >
                
            function carrega(){
                relogio('data_hora.jsp','data_hora');
                relogio();
            }
        </script>
    </head>
    <body onload="relogio();">
        <center>
           <% 
                String mensagem_acao="";   
                String command01="";   
                String command02="";   
                String acao=request.getParameter("acao");   
                String Data=request.getParameter("Data");   
                String Hora=request.getParameter("Hora");   
                Date data_hora=new Date(); 
                if((acao!=null)&&(acao.length()>0)){
                    if(acao.equals("Salvar")){
                        try{
                            data_hora=Until.functions.StringToDate(Data+" "+Hora,"dd/MM/yyyy HH:mm:ss");
                            
                            command01="sudo date +%T -s \""+Until.functions.DateToString(data_hora,"HH:mm:ss")+"\"";
                            command02="sudo date +%Y%m%d -s  \""+Until.functions.DateToString(data_hora,"yyyyMMdd")+"\"";
                            Runtime.getRuntime().exec(command01);
                            Runtime.getRuntime().exec(command02);

                            
                            
                            
                        }
                        catch(Exception erro){
                            mensagem_acao="Data e hora ivalida";
                        }
                    }
                }
                
           %>
        <a class="texto1">Cadastro categoria Fotos</a><br><br>
            <form method="post">
                <a class="texto3" id="data_hora"></a><br>
                <a class="texto3">data:</a> <input type="text" name="Data" value="<%=Until.functions.DateToString(data_hora,"dd/MM/yyyy")%>">dd/MM/aaaa<br>
                <a class="texto3">hora:</a> <input type="text" name="Hora" value="<%=Until.functions.DateToString(data_hora,"HH:mm:ss")%>">HH:mm:ss<br>
               <%if(restricao_acesso.getSalvar()){%><input type="submit" value="Salvar" name="acao"><%}%><br>
               <h1 style="color:red"><%=mensagem_acao%></h1>
               <h1 style="color:red"><%=command01%></h1>
               <h1 style="color:red"><%=command02%></h1>
            </form>
 
            
                </table>
        </center>
    </body>
</html>
<%}%>