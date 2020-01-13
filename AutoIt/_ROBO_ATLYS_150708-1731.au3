; COMO FUNCIONA: MAIN - (PRINCIPAL) | INTERFACE - (ADM USUÁRIO X ROBO) | VALIDACAO - (VALIDAR DADOS DA INTERFACE) | PRODUCAO - (FUNCOES DO ROBO) | PreSets - (eventos de controle)
; RESOLUÇÃO DE TELA: 1600 x 900 - amb.testes <<<<< DESENVOLVIDO PARA ESTE AMBIENTE >>>>>
; RESOLUÇÃO DE TELA: 1280 x 1024 - amb.usuário


#include <ButtonConstants.au3>
#include <ComboConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <MsgBoxConstants.au3>
#include <StringConstants.au3>
#include <ComboConstants.au3>
#include <GUIConstantsEx.au3>
#include <FileConstants.au3>
#include <Constants.au3>
#include <excel.au3>

#include "funcoes_ATLYS.au3"
#include "funcoes_UTIL.au3"

#Region PreSets
; Quando pressionar a tecla 'Esc' sai da rotina
HotKeySet("{Esc}", "CaptureEsc")

; Liga a opção de eventos de controle
Opt("GUIOnEventMode",1)
#EndRegion

#Region __MAIN

Global $iAutomatioName = "ROBO DESCONTO DE MARKETING"
Global $iMsgTitle = "Automação - " & $iAutomatioName
Global $s_Directory = @ScriptDir
Global $sValidarMarketing = False

Global $SleepTime = 1500

_ShowStatus($ResolucaoTela)

;~ ---------------
;~ AJUSTES
;~ ---------------

;~  NOTAS FISCAIS
; CONTA NÃO ENCONTRADA
; FECHAR NOTAS DA CONTA
; ABRIR NOTAS DA CONTA

;~ ---------------
;~ EXECUÇÃO
;~ ---------------

IF @DesktopWidth <> "1600" Then
	MsgBox(0,$iMsgTitle,"ATENÇÃO: O ROBO FOI DESENVOLVIDO PARA USO EM RESOLUÇÃO: 1600 x 900. FAVOR CHAMAR RESPONSAVEL PELO ROBO")
Else
	ExibeInterface()
EndIf


#EndRegion

#Region __INTERFACE


Func ExibeInterface()

	  Global $iEXECUCAO[2] = ["ALTERAÇÕES DE CONTAS","INSERIR NOTAS CONTAS"]

	  Global $hGUI = GUICreate($iMsgTitle, 615, 164, 192, 124)
	  GUISetOnEvent($GUI_EVENT_CLOSE, "ConfirmaEncerramento")

	  ;-- GRUPO DE PROCEDIMENTO
	  $grpImpressao = GUICtrlCreateGroup("PROCEDIMENTO", 8, 8, 593, 145)
	  GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")

	  ;-- EXECUÇÃO
	  GLOBAL $cboExecucao = GUICtrlCreateCombo("", 104, 32, 481, 25, BitOR($CBS_DROPDOWN,$CBS_AUTOHSCROLL))
	  GUICtrlSetData(-1,  _ArrayToString($iEXECUCAO,"|"))

	  ;-- ARQUIVO
	  GLOBAL $txtArquivo = GUICtrlCreateInput("", 104, 64, 481, 21)

	  ;-- PLANILHA
	  $btnArquivo = GUICtrlCreateButton("CARREGAR PLANILHA", 104, 96, 355, 41)
	  GUICtrlSetOnEvent($btnArquivo, "carregarPlanilha")

	  ;-- EXECUTAR ROBÔ
	  $btnExecutar = GUICtrlCreateButton("EXECUTAR", 480, 96, 107, 41)
	  GUICtrlSetOnEvent($btnExecutar, "ValidaInterface")

	  ;-- ETIQUETAS
	  $lblExecucao = GUICtrlCreateLabel("EXECUÇÃO :", 16, 32, 78, 17, $SS_RIGHT)
	  $lblArquivo = GUICtrlCreateLabel("ARQUIVO :", 16, 64, 68, 17, $SS_RIGHT)
	  GUICtrlCreateGroup("", -99, -99, 1, 1)
	  GUISetState(@SW_SHOW)

	  ;-- Aguarda ação do usuário
	  While 1
		Sleep(10); comando para nao usar muito a CPU
	  WEnd

