
/*
-- Nome Artefato/Programa..: memory_free.sql
-- Autor(es)...............: Guilherme Brunhole
-- Data In�cio ............: 01/10/2015
-- Data Atualiza��o........: 
-- Vers�o..................: 1.00
-- Compilador/Interpretador: PL-SQL
-- Sistemas Operacionais...: Indefinido
-- SGBD....................: MSSQL 2014
-- Especifica��es..........: Script para visualizar o total de memoria disponivel no servidor
*/

SELECT 
	available_physical_memory_kb/1024 as "Total Memory MB",
    CAST(available_physical_memory_kb/(total_physical_memory_kb*1.0)*100 AS NUMERIC(4,2)) AS "% Memory Free"
FROM 
	sys.dm_os_sys_memory