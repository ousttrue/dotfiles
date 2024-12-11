[[OpenXR]]

- [GitHub - KhronosGroup/OpenXR-SDK-Source: Sources for OpenXR loader, basic API layers, and example code.](https://github.com/KhronosGroup/OpenXR-SDK-Source)

CMakeLists.txt - include - src - tests

`src/tests/hello_xr`

# struct OpenXrProgram : IOpenXrProgram

```c++:main.cpp
std::shared_ptr<IOpenXrProgram> program = CreateOpenXrProgram(options, platformPlugin, graphicsPlugin);
```

`xrCreateInstance`
