:: Backup Utility - Backs up the user's files to the network drive
:: Code by: Kevin Novak
:: Last Edited: 9/9/2015

@echo off

title Backup Utility

:: change userDirectory path to the network drive
set userDirectory="C:\Users\kevin\Desktop\"

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
if "%noteOption%"=="1" (
    set notePrint=Don't delete
    goto _nonote
)
if "%noteOption%"=="2" (
    set notePrint=Ask before deleting
    goto _nonote
)
if "%noteOption%"=="3" (
    set notePrint=Key only
    goto _nonote
)
if "%noteOption%"=="4" (
    set notePrint=Disk image
    goto _nonote
)
if "%noteOption%"=="5" (
    goto _nonote
) else (
    goto _note
)
set /p var=%BS%  Press Enter to Continue: 

:_nonote
:: FOLDER NAMES NEED TO BE REPLACED 
if not exist "%userDirectory%%flashline%-%phone% (%notePrint%)" mkdir "%userDirectory%%flashline%-%phone% (%notePrint%)"
pause
exit