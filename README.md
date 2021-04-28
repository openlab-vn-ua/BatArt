# BatArt
Usable and cool .bat files
Implemented as .bat to .cs hybrids (.bat files that compiles as .cs).

This technology allows you to create command line scripts on CSharp and use full power of .NetFramework (already present on your machine as part of Windows XP or later). The files do not relay on PowerShell, regular .cs syntax may be used for command line scripts.
These files need .NetFramework to operate (automatically compile their own CSharp parts and run as .exe files).

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
.bat command file script to create free ASN1 OID based on random GUID (need .NetFramework to operate, .cs to .bat hybryd).

Prints generated random OID to standard output. 
Uses GUID to OID mappind rules provided by MS (based on MS-published VB script)
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

Command .bat script file simple RegExp search or searc-and-replace proccessor (need .NetFramework to operate, .cs to .bat hybryd).
Uses .cs RegExp

```
cs_regexp.bat simple CS regexp proccessor
Usage:
cs_regexp {Options} [SearchRegexp] {ReplaceExp (optional)} < input > output
SearchRegexp: CS regular expression to provide to Regex object
 https://docs.microsoft.com/en-us/dotnet/api/system.text.regularexpressions.regex.matches
 if no ReplaceExp specified, returns matches (each match follwed by EOL)
ReplaceExp: Regexp.Replace replacement string (use $n to address pattern from regexp)
 https://docs.microsoft.com/en-us/dotnet/api/system.text.regularexpressions.regex.replace
Options:
 -h    : show help
 -N    : print line number before each line that macthes (search only)
 -eol- : do not add eol after each match print
 -ropts=Option,Option... : Set Regexp options/flags (i,m,s may also be used)
```

## Hello_World

Command .bat script file to print out `Hello World!` (need .NetFramework to operate, .cs to .bat hybryd).
Just technology demosntrator to make you own .cs to .bat hybrid files without any console output side effects.

Use it as stub for you own .cs to .bat hybrids utilities

