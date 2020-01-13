declare @Comando varchar(max);
		
SET QUOTED_IDENTIFIER OFF
set @Comando = "

"
SET QUOTED_IDENTIFIER ON 

INSERT INTO [ADM].[TB_APP_CONTROLE]
        ([TIPO]
        ,[DESCRICAO]
        ,[DESCRICAO_02]
        ,[DTSUBIDA]
        ,[DESCRICAO_03])
    SELECT 
        'ADM_FOCO_SEGMENTO'
        ,'CADASTRO DE ARQUIVOS EM TABELA DE CONSUMO DA TELA DA APP WEB '
        ,''
        ,GETDATE()
        ,@Comando;

		
SELECT * FROM [DB_SISCOB].[ADM].[TB_APP_CONTROLE] ORDER BY ID DESC