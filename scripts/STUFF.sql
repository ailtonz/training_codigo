SELECT 

       MAX(ID)
FROM
       [DB_SISCOB].[CONSOLIDADO].[TB_HISTORICO]
GROUP BY
       ID



Comando

SELECT 
        ID_CONSOLIDADO
       ,HD = STUFF(
                 (SELECT
                                        '|' + HISTORICO_DETALHADO 
                             FROM [DB_SISCOB].[CONSOLIDADO].[TB_HISTORICO]
                             
                              
                                        
                             ORDER BY ID DESC 
                             FOR XML PATH ('')), 1, 1, ''
                 ) 
   INTO [DB_SISCOB].[TRANSITO].[HISTORICO_ACUMULADO]
   FROM
             [DB_SISCOB].[CONSOLIDADO].[TB_HISTORICO] H

   GROUP BY ID_CONSOLIDADO







   select ID_CONSOLIDADO, HISTORICO_DETALHADO, ROW_NUMBER() over (partition by ID_CONSOLIDADO order by ID_CONSOLIDADO) id_part into TB_HISTORICO_partition   from  [DB_SISCOB].[CONSOLIDADO].[TB_HISTORICO]