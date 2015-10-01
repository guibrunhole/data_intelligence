
/*
-- Nome Artefato/Programa..: jobs_error.sql
-- Autor(es)...............: Guilherme Brunhole
-- Data In�cio ............: 01/10/2015
-- Data Atualiza��o........: 
-- Vers�o..................: 1.00
-- Compilador/Interpretador: PL-SQL
-- Sistemas Operacionais...: Indefinido
-- SGBD....................: MSSQL 2014
-- Especifica��es..........: Script para listas quais jobs falharam e qual foi o erro exibido
*/


SELECT 
	A.name AS [JOB]
	,B.last_outcome_message AS [ERROR]
FROM 
	msdb.dbo.sysjobs A, msdb.dbo.sysjobservers B 
WHERE 
	A.job_id = B.job_id 
	AND B.last_run_outcome = 0
