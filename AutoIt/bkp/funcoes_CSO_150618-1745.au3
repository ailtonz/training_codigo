#include-Once
#include "funcoes_UTIL_150730-1507.au3"


Func _LOGIN_TELEFONICA($UserIni,$UserMid,$UserPwd,$SleepTime=500)
   SendWait($UserIni & $UserMid ,$SleepTime)
   SendWait("{TAB}",$SleepTime)
   SendWait($UserPwd,$SleepTime)
   SendWait("{ENTER}",$SleepTime)
   EndFunc

Func _LOGIN_TELEFONICA_INICIO($csoMonitor,$csoTransacao,$SleepTime=500,$iSleep=1500)
   SendWait("{ENTER}{TAB}",$SleepTime)
   Sleep($iSleep)

   SendWait($csoMonitor,$SleepTime) ; Monitor
   SendWait("{ENTER}",$SleepTime)

   SendWait("{PAUSE}",$SleepTime)
   SendWait("{PAUSE}",$SleepTime)
   SendWait("{PAUSE}",$SleepTime)
   Sleep($iSleep)

   SendWait($csoTransacao & "{ENTER}",$SleepTime) ; Transacao
EndFunc

Func _LOGIN_TELEFONICA_CONSULTA($REF_O,$REF_T,$REF_NUMERO,$REF_LOCAL="",$REF_AT="",$NAT="",$ES="",$SENHA="",$SleepTime=500)

   ;[O]
   SendWait($REF_O,$SleepTime)

   ;[T]
   IF $REF_T = "" Then
	  SendWait("{TAB}",$SleepTime)
   Else
	  SendWait($REF_T,$SleepTime)
   EndIf

   ;[NUMERO]
   if $REF_NUMERO = "" Then
	  SendWait("{TAB}",$SleepTime)
   Else
	  SendWait(StringFormat("%010s", $REF_NUMERO),$SleepTime)
;~ 	  SendWait($REF_NUMERO,$SleepTime)
   EndIf

   ;[LOCAL]
   if $REF_LOCAL = "" Then
	  SendWait("{TAB}",$SleepTime)
   Else
	  SendWait($REF_LOCAL,$SleepTime)
   EndIf

   ;[AT_COM]
   if $REF_AT = "" Then
	  SendWait("{TAB}",$SleepTime)
   Else
	  SendWait($REF_AT,$SleepTime)
   EndIf

   ;[AT_COM]
;~    SendWait($UserMid & $UserDig,$SleepTime)

   ;[NAT]
   if $NAT = "" THEN
	  SendWait("{TAB}",$SleepTime)

	  ;[ES]
	  if $ES = "" THEN
;~ 		 SendWait("{TAB}",$SleepTime)
		 SendWait("{TAB}",$SleepTime)
	  else
		 SendWait($ES,$SleepTime)
	  EndIf

	  ;[SENHA]
	  if $SENHA <> "" THEN
		 SendWait($SENHA,$SleepTime)
	  EndIf

	  SendWait("{ENTER}",$SleepTime)

   else
	  SendWait($NAT,$SleepTime)
	  SendWait("{ENTER}",$SleepTime)
   EndIf

Sleep($SleepTime)


   EndFunc

Func _LOGIN_TELEFONICA_FIM($csoTransacao,$SleepTime,$iSleep=1000)
   SendWait("{PAUSE}",$SleepTime)
   SendWait("{PAUSE}",$SleepTime)
   SendWait("{PAUSE}",$SleepTime)
   Sleep($iSleep)

   SendWait($csoTransacao & "{ENTER}",$SleepTime)
EndFunc

Func _USUARIO_CONTROLE($Linha,$iMsgTitle,$SleepTime)
   if (StringInStr($Linha, "SENHA") > 0) or (StringInStr($Linha, "USUARIO NAO AUTORIZADO") > 0) Then
	  MsgBox($MB_ICONERROR, $iMsgTitle, "Erro no acesso. Verifique os dados de acesso informados.")
	  SendWait("{PAUSE}",$SleepTime)
	  Exit
   EndIf
   EndFunc

