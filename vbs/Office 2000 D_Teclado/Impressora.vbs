'=================================================================================================
'
'Script para parar, iniciar serviços
'
'=================================================================================================

'set obj = getobject("winmgmts:")

'set svc = obj.execmethod("win32_service.name='Alerter'","stopservice")
'wscript.Echo "Microsoft Avisa : Serviço Parado"

'=================================================================================
'
'
'
'==================================================================
set obj = getobject("winmgmts:\\london")
set servico = obj.execquery("select * from win32_process")
for each s in servico
txt = txt & s.name & "   " &  s.   & vbnewline
next
wscript.Echo txt