@echo off & chcp 65001
cd /d %~dp0
echo %cd%
set cgong=完美，下一个。。。。 & set shibai=失败，再来一遍。。。。
set /a jjj=1
tasklist /nh|find /i "node.exe"
if errorlevel 1 (
    echo could not start while Appium not running
    start appium
) else (
    REM echo Appium is running
)

tasklist /nh|find /i "Nox.exe"
if errorlevel 1 (
    echo could not start while Nox not running
    start Nox.bat
    TIMEOUT /T 25
) else (
    REM echo Nox is running
    goto run1
)

:run1
set /a val=0
setlocal enabledelayedexpansion
for /f %%a in ('type %cd%\zhanghao.txt') do set /a val+=1
echo !val!

for /l %%j in (!jjj!,1,!val!) do (
for /f "delims=" %%i in (%cd%\zhanghao.txt) do (set /a n+=1 & if !n!==%%j set "var=%%i" & set "jj=%%j")
set /a n=0
:run
echo !var!
REM echo venv\scripts\python -m xuexi
venv\scripts\python -m xuexi !var!
TIMEOUT /T 10
for /f "delims=" %%c in ('powershell -c "Get-Date -UFormat '%%Y-%%m-%%d'"') do (set "shij=%%c")

echo !shij!
for /f "delims=" %%b in (%cd%\logs\!shij!.log) do set "str1=%%~b"
echo !str1!
If NOT "!str1!"=="!str1:logout_or_not=!" (echo %cgong%) else (echo %shibai% & goto run)
)
echo !jj!/!val!
if !jj! lss !val! (set /a jjj=!jj!+1 & goto run1)
pause
exit

:breakout
echo please start Appium and Nox
pause
exit
