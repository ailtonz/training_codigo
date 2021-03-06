USE [DB_SISCOB]
GO
/****** Object:  StoredProcedure [APP_WEB].[PRC_CENARIO_161127_1520]    Script Date: 12/5/2016 7:20:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



ALTER PROCEDURE [APP_WEB].[PRC_CENARIO_161127_1520] @QUERY_WHERE NVARCHAR(MAX),  @ANALISTA NVARCHAR(100),  @RAIZ_GRUPO NVARCHAR(100), @ID_FILE int output
AS
BEGIN

SET NOCOUNT ON


DECLARE @Cmd VARCHAR(500);
DECLARE @SQL NVARCHAR(MAX);	
DECLARE @QUERY NVARCHAR(MAX);
DECLARE @QUERY_WHERE_TMP NVARCHAR(MAX);

SET LANGUAGE PORTUGUESE;
-- ###################################################################################################################################################################################
-- ###################################################################################################################################################################################
-- [1] -> COPIAR ARQUIVO MODELO 
-- ###################################################################################################################################################################################
-- ###################################################################################################################################################################################

-- #########################
-- SELEÇÃO DO ARQUIVO
-- #########################
	DECLARE @FILE_MODEL_PATH		VARCHAR(1000); SET @FILE_MODEL_PATH		= (SELECT TOP 1 [DESCRICAO] AS 'FILE_MODEL_PATH' FROM [DB_SISCOB].[ADM].[TB_APP_CONTROLE] WHERE [TIPO] = 'CENARIO_FILE_MODEL_PATH');
	DECLARE @FILE_MODEL				VARCHAR(1000); SET @FILE_MODEL			= (SELECT TOP 1 [DESCRICAO] AS 'FILE_MODEL' FROM [DB_SISCOB].[ADM].[TB_APP_CONTROLE] WHERE [TIPO] = 'CENARIO_FILE_MODEL');
	DECLARE @FILE_EXIT				VARCHAR(1000); SET @FILE_EXIT			= (SELECT TOP 1 [DESCRICAO_02] AS 'FILE_EXIT' FROM [DB_SISCOB].[ADM].[TB_APP_CONTROLE] WHERE [TIPO] = 'CENARIO_FILE_MODEL');
	DECLARE @FILE_DOWNLOAD			VARCHAR(1000); SET @FILE_DOWNLOAD		= (SELECT TOP 1 [DESCRICAO] AS 'FILE_DOWNLOAD' FROM [DB_SISCOB].[ADM].[TB_APP_CONTROLE] WHERE [TIPO] = 'CENARIO_DOWNLOAD');
	DECLARE @FILE_DOWNLOAD_TMP		VARCHAR(100);  SET @FILE_DOWNLOAD_TMP	= LEFT(@FILE_DOWNLOAD,LEN(@FILE_DOWNLOAD)-1) +'\'
	
	DECLARE @FILE_EXIT_TMP			VARCHAR(1000); SET @FILE_EXIT_TMP		= @RAIZ_GRUPO + '_' + @FILE_EXIT;
	DECLARE @RETURN_ID_FILE			VARCHAR(1000); --SET @RETURN_ID_FILE		= (SELECT TOP 1 [ID] AS 'ID' FROM [DB_SISCOB].[APP_WEB].[TBL_ARQUIVOS_TRANSITO_CENARIOS] WHERE [nm_arquivo] = @FILE_EXIT_TMP ORDER BY [ID] DESC);

-- ##################################
-- COPIA DE ARQUIVO MODELO
-- ##################################
	SET @Cmd = 'COPY ' + @FILE_MODEL_PATH + @FILE_MODEL + ' ' + @FILE_DOWNLOAD_TMP + @FILE_EXIT_TMP ;
	--PRINT @Cmd  
	EXEC xp_cmdshell @Cmd,no_output	


-- ###################################################################################################################################################################################
-- ###################################################################################################################################################################################
-- [2] -> CADASTRA ARQUIVO COM DADOS CARRAGADOS
-- ###################################################################################################################################################################################
-- ###################################################################################################################################################################################


  INSERT INTO [APP_WEB].[TBL_ARQUIVOS_TRANSITO_CENARIOS]
           ([nm_arquivo]
           ,[diretorio]
           )
     VALUES
           (@FILE_EXIT_TMP
           ,@FILE_DOWNLOAD
           )

-- ###################################################################################################################################################################################
-- ###################################################################################################################################################################################
-- [3] -> CARREGAR DADOS EM ARQUIVO COPIADO
-- ###################################################################################################################################################################################
-- ###################################################################################################################################################################################

-- #########################
-- EXPORTAR DADOS
-- #########################
	
	SET @SQL = 'INSERT INTO OPENROWSET(''Microsoft.ACE.OLEDB.12.0'',''Excel 12.0 Xml;HDR=YES;IMEX=0;Database=' + @FILE_DOWNLOAD_TMP + @FILE_EXIT_TMP  + ''',''SELECT * FROM [Dados$]'') '

	SET @QUERY = 'SELECT PROCV '
	SET @QUERY = @QUERY + '		,ID '
	SET @QUERY = @QUERY + '		,NOME_ANALISTA '
	SET @QUERY = @QUERY + '		,NOME_ANALISTA_TMP '
	SET @QUERY = @QUERY + '		,FEEDBACK '
	SET @QUERY = @QUERY + '		,AREA_OFENSORA '
	SET @QUERY = @QUERY + '		,TIPO_PAGTO '
	SET @QUERY = @QUERY + '		,DT_PAGTO '
	SET @QUERY = @QUERY + '		,REPLACE(CONVERT(VARCHAR(20),VALOR_PAGTO),''.'','','') '
	SET @QUERY = @QUERY + '		,DT_AJUSTE '
	SET @QUERY = @QUERY + '		,REPLACE(CONVERT(VARCHAR(20),VALOR_AJUSTADO),''.'','','') '
	SET @QUERY = @QUERY + '		,RESUMO_EXECUTIVO_ACAO '
	SET @QUERY = @QUERY + '		,RESUMO_EXECUTIVO_PROBLEMA '
	SET @QUERY = @QUERY + '		,'''' AS HISTORICO_DETALHADO '
	SET @QUERY = @QUERY + '		,DT_FOLLOW_UP '
	SET @QUERY = @QUERY + '		,DT_ENCERRAMENTO '
	SET @QUERY = @QUERY + '		,DT_CONTATO '
	SET @QUERY = @QUERY + '		,RESPONSAVEL '
	SET @QUERY = @QUERY + '		,FAIXA_FORNECEDOR '
	SET @QUERY = @QUERY + '		,FAIXA_FECHO '
	SET @QUERY = @QUERY + '		,FAIXA_ARRECADA_INICIAL '
	SET @QUERY = @QUERY + '		,FAIXA_ARRECADA_ATUAL '
	SET @QUERY = @QUERY + '		,RAIZ_GRUPO '
	SET @QUERY = @QUERY + '		,GRUPO '
	SET @QUERY = @QUERY + '		,RAIZ '
	SET @QUERY = @QUERY + '		,CNPJ '
	SET @QUERY = @QUERY + '		,NOME '
	SET @QUERY = @QUERY + '		,NOME_CLIENTE '
	SET @QUERY = @QUERY + '		,TIPO '
	SET @QUERY = @QUERY + '		,EMPRESA '
	SET @QUERY = @QUERY + '		,CONTA '
	SET @QUERY = @QUERY + '		,TEL '
	SET @QUERY = @QUERY + '		,LOCAL '
	SET @QUERY = @QUERY + '		,TERMINAL '
	SET @QUERY = @QUERY + '		,DV '
	SET @QUERY = @QUERY + '		,NRC '
	SET @QUERY = @QUERY + '		,CLASSERV '
	SET @QUERY = @QUERY + '		,TITULO '
	SET @QUERY = @QUERY + '		,FILIAL '
	SET @QUERY = @QUERY + '		,LJ_CLI '
	SET @QUERY = @QUERY + '		,COD_CLI '
	SET @QUERY = @QUERY + '		,DOCUMENTO_SAP '
	SET @QUERY = @QUERY + '		,DOC_FAT '
	SET @QUERY = @QUERY + '		,N_DOC_DE_PARA_ATLYS '
	SET @QUERY = @QUERY + '		,NOTA_FISCAL '
	SET @QUERY = @QUERY + '		,VENC_ATUAL '
	SET @QUERY = @QUERY + '		,VENC_ORIGINAL '
	SET @QUERY = @QUERY + '		,DT_PROCESS '
	SET @QUERY = @QUERY + '		,ANOMES '
	SET @QUERY = @QUERY + '		,DIA_VENCIMENTO_LOTE '
	SET @QUERY = @QUERY + '		,NUMERO_LOTE '
	SET @QUERY = @QUERY + '		,REPLACE(CONVERT(VARCHAR(20),VALOR_LOTE),''.'','','') '
	SET @QUERY = @QUERY + '		,REPLACE(CONVERT(VARCHAR(20),SALDO_CAR_26),''.'','','')  '
	SET @QUERY = @QUERY + '		,REPLACE(CONVERT(VARCHAR(20),SALDO_CAR_05),''.'','','')  '
	SET @QUERY = @QUERY + '		,REPLACE(CONVERT(VARCHAR(20),SALDO_CAR_14),''.'','','') '
	SET @QUERY = @QUERY + '		,REPLACE(CONVERT(VARCHAR(20),SALDO_CAR_21),''.'','','')  '
	SET @QUERY = @QUERY + '		,REPLACE(CONVERT(VARCHAR(20),SALDO_CAR_25),''.'','','')  '
	SET @QUERY = @QUERY + '		,REPLACE(CONVERT(VARCHAR(20),SALDO_TOTAL),''.'','','')  '
	SET @QUERY = @QUERY + '		,REPLACE(CONVERT(VARCHAR(20),SOMA_FXE_PDD_26),''.'','','')  '
	SET @QUERY = @QUERY + '		,REPLACE(CONVERT(VARCHAR(20),SOMA_FXE_PDD_05),''.'','','')  '
	SET @QUERY = @QUERY + '		,REPLACE(CONVERT(VARCHAR(20),SOMA_FXE_PDD_14),''.'','','')  '
	SET @QUERY = @QUERY + '		,REPLACE(CONVERT(VARCHAR(20),SOMA_FXE_PDD_21),''.'','','')  '
	SET @QUERY = @QUERY + '		,REPLACE(CONVERT(VARCHAR(20),SOMA_FXE_PDD_25),''.'','','')  '
	SET @QUERY = @QUERY + '		,REPLACE(CONVERT(VARCHAR(20),VALOR_PAGAMENTO),''.'','','')  '
	SET @QUERY = @QUERY + '		,REPLACE(CONVERT(VARCHAR(20),VALOR_AJUSTE),''.'','','')  '
	SET @QUERY = @QUERY + '		,REPLACE(CONVERT(VARCHAR(20),SALDO_ATUAL),''.'','','')  '
	SET @QUERY = @QUERY + '		,CICLO '
	SET @QUERY = @QUERY + '		,UF '
	SET @QUERY = @QUERY + '		,STATUS '
	SET @QUERY = @QUERY + '		,CLASSE '
	SET @QUERY = @QUERY + '		,SEGMENTO_GERENCIA '
	SET @QUERY = @QUERY + '		,GN '
	SET @QUERY = @QUERY + '		,GV '
	SET @QUERY = @QUERY + '		,DIRETOR '
	SET @QUERY = @QUERY + '		,ANALISTA_TLF_VIVO '
	SET @QUERY = @QUERY + '		,INTRAGOV '
	SET @QUERY = @QUERY + '		,INTERCOMPANY '
	SET @QUERY = @QUERY + '		,FEEDBACK_00 '
	SET @QUERY = @QUERY + '		,FEEDBACK_01 '
	SET @QUERY = @QUERY + '		,FEEDBACK_02 '
	SET @QUERY = @QUERY + '		,FEEDBACK_03 '
	SET @QUERY = @QUERY + '		,FEEDBACK_04 '
	SET @QUERY = @QUERY + '		,FEEDBACK_05 '
	SET @QUERY = @QUERY + '		,PENDENTE_ID_ANALISE_CONTA '
	SET @QUERY = @QUERY + '		,PENDENTE_DATA_ANALISE_CONTA '
	SET @QUERY = @QUERY + '		,CONCLUIDO_ID_ANALISE_CONTA '
	SET @QUERY = @QUERY + '		,CONCLUIDO_DATA_ANALISE_CONTA '
	SET @QUERY = @QUERY + '		,REABERTO_ID_ANALISE_CONTA '
	SET @QUERY = @QUERY + '		,REABERTO_DATA_ANALISE_CONTA '
	SET @QUERY = @QUERY + '		,QTD_REG_AGRUPADO '
	SET @QUERY = @QUERY + '		,DT_ULT_ALTERACAO '
	SET @QUERY = @QUERY + '		,USUARIO_ATUALIZACAO '
	SET @QUERY = @QUERY + '		,ID_ANALISTA '
	SET @QUERY = @QUERY + '		,ID_ANALISTA_TMP '
	SET @QUERY = @QUERY + '		,AREA_ATUACAO '
	SET @QUERY = @QUERY + '		,TASK_FORCE '
	SET @QUERY = @QUERY + '		,SEG_DESCR '
	SET @QUERY = @QUERY + '		,PARCELAMENTO '
	SET @QUERY = @QUERY + '		,ESCALATION '
	SET @QUERY = @QUERY + '	FROM [APP_EXCEL].[VW_CONSUMO_CONSOLIDADO_ANALISTA] '
	SET @QUERY = @QUERY + '	WHERE ' 
	SET @QUERY_WHERE_TMP = @QUERY_WHERE

	SET @SQL = @SQL + @QUERY + @QUERY_WHERE
	INSERT INTO [APP_WEB].[TBL_ARQUIVOS_TRANSITO_CENARIOS] ([QUERY_RESUMO]) VALUES (@SQL);
	--PRINT @SQL
	EXEC(@SQL) 
	

		   	
-- ###################################################################################################################################################################################
-- ###################################################################################################################################################################################
-- [4] -> OK
-- ###################################################################################################################################################################################
-- ###################################################################################################################################################################################
	
	SET @RETURN_ID_FILE		= (SELECT TOP 1 [ID] AS 'ID' FROM [DB_SISCOB].[APP_WEB].[TBL_ARQUIVOS_TRANSITO_CENARIOS] WHERE [nm_arquivo] = @FILE_EXIT_TMP ORDER BY [ID] DESC);
	SET @ID_FILE = @RETURN_ID_FILE

END

