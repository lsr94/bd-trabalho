-- 1. Encontre todos os satélites que estão conectados a uma central ‘x’. 

-- 2. Encontre todas as centrais que realizam ‘pesquisa’.
SELECT * FROM CENTRAL WHERE tipotrabalho = 'Central de Pesquisa';

-- 3. Encontre todos os satélites lançados antes de 2010.
SELECT * FROM SATELITE WHERE datalancamento <= '31-12-2010';

-- 4. Encontre todas as chaves de criptografia dos satélites de ‘comunicação’.
SELECT chaveCripto FROM SATELITECOMUNICACAO;

-- 5. Encontre todos os funcionários da central ‘x’.