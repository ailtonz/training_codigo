-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [APP_WEB].[PRC_GRAVAR_FATURAS_new]
(
	@CRITERIO VARCHAR(MAX),
	@ID_FOCO_FEEDBACK VARCHAR(1000),
	@ID_TIPO_PGTO VARCHAR(1000),
	@ID_ANALISTA VARCHAR(1000),
	@DT_FOLLOW VARCHAR(1000),
	@DT_CONTATO VARCHAR(1000),
	@DT_PGTO VARCHAR(1000),
	@RESPONSAVEL VARCHAR(1500),
	@RE_PRBLMA VARCHAR(1500),
	@RE_ACAO VARCHAR(1500),
	@HD VARCHAR(1500),
	@CBPM VARCHAR(50),
	@ID_PORTAL_DEMANDA VARCHAR(1000),
	@NUMERO_BOLETO VARCHAR(1000),
	@DATA_EMISSAO_BOLETO VARCHAR(1000),
	@ID_GESTAO_CONTA VARCHAR(1000),
	@OBS VARCHAR(1000),
	@RETORNO int output
)

AS

BEGIN

set nocount on

BEGIN TRY

	DECLARE @qry 					varchar(max);

	if @ID_FOCO_FEEDBACK is null  
	begin
	set @ID_FOCO_FEEDBACK = 'null'
	end

	if @DT_PGTO is null  
	begin
	set @DT_PGTO = 'null'
	end

	if @RESPONSAVEL is null  
	begin
	set @RESPONSAVEL = 'null'
	end

	if @RE_PRBLMA is null  
	begin
	set @RE_PRBLMA = 'null'
	end

	if @RE_ACAO is null  
	begin
	set @RE_ACAO = 'null'
	end

	if @HD is null  
	begin
	set @HD = 'null'
	end

	if @CBPM is null  
	begin
	set @CBPM = 'null'
	end

	if @ID_PORTAL_DEMANDA is null  
	begin
	set @ID_PORTAL_DEMANDA = 'null'
	end

	if @NUMERO_BOLETO is null  
	begin
	set @NUMERO_BOLETO = 'null'
	end

	if @DATA_EMISSAO_BOLETO is null  
	begin
	set @DATA_EMISSAO_BOLETO = 'null'
	end

	if @ID_GESTAO_CONTA is null  
	begin
	set @ID_GESTAO_CONTA = 'null'
	end

	if @OBS is null  
	begin
	set @OBS = 'null'
	end

SET @qry = 'INSERT INTO [CONSOLIDADO].[TB_HISTORICO] 
	 (
		[ID_CONSOLIDADO]
	   ,[ID_SEMANA]
	   ,[ID_FOCO_FEEDBACK]
	   ,[ID_TIPO_PAGAMENTO]
	   ,[ID_ANALISTA]
	   ,[TIME_STAMP]
	   ,[DT_FOLLOW]
	   ,[DT_CONTATO]
	   ,[DT_PAGAMENTO]
	   ,[VALOR_PAGO]
	   ,[VALOR_AJUSTE]   
	   ,[RESPONSAVEL]
	   ,[RE_PROBLEMA]
	   ,[RE_ACAO]
	   ,[HISTORICO_DETALHADO]
	   ,[CBPM]
	   ,[ID_PORTAL_DEMANDA]
	   ,[NUMERO_BOLETO]
	   ,[DATA_EMISSAO_BOLETO]
	   ,[ID_GESTAO_CONTA]
	   ,[OBS]
	 )
	 SELECT
		 ID
		,(SELECT ID FROM AUXILIAR.TB_STATUS_CAR WHERE STATUS = 1)
		, CONVERT(bigint, ' + @ID_FOCO_FEEDBACK + ' ) 
		, CONVERT(bigint, ' + @ID_TIPO_PGTO +') 
		,' + @ID_ANALISTA + '
		,GETDATE()
		, CONVERT(date, ' + @DT_FOLLOW + ', 103)
		, CONVERT(date, ' + @DT_CONTATO +', 103) 
		, CONVERT(date, ' + @DT_PGTO +',  103)
		,[SALDO_CAR]
		,0
		,Replace(' + @RESPONSAVEL + ','';'','''')
		,Replace(' + @RE_PRBLMA + ','';'','''')			
		,Replace(' + @RE_ACAO + ','';'','''')			
		,CONVERT(VARCHAR(10),CONVERT(DATE,GETDATE())) + '' - '' + Replace(' + @HD + ' ,'';'','''')
		,' + @CBPM + '
		,CONVERT(bigint, ' + @ID_PORTAL_DEMANDA + ')
		,CONVERT(bigint, ' + @NUMERO_BOLETO +')
		,CONVERT(date, ' + @DATA_EMISSAO_BOLETO +', 103)
		,CONVERT(bigint, ' + @ID_GESTAO_CONTA + ') 
		,Replace(' + @OBS + ','';'','''')
	 FROM
		[DB_SISCOB].[APP_WEB].[VW_FILTRO_DINAMICO] ' + @CRITERIO + ''

	EXEC(@qry) 

	EXEC [APP_EXCEL].[PRC_UPDATE_CONSOLIDADO_HISTORICO] @ID_ANALISTA;
	
	set @RETORNO = 1 

END TRY

BEGIN CATCH

	set @RETORNO = 0

END CATCH

END
