@echo off

SET LAZBUILD="D:\home\pi\fpcupdeluxe\lazarus\lazbuild.exe"
SET PROJECT="D:\05_SYNC\00_PROJECTS\LazarusProjects\hcie\lazarus_hcie.lpi"

REM Modify .lpr file in order to avoid nothing-to-do-bug (http://lists.lazarus.freepascal.org/pipermail/lazarus/2016-February/097554.html)
echo. >> "D:\05_SYNC\00_PROJECTS\LazarusProjects\hcie\lazarus_hcie.lpr"

%LAZBUILD% %PROJECT%

if %ERRORLEVEL% NEQ 0 GOTO END

echo. 

if "%1"=="" goto END

if /i %1%==test (
  "D:\05_SYNC\00_PROJECTS\LazarusProjects\hcie\lazarus_hcie.exe" 
)
:END
