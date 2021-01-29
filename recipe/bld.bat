set "CMAKE_CONFIG=Release"
if errorlevel 1 exit 1

mkdir build_%CMAKE_CONFIG%
if errorlevel 1 exit 1

pushd build_%CMAKE_CONFIG%
if errorlevel 1 exit 1

cmake -G "NMake Makefiles" ^
      -DCMAKE_BUILD_TYPE:STRING=%CMAKE_CONFIG% ^
      -DBUILD_SHARED_LIBS:BOOL=ON ^
      -DBUILD_STATIC_LIBS:BOOL=ON ^
      -DCMAKE_INSTALL_PREFIX:PATH="%LIBRARY_PREFIX%" ^
      -DENABLE_BINARY_COMPATIBLE_POSIX_API=YES ^
      "%SRC_DIR%"
if errorlevel 1 exit 1

cmake --build . --target install --config %CMAKE_CONFIG%
if errorlevel 1 exit 1

popd
if errorlevel 1 exit 1
