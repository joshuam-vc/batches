@echo off
color a
echo Fixing the internet.
ipconfig /release
ipconfig /flushdns
ping localhost -t 300 > nul
ipconfig /renew