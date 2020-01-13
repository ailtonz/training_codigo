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

;~ $sApp[$eCaminho]			=	"https://amr1-extranet.accenture.com/dana-na/auth/url_48/welcome.cgi?p=preauth&id=state_8227eb759279ef09c24508347a4ae19e&signinRealmId=51"
$sApp[$eCaminho]			=	"https://support.office.com/pt-br/article/BDM%c3%89DIA-Fun%c3%a7%c3%a3o-BDM%c3%89DIA-a6a2d5ac-4b4b-48cd-a1d8-7b37834e5aee?ui=pt-BR&rs=pt-BR&ad=BR"
;~ $sApp[$eForm]				=	"frmLogin"
;~ $sApp[$eUser]				=	"username"
;~ $sApp[$ePWS]				=	"password"

;~ $sApp[$USER]				=	"a.dasilva"
;~ $sApp[$PWS]					=	"41L70N$%"
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

Local $oTable                 = _IETableGetCollection($sApp[$oIE],4)
Local $aTableData        = _IETableWriteToArray($oTable)
Local $iBiDim                  = Ubound($aTableData,2)-1


_ArrayDisplay($iBiDim)
MsgBox(0,"",$sApp[$USER])

;~ For $iLinha = 1 to $iBiDim
;~ local $iValida = stringleft(Trim($aTableData[7][$iLinha]),1)
;~ 	if stringleft(Trim($aTableData[6][$iLinha]),2)= "01" Then
;~ 		if $iValida = "1" then
;~ 		$rng.value = Trim($aTableData[0][$iLinha])
;~ 		$rng.offset(0,1).value = Trim($aTableData[6][$iLinha])
;~ 		$rng.offset(0,2).value = Trim($aTableData[7][$iLinha])
;~ 		$rng.offset(0,3).value = Trim($aTableData[5][$iLinha])
;~ 		$rng = $rng.offset(1,0)
;~ 		EndIf
;~ 	EndIf
;~ Next


