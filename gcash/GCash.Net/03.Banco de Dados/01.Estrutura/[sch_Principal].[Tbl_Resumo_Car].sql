USE [DB_G_CASH_BBRIL]
GO

/****** Object:  Table [sch_Principal].[Tbl_Resumo_Car]    Script Date: 4/24/2017 4:48:31 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [sch_Principal].[Tbl_Resumo_Car](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ID_CLIENTE] [int] NOT NULL,
	[FAIXA_01] [decimal](18, 2) NULL,
	[FAIXA_02] [decimal](18, 2) NULL,
	[FAIXA_03] [decimal](18, 2) NULL,
	[FAIXA_04] [decimal](18, 2) NULL,
	[FAIXA_05] [decimal](18, 2) NULL,
	[FAIXA_06] [decimal](18, 2) NULL,
	[FAIXA_07] [decimal](18, 2) NULL,
	[FAIXA_08] [decimal](18, 2) NULL,
	[FAIXA_09] [decimal](18, 2) NULL,
	[FAIXA_10] [decimal](18, 2) NULL,
	[FAIXA_TOTAL] [decimal](18, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


