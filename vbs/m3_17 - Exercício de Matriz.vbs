   dim matriz(3)	'matriz declarada com 4 posi��es
matriz(0) = "zero"
matriz(1) = "um"
matriz(2) = "dois"
matriz(3) = "tr�s"

wscript.Echo matriz(2)
'============================================================================

dim semana
'matrizes come�am em ZERO
semana = array("","Dom","Seg","Ter","Qua","Qui","Sex","Sab")
'wscript.Echo "Hoje �: " & semana(weekday(now()))

'============================================================================

'-------------------------------------------------------------------------
' OBS: matriz fixa n�o pode ser redimencionada, somente matriz din�mica
' veja o exemplo abaixo:
' 		teste = array(5)
'		teste(1) = "Maria"
'		redim teste(3)
'-------------------------------------------------------------------------

dim mes()
'redim mes(3)
mes(0)= "jan"
mes(1)= "fev"
mes(2)= "mar"
mes(3)= "abr"

for x=0 to ubound(mes) 'para descobrir quantos itens tem na matriz use ubound(matriz)
wscript.Echo "A posi��o " & x & " na matriz mes �: " & mes(x)
next


'-------------------------------------------------------------------------
'ao redimensionar matrizes vc perder� todos os valores armazenados
'para evitar isto use a palavra chave preserve (redim preserve mes(3))
'-------------------------------------------------------------------------

'redim mes(3)
'mes(3)="abr"
'for x=0 to ubound(mes)
'wscript.Echo "A posi��o " & x & " na matriz mes �: " & mes(x)
'next



