[[OpenGL]]

- [KHR_debug and EXT_debug_marker/EXT_debug_label - Qiita](https://qiita.com/shimacpyon/items/2eebf0d97c2adacee706)

# EXT_debug_label
- [https://registry.khronos.org/OpenGL/extensions/EXT/EXT_debug_label.txt](https://registry.khronos.org/OpenGL/extensions/EXT/EXT_debug_label.txt)

```c
auto label = "atlas";
if ((__GLEW_EXT_debug_label)) {
  glLabelObjectEXT(GL_TEXTURE, texture->Handle(), 0, label);
}
if ((__GLEW_KHR_debug)) {
  glObjectLabel(GL_TEXTURE, texture->Handle(), -1, label);
}
```

