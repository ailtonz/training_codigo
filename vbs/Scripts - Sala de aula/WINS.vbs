
Private Function GetOrgAppClause(strInput, strDirection)
	'// This function returns the clause (excluding where) for Orgs and Apps
	'// Works for both directions (Source and Dest)
	'// Uses BuildAllOrgs and BuildOrgAppDict
	
	'// INPUTS
	'// strInput = a string that contains the Orgs and Apps selected from the main page
	'// Input format: Org1:app1,app2,app3;Org2;Org3 etc.
	'// strDirection = indicated whether we are looking at the source or destination perspective
	
	'// Usage
	'// Called from results page

    Dim objDictionary 
    
    Set objDictionary = CreateObject("Scripting.Dictionary")
    
    BuildOrgAppDict strInput, objDictionary
    If strDirection = DIRECTION_SOURCE Then
        GetOrgAppClause = BuildAllOrgs(objDictionary, "dta_routing_details.nvcSrcOrgName", _
			"dta_routing_details.nvcSrcAppName")
    Else
        GetOrgAppClause = BuildAllOrgs(objDictionary, "dta_routing_details.nvcDestOrgName", _
			"dta_routing_details.nvcDestAppName")
    End If
    
End Function

Private Sub BuildOrgAppDict(sInput, Dict)
	'// INPUTS
	'// sInput = a string that contains the Orgs and Apps selected from the main page
	'// Input format: Org1:app1,app2,app3;Org2;Org3 etc.
	'// strDirection = indicated whether we are looking at the source or destination perspective
	
	'//Adds Orgs and Apps to Dictionary Object on page general.vb
	
    Dim sOutput 
    Dim vArray1 
    Dim sOrg 
    Dim sApps 
    Dim sApp 
    Dim sTemp 
    
    Dim i 
    Dim j
    
    Dim oDict 
    
    Set oDict = Dict
    
    vArray1 = Split(sInput, SEP_ORGAPPLIST_ORG)
    
    For i = 0 To UBound(vArray1)
        'Find the org
        sTemp = vArray1(i)
        j = InStr(sTemp, SEP_ORGAPPLIST_ORGAPP)
        If j > 0 Then
            sOrg = Mid(sTemp, 1, j - 1)
            sApps = Mid(sTemp, j + Len(SEP_ORGAPPLIST_ORGAPP))
            oDict.Add sOrg, sApps
        Else
            sOrg = sTemp
            sApps = ""
            oDict.Add sOrg, ""
        End If
    Next      
End Sub


Private Function BuildOneOrg(OrgName, AppList, OrgFieldName, AppFieldName) 
    '//Builds where clause for a single Org and App pair
    '//Receives input parameters from the BuildAllOrgs Function
    Dim sOrgPart 
    Dim sAppPart 
    Dim sTemp 
    Dim varray
    Dim i 
    Dim j 

		sOrgPart = OrgFieldName & " = N'" & OrgName & "'"
		If Trim(AppList) = "" Then
		    BuildOneOrg = "(" & sOrgPart & ")"
		Else
			vArray = Split(AppList, ",")
			i = UBound(vArray)
			If i = 0 Then
			    sAppPart = AppFieldName & " = N'" & Trim(AppList) & "'"
			Else
			    sAppPart = "("
			    For j = 0 To i - 1
			        sAppPart = sAppPart & AppFieldName & " = N'" & Trim(vArray(j)) & "' OR "
			    Next
			    sAppPart = sAppPart & AppFieldName & " = N'" & Trim(vArray(j)) & "')"
			End If
        BuildOneOrg = "(" & sOrgPart & " AND " & sAppPart & ")"
		End If

End Function

Public Function BuildAllOrgs(Dict, OrgFieldName, AppFieldName)
	'//Builds where clause for Orgs and Apps from info generated 
	'//  in the BuildOneOrg Clause
	
    Dim oDict 
    Dim varray
    Dim sResult 
    Dim iCount
    Dim sOrg, sApp 
    Dim i 
    
    
    Set oDict = Dict
    iCount = oDict.Count
 
    If iCount = 0 Then
        sResult = ""
        BuildAllOrgs = sResult
        Exit Function
    Else
        vArray = oDict.Keys
        If iCount = 1 Then
            sOrg = vArray(0)
