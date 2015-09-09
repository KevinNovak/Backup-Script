:: Backup Utility - Backs up the user's files to the network drive
:: Code by: Kevin Novak
:: Last Edited: 9/9/2015

@echo off

title Backup Utility

:: define a variable containing a single backspace character
for /f %%A in ('"prompt $H &echo on &for %%B in (1) do rem"') do set BS=%%A

:: =================================================
:: Intro
:: =================================================
echo.
echo   The backup utility will back up the user's files to the network drive
echo.
set /p var=%BS%  Press Enter to Continue:  
cls
goto _create

:: =================================================
:: Create folder 
:: =================================================
:_create
echo.
set flashline=
set /p flashline=%BS%  Please enter the user's flashline: 
set phone=
set /p phone=%BS%  Please enter the last 4 digits of the user's phone number: 
if not exist "C:\Users\kevin\Desktop\%flashline%-%phone%" mkdir C:\Users\kevin\Desktop\%flashline%-%phone%
pause
exit