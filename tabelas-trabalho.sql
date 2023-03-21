--sugestão de sequência de criação das tabelas para não gerar conflito: central, satélite, satélite comunicação, satélite obs-met, leitura, localização,
--funcionário, pertence, consulta, usuário, antena, modem, conecta

-- Apagar todas as tabelas e recriar o schema: descomente as 2 linhas abaixo
DROP SCHEMA public CASCADE;
CREATE SCHEMA public;

CREATE TABLE CENTRAL (
  idCentral INTEGER PRIMARY KEY,
  qntdeFuncionarios INTEGER NOT NULL,
  cidade VARCHAR(30),
  tipoTrabalho VARCHAR(15) NOT NULL
);

CREATE TABLE SATELITE(
  idSatelite INTEGER PRIMARY KEY,
  idCentral INTEGER,
  nome VARCHAR(20) NOT NULL,
  dataLancamento DATE NOT NULL,
  CONSTRAINT fk_idCentral FOREIGN KEY (idCentral) REFERENCES CENTRAL (idCentral)
);

CREATE TABLE SATELITECOMUNICACAO (
  idSatelite INTEGER PRIMARY KEY,
  chaveCripto CHAR(20) NOT NULL,
  CONSTRAINT fk_idSateliteC FOREIGN KEY (idSatelite) REFERENCES SATELITE (idSatelite)
);

CREATE TABLE SATELITEOBSMET(
  idSatelite INTEGER PRIMARY KEY,
  raioLeituraKm DECIMAL(20,5) NOT NULL,
  CONSTRAINT fk_idSateliteO FOREIGN KEY (idSatelite) REFERENCES SATELITE (idSatelite)
);

CREATE TABLE LEITURA(
  idSateliteObsM INTEGER,
  data_leitura DATE,
  horario TIME,
  temperaturaC DECIMAL(5,5),
  umidade_porc DECIMAL(5,3),
  imagem bytea,
  CONSTRAINT pk_todas PRIMARY KEY (idSateliteObsM, data_leitura, horario),
  CONSTRAINT fk_idSateliteObsM FOREIGN KEY (idSateliteObsM) REFERENCES SateliteObsMet (idSatelite)
);

CREATE TABLE LOCALIZACAO(
  idSatelite INTEGER,
  data_loc DATE,
  horario TIME,
  coordX DECIMAL(6,2),
  coordY DECIMAL(6,2),
  coordZ DECIMAL(6,2),
  CONSTRAINT pk_todas2 PRIMARY KEY (idSatelite, data_loc, horario, coordX, coordY, coordZ),
  CONSTRAINT fk_idSatelite FOREIGN KEY (idSatelite) REFERENCES SATELITE (idSatelite)
);

CREATE TABLE FUNCIONARIO (
  idFuncionario INTEGER PRIMARY KEY,
  nome VARCHAR(70) NOT NULL
);

CREATE TABLE PERTENCE (
  idCentral INTEGER NOT NULL,
  idFuncionario INTEGER NOT NULL,
  CONSTRAINT pk_todas3 PRIMARY KEY (idCentral, idFuncionario),
  CONSTRAINT fk_idCentral FOREIGN KEY (idCentral) REFERENCES CENTRAL (idCentral),
  CONSTRAINT fk_idFuncionario FOREIGN KEY (idFuncionario) REFERENCES FUNCIONARIO (idFuncionario)
);

CREATE TABLE USUARIO (
  idUsuario INTEGER PRIMARY KEY,
  nome VARCHAR(70) NOT NULL,
  senha VARCHAR(15) NOT NULL,
  velocidadeUpLink DECIMAL (5,2) NOT NULL,
  velocidadeDownLink DECIMAL (5,2) NOT NULL
);

CREATE TABLE CONSULTA (
  data DATE NOT NULL,
  horario TIME NOT NULL,
  idFuncionario INTEGER NOT NULL,
  idSatelite INTEGER NOT NULL,
  CONSTRAINT pk_todas4 PRIMARY KEY (data, horario, idFuncionario, idSatelite),
  CONSTRAINT fk_idFuncionario FOREIGN KEY (idFuncionario) REFERENCES FUNCIONARIO (idFuncionario),
  CONSTRAINT fk_idSatelite FOREIGN KEY (idSatelite) REFERENCES SATELITE (idSatelite)
);
  
CREATE TABLE ANTENA (
  idAntena INTEGER PRIMARY KEY,
  idSatelite_Com INTEGER NOT NULL,
  chaveDescrip CHAR(20) NOT NULL, 
  CONSTRAINT fk_idSatelite_Com FOREIGN KEY (idSatelite_Com) REFERENCES SATELITECOMUNICACAO (idSatelite)
);

CREATE TABLE MODEM (
  idModem INTEGER PRIMARY KEY,
  idAntena INTEGER NOT NULL,
  nomeRede VARCHAR(30) NOT NULL,
  senhaRede VARCHAR(15) NOT NULL,
  CONSTRAINT fk_idAntena FOREIGN KEY (idAntena) REFERENCES ANTENA (idAntena)
);

CREATE TABLE CONECTA(
  idModem INTEGER NOT NULL,
  idUsuario INTEGER NOT NULL,
  CONSTRAINT pk_conecta PRIMARY KEY (idModem, idUsuario),
  CONSTRAINT fk_idModem FOREIGN KEY (idModem) REFERENCES MODEM (idModem),
  CONSTRAINT fk_idUsuario FOREIGN KEY (idUsuario) references USUARIO (idUsuario)
);
