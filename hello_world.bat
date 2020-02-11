@goto :batch_start_label_cs_hybrid
/*
@:batch_start_label_cs_hybrid
@echo off
if exist "%~dpn0.exe" (
"%~dpn0.exe" %*
exit /b %errorlevel% 
)

setlocal

:: Additional options to csc.exe (like /r:"references")
set CSC_OPS=

:: Runner options
set CS_FAIL_EXIT_CODE=1001

:: find csc.exe
set "csc="
for /r "%SystemRoot%\Microsoft.NET\Framework\" %%# in ("*csc.exe") do  set "csc=%%#"

if not exist "%csc%" (
   echo Error: no .net framework installed
   exit /b %CS_FAIL_EXIT_CODE%
)

set BAT_START_LINE=batch_start
set BAT_START_LINE=%BAT_START_LINE%_
set BAT_START_LINE=%BAT_START_LINE%label_cs_hybrid

call findstr /V "%BAT_START_LINE%" "%~dpn0.bat" > "%~dpn0.bat.cs"
if not exist "%~dpn0.bat.cs" (
   echo Error: fail to prepare executable
   exit /b %CS_FAIL_EXIT_CODE%
)

call %csc% /nologo %CSC_OPS% /out:"%~dpn0.exe" "%~dpn0.bat.cs" || (
   exit /b %CS_FAIL_EXIT_CODE%
)

del "%~dpn0.bat.cs"

"%~dpn0.exe" %*
endlocal & exit /b %errorlevel%

*/

/// Simple hello world example for hybris .bat to .cs file

using System;

public class Program
{
    public static int Main(string[] Argv)
    {
         Console.WriteLine("Hello, world!");
         return 0;
    }
}
