#include <File.au3>
#include <IE.au3>

#include "funcoes_UTIL_160223-1642.au3"

Global Enum $eAutomatioName,$USER,$PWS,$eCaminho,$eForm,$eUser,$ePWS,$oIE,$oForm,$o_txt_user,$o_txt_pwd,$hFile,$s_Directory,$data
Global $sApp[14]

;~ x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x

;~ #[CFG]##########################################################################################################################################

;~ $sApp[$eAutomatioName]		=	"ROBO - LOGIN APP CITRIX"
;~ $sApp[$data]				=	@YEAR&@MON&@MDAY&"_"&@HOUR&@MIN
;~ $sApp[$s_Directory]			= 	@ScriptDir
;~ $sApp[$hFile] 				= 	FileOpen($sApp[$s_Directory] & "\" & StringReplace(@ScriptName,".exe","") & "_" & $sApp[$data] & ".log", 1)

;~ #[CFG]##########################################################################################################################################

;~ x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x

;~ #[citrixaccenture]##########################################################################################################################################

$sApp[$eCaminho]			=	"http://citrixaccenture.vivo.com.br/Citrix/XenApp/auth/login.aspx"
$sApp[$eForm]				=	"CitrixForm"
$sApp[$eUser]				=	"user"
$sApp[$ePWS]				=	"password"

$sApp[$USER]				=	"80397306"
$sApp[$PWS]					=	"41L70N%!"
$sApp[$oIE]					=	_IECreate($sApp[$eCaminho])

;~ #[citrixaccenture]##########################################################################################################################################

;~ x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x
;~ x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x


; Altera para 50 milisegundos o intervalo entre as teclas digitadas
Opt("SendKeyDelay", 50)

;Liga a opc de eventos de controle
Opt("GUIOnEventMode",1)

;Quando pressionar a tecla 'CTRL+END' sai da rotina
HotKeySet("^{END}", "CaptureEND")


connectApp($sApp[$oIE],$sApp[$eForm],$sApp[$eUser],$sApp[$ePws],$sApp[$User],$sApp[$Pws])

;~ exit

;~ Func CaptureEND()
;~  Switch @HotKeyPressed ; The last hotkey pressed.
;~ 	 Case "^{END}" ; String is the {END} hotkey.
;~    Exit
;~  EndSwitch
;~ EndFunc

