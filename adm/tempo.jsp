<%@page import="java.util.Date"%><%@page contentType="text/html" pageEncoding="UTF-8"%><%
    try{
        Date entrada=(Date)session.getAttribute("entrada");
        long diferenca = (new Date()).getTime() -entrada.getTime();
        //out.write(diferenca+"");
        diferenca=(10*60*1000)-diferenca;
        if(diferenca<=0)
            session.invalidate();
        Date tempo=new Date(diferenca);
        out.write(Until.functions.DateToString(tempo, "mm:ss",null));
    }
    catch(Exception erro){
        session.invalidate();
        out.write("00:00");
    }
%>