CREATE TABLE antena (
	idAntena DECIMAL(3) PRIMARY KEY,
	idSatelite_Com DECIMAL(3),
	chaveDescrip DECIMAL(5) NOT NULL, --não sei qual tipo de dado colocar e deve ser not null?
	
	CONSTRAINT fk_idSatelite_Com FOREIGN KEY idSatelite_Com REFERENCES SateliteComunicacao
);

CREATE TABLE modem (
	idModem DECIMAL(3) PRIMARY KEY,
	idAntena DECIMAL(3),
	nomeRede VARCHAR(30) NOT NULL,
	senhaRede VARCHAR(15) NOT NULL,
	
	CONSTRAINT fk_idAntena FOREIGN KEY idAntena REFERENCES antena
);