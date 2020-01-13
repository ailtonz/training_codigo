Set Msg = CreateObject("CDO.Message") 

With Msg

      .To = "LondonAdmin@nwtraders.msft"
       .From = "SamSmith@nwtraders.msft"
       .Subject = "Performing preventative maintenance"
       .TextBody = "Hi there!  Now that Megan�s been promoted, I need you to start managing the maintenance tasks for the London server. Here is a list of what I need you to do:" & chr(10) & chr(10) & "* Check Event Viewer for potential issues." & chr(10) & "* Check Monitoring and Status for potential issues." & chr(10) & "* Verify that the queues have no long-term undelivered messages." & chr(10) & "* Produce a performance report and search for trends." & chr(10) & "* Check the SMTP log for problems." & chr(10) & "* Use HTTPmon to monitor the HTTP front-end server." & chr(10) & "* Check for over-limit mailboxes." & chr(10) & "* Clean all over-limit mailboxes: any items in users' deleted items folder that are older than 60 days need to be removed." & chr(10) & "* Review the badmail folder and delete the contents if everything looks normal." & chr(10) & "* Create a Postmaster account and configure the default SMTP virtual server to send NDRs to that account." & chr(10) & "* Defragment the mailbox store." & chr(10) & "* Run isinteg.exe against the mailbox store to verify that everything is working properly." & chr(10) & chr(10) & "Thanks!"
       .Send
End With

MsgBox "Script Complete"
