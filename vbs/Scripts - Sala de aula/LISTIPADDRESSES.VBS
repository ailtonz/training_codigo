Set MyNameSpace=GetObject("winmgmts://./root/MicrosoftHIS")
Set CONNs=MyNameSpace.InstancesOf("MsSna_ConnectionSdlc")
For each CONN in CONNs
Wscript.Echo CONN.Name
Next