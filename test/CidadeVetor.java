import java.lang.Exception;

public class CidadeVetor extends Vetor implements EventoVetor{
	public CidadeVetor(){
		super();
		this.setarElemento(this);
	}
	
	public boolean Adicionar(CidadeBean Cidade){
		return super.Adicionar(Cidade);
	}
	
	public boolean Substituir(CidadeBean Cidade){
		return super.Substituir(Cidade);
	}

	public CidadeBean Mostrar(){
		CidadeBean Cidade= new CidadeBean();
		try{
			if (super.Mostrar()!=null)
				Cidade=(CidadeBean)super.Mostrar();
		}
		catch (Exception erro){
		}
		return Cidade;
	}
	
	public void QuandoMover(Object dado){
		
	}

	public void QuandoAtualizar(Object dado){
		
	}
}
