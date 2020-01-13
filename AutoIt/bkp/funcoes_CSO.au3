#include-Once
#include "funcoes_UTIL.au3"

Func _LOGIN_TELEFONICA($UserIni,$UserMid,$UserPwd,$SleepTime)
   SendWait($UserIni & $UserMid ,$SleepTime)
   SendWait("{TAB}",$SleepTime)
   SendWait($UserPwd,$SleepTime)
   SendWait("{ENTER}",$SleepTime)
   EndFunc

Func _LOGIN_TELEFONICA_INICIO($csoMonitor,$csoTransacao,$SleepTime,$iSleep=1500)
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

Func _LOGIN_TELEFONICA_CONSULTA($REF_O,$REF_T,$REF_NUMERO,$REF_LOCAL,$REF_AT,$SleepTime,$NAT="",$ES="",$SENHA="")

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
	  SendWait($REF_NUMERO,$SleepTime)
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
   else
	  SendWait($NAT,$SleepTime)
   EndIf

   ;[ES]
   if $ES = "" THEN
	  SendWait("{TAB}",$SleepTime)
	  SendWait("{TAB}",$SleepTime)
   else
	  SendWait($ES,$SleepTime)
   EndIf

   ;[SENHA]
   if $NAT <> "" THEN
	  SendWait($SENHA,$SleepTime)
   EndIf

   SendWait("{ENTER}",$SleepTime)

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

Func ConexaoPW3270($strUser, $strPassword, $strIP)

   ; Verifica se o PW3270 já está aberto
   If WinExists("pw3270") or WinExists("pw3270 - Desconectado") Then
                  MsgBox($MB_ICONERROR, "", "O PW3270 já está aberto. Favor fechar a janela antes de iniciar o processo.")
                  Exit
   EndIf

   ; Abre o PW3270 dentro do Citrix
   Local $iPID = Run("E:\Program Files (x86)\pw3270\pw3270.exe", "", @SW_SHOWMAXIMIZED)

   ; Ativa a janela do PW3270 e aguarda ativação por 30 segundos
   WinActivate("pw3270 - Desconectado")
   $nPW = WinWaitActive("pw3270 - Desconectado","",30)
   if $nPW = 0 Then
	  MsgBox($MB_ICONERROR, "", "Erro na abertura do PW3270")
	  Exit
   EndIf

   Sleep(2000)

   ; Clica em Rede > Selecione servidor
   Send("!r")
   Send("{ENTER}")
   Sleep(500)

   ; Preenche HOST
   If WinExists("Selecione host") Then
                  ControlSend("Selecione host","","gdkWindowChild4", $strIP)
                  Sleep(250)
                  ControlClick("Selecione host","","gdkWindowChild1")
   EndIf

   Sleep(1000)

   ; Ativa a janela do PW3270 e aguarda ativação por 20 segundos
   WinActivate("pw3270 - " & $strIP & ":23")
   $nPW = WinWaitActive("pw3270 - " & $strIP & ":23","",20)
   if $nPW = 0 Then
                  MsgBox($MB_ICONERROR, "", "Erro na ativação da página de Login")
                  Exit
   EndIf

   ; Preenche usuário e senha na tela de Login
   Send(StringLeft($strUser,7),1)
   Sleep(250)
   Send("{TAB}")
   Send($strPassword,1)
   Sleep(250)
   Send("{ENTER}")

EndFunc

Func RetornaLinhaDaTela($Linha,$WindowTitle,$xPosicaoReset,$yPosicaoReset,$iSleep=500)
	ClipPut("Vazio")
	Sleep($iSleep)
	Local $aTela = StringSplit(ClipGet(),@CR)
	While $aTela[0] <= 1
		WinActivate("[REGEXPTITLE:" & $WindowTitle & ".+]")
		;botão Reset
		MouseMove($xPosicaoReset,$yPosicaoReset)
		MouseClick("left")
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

Func marcarRegistro($SleepTime,$WindowTitle,$xPosicaoReset,$yPosicaoReset,$sNAT)
	Local $AuxTela = RetornaLinhaDaTela(0,$WindowTitle,$xPosicaoReset,$yPosicaoReset)
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