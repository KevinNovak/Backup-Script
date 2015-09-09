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
goto _prompt

:: =================================================
:: Prompt for Options
:: =================================================
:_prompt
echo.
set flashline=
set /p flashline=%BS%  Please enter the user's flashline: 
set phone=
set /p phone=%BS%  Please enter the last 4 digits of the user's phone number: 
set askForNote=
set /p askForNote=%BS%  Add an aditional note to the folder name? (yes/no): 
if "%askForNote%"=="yes" goto _note
goto _nonote

:: =================================================
:: Folder Note
:: =================================================
:_note
cls
echo.
echo   Please choose a folder note:
echo     1 Don't delete
echo     2 Ask before deleting
echo     3 Key only
echo     4 Disk image
echo     5 [Add your own]
echo.
set noteOption=
set /p noteOption=%BS%  Option: 
echo.
set /p var=%BS%  Press Enter to Continue: 

:_nonote
if not exist "C:\Users\kevin\Desktop\%flashline%-%phone%" mkdir C:\Users\kevin\Desktop\%flashline%-%phone%
pause
exit