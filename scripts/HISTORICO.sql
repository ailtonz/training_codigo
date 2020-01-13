SELECT Q.[ID]
      ,Q.[ID_CONSOLIDADO]
      ,[ID_SEMANA]
      ,[ID_FOCO_FEEDBACK]
      ,[ID_TIPO_PAGAMENTO]
      ,Q.[ID_ANALISTA]
      ,[TIME_STAMP]
      ,[DT_FOLLOW]
      ,[DT_CONTATO]
      ,[DT_ENCERRAMENTO]
      ,[DT_ABERTURA]
      ,[DT_AJUSTE]
      ,[DT_PAGAMENTO]
      ,[VALOR_PAGO]
      ,[VALOR_AJUSTE]
      ,[LOTE]
      ,[GESTAO_CONTA]
      ,[RESPONSAVEL]
      ,[RESUMO_EXECUTIVO]
      ,[HISTORICO_DETALHADO]
      ,[STATUS]

       INTO [SISCOB_TRANSITO].[dbo].[HISTORICO]
  FROM 
                                  [SISCOB_TRANSITO].[dbo].[Query]                                    Q 
             INNER JOIN  [SISCOB_TRANSITO].[CONSOLIDADO].[TB_CONSUMO_SISCOB] CS ON Q.ID_CONSOLIDADO = CS.ID_CONSOLIDADO

  ORDER BY ID DESC
