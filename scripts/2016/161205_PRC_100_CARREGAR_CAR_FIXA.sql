USE [DB_SISCOB]
GO
/****** Object:  StoredProcedure [FILE_CAR].[PRC_100_CARREGAR_CAR_FIXA]    Script Date: 12/5/2016 7:31:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		<AILTON ZACARIAS>
-- Create date: <11/05/2016>
-- Description:	<IMPORT FILE CAR>
-- =============================================
CREATE PROCEDURE [FILE_CAR].[PRC_100_CARREGAR_CAR_FIXA] @FILE_NAME VARCHAR(100) --,@FILE_PATH VARCHAR(100),@FILE_MOVE VARCHAR(100)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

DECLARE 
	@RETVAL INT,
	--@FILE_NAME VARCHAR(100),
	@FILE_PATH VARCHAR(100),
	@FILE_MOVE VARCHAR(100),
	@STR_EXEC nvarchar(max),
	@cmd varchar(1000)
	
-- ### APONTAR PARA ARQUIVO TMP
--SET @FILE_NAME = 'CAR_FIXA_PJ_CORP_20160426.txt'

SET @FILE_PATH = '\\10.128.222.63\siscob\Relatorios\FILE_CAR\'
SET @FILE_MOVE = '\\10.128.222.63\siscob\Relatorios\FILE_CAR\_PROCESSADOS'



-- ### VERIFICAR EXISTENCIA DE ARQUIVO TMP
	SELECT @RETVAL = dbo.fn_FileExists(@FILE_PATH+@FILE_NAME) 
	IF @RETVAL = 1 
	BEGIN

		-- ### RECRIAR TABELA DE LOG DE PROCESSO DE IMPORT
		IF OBJECT_ID('[DB_SISCOB].[FILE_CAR].[TB_CAR_FIXA]','U') IS NOT NULL
		BEGIN  
			DROP TABLE	 [DB_SISCOB].[FILE_CAR].[TB_CAR_FIXA];
			CREATE TABLE [DB_SISCOB].[FILE_CAR].[TB_CAR_FIXA](
						[ACORDO] [varchar](50) NULL,
					[AGING_ATUAL] [varchar](50) NULL,
					[AGING_ORIGINAL] [varchar](50) NULL,
					[CDCLIENTE] [varchar](50) NULL,
					[CDCONTA] [varchar](50) NULL,
					[CICLO] [varchar](50) NULL,
					[CLASSE] [varchar](50) NULL,
					[CLASSIFICACAO] [varchar](50) NULL,
					[CLASSSERV] [varchar](50) NULL,
					[CLIENTE] [varchar](255) NULL,
					[COD_SERV] [varchar](50) NULL,
					[CONTA] [varchar](50) NULL,
					[CPF_CNPJ] [varchar](50) NULL,
					[DA] [varchar](255) NULL,
					[DOCUMENTO_SAP] [varchar](50) NULL,
					[DT_CADASTRO] [varchar](50) NULL,
					[DTCONTA] [varchar](50) NULL,
					[DTCORTE] [varchar](50) NULL,
					[DTWO] [varchar](50) NULL,
					[EMPRESA] [varchar](50) NULL,
					[FAIXA_ATUAL] [varchar](50) NULL,
					[FAIXA_ORIGINAL] [varchar](50) NULL,
					[FILTRO] [varchar](50) NULL,
					[GRUPO_DE_EMPRESAS] [varchar](50) NULL,
					[ID_CLIENTE] [varchar](50) NULL,
					[IP] [varchar](50) NULL,
					[NMFATURA] [varchar](50) NULL,
					[NRC] [varchar](50) NULL,
					[OPERACAO] [varchar](50) NULL,
					[ORIGEM] [varchar](50) NULL,
					[OVERBILLING] [varchar](50) NULL,
					[PARCEL_PDD] [varchar](50) NULL,
					[PARCELAMENTO] [varchar](50) NULL,
					[PERDA] [varchar](50) NULL,
					[PF_PJ] [varchar](50) NULL,
					[PRODUTO_ORIGEM] [varchar](50) NULL,
					[PROVISAO] [varchar](50) NULL,
					[RAIZ_CPF_CNPJ] [varchar](50) NULL,
					[RECEBIVEL] [varchar](50) NULL,
					[REGI_AGR] [varchar](50) NULL,
					[REGRA_FX_ENT] [varchar](50) NULL,
					[SALDO_CAR] [varchar](50) NULL,
					[SALDO_FX_ENT] [varchar](50) NULL,
					[SALDO_PDD] [varchar](50) NULL,
					[SALDO_TERCEIROS] [varchar](50) NULL,
					[SALDO_WO] [varchar](50) NULL,
					[SEG_CLIENTE] [varchar](50) NULL,
					[SEG_DESCR] [varchar](50) NULL,
					[SERVTERCEIROS] [varchar](50) NULL,
					[TEL] [varchar](50) NULL,
					[TERM_RET_PDD] [varchar](50) NULL,
					[TIPO_CLIENTE] [varchar](50) NULL,
					[TITULO] [varchar](50) NULL,
					[UF] [varchar](50) NULL,
					[VENC_ATUAL] [varchar](50) NULL,
					[VENC_ORIGINAL] [varchar](50) NULL,
					[WO] [varchar](50) NULL,
					[BILLING] [varchar](50) NULL,
					[STATUS] [varchar](50) NULL,
					[NOTA_FISCAL] [varchar](50) NULL,
					[PARCELA] [varchar](50) NULL,
					[DT_PROCESS] [varchar](50) NULL,
					[REGRA_PDD] [varchar](50) NULL,
					[AGING_CORTE] [varchar](50) NULL,
					[FAIXA_CORTE] [varchar](50) NULL,
					[SEG_DESCR_CLASSE] [varchar](50) NULL,
					[DOC_FAT] [varchar](50) NULL,
					[FILIAL] [varchar](255) NULL,
					[LJ_CLI] [varchar](255) NULL,
					[COD_CLI] [varchar](255) NULL				
	)
		END

	-- ### INICIO 	

		SET @cmd = 'BULK INSERT [DB_SISCOB].[FILE_CAR].[TB_CAR_FIXA]
					FROM ''' + @FILE_PATH + @FILE_NAME + '''
					WITH (      FIELDTERMINATOR = '';'',
								CODEPAGE = ''RAW'',
								FIRSTROW =2,
								ROWTERMINATOR = '''+CHAR(10)+''')'
		EXEC(@cmd)
								
	END

-- X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X
-- X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X
-- X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X

-- ########################################		
-- ### MOVER ARQUIVO 'CAR'
-- ########################################

	SET @STR_EXEC = 'EXEC xp_cmdshell '' move ' + @FILE_PATH + @FILE_NAME + ' ' + @FILE_MOVE + '\' + LEFT(@FILE_NAME,LEN(@FILE_NAME)-4) + '.ok'+''''
	EXEC sp_executesql @STR_EXEC;

-- ########################################		
-- ### MOVER ARQUIVO 'CAR'
-- ########################################

-- X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X
-- X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X
-- X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X
	
-- ########################################		
-- ### [TB_CAR_FIXA_IMPORT]
-- ########################################
--ALTER TABLE [DB_SISCOB].[FILE_CAR].[TB_CAR_FIXA_IMPORT] ADD [COD_CLI] [varchar](255) NULL

---- LIMPAR TABELA
--	TRUNCATE TABLE [DB_SISCOB].[FILE_CAR].[TB_CAR_FIXA_IMPORT]

---- INSERIR DADOS
--	INSERT INTO [DB_SISCOB].[FILE_CAR].[TB_CAR_FIXA_IMPORT] 
--		(
--		[ACORDO]
--		,[AGING_ATUAL]
--		,[AGING_ORIGINAL]
--		,[CDCLIENTE]
--		,[CDCONTA]
--		,[CICLO]
--		,[CLASSE]
--		,[CLASSIFICACAO]
--		,[CLASSSERV]
--		,[CLIENTE]
--		,[COD_SERV]
--		,[CONTA]
--		,[CPF_CNPJ]
--		,[DA]
--		,[DOCUMENTO_SAP]
--		,[DT_CADASTRO]
--		,[DTCONTA]
--		,[DTCORTE]
--		,[DTWO]
--		,[EMPRESA]
--		,[FAIXA_ATUAL]
--		,[FAIXA_ORIGINAL]
--		,[FILTRO]
--		,[GRUPO_DE_EMPRESAS]
--		,[ID_CLIENTE]
--		,[IP]
--		,[NMFATURA]
--		,[NRC]
--		,[OPERACAO]
--		,[ORIGEM]
--		,[OVERBILLING]
--		,[PARCEL_PDD]
--		,[PARCELAMENTO]
--		,[PERDA]
--		,[PF_PJ]
--		,[PRODUTO_ORIGEM]
--		,[PROVISAO]
--		,[RAIZ_CPF_CNPJ]
--		,[RECEBIVEL]
--		,[REGI_AGR]
--		,[REGRA_FX_ENT]
--		,[SALDO_CAR]
--		,[SALDO_FX_ENT]
--		,[SALDO_PDD]
--		,[SALDO_TERCEIROS]
--		,[SALDO_WO]
--		,[SEG_CLIENTE]
--		,[SEG_DESCR]
--		,[SERVTERCEIROS]
--		,[TEL]
--		,[TERM_RET_PDD]
--		,[TIPO_CLIENTE]
--		,[TITULO]
--		,[UF]
--		,[VENC_ATUAL]
--		,[VENC_ORIGINAL]
--		,[WO]
--		,[BILLING]
--		,[STATUS]
--		,[NOTA_FISCAL]
--		,[PARCELA]
--		,[DT_PROCESS]
--		,[REGRA_PDD]
--		,[AGING_CORTE]
--		,[FAIXA_CORTE]
--		,[SEG_DESCR_CLASSE]
--		,[DOC_FAT]
--		,[FILIAL]
--		,[LJ_CLI]
--		)
--	SELECT 
--		[ACORDO]
--		,[AGING_ATUAL]
--		,[AGING_ORIGINAL]
--		,[CDCLIENTE]
--		,[CDCONTA]
--		,[CICLO]
--		,[CLASSE]
--		,[CLASSIFICACAO]
--		,[CLASSSERV]
--		,[CLIENTE]
--		,[COD_SERV]
--		,[CONTA]
--		,[CPF_CNPJ]
--		,[DA]
--		,[DOCUMENTO_SAP]
--		,[DT_CADASTRO]
--		,[DTCONTA]
--		,[DTCORTE]
--		,[DTWO]
--		,[EMPRESA]
--		,[FAIXA_ATUAL]
--		,[FAIXA_ORIGINAL]
--		,[FILTRO]
--		,[GRUPO_DE_EMPRESAS]
--		,[ID_CLIENTE]
--		,[IP]
--		,[NMFATURA]
--		,[NRC]
--		,[OPERACAO]
--		,[ORIGEM]
--		,[OVERBILLING]
--		,[PARCEL_PDD]
--		,[PARCELAMENTO]
--		,[PERDA]
--		,[PF_PJ]
--		,[PRODUTO_ORIGEM]
--		,[PROVISAO]
--		,[RAIZ_CPF_CNPJ]
--		,[RECEBIVEL]
--		,[REGI_AGR]
--		,[REGRA_FX_ENT]
--		,[SALDO_CAR]
--		,[SALDO_FX_ENT]
--		,[SALDO_PDD]
--		,[SALDO_TERCEIROS]
--		,[SALDO_WO]
--		,[SEG_CLIENTE]
--		,[SEG_DESCR]
--		,[SERVTERCEIROS]
--		,[TEL]
--		,[TERM_RET_PDD]
--		,[TIPO_CLIENTE]
--		,[TITULO]
--		,[UF]
--		,[VENC_ATUAL]
--		,[VENC_ORIGINAL]
--		,[WO]
--		,[BILLING]
--		,[STATUS]
--		,[NOTA_FISCAL]
--		,[PARCELA]
--		,[DT_PROCESS]
--		,[REGRA_PDD]
--		,[AGING_CORTE]
--		,[FAIXA_CORTE]
--		,[SEG_DESCR_CLASSE]
--		,[DOC_FAT]
--		,[FILIAL]
--		,[LJ_CLI]
--	FROM [DB_SISCOB].[FILE_CAR].[TB_CAR_FIXA]

-- ########################################		
-- ### [TB_CAR_FIXA_IMPORT]
-- ########################################

-- X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X
-- X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X
-- X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X

---- ########################################		
---- ### [TB_STATUS_CAR]
---- ########################################
	
---- ATUALIZAR [TB_STATUS_CAR]
--	INSERT INTO [DB_SISCOB].[AUXILIAR].[TB_STATUS_CAR]
--			   ([ID_PERIODO]
--			   ,[DESCRICAO]
--			   ,[STATUS]
--			   ,[FILE_CAR])
--		 VALUES
--			   ((SELECT [ID] FROM [DB_SISCOB].[AUXILIAR].[TB_PERIODO] WHERE [STATUS]=1 )
--			   ,right(right(db_siscob.dbo.GetFileNameWithoutExtension(@FILE_PATH + @FILE_NAME),8),2)
--			   ,1
--			   ,@FILE_NAME)
END