Func ConexaoPW3270($strIP ,$strSrv ,$iSleep=500)

   ; Verifica se o PW3270 já está aberto
   If WinExists("pw3270") or WinExists("pw3270 - Desconectado") Then
	  MsgBox($MB_ICONERROR, "", "O PW3270 já está aberto. Favor fechar a janela antes de iniciar o processo.")
	  Exit
   EndIf

   ; Abre o PW3270 dentro do Citrix
;~    Local $iPID = Run("E:\Program Files (x86)\pw3270\pw3270.exe", "", @SW_SHOWMAXIMIZED)
	_ShowStatus("Abre o PW3270 dentro do Citrix")
   Local $iPID = Run("E:\Program Files (x86)\pw3270\pw3270.exe", "", @SW_SHOWMAXIMIZED)
;~    Local $iPID = Run("C:\Program Files (x86)\pw3270\pw3270.exe", "", @SW_SHOWMAXIMIZED)

   Sleep(2000)

   ; Clica em Rede > Selecione servidor
   _ShowStatus("Selecione servidor")
   Send("!r")
   Send("{ENTER}")
   Sleep(500)

   ; Preenche HOST
   _ShowStatus("Selecione host " & $strIP)
   If WinExists("Selecione host") Then
	  SendWait($strIP,$iSleep)
	  SendWait("{tab}",$iSleep)
	  SendWait($strSrv,$iSleep)
	  Send("!o")
   EndIf

   Sleep(1000)

EndFunc


Func RetornaLinhaDaTela($Linha,$iSleep=500)
	ClipPut("Vazio")
	Sleep($iSleep)
	Local $aTela = StringSplit(ClipGet(),@CR)
	While $aTela[0] <= 1
;~ 		WinActivate("[REGEXPTITLE:" & $WindowTitle & ".+]")
		Send("{ESC}")
		Sleep($iSleep)
		Send("{CTRLDOWN}a{CTRLUP}")
		Send("{CTRLDOWN}c{CTRLUP}")
		Sleep($iSleep)
		Local $aTela = StringSplit(ClipGet(),@CR)
		Sleep($iSleep)
	WEnd
	if $Linha = 0 Then
		Return $aTela
	else
		Return _ALLTRIM(_ALLTRIM($aTela[$Linha]),@LF)
	EndIf
EndFunc

Func _copiarLinha($iLinha)
	;Função retorna a linha especifica passada pelo parametro;
	if $iLinha < 1 or $iLinha > 24 Then
		MsgBox($MB_ICONERROR,"Erro!", "Numero de Linha Inválida!")
		Exit
	EndIf

	Local $iTentativa = 1

	ClipPut("")
	Local $Tela = StringSplit(ClipGet(),@CR)
	WinActivate("pw3270")

	While $Tela[0] <= 1

		; Verifica se for realizada + de 1 tentativa tenta pegar a tela
		if $iTentativa > 1 Then
		WinActivate("pw3270")
		Send("{ESC}")
		EndIf

		Send("{CTRLDOWN}a{CTRLUP}") ;Crtl + A
		Send("{CTRLDOWN}c{CTRLUP}") ;Crtl + C
		Sleep(100)

		Local $Tela = StringSplit(ClipGet(),@CR)
		Sleep(200)

		$iTentativa = $iTentativa + 1
	WEnd

EndFunc

Func marcarRegistro($SleepTime,$WindowTitle,$sNAT)
	Local $AuxTela = RetornaLinhaDaTela(0,$WindowTitle)
	SendWait("{ENTER}", $SleepTime)
	SendWait("{TAB}", $SleepTime)
	SendWait("{DOWN}", 50, 17)

	Local $FlagEncontrou = 0

	For $a = UBound($AuxTela) - 5 To 3 Step -1
		If ($FlagEncontrou = 0) And (StringInStr($AuxTela[$a+1], $sNAT) > 0) Then
			SendWait("x", 50)
			SendWait("{UP}", 50, 2)
			$FlagEncontrou = 1
		Else
			SendWait("{UP}", 50)
		EndIf

	Next

	SendWait("{F1}", 1000)

	IF $FlagEncontrou = 1 THEN
		Return "OK"
	Else
		Return ""
	EndIf

