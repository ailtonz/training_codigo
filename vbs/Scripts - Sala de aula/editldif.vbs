'
' DumpOrder is a simple example of building a component using VBS and scriptor
'
' To use dumporder, configure a Pipeline using one of the available Pipeline Editors.
' Set the Language to VBScript, choose File and set the file to DumpOrder.vbs (this file).
'
' In addition, this script assumes you set the filename parameter to a
' valid filename for output. The directory the output file is written to must be set up to
' have write access via the user your IIS is running as.
'
' For example, you could set
' filename=c:\orderdump.log
' in the Parameters control.
' 
' This would assume your IIS user can write to c:\
'
function mscsexecute(config, orderform, context, flags)

	Set fs = CreateObject("Scripting.FileSystemObject")
	Set a = fs.CreateTextFile(config.filename, True)

	DumpOrderForm orderform, a

	a.Close

    mscsexecute = 1

end function

sub DumpItem(byRef item, byRef a)

	' Dump all key/value pairs from a dictionary
	for each key in item
		on error resume next
		a.WriteLine("		Key [" + key + "] {" + TypeName(Key) + "} Value [" + cstr(item.Value(key)) + "] {" + TypeName(item.Value(Key)) + "}")
		if err.number > 0 then 
			if err.number = 450 then 
				DumpItem key, a
			else
				a.writeline " *** ERROR in DumpItem # " & CStr(Err.Number) & " " & Err.Description
			end if
		end if
	next

end sub

sub DumpItems(byRef items, byRef a)

	'Iterate over List of Dictionaries, dump each dictionary
	n = 1
	for each item in items
		on error resume next
		a.WriteLine("	Item " + cstr(n))
		if err.number > 0 then a.writeline " *** ERROR in DumpItems # " & CStr(Err.Number) & " " & Err.Description
		DumpItem item, a
		n = n + 1
	next

end sub

sub DumpList(byRef list, byRef a)

	'Iterates over list, write out each item and type
	for each item in list
		on error resume next
		a.WriteLine("	Value [" + item + "] {" + TypeName(item) + "}")
		if err.number > 0 then
			if err.number = 450 then 
				a.WriteLine(" ")
				a.WriteLine("	Start Dictionary")
				DumpItem item, a
				a.WriteLine("	End of Dictionary")
				a.WriteLine(" ")
				
			else
				a.writeline " *** ERROR in DumpList # " & CStr(Err.Number) & " " & Err.Description
			end if
		end if
	next

end sub

sub DumpOrderForm(byRef orderForm, byRef a)

	a.WriteLine("** Orderform Contents **")

	for each key in orderForm

		if VarType(orderForm.Value(key)) <> vbObject then

			' Dump out top level items
			a.WriteLine("Order Key [" + key + "] {" + TypeName(Key) + "} Value [" + cstr(orderForm.Value(key)) + "] {" + TypeName(orderForm.Value(key)) + "}")
		
		elseif key = "Items" then
		
			' Dump out Items List
			a.WriteLine("Items List")
			DumpItems orderForm.Value(key), a
			a.WriteLine("End of Items List")
			a.WriteLine(" ")

		elseif key = "_Verify_With" then
			' Dump out _Verify_With Dictionary
			a.WriteLine(" ")
			a.WriteLine("Order Key is [_Verify_With] Start Dictionary")
			DumpItem orderForm.Value(key), a
			a.WriteLine("End of Dictionary")
			a.WriteLine(" ")

		else
			' Some object, assume it is a list
			a.WriteLine(" ")
			a.WriteLine("Order Key is [" + key + "]" + " Start List")
			on error resume next
			DumpList orderForm.Value(key), a
			if err.number > 0 then
				if err.number = 438 Then
					if TypeName(orderForm.Value(key)) = "IContentList" then
						a.writeline " *** unable to write the contents of a " & TypeName(orderForm.Value(key)) & " with " & orderForm.Value(key).Count & " rows."
					end if
				else
					a.writeline " *** ERROR in DumpOrderForm # " & CStr(Err.Number) & " " & Err.Description				
				end if 
			end if
			a.WriteLine("End of List")
			a.WriteLine(" ")

		end if

	next

	a.WriteLine("** End of Orderform Contents **")

end sub
