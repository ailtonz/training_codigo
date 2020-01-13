
set usuario = getobject("LDAP://cn=administrator,cn=users,dc=nwtraders,dc=msft")
usuario.getinfo
wscript.Echo "Existem " & usuario.propertycount & " propriedades para o objeto " & usuario.adspath

for x=0 to usuario.propertycount-1
	txt = txt & usuario.item(cint(x)).name & " / " & usuario.get(usuario.item(cint(x)).name) & vbnewline
	if err.number <> 0 then 
	oerro = oerro & usuario.item(cint(x)).name & vbnewline
	end if
next


'wscript.Echo "Propriedades que aceitam GET: " & vbnewline & txt

'wscript.Echo "Propriedades que não aceitam GET: " & vbnewline & oerro

set fso = createobject("scripting.filesystemobject")
set arq = fso.createtextfile("c:\x.txt")
arq.writeline(txt & vbnewline & vbnewline & vbnewline & oerro)
arq.close

set oshell = createobject("wscript.shell")
oshell.run "notepad c:\x.txt",3