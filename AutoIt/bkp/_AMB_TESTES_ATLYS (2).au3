#include <Array.au3>
#include <WinAPISys.au3>
#include "funcoes_ATLYS_150618-1745.au3"


#Region PreSets
HotKeySet("^{end}", "CaptureEsc")
Opt("GUIOnEventMode",1)
#EndRegion


Global Enum $eAutomatioName,$eDirectory,$eSleepTime,$eCNTA,$eUSER,$ePWS
Global $sApp[6]

$sApp[$eAutomatioName]		=	"ROBO - MANUTEN��O DE PACOTES DE DADOS"
$sApp[$eDirectory]			=	@ScriptDir
$sApp[$eSleepTime]			=	1000
$sApp[$eCNTA]				=	2124837356
$sApp[$eUSER]				=	"80187511"
$sApp[$ePWS]				=	"Val@2015"


global $hWnd = WinWait("[REGEXPTITLE:" & "Atlys Global Solution" & ".+]")

if $hWnd <> 0 Then

	WinActivate("[REGEXPTITLE:" & "Atlys" & ".+]")

	_ShowStatus("MAXIMIZAR APLICA��O")
	MouseMove(740, 15)
	MouseClick("left")

	_ShowStatus("LIMPAR PESQUISA ANTIGA SE HOUVER")
	_CLIENTE_PESQUISA_FECHAR($sApp[$eSleepTime])

	_ShowStatus("INICIO DO PROCESSO - PESQUISA CLIENTE")
	_CLIENTE_PESQUISA($sApp[$eCNTA],$sApp[$eSleepTime])

	_ShowStatus("MAXIMIZAR - PESQUISA CLIENTE")
	_PESQUISA_MAXIMIZAR(667,101,$sApp[$eSleepTime])

	_ShowStatus("OPERACOES EM LOTES")
	_OPERACOES_LOTE(1174,810,$sApp[$eSleepTime])

	_ShowStatus("SELECIONAR CONTA EM LOTES")
	_CONTAS_LOTE(125,185,$sApp[$eSleepTime])

	_ShowStatus("LISTA DE ASSINATURAS")
	_MARCACAO_CORINGA(688,817,$sApp[$eSleepTime])

;~ >>>>>>>>>>>>>
;~ >>>>>>>>>>>>>	SELECIONAR TERMINAIS
;~ >>>>>>>>>>>>>

	_ShowStatus("SELECIONAR TERMINAL")
	_MARCACAO_CORINGA(240,183,$sApp[$eSleepTime])

;~ >>>>>>>>>>>>>
;~ >>>>>>>>>>>>>	SELECIONAR TERMINAIS
;~ >>>>>>>>>>>>>


	_ShowStatus("OPERACOES EM LOTES")
	_MARCACAO_CORINGA(714,804,$sApp[$eSleepTime])

	_ShowStatus("ADICIONAR/TROCAR/ALTERAR SERVI�OS")
	_MARCACAO_CORINGA(728,827,$sApp[$eSleepTime])

	_ShowStatus("ASSOCIA��O DE SERVI�OS AT� LIMITE PADR�O")
	Sleep(2000)
	SendWait($sApp[$eUSER],$sApp[$eSleepTime])
	SendWait("{TAB}",$sApp[$eSleepTime])
	SendWait($sApp[$ePWS],$sApp[$eSleepTime])
	SendWait("{TAB}",$sApp[$eSleepTime])
	SendWait("{ENTER}",$sApp[$eSleepTime])

;~ >>>>>>>>>>>>>
;~ >>>>>>>>>>>>>	OPERA��ES
;~ >>>>>>>>>>>>>

	_ShowStatus("OPERA��ES - ADICIONAR")
	_MARCACAO_CORINGA(39,168,$sApp[$eSleepTime])

	_ShowStatus("ASSOCIA��O DE SERVI�OS AT� LIMITE PADR�O")
	Sleep(3000)
	SendWait($sApp[$eUSER],$sApp[$eSleepTime])
	SendWait("{TAB}",$sApp[$eSleepTime])
	SendWait($sApp[$ePWS],$sApp[$eSleepTime])
	SendWait("{TAB}",$sApp[$eSleepTime])
	SendWait("{ENTER}",$sApp[$eSleepTime])

	Sleep(3000)
	_ShowStatus("OPERA��ES - EXCLUIR")
	_MARCACAO_CORINGA(38,197,$sApp[$eSleepTime])

	Sleep(3000)
	_ShowStatus("OPERA��ES - ALTERA��O")
	_MARCACAO_CORINGA(368,168,$sApp[$eSleepTime])


;~ >>>>>>>>>>>>>
;~ >>>>>>>>>>>>>	OPERA��ES
;~ >>>>>>>>>>>>>


;~ 	_ShowStatus("OPERACOES EM LOTES")
;~ 	_OPERACOES_LOTE(993,806,$sApp[$eSleepTime])

;~ 	_ShowStatus("OPERACOES EM LOTES")
;~ 	_MARCACAO_CORINGA(999,828,$sApp[$eSleepTime])

global $hWnd2 = WinActivate("[REGEXPTITLE:" & "Atlys" & ".+]")
;~ global $hWnd2 = WinWait("[REGEXPTITLE:" & "Manute��o" & ".+]")

MsgBox(0,"$hWnd",$hWnd2)
Local $aData = _WinAPI_EnumChildWindows($hWnd2)
MsgBox(0,"fase02","fase02")

_ArrayDisplay($aData, '_WinAPI_EnumChildWindows')
MsgBox(0,"fase03","fase03")

MsgBox(0,"__FIM__","FIM")



EndIf