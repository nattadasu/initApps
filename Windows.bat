@echo off
setlocal
echo Switching script to PowerShell
echo ==============================
echo If PowerShell fail to load, please download and install the latest version of PowerShell from https://www.microsoft.com/en-us/download/details.aspx?id=48126
echo ---
echo If PowerShell throw an error to run the script, type `powershell` on cmd and type following snippet:
echo Set-ExecutionPolicy AllSigned
echo ---
PowerShell -Command ".\Windows.ps1"