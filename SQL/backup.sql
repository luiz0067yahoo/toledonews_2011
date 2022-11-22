


/*inicio videos*/
DROP TABLE IF EXISTS categoriavideos;
create table categoriavideos(
id integer not null primary key auto_increment,
titulo varchar(50)
);
delete from categoriavideos; 
/*categoria videos*/
DROP TABLE IF EXISTS videos;
create table videos(
id integer not null primary key auto_increment,
titulo varchar(50) not null, 
descricao varchar(50) not null,
src varchar(50) not null,
id_categoria integer
);
delete from videos; 
/*videos*/

/*fim videos*/


/*inicio fotos*/
DROP TABLE IF EXISTS categoriafotos;
create table categoriafotos(
id integer not null primary key auto_increment,
titulo varchar(50),
contador integer 
);
delete from categoriafotos; 
/*categoria videos*/
DROP TABLE IF EXISTS fotos;
create table fotos(
id integer not null primary key auto_increment,
id_categoria integer not null, 
titulo  varchar(50) not null, 
descricao varchar(50) not null,
src varchar(50) not null,
data_cadastro date,
contador integer not null 
);
delete from fotos; 
/*fotos*/

/*fim fotos*/


/*inicio servicos*/
DROP TABLE IF EXISTS categoriaservicos;
create table categoriaservicos(
id integer not null primary key auto_increment,
titulo varchar(50),
contador integer 
);
delete from categoriaservicos; 
/*categoria servicos*/
DROP TABLE IF EXISTS fotosservicos;
create table fotosservicos(
id integer not null primary key auto_increment,
id_categoria integer not null,
titulo varchar(50) not null, 
telefone varchar(50) not null, 
email varchar(50), 
endereco varchar(50) not null, 
site varchar(50) , 
src varchar(50) not null 
);
delete from fotosservicos; 
/*servicos*/

/*fim servicos*/


/*inicio ensaio*/
DROP TABLE IF EXISTS menu_ensaio;
create table menu_ensaio(
id integer not null primary key auto_increment,
titulo varchar(50) not null, 
src varchar(50) not null, 
srcs varchar(50) not null 
);
delete from menu_ensaio; 
/*menu ensaio*/
DROP TABLE IF EXISTS ensaio;
create table ensaio(
id integer not null primary key auto_increment,
id_menu_ensaio integer not null, 
titulo varchar(50) not null,
src varchar(50) not null,
creditos varchar(50) not null
);
delete from ensaio; 
/*ensaio*/
DROP TABLE IF EXISTS fotos_ensaio;
create table fotos_ensaio(
id integer not null primary key auto_increment,
id_ensaio integer not null,
src varchar(50) not null 
);
delete from fotos_ensaio; 
/*fotos ensaio*/

/*fim ensaio*/


/*inicio noticias*/
DROP TABLE IF EXISTS menus;
create table menus(
id integer not null primary key auto_increment,
id_menus integer not null,
titulo varchar(50) not null 
);
delete from menus; 
/*menu*/
DROP TABLE IF EXISTS paginas;create table paginas(
id integer not null primary key auto_increment,
id_menus integer not null,
titulo varchar(250) , 
subtitulo varchar(250) ,
src varchar(50) ,
conteudo blob,
fonte varchar(250),
contador integer,
inicio date,
fim date
);delete from paginas; 
/*paginas*/
DROP TABLE IF EXISTS fotospaginas;create table fotospaginas(
id integer not null primary key auto_increment,
id_paginas integer not null,
titulo varchar(250) not null, 
descricao varchar(50) not null, 
src varchar(50) 
);delete from fotospaginas; 
/*fotos paginas*/
DROP TABLE IF EXISTS tipo;
create table tipo(
id integer not null primary key auto_increment,
nome varchar(50) not null, 
quantidade integer not null,
altura integer not null,
largura integer not null
);
delete from tipo; 
/*tipo*/
DROP TABLE IF EXISTS patrocinio;
create table patrocinio(
id integer not null primary key auto_increment,
id_paginas integer ,
id_menus integer ,
id_tipo integer not null,
titulo varchar(50) not null, 
src varchar(50) , 
url varchar(50), 
popup varchar(50) 
);
delete from patrocinio; 
/*patrocinio*/
DROP TABLE IF EXISTS comentarios;
create table comentarios(
id integer not null primary key auto_increment,
id_paginas integer not null,
id_menus integer not null, 
autor varchar(50) not null,
comentario blob not null,
data_cadastro date,
exibir bool
);
delete from comentarios ;
/*comentarios*/
DROP TABLE IF EXISTS contagem;create table contagem(
id integer not null primary key auto_increment,
id_menus integer, 
ip varchar(50) not null,
data_cadastro date
);delete from contagem; 
/*contagem*/

/*fim noticias*/


/*inicio usuario*/
DROP TABLE IF EXISTS usuario;
create table usuario(
id integer not null primary key auto_increment,
nome varchar(50),
login varchar(50),
senha varchar(50)
);
delete from usuario; 
/*menu usuario*/
DROP TABLE IF EXISTS restricao;
create table restricao(
id integer not null primary key auto_increment,
id_usuario integer not null,
pagina varchar(50) not null, 
ver boolean not null, 
editar boolean not null, 
excluir boolean not null, 
salvar boolean not null, 
buscar boolean not null 
);
delete from restricao; 
/*restricao*/

