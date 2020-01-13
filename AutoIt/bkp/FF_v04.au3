#Include <FF.au3>

;~ _FFStart()
Sleep(1000)
_FFWindowOpen("www.yahoo.com")

;~ If _FFIsConnected() Then
;~     $sStringToSearch = "www.google.com"
;~     sleep (2000)
;~     If _FFSearch($sStringToSearch) Then
;~         ; add a new tab with an URL
;~         _FFWindowOpen("http://ff-au3-example.thorsten-willert.de/")
;~         Sleep(1000)
;~         _FFWindowOpen("www.msn.com")
;~         Sleep(1000)
;~         _FFWindowOpen("www.yahoo.com")
;~         Sleep(1000)
;~         _FFWindowOpen("google.com")
;~     EndIf
;~ Else
;~ EndIf