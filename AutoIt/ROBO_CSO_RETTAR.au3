; COMO FUNCIONA: MAIN - (PRINCIPAL) | INTERFACE - (ADM USUÁRIO X ROBO) | VALIDACAO - (VALIDAR DADOS DA INTERFACE) | PRODUCAO - (FUNCOES DO ROBO) | PreSets - (eventos de controle)


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

#include "funcoes_CSO.au3"
#include "funcoes_UTIL.au3"

#Region PreSets
; Quando pressionar a tecla 'Esc' sai da rotina
HotKeySet("{Esc}", "CaptureEsc")

; Liga a opção de eventos de controle
Opt("GUIOnEventMode",1)
#EndRegion

#Region __MAIN

Global $iAutomatioName = "ROBO CONSULTA DE OS RETTAR"
Global $iMsgTitle = "Automação - " & $iAutomatioName
Global $s_Directory = @ScriptDir
Global $sValidarMarketing = False

Global $SleepTime = 1000

Global $xPosicaoReset = 0
Global $yPosicaoReset = 0

_ShowStatus($ResolucaoTela)

;~ ---------------
;~ TO-DO
;~ ---------------

;
;
;
;


;~ ---------------
;~ EXECUÇÃO
;~ ---------------


Switch @DesktopWidth
    Case "1600"
		 $xPosicaoReset = 1249
		 $yPosicaoReset = 731

	Case "1366"
		 $xPosicaoReset = 1107
		 $yPosicaoReset = 560

	Case Else

		 MsgBox(0,$iMsgTitle,"ATENÇÃO: O ROBO FOI DESENVOLVIDO PARA USO EM RESOLUÇÃO: 1600 ou 1366. FAVOR CHAMAR RESPONSAVEL PELO ROBO")
		 exit
EndSwitch

ExibeInterface()

#EndRegion

#Region __INTERFACE


Func ExibeInterface()

	#Region ### START - Form Aplication ###

		Global $hGUI = GUICreate($iMsgTitle, 615, 206, 192, 124)
		GUISetOnEvent($GUI_EVENT_CLOSE, "ConfirmaEncerramento")

		;--------------------
		;-- GRUPO DE LOGIN
		;--------------------
		$grpLogin 			= GUICtrlCreateGroup("LOGIN", 8, 8, 593, 65)
		GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")

		; USUARIO
		Global $txtUsuario 	= GUICtrlCreateInput("", 104, 32, 153, 21)
		GUICtrlSetTip(-1, "(com letra e dígito")

		; SENHA
		Global $txtSenha = GUICtrlCreateInput("", 424, 32, 161, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_PASSWORD))

		;------------------------
		;-- GRUPO DE PROCEDIMENTO
		;------------------------
		$grpImpressao 		= GUICtrlCreateGroup("PROCEDIMENTO", 8, 80, 593, 113)
		GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")

		; ARQUIVO
		Global $txtArquivo	= GUICtrlCreateInput("", 104, 104, 481, 21)

		$btnArquivo 		= GUICtrlCreateButton("CARREGAR PLANILHA", 104, 136, 355, 41)
		GUICtrlSetOnEvent($btnArquivo, "carregarPlanilha")

		$btnExecutar 		= GUICtrlCreateButton("EXECUTAR", 480, 136, 107, 41)
		GUICtrlSetOnEvent($btnExecutar, "ValidaInterface")

		GUICtrlCreateGroup("", -99, -99, 1, 1)

		;--------------------
		;-- ETIQUETAS
		;--------------------
		$lblUsuario 	= GUICtrlCreateLabel("USUÁRIO :", 24, 32, 68, 17, $SS_RIGHT)
		$lblSenha 		= GUICtrlCreateLabel("SENHA :", 352, 32, 54, 17, $SS_RIGHT)
		$lblArquivo 	= GUICtrlCreateLabel("ARQUIVO :", 16, 104, 68, 17, $SS_RIGHT)
		GUICtrlCreateGroup("", -99, -99, 1, 1)

		GUISetState(@SW_SHOW)

	#EndRegion ### END - Form Aplication  ###

	;-- Aguarda ação do usuário
	While 1
		Sleep(10); comando para nao usar muito a CPU
	WEnd

EndFunc

Func carregarPlanilha()
   local $tmpArqTexto = __SelecionarArquivo("*.xls*")
   GUICtrlSetData(7,$tmpArqTexto)
EndFunc

Func ValidaInterface()
	Local $strAux = ""

	if (GUICtrlRead($txtUsuario) = "") or (GUICtrlRead($txtSenha) = "") Then
		 $strAux = $strAux & "  - Preencha todos os dados para execucao do robô" & @CRLF
	EndIf

	if $strAux = "" Then

		mainEXCEL(GUICtrlRead($txtArquivo),"DADOS")

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

