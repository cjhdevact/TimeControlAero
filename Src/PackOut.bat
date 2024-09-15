@echo off
echo 任意键打包 时钟小工具 Aero 版（TimeControlAero）...
pause > nul
if exist "%~dp0TimeControlAero-Bin" rd /s /q "%~dp0TimeControlAero-Bin"
md "%~dp0TimeControlAero-Bin"
copy "%~dp0TimeControlAero\files\1-安装.bat" "%~dp0TimeControlAero-Bin\1-安装.bat"
copy "%~dp0TimeControlAero\files\2-卸载.bat" "%~dp0TimeControlAero-Bin\2-卸载.bat"
copy "%~dp0TimeControlAero\files\UserinitBootInstall.bat" "%~dp0TimeControlAero-Bin\UserinitBootInstall.bat"
copy "%~dp0TimeControlAero\files\UserinitBootUnInstall.bat" "%~dp0TimeControlAero-Bin\UserinitBootUnInstall.bat"
copy "%~dp0TimeControlAero\bin\Release\TimeControlAero.exe" "%~dp0TimeControlAero-Bin\TimeControlAero.exe"
copy "%~dp0TimeControlAero\bin\x64\Release\TimeControlAero.exe" "%~dp0TimeControlAero-Bin\TimeControlAero64.exe"
echo.
echo 完成！
echo 任意键退出...
pause > nul