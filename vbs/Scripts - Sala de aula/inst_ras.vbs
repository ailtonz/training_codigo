set objnet=wscript.createobject("wscript.network")
set wshshell=wscript.createobject("wscript.shell")

if objnet.computername = "VANCOUVER" then
wshshell.run "c:\tools\vancert.cmd",6 , true
End if

if objnet.computername = "LISBON" then
wshshell.run "c:\tools\liscert.cmd", 6, true
end if

if objnet.computername = "BANGALORE" then
wshshell.run "c:\tools\bancert.cmd", 6, true
end if

if objnet.computername = "LIMA" then
wshshell.run "c:\tools\limcert.cmd", 6, true
end if

if objnet.computername = "CASABLANCA" then
wshshell.run "c:\tools\cascert.cmd", 6, true
end if

if objnet.computername = "PERTH" then
wshshell.run "c:\tools\percert.cmd", 6, true
end if

wscript.quit  