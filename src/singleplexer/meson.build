ftxui_dep = dependency('ftxui-component')
libvterm_dep = dependency('libvterm')

executable(
    'sinple',
    [
        'main.cpp',
        'child_process.cpp',
    ],
    install: true,
    dependencies: [
        ftxui_dep,
        libvterm_dep,
    ],
    cpp_args: ['-DNOMINMAX'],
)
