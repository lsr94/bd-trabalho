--sugestão de sequência de criação das tabelas para não gerar conflito: central, satélite, satélite comunicação, satélite obs-met, leitura, localização,
--funcionário, pertence, consulta, usuário, antena, modem, conecta

-- Apagar todas as tabelas e recriar o schema: descomente as 2 linhas abaixo
DROP SCHEMA public CASCADE;
CREATE SCHEMA public;

CREATE TABLE CENTRAL(
  idCentral INTEGER PRIMARY KEY,
  cidade VARCHAR(30),
  tipoTrabalho VARCHAR(30) NOT NULL,
  qntdeFuncionarios INTEGER NOT NULL
  
);

CREATE TABLE SATELITE(
  idSatelite INTEGER PRIMARY KEY,
  idCentral INTEGER,
  nome VARCHAR(20) NOT NULL,
  dataLancamento TIMESTAMP NOT NULL,
  CONSTRAINT fk_idCentral FOREIGN KEY (idCentral) REFERENCES CENTRAL (idCentral)
);

CREATE TABLE SATELITECOMUNICACAO(
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
  data_leitura TIMESTAMP,
  temperaturaC DECIMAL(5,2),
  umidade_porc DECIMAL(5,3),
  imagem bytea,
  CONSTRAINT pk_todas PRIMARY KEY (idSateliteObsM, data_leitura),
  CONSTRAINT fk_idSateliteObsM FOREIGN KEY (idSateliteObsM) REFERENCES SateliteObsMet (idSatelite)
);

CREATE TABLE LOCALIZACAO(
  idSatelite INTEGER,
  data_loc TIMESTAMP,
  coordX DECIMAL(6,3),
  coordY DECIMAL(6,3),
  coordZ DECIMAL(6,3),
  CONSTRAINT pk_todas2 PRIMARY KEY (idSatelite, data_loc, coordX, coordY, coordZ),
  CONSTRAINT fk_idSatelite FOREIGN KEY (idSatelite) REFERENCES SATELITE (idSatelite)
);

CREATE TABLE FUNCIONARIO(
  idFuncionario INTEGER PRIMARY KEY,
  nome VARCHAR(70) NOT NULL
);

