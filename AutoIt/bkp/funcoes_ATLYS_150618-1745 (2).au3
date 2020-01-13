#include-Once
#include "funcoes_UTIL_150730-1507.au3"

Func _CLIENTE_PESQUISA($CD_CNTA,$SleepTime)
   ; ABRIR PESQUISA DE CLIENTE / CONTA
   SendWait("{f4}",$SleepTime)

   ; NUM ACESSO E ID DO CLI
   SendWait("{TAB}",$SleepTime,5)
   SendWait("{DOWN}",$SleepTime)

   ; NOME
   SendWait("{TAB}",$SleepTime,6)
   SendWait("{DOWN}",$SleepTime)

   ; PESQUISA POR: >>>> NUMERO DA CONTA <<<<
   SendWait("{TAB}",$SleepTime,9)
   SendWait("{DOWN}",$SleepTime)

   ; [CD_CNTA]
   SendWait($CD_CNTA,$SleepTime)
   SendWait("{TAB}",$SleepTime)
   SendWait("{ENTER}",$SleepTime)

;~    ; VISUALIZAR
;~    SendWait("{tab}",$SleepTime,3)
;~    SendWait("{ENTER}",$SleepTime)
   EndFunc

Func _CONTA_PROTEGIDA_SENHA($xPosicao,$yPosicao,$SleepTime)
   ; CONTA PROTEGIDA POR SENHA
   Sleep($SleepTime)
   MouseMove($xPosicao,$yPosicao)
   MouseClick("left")
   EndFunc

Func _NOTAS_CONTA_FECHAR($xPosicao,$yPosicao,$SleepTime)
	; FECHAR - NOTAS DA CONTA
	Sleep($SleepTime)


	MouseMove($xPosicao,$yPosicao)
	MouseClick("left")
   EndFunc

Func _NOTAS_CONTA_ABRIR($xPosicao,$yPosicao,$SleepTime)
   ; ABRIR - NOTAS DA CONTA
	Sleep($SleepTime)

   MouseMove($xPosicao,$yPosicao)
   MouseClick("left")
EndFunc

Func _NOTAS_CONTA_OK($xPosicao,$yPosicao,$SleepTime)
	; OK - NOTAS DA CONTA

	Sleep($SleepTime)

	MouseMove($xPosicao,$yPosicao)
	MouseClick("left")
EndFunc

Func _NOTAS_CONTA_TIPO($sMsg, $SleepTime, $iSleep=500)
	; TIPOS DE NOTAS
	Sleep($SleepTime)

	For $x = 1 to StringLen($sMsg)
		Sleep($iSleep)
		SendWait(StringMid($sMsg,$x,1),$iSleep)
	Next

	SendWait("{ENTER}",$iSleep)
   EndFunc


Func _ASSINATURAS_ABRIR($NR_TLFN,$xPosicao,$yPosicao,$xNR_TLFN,$yNR_TLFN,$SleepTime)
   Sleep($SleepTime)

	; ASSINATURAS
;~ 	SendWait("{tab}",$SleepTime,13)
;~ 	SendWait("{ENTER}",$SleepTime)
	MouseMove($xPosicao,$yPosicao)
	MouseClick("left")

	Sleep($SleepTime)

   ; NUM. ACESSO.
;~    EXIT
	MouseMove($xNR_TLFN,$yNR_TLFN)
	MouseClick("left")
	SendWait($NR_TLFN,$SleepTime)

   ; PESQUISAR
   SendWait("{ENTER}",$SleepTime)

   ; INICIA A PESQUISAR
   SendWait("{tab}",$SleepTime,3)
   SendWait("{ENTER}",$SleepTime)
   EndFunc

Func _PROGRAMA_MARKETING_SELECAO($xPosicao,$yPosicao,$xCURSOR,$yCURSOR,$SleepTime)
   Sleep($SleepTime)

   ; POSICIONA O CURSOR
