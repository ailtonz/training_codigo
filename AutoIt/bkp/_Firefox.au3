$FF = @ProgramFilesDir & "\Mozilla Firefox\firefox.exe -new-tab "
$url = "http://10.20.142.117:8081/caixaEntrada/index.jsp?close=1"
Run($FF & $url, "", @SW_MAXIMIZE)
