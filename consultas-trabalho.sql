--///////////////////////////////////////////////////////////////////////////
-- CONSULTA SIMPLES
--///////////////////////////////////////////////////////////////////////////
-- Solicitadas pelos clientes --
-- 1. Encontre todos os satélites que estão conectados a uma central ‘x’. Vamos considerar que a central 'x' está localizada na cidade de São Carlos.
SELECT * FROM CENTRAL WHERE cidade = 'São Carlos';

-- 2. Encontre todas as centrais que realizam ‘pesquisa’.
SELECT * FROM CENTRAL WHERE tipotrabalho = 'Central de Pesquisa';

-- 3. Encontre todos os satélites lançados antes de 2010.
SELECT * FROM SATELITE WHERE datalancamento < '01-01-2010';

-- 4. Encontre todas as chaves de criptografia dos satélites de ‘comunicação’.
SELECT chaveCripto FROM SATELITECOMUNICACAO;

-- 5. Encontre todos os funcionários da central ‘x’. Vamos considerar que a central 'x' está localizada na cidade de São Carlos.
SELECT f.* FROM funcionario f, central ce, pertence pe
where f.idfuncionario = pe.idfuncionario AND 
	pe.idcentral = ce.idcentral AND 
    ce.cidade = 'São Carlos';
    
-- Criadas pelo grupo --

-- 6. 

-- 7.

-- 8.

-- 9.

-- 10.

--///////////////////////////////////////////////////////////////////////////
-- CONSULTAS COMPLEXAS
--///////////////////////////////////////////////////////////////////////////
-- 1. Encontre o nome e o número de identificação de todos os satélites de observação que foram lançados nos últimos 5 anos.
SELECT sateliteobsmet.idsatelite, satelite.nome FROM SATELITE, SATELITEOBSMET WHERE satelite.datalancamento BETWEEN '03-22-2018' AND '03-22-2023' AND 
satelite.idsatelite = sateliteobsmet.idsatelite;

-- 2. Encontre o nome e o número de identificação de todos os satélites de comunicação que possuem uma velocidade de DownLink maior que 100 Mbps.
SELECT s.idsatelite, s.nome from satelite s, satelitecomunicacao sc, antena an, modem mo, conecta co, usuario u
	WHERE s.idsatelite = sc.idsatelite AND
    sc.idsatelite = an.idsatelite_com AND
    an.idantena = mo.idantena AND
    co.idmodem = mo.idmodem	AND
    co.idusuario = u.idusuario AND
    u.velocidadedownlink > 100;
    

-- 3. Encontre o nome e a posição espacial de todos os satélites de observação que registraram uma temperatura acima de 30 graus Celsius nas últimas 24 horas.

-- Criadas pelo grupo: --

-- 4.

-- 5.
 
-- 6.
