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
$sApp[$eSleepTime]		=	2000

;~ #[CFG]##########################################################################################################################################

;~ #[APP]##########################################################################################################################################

$sApp[$eCaminho]			=	"http://vivocorp.vivo.com.br/vivocorp/start.swe?SWECmd=Start&SWEHo=vivocorp.vivo.com.br"
$sApp[$eForm]				=	"SWEEntryForm"
$sApp[$eUser]				=	"SWEUserName"
$sApp[$ePws]				=	"SWEPassword"

$sApp[$User]				=	"A5128875"
$sApp[$Pws]					=	"Senha@2018"
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
   ;~ ### NUMERO DO PEDIDO
   SendWait("1-120192883239",$sApp[$eSleepTime])
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


;~ ### PESUISAR LOGIN PARA APROVAÇAO
;~ _MARCACAO_CORINGA(635,427,$sApp[$eSleepTime])
   ;~ ### SELEÇAO DE LOGIN
   ;~ _MARCACAO_CORINGA(635,427,$sApp[$eSleepTime])
   ;~ ### ADICIONAR
   ;~ _MARCACAO_CORINGA(635,427,$sApp[$eSleepTime])
   ;~ ### MARCAR COMO PRINCIPAL
   ;~ _MARCACAO_CORINGA(635,427,$sApp[$eSleepTime])


;~    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
;~    TEMPORARIO
;~    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

   ;~ ### FECHAR JANELA
   _MARCACAO_CORINGA(1439,315,$sApp[$eSleepTime]+1000)

;~    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
;~    TEMPORARIO
;~    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@


;~ ### INSERIR COMENTÁRIO DE PEDIDO APROVADO
;~ _MARCACAO_CORINGA(253,492,$sApp[$eSleepTime])
;~ SendWait("PEDIDO APROVADO. ** ",$sApp[$eSleepTime])

;~ ### 1a GUIA - ATIVIDADES
   _MARCACAO_CORINGA(562,426,$sApp[$eSleepTime]+1000)

;~ ### AÇAO - MOTIVO DA AÇAO
   ;~ ### AÇAO
   _MARCACAO_CORINGA(1110,513,$sApp[$eSleepTime])
   ;~ ### MOTIVO DA AÇAO
   _MARCACAO_CORINGA(1232,514,$sApp[$eSleepTime])

;~ ### NOVO
_MARCACAO_CORINGA(122,453,$sApp[$eSleepTime])
   ;~ ### NOME DO MODELO
   ;~ _MARCACAO_CORINGA(0,0,$sApp[$eSleepTime])
   ;~ ### CLICAR NA PICK APPLET
   ;~ _MARCACAO_CORINGA(0,0,$sApp[$eSleepTime])


;~ ### PESQUISAR
;~ _MARCACAO_CORINGA(0,0,$sApp[$eSleepTime])
   ;~ ### NOME DO MODELO
   ;~ _MARCACAO_CORINGA(0,0,$sApp[$eSleepTime])
   ;~ SendWait("*EMPRESAS*",$sApp[$eSleepTime])




;~ ################################################################################################################################
;~ ################################################################################################################################
;~ ################################################################################################################################


PosicionamentoXY($sApp[$oIE])




;~ Func CaptureEND()
;~  Switch @HotKeyPressed ; The last hotkey pressed.
;~ 	 Case "^{END}" ; String is the {END} hotkey.
;~    Exit
;~  EndSwitch
;~ EndFunc
