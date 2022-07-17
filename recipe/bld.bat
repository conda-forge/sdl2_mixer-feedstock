@echo on

mkdir build
cd build

:: no libxmp/modplug in conda-forge yet; no opusfile for win
cmake -G Ninja ^
    -DCMAKE_BUILD_TYPE=Release ^
    -DBUILD_SHARED_LIBS=ON ^
    -DSDL2MIXER_VENDORED=OFF ^
    -DSDL2MIXER_MOD_MODPLUG=OFF ^
    -DSDL2MIXER_MOD_XMP=OFF ^
    -DSDL2MIXER_OPUS=OFF ^
    ..
if %ERRORLEVEL% neq 0 exit 1

cmake --build .
if %ERRORLEVEL% neq 0 exit 1

cmake --install . --prefix $PREFIX
if %ERRORLEVEL% neq 0 exit 1
