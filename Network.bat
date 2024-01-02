@echo off
title Network
:control
cls
for /f "tokens=2,3 delims={,}" %%a in ('"WMIC NICConfig where IPEnabled="True" get DefaultIPGateway /value | find "I" "') do set ipAddress=%%~a
nmap -sS -p 7899 %ipAddress%/24 | findstr /v "PORT     STATE  SERVICE" | findstr /v "closed" | findstr /v "MAC" | findstr /v "Host" | findstr /v "done" | findstr /v "Starting" > "%temp%\temp__"
type "%temp%\temp__" | findstr /l "filtered" > nul
if errorlevel 1 echo No devices found & pause & goto control
type "%temp%\temp__"
:loopend
set /p ssdf=
goto loopend