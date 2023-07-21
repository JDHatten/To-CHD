@ECHO off
MODE CON COLS=128 LINES=20
SETLOCAL EnableExtensions EnableDelayedExpansion

SET supported=false

ECHO File Droped: "%~f1"
ECHO\

IF /I "%~x1" == ".cue" (
    SET supported=true
)
IF /I "%~x1" == ".gdi" (
    SET supported=true
)
IF /I "%~x1" == ".iso" (
    SET supported=true
)

IF %supported% == true (
    "%~dp0\chdman.exe" createcd -i "%~f1" -o "%~n1.chd"
    ECHO\
    SET /P cont="Continue searching "%~dp1" for more (.cue .gdi .iso) files to convert? [Y/N]: "
    IF /I !cont! == y (
        ECHO Searching...
        FOR /R %%i IN (*.cue, *.gdi, *.iso) DO "%~dp0\chdman.exe" createcd -i "%%i" -o "%%~dpni.chd"
    )
    ECHO\
    SET /P close=Finished, You May Close Window.
) ELSE (
    ECHO\
    SET /P close=""%~x1" File Types Are Not Supported"
)
