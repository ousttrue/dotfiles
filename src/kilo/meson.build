project(
    'kilo',
    'c',
    'cpp',
    default_options: ['c_std=c99'],
)

srcs = [
    'kilo.cpp',
    'main.cpp',
]

if host_machine.system() == 'windows'
  srcs += 'ipty_win32.cpp'
else
  srcs += 'ipty_posix.cpp'
endif

executable(
    'kilo',
    srcs,
    c_args: [
        '-Wall',
        '-W',
        '-pedantic',
    ],
    install: true,
)
