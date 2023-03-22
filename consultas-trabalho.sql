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
-- 6. Liste o id do satélite, id do funcionário e horário das consultas que foram realizadas na parte noturna (18h até 23:59:59)
SELECT idsatelite, idfuncionario, horario FROM CONSULTA WHERE horario BETWEEN '18:00:00' AND '23:59:59';

-- 7. Liste o nome de todos os funcionários que trabalham na central localizada em Campinas
SELECT nome FROM FUNCIONARIO, CENTRAL, PERTENCE WHERE cidade = 'Campinas' AND  funcionario.idfuncionario = pertence.idfuncionario AND 
pertence.idcentral = central.idcentral;

-- 8. Liste o nome dos funcionários e a central que ele pertence que realizaram consultas no ano de 2022 ordenado pelo nome dos funcionários de forma decrescente
SELECT funcionario.nome, central.tipotrabalho FROM FUNCIONARIO, CENTRAL, CONSULTA, SATELITE WHERE
consulta.data BETWEEN '01-01-2022' AND '31-12-2022' AND funcionario.idfuncionario = consulta.idfuncionario AND
consulta.idsatelite = satelite.idsatelite AND central.idcentral = satelite.idcentral ORDER BY funcionario.nome DESC;

-- 9. Liste as velocidades de UpLink e DownLink e o id do modem correspondente
SELECT usuario.velocidadeuplink, usuario.velocidadedownlink, conecta.idmodem FROM USUARIO, CONECTA WHERE usuario.idusuario = conecta.idusuario;

-- 10. Liste todos os satélites de observação e metereologia no qual o raio de leitura por km > 1.000
SELECT * FROM SATELITEOBSMET WHERE raioleiturakm > 1000;

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
SELECT DISTINCT(satelite.nome), localizacao.coordx, localizacao.coordy, localizacao.coordz
FROM SATELITE, LEITURA, LOCALIZACAO WHERE leitura.temperaturaC > 30 AND
satelite.idsatelite = leitura.idsateliteobsm AND satelite.idsatelite = localizacao.idsatelite;

-- Criadas pelo grupo: --
-- 4. Liste a quantidade de consultas que foram realizadas pela central localizada em São Carlos 
SELECT COUNT(consulta.idsatelite) AS qntd_consultas FROM CONSULTA, CENTRAL, SATELITE WHERE central.cidade = 'São Carlos' AND 
consulta.idsatelite = satelite.idsatelite AND central.idcentral = satelite.idcentral;

-- 5. Liste o id do funcionário, nome e quantidade de funcionários que trabalham no Centro de Pesquisa e no Centro de Monitoramento
SELECT central.tipotrabalho, COUNT(central.idcentral) AS qntd_funcionario FROM CENTRAL GROUP BY (central.tipotrabalho);

-- 6. Liste o nome e id do funcionário que realizou uma consulta no qual o satélite seja de observação e metereologia que tem o maior raio de leitura
SELECT funcionario.idfuncionario, funcionario.nome FROM FUNCIONARIO, CONSULTA, SATELITEOBSMET, SATELITE
WHERE funcionario.idfuncionario = consulta.idfuncionario AND satelite.idsatelite = sateliteobsmet.idsatelite AND 
consulta.idsatelite = satelite.idsatelite AND sateliteobsmet.raioleiturakm = 
(SELECT MAX(raioleiturakm) FROM SATELITEOBSMET);
