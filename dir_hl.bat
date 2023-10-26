@echo off
Rem lists all files that have hardlinks in folder (s)
setlocal

if "%1"=="/?" goto help
if "%1"=="-?" goto help
if "%1"=="--?" goto help
if "%1"=="/h" goto help
if "%1"=="-h" goto help
if "%1"=="--help" goto help

:check_subdirs
Rem subdirs

if "%1"=="/r" goto use_cs
if "%1"=="-r" goto use_cs

if "%2"=="/r" goto use_ps
if "%2"=="-r" goto use_ps

if "%3"=="/r" goto use_pms
if "%3"=="-r" goto use_pms

if not "%4"=="" goto help

goto check_no_subdirs

:use_cs
set DIRS=.
set MASK=*.*
goto run_r

:use_ps
set DIRS=%1
set MASK=*.*
goto run_r

:use_pms
set DIRS=%1
set MASK=%2
goto run_r

:check_no_subdirs
Rem non-subdirs

if "%1"=="" goto use_c
if "%2"=="" goto use_p
goto use_pm

if not "%3"=="" goto help

:use_c
set DIRF=.\*.*
goto run_n

:use_p
set DIRF=%1\*.*
goto run_n

:use_pm
set DIRF=%1\%2
goto run_n

:run_n
echo (Hardlinks in "%DIRF%" folder)
for %%i in ("%DIRF%") do call :print_hl %%i
goto :eof

:run_r
echo (Hardlinks in "%DIRS%" folder+subfolders with mask "%MASK%")
for /r "%DIRS%" %%i in ("%MASK%") do call :print_hl %%i
goto :eof


:print_hl
FOR /F "usebackq delims==" %%a IN (`fsutil hardlink list %1 ^| find /c /v ""`) do set LINKS_C=%%a
if "%LINKS_C%"=="1" goto :eof
::echo %~pnx1 [HardLinks:]
echo [HardLinks:]
fsutil hardlink list %1
goto :eof

:help
Echo Directory listing for HardLinks
Echo Lists all file that are hardlinks (AKA hl) at path with specified mask
Echo Usage DIR_HL [Path] [Mask] [/r]
Echo Where:
Echo  [Path] to scan (use "." as current folder)
Echo  [Mask] use mask to scan only specified files
Echo Options:
Echo  -r,/r  Recursive (with subfolders)
goto :eof
