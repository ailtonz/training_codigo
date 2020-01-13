#include <File.au3>
#include <IE.au3>

#include "funcoes_UTIL_160223-1642.au3"

Global Enum $eAutomatioName,$USER,$PWS,$eCaminho,$eForm,$eUser,$ePWS,$oIE,$oForm,$o_txt_user,$o_txt_pwd,$hFile,$s_Directory,$data,$eSleepTime
Global $sApp[15]

;~ #[CFG]##########################################################################################################################################

;~ $sApp[$eAutomatioName]		=	"ROBO - LOGIN APP CITRIX"
;~ $sApp[$data]				=	@YEAR&@MON&@MDAY&"_"&@HOUR&@MIN
;~ $sApp[$s_Directory]			= 	@ScriptDir
;~ $sApp[$hFile] 				= 	FileOpen($sApp[$s_Directory] & "\" & StringReplace(@ScriptName,".exe","") & "_" & $sApp[$data] & ".log", 1)
$sApp[$eSleepTime]		=	1000

;~ #[CFG]##########################################################################################################################################

;~ #[APP]##########################################################################################################################################

$sApp[$eCaminho]			=	"http://vivocorp.vivo.com.br/vivocorp/start.swe?SWECmd=Start&SWEHo=vivocorp.vivo.com.br"
$sApp[$eForm]				=	"SWEEntryForm"
$sApp[$eUser]				=	"SWEUserName"
$sApp[$ePws]				=	"SWEPassword"

$sApp[$User]				=	"A5128875"
$sApp[$Pws]					=	"Senha@2017"
$sApp[$oIE]					=	_IECreate($sApp[$eCaminho])

;~ #[APP]##########################################################################################################################################

; Altera para 50 milisegundos o intervalo entre as teclas digitadas
Opt("SendKeyDelay", 50)

;Liga a opc de eventos de controle
Opt("GUIOnEventMode",1)

;Quando pressionar a tecla 'END' sai da rotina
HotKeySet("^{END}", "CaptureEND")


connectApp($sApp[$oIE],$sApp[$eForm],$sApp[$eUser],$sApp[$ePws],$sApp[$User],$sApp[$Pws])


;~ ################################################################################################################################
;~ ################################################################################################################################
;~ ################################################################################################################################



;~ ### PEDIDOS
   _MARCACAO_CORINGA(477,126,$sApp[$eSleepTime])



;~ ### PESQUISA PEDIDOS
   _MARCACAO_CORINGA(1001,241,$sApp[$eSleepTime])
   ;~ ### INICIA A PESQUISA
   SendWait("{ENTER}",$sApp[$eSleepTime])

;~ ### SELECAO DE PEDIDOS
   _MARCACAO_CORINGA(81,223,$sApp[$eSleepTime])


;~ ### 2a GUIA - ATIVIDADES
   _MARCACAO_CORINGA(635,427,$sApp[$eSleepTime]+1000)


;~ ### FUNCIONARIO
   ;~ ### NOME
   _MARCACAO_CORINGA(1173,535,$sApp[$eSleepTime])
   ;~ ### SELEÇAO DE FUNCIONARIO
   _MARCACAO_CORINGA(1244,535,$sApp[$eSleepTime])

;~ ### FUNCIONARIO
;~ _MARCACAO_CORINGA(635,427,$sApp[$eSleepTime])



;~ ################################################################################################################################
;~ ################################################################################################################################
;~ ################################################################################################################################


PosicionamentoXY($sApp[$oIE])




;~ exit


Func CaptureEND()
 Switch @HotKeyPressed ; The last hotkey pressed.
	 Case "^{END}" ; String is the {END} hotkey.
   Exit
 EndSwitch
EndFunc

;~ Func connectApp($oIE,$eForm,$eUser,$ePws,$User,$Pws)
;~    Sleep(2000)

;~    _IELoadWait($oIE)

;~    local $oForm	=	_IEFormGetObjByName($oIE, $eForm)
;~    local $oUser	=	_IEFormElementGetObjByName($oForm, $eUser)
;~    local $oPwd	=	_IEFormElementGetObjByName($oForm, $ePws)

;~    _IEFormElementSetValue($oUser, $User)
;~    _IEFormElementSetValue($oPwd, $Pws)
;~    _IEFormSubmit($oForm)

;~    local $HWND = _IEPropertyGet($oIE, "hwnd")
;~    WinSetState($HWND, "", @SW_MAXIMIZE)

;~ EndFunc

;~ func PosicionamentoXY($oIE)
;~    local $hWnd = _IEPropertyGet($oIE, "hwnd")
;~    WinActivate($hWnd)

;~    While WinExists($hWnd)
;~ 	  ;Captura o tamanho da tela
;~ 	  local $aClientSize = WinGetClientSize($hWnd)

;~ 	  local $aPos = MouseGetPos()
;~ 	  ToolTip($aClientSize[0] & "x" & $aClientSize[1] & @CR & "x: " & $aPos[0] & @CR & "y: " & $aPos[1], Default, Default, Default, Default, 4)
;~ 	  Sleep(100)
;~    WEnd
;~ EndFunc