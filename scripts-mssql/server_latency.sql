
/*
-- Nome Artefato/Programa..: server_latency.sql
-- Autor(es)...............: Guilherme Brunhole
-- Data Início ............: 01/10/2015
-- Data Atualização........: 
-- Versão..................: 1.00
-- Compilador/Interpretador: PL-SQL
-- Sistemas Operacionais...: Indefinido
-- SGBD....................: MSSQL 2014
-- Especificações..........: Script para visualizar as latencias do servidor
*/

SELECT
    CASE 
		WHEN num_of_reads = 0 THEN 0 
		ELSE (io_stall_read_ms / num_of_reads) 
	END AS ReadLatency,
    CASE 
		WHEN num_of_writes = 0 THEN 0 
		ELSE (io_stall_write_ms / num_of_writes) 
	END AS WriteLatency,
    CASE 
		WHEN (num_of_reads = 0 AND num_of_writes = 0) THEN 0 
		ELSE (io_stall / (num_of_reads + num_of_writes)) 
	END AS Latency,
    CASE 
		WHEN num_of_reads = 0 THEN 0 
		ELSE (num_of_bytes_read / num_of_reads) 
	END AS AvgBPerRead,
    CASE 
		WHEN num_of_writes = 0 THEN 0 
		ELSE (num_of_bytes_written / num_of_writes) 
	END AS AvgBPerWrite,
    CASE 
		WHEN (num_of_reads = 0 AND num_of_writes = 0) THEN 0 
		ELSE ((num_of_bytes_read + num_of_bytes_written) / (num_of_reads + num_of_writes)) 
	END AS AvgBPerTransfer,
    LEFT (mf.physical_name, 2) AS Drive,
    DB_NAME (vfs.database_id) AS DB,
    mf.physical_name
FROM
    sys.dm_io_virtual_file_stats (NULL,NULL) AS vfs
	JOIN sys.master_files AS mf ON vfs.database_id = mf.database_id AND vfs.file_id = mf.file_id
-- WHERE vfs.file_id = 2 -- log files
ORDER BY 
	WriteLatency DESC
GO