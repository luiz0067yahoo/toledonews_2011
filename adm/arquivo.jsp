<%
    try{
            String nome=request.getParameter("nome");
        String nome_completo="";
        String pasta=request.getParameter("pasta");
        if ((Until.functions.path_upload!=null)&&(Until.functions.path_upload.indexOf("\\")!=-1)){
            pasta=(pasta!=null)?pasta+"\\":"";
            nome_completo=Until.functions.path_upload+"\\"+pasta+nome;
        }
        else{
            pasta=(pasta!=null)?pasta+"/":"";
            nome_completo=Until.functions.path_upload+"/"+pasta+nome;
        }
        java.io.File file=new java.io.File(nome_completo);
        if(file.exists()){
            response.setContentType("application/octet-stream");
            response.setHeader("Content-Disposition","attachment;filename="+nome+"");
            java.io.InputStream fileIn = new java.io.FileInputStream(file);
            ServletOutputStream  out2 = response.getOutputStream();
            byte[] outputByte = new byte[4096];
            while(fileIn.read(outputByte, 0, 4096) != -1)
            { 
                out2.write(outputByte, 0, 4096);
            }
            fileIn.close();
        }
        else{
            pasta=request.getParameter("pasta2");
            if ((Until.functions.path_upload!=null)&&(Until.functions.path_upload.indexOf("\\")!=-1)){
                pasta=(pasta!=null)?pasta+"\\":"";
                nome_completo=Until.functions.path_upload+"\\"+pasta+nome;
            }
            else{
                pasta=(pasta!=null)?pasta+"/":"";
                nome_completo=Until.functions.path_upload+"/"+pasta+nome;
            }
            file=new java.io.File(nome_completo);
            if(file.exists()){
                file=new java.io.File(nome_completo);
                response.setContentType("application/octet-stream");
                response.setHeader("Content-Disposition","attachment;filename="+nome+"");
                java.io.InputStream fileIn = new java.io.FileInputStream(file);
                ServletOutputStream  out2 = response.getOutputStream();
                byte[] outputByte = new byte[4096];
                while(fileIn.read(outputByte, 0, 4096) != -1)
                { 
                    out2.write(outputByte, 0, 4096);
                }
                fileIn.close();
            }
        }
    }
    catch(Exception erro){        
    }
%>