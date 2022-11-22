import java.lang.Exception;

public class Funcoes{
	
	public static long ValidaInteiro(String Valor,String Campo) throws Exception{
		try{
			return Long.parseLong(Valor);
		}
		catch(Exception erro){
			String mensagem=
			"Valor \""+Valor+"\" inválido!"
			+"\n"
			+" O "+Campo+" deve ser um numero inteiro"
			throw new Exception();
		}
	}

	public static long ValidaInteiro(long Valor,int Minimo,Minimo_Maximo,String Campo) throws Exception{
		try{
			return Long.parseLong(Valor);
		}
		catch(Exception erro){
			String mensagem=
			"Valor \""+Valor+"\" inválido!"
			+"\n"
			+" O "+Campo+" deve ser um numero inteiro"
			throw new Exception();
		}
	}
	
}
