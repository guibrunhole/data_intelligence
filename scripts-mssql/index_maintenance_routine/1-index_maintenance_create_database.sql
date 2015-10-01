/*
-- Nome Artefato/Programa..: index_maintenance_create_database.sql
-- Autor(es)...............: Guilherme Brunhole
-- Data Início ............: 01/10/2015
-- Data Atualização........: 
-- Versão..................: 1.00
-- Compilador/Interpretador: PL-SQL
-- Sistemas Operacionais...: Indefinido
-- SGBD....................: MSSQL 2014
-- Especificações..........: SCRIPTS DE CRIACAO DAS TABELAS E BANCOS USADOS NA ROTINA DE MANUTENÇÃO DOS INDICES
*/

CREATE DATABASE [index_control]
GO


CREATE TABLE [index_control].[dbo].[index_fragmentation_stats](
	[ServerName] [nvarchar](128) NULL,
	[DatabaseName] [nvarchar](128) NULL,
	[SchemaName] [nvarchar](128) NULL,
	[ObjectName] [sysname] NOT NULL,
	[ObjectID] [int] NULL,
	[IndexID] [int] NOT NULL,
	[IndexName] [sysname] NOT NULL,
	[IndexType] [varchar](12) NULL,
	[PartitionNumber] [int] NULL,
	[FillFactorAvg] [int] NULL,
	[AvgPctFrag] [numeric](38, 6) NULL,
	[rows] INT
) ON [PRIMARY]
GO

CREATE TABLE [index_control].[dbo].[index_maintenance](
	[Date] [date] NULL,
	[SGBD] [varchar](5) NOT NULL,
	[ServerName] [nvarchar](128) NULL,
	[DatabaseName] [nvarchar](128) NULL,
	[SchemaName] [nvarchar](128) NULL,
	[ObjectName] [sysname] NOT NULL,
	[ObjectID] [int] NULL,
	[IndexType] [nvarchar](67) NULL,
	[IndexName] [sysname] NULL,
	[AvgPctFrag] [numeric](38, 6) NULL,
	[Number] [int] IDENTITY(1,1) NOT NULL,
	[rows] [INT]
) ON [PRIMARY]
GO

CREATE TABLE [index_control].[dbo].[index_maintenance_history](
	[Date] [date] NULL,
	[SGBD] [varchar](5) NOT NULL,
	[ServerName] [nvarchar](128) NULL,
	[DatabaseName] [nvarchar](128) NULL,
	[SchemaName] [nvarchar](128) NULL,
	[ObjectName] [sysname] NOT NULL,
	[ObjectID] [int] NULL,
	[IndexType] [nvarchar](67) NULL,
	[IndexName] [sysname] NULL,
	[AvgPctFrag] [numeric](38, 6) NULL,
	[Number] [int] NOT NULL,
	[rows] [INT]
) ON [PRIMARY]
GO