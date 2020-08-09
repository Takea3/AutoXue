@echo off & chcp 65001
cd /d %~dp0
echo %cd%
set cgong=完美，下一个。。。。 & set shibai=失败，再来一遍。。。。
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
    goto run1
)

:run1
setlocal enabledelayedexpansion
for /f %%a in ('type %cd%\zhanghao.txt') do set /a val+=1
echo !val!
for /l %%j in (1,1,%val%) do (
for /f "delims=" %%i in (%cd%\zhanghao.txt) do (
set /a n+=1 & if !n!==%%j set "var=%%i"
)
set /a n=0

:run
echo !var!
REM echo venv\scripts\python -m xuexi
venv\scripts\python -m xuexi !var!
TIMEOUT /T 10
set SysTS=""
set i=""
for /f "delims=" %%i in ('powershell -c "Get-Date -UFormat '%%Y-%%m-%%d'"') do (set "SysTS=%%i")
echo !SysTS!
set b=""
set str1=""
for /f "delims=" %%b in (%cd%\logs\!SysTS!.log) do set "str1=%%~b"
If NOT "!str1!"=="!str1:logout_or_not=!" (echo !cgong!) else echo !shibai! & goto run)
set a=""
set j=""
set b=""
set var=""
set i=""


)
pause
exit

:breakout
echo please start Appium and Nox
pause
exit