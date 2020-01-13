use DB_SISCOB
go
CREATE TABLE [TRANSITO].[tmp_TB_HISTORICO](
	[ID] [bigint] NOT NULL,
	[ID_CONSOLIDADO] [bigint] NOT NULL,
	[ID_SEMANA] [bigint] NOT NULL,
	[ID_FOCO_FEEDBACK] [bigint] NOT NULL,
	[ID_TIPO_PAGAMENTO] [bigint] NULL,
	[ID_ANALISTA] [bigint] NOT NULL,
	[TIME_STAMP] [datetime] NOT NULL,
	[DT_FOLLOW] [date] NULL,
	[DT_CONTATO] [date] NULL,
	[DT_ENCERRAMENTO] [date] NULL,
	[DT_ABERTURA] [date] NULL,
	[DT_AJUSTE] [date] NULL,
	[DT_PAGAMENTO] [date] NULL,
	[VALOR_PAGO] [decimal](18, 2) NULL,
	[VALOR_AJUSTE] [decimal](18, 2) NULL,
	[LOTE] [varchar](max) NULL,
	[GESTAO_CONTA] [varchar](max) NULL,
	[RESPONSAVEL] [varchar](max) NULL,
	[RESUMO_EXECUTIVO] [varchar](max) NULL,
	[HISTORICO_DETALHADO] [varchar](max) NULL,
	[STATUS] [bit] NULL
)


alter table [TRANSITO].[tmp_TB_HISTORICO] alter column [STATUS] nvarchar(1)