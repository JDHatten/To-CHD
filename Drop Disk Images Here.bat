@ECHO off
MODE CON COLS=128 LINES=40
SETLOCAL EnableExtensions EnableDelayedExpansion

SET supported=false
SET search_text=Continue searching "%~dp1" for more (.cue .gdi .iso) files to convert? [Y/N]: 
SET /A disks_found = 0


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
    CALL :RunCHDMAN "%~f1", "%~n1.chd"
    ECHO\
    SET /P cont=!search_text!
    IF /I !cont! == y (
        CALL :RunCHDMAN
    )
) ELSE (
    IF /I "%~x1" NEQ "" (
        ECHO These file formats "%~x1" are not supported.
        ECHO\
        SET /P cont=!search_text!
        IF /I !cont! == y (
            CALL :RunCHDMAN
        )
    ) ELSE (
        CALL :RunCHDMAN
    )
)

ECHO\
IF !disks_found! GTR 0 (
    CALL :DequoteECHO "Amount of Disk Images found and converted (or errored): !disks_found!"
) ELSE (
    ECHO No Disk Images Found
)
ECHO\
SET /P close=Finished, You May Close Window.


:: %1 Source
:: %2 Output
:RunCHDMAN
    ECHO\
    IF /I "%~1" == "" (
        ECHO Searching...
        FOR /R %%i IN (*.cue, *.gdi, *.iso) DO (
            ECHO\
            ECHO Converting File: "%%i"
            SET /A disks_found=disks_found+1
            CALL "%~dp0\chdman.exe" createcd -i "%%i" -o "%%~dpni.chd"
        )
    ) ELSE (
        ECHO Converting Droped File: %1
        CALL "%~dp0\chdman.exe" createcd -i %1 -o %2
    )
    EXIT /B 0


:: %1 String With Quotes
:DequoteECHO
    SET no_quotes=%~1
    ECHO !no_quotes!
    EXIT /B 0
