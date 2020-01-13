set a = getobject("winmgmts:win32_service.name='Alerter'")
for each x in a.properties_
txt = txt & x.name & "  -  "  & x.value & vbnewline
next
wscript.Echo txt