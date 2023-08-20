project('lua_build', 'c', 'cpp')

# subdir('lua')
lua_dep = dependency('lua')

# lpeg_dep = dependency('lpeg')

shared_library(
    'hello',
    'hello.cpp',
    dependencies: [
        lua_dep,
        # lpeg_dep,
    ],
    name_prefix: 'msys-',
)
