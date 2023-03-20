--sugestão de sequência de criação das tabelas para não gerar conflito: central, satélite, satélite comunicação, satélite obs-met, leitura, localização,
--funcionário, pertence, consulta, usuário, antena, modem, conecta

CREATE TABLE antena (
	idAntena INTEGER PRIMARY KEY,
	idSatelite_Com INTEGER,
	chaveDescrip CHAR(20) NOT NULL, --não sei qual tipo de dado colocar e deve ser not null?
	
	CONSTRAINT fk_idSatelite_Com FOREIGN KEY idSatelite_Com REFERENCES SateliteComunicacao
);

CREATE TABLE modem (
	idModem INTEGER PRIMARY KEY,
	idAntena INTEGER,
	nomeRede VARCHAR(30) NOT NULL,
	senhaRede VARCHAR(15) NOT NULL,
	
	CONSTRAINT fk_idAntena FOREIGN KEY idAntena REFERENCES antena
);

create table USUARIO(
  idUsuario INTEGER PRIMARY KEY
)

CREATE TABLE CONECTA(
  idModem INTEGER,
  idUsuario INTEGER,
  CONSTRAINT pk_conecta PRIMARY KEY (idModem, idUsuario),
  CONSTRAINT fk_idModem FOREIGN KEY (idModem) REFERENCES	MODEM (idModem),
  CONSTRAINT fk_idUsuario FOREIGN KEY (idUsuario) references USUARIO (idUsuario)
)
create table SATELITEOBSMET(
  idSatelite INTEGER PRIMARY KEY
)
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
)
