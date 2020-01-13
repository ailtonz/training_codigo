REM RTMImport.VBS
REM Copyright 2000 Microsoft Corporation

REM Saves property values for global Predictor and Direct Mailer resources.
REM Intended to ease upgrading from CS2000 RC0 to CS2000 RTM.

Option Explicit
Dim f, fso, objGrpCfg, fldResource, fldProperty

If WScript.Arguments.Count <> 1 Then
    WScript.Echo "Usage:"
    WScript.Echo "CScript.exe RC0Export.VBS filename"
    WScript.Echo "'filename' will be used to to store the global resource settings (destroying any previous contents)."
Else
    Set fso = CreateObject("Scripting.FileSystemObject")
    Set f = Nothing
    On Error Resume Next
    Set f = fso.CreateTextFile(WScript.Arguments(0), True, True)
    On Error Goto 0
    If f Is Nothing Then
        WScript.Echo "Error: Unable to open file '"&WScript.Arguments(0)&"' for export."
    Else
        Set objGrpCfg = CreateObject("Commerce.GlobalConfig")
        objGrpCfg.Initialize

        For Each fldResource in objGrpCfg.Fields
            if (0=StrComp(Left(fldResource.Name, 14), "Direct Mail on", 1)) Or (0=StrComp(Left(fldResource.Name, 12), "Predictor on", 1)) Then
                WScript.Echo "Info: Exporting settings for '"&fldResource.Name&"'."
                f.WriteLine("RESOURCE: "&fldResource.Name)
                For Each fldProperty in fldResource.Value.Fields
                    f.WriteLine("    PROPERTY: "&fldProperty.Name)
                    f.WriteLine("    TYPE:     "&typename(fldProperty.value))
                    f.WriteLine("    VALUE:    "&CStr(fldProperty.value)&"$$END$$")
                Next
            End If
        Next

        f.Close
    End If
End If

