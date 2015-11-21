/*
-- Nome Artefato/Programa..: shrink_log_files.sql
-- Autor(es)...............: Guilherme Brunhole
-- Data Início ............: 20/11/2015
-- Data Atualização........: 
-- Versão..................: 1.00
-- Compilador/Interpretador: PL-SQL
-- Sistemas Operacionais...: Indefinido
-- SGBD....................: MSSQL
*/


USE database_to_select
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[usp_shrink_log_files]
AS
BEGIN

	DECLARE banco CURSOR READ_ONLY FAST_FORWARD FOR SELECT name FROM sys.databases
													 WHERE state_desc = 'ONLINE'
												  ORDER BY name
	
	DECLARE @banco VARCHAR(50)
	DECLARE @sql NVARCHAR(max)

	OPEN banco
	FETCH banco INTO @banco

	WHILE @@fetch_status = 0
	BEGIN
	   
	   SET @sql = ' USE [' + @banco + '];
	                
					DECLARE @logfile NVARCHAR(255);

					SELECT @logfile = name FROM sys.database_files WHERE type = 1;

					DBCC SHRINKFILE(@logfile, 1);  '

	   EXEC sp_executesql @sql
	   FETCH banco INTO @banco
	END

	CLOSE banco
	DEALLOCATE banco

END
GO