EndFunc

Func carregarPlanilha()
   local $tmpArqTexto = __SelecionarArquivo("*.xls*")
   GUICtrlSetData(5,$tmpArqTexto)
EndFunc

Func ValidaInterface()
	Local $strAux = ""

	if (GUICtrlRead($cboExecucao) = "") or (GUICtrlRead($txtArquivo) = "") Then
		 $strAux = $strAux & "  - Preencha todos os dados para execucao do robô" & @CRLF
	EndIf

	if $strAux = "" Then

		IF GUICtrlRead($cboExecucao) == "ALTERAÇÕES DE CONTAS" then

			mainEXCEL(GUICtrlRead($txtArquivo),"DESCONTO",GUICtrlRead($cboExecucao))

		ElseIF GUICtrlRead($cboExecucao) == "INSERIR NOTAS CONTAS" then

			mainEXCEL(GUICtrlRead($txtArquivo),"NOTAS",GUICtrlRead($cboExecucao))

		EndIf


		_Exit()

	Else
		MsgBox($MB_ICONERROR, $iMsgTitle,"Ocorreram inconsistências no preenchimento. Veja abaixo:" & @CRLF & @CRLF & $strAux)
	EndIf

EndFunc

Func ConfirmaEncerramento()
   Local $iAnswer = MsgBox(BitOR($MB_YESNO, $MB_SYSTEMMODAL), $iMsgTitle, "Deseja interromper a execução da automação?")
	If $iAnswer = 6 Then 	; Verifica se o usuário abortou a operação
		MsgBox(0, $iMsgTitle, "Processo abortado pelo usuário")
		_Exit()
	EndIf
EndFunc

Func _Exit()
   __PLANILHA_FECHAR()
   Exit
EndFunc

#EndRegion __INTERFACE

#Region __VALIDACAO

Func mainEXCEL($sFilename,$sSheetName,$sTipoTarefa)

	local $iFileExists = FileExists($sFilename)

	If Not $iFileExists Then
		MsgBox($MB_ICONERROR, $iMsgTitle, "Arquivo " & $sFilename & " não encontrado.")
	Else

		; INSTANCIAR OBJETO
;~ 		Global $iExcelObj = ObjGet($sFilename)
		Global $iExcelObj = ObjCreate("Excel.Application")
		$iExcelObj.application = true

		; ABRIR WORKBOOK
		Global $oDocument =  $iExcelObj.WorkBooks.Open($sFilename)

	;~ 	; CARREGAR WORKSHEET
	;~ 	;~ Local $aWorkSheet = _Excel_SheetList($oDocument)
		Global $iSheetName =  $oDocument.Worksheets($sSheetName)
	;~
	;~ 	; QUANTIDADE DE LINHAS
		Global $iRowCount = $iSheetName.UsedRange.Rows.Count
	;~ 	MsgBox(0,"$iRowCount",$iRowCount)

	;~ 	; QUANTIDADE COLUNAS
		Global $iColumnCount = $iSheetName.UsedRange.Columns.Count
	;~ 	MsgBox(0,"$iColumnCount",$iColumnCount)

	;~ 	; POSICIONAR APOS A ULTIMA COLUNA PARA STATUS
		Global $iLastColumn = _Excel_ColumnToLetter($iColumnCount+1)
	;~ 	MsgBox(0,"$iLastColumn",$iLastColumn)

	;~ 	; RANGE
		Local $iRange = "A1" & ":" & $iLastColumn  & $iRowCount
	;~ 	MsgBox(0,"$iRowCount",$iRowCount)


	;~ 	; ARRAY DO RANGE
		Global $iArrayValues = $iSheetName.range($iRange).value

	;~ ; INICIO DOS REGISTROS
		Local $iInicioRegistros = 2
		Local $UltStatus

