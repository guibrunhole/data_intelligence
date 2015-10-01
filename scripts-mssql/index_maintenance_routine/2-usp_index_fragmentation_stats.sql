/*
-- Nome Artefato/Programa..: usp_index_fragmentation_stats.sql
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

/****** Object:  StoredProcedure [dbo].[usp_index_fragmentation_stats]    Script Date: 27/07/2015 09:01:09 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
	
CREATE PROCEDURE [dbo].[usp_index_fragmentation_stats] (@database NVARCHAR(50))
AS
	BEGIN
		
		SET NOCOUNT ON

		DECLARE @SQL NVARCHAR(MAX) =
		('
		USE ['+@database+']
	
		INSERT INTO [index_control].[dbo].[index_fragmentation_stats]
				   ([ServerName]
				   ,[DatabaseName]
				   ,[SchemaName]
				   ,[ObjectName]
				   ,[ObjectID]
				   ,[IndexID]
				   ,[IndexName]
				   ,[IndexType]
				   ,[PartitionNumber]
				   ,[FillFactorAvg]
				   ,[AvgPctFrag]
				   ,[rows])
			SELECT 
				ServerName
				,DatabaseName
				,SchemaName
				,ObjectName
				,ObjectID
				,IndexID
				,IndexName
				,IndexType
				,MAX(PartitionNumber) PartitionNumber
				,AVG(FillFactorAvg) FillFactorAvg
				,AVG(AvgPctFrag) AvgPctFrag
				,AVG(rows) Rows
			FROM
				(
				SELECT
				   @@SERVERNAME AS ServerName
				   , DB_NAME() AS DatabaseName
				   , SCHEMA_NAME(sObj.schema_id) AS SchemaName
				   , sObj.name AS ObjectName
				   ,sdmfIPS.object_id AS ObjectID
				   , sIdx.index_id AS IndexID
				   , ISNULL(sIdx.name, ''N/A'') AS IndexName
				   , CASE
						 WHEN sIdx.type = 2 THEN ''Nonclustered''
						 ELSE null
					 END AS IndexType
				   , ISNULL(sPtn.partition_number, 1) AS PartitionNumber
				   , sdmfIPS.alloc_unit_type_desc AS IndexAllocationUnitType
				   , sIdx.fill_factor AS FillFactorAvg
				   , CAST(sdmfIPS.avg_fragmentation_in_percent AS NUMERIC(5,2)) AS AvgPctFrag
				   , sPtn.rows
				FROM 
				   sys.indexes AS sIdx
				   INNER JOIN sys.objects AS sObj
					  ON sIdx.object_id = sObj.object_id
				   LEFT JOIN  sys.partitions AS sPtn
					  ON sIdx.object_id = sPtn.object_id
					  AND sIdx.index_id = sPtn.index_id
				   LEFT JOIN sys.dm_db_index_physical_stats (DB_ID(),NULL,NULL,NULL,''LIMITED'') sdmfIPS
					  ON sIdx.object_id = sdmfIPS.object_id
					  AND sIdx.index_id = sdmfIPS.index_id
					  AND sdmfIPS.database_id = DB_ID()
				WHERE
				   sObj.type IN (''U'')		      -- Look in Tables
				   AND sObj.is_ms_shipped = 0x0   -- Exclude System Generated Objects
				   AND sIdx.is_disabled = 0x0     -- Exclude Disabled Indexes
				   AND sIdx.type = 2			  -- Only INDEX NONCLUSTERED
				   ) AS base
			GROUP BY
				ServerName
				,DatabaseName
				,SchemaName
				,ObjectName
				,ObjectID
				,IndexID
				,IndexName
				,IndexType
			')
		
			EXEC sp_executesql @SQL

			SET NOCOUNT OFF
	END
GO


