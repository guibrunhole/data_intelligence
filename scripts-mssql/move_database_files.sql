/*
-- Nome Artefato/Programa..: move_database_files.sql
-- Autor(es)...............: Matheus Campos
-- Data Início ............: 12/05/2017
-- Data Atualização........: 
-- Versão..................: 1.00
-- Compilador/Interpretador: PL-SQL
-- Sistemas Operacionais...: Indefinido
-- SGBD....................: MSSQL 2014
-- Especificações..........: 
*/

EXEC sp_configure 'show advanced options', 1
reconfigure
EXEC sp_configure 'xp_cmdshell', 1 
reconfigure

DECLARE @myQuery nvarchar(max) = ''
DECLARE @countMax int = 0
DECLARE @countCurrent int = 1
DECLARE @DatabaseName varchar(100) = ''
DECLARE @DatabaseOrigin varchar(100) =  'C:'
DECLARE @DatabaseDestination varchar(100) = ''
DECLARE @ShellCommand varchar(100) = 'mkdir '+@DatabaseDestination
DECLARE @FileName varchar(100) = ''
DECLARE @FileExtension varchar(10) = ''

EXEC xp_cmdshell @ShellCommand

WAITFOR DELAY '00:00:05';

IF OBJECT_ID('tmpMoveFiles', 'U') IS NOT NULL 
  DROP TABLE tmpMoveFiles;   

SELECT
	ROW_NUMBER() over (order by mf.name) myRow,
	db.name as DatabaseName,   
	mf.name as FileName,
    type_desc AS FileType,
	SUBSTRING(Physical_Name,CHARINDEX('.',Physical_Name)+1,LEN(Physical_Name)+1) as 'FileExtension',
    Physical_Name AS Location
into tmpMoveFiles
FROM sys.master_files mf
INNER JOIN sys.databases db ON db.database_id = mf.database_id
where db.name = @DatabaseName

set @countMax = (select COUNT(1) from tmpMoveFiles)

set @myQuery = 'ALTER DATABASE '+@DatabaseName+' SET OFFLINE WITH ROLLBACK IMMEDIATE'
exec (@myQuery)

while @countCurrent <= @countMax begin
		
	set @FileName = (select FileName from tmpMoveFiles where myRow = @countCurrent)
	set @FileExtension = (select FileExtension from tmpMoveFiles where myRow = @countCurrent)

	set @ShellCommand = 'move '+@DatabaseOrigin+'\'+@FileName+'.'+@FileExtension+' '+@DatabaseDestination
	EXEC xp_cmdshell @ShellCommand	

	set @myQuery = 'ALTER DATABASE '+@DatabaseName+' MODIFY FILE ( NAME = '+@FileName+', FILENAME = '''+@DatabaseDestination+'\'+@FileName+'.'+@FileExtension+''');'
	exec (@myQuery)

	set @countCurrent = @countCurrent + 1
end

set @myQuery = 'ALTER DATABASE '+@DatabaseName+' SET ONLINE'
exec (@myQuery)

