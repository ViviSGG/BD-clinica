CREATE DATABASE `clinica`; -- DDL 
use clinica;
drop database clinica;  -- DDL 

CREATE TABLE `ambulatorios` ( -- DDL 
`nroa` INT NOT NULL AUTO_INCREMENT,
`andar` NUMERIC(3) NOT NULL, 
`capacidade` SMALLINT,
PRIMARY KEY(`nroa`)
 );
 
SELECT * FROM ambulatorios;
drop table ambulatorios; -- DDL 
 
CREATE TABLE `medicos` ( -- DDL 
`codm` INT NOT NULL AUTO_INCREMENT,
`nome` VARCHAR(40) NOT NULL,
`idade` SMALLINT NOT NULL,
`especialidade` CHAR(20),
`cpf` NUMERIC(11) UNIQUE,
`cidade`VARCHAR(30),
`nroa` INT,
FOREIGN KEY (nroa) REFERENCES ambulatorios (nroa), 
PRIMARY KEY(`codm`) 
);

SELECT * FROM medicos;
drop table medicos; -- DDL 

CREATE TABLE `pacientes` ( -- DDL 
`codp` INT NOT NULL AUTO_INCREMENT,
`nome` VARCHAR(40) NOT NULL,
`idade` SMALLINT NOT NULL,
`cidade` CHAR(30),
`cpf` NUMERIC(11) UNIQUE,
`doenca` VARCHAR(40) NOT NULL,
PRIMARY KEY(`codp`)
);

SELECT * FROM pacientes;
drop table pacientes; -- DDL 

CREATE TABLE `funcionarios` ( -- DDL 
`codf` INT NOT NULL AUTO_INCREMENT,
`nome` VARCHAR(40) NOT NULL,
`idade` SMALLINT,
`cidade` VARCHAR(30),
`salario` NUMERIC(10),
`cargo` VARCHAR(20),
`cpf` NUMERIC(11) UNIQUE,
PRIMARY KEY(`codf`)
);

SELECT * FROM funcionarios;
DROP TABLE funcionarios; -- DDL 

CREATE TABLE `consultas` ( -- DDL 
`codm` INT,
`codp` INT,
`data_consulta` DATE,
`hora` TIME,
FOREIGN KEY (codm) REFERENCES medicos (codm), 
FOREIGN KEY (codp) REFERENCES pacientes (codp)
);

SELECT * FROM consultas;
DROP TABLE consultas; -- DDL 

-- Crie a coluna nroa (int) na tabela Funcionarios 

ALTER TABLE funcionarios -- DDL 
ADD COLUMN nroa INT,
ADD CONSTRAINT `nroa` 
FOREIGN KEY (nroa) REFERENCES ambulatorios (nroa);

-- Crie os seguintes índices:  
-- Medicos: CPF (único)
-- Pacientes: doenca

CREATE INDEX indice_cpf ON medicos (cpf); -- DDL
CREATE INDEX indice_doenca ON pacientes (doenca); -- DDL

-- Remover o índice doenca em Pacientes

DROP INDEX indice_doenca ON pacientes; -- DDL

-- Remover as colunas cargo e nroa da tabela de Funcionarios

ALTER TABLE funcionarios DROP COLUMN cargo; -- DDL
ALTER TABLE funcionarios DROP COLUMN nroa; -- DDL

-- ------------------------------------------
-- POPULAR AS TABELAS
-- ------------------------------------------

INSERT INTO ambulatorios (andar, capacidade) VALUES -- DML 
("1", "30"),
("1", "50"),
("2", "40"),
("2", "25"),
("2", "55");

INSERT INTO medicos (nome, idade, especialidade, cpf, cidade, nroa) VALUES -- DML 
("Joao", "40", "ortopedia", "10000100000", "Florianopolis", "1"),
("Maria", "42", "traumatologia", "10000110000", "Blumenau", "2"),
("Pedro", "51", "pediatria", "11000100000", "São José", "2"),
("Carlos", "28", "ortopedia", "11000110000", "Joinviller", "4"),
("Marcia", "33", "neurologia", "11000111000", "Biguacu", "3");

INSERT INTO pacientes (nome, idade, cidade, cpf, doenca) VALUES -- DML 
("Ana", "20", "Florianopolis", "20000200000", "gripe"),
("Paulo", "24", "Palhoca", "20000220000", "fratura"),
("Lucia", "30", "Biguacu", "22000200000", "tendinite"),
("Carlos", "28", "Joinville", "11000110000", "sarampo");

INSERT INTO consultas (codm, codp, data_consulta, hora) VALUES -- DML 
("1", "1", '2006-06-12', "14:00"),
("1", "4", '2006-06-13', "10:00"),
("2", "1", '2006-06-13', "9:00"),
("2", "2", '2006-06-13', "11:00"),
("2", "3", '2006-06-14', "14:00"),
("2", "4", '2006-06-14', "17:00"),
("3", "1", '2006-06-19', "18:00"),
("3", "3", '2006-06-12', "10:00"),
("3", "4", '2006-06-19', "13:00"),
("4", "4", '2006-06-20', "13:00"),
("4", "4", '2006-06-22', "19:30");

INSERT INTO funcionarios (nome, idade, cidade, salario, cpf) VALUES -- DML 
("Rita", "32", "Sao Jose", "1200", "20000100000"),
("Maria", "55", "Palhoca", "1220", "30000110000"),
("Caio", "45", "Florianopolis", "1100", "41000100000"),
("Carlos", "44", "Florianopolis", "1200", "51000110000"),
("Paula", "33", "Florianopolis", "2500", "61000111000");

-- ------------------------------------------
-- ATUALIZAÇÕES
-- ------------------------------------------

-- O paciente Paulo mudou-se para Ilhota

UPDATE pacientes SET cidade = "Ilhota" WHERE codp = 2;

-- A consulta do médico 1 com o paciente 4 passou para às 12:00 horas do dia 4 de Julho de 2006

UPDATE consultas SET hora = "12:00", data_consulta = '2006-07-04' WHERE codm = 1 AND codp = 4;

-- A paciente Ana fez aniversário e sua doença agora é cancer

UPDATE pacientes SET doenca = "cancer" WHERE codp = 1;

-- A consulta do médico Pedro (codf = 3) com o paciente Carlos (codf = 4) 
-- passou para uma hora e meia depois

UPDATE consultas SET hora = "14:30" WHERE codm = 3 AND codp = 4;

-- O funcionário Carlos (codf = 4) deixou a clínica

DELETE FROM funcionarios WHERE codf = 4;

-- As consultas marcadas após as 19 horas foram canceladas

DELETE FROM consultas WHERE hora > "19:00";
