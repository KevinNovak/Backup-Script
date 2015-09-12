:: Backup Utility - Backs up the user's files to the network drive
:: Code by: Kevin Novak
:: Last Edited: 9/11/2015
:: Version: 0.0.0.0

@echo off

title Backup Utility

set driveLetter=C

:: change userDirectory path to the network drive
set userDirectory=%driveLetter%:\Users\kevin\Desktop\

:: change copyFromDirectory path to the path to copy from
set copyFromDirectory=C:\Users\Kevin\Desktop\from_here

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
goto _drive

:: =================================================
:: Setting Drive Letter
:: =================================================
:_drive
echo.
echo   From which location are you running the backup utility?
echo     1 User's Computer
echo     2 Backup Station
echo.
:_driveprompt
set location=
set /p location=%BS%  Location: 
if "%location%"=="1" (
    goto _prompt
)
if "%location%"=="2" (
    goto _driveletter
)
goto _driveprompt

:: =================================================
:: Get Drive Letter
:: =================================================
:_driveletter
cls
echo.
echo   Please select the drive letter to be backed up: 
echo.
wmic logicaldisk get deviceid, volumename, description
echo.
set /p driveletter=%BS%  Drive Letter: 

:: change copyFromDirectory path to the path to copy from
set copyFromDirectory=%driveletter%:\Users\Kevin\Desktop\from_here
goto _prompt

:: =================================================
:: Prompt for Options
:: =================================================
:_prompt
cls
echo.
set flashline=
set /p flashline=%BS%  Please enter the user's flashline: 
set phone=
set /p phone=%BS%  Please enter the last 4 digits of the user's phone number: 
set askForNote=
set /p askForNote=%BS%  Add an aditional note to the folder name? (yes/no): 
if "%askForNote%"=="yes" goto _note
goto _createFolderNoNote

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
    set notePrint=Don't_delete
    goto _createFolderNote
)
if "%noteOption%"=="2" (
    set notePrint=Ask_before_deleting
    goto _createFolderNote
)
if "%noteOption%"=="3" (
    set notePrint=Key_only
    goto _createFolderNote
)
if "%noteOption%"=="4" (
    set notePrint=Disk_image
    goto _createFolderNote
)
if "%noteOption%"=="5" (
    set notePrint=
    set /p notePrint=%BS%  Please enter your folder note: 
    goto _createFolderNote
) else (
    goto _note
)
set /p var=%BS%  Press Enter to Continue: 

:: =================================================
:: Create Folder
:: =================================================
:_createFolderNote
set folderName=%userDirectory%%flashline%-%phone%-(%notePrint%)
goto _createFolder
:_createFolderNoNote
set folderName=%userDirectory%%flashline%-%phone%
goto _createFolder
:_createFolder
if not exist "%folderName%" mkdir "%folderName%"
goto _copy

:: =================================================
:: Copy Files
:: =================================================
:_copy
@echo %copyFromDirectory%^|%folderName%> %folderName%\unstoppable.ucb
:: +d means default and +z means calculate time remaining 
UnstopCpy_5_2_Win2K_UP.exe +dz %folderName%\unstoppable.ucb
goto _end

:: =================================================
:: End
:: =================================================
:_end
cls
echo.
echo   The Backup Utility has finished.
echo.
set /p var=%BS%  Press Enter to Exit: 
exit