'			if sOrg = "is null" then
'				BuildAllOrgs = OrgFieldName & " is Null"
'				Exit Function
'			end if
            sApp = oDict(sOrg)
            sResult = "(" & BuildOneOrg(sOrg, sApp, OrgFieldName, AppFieldName) & ")"
            BuildAllOrgs = sResult
            Exit Function
        Else
            sResult = "("
            For i = 0 To iCount - 2
                sOrg = vArray(i)
                sApp = oDict(sOrg)
                sResult = sResult & BuildOneOrg(sOrg, sApp, OrgFieldName, AppFieldName) & " OR "
            Next
            sOrg = vArray(iCount - 1)
            sApp = oDict(sOrg)
            sResult = sResult & BuildOneOrg(sOrg, sApp, OrgFieldName, AppFieldName) & ")"
            BuildAllOrgs = sResult
            Exit Function
        End If
    End If
   
End Function

Private Function GetDocClause (sInput, sDirection)
	'//This function returns the where clause (excluding where) for DocTypes
	'//Works for both directions
	'//Assuming the format: doc1,doc2,doc3,...,docn
	'//Inputs: 
	'//Uses: BuildDocDict and BuildAllDocs
	If sDirection = DIRECTION_SOURCE Then
        GetDocClause = BuildAllDocs(sInput, "dta_indoc_details.nvcDocType")
    ElseIf sDirection = DIRECTION_DESTINATION Then
		GetDocClause = BuildAllDocs(sInput, "dta_outdoc_details.nvcDocType")
	Else
		GetDocClause = ""
	End If
    
End Function

Private Function GetDateRangeClause(FromDate, ToDate, TimezoneOffset)
	'//This function returns the where clause (excluding where) for DateRange
	'//Input:  Dates is formatted: date1,date2
	FromDate = DateAdd("h", TimezoneOffset, FromDate)
	ToDate = DateAdd("h", TimezoneOffset, ToDate)
	'//Use SQL Server Convert function to convert date strings to datetime values
	'//using ODBC Canonical style (style 120)
	FromDate = "convert(datetime, '" & Year(FromDate) & "-" & Pad(Month(FromDate), "0", 2) _
		& "-" & Pad(Day(FromDate), "0", 2) & " " & Pad(Hour(FromDate), "0", 2) _
		& ":" & Pad(Minute(FromDate), "0", 2) & ":" & Pad(Second(FromDate), "0", 2) _
		& "', 120)"
	ToDate = "convert(datetime, '" & Year(ToDate) & "-" & Pad(Month(ToDate), "0", 2) _
		& "-" & Pad(Day(ToDate), "0", 2) & " " & Pad(Hour(ToDate), "0", 2) _
		& ":" & Pad(Minute(ToDate), "0", 2) & ":" & Pad(Second(ToDate), "0", 2) _
		& "', 120)"
	
	GetDateRangeClause = "dta_interchange_details.dtProcessedTimeStamp between " & _ 
	                     FromDate & " and " & ToDate
End Function

Private Function GetSortOrderClause(SortOrder)
    '//Returns the order by clause for Sort Order Generated on the Submit page
    '//
    'Input: 012315. Assume we will always have 6 numbers passed in and each will
    '		fall between 0 and 5.
    'Output: the clause in "ORDER BY A, B, C ..."
    'Meaning of 0 - 5:
    '0: nvcSrcOrgName
    '1: nvcSrcAppName
    '2: nvcDestOrgName
    '3: nvcDestAppName
    '4: nvcDocType
    '5: dtProcessedTime

    Dim i, j, intNumber, strNumber
    Dim strRawArray(5)
    Dim strOrderArray(5)
    Dim strFieldArray(5)
    Dim strTemp
    Dim strResult
    
    'Get the raw array
    For i = 0 To 5
        strRawArray(i) = Mid(SortOrder, i + 1, 1)
    Next

    'Get the order array where repeated values are replaced
    'by ""
    For i = 0 To 5
        strTemp = strRawArray(i)
        'Find if it has appeared previously
        For j = 0 To i - 1
            If strTemp = strRawArray(j) Then
                strTemp = ""
                Exit For
            End If
        Next
        strOrderArray(i) = strTemp
    Next 
        
            
    'Define strFieldArray
    strFieldArray(0) = "temp1.nvcSrcOrgName"
    strFieldArray(1) = "temp1.nvcSrcAppName"
    strFieldArray(2) = "temp1.nvcDestOrgName"
    strFieldArray(3) = "temp1.nvcDestAppName"
    strFieldArray(4) = "temp1.nvcDocType"
    strFieldArray(5) = "inter.dtProcessedTimeStamp"
    
    'Generate the final string

    strNumber = strOrderArray(0)
    intNumber = CInt(strNumber)
    strResult = strFieldArray(intNumber)
    For i = 1 To 5
        strNumber = strOrderArray(i)
        If strNumber <> "" Then
            intNumber = CInt(strNumber)
            strResult = strResult & ", " & strFieldArray(intNumber)
        End If
    Next 
    GetSortOrderClause = strResult
        
