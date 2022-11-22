import java.lang.Exception;

public class CidadeBean{
	
	private long Codigo;
	private String Descricao;
	
	public CidadeBean(){
		this.Codigo=0;
		this.Descricao="";
	}
	
	public void setarCodigo(int Codigo) {
	}	
	
	public void setarCodigo(String Codigo) {
	}	

	public void setarDescricao(String Descricao) {
	}	

	public long mostarCodigo() {
		return this.Codigo;
	}	

	public String mostarDescricao() {
		return this.Descricao;
	}	

}
