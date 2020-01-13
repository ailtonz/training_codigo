const ADS_SERVICE_RUNNING = &H4
dim ocomputer, service, lista
set ocomputer = getobject("WinNT://London")
lista = "Os serviços da máquina " & ocomputer.adspath &" são: " & vbnewline & vbnewline
for each service in ocomputer
	if service.class = "Service" then
		if service.status = ADS_SERVICE_RUNNING then
		     lista = lista & service.name  & " - Executando." & vbnewline
		else
		     lista = lista & service.name & " - Parado."& vbnewline
		end if
	end if
next
wscript.Echo lista

'----------------------------------------------------------------------------------------------------------------------------
set servico = GetObject("WinNT://london")

for each s in servico 
obj = obj & s.name &";"&  s.class & vbcrlf
	if s.name = "Alerter" then
		if s.status = 4 then
		    s.stop
		    msg="O serviço " & s.name &" foi Parado."
		else if s.status = 1 then
		    s.start
		    msg="O serviço " & s.name &" foi Iniciado."
		end if
		end if
	     wscript.echo msg
	end if
next

set fso = createobject("scripting.filesystemobject")
set result = fso.createtextfile("c:\resultado.txt",true)
result.writeline(obj)
result.close

set oshell = createobject("wscript.shell")
oshell.Run "notepad c:\resultado.txt"

