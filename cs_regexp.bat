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
set CSC_OPS=/r:"System.IO.Compression.FileSystem.dll"

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

// Written by Serge A
// This software is freeware based on MIT license

using System;
using System.Collections.Generic;
using System.IO;
using System.Text.RegularExpressions;
using System.Linq;

/// Simple utility to create .zip files without external files under Windows

public class CsRegExp
{
    const string EOL = "\n";

    static void printHelp()
    {
        //clears the extension from the script name
        String scriptName = Environment.GetCommandLineArgs()[0];
        scriptName = Path.GetFileNameWithoutExtension(scriptName);
        Console.WriteLine(scriptName + " simple CS regexp proccessor.");
        Console.WriteLine("");
        Console.WriteLine("Usage:");
        Console.WriteLine(" " + scriptName + " {Options} [SearchRegexp] {ReplaceExp (optional)} < input > output");
        Console.WriteLine("");
        Console.WriteLine("SearchRegexp: CS regular expression to provide to Regex object");
        Console.WriteLine(" https://docs.microsoft.com/en-us/dotnet/api/system.text.regularexpressions.regex.matches");
        Console.WriteLine(" if no ReplaceExp specified, returns matches (each match follwed by EOL)");
        Console.WriteLine("ReplaceExp: Regexp.Replace replacement string (use $n to address pattern from regexp)");
        Console.WriteLine(" https://docs.microsoft.com/en-us/dotnet/api/system.text.regularexpressions.regex.replace");
        Console.WriteLine("Options:");
        Console.WriteLine(" -h    : show this help");
        Console.WriteLine(" -N    : print line number before each line that macthes (search only)");
        Console.WriteLine(" -eol- : do not add eol after each match print");
        Console.WriteLine(" -ropts=Option,Option... : Set Regexp options/flags (i,m,s may also be used)");
    }

    protected static int GetLinesBeforeOffset(string Text, int Offset)
    {
        int Result = 0;

        for (var Index = 0; Index < Offset; Index++)
        {
            if (Text[Index] == '\n') { Result++; }
        }

        return Result;
    }

    public static int Main(string[] Argv)
    {
        int FAIL = 1;
        int OK   = 0;

        int Argi = 0;

        var Arguments = new List<string>();

        RegexOptions TheRegExpOptions = RegexOptions.None;
        bool TheOptShowLineNumbers = false;
        bool TheOptDoNotAddEOL = false;
        //int  TheOptCaptureNumber = 0;

        var REOPT_PFX = "ropts";

        while (Argi < Argv.Length)
        {
            if (Argv[Argi].StartsWith("-"))
            {
                var Option = Argv[Argi].Substring(1);

                if      (Option == "h") { printHelp(); return OK; }
                else if (Option == "?") { printHelp(); return OK; }
                else if (Option == "N") { TheOptShowLineNumbers = true; }
                else if (Option == "eol-") { TheOptDoNotAddEOL = true; }
                else if (Option.StartsWith(REOPT_PFX + "=") || Option.StartsWith(REOPT_PFX + "+"))
                {
                    var OptNames = Option.Substring(REOPT_PFX.Length + 1).Trim().Split('+',',',';');

                    if (Option[REOPT_PFX.Length] == '=')
                    {
                        // Assign flags, not add, so reset flags
                        TheRegExpOptions = RegexOptions.None;
                    }

                    foreach(var OptName in OptNames)
                    {
                        RegexOptions OptValue;

                        if (Enum.TryParse(OptName, out OptValue))
                        {
                            TheRegExpOptions |= OptValue;
                        }
                        else if (OptName == "i")
                        {
                            TheRegExpOptions |= RegexOptions.IgnoreCase;
                        }
                        else if (OptName == "m")
                        {
                            TheRegExpOptions |= RegexOptions.Multiline;
                        }
                        else if (OptName == "s")
                        {
                            TheRegExpOptions |= RegexOptions.Singleline;
                        }
                    }
                }
                else
                {
                    printHelp(); return FAIL;
                }
            }
            else
            {
                Arguments.Add(Argv[Argi]);
            }

            Argi++;
        }
        
        if (Arguments.Count < 1) { printHelp(); return FAIL; }
        if (Arguments.Count > 2) { printHelp(); return FAIL; }

        string TheSearchRegExp = Arguments[0];
        string TheReplaceExp   = Arguments.Count > 1 ? Arguments[1] : null;

        var RExp = new Regex(TheSearchRegExp, TheRegExpOptions);

        try
        {
            using (StreamReader sr = new StreamReader(Console.OpenStandardInput()))
            {
                string Text = sr.ReadToEnd();

                if (TheReplaceExp == null)
                {
                    // Search only
                    var Matches = RExp.Matches(Text);
                    for (var i = 0; i < Matches.Count; i++)
                    {
                        var Match = Matches[i];
                        string Output;

                        Output = Match.Value;

                        if (TheOptShowLineNumbers)
                        {
                            int LineNumber = GetLinesBeforeOffset(Text, Match.Index) + 1;
                            Output = LineNumber + ":" + Output;
                        }

                        if (TheOptDoNotAddEOL)
                        {
                            Console.Write(Output);
                        }
                        else
                        {
                            Console.WriteLine(Output);
                        }
                    }
                }
                else
                {
                    // Replace
                    string Output = RExp.Replace(Text, TheReplaceExp);

                    if (TheOptDoNotAddEOL)
                    {
                        Console.Write(Output);
                    }
                    else
                    {
                        Console.WriteLine(Output);
                    }
                }
            }
        }
        catch (Exception e)
        {
            Console.Error.WriteLine(String.Format("ERROR: proccessing data", e));
            Console.Error.Write(e);
            return FAIL;
        }

        return OK;
    }
}
