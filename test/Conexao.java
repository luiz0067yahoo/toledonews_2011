import java.sql.*;
import javax.swing.JOptionPane;
        
public class Conexao 
{
    
    private  static Connection con;
    private  static Statement stm;
    private  static ResultSet rs=null; 
    private  static String sgbd=null; 
	private  static DadosConexao dados;    

    public Conexao(DadosConexao dados){
    	this.dados=dados;
        con=null;
        stm=null;
    }

    public static boolean Abrir() 
    {
        try
        {
            String driver="", url="";
            if (dados.mostrarSGBD().equals(DadosConexao.MYSQL)){
            	url = "jdbc:mysql://"+dados.mostrarServidor()+"/"+dados.mostrarBanco();
	            driver = "com.mysql.jdbc.Driver";
        	}
            Class.forName(driver);
            con=DriverManager.getConnection(url,dados.mostrarUsuario(),dados.mostrarSenha());
            stm=con.createStatement();
            return true;
        }
        catch (Exception erro){return false;}
    }


    public static boolean Fechar() 
    {
        try 
        {
            con.close(); 
            return true;
        }
        catch(SQLException sqle) 
        {
            return false;
        }
    }
    
    public  boolean Busca(String sql) {
        boolean resultado=false;
        rs=null;
        if (con==null){
            Abrir();
        }
        try{
            rs=stm.executeQuery(sql);
            resultado = true;
        }
        catch (Exception e){
        }
        //JOptionPane.showInputDialog("",sql);
        return resultado;
    }
    
    public static boolean Executa(String sql){
        boolean resultado=false;
        if (con==null){
            Abrir();
        }
        try{
            resultado=stm.execute(sql);
            //resultado=true;
        }
        catch (Exception e){
        }
        return resultado;
    }
    
    public String MostrarCampo(String campo){
        String resultado="";
        try{
            resultado=rs.getString(campo);
        }
        catch(Exception e){
        }
        return resultado;
    }
    
    public boolean MoverProximo(){
        try{
            return rs.next();
        }
        catch(Exception e){
            return false;
        }
    }
    
    public boolean MoverInicio(){
        try{
            return rs.first();
        }
        catch(Exception e){
            return false;
        }
    }

    public boolean MoverFim(){
        try{
            return rs.last();
        }
        catch(Exception e){
            return false;
        }
    }

    public boolean MoverVoltar(){
        try{
            return rs.previous();
        }
        catch(Exception e){
            return false;
        }
    }

}
