cmake -B build ${CMAKE_ARGS} -G "NMake Makefiles" ^
      -DCMAKE_PREFIX_PATH=%LIBRARY_PREFIX% ^
      -DCMAKE_INSTALL_PREFIX="%LIBRARY_PREFIX%" ^
      -DCMAKE_INSTALL_LIBDIR=lib ^
      -DCMAKE_BUILD_TYPE=Release ^
      -DBUILD_SHARED_LIBS=ON ^
      -DENABLE_BINARY_COMPATIBLE_POSIX_API=ON ^
      -DBUILD_TEST=ON ^
      -DCMAKE_POSITION_INDEPENDENT_CODE=ON ^
      .
if errorlevel 1 exit 1

cmake --build build --config Release --target install
if errorlevel 1 exit 1

@REM Rewrote the upstream Bash script for running tests.
@echo off
echo [Oniguruma API, UTF-8 check]
build\test\test_utf8.exe | findstr RESULT
if errorlevel 1 exit 1

echo [Oniguruma API, SYNTAX check]
build\test\test_syntax.exe | findstr RESULT
if errorlevel 1 exit 1

echo [Oniguruma API, Options check]
build\test\test_options.exe | findstr RESULT
if errorlevel 1 exit 1

echo [Oniguruma API, UTF-16 check]
build\test\testcu.exe | findstr RESULT
if errorlevel 1 exit 1

echo [Oniguruma API, regset check]
build\test\test_regset.exe
if errorlevel 1 exit 1

echo [Oniguruma API, backward search check]
build\test\test_back.exe | findstr RESULT
if errorlevel 1 exit 1

echo [Oniguruma API, EUC-JP check]
build\test\testc.exe
if not "%ERRORLEVEL%"=="0" exit 1

echo All tests passed successfully.
exit 0