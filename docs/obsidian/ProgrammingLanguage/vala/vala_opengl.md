
# Gtk3.GLArea
`mingw` で動いた
[GitHub - AstraLuma/gltutorial-vala: Following along http://www.opengl-tutorial.org/beginners-tutorials/ in vala](https://github.com/AstraLuma/gltutorial-vala)
```
project('gltutorial', 'vala', 'c')

vapi_dir = meson.current_source_dir() 
add_project_arguments(['--vapidir', vapi_dir], language: 'vala')

executable('gltest', 'gltest.vala',
  install: true,
  dependencies: [
    dependency('gtk+-3.0'),
    dependency('gl'),
    dependency('glew'),
    dependency('gio-2.0'),
    dependency('graphene-1.0'),
    ],
  vala_args: ['--pkg', 'gl'],
  )
```

TODO: glib-compile-resources