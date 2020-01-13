Set Msg = CreateObject("CDO.Message")

With Msg

      .To = "LondonAdmin@nwtraders.msft"
       .From = "samsmith@nwtraders.msft"
       .Subject = "Managing routing"
       .TextBody = "Hello - I have a list of tasks that I need you to accomplish with respect to routing.  Here is the task list:" & chr(10) & chr(10) & "* Refresh your knowledge on how routing works in Exchange." & chr(10) & "* Refresh your knowledge on why different types of connectors are used." & chr(10) & "* Create a new routing group and move the Miami server into it." & chr(10) & "* Connect the Miami and London routing groups by using a routing group connector." & chr(10) & "* Verify that the routing group connector is working correctly." & chr(10) & "* Re-acquaint yourself with SMTP commands and usage." & chr(10) & "* Add an MX record for the London server to the London DNS server." & chr(10) & "* Set up an SMTP connector on the London server." & chr(10) & "* Configure the users who are listed in the attached nosmtp.doc file so that they can no longer send Internet e-mail." & chr(10) & "* Configure the London SMTP connector to use the SMARTHOST box as an SMTP relay host." & chr(10) & "* Configure the SMTP connector to allow SMTP relaying." & chr(10) & "* Configure London to pull e-mail from our ISP. The ISP agreed that they will host our e-mail for us if our connection to them goes down so that we do not lose any e-mail, but we will have to pull it down ourselves." & chr(10) & chr(10) & "Thanks!"
       .AddAttachment "C:\moc\2400\practices\Mod09\nosmtp.doc"
       .Send





End With

MsgBox "Script Complete"
