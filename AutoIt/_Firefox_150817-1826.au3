;~ $FF = @ProgramFilesDir & "\Mozilla Firefox\firefox.exe -new-tab "
;~ $url = "http://10.20.142.117:8081/caixaEntrada/index.jsp?close=1"
;~ Run($FF & $url, "", @SW_MAXIMIZE)


_chamadaStaffMozila("http://vivocorp.vivo.com.br/vivocorp/start.swe?SWECmd=Start&SWEHo=vivocorp.vivo.com.br")


Func _chamadaStaffMozila($sUrl)
   ;Chamada do staffware via FireFox
   Local $sFF = "E:\Program Files (x86)\Mozilla Firefox\firefox.exe -new-tab "
;~    Local $sUrl = "http://10.20.142.117:8081/caixaEntrada/index.jsp?close=1"
   Run($sFF & $sUrl, "", @SW_MAXIMIZE)
EndFunc