;~ 	; ################################################################
;~ 	; EXECUCAO
;~ 	; ################################################################

	If IsArray($iArrayValues) and Ubound($iArrayValues,0)>0 then

		IF $sTipoTarefa == "ALTERAÇÕES DE CONTAS" then
			;~ ; ORDERNAR RANGE
			_Excel_RangeSort($oDocument,$iSheetName, $iRange, "F:F", Default, Default, $xlYes)

			;~ ; IDENTIFICA O ULTIMO REGISTRO - STATUS
			$UltStatus = $iExcelObj.WorksheetFunction.CountA($iSheetName.Range("P:P"))

		ElseIF $sTipoTarefa == "INSERIR NOTAS CONTAS" then

			;~ ; IDENTIFICA O ULTIMO REGISTRO - STATUS
			$UltStatus = $iExcelObj.WorksheetFunction.CountA($iSheetName.Range("D:D"))

		EndIf

		;~ ; INICIO DOS REGISTROS DEPOIS DO STATUS
		if $UltStatus <>"" Then
			$iInicioRegistros = $UltStatus + 2
		EndIf

;~ 		MsgBox(0,"$iInicioRegistros",$iInicioRegistros)


		for $x = $iInicioRegistros to $iRowCount

			; TIPO DE PLANILHA
			IF $sTipoTarefa == "ALTERAÇÕES DE CONTAS" then

				Local $CD_CNTA 				= $iSheetName.range("F" &($x)).Text
				Local $NR_TLFN	 			= $iSheetName.range("B" &($x)).Text
				Local $iExclusoes			= $iSheetName.range("M" &($x)).Text
				Local $sOBS					= $iSheetName.range("O" &($x)).Text
				Local $sAdicionarDesconto 	= False

				; ADICIONAR DESCONTO
				IF $sOBS == "R$ 6,00" THEN
					$sAdicionarDesconto = True
				EndIf

				; DESCONTO MARKETING
				__MARKETING_DESCONTO($CD_CNTA,$NR_TLFN,$iExclusoes,$sAdicionarDesconto)

				; MARCAR STATUS DE REGISTRO
				_ShowStatus("MARCAR STATUS DE REGISTRO" & " "  & $x)
				$iSheetName.range("P" &($x)) = "OK"
				$oDocument.Save

			ElseIF $sTipoTarefa == "INSERIR NOTAS CONTAS" then

				$CD_CNTA 	= $iSheetName.range("A" &($x)).Text
				$TIPO_NOTA 	= $iSheetName.range("B" &($x)).Text
				$DESC_NOTA 	= $iSheetName.range("C" &($x)).Text

				; CADASTRO DE NOTAS
				__MARKETING_NOTAS($CD_CNTA,$TIPO_NOTA,$DESC_NOTA)

				; MARCAR STATUS DE REGISTRO
				_ShowStatus("MARCAR STATUS DE REGISTRO" & " "  & $x)
				$iSheetName.range("D" &($x)) = "OK"
				$oDocument.Save

			EndIf

		  Next

		  MsgBox(0,"FIM","FIM DA EXECUÇÃO")

	EndIf


EndIf

;~ ; ################################################################
;~ ; EXECUCAO
;~ ; ################################################################

EndFunc

Func __PLANILHA_FECHAR()
;~ 	IF $iExcelObj.activate == True then
		$oDocument.close
		$iExcelObj.quit
		$iExcelObj = Null
;~ 	EndIf
EndFunc

Func qtdLinExcel($strCol)
     Return ($iExcelObj.Range($strCol & 65536).End(-4162).Row)
                ; -4162 equivale a constante xlUp do Excel
EndFunc


#EndRegion __VALIDACAO

#Region __PRODUCAO

Func __MARKETING_DESCONTO($CD_CNTA,$NR_TLFN,$iExclusoes,$sAdicionarDesconto)

   Local $hWnd = WinWait("[REGEXPTITLE:" & "Atlys Global Solution" & ".+]")

   if $hWnd <> 0 Then
	  WinActivate("[REGEXPTITLE:" & "Atlys" & ".+]")

;~ 	  ; MAXIMIZAR APLICAÇÃO
	_ShowStatus("MAXIMIZAR APLICAÇÃO")
	MouseMove(740, 15)
	MouseClick("left")


