bpy addon
#blender #bpy #bpy.types.Panel

	https://docs.blender.org/api/blender_python_api_current/bpy.types.Operator.html
	https://docs.blender.org/manual/en/latest/advanced/scripting/addon_tutorial.html
	[【Blender 2.8 アドオン開発】004 Hello Blender AddOn https://memoteu.hatenablog.com/entry/2019/04/11/022255]
	https://memoteu.hatenablog.com/entry/2019/05/08/160000
	https://note.com/appai/n/n1026bd60e789
 [Blender の UI スクリプト集 http://dskjal.com/blender/ui-script.html]
	http://qcganime.web.fc2.com/BLENDER/ADDON01.html

[* 命名規則]
	class名
	bl_idname ユニークになるように小文字でつける `{namespace}.{operator_name}`

Operator
code:.py
 class MESH_OT_InsetStraightSkeleton(bpy.types.Operator):
     bl_idname = "mesh.insetstraightskeleton"
     bl_label = "Inset Straight Skeleton"
     bl_description = "Make an inset inside selection using straight skeleton algorithm"
     bl_options = {'UNDO', 'REGISTER', 'GRAB_CURSOR', 'BLOCKING'}

パネル
code:.py
 class HelloWorldPanel(bpy.types.Panel):
		# `[A-Z][A-Z0-9_]*_{Separator}_[A-Za-z0-9_]+`
     bl_idname = "OBJECT_PT_hello_world"

サブパネル
code:.py
 class OBJ_PT_import_transform(bpy.types.Panel):
     bl_parent_id = "FILE_PT_operator" # sub panel
     bl_space_type = 'FILE_BROWSER'
     bl_region_type = 'TOOL_PROPS'
     bl_label = "Transform"

Exporter
code:.py
 class ExportOBJ(bpy.types.Operator, ExportHelper):
     """Save a Wavefront OBJ File""" 
     bl_idname = "export_scene.obj" # 命名規則は？
     bl_label = 'Export OBJ'
     bl_options = {'PRESET'}

Importer
code:.py
 class ImportOBJ(bpy.types.Operator, ImportHelper):
     """Load a Wavefront OBJ File"""
     bl_idname = "import_scene.obj"
     bl_label = "Import OBJ"
     bl_options = {'PRESET', 'UNDO'}


	`bl_info`
	`bpy.types.Operator` の作成と登録 `bpy.utils.register_class(cls)`
	`bpy.types.Panel` の作成と登録 `bpy.utils.register_class(cls)`
		#bpy.types.Panel

[* addon folder]
	`INSTALL_DIR\2.80\scripts\addons`
	`%USERPROFILE%\AppData\Roaming\Blender Foundation\Blender\2.79\scripts\addons`

code: addon.py
	import bpy
	
	
	class ObjectMoveX(bpy.types.Operator):
    """My Object Moving Script"""
    bl_idname = "object.move_x"
    bl_label = "Move X by One"
    bl_options = {'REGISTER', 'UNDO'}
	
    def execute(self, context):
        scene = context.scene
        for obj in scene.objects:
            obj.location.x += 1.0
	
        return {'FINISHED'}
	
	def register():
    bpy.utils.register_class(ObjectMoveX)
	
	def unregister():
    bpy.utils.unregister_class(ObjectMoveX)
	
	
	if __name__ == "__main__":
    register()

とりあずこれで、`User Preferences - Add-ons`に表示されることを確認する。

#blender

	http://renderhjs.net/textools/blender/

	Snap_Utilities_Line

#blender

	https://dskjal.com/blender/register-operation.html
	https://dskjal.com/blender/python-script-tips.html

	https://sites.google.com/site/matosus304blendernotes/home/download


[* addons]
https://github.com/SavMartin/TexTools-Blender
https://github.com/samytichadou/Auto_Reload_Blender_addon

#blender

https://gumroad.com/l/spmxY

https://modelinghappy.com/archives/28623


AddOn紹介
[https://www.youtube.com/watch?v=SC5qpe0Emmg]

