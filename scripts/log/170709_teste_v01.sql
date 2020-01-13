declare @qry 					varchar(max);
declare @ID_FOCO_FEEDBACK 		varchar(50); SET @ID_FOCO_FEEDBACK 	=	null
declare @ID_TIPO_PGTO 			varchar(50); SET @ID_TIPO_PGTO 		=	'0'
declare @ID_ANALISTA 			varchar(50); SET @ID_ANALISTA 			=	'0'
declare @DT_FOLLOW 				varchar(50); SET @DT_FOLLOW 			=	'0'
declare @DT_CONTATO 			varchar(50); SET @DT_CONTATO 			=	'0'
declare @DT_PGTO 				varchar(50); SET @DT_PGTO 				=	null
declare @RESPONSAVEL 			varchar(50); SET @RESPONSAVEL 			=	null
declare @RE_PRBLMA 				varchar(50); SET @RE_PRBLMA 			=	null
declare @RE_ACAO 				varchar(50); SET @RE_ACAO 				=	null
declare @HD 					varchar(50); SET @HD 					=	null
declare @CBPM 					varchar(50); SET @CBPM 					=	null
declare @ID_PORTAL_DEMANDA 		varchar(50); SET @ID_PORTAL_DEMANDA 	=	null
declare @NUMERO_BOLETO 			varchar(50); SET @NUMERO_BOLETO 		=	null
declare @DATA_EMISSAO_BOLETO 	varchar(50); SET @DATA_EMISSAO_BOLETO	=	null
declare @ID_GESTAO_CONTA 		varchar(50); SET @ID_GESTAO_CONTA 		=	null
declare @OBS 					varchar(50); SET @OBS 					=	null
declare @CRITERIO 				varchar(max);  SET @CRITERIO 					=	'WHERE ( ID_ANALISTA = 9 OR ID_ANALISTA_TMP = 9) AND RAIZ_GRUPO = ''4060701190'' and ID_TIPO IN (7,9) and ID_AREA_OFENSORA IN (1,2,3,7)'

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
		,' + @ID_FOCO_FEEDBACK + '
		,' + @ID_TIPO_PGTO + '
		,' + @ID_ANALISTA + '
		,GETDATE()
		,' + @DT_FOLLOW + '
		,' + @DT_CONTATO + '
		,' + @DT_PGTO + '
		,[SALDO_CAR]
		,0
		,Replace(' + @RESPONSAVEL + ','';'','''')
		,Replace(' + @RE_PRBLMA + ','';'','''')			
		,Replace(' + @RE_ACAO + ','';'','''')			
		,CONVERT(VARCHAR(10),CONVERT(DATE,GETDATE())) + '' - '' + Replace(' + @HD + ' ,'';'','''')
		,' + @CBPM + '
		,' + @ID_PORTAL_DEMANDA + '
		,' + @NUMERO_BOLETO + '
		,' + @DATA_EMISSAO_BOLETO + '
		,' + @ID_GESTAO_CONTA + '
		,Replace(' + @OBS + ','';'','''')
	 FROM
		[DB_SISCOB].[APP_WEB].[VW_FILTRO_DINAMICO] ' + @CRITERIO + ';'
print @qry

--EXEC(@qry) 