CREATE TABLE PERTENCE(
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
  data_consulta TIMESTAMP NOT NULL,
  idFuncionario INTEGER NOT NULL,
  idSatelite INTEGER NOT NULL,
  CONSTRAINT pk_todas4 PRIMARY KEY (data_consulta, idFuncionario, idSatelite),
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

--INSERTS:
INSERT INTO CENTRAL
    VALUES  (1, 'São Carlos', 'Central de Pesquisa', 3),
            (2, 'São Paulo', 'Central de Monitoramento', 1),
            (3, 'Rio de Janeiro', 'Central de Monitoramento', 1),
            (4, 'Campinas', 'Central de Pesquisa', 1),
            (5, 'Araraquara', 'Central de Pesquisa', 0),
            (6, 'Ribeirão Preto', 'Central de Monitoramento', 0), 
            (7, 'Brotas', 'Central de Pesquisa', 0),
            (8, 'Minas Gerais', 'Central de Monitoramento', 0);

INSERT INTO SATELITE
    VALUES  (735, 4, 'Regulus', '03/05/2021'),
            (032, 4, 'Denebola', '09/09/2021'),
            (944, 2, 'Teegarden', '03/23/2021'),
            (456, 3, 'Andromeda', '07/16/2021'),
            (259, 1, 'Altair', '12/09/2020'),
	    (897, 8, 'Capella', '01/05/2005'),
	    (999, 7, 'Deneb', '04/09/2010');

INSERT INTO SATELITECOMUNICACAO
    VALUES  (735, '53oi-=3kjd?=elmç2dsf'),
            (032, 'a83mf-@au39am+a93a]='),
            (944, '409kmf^d=32çl++03e4?'),
			      (999, '89akm-=4ghj?que++ops');

INSERT INTO SATELITEOBSMET
    VALUES  (456, 4350.6352),
            (259, 1256.3871),
	    (897, 899.711);

INSERT INTO LEITURA
    VALUES  (456, '2023-01-01 01:01:01-03', 032.56, 76.555, '0101010001'),
            (259, '2022-07-03 22:35:41-03', 021.11, 59.999, '1101011001'),
            (456, '2022-03-06 05:02:15-03', 032.56, 76.555, '0101010011'),
            (259, '2022-04-07 13:51:23-03', 021.11, 59.999, '1111010001'),
            (456, '2023-12-25 18:24:14-03', 032.56, 76.555, '0110000001'),
            (897, '2005-01-06 13:10:17-03', 029.44, 62.000, '0000011110'),
            (897, '2006-01-06 09:58:27-03', 029.44, 62.000, '0000011111'),
	    (456, '2023-03-23 15:15:02-03', 032.56, 76.555, '0101010000'),
	    (456, '2023-03-22 18:18:18-03', 032.56, 76.555, '0101010010'),
	    (897, '2023-03-23 14:15:02-03', 035.56, 76.555, '0101010000');

INSERT INTO LOCALIZACAO
    VALUES  (735, '2023-03-21 03:33:45-03', -22.145, -47.886, 95.645),
            (735, '2023-02-21 23:02:31-03', -22.145, -47.886, 95.645),
            (944, '2023-06-25 15:27:59-03', 45.862, 98.200, 87.452),
            (735, '2023-04-07 13:26:12-03', -78.169, 166.258, 85.519),
            (735, '2023-03-21 09:48:20-03', 26.654, -13.984, 100.000),
            (456, '2023-03-20 22:05:28-03', 30.588, 35.895, 59.666);

INSERT INTO FUNCIONARIO 
    VALUES  ('1', 'Alberto Braga'),
            ('2', 'Carlos Dollabela'),
            ('3', 'Elisa Fernandes'),
            ('4', 'Garibalda Helena'),
            ('5', 'Ivone Juarez'),
            ('6', 'Katia Lima'), 
            ('7', 'Maria de Nobrega'),
            ('8', 'Olivia de Paula');

INSERT INTO PERTENCE
    VALUES  (3, 1),
            (1, 2),
            (2, 3),
            (4, 4),
            (3, 5),
            (1, 6),
            (1, 7),
            (4, 8);

INSERT INTO USUARIO
    VALUES  (181227, 'Jorge', '280996pastel', 005.00, 020.00),
            (107135, 'Jefferson', 'cappuccino678', 010.55, 050.89),
            (216129, 'Maria', 'pipoca120506', 002.11, 010.44),
            (253249, 'Camila', 'coxinha48547', 040.48, 100.88),
            (231177, 'Danny', 'gaming398347', 100.76, 200.00);          
        
INSERT INTO CONSULTA
    VALUES  ('2023-03-22 10:15:33-03', 4, 735),
            ('2023-02-22 16:36:21-03', 4, 735),
            ('2022-07-31 14:01:39-03', 1, 456),
            ('2022-05-05 11:28:46-03', 2, 032),
            ('2022-08-10 20:20:20-03', 3, 259),    
	    ('2009-09-09 18:18:25-03', 3, 897),
	    ('2012-01-05 07:05:14-03', 7, 999);
        
INSERT INTO ANTENA
    VALUES  (8731, 735, '53oi-=3kjd?=elmç2dsf'),
            (2516, 032, 'a83mf-@au39am+a93a]='),
            (5416, 944, '409kmf^d=32çl++03e4?'),
            (9972, 944, '409kmf^d=32çl++03e4?'),
            (1042, 735, '53oi-=3kjd?=elmç2dsf');          
 
INSERT INTO MODEM
    VALUES  (431571430, 8731, 'NaveEspacial', 'alien25'),
            (185102511, 2516, 'Insonia', 'dramim50mg'),
            (1651892321, 5416, 'FamiliaDinossauro', 'senha123'),
            (703412180, 5416, 'FamiliaAddams', 'JennaOrtega<3'),
            (921482091, 9972, 'wifi', 'coxinha08081988'),
            (687823415, 1042, 'NETVIRTUA#068', '1A2B3C4D5E');          
            
INSERT INTO CONECTA
    VALUES  (703412180, 181227),
            (185102511, 107135),
            (921482091, 253249),
            (431571430, 231177),
            (1651892321, 216129); 
