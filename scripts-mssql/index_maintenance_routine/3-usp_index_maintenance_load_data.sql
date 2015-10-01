
/*
-- Nome Artefato/Programa..: usp_index_maintenance_load_data.sql
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

CREATE PROCEDURE dbo.usp_index_maintenance_load_data
AS
	BEGIN

		SET NOCOUNT ON
		
		TRUNCATE TABLE [index_control].[dbo].[index_maintenance]
				
		INSERT INTO [index_control].[dbo].[index_maintenance]
           ([Date]
           ,[SGBD]
           ,[ServerName]
           ,[DatabaseName]
           ,[SchemaName]
           ,[ObjectName]
           ,[ObjectID]
           ,[IndexType]
           ,[IndexName]
           ,[AvgPctFrag]
		   ,[rows])
		SELECT DISTINCT
			CAST(GETDATE() AS DATE)  [Date]
			,'MSSQL' [SGBD]
			,ids.ServerName
			,ids.DatabaseName
			,ids.SchemaName
			,ids.ObjectName
			,ids.ObjectID
			,ids.IndexType
			,ids.IndexName
			,ids.AvgPctFrag
			,ids.[rows]
		FROM 
			[index_control].[dbo].[index_fragmentation_stats] AS ids			

		SET NOCOUNT OFF
	END