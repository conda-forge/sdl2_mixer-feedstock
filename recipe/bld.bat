setlocal EnableDelayedExpansion

if %ARCH%==32 (
	set PLATFORM=Win32
) else if %ARCH%==64 (
	set PLATFORM=x64
)

:: See https://github.com/conda-forge/staged-recipes/pull/194#issuecomment-203577297
:: Nasty workaround. Need to move a more current msbuild into PATH.  The one on
:: AppVeyor barfs on the solution. This one comes from the Win7 SDK (.net 4.0),
:: and is known to work.
if %VS_MAJOR% == 9 (
    COPY C:\Windows\Microsoft.NET\Framework\v4.0.30319\MSBuild.exe .\
    if errorlevel 1 exit 1
    set "PATH=%CD%;%PATH%"
)

if "%VS_YEAR%" == "2008" (
  copy %LIBRARY_INC%\stdint.h %SRC_DIR%\builds\msvc\
  copy %LIBRARY_INC%\inttypes.h %SRC_DIR%\builds\msvc\
  if errorlevel 1 exit 1
)

cd VisualC
if %VS_MAJOR% GTR 10 (
	devenv SDL_mixer.sln /upgrade
)
if errorlevel 1 exit 1

set "INCLUDE=%LIBRARY_INC%;%INCLUDE%"
set "LIB=%LIBRARY_LIB%;%LIBRARY_BIN%;%LIB%"
set "AdditionalIncludeDirectories=%LIBRARY_INC%"

echo "Build env configuration"
echo %INCLUDE%
echo %LIB%
echo %AdditionalIncludeDirectories%

IF EXIST %BUILD_PREFIX% (
echo "build prefix exists"
) ELSE (
echo "build prefix does not exists!!!"
)

IF EXIST %PREFIX% (
echo "prefix exists"
) ELSE (
echo "prefix does not exists!!!"
)


msbuild /nologo SDL_mixer.sln "/p:Configuration=Release;Platform=%PLATFORM%;useenv=true"
if errorlevel 1 exit 1


move %PLATFORM%\Release\SDL2_mixer.lib %LIBRARY_LIB%
move %PLATFORM%\Release\SDL2_mixer.dll %LIBRARY_BIN%
move ..\SDL_mixer.h %LIBRARY_INC%\\SDL2
