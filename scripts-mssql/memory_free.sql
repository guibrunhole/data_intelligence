
/*
-- Nome Artefato/Programa..: memory_free.sql
-- Autor(es)...............: Guilherme Brunhole
-- Data Início ............: 01/10/2015
-- Data Atualização........: 
-- Versão..................: 1.00
-- Compilador/Interpretador: PL-SQL
-- Sistemas Operacionais...: Indefinido
-- SGBD....................: MSSQL 2014
-- Especificações..........: Script para visualizar o total de memoria disponivel no servidor
*/

SELECT 
	available_physical_memory_kb/1024 as "Total Memory MB",
    CAST(available_physical_memory_kb/(total_physical_memory_kb*1.0)*100 AS NUMERIC(4,2)) AS "% Memory Free"
FROM 
	sys.dm_os_sys_memory