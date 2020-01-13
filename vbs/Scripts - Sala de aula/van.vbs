'these functions can be used both on the client and on the server,
'so we intentionally do not use Server.CreateObject!

'attempts to parse strDataString as XML, returns true if successful, else false
Function bolFuncIsStringValidXML(strDataString)
    If Len(Trim(strDataString)) = 0 Then
        bolFuncIsStringValidXML = False
    Else
        Dim dom
        Set dom = CreateObject("MSXML.DOMDocument")
        dom.async = False
        dom.loadXML strDataString
        If dom.parseError = 0 Then
            bolFuncIsStringValidXML = True
        Else
            bolFuncIsStringValidXML = False
        End If
    End If
End Function


' utility function for bolBLOB2BSTR
Function dta_ui_bolIsXML(varBLOB, strCharSet) ' As Boolean
    Dim stm ' As ADODB.Stream
    Set stm = CreateObject("ADODB.Stream")
    stm.Type = 1 ' adTypeBinary
    stm.Open
    stm.Write varBLOB
    stm.Position = 0
    stm.Type = 2 ' adTypeText
    On Error Resume Next
    stm.Charset = strCharSet
    If Err.Number <> 0 Then
		dta_ui_bolIsXML = False
		Exit Function
	End If
    On Error Goto 0
        
    Dim dom ' As MSXML.DOMDocument
    Set dom = CreateObject("MSXML.DOMDocument")
    Dim strOut ' As String
    On Error Resume Next
    strOut = stm.ReadText
    If Err.Number <> 0 Then
		dta_ui_bolIsXML = False
		Exit Function
	End If
    On Error Goto 0
    dom.loadXML strOut
    If dom.parseError = 0 Then
        dta_ui_bolIsXML = True
    Else
        dta_ui_bolIsXML = False
    End If
End Function

' input varBLOB with binary data as blob,
' strCharSet as CharSet (if not known, input the empty string),
' bolAttemptXML to attempt to recognise as XML
' return value is false if blob couldn't be converted to text
' else true, with text returned in outstrString,
' charset returned in outstrCharSet (for the case when charset wasn't known initially, but MSXML found it),
' outbolIsXML tells whether it was recognised as XML (always false unless bolAttemptXML = true)
Function bolBLOB2BSTR(varBLOB, strCharSet, bolAttemptXML, outstrString, outstrCharSet, outbolIsXML) ' as boolean
    bolBLOB2BSTR = False
    
    outstrCharSet = strCharSet
    outbolIsXML = False

    If bolAttemptXML Then
        If outstrCharSet <> "" Then
            outbolIsXML = dta_ui_bolIsXML(varBLOB, outstrCharSet)
        ElseIf dta_ui_bolIsXML(varBLOB, "utf-8") Then
            outbolIsXML = True
            outstrCharSet = "utf-8"
        ElseIf dta_ui_bolIsXML(varBLOB, "unicode") Then
            outbolIsXML = True
            outstrCharSet = "unicode"
        ElseIf dta_ui_bolIsXML(varBLOB, "utf-7") Then
            outbolIsXML = True
            outstrCharSet = "utf-7"
        End If
    End If
    
    If outstrCharSet <> "" Then
        Dim stm ' as ADODB.stream
        Set stm = CreateObject("ADODB.Stream")
        stm.Type = 1 ' adTypeBinary
        stm.Open
        stm.Write varBLOB
        stm.Position = 0
        stm.Type = 2 ' adTypeText
        On Error Resume Next
        stm.Charset = outstrCharSet
        If Err.Number <> 0 Then
			On Error Goto 0
			outstrCharSet = ""
			bolBLOB2BSTR = False
		Else
			On Error Goto 0 
	        outstrString = stm.ReadText
	        bolBLOB2BSTR = True
	    End If
    End If
    
End Function

' OBSOLETE FUNCTION, REMOVE
' varBLOB is the BLOB
' nBLOBtype specifies UNICODE, ASCII, DBCS
' strCodePage specifies codepage
' return value is a string representation of the BLOB
function strBLOBtoBSTR (varBLOB, strCodePage, strSyntax)
	if IsEmpty(varBLOB) then
		strBLOBtoBSTR = L_DocumentIsEmpty_Message	
	else
		dim stm ' as Stream
		set stm = CreateObject("ADODB.Stream")
		stm.Open 
		stm.Type = 1
		stm.Write varBLOB
		stm.Position = 0
		stm.Type = 2
		stm.CharSet = strCodePage
		if stm.Size > 0 then
			strBLOBtoBSTR = stm.ReadText ()
		else
			strBLOBtoBSTR = ""
		end if
	end if
end function

