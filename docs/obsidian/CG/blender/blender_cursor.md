# 移動

`shift + 右クリック`

# カーソルの向き

https://blender.stackexchange.com/questions/211429/how-do-i-rotate-the-3d-cursor-to-match-the-rotation-of-a-camera

```py
bpy.context.scene.cursor.matrix = bpy.context.scene.camera.matrix_world
```
