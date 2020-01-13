declare @Comando varchar(max);
		
SET QUOTED_IDENTIFIER OFF
set @Comando = "

"
SET QUOTED_IDENTIFIER ON 

INSERT INTO [ADM].[TB_APP_CONTROLE_LOG]
        ([TIPO]
        ,[DESCRICAO]
        ,[DESCRICAO_02]
        ,[DTSUBIDA]
        ,[DESCRICAO_03])
    SELECT 
        'LOG_CENARIO'
        ,'170321_0914_PRC_CENARIO.sql'
        ,''
        ,GETDATE()
        ,@Comando;

SELECT * FROM [DB_SISCOB].[ADM].[TB_APP_CONTROLE_LOG] ORDER BY ID DESC