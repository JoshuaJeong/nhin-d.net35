@rem ----------------------------------------------------
@rem Batch File for Deploying New NHIND Config Service Binaries
@rem ----------------------------------------------------
@echo off

setlocal

set dest=%1
set bin=..\..\bin\debug

if "%dest%"=="" set dest=C:\inetpub\nhindConfigConsole
if "%bin%"=="" goto :Usage

call :EnsureDirs
if %ERRORLEVEL% NEQ 0 goto :Error

pushd %bin%
call :CopyBins
popd

goto :Done

@rem -------------------------------
:EnsureDirs
echo Ensuring Directories
if not exist %dest% md %dest%
goto :EOF

@rem -------------------------------
:CopyBins
call :PrintHeading Copying BINS to "%dest%"
call :CopyFiles nhinConfigConsole.exe nhinConfigClient.dll nhinConfigStore.dll nhinCommon.dll nhinToolLib.dll ConfigConsoleSettings.xml nhinConfigConsole.exe.config
exit /b %ERRORLEVEL%

@rem -------------------------------
:CopyFiles
for %%i in (%*) do (xcopy /y %%i "%dest%" || exit /b)
goto :EOF

@rem -------------------------------
:PrintHeading
shift
echo ==============================
echo.
echo %*
echo.
echo ==============================
goto :EOF

@rem -------------------------------
:Error
call :PrintHeading ERROR %ERRORLEVEL%
goto :Done

@rem -------------------------------
:Usage
echo copybins binPath
goto :Done

@rem -------------------------------
:Done
endlocal
exit /b %ERRORLEVEL%