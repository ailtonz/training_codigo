Set Msg = CreateObject("CDO.Message")

With Msg

      .To = "SharonSal@nwtraders.msft"
       .From = "samsmith@nwtraders.msft"
       .Subject = "Your account is ready"
       .TextBody = "Just wanted to let you know that your account is now ready for use.  Thanks!"
       .Send

      
       
End With

MsgBox "Script Complete"
