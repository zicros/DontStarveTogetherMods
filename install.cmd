@ECHO OFF
SETLOCAL enabledelayedexpansion

SET MOD_NAME=RZ

REM Check if steam folder exists
IF EXIST "!ProgramFiles(x86)!" (
    SET "STEAM_PARENT=!ProgramFiles(x86)!"
) ELSE (
    SET STEAM_PARENT=!ProgramFiles!
)

SET STEAM_PATH=!STEAM_PARENT!\Steam
IF NOT EXIST "!STEAM_PATH!" (
    ECHO Unable to find steam folder: !STEAM_PATH!
    GOTO :EOF
)

REM If it exists, look for the Don't Starve Folder
SET DST_PATH=!STEAM_PATH!\steamapps\common\Don't Starve Together
IF NOT EXIST "!DST_PATH!" (
    ECHO Unable to find DST folder: !DST_PATH!
    GOTO :EOF
)

REM If it exists, ensure our mod folder is available
SET DST_MOD_PATH=!DST_PATH!\mods\!MOD_NAME!
IF NOT EXIST "!DST_MOD_PATH!" (
    mkdir "!DST_MOD_PATH!"
)

REM Copy files from here to mods folder
robocopy /MIR ./ "!DST_MOD_PATH!" * /XF install.cmd /XD .git /MT:4
