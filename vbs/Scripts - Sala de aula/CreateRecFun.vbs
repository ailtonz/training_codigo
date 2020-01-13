dim qinfo

set qinfo = CreateObject("MSMQ.MSMQQueueInfo")

sub CreateQueue(sQueueName, sQueueLabel)
	qinfo.Label = ""
	qinfo.PathName = sQueueName
	on error resume next
	qInfo.Refresh
	on error goto 0
	if (len(qinfo.Label) = 0) then
		qinfo.Label = sQueueLabel
		qinfo.Create true
	end if
end sub

Call CreateQueue(".\private$\AcceptSale", "Accept Sale Sample")
MsgBox "Queue created successfully", vbOKOnly, "Module05"