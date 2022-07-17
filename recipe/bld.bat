@echo on

mkdir build
cd build

cmake -DCMAKE_BUILD_TYPE=Release ^
      -DBUILD_SHARED_LIBS=ON ^
      -DSDL2MIXER_VENDORED=OFF ^
      ..
if %ERRORLEVEL% neq 0 exit 1

cmake --build .
if %ERRORLEVEL% neq 0 exit 1

cmake --install --prefix $PREFIX
if %ERRORLEVEL% neq 0 exit 1
