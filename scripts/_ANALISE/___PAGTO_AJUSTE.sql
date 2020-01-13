
-- ################################################################
-- CRIA TABELA DE TRANSITO DE DADOS PARA TRANSFERENCIAS DE DADOS
-- ################################################################

IF EXISTS(SELECT * FROM sys.tables WHERE name = N'tmp_PAGTO_AJUSTE')
BEGIN
DROP TABLE [TRANSITO].[tmp_PAGTO_AJUSTE]
END
GO

CREATE TABLE [TRANSITO].[tmp_PAGTO_AJUSTE] (
 [CONTA] [varchar](10) NULL,
 [DT_CORTE] [datetime] NULL,
 [VALOR_AJUSTE] [decimal](18, 2) NULL,
 [VALOR_PAGTO] [decimal](18, 2) NULL,
 [dt_atrib] [date] NULL,
 [CHAVE] [varchar](50) NULL
)
GO

-- ################################################################
-- TRANSFERE DADOS ENTRE PLANILHA E TABELA DE TRANSITO
-- ################################################################

INSERT INTO [TRANSITO].[tmp_PAGTO_AJUSTE]
           ([CONTA]
           ,[DT_CORTE]
           ,[VALOR_AJUSTE]
           ,[VALOR_PAGTO]
           ,[dt_atrib]
           )
SELECT 
	[CONTA]
	,convert(datetime,[DT_CORTE],103)
	,[VALOR_AJUSTE]
	,[VALOR_PAGTO]
	,convert(datetime,[dt_atrib],103) 
FROM 
OPENROWSET('Microsoft.ACE.OLEDB.12.0', 'Excel 12.0;Database=\\172.16.0.6\e\sftp_files\FTP_User\SISCOB\TB_PAGTO_AJUSTE.xlsx', [dados$])

-- ################################################################
-- CARREGAR CAMPO CHAVE
-- ################################################################

UPDATE [DB_SISCOB].[TRANSITO].[tmp_PAGTO_AJUSTE] SET CHAVE = [CONTA]+CONVERT(VARCHAR(10),convert(date,[DT_CORTE],103))

-- ################################################################
-- LIMPA A TABELA DESTINO E TRANSFERE OS DADOS
-- ################################################################

TRUNCATE TABLE  [DB_SISCOB].[AUXILIAR].[TB_PAGTO_AJUSTE]
GO
INSERT INTO [DB_SISCOB].[AUXILIAR].[TB_PAGTO_AJUSTE]
           (
   [CONTA]
   ,[DT_PROCESS] 
   ,[VALOR_AJUSTE]
   ,[VALOR_PAGTO]
   ,[DT_IMPORTACAO]
   ,[dt_atrib] 
   )
SELECT 
            
            U.CONTA
            ,U.DT_CORTE
            ,ISNULL(AJ.VALOR_AJUSTE,0)    AS VALOR_AJUSTE
            ,ISNULL(PGTO.VALOR_PAGTO,0) AS VALOR_PAGTO
            ,GETDATE()
            ,CASE 
                  WHEN 
                        AJ.[dt_atrib] IS NULL THEN PGTO.[dt_atrib]
                  WHEN  
                        PGTO.[dt_atrib] IS NULL THEN AJ.[dt_atrib]
                  WHEN
                        AJ.[dt_atrib] < PGTO.[dt_atrib] THEN PGTO.[dt_atrib] 
                  ELSE 
                        AJ.[dt_atrib] 
             END AS dt_atrib
FROM

(

SELECT 
        DISTINCT 
                     
                     P.CONTA
                    ,P.DT_CORTE
                    ,P.CHAVE
                  
FROM
      [DB_SISCOB].[TRANSITO].[tmp_PAGTO_AJUSTE] P

) U 

LEFT JOIN
      ( 
            SELECT 
                   t1.[CONTA]
                  ,t1.[DT_CORTE]
                  ,t1.[VALOR_AJUSTE]
                  ,t1.[VALOR_PAGTO]
                  ,t1.[dt_atrib]
                  ,t1.[CHAVE]
            FROM [DB_SISCOB].[TRANSITO].[tmp_PAGTO_AJUSTE] t1 WHERE t1.[VALOR_AJUSTE] > 0
      ) AJ ON U.CHAVE = AJ.CHAVE

LEFT JOIN 
      (
      SELECT 
                  t2.[CONTA]
                  ,t2.[DT_CORTE]
                  ,t2.[VALOR_AJUSTE]
                  ,t2.[VALOR_PAGTO]
                  ,t2.[dt_atrib]
                  ,t2.[CHAVE]
            FROM [DB_SISCOB].[TRANSITO].[tmp_PAGTO_AJUSTE] t2 WHERE t2.[VALOR_PAGTO] > 0
      ) PGTO ON PGTO.CHAVE = U.CHAVE


GO

-- ################################################################
-- CADASTRO DE SOLICITAÇÕES
-- ################################################################

EXEC [APP_EXCEL].[PRC_UPDATE_PAGTO_AJUSTE]

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
