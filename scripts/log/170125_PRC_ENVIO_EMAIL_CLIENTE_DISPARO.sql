USE [DB_SISCOB_HML]
GO
/****** Object:  StoredProcedure [APP_WEB].[PRC_ENVIO_EMAIL_CLIENTE_DISPARO]    Script Date: 1/25/2017 4:38:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [APP_WEB].[PRC_ENVIO_EMAIL_CLIENTE_DISPARO] 
	 @RAIZ_GRUPO	VARCHAR(1000)
	,@RAIZES		VARCHAR(MAX)
	,@ID_ANALISTA   VARCHAR(4)
	,@TO			VARCHAR(1000)
	,@COPY			VARCHAR(1000)
	,@ANEXO			VARCHAR(1000)
	,@bRaiz			BIT
	,@Nome_Grupo    VARCHAR(1000)
	,@NomeAnalista  VARCHAR(1000)
	,@TelAnalista	VARCHAR(1000)
AS

BEGIN

	SET NOCOUNT ON

    DECLARE  @Sql		VARCHAR(MAX)
			,@TIPO_SUM	VARCHAR(MAX)
			,@TIPO		VARCHAR(MAX)
			,@T			VARCHAR(MAX)
			,@TOTAL		VARCHAR(MAX)
			,@TI		VARCHAR(MAX)
			,@Body		VARCHAR(MAX)
			,@TableTail VARCHAR(MAX)
			,@TableHead VARCHAR(MAX)
			,@AssuntoEmail VARCHAR(1000)
			,@MailTo    VARCHAR(100);
	
	----------------------------------------------------------
	--Limpar tabela para inicio do processo de envio de e-mail
	----------------------------------------------------------
	TRUNCATE TABLE [TRANSITO].[tmpXmlEnvioEmail];

	----------------------------------------------------------------------------------------------
	-- Identificar a abertura por tipo que consta na condicao cadastrada pelo usuário
	----------------------------------------------------------------------------------------------
	SET @TIPO = 'INSERT INTO [TRANSITO].[tmpXmlEnvioEmail] ([TIPO],[XmlColumn]) VALUES (''TIPO'',
				 STUFF(
						(SELECT DISTINCT 
											'',['' + CONVERT(NVARCHAR(200),TIPO) + '']'' 
							FROM 
								[APP_WEB].[VW_CONSUMO_ANALITICO] 
							WHERE
								RAIZ_GRUPO = ''' + @RAIZ_GRUPO + '''
							AND (ID_ANALISTA = ' + @ID_ANALISTA + ' OR ID_ANALISTA_TMP = ' + @ID_ANALISTA + ')
							AND SALDO_ATUAL > 0'

							if @bRaiz = 0 
							BEGIN
								SET @TIPO = @TIPO  + ' AND RAIZ IN (' + @RAIZES + ')'
							END
						
							SET @TIPO = @TIPO  + ' FOR xml path('''')),1,1,''''));'
		EXEC (@TIPO)
	-----------------------------------------------------------------------------------------------

	-----------------------------------------------------------------------------------------------
	-- Montagem dinamica da query a ser disponibilizada no corpo do e-mail
	-----------------------------------------------------------------------------------------------

	SET @TIPO = 'INSERT INTO [TRANSITO].[tmpXmlEnvioEmail] ([TIPO],[XmlColumn]) VALUES (''SUMARIZAR'',
					
					STUFF(
							(SELECT DISTINCT 
										'',format(SUM(ISNULL(['' + CONVERT(NVARCHAR(1000),TIPO) + ''],0)),''''C'''',''''pt-br'''') AS [TD]'' 
							 FROM 
									[APP_WEB].[VW_CONSUMO_ANALITICO] 
							 WHERE
						     RAIZ_GRUPO = ''' + @RAIZ_GRUPO + '''
						AND (ID_ANALISTA = ' + @ID_ANALISTA + ' OR ID_ANALISTA_TMP = ' + @ID_ANALISTA + ')
						AND SALDO_ATUAL > 0'
						
						if @bRaiz = 0 
							BEGIN
								SET @TIPO = @TIPO  + ' AND RAIZ IN (' + @RAIZES + ')'
							END
					 
					     SET @TIPO = @TIPO  + ' FOR xml path('''')),1,1,''''));'
	
	EXEC (@TIPO)
	------------------------------------------------------------------------------------------------


	-----------------------------------------------------------------------------------------------
	-- Montagem dinamica da query a ser disponibilizada para saldo total
	-----------------------------------------------------------------------------------------------
	SET @TIPO = 'INSERT INTO [TRANSITO].[tmpXmlEnvioEmail] ([TIPO],[XmlColumn]) VALUES (''TOTAL'',
		
					 STUFF(
							(SELECT DISTINCT 
								''ISNULL(['' + CONVERT(NVARCHAR(200),TIPO) + ''],0)+'' 
							 FROM 
								[APP_WEB].[VW_CONSUMO_ANALITICO] 
							 WHERE
								RAIZ_GRUPO = '''+ @RAIZ_GRUPO + '''
							AND (ID_ANALISTA = ' + @ID_ANALISTA + ' OR ID_ANALISTA_TMP = ' + @ID_ANALISTA + ')
							AND SALDO_ATUAL > 0'
					
					if @bRaiz = 0 
							BEGIN
								SET @TIPO = @TIPO  + ' AND RAIZ IN (' + @RAIZES + ')'
							END
					 
					 SET @TIPO = @TIPO  + ' FOR xml path('''')),1,0,''''));'
		
		EXEC (@TIPO)
		
		UPDATE [TRANSITO].[tmpXmlEnvioEmail] SET XmlColumn = LEFT(XmlColumn,LEN(XmlColumn)-1) WHERE ID = 3
		UPDATE [TRANSITO].[tmpXmlEnvioEmail] SET XmlColumn =',format(SUM(' + XmlColumn + '),''C'', ''pt-br'') AS [TD]' WHERE ID = 3
		
	------------------------------------------------------------------------------------------------

	-----------------------------------------------------------------------------------------------
	-- Montagem dinamica da query a ser disponibilizada para saldo tags xml
	-----------------------------------------------------------------------------------------------
	SET @TIPO = 'INSERT INTO [TRANSITO].[tmpXmlEnvioEmail] ([TIPO],[XmlColumn]) VALUES (''TAGS'',
					
					STUFF(
							(
								SELECT DISTINCT 
									''#'' + CONVERT(NVARCHAR(200),TIPO) + ''@'' 
								FROM 
									[APP_WEB].[VW_CONSUMO_ANALITICO] 
								
								WHERE
								RAIZ_GRUPO = '''+ @RAIZ_GRUPO + '''
							AND (ID_ANALISTA = ' + @ID_ANALISTA + ' OR ID_ANALISTA_TMP = ' + @ID_ANALISTA + ')
							AND SALDO_ATUAL > 0'
					
							if @bRaiz = 0 
							BEGIN
								SET @TIPO = @TIPO  + ' AND RAIZ IN (' + @RAIZES + ')'
							END
					 
					 SET @TIPO = @TIPO  + ' FOR xml path('''')),1,0,''''));'
	EXEC (@TIPO)
	UPDATE [TRANSITO].[tmpXmlEnvioEmail] SET XmlColumn = REPLACE(XmlColumn,'#','<th width="108px"><b>') where id = 4
	UPDATE [TRANSITO].[tmpXmlEnvioEmail] SET XmlColumn = REPLACE(XmlColumn,'@','</b></th>') where id = 4
	------------------------------------------------------------------------------------------------
	

Set @Sql = 'INSERT INTO [TRANSITO].[tmpXmlEnvioEmail] ([TIPO],[XmlColumn]) SELECT ''XML'',
			  CONVERT(VARCHAR(MAX),(SELECT ISNULL([FAIXA_FORNECEDOR],''TOTAL GERAL'') AS [TD],'

SET @TIPO = (SELECT [XmlColumn] FROM [TRANSITO].[tmpXmlEnvioEmail] WHERE ID = 1)
SET @TIPO_SUM =  (SELECT [XmlColumn] FROM [TRANSITO].[tmpXmlEnvioEmail] WHERE ID = 2)
SET @TOTAL	 =	 (SELECT [XmlColumn] FROM [TRANSITO].[tmpXmlEnvioEmail] WHERE ID = 3)

Set @Sql = @Sql +  @TIPO_SUM + @TOTAL
Set @Sql = @Sql + ' FROM (
							SELECT 
									 ISNULL(W.Faixa_Fornecedor,''TOTAL_GERAL'') AS Faixa_Fornecedor
									,W.TIPO
									,SUM(W.SALDO_ATUAL) AS SALDO_TOTAL 
							FROM
								  [APP_WEB].[VW_CONSUMO_ANALITICO] W
							WHERE 
									W.SALDO_ATUAL > 0
									AND RAIZ_GRUPO = ''' +  @RAIZ_GRUPO + '''
									AND (ID_ANALISTA = ' + @ID_ANALISTA + ' OR ID_ANALISTA_TMP = ' + @ID_ANALISTA + ')'


							IF @bRaiz = 0 
								BEGIN
									set @Sql = @Sql + ' AND RAIZ IN (' + @RAIZES + ')'
								END
set @Sql = @Sql + 'GROUP BY		
									W.Faixa_Fornecedor
									,W.TIPO
							) AS R 
									Pivot (SUM(R.SALDO_TOTAL) FOR R.TIPO IN ('  + @TIPO + ') ) P

	GROUP BY ROLLUP (
			  Faixa_Fornecedor) For XML raw(''tr''), Elements))' 
	
	
	EXEC (@Sql);
	
	SET @TI = (SELECT [XmlColumn] FROM [TRANSITO].[tmpXmlEnvioEmail] WHERE ID = 4)
	SET @MailTo = 'mailto:' + @COPY
	print @MailTo
	Set @TableTail = '</table><font size="4pt" face="Calibri"><p>*Se por ventura o pagamento tenha sido efetuado, favor enviar os comprovantes para conciliação e baixa.</p>' +
					 '<p>**Por favor, não responda este e-mail. Caso haja dúvidas sobre a autenticidade desta mensagem. Contacte o analista informado abaixo.</p>' + 
					 '<br><table style="font-family:Times New Roman;padding-left: 10px;"><tr><td style="font-size:13px;text-align: left;border: none;color:Navy;">' +
					 '<strong>'+ @NomeAnalista +'</strong></td></tr><tr>' +
					 '<td style="font-size:13px;text-align: left;border: none;color:DimGray;">' +
					 '<strong>Accenture Brasil</strong>' +
					 '</td></tr>
					 <tr><td style="font-size:13px;text-align: left;border: none;color:DarkBlue;">
					 <strong>Projeto Telefonica | Analista de relacionamento financeiro</strong></td></tr>
					 <tr><td td style="font-size:13px;text-align: left;border: none;color:DarkBlue"><strong>Tel. ' + @TelAnalista + ' </strong></td></tr>
					 <tr><td style="font-size:13px;text-align: left;border: none;color:DarkBlue"><strong>Rua Brasilio Machado, 355 – 4º andar – São Bernardo do Campo – SP</strong>
					</td></tr>
					<tr><td style="font-size:13px;text-align: left;border: none;color:DarkBlue">
					<a href="' + @MailTo + '"><strong>' + @COPY + ' | </strong></a> 
				<a href="www.accenture.com" target="_blank"><strong>www.accenture.com</strong></a>
			</td>
		</tr>
					 
					 
					 </table></body></html>'
	
	Set @TableHead = '<html><head>' +

	'<style>' +
	'td {text-align: right; border: solid black 1px;padding-left:5px;padding-right:5px;padding-top:1px;padding-bottom:1px;font-size:9pt;color:Black;} th {border: solid black 1px;padding-left:5px;padding-right:5px;padding-top:1px;padding-bottom:1px;font-size:9pt;color:White;background-color: 000000;} table{border-collapse: collapse;}  ' +
	'</style>' +
	'</head>' +
	'<body>' +
	'<font size="4pt" face="Calibri">' +
	'<p><b>Prezado cliente,</b></p>
	<p>Faço parte da área de relacionamento financeiro B2B da Telefonica-Vivo Fixa e Móvel.</p>
	<p>Nesta ocasião, envio o relatório de débitos ao qual não identificamos os pagamentos e que necessitamos de um parecer com urgência para seguir com as ações necessárias de regularização.</p>
	<p>Havendo necessidade de envio de 2ª vias ou boleto, gentileza informar.</p>
	<p>Caso alguma tratativa de contestação tenha sido direcionada a consultoria de relacionamento e você não tenha recebido retorno até esta data, peço que sinalize de imediato para que possamos interagir com a área responsável.</p>
	<p>Caso discorde de algum valor ou alguma fatura, favor solicitar a abertura de protocolo de contestação, direcionando e-mail para a central de relacionamento para FIXA ou Consultor de Relacionamento para Móvel, mantendo-nos em cópia para acompanhamento dos status.</p>
	<p>No prazo de até 10 dias úteis entraremos em contato, com intuito de um retorno sobre os débitos em questão.</p></font>' +
	'<table>' +
	'<tr style="background-color:#000080;">'+
	'<th width="108px"><b>FAIXA DE DIAS EM ATRASO</b></th>' + @TI +
	'<th width="108px"><b>SALDO_TOTAL</b></th></tr>'

	SET @Body = (SELECT XmlColumn FROM [TRANSITO].[tmpXmlEnvioEmail] WHERE ID = 5)
	Set @Body = replace(@Body,'<tr><TD>','<tr><TD style="text-align: left;">')
	Set @Body = @TableHead + @Body + @TableTail
	SET @AssuntoEmail = UPPER('Relatório de débitos ' + @Nome_Grupo + ' serviços Telefonica-Vivo')
	
	EXEC msdb.dbo.sp_send_dbmail
		@profile_name = 'ENVIO_COBRANCA',
		@recipients = @TO,
		@copy_recipients = @COPY,
		@subject = @AssuntoEmail,
		@Body = @Body,
		@file_attachments = @ANEXO,
		@body_format = 'HTML';


END
