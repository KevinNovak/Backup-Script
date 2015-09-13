:: Backup Utility - Backs up the user's files to the network drive
:: Code by: Kevin Novak
:: Last Edited: 9/12/2015
:: Version: 0.0.0.0

@echo off

title Backup Utility

set driveLetter=C

:: =================================================
:: Network Drive & Copy Paths
:: =================================================
:: change userDirectory path to the network drive
set userDirectory=C:\Users\kevin\Desktop\

:: change copyFromDirectory path to the path to copy from
set copyFromDirectory=%driveLetter%:\Users\Kevin\Desktop\from_here

:: define a variable containing a single backspace character
for /f %%A in ('"prompt $H &echo on &for %%B in (1) do rem"') do set BS=%%A

:: =================================================
:: Intro Dialog
:: =================================================
echo.
echo   The backup utility will back up the user's files to the network drive.
echo.
set /p var=%BS%  Press Enter to Continue: 
cls
goto _drive

:: =================================================
:: Setting Drive Letter
:: =================================================
:_drive
echo.
echo   ----------------- Backup Location -----------------
echo   From which location are you running the backup utility?
echo     1 - User's Computer
echo     2 - Backup Station
echo.
:_driveprompt
set location=
set /p location=%BS%  Location: 
if "%location%"=="1" (
    goto _keys
)
if "%location%"=="2" (
    goto _driveletter
)
goto _driveprompt

:: =================================================
:: Prompt for Saving Keys
:: =================================================
:_keys
cls
echo.
echo   ----------------- Saving Keys -----------------
set savekey=
set /p savekey=%BS%  Would you like to save keys? (yes/no): 
goto _prompt

:: =================================================
:: Getting Drive Letter
:: =================================================
:_driveletter
cls
echo.
echo   ----------------- Drive Letter -----------------
echo   Please select the drive letter containing the user's folder: 
echo.
wmic logicaldisk get deviceid, volumename, description
set /p driveletter=%BS%  Drive Letter ('?' for help): 
if "%driveletter%"=="?" (
    diskmgmt.msc
    goto _driveletter
)

:: change copyFromDirectory path to the path to copy from
set copyFromDirectory=%driveletter%:\Users\Kevin\Desktop\from_here
goto _prompt

:: =================================================
:: Prompt for Folder Name
:: =================================================
:_prompt
cls
echo.
echo   ----------------- Folder Options -----------------
set flashline=
set /p flashline=%BS%  Please enter the user's flashline: 
set phone=
set /p phone=%BS%  Please enter the last 4 digits of the user's phone number: 
set askForNote=
set /p askForNote=%BS%  Add an aditional note to the folder name? (yes/no): 
if "%askForNote%"=="yes" goto _note
goto _createFolderNoNote

:: =================================================
:: Prompt for Folder Note
:: =================================================
:_note
cls
echo.
echo   ----------------- Folder Note -----------------
echo   Please choose a folder note:
echo     1 - Don't delete
echo     2 - Ask before deleting
echo     3 - [No Note]
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
    goto _createFolderNoNote
) else (
    goto _note
)
set /p var=%BS%  Press Enter to Continue: 

:: =================================================
:: Create Folder
:: =================================================
:_createFolderNote
set folderName=%userDirectory%%flashline%-%phone%-%notePrint%
goto _createFolder
:_createFolderNoNote
set folderName=%userDirectory%%flashline%-%phone%
goto _createFolder
:_createFolder
if not exist "%folderName%" mkdir "%folderName%"
goto _keys

:: =================================================
:: Save Keys
:: =================================================
:_keys
if "%savekey%" == "yes" produkey.exe /stext %folderName%\keys.txt
if "%savekey%" == "y" produkey.exe /stext %folderName%\keys.txt
goto _sizebefore

:: =================================================
:: Size Before
:: =================================================
:_sizebefore
cls
echo.
echo   ----------------- Transfer Data -----------------
echo   Getting original data information (this could take awhile)...
du -q %copyFromDirectory%>%folderName%\originalUserData.txt
ping 1.1.1.1 -n 1 -w 1500 > nul
echo.
echo   Original User Data:
FOR /F "tokens=* delims= " %%A IN (%folderName%\originalUserData.txt) DO ECHO.    %%A
echo.
echo   Ensure the sound is enabled if you would like to be alerted.
echo.
set /p var=%BS%  Press Enter to begin transfer: 
goto _copy

:: =================================================
:: Copy Files
:: =================================================
:_copy
echo.
echo   Transferring files...
@echo %copyFromDirectory%^|%folderName%> %folderName%\unstoppable.ucb
:: +d means default and +z means calculate time remaining 
UnstopCpy_5_2_Win2K_UP.exe +dz %folderName%\unstoppable.ucb
del %folderName%\unstoppable.ucb
cls
goto _end

:: =================================================
:: Ending Dialog
:: =================================================
:_end
echo.
echo   ----------------- Backup Complete -----------------
echo   The Backup Utility has finished.
echo.
echo   Original User Data:
FOR /F "tokens=* delims= " %%A IN (%folderName%\originalUserData.txt) DO ECHO.    %%A
echo.
echo   Getting backup data information (this could take awhile)...
du -q %folderName%>%folderName%\dataOnBackup.txt
ping 1.1.1.1 -n 1 -w 1500 > nul
echo.
echo   Data on Backup:
FOR /F "tokens=* delims= " %%A IN (%folderName%\dataOnBackup.txt) DO ECHO.    %%A
del %folderName%\originalUserData.txt
del %folderName%\dataOnBackup.txt
echo.
start sWavPlayer.exe Alarm05.wav
set /p var=%BS%  Press Enter to open folder and exit: 
start %folderName%\
exit