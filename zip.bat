// 2>nul||@goto :batch
/*
:batch
@echo off
if exist "%~dpn0.exe" (
"%~dpn0.exe" %*
exit /b %errorlevel% 
)

setlocal
:: find csc.exe
set "csc="
for /r "%SystemRoot%\Microsoft.NET\Framework\" %%# in ("*csc.exe") do  set "csc=%%#"

if not exist "%csc%" (
   echo no .net framework installed
   exit /b 10
)

call %csc% /nologo /r:"System.IO.Compression.FileSystem.dll" /out:"%~dpn0.exe" "%~dpn0.bat" || (
   exit /b %errorlevel% 
)

"%~dpn0.exe" %*
endlocal & exit /b %errorlevel%

*/

// Written by Serge A
// This software is freeware based on MIT license

using System;
using System.Collections.Generic;
using System.IO;

/// Provides functions to capture the entire screen, or a particular window, and save it to a file. 

public class ZipUtil
{
    static void printHelp()
    {
        //clears the extension from the script name
        String scriptName = Environment.GetCommandLineArgs()[0];
        scriptName = Path.GetFileNameWithoutExtension(scriptName);
        Console.WriteLine(scriptName + " simple zip archive operations.");
        Console.WriteLine("");
        Console.WriteLine("Usage:");
        Console.WriteLine(" " + scriptName + " [command] {options} [archive] [source/target]");
        Console.WriteLine("");
        Console.WriteLine("command  - [a]archive, e[x]tract");
        Console.WriteLine("archive  - archive file name with extension");
        Console.WriteLine("source   - source folder to archive for 'a' operation");
        Console.WriteLine("target   - target folder for 'x' operation");
        Console.WriteLine(" -r      - for 'a' command = Resursive folders (MANDATORY)");
        Console.WriteLine(" -ep1    - for 'a' command = Exclude base folder");
      //Console.WriteLine(" -o+     - for 'x' command = Overwrite exiting files");
    }

    public static int Main(string[] Argv)
    {
        int FAIL = 1;
        int OK   = 0;

        int Argi = 0;

        var Arguments = new List<string>();

        bool Options_Recursive = false;
        bool Options_ExcludeParsent = false;
      //bool Options_Overwrite = false;

        while (Argi < Argv.Length)
        {
            if (Argv[Argi].StartsWith("-"))
            {
                var Option = Argv[Argi].Substring(1);

                if (Option == "h") { printHelp(); return OK; }
                if (Option == "?") { printHelp(); return OK; }

                if (Option == "r")   { Options_Recursive = true; }
                if (Option == "ep1") { Options_ExcludeParsent = true; }
              //if (Option == "o+")  { Options_Overwrite = true; }
            }
            else
            {
                Arguments.Add(Argv[Argi]);
            }

            Argi++;
        }
        
        if (Arguments.Count < 1) { printHelp(); return FAIL; }

        string Command = Arguments[0];

        if (Command == "a")
        {
            if (!Options_Recursive) { printHelp(); Console.Error.WriteLine("-r option is mandatory for 'a' command (for compatibility)"); return FAIL; }

            if (Arguments.Count < 3) { printHelp(); return FAIL; }

            string Arc = Arguments[1];
            string Src = Arguments[2];

            try
            {
                Console.WriteLine(string.Format("Archiving {0} from {1} [R]", Arc, Src) + (Options_ExcludeParsent ? " [EP]" : ""));
                System.IO.Compression.ZipFile.CreateFromDirectory(Src, Arc, System.IO.Compression.CompressionLevel.Optimal, !Options_ExcludeParsent);
            }
            catch (Exception e)
            {
                Console.Error.WriteLine(String.Format("ERROR archiving {0}", Arc));
                Console.Error.Write(e);
                return FAIL;
            }
        }
        else if (Command == "x")
        {
            if (Arguments.Count < 3) { printHelp(); return FAIL; }

            string Arc = Arguments[1];
            string Dst = Arguments[2];

            try
            {
                Console.WriteLine(string.Format("Extracting {0} to {1}", Arc, Dst));
                System.IO.Compression.ZipFile.ExtractToDirectory(Arc, Dst);
              //System.IO.Compression.ZipFile.ExtractToDirectory(Arc, Dst , Options_Overwrite);
            }
            catch (Exception e)
            {
                Console.Error.WriteLine(String.Format("ERROR extracting {0}", Arc));
                Console.Error.Write(e);
                return FAIL;
            }
        }
        else
        {
            { printHelp(); Console.Error.WriteLine("Invalid command"); return FAIL; }
        }

        return OK;
    }
}
