USE [DB_SISCOB]
GO
/****** Object:  StoredProcedure [AUXILIAR].[PRC_ANALISE_CONTA_161128_1323_BKP]    Script Date: 12/5/2016 7:21:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- ==========================================================================
-- Author:		Ailton
-- Create date: 2016-11-22
-- Obs> : 
-- 
-- ==========================================================================

ALTER PROCEDURE [AUXILIAR].[PRC_ANALISE_CONTA_161128_1323_BKP] 

AS
BEGIN

-- ################################################################
-- CRIA TABELA DE TRANSITO DE DADOS PARA TRANSFERENCIAS DE DADOS
-- ################################################################

IF EXISTS(SELECT * FROM sys.tables WHERE name = N'tmp_ANALISE_CONTA')
BEGIN
DROP TABLE [TRANSITO].[tmp_ANALISE_CONTA]
END

CREATE TABLE [TRANSITO].[tmp_ANALISE_CONTA] (
[NR_CONTA] nvarchar(255),
[FATURA] nvarchar(255),
[ID_ANALISE_CONTA] float,
[DATA_ENTRADA] datetime,
[TIPO] nvarchar(255),
[KEY] nvarchar(255)
)

-- ################################################################
-- TRANSFERE DADOS ENTRE PLANILHA E TABELA DE TRANSITO
-- ################################################################

INSERT INTO [TRANSITO].[tmp_ANALISE_CONTA]
           ([NR_CONTA]
           ,[FATURA]
           ,[ID_ANALISE_CONTA]
           ,[DATA_ENTRADA]
           ,[TIPO]
           )

SELECT 
	[NR_CONTA]
	,[FATURA]
	,[ID_ANALISE_CONTA]
	,convert(datetime,[DATA_ENTRADA],103)
	,[TIPO] 
FROM 
OPENROWSET('Microsoft.ACE.OLEDB.12.0', 'Excel 12.0;Database=\\172.16.0.6\e\sftp_files\FTP_User\SISCOB\TB_ANALISE_CONTA.xlsx', [dados$])

-- ################################################################
-- CRIA CHAVE DE REGISTROS
-- ################################################################

DELETE FROM [DB_SISCOB].[TRANSITO].[tmp_ANALISE_CONTA]  WHERE [NR_CONTA]  IS NULL


UPDATE [DB_SISCOB].[TRANSITO].[tmp_ANALISE_CONTA] SET [KEY] = [NR_CONTA]+[FATURA]


-- ################################################################
-- LIMPA TABELA DESTINO E CARREGA TODOS OS REGITROS
-- ################################################################

TRUNCATE TABLE  [DB_SISCOB].[AUXILIAR].[TB_ANALISE_CONTA]

INSERT INTO [DB_SISCOB].[AUXILIAR].[TB_ANALISE_CONTA]
           ([PENDENTE_ID]
           ,[PENDENTE_DATA]
           ,[CONCLUIDO_ID]
           ,[CONCLUIDO_DATA]
           ,[CONTA]
           ,[ANOMES]
           ,[DATA_IMPORTACAO])
SELECT 
                PDT.[ID_ANALISE_CONTA] AS [PENDENTE_ID]
                ,PDT.[DATA_ENTRADA] AS [PENDENTE_DATA]
                ,CLD.[ID_ANALISE_CONTA] AS [CONCLUIDO_ID]
                ,CLD.[DATA_ENTRADA] AS [CONCLUIDO_DATA]
                ,CASE WHEN PDT.[NR_CONTA] is null then CLD.[NR_CONTA] else PDT.[NR_CONTA] END AS [CONTA]
                ,CASE WHEN PDT.[FATURA] is null then CLD.[FATURA] else PDT.[FATURA] END AS [ANOMES]
                ,GETDATE()  AS [DATA_IMPORTACAO]
  FROM 
  ( SELECT * FROM [DB_SISCOB].[TRANSITO].[tmp_ANALISE_CONTA] t1 WHERE t1.[TIPO]='PENDENTES' ) PDT 
  FULL OUTER JOIN  ( SELECT * FROM [DB_SISCOB].[TRANSITO].[tmp_ANALISE_CONTA] t2 WHERE t2.[TIPO]='CONCLUIDOS' ) CLD ON PDT.[KEY] = CLD.[KEY] 


-- ################################################################
-- CADASTRO DE SOLICITAÇÃO
-- ################################################################




EXEC [DB_SISCOB].[APP_EXCEL].[PRC_UPDATE_ANALISE_CONTAS]



-- ################################################################
-- RENOMEAR ARQUIVO
-- ################################################################

---
---
---
---

-- ################################################################
-- E-MAIL DE CONCLUSÃO
-- ################################################################

---
---
---
---


END

