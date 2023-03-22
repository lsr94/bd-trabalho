--sugestão de sequência de criação das tabelas para não gerar conflito: central, satélite, satélite comunicação, satélite obs-met, leitura, localização,
--funcionário, pertence, consulta, usuário, antena, modem, conecta

-- Apagar todas as tabelas e recriar o schema: descomente as 2 linhas abaixo
DROP SCHEMA public CASCADE;
CREATE SCHEMA public;

CREATE TABLE CENTRAL(
  idCentral INTEGER PRIMARY KEY,
  qntdeFuncionarios INTEGER NOT NULL,
  cidade VARCHAR(30),
  tipoTrabalho VARCHAR(30) NOT NULL
);

CREATE TABLE SATELITE(
  idSatelite INTEGER PRIMARY KEY,
  idCentral INTEGER,
  nome VARCHAR(20) NOT NULL,
  dataLancamento DATE NOT NULL,
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
  data_leitura DATE,
  horario TIME,
  temperaturaC DECIMAL(5,2),
  umidade_porc DECIMAL(5,3),
  imagem bytea,
  CONSTRAINT pk_todas PRIMARY KEY (idSateliteObsM, data_leitura, horario),
  CONSTRAINT fk_idSateliteObsM FOREIGN KEY (idSateliteObsM) REFERENCES SateliteObsMet (idSatelite)
);

CREATE TABLE LOCALIZACAO(
  idSatelite INTEGER,
  data_loc DATE,
  horario TIME,
  coordX DECIMAL(6,3),
  coordY DECIMAL(6,3),
  coordZ DECIMAL(6,3),
  CONSTRAINT pk_todas2 PRIMARY KEY (idSatelite, data_loc, horario, coordX, coordY, coordZ),
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

--INSERTS:
INSERT INTO CENTRAL(idCentral, cidade, tipoTrabalho, qteFuncionarios) 
    VALUES  ('1','São Carlos','Central de Pesquisa','2'),
            ('2','Araraquara','Central de Monitoramento','4'),
            ('3','Ribeirão Preto','Central de Monitoramento','6'),
            ('4','Campinas','Central de Pesquisa','8'),
            ('5','São Paulo','Central de Pesquisa','10'),
            ('6','Rio de Janeiro','Central de Monitoramento','12'), 
            ('7','Brotas','Central de Pesquisa','14'),
            ('8','Minas Gerais','Central de Monitoramento','6');

INSERT INTO SATELITE
    VALUES  (735, 4, 'Regulus', '03/05/2021'),
            (032, 4, 'Denebola', '09/09/2021'),
            (944, 2, 'Teegarden', '03/23/2021'),
            (456, 3, 'Andromeda', '07/16/2021'),
            (259, 1, 'Altair', '12/09/2020');

INSERT INTO SATELITECOMUNICACAO
    VALUES  (735, '53oi-=3kjd?=elmç2dsf'),
            (032, 'a83mf-@au39am+a93a]='),
            (944, '409kmf^d=32çl++03e4?');

INSERT INTO SATELITEOBSMET
    VALUES  (456, 4350.6352),
            (259, 1256.3871);

INSERT INTO LEITURA
    VALUES  (456, '01/01/2023', '01:01:01', 32, 76, '0101010001'),
            (259, '07/26/2022', '22:35:41', 21, 59, '1101011001'),
            (456, '03/06/2022', '05:02:15', 32, 76, '0101010011'),
            (259, '04/07/2022', '13:51:23', 21, 59, '1111010001'),
            (456, '12/25/2023', '18:24:14', 32, 76, '0110000001');

INSERT INTO LOCALIZACAO
    VALUES  (735, '03/21/2023', '03:33:45', -22.145, -47.886, 95.645),
            (735, '02/21/2023', '23:02:31', -22.145, -47.886, 95.645),
            (944, '06/25/2023', '15:27:59', 45.862, 98.200, 87.452),
            (735, '04/07/2023', '13:26:12', -78.169, 166.258, 85.519),
            (735, '03/21/2023', '09:48:20', 26.654, -13.984, 100.000);  

INSERT INTO FUNCIONARIO(idFuncionario, nome) 
    VALUES  ('1','Alberto Braga'),
            ('2','Carlos Dollabela'),
            ('3','Elisa Fernandes'),
            ('4','Garibalda Helena'),
            ('5','Ivone Juarez'),
            ('6','Katia Lima'), 
            ('7','Maria de Nobrega'),
            ('8','Olivia de Paula');

INSERT INTO PERTENCE (idcentral, idfuncionario)
    VALUES  (3, 1),
            (1, 2),
            (2, 3),
            (4, 4),
            (3, 5),
            (1, 6),
            (1, 7),
            (4, 8);

INSERT INTO USUARIO
    VALUES  (181227, 'Jorge', '280996pastel', 5, 20),
            (107135, 'Jefferson', 'cappuccino678', 10, 50),
            (216129, 'Maria', 'pipoca120506', 2, 10),
            (253249, 'Camila', 'coxinha48547', 40, 100),
            (231177, 'Danny', 'gaming398347', 100, 200);          
        
INSERT INTO consulta
    VALUES  ('03/22/2023', '10:15:33', 4, 735),
            ('02/22/2023', '16:36:21', 4, 735),
            ('07/31/2022', '14:01:39', 1, 456),
            ('05/05/2022', '11:28:46', 2, 032),
            ('08/10/2022', '20:20:20', 3, 259);        
        
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
            
insert into CONECTA
    VALUES  (703412180, 181227),
            (185102511, 107135),
            (921482091, 253249),
            (431571430, 231177),
            (1651892321, 216129);            
            
