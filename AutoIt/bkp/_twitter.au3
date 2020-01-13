#include <WindowsConstants.au3>
#include <MsgBoxConstants.au3>
#include <GUIConstantsEx.au3> ; constante para GUI eventos
#include <File.au3>
#include <IE.au3>

;Liga a opção de eventos de controle
Opt("GUIOnEventMode",1)

HotKeySet("{Esc}", "CaptureEsc")


Func CaptureEsc()
    Switch @HotKeyPressed ; The last hotkey pressed.
        Case "{ESC}" ; String is the {ESC} hotkey.
	  Exit
    EndSwitch
 EndFunc

Local $oLink = "https://aapj.bb.com.br/aapj/logincor.bb"
;~ Local $oLink = "https://twitter.com/login"

Local $oIE = _IECreate($oLink)
_IELoadWait($oIE)

Sleep(1000)

Send("ailtonzsilva@gmail.com")

send("{TAB}")

Sleep(1000)

Send("")

send("{TAB}")

send("{ENTER}")