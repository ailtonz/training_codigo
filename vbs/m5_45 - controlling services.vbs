
'o objeto lanmanserver deve ser usado logo ap�s o nome do servidor
'se a pasta j� estiver compartilhada ser� feito um 2� compartilhamento para a pasta

set oserver = getobject("WinNT://london/LANMANSERVER")
SET OSHARE = oserver.create("fileshare", "home_folder")
oshare.path= "c:\user"
oshare.description = "Share de teste"
oshare.maxusercount = 5
oshare.setinfo

set oshell = createobject("wscript.shell")
oshell.Run ("\\london\home_folder")
wscript.Sleep 3000

wscript.Echo "Usu�rios conectados: " & oshare.currentusercount