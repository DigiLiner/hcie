@echo off
SET THEFILE=D:\05_SYNC\00_PROJECTS\LazarusProjects\hcie\lib\x86_64-win64\lazarus_hcie.exe
echo Linking %THEFILE%
D:\home\pi\fpcupdeluxe\fpc\bin\x86_64-win64\ld.exe -b pei-x86-64  --gc-sections   --subsystem windows --entry=_WinMainCRTStartup    -o D:\05_SYNC\00_PROJECTS\LazarusProjects\hcie\lib\x86_64-win64\lazarus_hcie.exe D:\05_SYNC\00_PROJECTS\LazarusProjects\hcie\lib\x86_64-win64\link23476.res
if errorlevel 1 goto linkend
goto end
:asmend
echo An error occurred while assembling %THEFILE%
goto end
:linkend
echo An error occurred while linking %THEFILE%
:end
