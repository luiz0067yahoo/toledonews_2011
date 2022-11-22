import java.lang.Exception;

public class CidadeDao{
	private Conexao con;
	
	public  CidadeDao(Conexao con){
		this.con=con;
	}

	public void Inserir(CidadeBean Cidade){
		sql="insert into cidade (1,'"+Cidade.+"') values" 
	}
	
	public void Alterar(CidadeBean Cidade){
	}
	
	public void Excluir(CidadeBean Cidade){
	}
	
	public void Buscar(){
		
	}
}
