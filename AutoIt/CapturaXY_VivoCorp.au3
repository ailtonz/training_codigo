#include <GUIConstantsEx.au3> ; constante para GUI eventos
#include <MsgBoxConstants.au3>
#include <IE.au3>


;Liga a opção de eventos de controle
Opt("GUIOnEventMode",1)

;Quando pressionar a tecla 'END' sai da rotina
HotKeySet("{END}", "CaptureEND")



$oIE = _IECreate()
If Not IsObj($oIE) Then
   MsgBox($MB_ICONERROR, @ScriptName, "Erro na abertura do Internet Explorer (" & @error & ")")
   Exit
EndIf

_IENavigate($oIE, "http://vivocorp.vivo.com.br/vivocorp/start.swe?SWECmd=Start&SWEHo=vivocorp.vivo.com.br",1)
_IELoadWait($oIE)

$hWnd = WinWait("VivoCorp")
WinActivate($hWnd)
;Aguarda ativação da janela por 30 segundos
If WinWaitActive($hWnd, "",30) = 0 Then
   MsgBox($MB_ICONERROR, @ScriptName, "Erro na abertura do sistema VivoCorp")
   Exit
EndIf

;Maximiza a janela do VivoCorp
WinSetState($hWnd,"",@SW_MAXIMIZE)

While WinExists($hWnd)
   ;Captura o tamanho da tela
   $aClientSize = WinGetClientSize($hWnd)

   $aPos = MouseGetPos()
   ToolTip($aClientSize[0] & "x" & $aClientSize[1] & @CR & "x: " & $aPos[0] & @CR & "y: " & $aPos[1], Default, Default, Default, Default, 4)
   Sleep(100)
WEnd


Func CaptureEND()
 Switch @HotKeyPressed ; The last hotkey pressed.
	 Case "{END}" ; String is the {END} hotkey.
   Exit
 EndSwitch
EndFunc
