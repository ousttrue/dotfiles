- @2022 [\[rcamera\] Redesign · raysan5/raylib · Discussion #2507 · GitHub](https://github.com/raysan5/raylib/discussions/2507)

```zig
pub const struct_Camera3D = extern struct {
    position: Vector3 = @import("std").mem.zeroes(Vector3),
    target: Vector3 = @import("std").mem.zeroes(Vector3),
    up: Vector3 = @import("std").mem.zeroes(Vector3),
    fovy: f32 = @import("std").mem.zeroes(f32),
    projection: c_int = @import("std").mem.zeroes(c_int),
};

pub const CAMERA_CUSTOM: c_int = 0;
pub const CAMERA_FREE: c_int = 1;
pub const CAMERA_ORBITAL: c_int = 2;
pub const CAMERA_FIRST_PERSON: c_int = 3;
pub const CAMERA_THIRD_PERSON: c_int = 4;
```

# UpdateCamera

```zig
raylib.UpdateCamera(&camera, raylib.CAMERA_THIRD_PERSON);
```

# UpdateCameraPro

```zig

pub extern fn UpdateCameraPro(camera: [*c]Camera, movement: Vector3, rotation: Vector3, zoom: f32) void;

    // Camera PRO usage example (EXPERIMENTAL)
    // This new camera function allows custom movement/rotation values to be directly provided
    // as input parameters, with this approach, rcamera module is internally independent of raylib inputs
    raylib.UpdateCameraPro(&camera, .{
        (raylib.IsKeyDown(raylib.KEY_W) || raylib.IsKeyDown(raylib.KEY_UP)) * 0.1 - // Move forward-backward
            (raylib.IsKeyDown(raylib.KEY_S) || raylib.IsKeyDown(raylib.KEY_DOWN)) * 0.1,
        (raylib.IsKeyDown(raylib.KEY_D) || raylib.IsKeyDown(raylib.KEY_RIGHT)) * 0.1 - // Move right-left
            (raylib.IsKeyDown(raylib.KEY_A) || raylib.IsKeyDown(raylib.KEY_LEFT)) * 0.1,
        0.0, // Move up-down
    }, .{
        raylib.GetMouseDelta().x * 0.05, // Rotation: yaw
        raylib.GetMouseDelta().y * 0.05, // Rotation: pitch
        0.0, // Rotation: roll
    }, raylib.GetMouseWheelMove() * 2.0); // Move to target (zoom)
```

# BeginMode3D

```zig
raylib.BeginMode3D(camera);
```

# CameraYaw

```zig
raylib.CameraYaw(camera, -135 * raylib.DEG2RAD, true);
raylib.CameraPitch(camera, -45 * raylib.DEG2RAD, true, true, false);
```
