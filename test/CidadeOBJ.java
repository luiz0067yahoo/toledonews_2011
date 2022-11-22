import java.lang.Exception;

public class CidadeBean{
	private int Codigo;
	private String Descricao;
	
	public CidadeBean(){
		this.Codigo=0;
		this.Descricao="";
	}
	
	public void setarCodigo(int Codigo) {
		if (Codigo>0){
			this.Codigo=Codigo;
		}
		else{
			
		}
	}	
}