;~    SendWait("{tab}",$SleepTime,4)
	MouseMove($xCURSOR,$yCURSOR)
	MouseClick("left")

   ; ABRIR LISTA
;~    SendWait("!{DOWN}",$SleepTime)

   ; SELECIONAR INSCRICAO NO PROGRAMA DE MARKETING
   Sleep($SleepTime)
   MouseMove($xPosicao,$yPosicao)
   MouseClick("left")
   EndFunc

Func _PROGRAMA_MARKETING_ADICIONAR($iSelecao, $SleepTime, $iSleep=500)
   Sleep($SleepTime)

   ; ADICIONAR
;~    SendWait("^{A}",$SleepTime)
   SendWait("{ENTER}",$iSleep)

   ; SELEÇÃO DE ITEM
   SendWait("{S}",$iSleep)
   SendWait("{E}",$iSleep)
   SendWait("{R}",$iSleep)
   SendWait("{V}",$iSleep)
   SendWait("{I}",$iSleep)
   SendWait("{DOWN}",$iSleep * $iSelecao,$iSelecao)
   SendWait("{TAB}",$iSleep,2)
   SendWait("{ENTER}",$iSleep)
   EndFunc

Func _PROGRAMA_MARKETING_EXCLUIR($iExclusoes,$xSelecionar,$ySelecionar,$xExcluir,$yExcluir,$SleepTime)
   Sleep($SleepTime)

   for $x = 0 to $iExclusoes
	  ; SELECIONAR PROGRAMA DE MARKETING
	  MouseMove($xSelecionar,$ySelecionar)
	  MouseClick("left")

	  ; EXCLUIR
	  Sleep($SleepTime)
	  MouseMove($xExcluir,$yExcluir)
	  MouseClick("left")
   next
   EndFunc

Func _PROGRAMA_MARKETING_ABRIR($xPosicao,$yPosicao,$SleepTime)
   ; ABRIR JANELA
;~    Sleep($SleepTime)
   WinWaitActive("[REGEXPTITLE: Inscrição no programa de marketing .+]", "",10)
   MouseMove($xPosicao,$yPosicao)
   MouseClick("left")
   EndFunc

Func _PROGRAMA_MARKETING_FECHAR($xPosicao,$yPosicao,$SleepTime)
   ; FECHAR JANELA
   Sleep($SleepTime)
   MouseMove($xPosicao,$yPosicao)
   MouseClick("left")
   EndFunc

Func _CLIENTE_PESQUISA_FECHAR($SleepTime)
	SendWait("{F4}",$SleepTime)
	SendWait("^{F4}",$SleepTime)
	EndFunc

Func _PESQUISA_CRITERIOS_MENSAGEM($xPosicao,$yPosicao,$SleepTime)
	; FECHAR JANELA
	Sleep($SleepTime)
	MouseMove($xPosicao,$yPosicao)
	MouseClick("left")
	EndFunc

Func _PESQUISA_MAXIMIZAR($xPosicao,$yPosicao,$SleepTime)
	Sleep($SleepTime)
	MouseMove($xPosicao,$yPosicao)
	MouseClick("left")
	EndFunc

Func _OPERACOES_LOTE($xPosicao,$yPosicao,$SleepTime)
	Sleep($SleepTime)
	MouseMove($xPosicao,$yPosicao)
	MouseClick("left")
	EndFunc

Func _CONTAS_LOTE($xPosicao,$yPosicao,$SleepTime)
	Sleep($SleepTime)
	MouseMove($xPosicao,$yPosicao)
	MouseClick("left")
	EndFunc

Func _ADICIONAR_REMOVER_MARKETING($xPosicao,$yPosicao,$SleepTime)
	Sleep($SleepTime)
	MouseMove($xPosicao,$yPosicao)
	MouseClick("left")
	EndFunc

Func _MARCACAO_CORINGA($xPosicao,$yPosicao,$SleepTime)
	Sleep($SleepTime)
	MouseMove($xPosicao,$yPosicao)
	MouseClick("left")
	EndFunc
