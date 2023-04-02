CREATE DATABASE `clinica`;
use clinica;
drop database clinica;

CREATE TABLE `ambulatorios` (
`nroa` INT NOT NULL,
`andar` NUMERIC(3) NOT NULL, 
`capacidade` SMALLINT,
PRIMARY KEY(`nroa`)
 );
 
 drop table ambulatorios;
 
CREATE TABLE `medicos` (
`codm` INT NOT NULL auto_increment,
`nome` VARCHAR(40) NOT NULL,
`idade` SMALLINT NOT NULL,
`especialidade` CHAR(20),
`cpf` NUMERIC(11) UNIQUE,
`cidade`VARCHAR(30),
`nroa` INT,
FOREIGN KEY (nroa) REFERENCES ambulatorios (nroa), 
PRIMARY KEY(`codm`) 
);

drop table medicos;

CREATE TABLE `pacientes`(
`codp` INT NOT NULL auto_increment,
`nome` VARCHAR(40) NOT NULL,
`idade` SMALLINT NOT NULL,
`cidade` CHAR(30),
`cpf` NUMERIC(11) UNIQUE,
`doenca` VARCHAR(40) NOT NULL,
PRIMARY KEY(`codp`)
);

drop table pacientes;

CREATE TABLE `funcionarios`(
`codf` INT NOT NULL,
`nome` VARCHAR(40) NOT NULL,
`idade` SMALLINT,
`cpf` NUMERIC(11) UNIQUE,
`cidade` VARCHAR(30),
`salario` NUMERIC(10),
`cargo` VARCHAR(20),
PRIMARY KEY(`codf`)
);

DROP TABLE funcionarios;

CREATE TABLE `consultas`(
`codm` INT NOT NULL auto_increment,
`codp` INT,
FOREIGN KEY (codm) REFERENCES medicos (codm), 
FOREIGN KEY (codp) REFERENCES pacientes (codp)
);

DROP TABLE consultas;

ALTER TABLE funcionarios
ADD COLUMN nroa INT,
ADD CONSTRAINT `nroa` 
FOREIGN KEY (nroa) REFERENCES ambulatorios (nroa);

INSERT INTO ambulatorios (andar, capacidade)
	value 
    ("1", "30"),
    ("1", "50"),
    ("2", "40"),
    ("2", "25"),
    ("2", "55");

INSERT INTO medicos (nome, idade, especialidade, cpf, cidade, nroa) VALUES

    ("Joao", "40", "ortopedia", "10000100000", "Florianopolis", "1"),
    ("Maria", "42", "traumatologia", "10000110000", "Blumenau", "2"),
    ("Pedro", "51", "pediatria", "11000100000", "São José", "2"),
    ("Carlos", "28", "ortopedia", "11000110000", "Joinviller", "4"),
    ("Marcia", "33", "neurologia", "11000111000", "Biguacu", "3");

INSERT INTO pacienteS (nome, idade, cidade, cpf, doenca) VALUES
	
    ("Ana", "20", "Florianopolis", "20000200000", "gripe"),
	("Paulo", "24", "Palhoca", "20000220000", "fratura"),
    ("Lucia", "30", "Biguacu", "22000200000", "tendinite"),
    ("Carlos", "28", "Joinville", "11000110000", "sarampo");

INSERT INTO consultas (codm, codp) VALUES

    ("1", "1"),
    ("1", "4"),
    ("2", "1"),
	("2", "2"),
	("2", "3"),
	("2", "4"),
	("3", "1"),
	("3", "3"),
	("3", "4"),
	("4", "4"),
	("4", "4");

INSERT INTO funcionarios (nome, idade, cpf, cidade, salario) VALUES

    ("Rita", "32", "20000100000", "Sao Jose", "1200",),
	("Maria", "55", "30000110000", "Palhoca", "1220"),
	("Caio", "45", "41000100000", "Florianopolis", "1100"),
	("Carlos", "44", "51000110000", "Florianopolis", "1200"),
	("Paula", "33", "61000111000", "Florianopolis", "2500");
