Set MyNameSpace = GetObject("winmgmts://./root/MicrosoftHIS")
Set MyClass = MyNameSpace.Get("MsSna_Adapter8022Dlc")
Set MyInstance = MyClass.SpawnInstance_

MyInstance.Name = "SNADLC2"
MyInstance.Server = "Acapulco"

MyInstance.Put_