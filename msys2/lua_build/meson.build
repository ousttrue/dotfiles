project('lua_build', 'c', 'cpp')

# subdir('lua')
lua_dep = dependency('lua')

shared_library('hello', 
'hello.cpp', 
install: true,
dependencies: [lua_dep],
)

