project(
    'libvterm',
    'c',
    version: '0.3.2',
)

libvterm_inc = include_directories('include')

libvterm_lib = static_library(
    'vterm',
    [
        'src/encoding.c',
        'src/keyboard.c',
        'src/mouse.c',
        'src/parser.c',
        'src/pen.c',
        'src/screen.c',
        'src/state.c',
        'src/unicode.c',
        'src/vterm.c',
    ],
    include_directories: libvterm_inc,
)

libvterm_dep = declare_dependency(
    include_directories: libvterm_inc,
    link_with: libvterm_lib,
)
