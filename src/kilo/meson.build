project(
    'kilo',
    'c',
    'cpp',
    version: '0.0.1',
    default_options: [
        'cpp_std=c++20',
        'c_std=c99',
    ],
)

srcs = [
    'kilo.cpp',
    'kilo_highlight.cpp',
    'main.c',
]
args = []

if host_machine.system() == 'windows'
    srcs += 'ipty_win32.cpp'
else
    srcs += 'ipty_posix.cpp'
    args += [
        '-Wall',
        # '-W',
        '-pedantic-errors',
    ]
endif

executable(
    'kilo',
    srcs,
    cpp_args: args,
    install: true,
)
