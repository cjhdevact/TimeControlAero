@echo off
echo �������� ʱ��С���� Aero �棨TimeControlAero��...
pause > nul
if exist "%~dp0TimeControlAero-Bin" rd /s /q "%~dp0TimeControlAero-Bin"
md "%~dp0TimeControlAero-Bin"
copy "%~dp0TimeControlAero\files\1-��װ.bat" "%~dp0TimeControlAero-Bin\1-��װ.bat"
copy "%~dp0TimeControlAero\files\2-ж��.bat" "%~dp0TimeControlAero-Bin\2-ж��.bat"
copy "%~dp0TimeControlAero\files\UserinitBootInstall.bat" "%~dp0TimeControlAero-Bin\UserinitBootInstall.bat"
copy "%~dp0TimeControlAero\files\UserinitBootUnInstall.bat" "%~dp0TimeControlAero-Bin\UserinitBootUnInstall.bat"
copy "%~dp0TimeControlAero\bin\Release\TimeControlAero.exe" "%~dp0TimeControlAero-Bin\TimeControlAero.exe"
copy "%~dp0TimeControlAero\bin\x64\Release\TimeControlAero.exe" "%~dp0TimeControlAero-Bin\TimeControlAero64.exe"
echo.
echo ��ɣ�
echo ������˳�...
pause > nul