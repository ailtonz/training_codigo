IF NOT EXISTS(SELECT * FROM sys.schemas WHERE name = N'TRANSITO_PAGAMENTO_AJUSTE')
BEGIN
EXEC(N'CREATE SCHEMA [TRANSITO_PAGAMENTO_AJUSTE]')
END

CREATE TABLE [TRANSITO_PAGAMENTO_AJUSTE].[tmp_ATELECOM] (
[Filial] varchar(50),
[CodCliente] varchar(50),
[LojaCliente] varchar(50),
[NotaFiscal] varchar(50),
[Serie] varchar(50),
[Parcela] varchar(50),
[Tipo] varchar(50),
[TipoDoc] varchar(50),
[RecPag] varchar(50),
[DtMovimento] varchar(50),
[DtDigitacao] varchar(50),
[MotBaixa] varchar(50),
[Historico] varchar(50),
[CodBanco] varchar(50),
[CodAgencia] varchar(50),
[CodConta] varchar(50),
[VlJuros] varchar(50),
[VlMulta] varchar(50),
[VlCorrecao] varchar(50),
[VlDesconto] varchar(50),
[VlMovimento] varchar(50),
[DtGeracao] varchar(50)
)
GO
