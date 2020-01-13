option explicit
dim sVerMessage, sOKMessage
sVerMessage = "You are using version " & _
              ScriptEngineMajorVersion & "." & _
              ScriptEngineMinorVersion &  _
              " of VBScript (build "& ScriptEngineBuildVersion & ")"

if ScriptEngineMajorVersion < 3 then
    sOKMessage = "The minimum recommended version for this course is 3.0." & vbCRLF & _
                 "You should upgrade before proceeding." & vbCRLF & _
                 "An upgrade is available at http://www.microsoft.com/scripting/"
else
    sOKMessage = "This is a recent enough build for this course."
end if

msgbox sVerMessage & vbCRLF & sOKMessage
