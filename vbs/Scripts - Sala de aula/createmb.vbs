Set MyNameSpace = GetObject("winmgmts://./root/MicrosoftHIS")
Set MyLuClass = MyNameSpace.Get("MsSna_LuDisplay")
Set MyLUInstance = MyLuClass.SpawnInstance_

For nLU = 30 to 40
MyLuInstance.Name = "MyLU" & nLU
MyLuInstance.ConnectionName = "MYCONN"
MyLUInstance.Put_
Next
