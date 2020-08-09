@echo off
cd /d %~dp0
echo %cd%

tasklist /nh|find /i "Appium.exe"
if errorlevel 1 (
    echo could not start while Appium not running
    goto breakout
) else (
    REM echo Appium is running
)

tasklist /nh|find /i "Nox.exe"
if errorlevel 1 (
    echo could not start while Nox not running
    goto breakout
) else (
    REM echo Nox is running
    goto run
)


:run
REM echo venv\scripts\python -m xuexi
venv\scripts\python -m xuexi -u "" -p ""
TIMEOUT /T 10
for /f "delims=" %%i in ('powershell -c "Get-Date -UFormat '%%Y-%%m-%%d'"') do (set "SysTS=%%i")
set str=%cd%\logs\%SysTS%.log
echo %str%
for /f "delims=" %%a in (%str%) do set str1=%%~a
If NOT "%str1%"=="%str1:logout_or_not=%" (echo bunengyongzhongwen) else goto run
pause
exit

:breakout
echo please start Appium and Nox
pause
exit