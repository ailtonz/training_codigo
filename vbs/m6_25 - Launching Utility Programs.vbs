'-----------------------------------------------------------------------------------------
'criando/listando/excluindo mapeamento de impressora
'-----------------------------------------------------------------------------------------

set onet = createobject("wscript.network")
onet.AddPrinterConnection "LPT3:", "\\london\epson"
onet.AddWindowsPrinterConnection "\\london\epson","Epson Stylus COLOR 440 ESC/P 2"
for each p in onet.EnumPrinterConnections
wscript.Echo p
next

resposta = msgbox("Deseja remover a impressora Epson da porta LPT3: ?",vbquestion+vbyesno,"")
if resposta = vbyes then onet.RemovePrinterConnection "LPT3:"

'para mais informações veja creating objects pag-m2_12.vbs
