USE [DB_SISCOB]
GO
/****** Object:  StoredProcedure [AUXILIAR].[PRC_CONTA_BONUS_161128_1323_BKP]    Script Date: 12/5/2016 7:21:40 PM ******/
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

ALTER PROCEDURE [AUXILIAR].[PRC_CONTA_BONUS_161128_1323_BKP] 

AS
BEGIN
	
-- ################################################################
-- CRIA TABELA DE TRANSITO DE DADOS PARA TRANSFERENCIAS DE DADOS
-- ################################################################

IF EXISTS(SELECT * FROM sys.tables WHERE name = N'tmp_CONTA_BONUS')
BEGIN
DROP TABLE [TRANSITO].[tmp_CONTA_BONUS]
END


CREATE TABLE [TRANSITO].[tmp_CONTA_BONUS] (
[CONTA] nvarchar(255)
)


-- ################################################################
-- TRANSFERE DADOS ENTRE PLANILHA E TABELA DE TRANSITO
-- ################################################################

INSERT INTO [TRANSITO].[tmp_CONTA_BONUS]
           ([CONTA])

SELECT  
	[CONTA] 
FROM 
OPENROWSET('Microsoft.ACE.OLEDB.12.0', 'Excel 12.0;Database=\\172.16.0.6\e\sftp_files\FTP_User\SISCOB\TB_CONTA_BONUS.xlsx', [dados$])


-- ################################################################
-- LIMPA A TABELA DESTINO E TRANSFERE OS DADOS
-- ################################################################

TRUNCATE TABLE  [DB_SISCOB].[AUXILIAR].[TB_CONTA_BONUS]

INSERT INTO [DB_SISCOB].[AUXILIAR].[TB_CONTA_BONUS]
           (
           [CONTA]
           ,[DATA_IMPORTACAO]
)
SELECT 
                [CONTA]
                ,GETDATE()  AS [DATA_IMPORTACAO]
  FROM 
 	[DB_SISCOB].[TRANSITO].[tmp_CONTA_BONUS]


-- ################################################################
-- FATURA CONTA BONUS (SIM - NÃO)
-- ################################################################

EXEC [APP_EXCEL].[PRC_UPDATE_CONTA_BONUS]


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

