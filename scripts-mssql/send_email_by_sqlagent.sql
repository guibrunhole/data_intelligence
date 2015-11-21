/*
-- Nome Artefato/Programa..: send_email_by_sqlagent.sql
-- Autor(es)...............: Guilherme Brunhole
-- Data Início ............: 20/11/2015
-- Data Atualização........: 
-- Versão..................: 1.00
-- Compilador/Interpretador: PL-SQL
-- Sistemas Operacionais...: Indefinido
-- SGBD....................: MSSQL 2014
-- Especificações..........: Script para disparar e-mails com anexo via SQL Agent
*/


USE DATABASE_TO_SELECT
GO
SET LANGUAGE portuguese;
Declare @attach  varchar(max) = 'file_name'+'.csv';
Declare @bd varchar(max) =  '<html>
        <body>
		-- write something
        </body>
       </html>';
EXEC msdb.dbo.sp_send_dbmail
@profile_name = '[EMAIL PROFILE]',
@Query = 'Put your query here',
@attach_query_result_as_file = 1,
@query_attachment_filename = @attach,
@query_result_separator = ';',
@query_result_no_padding = 1,
@query_result_width = 9999,
@subject = 'subject',
@body = @bd,
@recipients = 'recipients',
@copy_recipients = 'copy_recipients' ,
@body_format = 'HTML'