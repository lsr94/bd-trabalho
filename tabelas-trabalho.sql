--sugestão de sequência de criação das tabelas para não gerar conflito: central, satélite, satélite comunicação, satélite obs-met, leitura, localização,
--funcionário, pertence, consulta, usuário, antena, modem, conecta

-- Apagar todas as tabelas e recriar o schema: descomente as 2 linahs abaixo
DROP SCHEMA public CASCADE;
CREATE SCHEMA public;

CREATE TABLE SATELITE(
  idSatelite INTEGER PRIMARY KEY
  -- falta completar!
);

CREATE TABLE SATELITECOMUNICACAO (
  idSatelite INTEGER PRIMARY KEY,
  chaveCripto CHAR(20) NOT NULL,
  CONSTRAINT fk_idSateliteC FOREIGN KEY (idSatelite) REFERENCES SATELITE (idSatelite)
);

Create table SATELITEOBSMET(
  idSatelite INTEGER PRIMARY KEY,
  raioLeituraKm DECIMAL(20,5) not null,
  CONSTRAINT fk_idSateliteO FOREIGN KEY (idSatelite) REFERENCES SATELITE (idSatelite)
);

create table LEITURA(
  idSateliteObsM iNTEGER,
  data_leitura DATE,
  horario TIME,
  temperaturaC DECIMAL(5,5),
  umidade_porc DECIMAL(3,5),
  imagem bytea,
  CONSTRAINT fk_idSateliteObsM FOREIGN KEY (idSateliteObsM)
  	REFERENCES	SateliteObsMet (idSatelite),
  PRIMARY KEY (idSateliteObsM, data_leitura, horario)
);

create table USUARIO(
  idUsuario INTEGER PRIMARY KEY
);
  
CREATE TABLE ANTENA (
	idAntena INTEGER PRIMARY KEY,
	idSatelite_Com INTEGER not NULL,
	chaveDescrip CHAR(20) NOT NULL, -- vamos deixar como not null apenas as chaves candidatas?
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
  CONSTRAINT fk_idModem FOREIGN KEY (idModem) REFERENCES	MODEM (idModem),
  CONSTRAINT fk_idUsuario FOREIGN KEY (idUsuario) references USUARIO (idUsuario)
);