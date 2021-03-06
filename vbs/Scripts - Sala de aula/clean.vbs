strSuperClass = "CIM_ManagedSystemElement"	'Where to start searching
iFlags = 0					'search all subclasses
vClassCount = 0
vPropCount = 0

For Each oSubClass in GetObject("WinMgmts:").SubclassesOf(strSuperClass,iFlags)
	If Left(oSubClass.Path_.RelPath,5) = "Win32" Then
		vClassCount = vClassCount + 1
		wscript.Echo oSubClass.Path_.RelPath
		For Each oProp in oSubClass.properties_
			vPropCount = vPropCount + 1
			wscript.Echo space(20)& oProp.name,vType 
		Next
	End If
Next
strMsg = "There were " & cStr(vClassCount)& " Win32 Classes," & vbcrlf
strMsg = strMsg & cStr(vPropCount) & " Properties " & vbcrlf
MsgBox strMsg,vbInformation,"Win32_Classes under " & strSuperClass