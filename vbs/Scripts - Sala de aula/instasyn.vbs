'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
'  File:      InstallSiteStatus.vbs
'
'  Summary:   Adds the Site Status SnapIn as a resource to the specified Site
'
'  Sample:    Site Status SnapIn
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

'Site name to add the Open/Close snapin
'specified at the command line as:
'cscript InstallSiteStatus.vbs <site name>
sSiteName = WScript.Arguments(0)

sResourceName = "Site Open/Close Applications"

Dim oResCfg

Set oResCfg = CreateObject("CommerceSDK.ResourceConfig")
Call oResCfg.Initialize("(local)", "sa", vbNullString)

'Create the resource schema
'First the resource type
Call oResCfg.CreateResource(vbNullString, "MSCS_SDKSiteStatus", "SDKSiteStatus", 6, 0, "CommerceSDK.SiteStatus")

'Then the properties
Call oResCfg.CreateProperty("SDKSiteStatus", "s_AppName", 0, 1, 0, "SDK SiteStatus Application Name", 8200, vbNullString, "s_AppName")
Call oResCfg.CreateProperty("SDKSiteStatus", "s_AppStatus", 0, 1, 0, "SDK SiteStatus Application Status", 8200, vbNullString, "s_AppStatus")
Call oResCfg.CreateProperty("SDKSiteStatus", "s_AppClosedURL", 0, 1, 0, "SDK SiteStatus Application ClosedURL", 8200, vbNullString, "s_AppClosedURL")
 
' Initialize the MSCSSiteConfigAdmin to the selected site
Dim objSiteCfg
Set objSiteCfg = CreateObject("Commerce.SiteConfig")
objSiteCfg.Initialize sSiteName

'Add the SiteStatus snapin to the resources table

objSiteCfg.CreateComponentConfig sResourceName, "MSCS_SDKSiteStatus"
objSiteCfg.Fields(sResourceName).Value.Fields("s_Description") = "SDK Site Status Resource"
objSiteCfg.SaveConfig
