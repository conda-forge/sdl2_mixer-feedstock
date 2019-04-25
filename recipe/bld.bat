setlocal EnableDelayedExpansion

if %ARCH%==32 (
	set PLATFORM=Win32
) else if %ARCH%==64 (
	set PLATFORM=x64
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
