c:\tools\dhcpcmd.exe 192.168.9.200 createsubnet 192.168.9.0 255.255.255.0 Van-gc
c:\tools\dhcpcmd.exe 192.168.9.200 addiprange 192.168.9.0 192.168.9.101 192.168.9.199
c:\tools\dhcpcmd.exe 192.168.9.200 setsubnetoptionvalue 192.168.9.0 6 string "192.168.9.200"
c:\tools\dhcpcmd.exe 192.168.9.200 setsubnetoptionvalue 192.168.9.0 15 string "nwtraders.msft"
c:\tools\dhcpcmd.exe 192.168.9.200 /norpc addserver van-gc.nwtraders.msft 192.168.9.200 