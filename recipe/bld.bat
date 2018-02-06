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
set "UseEnv=true"

msbuild /nologo SDL_mixer.sln /p:Configuration=Release;Platform=%PLATFORM%
if errorlevel 1 exit 1

rem copy %RECIPE_DIR%\CMakeLists.txt .\CMakeLists.txt

rem :: Make a build folder and change to it.
rem mkdir build
rem cd build

rem :: Configure using the CMakeFiles
rem %LIBRARY_BIN%\cmake -G "NMake Makefiles" -DCMAKE_INSTALL_PREFIX:PATH="%LIBRARY_PREFIX%" -DCMAKE_BUILD_TYPE:STRING=Release .. 
rem if errorlevel 1 exit 1

rem :: Build!
rem nmake
rem if errorlevel 1 exit 1

rem nmake install
rem if errorlevel 1 exit 1

rem :: Go back to source dir
rem cd ..

rem :: Copy headers of dependency dlls that are supplied with the source. It is impossible to compile them
rem :: with the anaconda build environment, but I doubt it will be a problem to just use the included dlls
rem :: as these libraries will probably only ever be used together with sdl2_mixer, and only if one tries
rem :: to play music from the ancient MOD format (which I think will be very rarely)
rem xcopy %SRC_DIR%\VisualC\external\include\libmodplug %LIBRARY_PREFIX%\include\libmodplug /I

rem :: Copy the dll's of these dependencies
rem if %ARCH%==32 (
rem 	set FOLDER=x86
rem ) else if %ARCH%==64 (
rem 	set FOLDER=x64
rem )

rem copy "%SRC_DIR%\VisualC\external\lib\%FOLDER%\libmodplug-1.dll" "%LIBRARY_PREFIX%\bin\libmodplug-1.dll"