End Function

Private Function ShowSortOrder(SortOrder)
	'//Very similar to GetSortOrderClause
	'//Result is for Sort Order in "View Parameters" table
    'Input: 0123145. Assume we will always have 6 numbers passed in and each will fall
    '		between 0 and 5
    'Output: a string in the form of "Source Organization, ..."
    'Meaning of 0 - 5:
    '0: Source Org
    '1: Source Application
    '2: Destination Organization
    '3: Destination Application
    '4: Document Type
    '5: Time Processed

    Dim i, j, intNumber, strNumber
    Dim strRawArray(5)
    Dim strOrderArray(5)
    Dim strNameArray(5)
    Dim strTemp
    Dim strResult
    
    'Get the raw array
    For i = 0 To 5
        strRawArray(i) = Mid(SortOrder, i + 1, 1)
    Next

    'Get the order array where repeated values are replaced
    'by ""
    For i = 0 To 5
        strTemp = strRawArray(i)
        'Find if it has appeared previously
        For j = 0 To i - 1
            If strTemp = strRawArray(j) Then
                strTemp = ""
                Exit For
            End If
        Next
        strOrderArray(i) = strTemp
    Next 
                   
    'Define strFieldArray
    const L_SourceOrganization_StaticText = "Source Organization"
    const L_SourceApplication_StaticText = "Source Application"
    const L_DestinationOrganization_StaticText = "Destination Organization"
    const L_DestinationApplication_StaticText = "Destination Application"
    const L_DocumentType_StaticText = "Document Type"
    const L_TimeProcessed_StaticText = "Time Processed"
    strNameArray(0) = L_SourceOrganization_StaticText
    strNameArray(1) = L_SourceApplication_StaticText
    strNameArray(2) = L_DestinationOrganization_StaticText
    strNameArray(3) = L_DestinationApplication_StaticText
    strNameArray(4) = L_DocumentType_StaticText
    strNameArray(5) = L_TimeProcessed_StaticText
    
    'Generate the final string

    strNumber = strOrderArray(0)
    intNumber = CInt(strNumber)
    strResult = strNameArray(intNumber)
    For i = 1 To 5
        strNumber = strOrderArray(i)
        If strNumber <> "" Then
            intNumber = CInt(strNumber)
            strResult = strResult & ", " & strNameArray(intNumber)
        End If
    Next 
        
    ShowSortOrder = strResult
        
End Function

Private Function BuildAllDocs(sInput, DocFieldName)
    Dim vArray, sResult, iBound, i 

    If Trim(sInput) = "" Then
		sResult = ""
		BuildAllDocs = sResult
		Exit Function
	End If
	
    vArray = Split(sInput, ",")
	iBound = UBound(vArray)
	
	sResult =""
	For i = 0 To iBound - 1
            sDocType = Trim(vArray(i))
            sResult = sResult & DocFieldName & " = N'" & sDocType & "' OR "
    Next
    sDocType = Trim(vArray(iBound))
    sResult = sResult & DocFieldName & " = N'" & sDocType & "'"
    BuildAllDocs = "(" & sResult & ")" 
End Function

