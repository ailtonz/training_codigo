
-- ################################################################
-- CRIA TABELA DE TRANSITO DE DADOS PARA TRANSFERENCIAS DE DADOS
-- ################################################################

IF EXISTS(SELECT * FROM sys.tables WHERE name = N'tmp_CONTA_BONUS')
BEGIN
DROP TABLE [TRANSITO].[tmp_CONTA_BONUS]
END
GO

CREATE TABLE [TRANSITO].[tmp_CONTA_BONUS] (
[CONTA] nvarchar(255)
)
GO

-- ################################################################
-- TRANSFERE DADOS ENTRE PLANILHA E TABELA DE TRANSITO
-- ################################################################

--INSERT INTO [TRANSITO].[tmp_CONTA_BONUS]
--           ([CONTA])

--SELECT  
--	[CONTA] 
--FROM 
--OPENROWSET('Microsoft.ACE.OLEDB.12.0', 'Excel 12.0;Database=\\172.16.0.6\e\sftp_files\FTP_User\SISCOB\TB_CONTA_BONUS.xlsx', [dados$])


-- ################################################################
-- LIMPA A TABELA DESTINO E TRANSFERE OS DADOS
-- ################################################################

--TRUNCATE TABLE  [DB_SISCOB].[AUXILIAR].[TB_CONTA_BONUS]
--GO
--INSERT INTO [DB_SISCOB].[AUXILIAR].[TB_CONTA_BONUS]
--           (
--           [CONTA]
--           ,[DATA_IMPORTACAO]
--)
--SELECT 
--                [CONTA]
--                ,GETDATE()  AS [DATA_IMPORTACAO]
--  FROM 
-- 	[DB_SISCOB].[TRANSITO].[tmp_CONTA_BONUS]
--GO

-- ################################################################
-- FATURA CONTA BONUS (SIM - NÃO)
-- ################################################################

--EXEC [APP_EXCEL].[PRC_UPDATE_CONTA_BONUS]
--GO

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