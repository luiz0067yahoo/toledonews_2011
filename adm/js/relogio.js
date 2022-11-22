function relogio(){
	var conecta=new ajax();
	document.getElementById("cronometro").innerHTML = conecta.enviar("./tempo.jsp", "get",false	);
	if(document.getElementById("cronometro").innerHTML=="00:00"){
			self.location.href="./logout.jsp";
	}
	setTimeout('relogio()', 1000);
}
//Prototype e heran�a de objeto
//crio um objeto principal e outros objetos que serao as subClasse para o primeiro, fazendo a heran�a de objetos
function ajax() {
};
//metodo iniciar
ajax.prototype.iniciar = function() {
//logo abaixo tentamos estanciar o objeto XMLHttpRequest() para o IE e os demais navegadores
	try{
            this.xmlhttp = new XMLHttpRequest();
	}catch(ee){
            try{
                            this.xmlhttp = new ActiveXObject("Msxml2.XMLHTTP");
            }catch(e){
                try{
                                    this.xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
                }catch(E){
                                this.xmlhttp = false;
                }
            }
	}
	return true;
}
//metodo oculpado
ajax.prototype.ocupado = function() {
		estadoAtual = this.xmlhttp.readyState;
		return (estadoAtual && (estadoAtual < 4));
}
//metodo processa
ajax.prototype.processa = function() {
	if (this.xmlhttp.readyState == 4 && this.xmlhttp.status == 200) {
			return true;
	}
}
//metodo envia esperando a url, o metodo get ou post e o modo true ou false
ajax.prototype.enviar = function(url, metodo, modo) {
//se nao existir o objeto xmlhttp ele sera criado com o metodo iniciar
	if (!this.xmlhttp) {
			this.iniciar();
	}
//se nao estiver oculpado
	if (!this.ocupado()) {
//se o metodo passado for get
			if(metodo == "GET") {
					this.xmlhttp.open("GET", url, modo);
					this.xmlhttp.send(null);
			} else {
//se for post        
					this.xmlhttp.open("POST", url, modo);
					this.xmlhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded; charset=UTF-8");
					this.xmlhttp.setRequestHeader("Cache-Control", "no-store, no-cache, must-revalidate");
					this.xmlhttp.setRequestHeader("Cache-Control", "post-check=0, pre-check=0");
					this.xmlhttp.setRequestHeader("Pragma", "no-cache");
					this.xmlhttp.send(url);
			}    
//se estiver ok ele retorna o resultado e ja utilizamos um modo para receber acentos
// usando a fun��o unescape e substituindo os + por espa�os mesma coisa que usar urldecode() do php
			if (this.processa) {
//recebe o resultado da da pagina php
					return unescape(this.xmlhttp.responseText.replace(/\+/g," "));
			}
	}
	return false;
}

function menuJump(element){
    var acc="?"+element.name+"=";
    var id_categoria=element.options[element.selectedIndex].value
    acc=acc+id_categoria;
    self.location.href=acc;
}
function menuJumpPatrocineo(element){
    var acc=element.options[element.selectedIndex].title
    self.location.href=acc;
}
function menuJumpConteudo(element){
    var acc="?"+element.name+"=";
    var id_categoria=element.options[element.selectedIndex].value
    acc=acc+id_categoria;
    self.location.href=acc;
}