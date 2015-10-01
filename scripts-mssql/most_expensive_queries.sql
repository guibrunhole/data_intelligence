
/*
-- Nome Artefato/Programa..: most_expensive_queries.sql
-- Autor(es)...............: Guilherme Brunhole
-- Data Início ............: 01/10/2015
-- Data Atualização........: 
-- Versão..................: 1.00
-- Compilador/Interpretador: PL-SQL
-- Sistemas Operacionais...: Indefinido
-- SGBD....................: MSSQL 2014
-- Especificações..........: Script para visualizar um numero X (@count) de consultas que foram mais custosas para o servidor
*/

DECLARE @count INT = 10

SELECT TOP (@count)
        RANK() Over (ORDER BY deqs.total_worker_time DESC) As [Rank],
        CONVERT(decimal(38,2), CONVERT(float, total_worker_time) / 1000) AS [Total CPU Time (ms)],
        execution_count AS [Execution Count],
        CONVERT(decimal(38,2), (CONVERT(float, total_worker_time) / execution_count) / 1000) AS [Average CPU Time (ms)] ,
        SUBSTRING(execText.text,
        -- starting value for substring 
        CASE 
			WHEN deqs.statement_start_offset = 0 OR deqs.statement_start_offset IS NULL THEN 1 
			ELSE deqs.statement_start_offset/2 + 1 
		END,
        -- ending value for substring
        (CASE 
			WHEN deqs.statement_end_offset = 0 OR deqs.statement_end_offset = -1 OR deqs.statement_end_offset IS NULL THEN LEN(execText.text) 
            ELSE deqs.statement_end_offset/2 
		END) 
		- 
        (CASE 
			WHEN deqs.statement_start_offset = 0 OR deqs.statement_start_offset IS NULL THEN 1 
			ELSE deqs.statement_start_offset/2  
		END) 
		+ 1
        ) AS [Query Text],
        execText.text AS [Object Text]
FROM
	sys.dm_exec_query_stats deqs
    CROSS APPLY sys.dm_exec_sql_text(deqs.plan_handle) AS execText
ORDER BY 
	deqs.total_worker_time DESC ;
	
	