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
if %VS_MAJOR%==9 (
    set "PATH=C:\Windows\Microsoft.NET\Framework\v4.0.30319;%PATH%"
)

cd VisualC

set "INCLUDE=%LIBRARY_INC%;%INCLUDE%;%LIBRARY_INC%\SDL2"
set "LIB=%LIBRARY_LIB%;%LIBRARY_BIN%;%LIB%"
set "AdditionalIncludeDirectories=%INCLUDE%"

echo "Build env configuration"
echo %INCLUDE%
echo %LIB%
echo %AdditionalIncludeDirectories%


msbuild /nologo SDL_mixer.sln "/p:Configuration=Release;Platform=%PLATFORM%;useenv=true"
if errorlevel 1 exit 1


move %PLATFORM%\Release\SDL2_mixer.lib %LIBRARY_LIB%
move %PLATFORM%\Release\SDL2_mixer.dll %LIBRARY_BIN%
move ..\SDL_mixer.h %LIBRARY_INC%\\SDL2
if errorlevel 1 exit 1
