USE [DB_SISCOB_HML]
GO
/****** Object:  StoredProcedure [FILE_CAR].[PRC_ENREQUECIMENTO_MOVEL_WEB_FORNECEDOR]    Script Date: 2/10/2017 9:48:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



 --==========================================================================
 --Author:		Alencar, Luiz
 --Create date: 2016-09-14
 --Obs> : O processo de inserção guardará histórico mensal dos registros
 --Sempre que iniciar um periodo novo (CAR 26) Iniciará um novo preenchimento
 --==========================================================================
ALTER PROCEDURE [FILE_CAR].[PRC_ENREQUECIMENTO_MOVEL_WEB_FORNECEDOR] 

AS
BEGIN
		
	-- Verificar a data do Car que foi importado por ultimo 	
	DECLARE @sDiaCar AS CHAR(2)
	SET @sDiaCar = (SELECT TOP 1 DESCRICAO_02 FROM [DB_SISCOB].[ADM].[TB_APP_CONTROLE] ORDER BY ID DESC)
   
   	IF @sDiaCar = '26'
   		BEGIN
   				TRUNCATE TABLE [DB_SISCOB].[AUXILIAR].[VW_VIVO_CARTEIRA];
   		END
   	
   	ELSE
   		BEGIN
   				UPDATE [DB_SISCOB].[FILE_CAR].[TB_TRATAMENTO_MOVEL_WEB] SET FORNECEDOR =  NULL ;
   				
   				UPDATE M SET 
   							M.FORNECEDOR =  C.FORNECEDOR
   				FROM 
   								[DB_SISCOB].[AUXILIAR].[VW_VIVO_CARTEIRA] C 
					INNER JOIN	[DB_SISCOB].[FILE_CAR].[TB_CAR_MOVEL_IMPORT] MI ON C.CONTA = MI.CONTA AND C.DT_PROCESS = MI.DT_PROCESS
					INNER JOIN	[DB_SISCOB].[FILE_CAR].[TB_TRATAMENTO_MOVEL_WEB] M	ON MI.ID  = M.ID_IMPORT_MOVEL
				WHERE 
					M.OK = 1;
					
					
				UPDATE M SET 
							M.FORNECEDOR = C.FORNECEDOR
				FROM
							
							[DB_SISCOB].[FILE_CAR].[TB_TRATAMENTO_MOVEL_WEB] M
				INNER JOIN  [DB_SISCOB].[FILE_CAR].[TB_CAR_MOVEL_IMPORT] MI ON M.ID_IMPORT_MOVEL = MI.ID
				INNER JOIN	(
								SELECT 
										DISTINCT 
												 C.RAIZ_GRUPO
												,C.FORNECEDOR
								FROM
										[DB_SISCOB].[FILE_CAR].[TB_TRATAMENTO_MOVEL_WEB] C
										INNER JOIN  [DB_SISCOB].[FILE_CAR].[TB_CAR_MOVEL_IMPORT] MI ON C.ID_IMPORT_MOVEL = MI.ID
								WHERE
										FORNECEDOR IS NOT NULL
										AND NOT FORNECEDOR = 'IP'
										and CONTA='2030786020'
								
							) C ON M.RAIZ_GRUPO = C.RAIZ_GRUPO
	
				WHERE 
							OK = 1
							
							AND M.FORNECEDOR IS NULL
							AND M.GRUPO_ANALISE = 'ATIVO'
   		
   		END
END

