set wshshell = createobject("wscript.shell")
set fso = createobject("scripting.FileSystemObject")
'delete existing Vs98ent.stf from install share
fso.DeleteFile "\\London\vb\setup\Vs98ent.stf", true

'copy custom Vs98ent.stf to install share
fso.CopyFile "\\London\setup\Vs98ent.stf", "\\london\vb\setup\Vs98ent.stf", true

wshshell.run "\\london\vb\smsinst.exe /k 4601111111", 6, true
wshshell.run "\\london\setup\waitvb.vbs", 6, true