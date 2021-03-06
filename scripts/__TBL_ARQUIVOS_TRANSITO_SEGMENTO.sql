/****** Script for SelectTopNRows command from SSMS  ******/
SELECT *
  FROM  [DB_SISCOB].[APP_WEB].[TBL_ARQUIVOS_TRANSITO_SEGMENTO]
  order by id desc

  update [DB_SISCOB].[APP_WEB].[TBL_ARQUIVOS_TRANSITO_SEGMENTO] set HISTORICO=1 where historico = 0

  INSERT INTO [APP_WEB].[TBL_ARQUIVOS_TRANSITO_SEGMENTO]
           ([arquivo]
           ,[diretorio]
           ,[segmento]
           ,[dt_atualizacao]
		   ,[HISTORICO])
		select
				'FOCO_VPE_DEMAIS_FIXA_MOVEL_CAR_14_04_CRIADO_EM_20170428_0729.7z'
				,'\\172.16.0.11\siscob\SEGMENTO\'
				,'VPE_DEMAIS'
				,getdate()
				,0
		union select 'FOCO_INTERCOMPANY_FIXA_MOVEL_CAR_14_04_CRIADO_EM_20170428_0735.7z'
				,'\\172.16.0.11\siscob\SEGMENTO\'
				,'INTERCOMPANY'
				,getdate()
				,0
		union select 'FOCO_VPE_TASKFORCE_FIXA_MOVEL_CAR_14_04_CRIADO_EM_20170428_0736.7z'
				,'\\172.16.0.11\siscob\SEGMENTO\'
				,'VPE_TASKFORCE'
				,getdate()
				,0
		union select 'FOCO_VPG_FIXA_MOVEL_CAR_14_04_CRIADO_EM_20170428_0738.7z'
				,'\\172.16.0.11\siscob\SEGMENTO\'
				,'VPG'
				,getdate()
				,0
		union select 'FOCO_VPK_FIXA_MOVEL_CAR_14_04_CRIADO_EM_20170428_0741.7z'
				,'\\172.16.0.11\siscob\SEGMENTO\'
				,'VPK'
				,getdate()
				,0