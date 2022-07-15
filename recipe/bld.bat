setlocal EnableDelayedExpansion

if %ARCH%==32 (
	set PLATFORM=Win32
) else if %ARCH%==64 (
	set PLATFORM=x64
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