;~    #####################
;~    #####################
;~    #####################
;~    #####################
;~    #####################
;~    #####################


                WinActivate("[REGEXPTITLE:" & "Atlys" & ".+]")

                _ShowStatus("Atribuição")
                $hWnd = WinActivate("[REGEXPTITLE:" & "Atribuição" & ".+]")
                ;~ MsgBox(0,"",$hWnd)
                if $hWnd <> 0 Then
                               ; ADICIONAR NOTA
                               Sleep($SleepTime)
                               MouseMove(647,339)
                               MouseClick("left")
                EndIf




                ;~ WinActivate("[REGEXPTITLE:" & "Atlys" & ".+]")
                $hWnd = 0

                _ShowStatus("Adicionar")
                $hWnd = WinActivate("[REGEXPTITLE:" & "Adicionar" & ".+]")
                ;~ MsgBox(0,"",$hWnd)
                if $hWnd <> 0 Then
                               ; ADICIONAR NOTA
                               Sleep($SleepTime)
                               MouseMove(533,227)
                               MouseClick("left")
                EndIf




                ;~ WinActivate("[REGEXPTITLE:" & "Atlys" & ".+]")
                $hWnd = 0

                _ShowStatus("Notas")
                $hWnd = WinActivate("[REGEXPTITLE:" & "Notas" & ".+]")
                ;~ MsgBox(0,"",$hWnd)
                if $hWnd <> 0 Then
                               ; NOTAS
                               Sleep($SleepTime)
                               MouseMove(735,505)
                               MouseClick("left")
                EndIf





;~    #####################
;~    #####################
;~    #####################
;~    #####################
;~    #####################
;~    #####################




   ; LIMPAR PESQUISA ANTIGA SE HOUVER
   _ShowStatus("LIMPAR PESQUISA ANTIGA SE HOUVER")
   __CLIENTE_PESQUISA_FECHAR($SleepTime)

   ; INICIO DO PROCESSO - PESQUISA CLIENTE
   _ShowStatus("INICIO DO PROCESSO - PESQUISA CLIENTE")
   __CLIENTE_PESQUISA($CD_CNTA,$SleepTime)

   ; FECHAR MENSAGEM DE CONTA PROTEGIDA POR SENHA
   _ShowStatus("FECHAR MENSAGEM DE CONTA PROTEGIDA POR SENHA")
   __CONTA_PROTEGIDA_SENHA(296, 415,$SleepTime)

   ; FECHAR NOTAS DA CONTA
   _ShowStatus("FECHAR NOTAS DA CONTA")
   __NOTAS_CONTA_FECHAR(719, 502,$SleepTime)

   ; ABRIR ASSINATURA
   _ShowStatus("ABRIR ASSINATURA")
   __ASSINATURAS_ABRIR($NR_TLFN,419,686,411,208,$SleepTime)

   ; SELECIONA O PROGRAMA DE MARKETING
   _ShowStatus("SELEÇAO MARKETING")

	if $sValidarMarketing = false Then
	   Sleep(3000)
	EndIf

   ;__PROGRAMA_MARKETING__SELECAO(543, 234,532,562,$SleepTime)
   __PROGRAMA_MARKETING__SELECAO(442,215,532,562,$SleepTime)

   ; EXCLUIR PROGRAMA DE MARKETING
   _ShowStatus("EXCLUIR MARKETING")
   __PROGRAMA_MARKETING__EXCLUIR($iExclusoes,71,140,556,310,$SleepTime)

	if $sAdicionarDesconto == True then
		; ABRIR MARKETING
		_ShowStatus("ABRIR MARKETING")
		__PROGRAMA_MARKETING__ABRIR(66, 350,$SleepTime)

		; VALIDAR CONTINUAÇÃO
		if $sValidarMarketing == false Then
			MsgBox(0,"","PRONTO PARA CONTINUAR?")
		   $sValidarMarketing = true
		   Sleep(3000)
		EndIf

		; SERVIÇO DESCONTO 24 MESES R$1
		_ShowStatus("SERVIÇO DESCONTO 24 MESES R$1")
		__PROGRAMA_MARKETING__ADICIONAR(20,3000,600)

		; SERVIÇO DESCONTO 24 MESES R$5
		_ShowStatus("SERVIÇO DESCONTO 24 MESES R$5")
		__PROGRAMA_MARKETING__ADICIONAR(23,3000,600)

	EndIf

   ; FECHAR JANELA DE MARKETING
   _ShowStatus("")
   __PROGRAMA_MARKETING__FECHAR(552, 350,$SleepTime)

   ; FIM DO PROCESSO
   Sleep($SleepTime*4)
   _ShowStatus("FIM DO PROCESSO")
   __CLIENTE_PESQUISA_FECHAR($SleepTime)

   EndIf

