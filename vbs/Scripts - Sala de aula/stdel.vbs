'this file sets lon_gui.vbs to start at next bootup. This happens right after the running of this
'file at first launch from the run once line in the unattend file. This is needed so that Lon_gui.vbs
'is not launched until the full interface is launched so that tasks that may be required of the user
'may be performed.

set fso = createobject("scripting.filesystemobject")
set strt = fso.getfolder("C:\Documents and Settings\All Users\Menu Iniciar\Programas\Inicializar")
fn = "runnext.vbs"
set nxt = fso.getfile("c:\setup\instruct\lon_gui.vbs")
set fl = fso.createtextfile(strt & "\" & fn, true)
fl.writeline("set wshshell = wscript.createobject" & chr(40) & chr(34) & "wscript.shell" & chr(34) & chr(41))
fl.writeline("wshshell.run " & chr(34) & nxt & chr(34))
fl.Close


'Disable the IE Enhanced Security Configuration message box
Set WshShell = WScript.CreateObject("WScript.Shell")
WshShell.RegWrite "HKLM\Software\Microsoft\Windows\CurrentVersion\Internet Settings\IEHardenIENoWarn", 000000001 ,"REG_DWORD"
