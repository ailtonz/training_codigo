' Copyright � 2002 Microsoft Corporation.  All rights reserved.
Function vbCompareString( l_string, r_string, b_binary )
	If b_binary = True Then
		vbCompareString = StrComp( l_string, r_string, 0 )
	Else
		vbCompareString = StrComp( l_string, r_string, 1 )
	End If
End Function