'This function returns the where clause (excluding where) for captured field targeting
'Input: expression like clause1;clause2;...;clausen
'       clause1 = FieldNameKey,FieldType,Logical Operator,Value,Grouping Operator
'Output: Where clause
Private Function GetCapturedFieldClause(Expression, TimezoneOffset)
    Dim i
    Dim iCount
    Dim j
    Dim k
    Dim sTemp
    Dim sTemp2
    Dim sBefore
    Dim sAfter
    Dim sResult
    Dim sTempClause
    
    sTemp = Expression
    If Trim(sTemp) = "" Then
        GetCapturedFieldClause = ""
        Exit Function
    End If

    i = InStr(1, sTemp, OP_GROUPING_AND)
    If i = 0 Then 'if AND is not found in the expression
        'Find the first OR
        sTemp = Trim(sTemp)
        j = InStr(sTemp, OP_GROUPING_OR)
        sResult = ""
        iCount = 0
        sTemp2 = sTemp
        Do While (j > 0 And sTemp2 <> "" And sTemp2 <> SEP_EXP_CLAUSE)
            'MsgBox sTemp2
			'MsgBox j
            sTempClause = Mid(sTemp2, 1, j - 1)
            If iCount > 0 Then
                sResult = sResult & " OR " & GetSQLForOneClause(sTempClause, TimezoneOffset)
            Else
                sResult = GetSQLForOneClause(sTempClause, TimezoneOffset)
            End If
            iCount = iCount + 1
            j = InStr(sTemp2, OP_GROUPING_OR)
            if j > 0 Then
				sTemp2 = Mid(sTemp2, j + 3)
				j = Instr(sTemp2, OP_GROUPING_OR)
			Else
				
			End If            
        Loop
        'MsgBox sTemp2
        If iCount = 0 Then
            GetCapturedFieldClause = GetSQLForOneClause(sTemp, TimezoneOffset)
        Else
            If (sTemp2 <> "") And (sTemp2 <> SEP_EXP_CLAUSE) Then
                GetCapturedFieldClause = "( " & sResult & " OR " & GetSQLForOneClause(sTemp2, TimezoneOffset) & " )"
            Else
                GetCapturedFieldClause = "( " & sResult & " )"
            End If
        End If
    Else
        sBefore = Mid(sTemp, 1, i - 1)
        j = InStr(1, sBefore, OP_GROUPING_OR)
        If j > 0 Then
            sBefore = "( " & GetCapturedFieldClause(sBefore, TimezoneOffset) & " )"
        Else
            sBefore = GetCapturedFieldClause(sBefore, TimezoneOffset)
        End If
        sAfter = Mid(sTemp, i)
        sAfter = Trim(sAfter)
        If Trim(sAfter) = OP_GROUPING_AND Then
            GetCapturedFieldClause = sBefore
            Exit Function
        Else
            sAfter = Mid(sAfter, 5)
            sAfter = Trim(sAfter)
            GetCapturedFieldClause = sBefore & " AND " & GetCapturedFieldClause(sAfter, TimezoneOffset)
        End If
    End If    
End Function

