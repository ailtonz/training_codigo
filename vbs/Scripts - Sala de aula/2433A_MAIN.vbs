Set Msg = CreateObject("CDO.Message")

With Msg


     .To = "LondonAdmin@nwtraders.msft"
       .From = "samsmith@nwtraders.msft"
       .Subject = "Merger with Contoso"
       .TextBody = "Hello. Here is the deployment plan that I told you about. I have pared it down to include just the part of the implementation that you are responsible for. Thanks!"
       .AddAttachment "c:\moc\2400\practices\mod14\deploymentplan.doc"
       .Send

End With

MsgBox "Script Complete"
