import java.util.Vector;
import java.lang.Object;
import java.lang.Exception;
import javax.swing.JOptionPane;

public class Vetor {
	private Vector vetor;
	private int i;
	
	public Vetor(){
		i=-1;
		this.vetor=new Vector();
	}
	
	
	protected boolean Adicionar(Object dado){
		try{
			this.vetor.add(dado);
			i=this.vetor.size()-1;
			return true;
		}
		catch(Exception erro){
			return false;
		}
	}

	protected Object Mostrar(){
		try{
			return this.vetor.get(i);
		}
		catch(Exception erro){
			return null;
		}
	}
	
	protected boolean Substituir(Object dado){
		try{
			this.vetor.set(i,dado);
			return true;
		}
		catch(Exception erro){
			return false;
		}
	}
	
	public boolean Remover(){
		try{
			this.vetor.remove(i);
			if (i>(this.vetor.size()-1)){
				i--;
			}
			return true;
		}
		catch(Exception erro){
			return false;
		}
	}

	public boolean Avancar(){
		if (this.vetor.size()>i+1){
			i++;
			return true;
		}
		else{
			return false;
		}
	}

	public boolean Voltar(){
		if (i>0){
			i--;
			return true;
		}
		else{
			return false;
		}
	}
	
	public boolean Inicio(){
		if (this.vetor.size()>0){
			i=0;
			return true;
		}
		else{
			return false;
		}
	}

	public boolean Fim(){
		if (this.vetor.size()>0){
			i=this.vetor.size()-1;
			return true;
		}
		else{
			return false;
		}
	}

	public int Posicao(){
			return i+1;
	}

	public int Tamanho(){
		return this.vetor.size();
	}
}