import java.lang.Object;

public interface EventoVetor{
	
	//public boolean Adicionar(Object dado);

	//public Object Mostrar();
	
	//public boolean Substituir(Object dado);
	
	public boolean Remover();

	public boolean Avancar();

	public boolean Voltar();
	
	public boolean Inicio();

	public boolean Fim();

	public int Posicao();

	public int Tamanho();
	
	public void QuandoMover(Object dado);
	
	public void QuandoAtualizar(Object dado);
}