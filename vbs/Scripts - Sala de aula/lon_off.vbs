Dim IE
Set IE = CreateObject("InternetExplorer.Application")
ie.left=0
ie.top=0
ie.height=570
ie.width=800
ie.menubar=0
ie.toolbar=0
ie.addressbar=0
ie.statusbar=0
ie.navigate "file:///c:\setup\instruct\lon_gui.htm"
ie.visible=1



Set WshShell = WScript.CreateObject("WScript.Shell")
WshShell.run "c:\setup\images\display.vbs", 6, true

Set WshShell = WScript.CreateObject("WScript.Shell")
WshShell.run "c:\setup\instruct\lonset2.cmd", 6, true