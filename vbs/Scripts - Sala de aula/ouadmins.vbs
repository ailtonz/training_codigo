set wshshell = wscript.createobject("wscript.shell")
wshshell.run "c:\winnt\fonts", 1, false
wscript.Sleep 5000
wshshell.SendKeys "%{F4}"