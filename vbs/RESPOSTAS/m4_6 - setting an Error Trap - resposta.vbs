dim letra
letra = "C:"

set objdrive = createobject("scripting.filesystemobject")
set hd = objdrive.GetDrive(letra)

if hd.drivetype = 0 then
	strTipo = "Desconhecido"
elseif hd.drivetype = 1 then
	strTipo = "Removable"
elseif hd.drivetype = 2 then
	strTipo = "Fixed"
elseif hd.drivetype = 3 then
	strTipo = "Network"
elseif hd.drivetype = 4 then
	strTipo = "CD-ROM"
else
	strTipo = "RAM Disk"
end if

wscript.Echo "Drive " & letra & " � :", vbnewline, _
	"Sistema de Arquivos: ", hd.filesystem , vbnewline, _
	"Tipo: ", strTipo, vbnewline , _
	"Nome: " , hd.VolumeName
