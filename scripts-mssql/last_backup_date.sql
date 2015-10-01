
/*
-- Nome Artefato/Programa..: last_backup_date.sql
-- Autor(es)...............: Guilherme Brunhole
-- Data Início ............: 01/10/2015
-- Data Atualização........: 
-- Versão..................: 1.00
-- Compilador/Interpretador: PL-SQL
-- Sistemas Operacionais...: Indefinido
-- SGBD....................: MSSQL 2014
-- Especificações..........: Script para visualizar a ultima data de backup em cada database
*/

SELECT 	
	B.name as Database_Name, 
	ISNULL(STR(ABS(DATEDIFF(day, GetDate(), MAX(Backup_finish_date)))), 'NEVER') as DaysSinceLastBackup,
	ISNULL(Convert(char(10), MAX(backup_finish_date), 101), 'NEVER') as LastBackupDate
FROM 
	master.dbo.sysdatabases B 
	LEFT OUTER JOIN msdb.dbo.backupset A ON A.database_name = B.name AND A.type = 'D' 
GROUP BY 
	B.Name 
ORDER BY 
	B.name