

;~ $handle = WinGetHandle("")
;~ $iPID = Run(@ProgramFilesDir & '\Mozilla Firefox\firefox.exe "http://google.com"', '', @SW_SHOWNOACTIVATE)
;~ WinActivate (HWnd($handle))


#include "funcoes_UTIL_160223-1642.au3"

; Altera para 50 milisegundos o intervalo entre as teclas digitadas
Opt("SendKeyDelay", 50)

;Liga a opc de eventos de controle
Opt("GUIOnEventMode",1)

;Quando pressionar a tecla 'END' sai da rotina
HotKeySet("^{END}", "CaptureEND")


$handle = WinGetHandle("")
$iPID = Run(@ProgramFilesDir & '\Mozilla Firefox\firefox.exe "http://google.com"', '', @SW_SHOWNOACTIVATE)
WinActivate (HWnd($handle))