'----------------------------------------------------
'Returns the SQL for one clause in the expression
'Input: assume FieldNameKey,FieldType,Logical Operator,Value,
'Assumptions:
'   Field Type:
'       DATATYPE_REAL: Real
'       DATATYPE_INT: Integer
'       DATATYPE_DATE: date
'       DATATYPE_STRING: String
'   Operators:
'       >
'       <
'       =
'		!=
'Notes:
'1: We need to check what operators apply to what datatype
'	Integer: <, >, =, != They are all safe.
'   Real: all safe
'	String: All four cases has been tested.
'	Date: All four cases has been tested.
Private Function GetSQLForOneClause(Clause, TimezoneOffset)
    Dim nFieldNameKey
    Dim tnFieldType
    Dim sOperator
    Dim sValue
    Dim sGrouping
    Dim sWhere
    Dim dtTemp
    
    Dim sTemp
    Dim i

	sTemp = Clause
	'Get the individual values from the clause
	'Get fieldnamekey
	'msgbox stemp
	i = InStr(1, sTemp, SEP_EXP_FIELD)
	nFieldNameKey = Mid(sTemp, 1, i - 1)
	sTemp = Mid(sTemp, i + Len(SEP_EXP_FIELD))

	'Get data type
	i = InStr(1, sTemp, SEP_EXP_FIELD)
	tnFieldType = Mid(sTemp, 1, i - 1)
	sTemp = Mid(sTemp, i + Len(SEP_EXP_FIELD))

	'Get Logical Operator
	i = InStr(1, sTemp, SEP_EXP_FIELD)
	sOperator = Mid(sTemp, 1, i - 1)
	sTemp = Mid(sTemp, i + Len(SEP_EXP_FIELD))

	'Get Value
	i = InStr(1, sTemp, SEP_EXP_FIELD)
	'MsgBox i
	sValue = Mid(sTemp, 1, i - 1)
	'sTemp = Mid(sTemp, i + Len(SEP_EXP_FIELD))

	'Determine if this clause is a 'normal' clause, or a custom
	'search clause
	If nFieldNameKey = "0" Then
		'Custom Search clause

		'Construct the where clause
		sWhere = "dta_outdoc_details.nvcCustomSearch"
		If sOperator = strContains_Text Then
			sWhere = sWhere & " like N'%"
		ElseIf sOperator = L_Does_not_contain Then
			sWhere = sWHere & " not like N'%"
		End If
		sWhere = sWhere & sValue & "%'"
	Else
		''Normal' clause
		If CInt(tnFieldType) = DATATYPE_REAL Then 'Real
			sWhere = "(dta_outdoc_details.nRealName1 = " & CLng(nFieldNameKey) & _
					 " AND dta_outdoc_details.rlRealValue1 " & sOperator & " " & sValue & ") OR " & _
					 "(dta_outdoc_details.nRealName2 = " & CLng(nFieldNameKey) & _
					 " AND dta_outdoc_details.rlRealValue2 " & sOperator & " " & sValue & ")"
		End If
		
		If CInt(tnFieldType) = DATATYPE_INT Then 'Integer
			sWhere = "(dta_outdoc_details.nIntName1 = " & CLng(nFieldNameKey) & _
					 " AND dta_outdoc_details.nIntValue1 " & sOperator & " " & sValue & ") OR " & _
					 "(dta_outdoc_details.nIntName2 = " & CLng(nFieldNameKey) & _
					 " AND dta_outdoc_details.nIntValue2 " & sOperator & " " & sValue & ")"          
		End If
		
		If CInt(tnFieldType) = DATATYPE_DATE Then 'Date
			'Manipulate the offset
			dtTemp = CDate(sValue)
			dtTemp = DateAdd("h", TimezoneOffset, dtTemp)
			sValue = CStr(dtTemp)
			sWhere = "(dta_outdoc_details.nDateName1 = " & CLng(nFieldNameKey) & _
					 " AND dta_outdoc_details.dtDateValue1 " & sOperator & " " & "'" & sValue & "') OR " & _
					 "(dta_outdoc_details.nDateName2 = " & CLng(nFieldNameKey) & _
					 " AND dta_outdoc_details.dtDateValue2 " & sOperator & " " & "'" & sValue & "')"
				
		End If
		
		If CInt(tnFieldType) = DATATYPE_STRING Then 'String
			sWhere = "(dta_outdoc_details.nStrName1 = " & CLng(nFieldNameKey) & _
					 " AND dta_outdoc_details.nvcStrValue1 " & sOperator & " " & "N'" & sValue & "') OR " & _
					 "(dta_outdoc_details.nStrName2 = " & CLng(nFieldNameKey) & _
					 " AND dta_outdoc_details.nvcStrValue2 " & sOperator & " " & "N'" & sValue & "')"            
		End If
		'MsgBox "Clause: " & clause & "tnFieldType: " & tnFieldType & " sWhere: " & sWhere      
	End If

	GetSQLForOneClause = "( " & sWhere & " )"
End Function
'---------------------------------------

'Combine an array of where clauses
Private Function GetCombinedWhereClause(a_strClauses(), blnAddWhere)
	Dim intCounter
	Dim strCombinedClause

	'Initialize
	strCombinedClause = ""

	'Loop through the array
	For intCounter = 0 To UBound(a_strClauses)
		'Only add this clause if it's non-empty
		If Trim(a_strClauses(intCounter)) <> "" Then
			If Trim(strCombinedClause) = "" Then
				'This is the first time, so we shouldn't add the "and"
				strCombinedClause =  " " & a_strClauses(intCounter)
			Else
				strCombinedClause = strCombinedClause & " and " & a_strClauses(intCounter)
			End If
		End If
	Next

	'Add the keyword "Where" if necessary
	If blnAddWhere Then
		If Trim(strCombinedClause) <> "" Then
			strCombinedClause = "where " & strCombinedClause
		End If
	End If
	
	GetCombinedWhereClause = strCombinedClause
End Function

Private Function GetIMRoutingWhereClause(Guid, blnAddWhere)
	Dim strClause

	If Trim(GUID) <> "" Then
		strClause = "dta_routing_details.uidChannelGUID = '" & _
			Guid & "' "
	Else
		strClause = " "
	End If

	'Add the keyword "Where" if necessary
	If blnAddWhere Then
		If Trim(strClause) <> "" Then
			strClause = " where " & strCombinedClause
		End If
	End If

	GetIMRoutingWhereClause = strClause
End Function