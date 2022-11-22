/*inicio usuario*/
drop table if exists usuario;
create table usuario(
    id int not null auto_increment primary key,
    nome varchar(50) not null,
    login varchar(50) not null,
    senha varchar(50) not null
);
/*fim usuario*/
/*inicio conteudo*/
drop table if exists menus;
create table menus(
    id int not null auto_increment primary key,
    titulo varchar(50),
    id_menus int
);
alter table menus
add constraint fk_menus_submenus
foreign key (id_menus)
references menus(id);
drop table if exists paginas;
create table paginas(
    id int not null auto_increment primary key,
    id_menus int not null,
    titulo varchar(255),
    subtitulo varchar(255),
    src varchar(255),
    conteudo blob not null,
    fonte varchar(50) not null,
    inicio timestamp not null,
    fim date
);
alter table paginas
add constraint fk_paginas_menus
foreign key (id_menus)
references menus(id);
/*conteudo fim*/
/*inicio fotos*/
drop table if exists categoriafotos;
create table categoriafotos(
    id int not null auto_increment primary key,
    titulo varchar(50)
);
drop table if exists fotos;
create table fotos(
    id int not null auto_increment primary key,
    id_categoria int not null,
    titulo varchar(50),
    descricao varchar(50),
    src  varchar(50)
);
alter table fotos
add constraint fk_fotos
foreign key (id_categoria)
references categoriafotos(id);
/*fotosfim*/
/*videosfim*/
drop table if exists categoriavideos;
create table categoriavideos(
    id int not null auto_increment primary key,
    titulo varchar(50)
);
drop table if exists videos;
create table videos(
    id int not null auto_increment primary key,
    id_categoria int not  null,
    titulo varchar(50),
    descricao varchar(50),
    src  blob
);
alter table videos
add constraint fk_videos
foreign key (id_categoria)
references categoriavideos(id);
/*videosfim*/
create table fotospaginas(
    id int not null auto_increment primary key,
    id_paginas int not null,
    titulo varchar(50),
    descricao varchar(50),
    src  varchar(50)
);
alter table fotospaginas
add constraint fk_fotospaginas
foreign key (id_paginas)
references paginas(id);
DROP TABLE IF EXISTS patrocinio;
CREATE TABLE  patrocinio(
  id integer NOT NULL AUTO_INCREMENT PRIMARY KEY,
  id_tipo integer NOT NULL,
  id_paginas integer NOT NULL,
  src varchar(50) NOT NULL,
  url varchar(50) NOT NULL
);
alter table patrocinio
add constraint fk_patrociniopaginas
foreign key (id_paginas)
references paginas(id);
alter table patrocinio
add constraint fk_patrociniotipo
foreign key (id_tipo)
references tipo(id);

    CREATE TABLE  menu_ensaio(
    id int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    titulo varchar(50) NOT NULL,
    src varchar(45),
    srcs varchar(45)
    );
    CREATE TABLE ensaio(
        id int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
        titulo varchar(50) NOT NULL,
        src varchar(50) NOT NULL,
        creditos varchar(50) NOT NULL,
        id_menu_ensaio int(11) NOT NULL
    );
    alter table ensaio
    add constraint fk_ensaio__menu_ensaio
    foreign key (id_menu_ensaio)
    references ensaio(id);

    DROP TABLE IF EXISTS fotos_ensaio;
    CREATE TABLE  fotos_ensaio(
        id int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY ,
        id_ensaio int(11) NOT NULL,
        src varchar(50) NOT NULL
    );
    alter table ensaio
    add constraint fk_ensaio_fotos_ensaio
    foreign key (id_menu_ensaio)
    references ensaio(id);
insert into usuario (nome,login,senha) values ('adm' ,'adm' ,'adm');
insert into usuario (nome,login,senha) values ('root','root','root');