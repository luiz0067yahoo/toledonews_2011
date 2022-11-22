import java.lang.Exception;

public class CidadeMysql{
	private Conexao con;
	
	public  CidadeMysql(Conexao con){
		this.con=con;
	}

	public void Inserir(CidadeBean Cidade){
		String sql="insert into cidade (cidade.descricao) values ('"+Cidade.mostarDescricao()+"')";
		con.Executa(sql);
	}
	
	public void Alterar(CidadeBean Cidade){
		String sql="update  cidade set cidade.descricao='"+Cidade.mostarDescricao()+"' where (cidade.codigo="+Cidade.mostarCodigo()+")";
		con.Executa(sql);
	}
	
	public void Excluir(CidadeBean Cidade){
		String sql="delete from  cidade where (cidade.codigo="+Cidade.mostarCodigo()+")";
		con.Executa(sql);
	}
	
	public void Buscar(){
		String sql="select cidade.codigo as cidade_codigo,cidade.descricao as cidade_descricao from  cidade ";
		con.Busca();
		con.
	}
}
