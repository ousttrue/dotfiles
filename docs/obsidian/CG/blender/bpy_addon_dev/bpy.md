[[bl_info]]
[[bpy_template_list]]
[[bpy.types.Panel]]
[[bpy_node]]
[[bpy.types.Material]]
[[blend_file]]
[[blender]]
[[bpy.data]]
[[bpy.context.window_manager]]
[[bpy.types.Scene]]
[[bpy.types.Object]]

- [Blender Scripts Memo](https://zenn.dev/samia_done/scraps/6589a7e9547169)
- @2021 [PythonでBlenderを操作してみる](https://zenn.dev/hotcocoa/articles/5c5ab06c40862b)

# Verson
[Blender latest Python API Documentation — Blender Python API](https://docs.blender.org/api/latest/)

## 3.4
- [Blender 3.4 Python API Documentation — Blender Python API](https://docs.blender.org/api/3.4/)
## 2.8
- [Blender Python Script - mato.sus304 Blender Notes](https://sites.google.com/site/matosus304blendernotes/home/blender-python-script)

# Structure
- scene: bpy.context.scene
	- view_layer: scene.view_layers[0]
		- collection: view_layer.active_layer_collection.collection(scene.collection)
			- objects: collection.objects
