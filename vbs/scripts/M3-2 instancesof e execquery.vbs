'============================================================
'definir o direito do script dar shutdown remoto
set objsvc = getobject("winmgmts:{(remoteshutdown)}!\\sanxp")
set objset = objsvc.execquery("select * from win32_operatingsystem where primary='true'")
for each so in objset
	so.reboot
next

'para impedir um privilégio acrescente uma ! antes do nome da constante
'set objsvc = getobject("winmgmts:{(!remoteshutdown)}!\\sanxp")


