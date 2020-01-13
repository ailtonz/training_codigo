USE [DB_G_CASH_BBRIL]
GO

/****** Object:  Table [sch_Carga].[Tbl_Import_Car_BomBril_temp]    Script Date: 4/26/2017 6:30:35 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO
--DROP TABLE [sch_Carga].[Tbl_Import_Car_BomBril_temp]
CREATE TABLE [sch_Carga].[Tbl_Import_Car_BomBril_temp](
	ID			INT IDENTITY(1, 1) NOT NULL,
	[DT_CARGA]	DATETIME DEFAULT GETDATE() NOT NULL,
	[COD_EMPRESA] INT NOT NULL,
	[Cliente] [varchar](20) NULL,
	[CL] [int] NULL,
	[Tipo] [varchar](50) NULL,
	[Nº doc ] [bigint] NULL,
	[DocCompens] [varchar](50) NULL,
	[Atribuição] [varchar](50) NULL,
	[Referência] [varchar](50) NULL,
	[BancEmpr] [varchar](50) NULL,
	[ChvRefer 3] [bigint] NULL,
	[ Vt] [varchar](50) NULL,
	[Data doc ] [varchar](50) NULL,
	[VencLíquid] [varchar](50) NULL,
	[   Mont em MI] [varchar](50) NULL,
	[CPgt] [varchar](50) NULL,
	[Compensaç ] [varchar](50) NULL,
	[Texto] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	ID ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]


GO

SET ANSI_PADDING OFF
GO


