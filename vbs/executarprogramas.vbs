' VB Script Document
option explicit

Set excel = CreateObject("Excel.Application")
Set pasta = excel.WorkBooks.Add()
Set planilha = pasta.WorkSheets("Plan1")

planilha.Range("A2").Value = 2
planilha.Range("A3").Value = 5

excel.Visible = True

MsgBox planilha.Range("A3").Value