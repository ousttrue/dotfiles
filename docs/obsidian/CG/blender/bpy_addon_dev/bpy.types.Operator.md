[[bl_info]]

- [Operator(bpy_struct) — Blender Python API](https://docs.blender.org/api/current/bpy.types.Operator.html)

# Operator
```python
class ObjectMoveX(bpy.types.Operator):
    # Unique identifier for buttons and menu items to reference.
    bl_idname = "object.move_x"
    # Display name in the interface.
    bl_label = "Move X by One"
    # Enable undo for the operator.
    bl_options = {"REGISTER", "UNDO"}

    # execute() is called when running the operator.
    def execute(self, context):

        # The original script
        scene = context.scene
        for obj in scene.objects:
            obj.location.x += 1.0

        # Lets Blender know the operator finished successfully.
        return {"FINISHED"}
```

## OperatorProperty
- [2-3. オペレータプロパティを活用する | はじめてのBlenderアドオン開発](https://colorful-pico.net/introduction-to-addon-development-in-blender/2.8/html/chapter_02/03_Use_Operator_Property.html)

## invoke と execute
invoke: property をsetup して実行
execute: 設定済みの property 使って実行

```python
class SimpleMouseOperator(bpy.types.Operator):
    """ This operator shows the mouse location,
        this string is used for the tooltip and API docs
    """
    bl_idname = "wm.mouse_position"
    bl_label = "Invoke Mouse Operator"

    x: bpy.props.IntProperty()
    y: bpy.props.IntProperty()

    def invoke(self, context, event):
        self.x = event.mouse_x
        self.y = event.mouse_y
        return self.execute(context)

    def execute(self, context):
        # rather than printing, use the report function,
        # this way the message appears in the header,
        self.report({'INFO'}, "Mouse coords are %d %d" % (self.x, self.y))
        return {'FINISHED'}
```

## poll
`edit mode` など状況を限定できる

## attributes
### bl_options
- UNDO
- REGISTER
- GRAB_CURSOR
- BLOCKING

# register
- class 登録
- menu 登録の両方が必要？(search に表示されない)

# 種類
## Exporter
```python
class ExportOBJ(bpy.types.Operator, ExportHelper):
    """Save a Wavefront OBJ File""" 
    bl_idname = "export_scene.obj" # 命名規則は？
    bl_label = 'Export OBJ'
    bl_options = {'PRESET'}
```

## Importer
```python
class ImportOBJ(bpy.types.Operator, ImportHelper):
    """Load a Wavefront OBJ File"""
    bl_idname = "import_scene.obj"
    bl_label = "Import OBJ"
    bl_options = {'PRESET', 'UNDO'}
```
