
/*
-- Nome Artefato/Programa..: dependencies_postgres.sql
-- Autor(es)...............: Guilherme Brunhole
-- Data Início ............: 01/10/2015
-- Data Atualização........: 
-- Versão..................: 1.00
-- Compilador/Interpretador: PL-SQL
-- Sistemas Operacionais...: Indefinido
-- SGBD....................: Postgres 9+
-- Especificações..........: Script para visualizar as dependencias do objeto
*/


SELECT DISTINCT 
  r.ev_class :: REGCLASS AS view_name
FROM
  pg_catalog.pg_depend d
  JOIN pg_catalog.pg_rewrite r ON (r.oid = d.objid)
  JOIN pg_catalog.pg_class c ON (c.oid::REGCLASS = d.refobjid)
WHERE
  d.refobjsubid != 0 AND c.relname = 'table_name';