;~    MsgBox(0,"FIM","FIM DA EXECUÇÃO")

EndFunc


FUNC __MARKETING_NOTAS($sCD_CNTA,$sTIPO_NOTA,$sDESC_NOTA)

	Local $hWnd = WinWait("[REGEXPTITLE:" & "Atlys Global Solution" & ".+]")

   if $hWnd <> 0 Then
	  WinActivate("[REGEXPTITLE:" & "Atlys" & ".+]")

	; MAXIMIZAR APLICAÇÃO
	_ShowStatus("MAXIMIZAR APLICAÇÃO")
	MouseMove(740, 15)
	MouseClick("left")

	; LIMPAR PESQUISA ANTIGA SE HOUVER
	_ShowStatus("LIMPAR PESQUISA ANTIGA SE HOUVER")
	__CLIENTE_PESQUISA_FECHAR($SleepTime)

	; INICIO DO PROCESSO - PESQUISA CLIENTE
	_ShowStatus("INICIO DO PROCESSO - PESQUISA CLIENTE")
	__CLIENTE_PESQUISA($sCD_CNTA,$SleepTime)

   ; CONTA NÃO ENCONTRADA
   _ShowStatus("CONTA NÃO ENCONTRADA")
   __NOTAS_CONTA_FECHAR(297, 416,$SleepTime)

	; FECHAR MENSAGEM DE CONTA PROTEGIDA POR SENHA
	_ShowStatus("FECHAR MENSAGEM DE CONTA PROTEGIDA POR SENHA")
	__CONTA_PROTEGIDA_SENHA(296, 415,$SleepTime)

   ; FECHAR NOTAS DA CONTA
   _ShowStatus("FECHAR NOTAS DA CONTA")
   __NOTAS_CONTA_FECHAR(719, 502,$SleepTime)

   ; ABRIR NOTAS DA CONTA
   	_ShowStatus("ABRIR NOTAS DA CONTA")
	MouseMove(702, 650)
	MouseClick("left")

	; ADICIONAR NOTAS DA CONTA
	_ShowStatus("ADICIONAR NOTAS DA CONTA")
	__NOTAS_CONTA_ABRIR(72,504,$SleepTime)

	; TIPO DE NOTA
	_ShowStatus("TIPO DE NOTA")
	__NOTAS_CONTA_TIPO($sTIPO_NOTA, $SleepTime,200)

	; DESCRICAO DA NOTA
	_ShowStatus("POSICIONAR EM CAMPO TEXTO")
	MouseMove(35, 96)
	MouseClick("left")

	_ShowStatus("DESCRICAO DA NOTA")
	SendWait(StringUpper(__CaracteresEspeciais($sDESC_NOTA)),$SleepTime,1)

	; CLIQUE NOTA OK
	_ShowStatus("CLIQUE NOTA OK")
	__NOTAS_CONTA_OK(59,228,$SleepTime)

   ; FECHAR NOTAS DA CONTA
   _ShowStatus("FECHAR NOTAS DA CONTA")
   __NOTAS_CONTA_FECHAR(719, 502,$SleepTime)

	; FIM DO PROCESSO
	_ShowStatus("FIM DO PROCESSO")
	__CLIENTE_PESQUISA_FECHAR($SleepTime)

   EndIf

;~    MsgBox(0,"FIM","FIM DA EXECUÇÃO")

EndFunc


#EndRegion __PRODUCAO
