

/*
-- Nome Artefato/Programa..: usp_index_maintenance.sql
-- Autor(es)...............: Guilherme Brunhole
-- Data Início ............: 01/10/2015
-- Data Atualização........: 
-- Versão..................: 1.00
-- Compilador/Interpretador: PL-SQL
-- Sistemas Operacionais...: Indefinido
-- SGBD....................: MSSQL 2014
-- Especificações..........: 
*/

USE [master]
GO

CREATE PROCEDURE dbo.usp_index_maintenance (@frag INT)
AS
	BEGIN
		SET NOCOUNT ON

		DECLARE @qntd INT = (SELECT MAX(Number) FROM [index_control].[dbo].[index_maintenance])
		DECLARE @count INT = 1
		DECLARE @fragmentation FLOAT = 0.0
		DECLARE @index_name VARCHAR(100)
		DECLARE @table VARCHAR(100) = NULL
		DECLARE @cmd VARCHAR(500)

		WHILE @count <= @qntd
			BEGIN
				
				SET @index_name = (SELECT IndexName FROM [index_control].[dbo].[index_maintenance]
									WHERE [Number] = @count AND AvgPctFrag >= @frag)
				SET @table = (SELECT DatabaseName+'.'+SchemaName+'.'+ObjectName FROM [index_control].[dbo].[index_maintenance]
								WHERE [Number] = @count AND AvgPctFrag >= @frag)
				IF @table IS NOT NULL
				BEGIN
					SET @cmd = 'ALTER INDEX '+@index_name+' ON '+@table+' REBUILD;'
					EXEC(@cmd)
					SET @cmd = 'UPDATE STATISTICS '+@table+' WITH SAMPLE 10000 ROWS;'
					EXEC(@cmd)
				END
			SET @count += 1
			END

	SET NOCOUNT OFF
	END