set WshShell = CreateObject("WScript.Shell")
WshShell.Run "c:\tools\testroot.cer"

wscript.sleep 5000

WshShell.SendKeys "%i"
WshShell.SendKeys "{ENTER}"
WshShell.SendKeys "%p"
WshShell.SendKeys "%r"

wscript.sleep 5000

WshShell.SendKeys "+{TAB}"
WshShell.SendKeys "+{TAB}"

WshShell.SendKeys "{DOWN}"
WshShell.SendKeys "{ENTER}"
WshShell.SendKeys "%n"
WshShell.SendKeys "{ENTER}"

wscript.sleep 10000

WshShell.AppActivate "Root"
WshShell.SendKeys "%y"

wscript.sleep 2000

WshShell.AppActivate "Certificate Import"
WshShell.SendKeys "{ENTER}"

WshShell.SendKeys "%{F4}"