set wshshell = CreateObject("Wscript.shell")
wshshell.currentDirectory = "C:\Program Files\Msdntrain\2663\Labfiles\VDirs"
wshshell.Run "cscript.exe makevdir.vbs", 6, true