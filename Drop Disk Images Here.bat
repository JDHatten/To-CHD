@ECHO off
MODE CON COLS=128 LINES=40
SETLOCAL EnableExtensions EnableDelayedExpansion


:: Change this to a fixed absolute path then copy and paste this file anywhere you like,
:: for instance directly inside your root game directory. Then you can just click the
:: file anytime you want to convert newly added disk images to the CHD format.
SET CHDMAN_PATH="%~dp0\chdman.exe"


SET search_text=Continue searching "%~dp1" for more (.cue .gdi .iso) files to convert? [Y^/N]: 
SET /A disks_found=0
SET supported=false

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
        ECHO - Searching For Disk Iamges...
        ECHO ------------------------------
        FOR /R %%i IN (*.cue, *.gdi, *.iso) DO (
            ECHO Converting Disk Image: "%%i"
            SET /A disks_found=!disks_found!+1
            CALL %CHDMAN_PATH% createcd -i "%%i" -o "%%~dpni.chd"
        )
        ECHO ------------------------------
    ) ELSE (
        ECHO - Converting Droped Disk Image: %1
        ECHO ------------------------------
        CALL %CHDMAN_PATH% createcd -i %1 -o %2
        ECHO ------------------------------
    )
    EXIT /B 0


:: %1 String With Quotes
:DequoteECHO
    SET no_quotes=%~1
    ECHO !no_quotes!
    EXIT /B 0
