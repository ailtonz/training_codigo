Set Msg = CreateObject("CDO.Message")

With Msg

      .To = "HR@nwtraders.msft"
       .From = "samsmith@nwtraders.msft"
       .Subject = "Vacation policy"
       .TextBody = "This attachment describes the Northwind Traders vacation policy"
       .AddAttachment "C:\moc\2400\practices\Mod05\vacationpolicy.doc"
       .Send

       .To = "HR@nwtraders.msft"
       .From = "jberry@nwtraders.msft"
       .Subject = "Sick leave policy"
       .TextBody = "Northwind Traders has no policy regarding sick leave. If you are too sick to come to work, you must take vacation time."
       .Send


       .To = "HR@nwtraders.msft"
       .From = "londonadmin@nwtraders.msft"
       .Subject = "Working from home policy"
       .TextBody = "In the interest of saving money on additional rent, we will be tripling up on our office space, starting next month. To maximize productivity, please plan to work from home at least 3 days each week."
       .Send
        

End With

MsgBox "Script Complete"
