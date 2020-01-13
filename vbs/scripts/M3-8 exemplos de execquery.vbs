'==========================================================================
'instancesof retorna todas as instâncias de um onjeto collection
'Ex: listar todos os programas instalados

for each soft in getobject("Winmgmts:").instancesof("win32_product")
	txt = txt & soft.name  & " - " & soft.installdate & vbnewline
next
wscript.Echo txt


'==========================================================================
'execquery retorna todas as instâncias de um objeto collection mas
'aceita critérios para poder filtrar o resultado
'Ex: listar todos os programas que foram instalados no dia 30/06/2003

set objsvc = getobject("Winmgmts:")
set objprod = objsvc.execquery("select * from win32_product where installdate = 20030630")
for each soft in objprod
	txt2 = txt2 & soft.name  & " - " & soft.installdate & vbnewline
next
wscript.Echo txt2