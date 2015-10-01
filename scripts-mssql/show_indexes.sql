
/*
-- Nome Artefato/Programa..: show_indexes.sql
-- Autor(es)...............: Guilherme Brunhole
-- Data In�cio ............: 01/10/2015
-- Data Atualiza��o........: 
-- Vers�o..................: 1.00
-- Compilador/Interpretador: PL-SQL
-- Sistemas Operacionais...: Indefinido
-- SGBD....................: MSSQL 2014
-- Especifica��es..........: Script para visualizar quais sao os indices em cada tabela
*/


SELECT 
	OBJECT_NAME(dmi.object_id) as tbl_name, 
	i.name AS idx_name, 
	dmi.database_id
	,dmi.user_seeks
	,dmi.user_scans
	,dmi.user_updates 
FROM 
	sys.dm_db_index_usage_stats dmi join 
	sys.indexes i on dmi.index_id = i.index_id and dmi.object_id = i.object_id
ORDER BY 
	user_updates DESC

