echo off
@call "C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\VC\Auxiliary\Build\vcvarsall.bat" x64

md bin
md bin\windows_x64

REM cl fizzbuzz.c /Fe: bin\windows_x64\fizzbuzz.exe
