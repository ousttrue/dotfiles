qt6, meson, qml

https://theolizer.com/cpp-school4/cpp-school4-4/

c++ で QML を host できた。
qml を resource(qrc) として埋め込み。

```meson
project(
    'qt-hello',
    'cpp',
    default_options: ['cpp_std=c++latest'],
)

qt6 = import('qt6')
qt6_dep = dependency('qt6', modules: ['Core', 'Gui', 'Widgets', 'Qml', 'Quick'])
# inc = include_directories('includes')
# moc_files = qt6.compile_moc(
#     headers: 'myclass.h',
#     extra_arguments: ['-DMAKES_MY_MOC_HEADER_COMPILE'],
#     include_directories: inc,
#     dependencies: qt6_dep,
# )
# translations = qt6.compile_translations(
#     ts_files: 'myTranslation_fr.ts',
#     build_by_default: true,
# )
rc = qt6.compile_resources(sources: 'main.qrc')
executable(
    'myprog',
    'main.cpp',
    rc,
    # 'myclass.cpp',
    # moc_files,
    # include_directories: inc,
    dependencies: qt6_dep,
    install: true,
)
```
