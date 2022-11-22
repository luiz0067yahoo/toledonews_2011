<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Tela de Apresentação Mídia Mix</title>
        <%@page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
        <%@page import="java.util.Date"%>
        <%@page import="DAO.usuarioDAO"%>
        <%@page import="BEAN.usuarioBEAN"%>
        <%@page import="java.util.Vector"%>
        <%@page import="BD.Conexao"%>
        <%@page import="BD.DadosConexao"%>
        <link rel="stylesheet" type="text/css" href="estilosadm.css" />
        <style type="text/css">
                body{
                    width:100%; height:100; margin-left:0px; margin-right:0px; margin-top:0px; margin-bottom:0px;
                }
        </style>
        <script type="text/javascript">
            function MM_swapImgRestore() { //v3.0
                var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
            }
            function MM_preloadImages() { //v3.0
                var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
                var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
                if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
            }

            function MM_findObj(n, d) { //v4.01
                var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
                    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
                if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
                for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
                if(!x && d.getElementById) x=d.getElementById(n); return x;
            }

            function MM_swapImage() { //v3.0
                var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
                if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
            }
        </script>
    </head>
    <body onload="MM_preloadImages('entrar2.gif','login2.gif')">
            <%    
                Conexao minhaConexao=new Conexao(Until.functions.CreateDataConection()); 
                session.setAttribute("minhaConexaoadm",minhaConexao);
                usuarioBEAN usuario_BEAN=new usuarioBEAN();
                usuarioDAO usuario_DAO=new usuarioDAO(minhaConexao);
                String login=request.getParameter("login");
                String senha=request.getParameter("senha");
                String erro_login="";
                String erro_senha="";
                String acao=request.getParameter("acao");
                if((acao!=null)&&(acao.length()>0)){                       
                    if(acao.equals("entrar")){
                        try{usuario_BEAN.setLogin(login);}catch(Exception erro){erro_login=erro.getMessage();}
                        try{usuario_BEAN.setSenha(senha);}catch(Exception erro){erro_senha=erro.getMessage();} 
                        usuario_BEAN = usuario_DAO.login(usuario_BEAN);
                        if(usuario_BEAN!=null){                            
                            session.setAttribute("usuario",usuario_BEAN);
                            session.setAttribute("entrada", new Date());
                            response.sendRedirect("principal.jsp");
                        }
                        else{%>
                        <a id="invalid">Usuário ou senha Inválida</a>
                        <% }
                    }  
                 }
                 try{minhaConexao.Fechar();}catch(Exception erro){}
                       
            %>
    <div id="tudo">
    	<div class="linhas">
        	<div class="linhacentro" style="height:33px;"></div>
        </div>
        <div class="linhas">
        	<div class="linhacentro" style="height:81px;">
            	<div style="height:81px; width:232px; float:center; margin-left:auto; margin-right:auto;"><img src="logo1.gif" /></div>
            </div>
        </div>
        <div class="linhas" style="height:128px;">
       	  <div class="linhacentro" style="height:15px;"></div>
          <div class="texto1" style="height:23px;">Seja Bem Vindo ao seu </div>
          <div class="texto2" style="height:29px;">Sistema Administrativo de Web</div>
          <div class="linhacentro" style="height:31px;"></div>
          <div class="invalid" style="height:30px;"></div>
        </div>
        <div class="linhas" style="background-color:#D1D1D1;">
        	<div class="linhacentro" style="height:132px;">
            	<div class="input">
                	<form method="post">
                	  <div class="espaco" style="width:250px; height:31px;">
                        <div class="espaco" style="width:79px; height:31px; line-height:31px;"><a class="texto3">Usuário:</a></div>
                            <div class="espaco" style="width:151px; height:31px; padding-left:10px; padding-right:10px; padding-top:5px; padding-right:10px;">
                                <input class="input" type="text" name="login" />
                            </div>
                      </div>
                        <div class="espaco" style="width:250px; height:9px;"></div>
                        <div class="espaco" style="width:250px; height:31px;">
                            <div class="espaco" style="width:79px; height:31px; line-height:31px;"><a class="texto3">Senha:</a></div>
                            <div class="espaco" style="width:151px; height:31px; padding-left:10px; padding-right:10px; padding-top:5px; padding-right:10px;">
                                <input class="input" type="password" name="senha" />
                            </div>
                        </div>
                        <input type="submit" value="entrar" name="acao" style="margin-left:100px; display:inline;">
                  </form>
                </div>
            </div>
        </div>
        <div class="linhas" style=" height:4px; background-image:url(barradegrade.gif); background-repeat:repeat-x;">
        	<div class="linhacentro">
                
            </div>
        </div>
      <div class="linhas">
       	<div class="linhacentro" style="height:110px;">
           	  <div class="espaco" style="width:357px; height:110px;"></div>
              <div class="espaco" style="width:106px; height:110px;">
              	  <div class="espaco" style="width:106px; height:52px; background-image:url(cadeado.gif)"></div>
                  <div class="espaco" style="width:106px; height:58px;"></div>	
              </div>
              <div class="espaco" style="width:337px; height:114px;"></div>
              
        </div>
       	 </div>
            <div class="linhas">
                    <div class="linhacentro" style="height:110px;">
                    <div class="espaco" style="width:357px; height:110px;"></div>
                    <div class="espaco" style="width:106px; height:110px; background-image:url(mix.gif);"></div>
                    <div class="espaco" style="width:337px; height:110px;"></div>
                </div>
            </div>
        </div>
    </body>
</html>