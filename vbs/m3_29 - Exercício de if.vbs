'==========================================================================================
'					INSTRU��ES DO LAB
'
' 1� Crie logo abaixo a VARI�VEL txt e a MATRIZ servidores
' 2� Defina os valores da MATRIZ com o nome do seu servidor e o servidor do seu parceiro
' 3� Substitua os textos em colchetes com as fun��es de dimens�o de matriz (lbound(matriz) 
'	e ubound(matriz)) para definir os valores do loop
'
'OBS: OS COMANDOS ABAIXO TRABALHAM COM WMI, QUE VEREMOS MAIS A FRENTE NO CURSO!!!
'==========================================================================================
dim txt 
dim servidores (1)
'servidores = array("london","brisbane")
servidores (0) = "london"
servidores (1) = "perth"

for x = lbound(servidores) to ubound(servidores)
	Set objcol = GetObject("WinMgmts:\\" & servidores(x))
	set coldisk = objcol.InstancesOf("Win32_LogicalDisk")
	txt = txt & vbnewline & "Servidor: " & servidores(x) & vbnewline
	For Each Drive In coldisk
		if not isnull (drive.size) then
			txt = txt & " Drive " & Drive.deviceid & " cont�m " _
			& formatnumber(Drive.Size / 1073741824,2) & " Gb" & vbnewline
		end if
	Next
next
wscript.Echo txt
