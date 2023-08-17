project(
    'tmux_build',
    'c',
    'cpp',
)

tmux_dep = dependency('tmux')

executable(
    'dummy',
    'main.cpp',
    # install: true,
    dependencies: [tmux_dep],
)
