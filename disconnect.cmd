@echo off

set install_dir="C:\Program Files (x86)\Cisco\Cisco AnyConnect Secure Mobility Client\"
%install_dir%\vpncli.exe connect connect.tridentusahealth.com -s disconnect
pause
echo on
