/****** Script for SelectTopNRows command from SSMS  ******/
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
  FROM [DB_SISCOB_HML].[APP_WEB].[TBL_USUARIOS]
  WHERE 
  [fname] like '%ale%'
  --id_user=9