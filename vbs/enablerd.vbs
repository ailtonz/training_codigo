'=============================================================================================
'
'                CONECTAR COM UM �NICO DISCO E VERIFICAR SE ESTA PRONTA
'
'
'=============================================================================================
'set fso = createobject("scripting.filesystemobject")
'set disco = fso.GetDrive("A:")
'if disco.IsReady = 0 then
'wscript.Echo "Drive n�o esta pronto"
'else
'wscript.Echo 	"Letra: " ,disco.DriveLetter,vbnewline,_
'				"Nome: " ,disco.VolumeName,vbnewline,_
'				"Tamanho: ",formatnumber(disco.TotalSize/1073741824,2),"GB",vbnewline,_
'				"Espa�o Livre: ",formatnumber(disco.FreeSpace/1073741824,2),"GB",vbnewline,_
'				"Tipo de Sistema: ",disco.FileSystem,vbnewline,_
'				"N�mero de S�rie: ",disco.SerialNumber
'				
'end if				
'============================================================================================
'Acessar todos os discos da M�quina
'============================================================================================
'set fso = createobject("scripting.filesystemobject")
'set coldiscos = fso.Drives

'for each hd in coldiscos
'wscript.Echo hd.DriveLetter
'next 'pega todos na sequencia



