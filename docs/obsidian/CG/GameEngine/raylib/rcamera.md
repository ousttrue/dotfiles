- @2022 [\[rcamera\] Redesign · raysan5/raylib · Discussion #2507 · GitHub](https://github.com/raysan5/raylib/discussions/2507)

# UpdateCamera

```zig
pub const CAMERA_CUSTOM: c_int = 0;
pub const CAMERA_FREE: c_int = 1;
pub const CAMERA_ORBITAL: c_int = 2;
pub const CAMERA_FIRST_PERSON: c_int = 3;
pub const CAMERA_THIRD_PERSON: c_int = 4;

raylib.UpdateCamera(&camera, raylib.CAMERA_THIRD_PERSON);
```
