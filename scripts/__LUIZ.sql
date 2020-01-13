
	SELECT 
        ID_CONSOLIDADO
       ,HD = STUFF(
                 (SELECT
                                        '|' + isnull(HISTORICO_DETALHADO, '' )
                             FROM [DB_SISCOB].[CONSOLIDADO].[TB_HISTORICO]
                             
                             where h.ID_CONSOLIDADO  = ID_CONSOLIDADO
                                        
                             ORDER BY ID DESC 
                             FOR XML PATH ('')), 1, 1, ''
                 ) 
   --INTO [DB_SISCOB].[TRANSITO].[HISTORICO_ACUMULADO]
   FROM
             [DB_SISCOB].[CONSOLIDADO].[TB_HISTORICO] H
where h.ID_CONSOLIDADO  = '7597739'
GROUP BY ID_CONSOLIDADO


