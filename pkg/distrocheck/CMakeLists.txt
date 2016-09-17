cmake_minimum_required(VERSION 2.8)

FIND_PACKAGE(Torch REQUIRED)

ADD_TORCH_PACKAGE(distrocheck "" "distrocheck.lua")

INSTALL(FILES README.md init.lua DESTINATION "${Torch_INSTALL_LUA_PATH_SUBDIR}/distrocheck")
