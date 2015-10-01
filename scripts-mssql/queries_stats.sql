
/*
-- Nome Artefato/Programa..: queries_stats.sql
-- Autor(es)...............: Guilherme Brunhole
-- Data Início ............: 01/10/2015
-- Data Atualização........: 
-- Versão..................: 1.00
-- Compilador/Interpretador: PL-SQL
-- Sistemas Operacionais...: Indefinido
-- SGBD....................: MSSQL 2014
-- Especificações..........: Script para visualizar as estatisticas das queries, como o plano de execucao, a consulta executada, total de leituras, escritas ...
*/

DECLARE @work_time INT = 300
DECLARE @elapse_time INT = 300


SELECT  
	st.text,
    qp.query_plan,
    qs.*
FROM
    (
    SELECT TOP 50
		*
    FROM
		sys.dm_exec_query_stats
    ORDER BY 
		total_worker_time DESC
	) AS qs
CROSS APPLY sys.dm_exec_sql_text(qs.sql_handle) AS st
CROSS APPLY sys.dm_exec_query_plan(qs.plan_handle) AS qp
WHERE
	qs.max_worker_time > @work_time
    OR qs.max_elapsed_time > @elapse_time
