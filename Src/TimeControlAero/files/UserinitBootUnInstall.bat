@echo off 
set path=%1
set path=%path:"=%
::echo %path%
set current_dir=%WINDIR%\System32
pushd %current_dir%
for /f "tokens=1,2,*" %%a in ('reg query "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Winlogon" /v "Userinit" ^|findstr /i "Userinit"') do (
    set value=%%c
)
set value=%value:"=%
setlocal enabledelayedexpansion
set value=!value:%path%,=!
::echo %value%

reg add "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Winlogon" /v "Userinit" /t REG_SZ /d "%value%" /f 