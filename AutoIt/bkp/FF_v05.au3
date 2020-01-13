#include "funcoes_UTIL_160223-1642.au3"


Global Enum $eAutomatioName,$USER,$PWS,$eCaminho,$eForm,$eUser,$ePWS,$oIE,$oForm,$o_txt_user,$o_txt_pwd,$hFile,$s_Directory,$data,$eSleepTime
Global $sApp[15]
$sApp[$eSleepTime]			=	1000
$sApp[$eCaminho]			=	"http://vivocorp.vivo.com.br/vivocorp/start.swe?SWECmd=Start&SWEHo=vivocorp.vivo.com.br"

$sApp[$eForm]				=	"SWEEntryForm"
$sApp[$eUser]				=	"SWEUserName"
$sApp[$ePws]				=	"SWEPassword"

$sApp[$USER]				=	"A5128875"
$sApp[$PWS]					=	"Senha@2017"


; Altera para 50 milisegundos o intervalo entre as teclas digitadas
Opt("SendKeyDelay", 50)

;Liga a opc de eventos de controle
Opt("GUIOnEventMode",1)

;Quando pressionar a tecla 'END' sai da rotina
HotKeySet("^{END}", "CaptureEND")


_chamadaStaffMozila($sApp[$eCaminho])

;~ SendWait($sApp[$USER], $sApp[$eSleepTime])
;~ SendWait("{TAB}", $sApp[$eSleepTime])
;~ SendWait($sApp[$PWS], $sApp[$eSleepTime])
;~ SendWait("{ENTER}", $sApp[$eSleepTime])

Func _chamadaStaffMozila($sUrl)
   ;Chamada do staffware via FireFox
   Local $sFF = "C:\Program Files (x86)\Mozilla Firefox\firefox.exe -new-tab "
   Run($sFF & $sUrl, "", @SW_MAXIMIZE)

   Local $hWnd = WinWait("[REGEXPTITLE:" & "Firefox" & ".+]")

   if $hWnd <> 0 Then
	  WinActivate("[REGEXPTITLE:" & "Atlys" & ".+]")
;~ 	  WinSetState($HWND, "", @SW_MAXIMIZE)
   EndIf

EndFunc