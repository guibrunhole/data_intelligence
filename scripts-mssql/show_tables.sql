
/*
-- Nome Artefato/Programa..: show_tables.sql
-- Autor(es)...............: Guilherme Brunhole
-- Data In�cio ............: 01/10/2015
-- Data Atualiza��o........: 
-- Vers�o..................: 1.00
-- Compilador/Interpretador: PL-SQL
-- Sistemas Operacionais...: Indefinido
-- SGBD....................: MSSQL 2014
-- Especifica��es..........: Script para visualizar todas as tabelas do banco de dados e suas caracteristicas: espaco, linhas ...
*/


SELECT 
    s.Name AS SchemaName,
    t.NAME AS TableName,
    p.rows AS RowCounts,
    SUM(a.total_pages) * 8 AS TotalSpaceKB, 
    SUM(a.used_pages) * 8 AS UsedSpaceKB, 
    (SUM(a.total_pages) - SUM(a.used_pages)) * 8 AS UnusedSpaceKB
FROM 
    sys.tables t
	INNER JOIN sys.schemas s ON s.schema_id = t.schema_id
	INNER JOIN sys.indexes i ON t.OBJECT_ID = i.object_id
	INNER JOIN sys.partitions p ON i.object_id = p.OBJECT_ID AND i.index_id = p.index_id
	INNER JOIN sys.allocation_units a ON p.partition_id = a.container_id
WHERE 
    t.NAME NOT LIKE 'dt%'    -- filter out system tables for diagramming
    AND t.is_ms_shipped = 0
    AND i.OBJECT_ID > 255 
GROUP BY 
    t.Name, 
	s.Name, 
	p.Rows
ORDER BY 
    s.Name, 
	t.Name