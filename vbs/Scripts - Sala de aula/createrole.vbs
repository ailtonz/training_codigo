'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
'  File:      CreateResource.VBS
'
'  Summary:   Creates a new resource definition in the admin db using the
'             CommerceSDK.ResourceConfig object.  Only works if you have 
'             previously built the VB project
'
'  Sample:    ResourceConfig Object
'
'---------------------------------------------------------------------
'  This file is part of the Microsoft Commerce Server 2000 SDK
'
'  Copyright (C) 2000 Microsoft Corporation.  All rights reserved.
'
' This source code is intended only as a supplement to Microsoft
' Commerce Server 2000 and/or on-line documentation.  See these other
' materials for detailed information regarding Microsoft code samples.
'
' THIS CODE AND INFORMATION ARE PROVIDED "AS IS" WITHOUT WARRANTY OF ANY
' KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
' IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS FOR A
' PARTICULAR PURPOSE.
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

Set oResCfg = CreateObject("CommerceSDK.ResourceConfig")

Call oResCfg.Initialize("(local)", "sa", vbNullString)

Call oResCfg.CreateResource(vbNullString, "MSCS_SDKObjectSample", "SDKResConfigObject", 6, 0, "CommerceSDK.ResourceConfig")

Call oResCfg.CreateProperty("SDKResConfigObject", "strFooProp", 0, 0, 0, "Resource Config Object Test", 8, vbNullString, "ResCfg Prop One")