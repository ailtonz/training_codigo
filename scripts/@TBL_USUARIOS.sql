/****** ADM - USUÁRIOS  ******/
SELECT TOP 1000 [id_user]
      ,[eid]
      ,[psw]
      ,[fname]
      ,[lname]
      ,[telefone]
      ,[ramal]
      ,[cargo]
      ,[area]
      ,[email]
      ,[bloqueado]
      ,[inativo]
  FROM [DB_SISCOB].[APP_WEB].[TBL_USUARIOS] 
  where 
  --id_user = 50
  [fname] like '%aman%'
  --where [fname] = 'nadia do nascimento (74)'
