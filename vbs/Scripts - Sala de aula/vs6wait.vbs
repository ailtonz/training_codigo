set wshshell = createobject("wscript.shell")
set fso = createobject("scripting.FileSystemObject")

if fso.FolderExists("\\London\vs6") then	
	'delete existing Vs98ent.stf from install share
	fso.DeleteFile "\\London\vs6\setup\Vs98ent.stf", true
	
	'copy custom Vs98ent.stf to install share
	fso.CopyFile "\\London\setup\Vs98ent.stf", "\\London\vs6\setup\Vs98ent.stf", true
	
	wshshell.run "\\London\vs6\smsinst.exe /k 4601111111", 6, true
	wshshell.run "\\London\setup\vs6wait.vbs", 6, true

end if ' if source files were not copied, don't install VS