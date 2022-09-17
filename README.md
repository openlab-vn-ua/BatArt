# BatArt
Command .bat files aand .bat to .cs hybrids (the .bat files written on CSharp that auto compiles and runs).
Usable and cool .bat examples:

- [zip.bat](#Zip) : Create or extract .zip archives
- [free_asn1_oid.bat](#Free_ASN1_OID) : Create free ASN1 OID based on random GUID
- [cs_regexp.bat](#CS_RegExp) : CSharp regular expression search or search-end-replace in text files
- [screenshot.bat](#Screenshot) : Save a screenshot (of whole screen or single a window)
- [hello_world.bat](#Hello_World) : Demo application use it as template you create you own .bat files on .cs
- [waste.bat](#Waste) : Fill free space on your disk drive with waste (useful after you delete something sensitive)

This technology allows you to create command line scripts on CSharp and use full power of .NetFramework (already present on your machine as part of Windows XP or later). You may use standart input and standart output and exit code without any artifacts. 

These files use .NetFramework to automatically compile their own CSharp parts once and than run it as .exe files.

*The files do not relay on PowerShell, regular .cs syntax may be used for command line scripts.*

## Zip
Command .bat script file to create or extract .zip archives (need .NetFramework to operate, .cs to .bat hybryd)
```
zip.bat simple zip archive operations.
Usage:
zip [command] {options} [archive] [source/target]
command  - [a]archive, e[x]tract
archive  - archive file name with extension
source   - source folder to archive for 'a' operation
target   - target folder for 'x' operation
 -r      - for 'a' command = Resursive folders (MANDATORY)
 -ep1    - for 'a' command = Exclude base folder
```

## Free_ASN1_OID
Command .bat file script file to create free ASN1 OID based on random GUID

Prints generated random OID to standard output. 
Uses GUID to OID mapping rules provided by MS (based on MS-published VB script)
OID generated in Microsoft-provided home 1.2.840.113556.1.8000.2554

See https://docs.microsoft.com/en-us/windows/win32/ad/obtaining-an-object-identifier-from-microsoft

See https://oidref.com/1.2.840.113556.1.8000.2554

```
free_asn1_oid.bat Free random ASN1 OID generator
Creates GUID and dumps it as ASN1 OID in MS-provided tree 1.2.840.113556.1.8000.2554
Usage:
free_asn1_oid {options}
options:
 -h,--help    - show help screen
 -v,--verbose - verbose output (source GIUD and OID)
```

## CS_RegExp

Command .bat script file simple RegExp search or search-and-replace processor
Uses .cs RegExp

```
cs_regexp.bat simple CS regexp processor
Usage:
cs_regexp {Options} [SearchRegexp] {ReplaceExp (optional)} < input > output
SearchRegexp: CS regular expression to provide to Regex object
 https://docs.microsoft.com/en-us/dotnet/api/system.text.regularexpressions.regex.matches
 if no ReplaceExp specified, returns matches (each match followed by EOL)
ReplaceExp: Regexp.Replace replacement string (use $n to address pattern from regexp)
 https://docs.microsoft.com/en-us/dotnet/api/system.text.regularexpressions.regex.replace
 if ReplaceExp specified, prints text after replace
Options:
 -h    : show help
 -N    : print line number before each line that matches (search only)
 -eol- : do not add eol after each match print
 -ropts=Option,Option... : Set Regexp options/flags (i,m,s may also be used)
```

## Screenshot

Command .bat script file to create screenshot (whole screen or current active window or specified window).
Result image may be saved in various formats (.jpg, .png, .bmp, .gif etc).

Based on:
https://github.com/npocmaka/batch.scripts/blob/master/hybrids/.net/c/screenCapture.bat

See also:
rem http://www.developerfusion.com/code/4630/capture-a-screen-shot/

```
screenshot.bat captures the screen or the active window and saves it to a file.

Usage:
screenshot filename [WindowTitle]

filename - the file where the screen capture will be saved
     allowed file extensions are - Bmp,Emf,Exif,Gif,Icon,Jpeg,Png,Tiff,Wmf.
WindowTitle - instead of capture whole screen you can point to a window 
     with a title which will put on focus and captuted.
     For WindowTitle you can pass only the first few characters.
     If don't want to change the current active window pass only ""
```

## Hello_World

Command .bat script file to print out `Hello World!` (need .NetFramework to operate, .cs to .bat hybrid).
Just technology demonstrator to make you own .cs to .bat hybrid files without any console output side effects.

Use it as stub for you own .cs to .bat hybrids utilities.
Just replace .cs code part after .bat prologue with your own code. 

If you need external assemblies add them to `CSC_OPS` options var in .bat section, example: 
```
set CSC_OPS=/r:"System.IO.Compression.FileSystem.dll"
```

## Waste

Fill free space on your disk drive with waste (useful after you delete something sensitive).
Empty space filled with 1G chunks of waste.
Operation will be stopped when there are no more free space or 100T is written.

```
Usage:
waste
```


