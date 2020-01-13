dim qinfo

set qinfo = CreateObject("MSMQ.MSMQQueueInfo")

sub DeleteQueue(sQueueName)
	qinfo.Label = ""
	qinfo.PathName = sQueueName
	on error resume next
	qInfo.Refresh
	on error goto 0
	if (len(qinfo.Label) > 0) then
		qinfo.Delete
	end if
end sub

Call DeleteQueue(".\private$\UnknownDocs")
Call DeleteQueue(".\private$\SendDocs")
Call DeleteQueue(".\private$\RecvDocs")
MsgBox "Queues deleted successfully", vbOKOnly, "Dispatcher Sample"