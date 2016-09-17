package = "distrocheck"
version = "scm-1"

source = {
   url = ""
}

description = {
   summary = "Check installed from distro",
   detailed = [[
   ]],
   license = "BSD"
}

dependencies = {
}

build = {
   type = "command",
   build_command = [[
cmake -E make_directory build && cd build && cmake .. -DCMAKE_BUILD_TYPE=Release -DCMAKE_PREFIX_PATH="$(LUA_BINDIR)/.." -DCMAKE_INSTALL_PREFIX="$(PREFIX)" && $(MAKE) install
]],
   install_command = "cd build"
}
