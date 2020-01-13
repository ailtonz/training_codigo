<SCRIPT LANGUAGE='VBScript'>
	<!--	
			
	' NOTE: window.event.XMLrecord returns an XML Node with child nodes for each column.
	'	<RECORD>
	'		<GUID>...</GUID>
	'		<NAME>...</NAME>
	'		<DESCRIPTION>...</DESCRIPTION>
	'		...
	'	</RECORD>
	'	oSelection.firstChild.nodeName					would return the first column name
	'	oSelection.childNodes(0).nodeName				is the same as oSelection.firstChild.nodeName
	'	oSelection.firstChild.text							would return the first column value (contained text)
	'	oSelection.selectSingleNode("name").text	would return the value for the column named "name"
		
	const PAGE_SIZE = 20
	Public g_aSelectedItems
	Public g_nItemsSelected
	Public g_sKeyString
	Redim g_aSelectedItems(0)
			
	Sub AddItem()
	' note: g_nItemsSelected is 1-based, array items are 0-based
		dim oSelection, sKey, iCount	
		
		ReDim Preserve g_aSelectedItems(g_nItemsSelected)
		set oSelection = window.event.XMLrecord
		sKey = oSelection.selectSingleNode("auction_id").text
		iCount = UBound(g_aSelectedItems)
		g_aSelectedItems(iCount) = sKey
		g_nItemsSelected = g_nItemsSelected + 1
		g_sKeyString = Join(g_aSelectedItems, ";")
	End Sub
	
	Sub RemoveItem()
		dim oSelection, sKey, iCount, i
	
	    set oSelection = window.event.XMLrecord
	    sKey = oSelection.selectSingleNode("auction_id").text
	    iCount = UBound(g_aSelectedItems)
	    for i = 0 to iCount
		    ' Remove item from the array and copy the last item into the empty space
		    if g_aSelectedItems(i) = sKey then
			    g_aSelectedItems(i) = empty
			    g_aSelectedItems(i) = g_aSelectedItems(iCount)
			    redim preserve g_aSelectedItems(iCount -1)
			    g_nItemsSelected = g_nItemsSelected -1
			    g_sKeyString = Join(g_aSelectedItems, ";")
	            exit for
	        end if
	    next
	End Sub
	
	Sub SetTaskButtons()
		select case g_nItemsSelected
			case 0
				DisableTask "delete"
				DisableTask "viewdetails"
				DisableTask "open"
				DisableTask "process"
				sText = "<%= L_NoItemsSelected_Message %>"
			case 1
				EnableTask "delete"	
				EnableTask "viewdetails"
				EnableTask "open"
				EnableTask "process"
				sText = "<%=L_OneItemSelected_Message%>"
			case else
				EnableTask "delete"	
				DisableTask "viewdetails"
				DisableTask "open"
				EnableTask "process"
				sText = sFormatString("<%= L_NItemsSelected_Message%>", Array(g_nItemsSelected))
		end select
		if selectform.seltype.value = "all" then
			EnableTask "process"
			EnableTask "delete"
			sText = "<%=L_AllItemsSelected_Message%>"
		end if
		setStatusText sText		
	End Sub
  
	sub OnUnSelectRow()
		selectform.seltype.value = ""
		call RemoveItem()
		call SetTaskButtons()
	 end sub

	sub OnSelectRow()
		selectform.seltype.value = ""
		call AddItem()
		call SetTaskButtons()     
	end sub

	sub OnSelectAllRows()
		selectform.seltype.value = "all"
		redim g_aSelectedItems(0)
		g_aSelectedItems(0) = empty
		g_nSelectedItems = 0
		g_sKeyString = ""
		call SetTaskButtons()
	end sub
	  
	sub OnUnSelectAllRows()
		selectform.seltype.value = ""
		redim g_aSelectedItems(0)
		g_aSelectedItems(0) = empty
		g_nItemsSelected = 0
		g_sKeyString = ""
		call SetTaskButtons()
	end sub  
	
	Sub EnableFind()
		Dim sValue
		
		sValue = selfindby.value
		select case sValue
			case "ProductName"
				If ProductName.value <> "" And ProductName.valid Then
					findbyform.btnfindby.disabled = false
				Else
					findbyform.btnfindby.disabled = true
				End If
			case "AuctionDate"
				if selfindby.value = "from" then
					if bIsDate(EndDate.value) and bIsDate(StartDate.value) then
						' Disable find if end date is less than start date
						if dtGetDate(EndDate.value) - dtGetDate(StartDate.value) >= 0 then
							' Disable find if end_date < start_date
							findbyform.btnfindby.disabled = false
						else
							findbyform.btnfindby.disabled = true
						end if
					else
						findbyform.btnfindby.disabled = true
					end if	
				else	' On or Before
					if bIsDate(StartDate.value) then
						findbyform.btnfindby.disabled = false
					else
						findbyform.btnfindby.disabled = true
					end if
				end if
			case "ProductAndDate"
				If ProductName.value = "" or ProductName.valid = false Then
					findbyform.btnfindby.disabled = true
				else
					if selfindby.value = "from" then
						if bIsDate(EndDate.value) and bIsDate(StartDate.value) then
							' Disable find if end date is less than start date
							if dtGetDate(EndDate.value) - dtGetDate(StartDate.value) >= 0 then
								' Disable find if end_date < start_date
								findbyform.btnfindby.disabled = false
							else
								findbyform.btnfindby.disabled = true
							end if
						else
							findbyform.btnfindby.disabled = true
						end if	
					else	' On or Before
						if bIsDate(StartDate.value) then
							findbyform.btnfindby.disabled = false
						else
							findbyform.btnfindby.disabled = true
						end if
					end if
				end if
			case "All", "Unprocessed", "Active"
				findbyform.btnfindby.disabled = false
		end select
	end sub	
 -->
</SCRIPT>
