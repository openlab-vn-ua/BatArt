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

/// Free random ASN1 OID generator
/// OID generated in Microsoft-provided home 1.2.840.113556.1.8000.2554
/// See https://docs.microsoft.com/en-us/windows/win32/ad/obtaining-an-object-identifier-from-microsoft
/// See https://oidref.com/1.2.840.113556.1.8000.2554
/// Based on VB script provided by MS

using System;
using System.IO;

public class Program
{
    // The Microsoft OID Prefix used for the automated OID Generator 
    public const string MsOidPrefix = "1.2.840.113556.1.8000.2554";

    public static string ConvertGuidToMsOidString(Guid TheGuid)
    {
        var guidString = "{" + TheGuid.ToString() + "}";

        // Split GUID into 6 hexadecimal numbers 
        // trick prepend string to keep original 1-based indexes
        guidString = "*" + guidString;
        var guidPart0 = guidString.Substring(2, 4).Trim();
        var guidPart1 = guidString.Substring(6, 4).Trim();
        var guidPart2 = guidString.Substring(11, 4).Trim();
        var guidPart3 = guidString.Substring(16, 4).Trim();
        var guidPart4 = guidString.Substring(21, 4).Trim();
        var guidPart5 = guidString.Substring(26, 6).Trim();
        var guidPart6 = guidString.Substring(32, 6).Trim();
        // Convert the hexadecimal to decimal 
        var oidPart0 = Convert.ToInt32(guidPart0, 16);
        var oidPart1 = Convert.ToInt32(guidPart1, 16);
        var oidPart2 = Convert.ToInt32(guidPart2, 16);
        var oidPart3 = Convert.ToInt32(guidPart3, 16);
        var oidPart4 = Convert.ToInt32(guidPart4, 16);
        var oidPart5 = Convert.ToInt32(guidPart5, 16);
        var oidPart6 = Convert.ToInt32(guidPart6, 16);
        // Concatenate all the generated OIDs together with the assigned Microsoft prefix and return 
        return MsOidPrefix + "." + oidPart0 + "." + oidPart1 + "." + oidPart2 + "." + oidPart3 + "." + oidPart4 + "." + oidPart5 + "." + oidPart6;
    }

    static void PrintHelp()
    {
        //clears the extension from the script name
        String scriptName = Environment.GetCommandLineArgs()[0];
        scriptName = Path.GetFileNameWithoutExtension(scriptName);
        Console.WriteLine(scriptName + " Free random ASN1 OID generator");
        Console.WriteLine("Creates GUID and dumps it as ASN1 OID in MS-provided tree");
        Console.WriteLine(MsOidPrefix);
        Console.WriteLine("");
        Console.WriteLine("Usage:");
        Console.WriteLine(" " + scriptName + " {options}");
        Console.WriteLine("");
        Console.WriteLine("options:");
        Console.WriteLine(" -h,--help    - this help screen");
        Console.WriteLine(" -v,--verbose - verbose output (source GIUD and OID)");
    }

    public static int Main(string[] Argv)
    {
        int FAIL = 1;
        int OK = 0;

        bool OptVerbose = false;

        foreach (var Arg in Argv)
        {
            if      ((Arg == "--help")    || (Arg == "-h")) { PrintHelp(); return OK; }
            else if ((Arg == "--verbose") || (Arg == "-v")) { OptVerbose = true; }
            else
            {
                PrintHelp();
                return FAIL;
            }
        }

        var TheGuid = System.Guid.NewGuid();

        if (OptVerbose)
        {
            Console.WriteLine("GUID  :{" + TheGuid.ToString() + "}");
            Console.WriteLine("MS OID:" + ConvertGuidToMsOidString(TheGuid).ToString() + "");
        }
        else
        {
            Console.WriteLine(ConvertGuidToMsOidString(TheGuid).ToString());
        }

        return OK;
    }
}