EndFunc

Func _LIMPAR_TELA()
	 Send("{PAUSE}{Break}")
	 Send("{PAUSE}{Break}")
	 Send("{ENTER}")
EndFunc

Func _CADASTRO_CLIENTE($REF_O,$REF_T,$REF_NUMERO,$REF_LOCAL,$REF_AT,$NAT,$ES,$SENHA,$SleepTime=500)

   ; [O]
   sendWait($REF_O,$SleepTime)

   ; [T]
   sendWait($REF_T,$SleepTime)

   ; [NUMERO]
   sendWait(StringFormat("%010s", $REF_NUMERO),$SleepTime);[NUMERO]

   ; [LOCAL]
;~    Send("{TAB}")
   If $REF_LOCAL="" THEN
	  sendWait("{TAB}",$SleepTime)
   Else
	  sendWait($REF_LOCAL,$SleepTime)
   EndIf

   ; [AT COM]
   sendWait($REF_AT,$SleepTime)

   ; [NAT]
   sendWait("{TAB}",$SleepTime)

   ; [ES]
   sendWait($ES,$SleepTime)

   ; [SENHA]
   sendWait($SENHA,$SleepTime)
   sendWait("{ENTER}",$SleepTime)
EndFunc

Func _CADASTRO_BC($REF_O,$NAT,$SleepTime=500)

   ; [O]
   sendWait($REF_O,$SleepTime)

   ; [NAT]
   sendWait("{DOWN}",$SleepTime)
   sendWait($NAT,$SleepTime)
   sendWait("{ENTER}",$SleepTime)
EndFunc

Func _EMISSAO_BC($End,$DesPed01,$DesPed02,$DesPed03,$AnalistaNome,$AnalistaArea,$URG,$RecSer,$Setor,$Assunto,$Sub,$SleepTime=500)
   ; [REF]
   SendWait("{TAB}",$SleepTime)

   ; [CONTATO]
   SendWait("{TAB}",$SleepTime)

   ; [END]
   SendWait($End,$SleepTime)

   ; [DESCRICAO DO PEDIDO]
   SendWait($DesPed01,$SleepTime)
   SendWait($DesPed02,$SleepTime)
   SendWait($DesPed03,$SleepTime)
   SendWait("{TAB}",$SleepTime)
   SendWait("{TAB}",$SleepTime)

   ; [EMI]
   SendWait($AnalistaNome,$SleepTime)
   SendWait("{TAB}",$SleepTime)
   SendWait($AnalistaArea,$SleepTime)
   SendWait("{TAB}",$SleepTime)

   ; [URG]
   SendWait($URG,$SleepTime)

   ; [REIT]
   SendWait("{TAB}",$SleepTime)

   ; [REC/SER]
   SendWait($RecSer,$SleepTime)

   ; [DATA ATEND]
   SendWait(@MDAY,$SleepTime)
   SendWait(@MON,$SleepTime)
   SendWait(StringRight(@YEAR,2),$SleepTime)

   ; [ES]
   SendWait("{TAB}",$SleepTime)

   ; [SETOR]
   SendWait($Setor,$SleepTime)

   ; [CPL]
   SendWait("{ENTER}",$SleepTime)

   ; [ASSUNTO]
   SendWait($Assunto,$SleepTime)
   SendWait("{ENTER}",$SleepTime)

   ; [SUB]
   SendWait($Sub,$SleepTime)
   SendWait("{ENTER}",$SleepTime)

   SendWait("{F1}",$SleepTime)

   Return _ALLTRIM(StringMid(RetornaLinhaDaTela(22),38,11))

EndFunc