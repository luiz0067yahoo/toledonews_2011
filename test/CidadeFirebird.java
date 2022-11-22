import java.lang.Exception;

public class CidadeMysql{
	private Conexao con;
	
	public  CidadeMysql(Conexao con){
		this.con=con;
	}

	public void Inserir(CidadeBean Cidade){
		sql="insert into cidade (cidade.descricao) values ('"+Cidade.mostarDescricao()+"')" 
		sql="insert into cidade (cidade.codigo,cidade.descricao) values ((select max(codigo) from cidade)+1,'"+Cidade.mostarDescricao()+"')" 
	}
	
	public void Alterar(CidadeBean Cidade){
	}
	
	public void Excluir(CidadeBean Cidade){
	}
	
	public void Buscar(){
		
	}
}
