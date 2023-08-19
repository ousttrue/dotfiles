project(
    'lpeg',
    'c',
    version: '1.0.2',
)

lua_dep = dependency('lua')

lpeg_lib = shared_library(
    'lpeg',
    [
        'lpvm.c',
        'lpcap.c',
        'lptree.c',
        'lpcode.c',
        'lpprint.c',
    ],
    install: true,
    dependencies: [lua_dep],
)

lpeg_dep = declare_dependency(
    include_directories: include_directories('.'),
    link_with: lpeg_lib,
)
