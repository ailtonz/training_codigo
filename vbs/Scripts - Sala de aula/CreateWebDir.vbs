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

Call CreateQueue(".\private$\ReceivedDoc", "Received Documents: Input Queue")
Call CreateQueue(".\private$\ProcessedDoc", "Processed Documents: Output Queue")
Call CreateQueue(".\private$\AbortedDoc", "Aborted Documents: Output Queue")
MsgBox "Queues created successfully", vbOKOnly, "Transaction Handler Demo"