'==========================================================================
'Assim que for criado o processo calc.exe ele ser� finalizado
'e o script ser� finalizado e com ele o consumer de evento
'

'set wqlquery = getobject("Winmgmts:").execnotificationquery _
'("select * from __instancecreationevent within 1" _
'& " where targetinstance isa 'win32_process' and targetinstance.name='calc.exe'") 
'set processos = wqlquery.nextevent
'processos.targetinstance.terminate()

'wscript.Echo "Foi finalizado o programa: " , processos.targetinstance.name


'==========================================================================
'
'
'
set EventSource = getobject("Winmgmts:").execnotificationquery _
("select * from __instancecreationevent within 1 " _
& "where targetinstance isa 'win32_PrintJob' group within 20 by targetinstance.owner having numberofevents > 2") 
set proc_adm = EventSource.nextevent

wscript.Echo proc_adm.targetinstance.document
