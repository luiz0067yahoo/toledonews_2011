<%@page import="java.util.Date"%>
<%@page import="Until.functions"%>
<div class="linhastotal" >
<%  
session.setAttribute("usuario",session.getAttribute("usuario"));
session.setAttribute("entrada", new Date());                 
try{ 
    String id_menu_=request.getParameter("id_menu");
    String id_pagina_=request.getParameter("id_pagina");            
    String pg_=request.getParameter("pg");
    String id_categoria=request.getParameter("id_categoria");
    int total_paginas=0;
    int posicao=0;
    try{
        total_paginas=Integer.parseInt(session.getAttribute("total").toString());
    }
    catch(Exception erro_total_paginas){
    }
    try{
        posicao=Integer.parseInt(session.getAttribute("posicao").toString());
        if(posicao<=0)
            posicao=1;
    }
    catch(Exception erro_total_paginas){
        posicao=1;
    }
%>
<div style="width:100%;clear:both;display:block;height:20px;">
    <div style="width:200px;clear:both;margin-left:auto;margin-right:auto">
        <%if((posicao)  < total_paginas){   %>  <a href="?pg=<%=functions.removenull(pg_)%>&id_menu=<%=functions.removenull(id_menu_)%>&id_pagina=<%=functions.removenull(id_pagina_)%>&id_categoria=<%=functions.removenull(id_categoria)%>&posicao=<%=total_paginas%>"              style="text-decoration:none;color:black;">      &nbsp;<<&nbsp;                        </a>    <%}%>
        <%if((posicao+1)<=total_paginas){   %>  <a href="?pg=<%=functions.removenull(pg_)%>&id_menu=<%=functions.removenull(id_menu_)%>&id_pagina=<%=functions.removenull(id_pagina_)%>&id_categoria=<%=functions.removenull(id_categoria)%>&posicao=<%=(posicao+1)%>"  style="text-decoration:none;color:black;">      &nbsp;<&nbsp;                         </a>    <%}%>

        <%if((posicao+1)<=total_paginas){   %>  <a href="?pg=<%=functions.removenull(pg_)%>&id_menu=<%=functions.removenull(id_menu_)%>&id_pagina=<%=functions.removenull(id_pagina_)%>&id_categoria=<%=functions.removenull(id_categoria)%>&posicao=<%=(posicao+1)%>"  style="text-decoration:none;color:black;">      &nbsp;<%=(posicao+1)%>&nbsp;    </a>    <%}%>
        <%if((posicao)  < total_paginas){   %>  <a href="??pg=<%=functions.removenull(pg_)%>&id_menu=<%=functions.removenull(id_menu_)%>&id_pagina=<%=functions.removenull(id_pagina_)%>&id_categoria=<%=functions.removenull(id_categoria)%>&posicao=<%=(posicao)%>"    style="text-decoration:none;color:black;">      &nbsp;<%=(posicao)%>&nbsp;      </a>    <%}%>
        <%if((posicao-1)>=1){       %>  <a href="?pg=<%=functions.removenull(pg_)%>&id_menu=<%=functions.removenull(id_menu_)%>&id_pagina=<%=functions.removenull(id_pagina_)%>&id_categoria=<%=functions.removenull(id_categoria)%>&posicao=<%=(posicao-1)%>"  style="text-decoration:none;color:black;">      &nbsp;<%=(posicao-1)%>&nbsp;    </a>    <%}%>

        <%if((posicao-1)>=1){       %>  <a href="?pg=<%=functions.removenull(pg_)%>&id_menu=<%=functions.removenull(id_menu_)%>&id_pagina=<%=functions.removenull(id_pagina_)%>&id_categoria=<%=functions.removenull(id_categoria)%>&posicao=<%=(posicao-1)%>"  style="text-decoration:none;color:black;">      &nbsp; > &nbsp;                         </a>    <%}%>
        <%if((posicao)  > 1){       %>  <a href="?pg=<%=functions.removenull(pg_)%>&id_menu=<%=functions.removenull(id_menu_)%>&id_pagina=<%=functions.removenull(id_pagina_)%>&id_categoria=<%=functions.removenull(id_categoria)%>&posicao=1"                       style="text-decoration:none;color:black;">      &nbsp;>>&nbsp;                        </a>    <%}%>
    </div>
</div>
<%
}  
catch(Exception erro__paginação){
}
%>  
</div>