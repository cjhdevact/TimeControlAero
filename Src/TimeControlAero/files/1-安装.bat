::/*****************************************************\
::
::     TimeControlAero - 1-��װ.bat
::
::     ��Ȩ����(C) 2024 CJH��
::
::     ��װ������
::
::\*****************************************************/
@echo off
cls
title ʱ��С���� Aero �氲װ����
if "%1" == "/noadm" goto main
if "%1" == "/?" goto hlp
fltmc 1>nul 2>nul&& goto main
echo ���ڻ�ȡ����ԱȨ��...
echo.
echo ����ʹ�� %0 /noadm ����Bat��Ȩ�������ֶ��Թ���Ա�������
echo �����ǰ��������ѭ�����֣�����δ�ɹ���ȡ����ԱȨ�ޣ���ע����ǰ�û����������ԣ�
echo Ȼ���Թ���Ա�û��˺����л��ֶ��Թ���Ա������С�
if "%1" == "/mshtaadm" goto mshtaAdmin
if "%2" == "/mshtaadm" goto mshtaAdmin
if "%1" == "/psadm" goto powershellAdmin
if "%2" == "/psadm" goto powershellAdmin
ver | findstr "10\.[0-9]\.[0-9]*" >nul && goto powershellAdmin
:mshtaAdmin
rem ԭ��������mshta����vbscript�ű���bat�ļ���Ȩ
rem ����ʹ����ǰ������ŵ�%~dpnx0����ʾ��ǰ�ű�����ԭ��Ķ��ļ���%~s0���ɿ�
rem ����ʹ��������Net session���ڶ����Ǽ���Ƿ���Ȩ�ɹ��������Ȩʧ������ת��failed��ǩ
rem ����Ч��������Ȩʧ��֮��bat�ļ�����ִ�е�����
::Net session >nul 2>&1 || mshta vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c ""%~dpnx0""","","runas",1)(window.close)&&exit
set parameters=
:parameter
@if not "%~1"=="" ( set parameters=%parameters% %~1& shift /1& goto :parameter)
set parameters="%parameters:~1%"
mshta vbscript:createobject("shell.application").shellexecute("%~dpnx0",%parameters%,"","runas",1)(window.close)&exit
cd /d "%~dp0"
Net session >nul 2>&1 || goto failed
goto main

:powershellAdmin
rem ԭ��������powershell��bat�ļ���Ȩ
rem ����ʹ��������Net session���ڶ����Ǽ���Ƿ���Ȩ�ɹ��������Ȩʧ������ת��failed��ǩ
rem ����Ч��������Ȩʧ��֮��bat�ļ�����ִ�е�����
Net session >nul 2>&1 || powershell start-process \"%0\" -argumentlist \"%1 %2\" -verb runas && exit
Net session >nul 2>&1 || goto failed
goto main

:failed
cls
echo.
echo ��ǰδ�Թ���Ա������С����ֶ��Թ���Ա������б�����
echo.
echo ������ر�... & pause > NUL
goto enda

:hlp
title һ���رտμ�С���߰�װ����
cls
echo.
echo ====================================================
echo            ʱ��С���� Aero �氲װ����
echo ====================================================
echo.
echo �����ʹ�����²�����
echo 1-��װ.bat [/noadm ^| /mshtaadm ^| /psadm]
echo.
echo /noadm ����⵽�޹���ԱȨ�������Զ���Ȩ��
echo /mshtaadm ǿ��ʹ��mshta.exe�Զ���Ȩ��
echo /psadm ǿ��ʹ��Powershell.exe�Զ���Ȩ��
echo.
goto enda

:main
cd /d "%~dp0"
title ʱ��С���� Aero �氲װ����
cls
echo.
echo ====================================================
echo            ʱ��С���� Aero �氲װ����
echo ====================================================
echo.
echo ��Ȩ����(C) 2024 CJH��
echo.
echo ��װǰ����ر�ɱ������Լ���UAC����������UAC�ȼ�Ϊ��ͣ������ڰ�װ����������ѡ��д���Զ�������ᱻ���ص��°�װʧ�ܡ�
echo.
echo �������ʼ��װ... & pause >nul

cls
echo.
echo ====================================================
echo            ʱ��С���� Aero �氲װ����
echo ====================================================
echo.
echo ���ڰ�װ��...
echo.
taskkill /f /im TimeControlAero.exe
::ver|findstr "\<10\.[0-9]\.[0-9][0-9]*\>" > nul && (set netv=4)
ver|findstr "\<6\.[0-1]\.[0-9][0-9]*\>" > nul && (set netv=4c)
ver|findstr "\<6\.[2-9]\.[0-9][0-9]*\>" > nul && (set netv=4c)
ver|findstr "\<5\.[0-9]\.[0-9][0-9]*\>" > nul && (set netv=4c)

if "%PROCESSOR_ARCHITECTURE%"=="x86" goto x86
if "%PROCESSOR_ARCHITECTURE%"=="AMD64" goto x64

:x86
echo.
if exist "%windir%\TimeControlAero.exe" choice /C YN /T 5 /D Y /M "��⵽��ǰϵͳ���ھɰ汾ʱ��С���� Aero �档��(Y)��(N)Ҫɾ���ɰ�ʱ��С���� Aero �棨5����Զ�ѡ��Y��"
if errorlevel 1 set a=1
if errorlevel 2 set a=2
if exist "%windir%\TimeControlAero.exe" if "%a%" == "1" echo.
if exist "%windir%\TimeControlAero.exe" if "%a%" == "1" echo �����ʱ��ͣ���ڴ˲����������Ƿ�ɱ��������ء�
if exist "%windir%\TimeControlAero.exe" if "%a%" == "1" echo.
if exist "%windir%\TimeControlAero.exe" if "%a%" == "1" call "%~dp0UserinitBootUnInstall.bat" "%windir%\TimeControlAero.exe"
if exist "%windir%\TimeControlAero.exe" if "%a%" == "1" Reg delete HKLM\Software\Microsoft\Windows\CurrentVersion\run /v TimeControlAero /f

if exist "%windir%\CJH\TimeControlAero\TimeControlAero.exe" choice /C YN /T 5 /D Y /M "��⵽��ǰϵͳ���ھɰ汾ʱ��С���� Aero �档��(Y)��(N)Ҫɾ���ɰ�ʱ��С���� Aero �棨5����Զ�ѡ��Y��"
if errorlevel 1 set at=1
if errorlevel 2 set at=2
if exist "%windir%\CJH\TimeControlAero\TimeControlAero.exe" if "%at%" == "1" echo.
if exist "%windir%\CJH\TimeControlAero\TimeControlAero.exe" if "%at%" == "1" echo �����ʱ��ͣ���ڴ˲����������Ƿ�ɱ��������ء�
if exist "%windir%\CJH\TimeControlAero\TimeControlAero.exe" if "%at%" == "1" echo.
if exist "%windir%\CJH\TimeControlAero\TimeControlAero.exe" if "%at%" == "1" call "%~dp0UserinitBootUnInstall.bat" "%windir%\CJH\TimeControlAero\TimeControlAero.exe"
if exist "%windir%\CJH\TimeControlAero\TimeControlAero.exe" if "%at%" == "1" Reg delete HKLM\Software\Microsoft\Windows\CurrentVersion\run /v TimeControlAero /f
if exist "%windir%\CJH\TimeControlAero\TimeControlAero.exe" if "%at%" == "1" rd /s /q "%windir%\CJH\TimeControlAero"

if exist "%programfiles%\CJH\TimeControlAero\TimeControlAero.exe" del /q "%programfiles%\CJH\TimeControlAero\TimeControlAero.exe"

if not exist "%programfiles%\CJH\TimeControlAero" md "%programfiles%\CJH\TimeControlAero"
copy "%~dp0TimeControlAero.exe" "%programfiles%\CJH\TimeControlAero\TimeControlAero.exe"
echo.
choice /C YN /T 5 /D Y /M "��(Y)��(N)Ҫ����Զ������5����Զ�ѡ��Y��"
if errorlevel 1 set aa=1
if errorlevel 2 set aa=2
if "%aa%" == "1" echo.
if "%aa%" == "1" echo �����ʱ��ͣ���ڴ˲����������Ƿ�ɱ��������ء�
if "%aa%" == "1" echo.
if "%aa%" == "1" Reg add HKLM\Software\Microsoft\Windows\CurrentVersion\run /v TimeControlAero /t REG_SZ /d "%programfiles%\CJH\TimeControlAero\TimeControlAero.exe" /f
echo.
choice /C YN /T 5 /D Y /M "��(Y)��(N)Ҫ���Userinit���Զ������5����Զ�ѡ��Y��"
if errorlevel 1 set ab=1
if errorlevel 2 set ab=2
if "%ab%" == "1" echo.
if "%ab%" == "1" echo �����ʱ��ͣ���ڴ˲����������Ƿ�ɱ��������ء�
if "%ab%" == "1" echo.
if "%ab%" == "1" call "%~dp0UserinitBootUnInstall.bat" "%programfiles%\CJH\TimeControlAero\TimeControlAero.exe"
if "%ab%" == "1" call "%~dp0UserinitBootInstall.bat" "%programfiles%\CJH\TimeControlAero\TimeControlAero.exe"
echo.

echo.
choice /C YN /T 5 /D Y /M "��(Y)��(N)Ҫ������ݷ�ʽ����ʼ�˵���5����Զ�ѡ��Y��"
if errorlevel 1 set ad=1
if errorlevel 2 set ad=2
if "%ad%" == "1" if not exist "%systemdrive%\ProgramData\Microsoft\Windows\Start Menu\Programs\ʱ��С���� Aero ��" md "%systemdrive%\ProgramData\Microsoft\Windows\Start Menu\Programs\ʱ��С���� Aero ��"
if "%ad%" == "1" if exist "%systemdrive%\ProgramData\Microsoft\Windows\Start Menu\Programs\ʱ��С���� Aero ��\ʱ��С���� Aero ��.lnk" del /q "%systemdrive%\ProgramData\Microsoft\Windows\Start Menu\Programs\ʱ��С���� Aero ��\ʱ��С���� Aero ��.lnk"
if "%ad%" == "1" call mshta VBScript:Execute("Set a=CreateObject(""WScript.Shell""):Set b=a.CreateShortcut(""%systemdrive%\ProgramData\Microsoft\Windows\Start Menu\Programs\ʱ��С���� Aero ��\ʱ��С���� Aero ��.lnk""):b.TargetPath=""%programfiles%\CJH\TimeControlAero\TimeControlAero.exe"":b.WorkingDirectory=""%programfiles%\CJH\TimeControlAero"":b.Save:close")

copy /y "%~dp02-ж��.bat" "%programfiles%\CJH\TimeControlAero\Uninstall.bat"
copy /y "%~dp0UserinitBootUnInstall.bat" "%programfiles%\CJH\TimeControlAero\UserinitBootUnInstall.bat"

echo.
choice /C YN /T 5 /D Y /M "��(Y)��(N)���ж�س����б�5����Զ�ѡ��Y��"
if errorlevel 1 set ae=1
if errorlevel 2 set ae=2
if "%ae%" == "1" Reg add HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TimeControlAero /v DisplayIcon /t REG_SZ /d "%programfiles%\CJH\TimeControlAero\TimeControlAero.exe" /f
if "%ae%" == "1" Reg add HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TimeControlAero /v DisplayName /t REG_SZ /d "ʱ��С���� Aero �棨TimeControlAero��" /f
if "%ae%" == "1" Reg add HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TimeControlAero /v Publisher /t REG_SZ /d "CJH" /f
if "%ae%" == "1" Reg add HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TimeControlAero /v UninstallString /t REG_SZ /d "%programfiles%\CJH\TimeControlAero\Uninstall.bat" /f

start "" "%programfiles%\CJH\TimeControlAero\TimeControlAero.exe"

echo.
cls

echo.
echo ====================================================
echo            ʱ��С���� Aero �氲װ����
echo ====================================================
echo.
echo ��װ��ɣ�������˳�... & pause > nul
goto enda

:x64
echo.
if exist "%windir%\TimeControlAero.exe" choice /C YN /T 5 /D Y /M "��⵽��ǰϵͳ���ھɰ汾ʱ��С���� Aero �档��(Y)��(N)Ҫɾ���ɰ�ʱ��С���� Aero �棨5����Զ�ѡ��Y��"
if errorlevel 1 set a=1
if errorlevel 2 set a=2
if exist "%windir%\TimeControlAero.exe" if "%a%" == "1" echo.
if exist "%windir%\TimeControlAero.exe" if "%a%" == "1" echo �����ʱ��ͣ���ڴ˲����������Ƿ�ɱ��������ء�
if exist "%windir%\TimeControlAero.exe" if "%a%" == "1" echo.
if exist "%windir%\TimeControlAero.exe" if "%a%" == "1" call "%~dp0UserinitBootUnInstall.bat" "%windir%\TimeControlAero.exe"
if exist "%windir%\TimeControlAero.exe" if "%a%" == "1" Reg delete HKLM\Software\Microsoft\Windows\CurrentVersion\run /v TimeControlAero /f

if exist "%windir%\CJH\TimeControlAero\TimeControlAero.exe" choice /C YN /T 5 /D Y /M "��⵽��ǰϵͳ���ھɰ汾ʱ��С���� Aero �档��(Y)��(N)Ҫɾ���ɰ�ʱ��С���� Aero �棨5����Զ�ѡ��Y��"
if errorlevel 1 set at=1
if errorlevel 2 set at=2
if exist "%windir%\CJH\TimeControlAero\TimeControlAero.exe" if "%at%" == "1" echo.
if exist "%windir%\CJH\TimeControlAero\TimeControlAero.exe" if "%at%" == "1" echo �����ʱ��ͣ���ڴ˲����������Ƿ�ɱ��������ء�
if exist "%windir%\CJH\TimeControlAero\TimeControlAero.exe" if "%at%" == "1" echo.
if exist "%windir%\CJH\TimeControlAero\TimeControlAero.exe" if "%at%" == "1" call "%~dp0UserinitBootUnInstall.bat" "%windir%\CJH\TimeControlAero\TimeControlAero.exe"
if exist "%windir%\CJH\TimeControlAero\TimeControlAero.exe" if "%at%" == "1" Reg delete HKLM\Software\Microsoft\Windows\CurrentVersion\run /v TimeControlAero /f
if exist "%windir%\CJH\TimeControlAero\TimeControlAero.exe" if "%at%" == "1" rd /s /q "%windir%\CJH\TimeControlAero"

if exist "%programfiles%\CJH\TimeControlAero\TimeControlAero.exe" del /q "%programfiles%\CJH\TimeControlAero\TimeControlAero.exe"
if exist "%programfiles%\CJH\TimeControlAero\x86\TimeControlAero.exe" del /q "%programfiles%\CJH\TimeControlAero\x86\TimeControlAero.exe"

if not exist "%programfiles%\CJH\TimeControlAero" md "%programfiles%\CJH\TimeControlAero"
if not exist "%programfiles%\CJH\TimeControlAero\x86" md "%programfiles%\CJH\TimeControlAero\x86"
copy "%~dp0TimeControlAero64.exe" "%programfiles%\CJH\TimeControlAero\TimeControlAero.exe"
copy "%~dp0TimeControlAero.exe" "%programfiles%\CJH\TimeControlAero\x86\TimeControlAero.exe"
echo.
choice /C YN /T 5 /D Y /M "��(Y)��(N)Ҫ����Զ������5����Զ�ѡ��Y��"
if errorlevel 1 set aa=1
if errorlevel 2 set aa=2
if "%aa%" == "1" echo.
if "%aa%" == "1" echo �����ʱ��ͣ���ڴ˲����������Ƿ�ɱ��������ء�
if "%aa%" == "1" echo.
if "%aa%" == "1" Reg add HKLM\Software\Microsoft\Windows\CurrentVersion\run /v TimeControlAero /t REG_SZ /d "%programfiles%\CJH\TimeControlAero\TimeControlAero.exe" /f
echo.
choice /C YN /T 5 /D Y /M "��(Y)��(N)Ҫ���Userinit���Զ������5����Զ�ѡ��Y��"
if errorlevel 1 set ab=1
if errorlevel 2 set ab=2
if "%ab%" == "1" echo.
if "%ab%" == "1" echo �����ʱ��ͣ���ڴ˲����������Ƿ�ɱ��������ء�
if "%ab%" == "1" echo.
if "%ab%" == "1" call "%~dp0UserinitBootUnInstall.bat" "%programfiles%\CJH\TimeControlAero\TimeControlAero.exe"
if "%ab%" == "1" call "%~dp0UserinitBootInstall.bat" "%programfiles%\CJH\TimeControlAero\TimeControlAero.exe"
echo.

echo.
choice /C YN /T 5 /D Y /M "��(Y)��(N)Ҫ������ݷ�ʽ����ʼ�˵���5����Զ�ѡ��Y��"
if errorlevel 1 set ad=1
if errorlevel 2 set ad=2
if "%ad%" == "1" if not exist "%systemdrive%\ProgramData\Microsoft\Windows\Start Menu\Programs\ʱ��С���� Aero ��" md "%systemdrive%\ProgramData\Microsoft\Windows\Start Menu\Programs\ʱ��С���� Aero ��"
if "%ad%" == "1" if exist "%systemdrive%\ProgramData\Microsoft\Windows\Start Menu\Programs\ʱ��С���� Aero ��\ʱ��С���� Aero ��.lnk" del /q "%systemdrive%\ProgramData\Microsoft\Windows\Start Menu\Programs\ʱ��С���� Aero ��\ʱ��С���� Aero ��.lnk"
if "%ad%" == "1" if exist "%systemdrive%\ProgramData\Microsoft\Windows\Start Menu\Programs\ʱ��С���� Aero ��\ʱ��С���� Aero �棨32λ��.lnk" del /q "%systemdrive%\ProgramData\Microsoft\Windows\Start Menu\Programs\ʱ��С���� Aero ��\ʱ��С���� Aero �棨32λ��.lnk"
if "%ad%" == "1" call mshta VBScript:Execute("Set a=CreateObject(""WScript.Shell""):Set b=a.CreateShortcut(""%systemdrive%\ProgramData\Microsoft\Windows\Start Menu\Programs\ʱ��С���� Aero ��\ʱ��С���� Aero ��.lnk""):b.TargetPath=""%programfiles%\CJH\TimeControlAero\TimeControlAero.exe"":b.WorkingDirectory=""%programfiles%\CJH\TimeControlAero"":b.Save:close")
if "%ad%" == "1" call mshta VBScript:Execute("Set a=CreateObject(""WScript.Shell""):Set b=a.CreateShortcut(""%systemdrive%\ProgramData\Microsoft\Windows\Start Menu\Programs\ʱ��С���� Aero ��\ʱ��С���� Aero �棨32λ��.lnk""):b.TargetPath=""%programfiles%\CJH\TimeControlAero\x86\TimeControlAero.exe"":b.WorkingDirectory=""%programfiles%\CJH\TimeControlAero\x86"":b.Save:close")

copy /y "%~dp02-ж��.bat" "%programfiles%\CJH\TimeControlAero\Uninstall.bat"
copy /y "%~dp0UserinitBootUnInstall.bat" "%programfiles%\CJH\TimeControlAero\UserinitBootUnInstall.bat"

echo.
choice /C YN /T 5 /D Y /M "��(Y)��(N)���ж�س����б�5����Զ�ѡ��Y��"
if errorlevel 1 set ae=1
if errorlevel 2 set ae=2
if "%ae%" == "1" Reg add HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TimeControlAero /v DisplayIcon /t REG_SZ /d "%programfiles%\CJH\TimeControlAero\TimeControlAero.exe" /f
if "%ae%" == "1" Reg add HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TimeControlAero /v DisplayName /t REG_SZ /d "ʱ��С���� Aero �棨TimeControlAero��" /f
if "%ae%" == "1" Reg add HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TimeControlAero /v Publisher /t REG_SZ /d "CJH" /f
if "%ae%" == "1" Reg add HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\TimeControlAero /v UninstallString /t REG_SZ /d "%programfiles%\CJH\TimeControlAero\Uninstall.bat" /f

start "" "%programfiles%\CJH\TimeControlAero\TimeControlAero.exe"

echo.
cls

echo.
echo ====================================================
echo            ʱ��С���� Aero �氲װ����
echo ====================================================
echo.
echo ��װ��ɣ�������˳�... & pause > nul
goto enda

:enda