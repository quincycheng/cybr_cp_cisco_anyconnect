@echo off

REM ================================================
REM Fetch Secrets from CyberArk Secrets Manager
REM ================================================

set cp_dir=C:\Program Files (x86)\CyberArk\ApplicationPasswordSdk
SET PATH=%PATH%;%cp_dir%

REM Construct the path to credentials in CyberArk Vault using logged on user name
set path_vpn_cred=Safe^=VPN;Folder^=Root;Object^=Security Appliance-CiscoAnyConnectVPN-%username%

for /f "delims=" %%a in ('CLIPasswordSDK.exe GetPassword /p AppDescs.AppID^=CiscoAnyConnectClient /p Query^="%%path_vpn_cred%%" /o Password') do set pwd=%%a 
for /f "delims=" %%a in ('CLIPasswordSDK.exe GetPassword /p AppDescs.AppID^=CiscoAnyConnectClient /p Query^="%%path_vpn_cred%%" /o PassProps.UserName') do set user_id=%%a 
for /f "delims=" %%a in ('CLIPasswordSDK.exe GetPassword /p AppDescs.AppID^=CiscoAnyConnectClient /p Query^="%%path_vpn_cred%%" /o PassProps.Address') do set cybr_vpn_host=%%a 

CALL :TRIM %pwd% pwd
CALL :TRIM %user_id% user_id

REM ================================================
REM Login to VPN
REM ================================================

taskkill /IM "vpnui.exe" /F > nul 2> nul

set install_dir="C:\Program Files (x86)\Cisco\Cisco AnyConnect Secure Mobility Client"
SET PATH=%PATH%;%install_dir%

if "%~1"=="/LPipe" goto :/LPipe
if "%~1"=="/RPipe" goto :/RPipe

"%~f0" /LPipe | "%~f0" /RPipe
pause
exit /b

:/LPipe
REM This will be executed inside a pipe but in batch context

REM Enable delayed expansion to be able to send any special characters
setlocal EnableDelayedExpansion

REM It's easy to take care of trailing spaces, no special hacks needed.
echo !user_id!
echo !pwd!
goto :EOF

:/RPipe
REM This will be executed inside a pipe but in batch context

vpncli.exe connect %cybr_vpn_host%  -s
goto :EOF

:TRIM
SET %2=%1
GOTO :EOF