Func mainEXCEL($sFilename,$sSheetName)

	local $iFileExists = FileExists($sFilename)

	If Not $iFileExists Then
		MsgBox($MB_ICONERROR, $iMsgTitle, "Arquivo " & $sFilename & " não encontrado.")
	Else

		; INSTANCIAR OBJETO
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

		;~ ; ORDERNAR RANGE
;~ 		_Excel_RangeSort($oDocument,$iSheetName, $iRange, "F:F", Default, Default, $xlYes)

		;~ ; IDENTIFICA O ULTIMO REGISTRO - STATUS
		$UltStatus = $iExcelObj.WorksheetFunction.CountA($iSheetName.Range("AG:AG"))

		;~ ; INICIO DOS REGISTROS DEPOIS DO STATUS
		if $UltStatus <>"" Then
			$iInicioRegistros = $UltStatus + 2
		EndIf


#Region PREPARACAO - PW3270

	; APENAS PW
	Global $WindowTitle = "pw3270"
	Global $UserIni = StringLeft(GUICtrlRead($txtUsuario),1)
	Global $UserMid = StringMid(GUICtrlRead($txtUsuario),2,StringLen(GUICtrlRead($txtUsuario))-2)
	Global $UserDig = StringRight(GUICtrlRead($txtUsuario),1)
	Global $UserPwd = GUICtrlRead($txtSenha)
	Global $UserQry = ""
	Global $csoTransacao = "o010"
	Global $csoMonitor = "RC"

	Global $REF_O = "4"
	Global $REF_T = "N"
;~ 	Global $REF_NUMERO = StringFormat("%010s", "0024595900")
	Global $REF_LOCAL = "11000"
	Global $REF_AT = $UserMid & $UserDig
	Global $NAT = ""
	Global $ES = "SP"

	; ARRAY DA TELA
	Local $arrayTela = ""

	; REGISTRO CARREGADO
	Local $registroCarregado = "OK"

	_ATIVAR_JANELA($WindowTitle)

	_LOGIN_TELEFONICA($UserIni,$UserMid,$UserPwd,$SleepTime)

	_USUARIO_CONTROLE(RetornaLinhaDaTela(22,$WindowTitle,$xPosicaoReset,$yPosicaoReset),$iMsgTitle,$SleepTime)

	_LOGIN_TELEFONICA_INICIO($csoMonitor,$csoTransacao,$SleepTime)

