rem We'll copy this into the torch\install\bin directory

pushd "%~dp0..\.."
set "BASE=%CD%"
echo BASE %BASE%
popd

set "TORCH_INSTALL=%BASE%\install"

rem set "TORCH_INSTALL=%~dp0..\.."
set "TORCH_INSTALL_BIN=%TORCH_INSTALL%\bin"

echo BASE %BASE%

rem set "LUA_CPATH=%BASE%/install/?.DLL;%BASE%/install/LIB/?.DLL;?.DLL"
set "LUA_DEV=%BASE%/install"
rem set "LUA_PATH=;;%BASE%/install/?;%BASE%/install/?.lua;%BASE%/install/lua/?;%BASE%/install/lua/?.lua;%BASE%/install/lua/?/init.lua
set "PATH=%BASE%\install;%BASE%\install\bin;%PATH%"

cmd /c luarocks path > "%TEMP%\setupluarockspath.bat"
call "%TEMP%\setupluarockspath.bat"

call "C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\bin\amd64\vcvars64.bat"
set "PATH=%PATH%;C:\Program Files\CMake\bin"
set "PATH=%PATH%;C:\Program Files\Git\bin"



rem /home/ubuntu/torch-cl/install/share/lua/5.1/?.lua;
rem /home/ubuntu/torch-cl/install/share/lua/5.1/?/init.lua;
rem /home/ubuntu/git/distro/install/share/lua/5.1/?.lua;
rem /home/ubuntu/git/distro/install/share/lua/5.1/?/init.lua;
rem ./?.lua;
rem /home/ubuntu/git/distro/install/share/luajit-2.1.0-beta1/?.lua;
rem /usr/local/share/lua/5.1/?.lua;
rem /usr/local/share/lua/5.1/?/init.lua
