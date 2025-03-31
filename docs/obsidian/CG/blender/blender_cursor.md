https://docs.blender.org/manual/ja/dev/editors/3dview/3d_cursor.html

# gizmo

# snap menu

`shift + s`

# move cursor

## 移動

`shift + 右クリック`

## 向き

https://blender.stackexchange.com/questions/211429/how-do-i-rotate-the-3d-cursor-to-match-the-rotation-of-a-camera

```py
# camera
bpy.context.scene.cursor.matrix = bpy.context.scene.camera.matrix_world

# object
bpy.context.scene.cursor.matrix = bpy.context.active_object.matrix_world
```

# selected to cursor

# cursor to selected / active

`shift + s`
