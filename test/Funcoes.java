import java.lang.Exception;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;


public class Funcoes {
	
	public static long ValidaInteiro(String Valor,long ValorAtual) {
		try{
			return Long.parseLong(Valor);
		}
		catch(Exception erro){
			return ValorAtual;
		}
	}

	public static long ValidaInteiro(long Valor,long Minimo,long Maximo,long ValorAtual) {
		if ((Minimo<=Valor)&&(Maximo>=Valor))
		{
			return Valor;
		}
		else{
			return ValorAtual;
		}
	}

	public static long ValidaInteiro(long Valor,long ValorComparado,boolean MinimoMaximo,long ValorAtual) {
		if  
		(
			((ValorComparado>=Valor)&&(MinimoMaximo))
			||
			((ValorComparado<=Valor)&&(!MinimoMaximo))
		)
		{
			return Valor;
		}
		else{
			return ValorAtual;
		}
	}


	public static String ValidaTexto(String Valor,long Minimo,long Maximo,String ValorAtual) {
		String Resultado;
		if (Valor==null){
			Resultado=ValorAtual;
		}
		else{
			Valor=Valor.trim();
			int Tamanho=Valor.length();
			if ((Maximo>=Tamanho)&&(Minimo<=Tamanho))
			{
				Resultado=Valor;
			}
			else{
				Resultado=ValorAtual;
			}
		}
		return Resultado;
	}


	public static String ValidaTexto(String Valor,long ValorComparado,boolean MinimoMaximo,String ValorAtual) {
		String Resultado;
		if (Valor==null){
			if (MinimoMaximo)
				Resultado=ValorAtual;
			else
				Resultado=ValorAtual;
		}
		else{
			Valor=Valor.trim();
			int Tamanho=Valor.length();
			if 
			(
				((ValorComparado>=Tamanho)&&(MinimoMaximo))
				||
				((ValorComparado<=Tamanho)&&(!MinimoMaximo))
			)			
			{
				Resultado=Valor;
			}
			else{
				Resultado=ValorAtual;
			}
		}
		return Resultado;
	}

	public static Date ValidaData(String Valor,String Formato,Date ValorAtual) {
		try{
			SimpleDateFormat formatar = new SimpleDateFormat(Formato);   
			return formatar.parse(Valor);
		}
		catch(Exception erro){
			return ValorAtual;
		}
	}

	public static String FormatarData(Date Data,String Formato) {
        String minha_data;
        try{
            SimpleDateFormat formatar = new SimpleDateFormat(Formato);   
            minha_data = formatar.format(Data);
        }
        catch(Exception erro){
            minha_data="null";
        }
        return minha_data;
	}

	public static String AdicionarAspas(String Valor) {
		return (Valor==null)?"null":"'"+Valor+"'";
	}
}
