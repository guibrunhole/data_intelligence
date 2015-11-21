
/*
-- Nome Artefato/Programa..: space_used_per_table.sql
-- Autor(es)...............: Guilherme Brunhole
-- Data In�cio ............: 21/11/2015
-- Data Atualiza��o........: 
-- Vers�o..................: 1.00
-- Compilador/Interpretador: PL-SQL
-- Sistemas Operacionais...: Indefinido
-- SGBD....................: AWS Redshift (Postgres)
-- Especifica��es..........: Script para visualizar o tamanho de cada tabela/banco/schema
*/


SELECT
		TRIM(pgdb.datname) AS dbase_name
		,TRIM(pgn.nspname) as schemaname
		,TRIM(a.name) AS tablename
		,id AS tbl_oid
		,b.mbytes AS megabytes
		,a.rows AS rowcount
		,a.unsorted_rows AS unsorted_rowcount
		,CASE WHEN a.rows = 0 then 0
			ELSE ROUND((a.unsorted_rows::FLOAT / a.rows::FLOAT) * 100, 5)
		END AS pct_unsorted
		,CASE WHEN a.rows = 0 THEN 'n/a'
			WHEN (a.unsorted_rows::FLOAT / a.rows::FLOAT) * 100 >= 20 THEN 'VACUUM recommended'
			ELSE 'n/a'
		END AS recommendation
FROM
       (
       SELECT
              db_id
              ,id
              ,name
              ,SUM(rows) AS rows
              ,SUM(rows)-SUM(sorted_rows) AS unsorted_rows 
       FROM stv_tbl_perm
       GROUP BY db_id, id, name
       ) AS a 
INNER JOIN
       pg_class AS pgc 
              ON pgc.oid = a.id
INNER JOIN
       pg_namespace AS pgn 
              ON pgn.oid = pgc.relnamespace
INNER JOIN
       pg_database AS pgdb 
              ON pgdb.oid = a.db_id
LEFT OUTER JOIN
       (
       SELECT
              tbl
              ,COUNT(*) AS mbytes 
       FROM stv_blocklist 
       GROUP BY tbl
       ) AS b 
              ON a.id=b.tbl
ORDER BY 1,3,2;