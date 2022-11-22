-- ----------------------------------------------------------------------
-- MySQL Migration Toolkit
-- SQL Create Script
-- ----------------------------------------------------------------------

SET FOREIGN_KEY_CHECKS = 0;

CREATE DATABASE IF NOT EXISTS `toledonews`
  CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `toledonews`;
-- -------------------------------------
-- Tables

DROP TABLE IF EXISTS `toledonews`.`agenda`;
CREATE TABLE `toledonews`.`agenda` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `titulo` VARCHAR(50) NOT NULL,
  `evento` VARCHAR(50) NOT NULL,
  `src` VARCHAR(50) NULL,
  `dataevento` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id`)
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `toledonews`.`banners`;
CREATE TABLE `toledonews`.`banners` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `id_categoria` INT(11) NOT NULL,
  `titulo` VARCHAR(50) NULL,
  `descricao` VARCHAR(50) NULL,
  `src` VARCHAR(50) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_banners` (`id_categoria`)
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `toledonews`.`categoria_shopping`;
CREATE TABLE `toledonews`.`categoria_shopping` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `titulo` VARCHAR(50) NOT NULL,
  `src` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id`)
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `toledonews`.`categoriabanners`;
CREATE TABLE `toledonews`.`categoriabanners` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `titulo` VARCHAR(50) NULL,
  PRIMARY KEY (`id`)
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `toledonews`.`categoriafotos`;
CREATE TABLE `toledonews`.`categoriafotos` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `titulo` VARCHAR(50) NULL,
  PRIMARY KEY (`id`)
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `toledonews`.`categoriapatrocinadores`;
CREATE TABLE `toledonews`.`categoriapatrocinadores` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `titulo` VARCHAR(50) NULL,
  PRIMARY KEY (`id`)
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `toledonews`.`categoriavideos`;
CREATE TABLE `toledonews`.`categoriavideos` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `titulo` VARCHAR(50) NULL,
  PRIMARY KEY (`id`)
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `toledonews`.`comentarios`;
CREATE TABLE `toledonews`.`comentarios` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `titulo` VARCHAR(50) NULL,
  `descricao` BLOB NULL,
  `data_cadastro` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `exibir` TINYINT(1) NULL,
  PRIMARY KEY (`id`)
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `toledonews`.`contagem`;
CREATE TABLE `toledonews`.`contagem` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `ip` VARCHAR(50) NULL,
  `data_cadastro` DATE NULL,
  PRIMARY KEY (`id`)
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `toledonews`.`contato`;
CREATE TABLE `toledonews`.`contato` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(50) NULL,
  `email` VARCHAR(50) NULL,
  `ativo` TINYINT(1) NULL,
  `data_cadastro` DATETIME NULL,
  PRIMARY KEY (`id`)
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `toledonews`.`dadossorteio`;
CREATE TABLE `toledonews`.`dadossorteio` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `titulo` VARCHAR(50) NOT NULL,
  `data_inicio` DATE NOT NULL,
  `data_Fim` DATE NULL,
  `id_sorteado` INT(11) NOT NULL,
  PRIMARY KEY (`id`)
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `toledonews`.`ensaio`;
CREATE TABLE `toledonews`.`ensaio` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `titulo` VARCHAR(50) NOT NULL,
  `src` VARCHAR(50) NOT NULL,
  `creditos` VARCHAR(50) NOT NULL,
  `id_menu_ensaio` INT(11) NOT NULL,
  PRIMARY KEY (`id`)
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `toledonews`.`estados`;
CREATE TABLE `toledonews`.`estados` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(50) NULL,
  `sigla` CHAR(2) NULL,
  PRIMARY KEY (`id`)
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `toledonews`.`fotos`;
CREATE TABLE `toledonews`.`fotos` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `id_categoria` INT(11) NOT NULL,
  `titulo` VARCHAR(50) NULL,
  `descricao` VARCHAR(50) NULL,
  `src` VARCHAR(50) NULL,
  `contador` INT(10) unsigned NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_fotos` (`id_categoria`)
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `toledonews`.`fotos_ensaio`;
CREATE TABLE `toledonews`.`fotos_ensaio` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `id_ensaio` INT(11) NOT NULL,
  `src` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id`)
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `toledonews`.`fotospaginas`;
CREATE TABLE `toledonews`.`fotospaginas` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `id_paginas` INT(11) NOT NULL,
  `titulo` VARCHAR(50) NULL,
  `descricao` VARCHAR(50) NULL,
  `src` VARCHAR(50) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_fotospaginas` (`id_paginas`)
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `toledonews`.`menu_ensaio`;
CREATE TABLE `toledonews`.`menu_ensaio` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `titulo` VARCHAR(50) NOT NULL,
  `src` VARCHAR(45) NULL,
  `srcs` VARCHAR(45) NULL,
  PRIMARY KEY (`id`)
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `toledonews`.`menus`;
CREATE TABLE `toledonews`.`menus` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `titulo` VARCHAR(50) NULL,
  `id_menus` INT(11) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_menus_submenus` (`id_menus`)
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `toledonews`.`menus_paginas`;
CREATE TABLE `toledonews`.`menus_paginas` (
  `id_paginas` INT(11) NOT NULL,
  `id_menus` INT(11) NOT NULL,
  UNIQUE INDEX `fk_menus_paginas_menu` (`id_menus`, `id_paginas`),
  INDEX `fk_menus_paginas_paginas` (`id_paginas`)
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `toledonews`.`paginas`;
CREATE TABLE `toledonews`.`paginas` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `titulo` VARCHAR(255) NULL,
  `src` VARCHAR(255) NULL,
  `conteudo` BLOB NULL,
  `inicio` DATETIME NOT NULL,
  `fim` DATE NULL,
  `id_menus` INT(10) unsigned NOT NULL,
  `fonte` VARCHAR(50) NULL,
  `subtitulo` VARCHAR(255) NULL,
  `slideshow` TINYINT(1) NULL,
  `contador` INT(10) unsigned NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_paginas_menus` (`id_menus`)
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `toledonews`.`patrocinadores`;
CREATE TABLE `toledonews`.`patrocinadores` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `id_categoria` INT(11) NOT NULL,
  `titulo` VARCHAR(50) NULL,
  `descricao` VARCHAR(50) NULL,
  `src` VARCHAR(50) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_patrocinadores` (`id_categoria`)
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `toledonews`.`patrocinio`;
CREATE TABLE `toledonews`.`patrocinio` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `id_tipo` INT(11) NOT NULL,
  `id_paginas` INT(11) NULL,
  `src` VARCHAR(50) NULL,
  `url` VARCHAR(50) NULL,
  `titulo` VARCHAR(50) NOT NULL,
  `id_menus` INT(10) NULL,
  PRIMARY KEY (`id`),
  INDEX `id_tipo` (`id_tipo`),
  INDEX `id_paginas` (`id_paginas`),
  INDEX `fk_patrociniomenus` (`id_menus`)
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `toledonews`.`restricao`;
CREATE TABLE `toledonews`.`restricao` (
  `id` INT(10) unsigned NOT NULL AUTO_INCREMENT,
  `pagina` VARCHAR(250) NOT NULL,
  `editar` TINYINT(1) NOT NULL,
  `excluir` TINYINT(1) NOT NULL,
  `salvar` TINYINT(1) NOT NULL,
  `buscar` TINYINT(1) NOT NULL,
  `id_usuario` INT(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `toledonews`.`sorteio`;
CREATE TABLE `toledonews`.`sorteio` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(50) NOT NULL,
  `email` VARCHAR(50) NOT NULL,
  `telefone` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id`)
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `toledonews`.`tipo`;
CREATE TABLE `toledonews`.`tipo` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `quantidade` INT(11) NOT NULL,
  `largura` INT(11) NOT NULL,
  `altura` INT(11) NOT NULL,
  `nome` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id`)
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `toledonews`.`usuario`;
CREATE TABLE `toledonews`.`usuario` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(50) NOT NULL,
  `login` VARCHAR(50) NOT NULL,
  `senha` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id`)
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `toledonews`.`videos`;
CREATE TABLE `toledonews`.`videos` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `id_categoria` INT(11) NOT NULL,
  `titulo` VARCHAR(50) NULL,
  `descricao` VARCHAR(50) NULL,
  `src` VARCHAR(50) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_videos` (`id_categoria`)
)
ENGINE = INNODB;



SET FOREIGN_KEY_CHECKS = 1;

-- ----------------------------------------------------------------------
-- EOF




drop table if exists categoriapatrocinadores;
create table categoriapatrocinadores(
	id int not null auto_increment primary key,
	titulo varchar(50)
);
drop table if exists patrocinadores;
create table patrocinadores(
	id int not null auto_increment primary key,
	id_categoria int not null,
	titulo varchar(50),
	descricao varchar(50),
	src  varchar(50)
);
alter table patrocinadores
add constraint fk_patrocinadores
foreign key (id_categoria)
references categoriapatrocinadores(id);