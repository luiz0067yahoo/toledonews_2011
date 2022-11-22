
function $(id){
	return document.getElementById(id)
}
function addEvent( obj, type, fn ) {
  if ( obj.attachEvent ) {
    obj['e'+type+fn] = fn;
    obj[type+fn] = function(){obj['e'+type+fn]( window.event );}
    obj.attachEvent( 'on'+type, obj[type+fn] );
  } else
    obj.addEventListener( type, fn, false );
}
function removeEvent( obj, type, fn ) {
  if ( obj.detachEvent ) {
    obj.detachEvent( 'on'+type, obj[type+fn] );
    obj[type+fn] = null;
  } else
    obj.removeEventListener( type, fn, false );
}
function ocultarlupa(){
	$('iconebusca').style.display='none';				
}
function mostrarlupa(){
	if (($('pesquisa').value!=null)&&($('pesquisa').value.length>0))
		$('iconebusca').style.display='none';
	else 
		$('iconebusca').style.display='';
}
function ajustes(ativo){
	var x=$('banner1').scrollHeight;
	var y=$('banner1').scrollWidth;
	$('verticaltextbanner1').style.width=(x+2)+"px";
	$('fundobanner1').style.height=(x)+"px";
	$('containnerbanner1').style.height=(x+2)+"px";
	$('barracinza').style.height=(x+26)+"px";
	$('logo').style.marginTop=Math.round((x/62)*29)+"px";
}
addEvent(window, "load", ajustes, false);
function mostrarsubmenus(menu){
	if (menu!=null)
	for (i=0; i<menu.childNodes.length; i++) {
		var node = menu.childNodes[i];
		if (node.className=="menu") {
			node.style.backgroundColor="#E6E7E8";
		}
		else if (node.className=="submenus") {
			mostrarsubmenus.node=node;
			mostrarsubmenus.node.style.display="block";
			break;
		}
	}	
}
function ocultarsubmenus(menu){
	if (menu!=null)
	for (i=0; i<menu.childNodes.length; i++) {
		var node = menu.childNodes[i];
		if (node.className=="menu") {
			node.style.backgroundColor="";
		}
		else if (node.className=="submenus") {
			ocultarsubmenus.node=node;
			ocultarsubmenus.node.style.display="none";
			//setTimeout('ocultarsubmenus.node.style.display="none"',1)
			break;
		}
	}	
}
function menuteclado(menu,e){
	var code;
	code= (window.event) ?window.event.keyCode:e.which;
	if	
	(
		(
			(menuteclado.className=="sub_menu_vertical")
			&&
			(code==39)
		)
		||
		((code==38)||(code==40))
	)
	{
		mostrarsubmenus(menu);
	}
	else if	
	(
		(
			(menuteclado.className=="sub_menu_vertical")
			&&
			(code==37)
		)
		||
		((code==27)||(code==40))
	)
		ocultarsubmenus(menu);	
}