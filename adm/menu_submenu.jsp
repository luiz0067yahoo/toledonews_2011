
<%@page import="java.util.Date"%>
<%@page import="Until.functions"%>
<%@page import="java.util.Vector"%>
<%@page import="DAO.menusDAO"%>
<%@page import="BEAN.menusBEAN"%>
<%@page import="BD.Conexao"%>
<div class="linhastotal" style="background-image:url(./images/home/fundo_menu.png); background-repeat:repeat-x;" >
    <div class="barra_menus" >
    <%
    
    try{
        Conexao minhaConexao2=null;
        try{minhaConexao2=(Conexao)session.getAttribute("minhaConexaoadm");}
        catch(Exception erro){minhaConexao2=new Conexao(Until.functions.CreateDataConection());}
        //minhaConexao2=new Conexao(Until.functions.CreateDataConection());
        
        menusDAO menus_DAO =new menusDAO(minhaConexao2);
        Vector registros_menus=new Vector();
        registros_menus=menus_DAO.buscarTodosMenus(1,8);
        if(registros_menus.size()!=0)
        for(int x=0;x<registros_menus.size();x++){
            
            String titulo_menu="";
            String id_do_menu="";
            menusBEAN menu =new menusBEAN();
            try{menu=(menusBEAN)registros_menus.get(x);}catch(Exception erro__3333){}            
            try{id_do_menu=menu.getIDStr();  }catch(Exception erro__3333){}
            try{titulo_menu=menu.getTitulo();}catch(Exception erro__3333){}
    %>                     
        <div class="coluna_menu" onmouseover="mostrarsubmenus(this)" onmouseout="ocultarsubmenus(this)" onkeydown="menuteclado(this,event)">
            <div class="menu">
                <a class="menu" href="?id_menu=<%=id_do_menu%>">
                    <div class="menu<%=x+1%>">&nbsp;&nbsp;<%=titulo_menu%>&nbsp;&nbsp;</div>
                </a> 
            </div>                            
            <div class="esquerda"><img src="../images/home/divisor_menu.png" height="34px" width="3px"/></div>
            <%
                try{
                Vector registros_submenus=menus_DAO.buscarTodosSubMenus(menu);
                if(registros_submenus.size()!=0){
            %>    
            <div class="submenus"><!-- submenus -->
                <div class="coluna_menu" >
                <%
                    
                        for(int y=0;y<registros_submenus.size();y++){
                            menu =(menusBEAN)registros_submenus.get(y);
                            titulo_menu="";
                            id_do_menu="";
                            menu =new menusBEAN();
                            try{menu=(menusBEAN)registros_submenus.get(y);}catch(Exception erro__3333){}                            
                            try{id_do_menu=menu.getIDStr();  }catch(Exception erro__3333){}
                            try{titulo_menu=menu.getTitulo();}catch(Exception erro__3333){}
                    %>
                    <div class="sub_menu_vertical" >
                        <div class="menu">
                            <a class="sub_menu" href="?id_menu=<%=id_do_menu%>">
                                <div class="sub_menu<%=x+1%>"><%=titulo_menu%></div>
                            </a> 
                        </div>
                    </div>
                        <%if(y%7==6){%>
                </div>
                <div class="coluna_menu">
                        <%}%>
<%
                        }
%>  
                </div>                        
            <!--submenus--> 
            </div>
            <%
                }
            }
            catch(Exception erro__asd___){
                String erro =erro__asd___.getMessage();
            }  
        %>       
        </div>   
    <%                        
        }
    }
    catch(Exception erro2){
        String erro =erro2.getMessage();
    }
    %>                
    </div>
</div>