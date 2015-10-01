
/*
-- Nome Artefato/Programa..: show_indexes_stats.sql
-- Autor(es)...............: Guilherme Brunhole
-- Data Início ............: 01/10/2015
-- Data Atualização........: 
-- Versão..................: 1.00
-- Compilador/Interpretador: PL-SQL
-- Sistemas Operacionais...: Indefinido
-- SGBD....................: MSSQL 2014
-- Especificações..........: Script para visualizar quais as estatisticas dos indices e ja com um comando pronto para rodar
*/

SELECT 
	'ALTER INDEX ['+name+'] ON ['+OBJECT_NAME(A.object_id)+'] REBUILD PARTITION = ALL WITH ( FILLFACTOR = 80, 
	PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, 
	ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, ONLINE = ON, 
	SORT_IN_TEMPDB = ON )' AS command
	,avg_fragmentation_in_percent
FROM 
	sys.dm_db_index_physical_stats (DB_ID(),NULL, NULL, NULL, NULL) AS a
	JOIN sys.indexes AS b ON a.object_id = b.object_id AND a.index_id = b.index_id 
WHERE 
	A.index_id <> 0
ORDER BY 
	avg_fragmentation_in_percent DESC;