#EndRegion PREPARACAO


		for $x = $iInicioRegistros to $iRowCount

			; LIMPAR ARRAY DA TELA
			$arrayTela = ""

			$registroCarregado = ""

			; INICIO DE CONSULTA
			; ------------------
			_LOGIN_TELEFONICA_CONSULTA($REF_O,$REF_T,StringFormat("%010s", $iSheetName.range("A" &($x)).Text),$REF_LOCAL,$REF_AT,$SleepTime,$NAT,$ES)

			; COPIAR A TELA
			$arrayTela = RetornaLinhaDaTela(0,$WindowTitle,$xPosicaoReset,$yPosicaoReset)


			; MARCAR REGISTRO
			If StringInStr($arrayTela[1],"Resumo") > 0 Then
				$registroCarregado = marcarRegistro($SleepTime,$WindowTitle,$xPosicaoReset,$yPosicaoReset,"RETTAR")
			Else
				$registroCarregado = "OK"
			EndIf


			; -------------
			; PRODUÇÃO
			; -------------

			; COPIAR A TELA
			$arrayTela = RetornaLinhaDaTela(0,$WindowTitle,$xPosicaoReset,$yPosicaoReset)

			IF $registroCarregado = "OK" THEN

				$iSheetName.range("B" &($x))	= _ALLTRIM(StringMid($arrayTela[3],11,65))	; ASS

				$iSheetName.range("C" &($x))	= _ALLTRIM(StringMid($arrayTela[4],11,7)) 	; NATU
				$iSheetName.range("D" &($x))	= _ALLTRIM(StringMid($arrayTela[4],24,8)) 	; SIT
				$iSheetName.range("E" &($x))	= _ALLTRIM(StringMid($arrayTela[4],39,25))	; DATA
				$iSheetName.range("F" &($x))	= _ALLTRIM(StringMid($arrayTela[4],11,4))	; PERIODO

				$iSheetName.range("G" &($x))	= _ALLTRIM(StringMid($arrayTela[5],11,7))	; TAR
				$iSheetName.range("H" &($x))	= _ALLTRIM(StringMid($arrayTela[5],30,33))	; MOT/PROV

				$iSheetName.range("I" &($x))	= _ALLTRIM(StringMid($arrayTela[6],11,7))	; DATAVIG
				$iSheetName.range("J" &($x))	= _ALLTRIM(StringMid($arrayTela[6],30,4))	; MOT/ANT
				; $iSheetName.range("K" &($x))	= _ALLTRIM(StringMid($arrayTela[0],0,0))	; DATAPED
				$iSheetName.range("L" &($x))	= _ALLTRIM(StringMid($arrayTela[6],72,4))	; DATA FAT

				$iSheetName.range("M" &($x))	= _ALLTRIM(StringMid($arrayTela[7],11,13))	; NROCS
				$iSheetName.range("N" &($x))	= _ALLTRIM(StringMid($arrayTela[7],36,5))	; CLA ASS
				$iSheetName.range("O" &($x))	= _ALLTRIM(StringMid($arrayTela[7],51,9))	; DATEMIS
				$iSheetName.range("P" &($x))	= _ALLTRIM(StringMid($arrayTela[7],72,5))	; CS

				$iSheetName.range("Q" &($x))	= _ALLTRIM(StringMid($arrayTela[8],11,13))	; TEL
				$iSheetName.range("R" &($x))	= _ALLTRIM(StringMid($arrayTela[8],36,5))	; CLA SERV
				$iSheetName.range("S" &($x))	= _ALLTRIM(StringMid($arrayTela[8],51,9))	; ES
				$iSheetName.range("T" &($x))	= _ALLTRIM(StringMid($arrayTela[8],72,5))	; CPCC

				$iSheetName.range("U" &($x))	= _ALLTRIM(StringMid($arrayTela[9],11,13))	; TEL D/P
				$iSheetName.range("V" &($x))	= _ALLTRIM(StringMid($arrayTela[9],36,5))	; CLA ANT
				$iSheetName.range("W" &($x))	= _ALLTRIM(StringMid($arrayTela[9],51,9))	; LOC/AT
				$iSheetName.range("X" &($x))	= _ALLTRIM(StringMid($arrayTela[9],72,5))	; CC

				; $iSheetName.range("Y" &($x))	= _ALLTRIM(StringMid($arrayTela[0],0,0))	; DT INIC
				; $iSheetName.range("Z" &($x))	= _ALLTRIM(StringMid($arrayTela[0],0,0))	; H INIC
				; $iSheetName.range("AA" &($x))	= _ALLTRIM(StringMid($arrayTela[0],0,0))	; DT TERM
				; $iSheetName.range("AB" &($x))	= _ALLTRIM(StringMid($arrayTela[0],0,0))	; H TERM
				; $iSheetName.range("AC" &($x))	= _ALLTRIM(StringMid($arrayTela[0],0,0))	; FATB
				; $iSheetName.range("AD" &($x))	= _ALLTRIM(StringMid($arrayTela[0],0,0))	; NOM LIS
				; $iSheetName.range("AE" &($x))	= _ALLTRIM(StringMid($arrayTela[0],0,0))	; LIS CLA

				$iSheetName.range("AF" &($x))	= _ALLTRIM(StringMid($arrayTela[17],1,80)) & @CR & _ALLTRIM(StringMid($arrayTela[18],1,80)) & @CR & _ALLTRIM(StringMid($arrayTela[19],1,80)) & @CR & _ALLTRIM(StringMid($arrayTela[20],1,38))

				; -------------------------
				; MARCAR STATUS DE REGISTRO
				; -------------------------
				_ShowStatus("MARCAR STATUS DE REGISTRO" & " "  & $x & "-" & $iRowCount)
				$iSheetName.range("AG" &($x)) = "OK"
				$oDocument.Save
				; -------------------------
				; MARCAR STATUS DE REGISTRO
				; -------------------------

			Else

				; -------------------------
				; MARCAR STATUS DE REGISTRO
				; -------------------------
				_ShowStatus("MARCAR STATUS DE REGISTRO" & " "  & $x & "-" & $iRowCount)
				$iSheetName.range("AG" &($x)) = "SEM REGISTRO"
				$oDocument.Save
				; -------------------------
				; MARCAR STATUS DE REGISTRO
				; -------------------------

			EndIf

			; -------------
			; PRODUÇÃO
			; -------------






			; PROXIMA CONSULTA
			; ----------------
			_LOGIN_TELEFONICA_FIM($csoTransacao,$SleepTime)


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


#EndRegion __VALIDACAO

#Region __PRODUCAO




#EndRegion __PRODUCAO
