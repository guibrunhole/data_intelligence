
/*
-- Nome Artefato/Programa..: server_connections.sql
-- Autor(es)...............: Guilherme Brunhole
-- Data In�cio ............: 01/10/2015
-- Data Atualiza��o........: 
-- Vers�o..................: 1.00
-- Compilador/Interpretador: PL-SQL
-- Sistemas Operacionais...: Indefinido
-- SGBD....................: MSSQL 2014
-- Especifica��es..........: Script para visualizar o numero total de conex�es em cada banco de dados do servidor
*/


SELECT 
    DB_NAME(dbid) as DBName, 
    COUNT(dbid) as NumberOfConnections,
    loginame as LoginName
FROM
    sys.sysprocesses
WHERE 
    dbid > 0
GROUP BY 
    dbid
	,loginame