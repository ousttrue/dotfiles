[[pbr_memo]]
[[OpenGL]]

- [LearnOpenGL/src/6.pbr/2.2.2.ibl_specular_textured at master · JoeyDeVries/LearnOpenGL · GitHub](https://github.com/JoeyDeVries/LearnOpenGL/tree/master/src/6.pbr/2.2.2.ibl_specular_textured)

```meson.build
project('LearnOpenGL', 'c', 'cpp')

conf_data = configuration_data()
# TODO: backslash !
conf_data.set('CMAKE_SOURCE_DIR', meson.current_source_dir())
configure_file(
    input: 'configuration/root_directory.h.in',
    output: 'root_directory.h',
    configuration: conf_data,
)

glad_inc = include_directories('includes', 'builddir')
glad_lib = static_library(
    'glad',
    [
        'src/glad.c',
        'src/stb_image.cpp',
    ],
    include_directories: glad_inc,
)
glad_dep = declare_dependency(
    link_with: glad_lib,
    include_directories: glad_inc,
)

subdir('src/6.pbr/2.2.2.ibl_specular_textured')```
```

```meson.build
glfw_dep = dependency('glfw3', default_options: ['install=true'])

executable(
    'ibl_specular_textured',
    'ibl_specular_textured.cpp',
    install: true,
    dependencies: [glad_dep, glfw_dep],
)
```

```json
{
    // Use IntelliSense to learn about possible attributes.
    // Hover to view descriptions of existing attributes.
    // For more information, visit: https://go.microsoft.com/fwlink/?linkid=830387
    "version": "0.2.0",
    "configurations": [
        {
            "name": "(Windows) Launch",
            "type": "cppvsdbg",
            "request": "launch",
            "program": "${workspaceFolder}/prefix/bin/ibl_specular_textured.exe",
            "args": [],
            "stopAtEntry": false,
            "cwd": "${workspaceFolder}/src/6.pbr/2.2.2.ibl_specular_textured",
            "environment": [
                {
                    "name": "LOGL_ROOT_PATH",
                    "value": "${workspaceFolder}"
                }
            ],
            "console": "externalTerminal"
        }
    ]
}
```