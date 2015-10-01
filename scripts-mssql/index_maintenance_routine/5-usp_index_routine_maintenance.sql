/*
-- Nome Artefato/Programa..: usp_index_routine_maintenance.sql
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

CREATE PROCEDURE usp_index_routine_maintenance 
AS
	BEGIN
	
	SET NOCOUNT ON
	/**********************************************************************************************/
	-- INSERT INDEX'S DATA ON AUX TABLE
	-- EXEC THE SAME COMMAND FOR EVERY DATABASE ON SERVER, EXCEPT SYSTEM DATABASE
		BEGIN TRY
			DELETE FROM [index_control].[dbo].[index_fragmentation_stats]
			EXEC sp_MSforeachdb '
			IF ''?'' NOT IN (''model'',''msdb'',''tempdb'',''master'',''ReportServer'',''ReportServerTempDB'',''public'')
			BEGIN
				EXEC [master].[dbo].[usp_index_fragmentation_stats] ''?''
			END'			
	
	/**********************************************************************************************/

	-- MAKING A LOAD OF DATA ON MAINTENANCE TABLE

			EXEC [master].[dbo].[usp_index_maintenance_load_data]
	
	/**********************************************************************************************/

	-- MAKING AN ACTION
	-- THE PARAMETER BESIDE IS THE MAX VALUE FOR INDEX PERCENT FRAGMENTATION 

			EXEC [master].[dbo].[usp_index_maintenance] 45
		
	/**********************************************************************************************/

	-- INSERT DATA ON HISTORY TABLE

		INSERT INTO [index_control].[dbo].[index_maintenance_history]
			SELECT * FROM [index_control].[dbo].[index_maintenance]

		END TRY
		BEGIN CATCH
			DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE()
			DECLARE @ErrorSeverity INT = ERROR_SEVERITY()
			DECLARE @ErrorState INT = ERROR_STATE()
		
			RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState)
		END CATCH

		SET NOCOUNT OFF

	END