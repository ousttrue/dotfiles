bpy.types.Panel
#bpy

https://docs.blender.org/api/current/info_quickstart.html#example-panel

	https://docs.blender.org/api/current/bpy.types.Panel.html
	https://dskjal.com/blender/ui-script.html
	https://en.blender.org/index.php/Dev:Py/Scripts/Cookbook/Code_snippets/Interface
	https://blenderartists.org/t/how-to-make-a-value-slider/663324/3

https://memoteu.hatenablog.com/entry/2019/06/17/132448

[** 場所決め]
[* bl_space_type]
https://docs.blender.org/api/current/bpy.types.Area.html?highlight=view_3d#bpy.types.Area.type

[* bl_region_type]
https://docs.blender.org/api/current/bpy.types.GizmoGroup.html?highlight=bl_region_type#bpy.types.GizmoGroup.bl_region_type

[* bl_category]
code:.py
 class SomePanel(bpy.types.Panel): 
     bl_space_type = "VIEW_3D"
     bl_region_type = "UI" # 右上のパネル
     bl_category = "TAB_NAME" # 勝手に決めてよい
     bl_label = "SECTION_NAME" # 開閉するところの名前。勝手に決めてよい

code:.py
 class BodyRatiosPanel(bpy.types.Panel):
     bl_idname = "OBJECT_PT_body_ratios"
     bl_label = "body ratios"
     bl_space_type = "VIEW_3D"
     bl_region_type = "TOOLS"
     bl_category = "Body Ratios"
 
     @classmethod
     def poll(cls, context):
         for o in bpy.data.objects:
             if o.select:
                 return True
         return False
 
     def draw(self, _context):
         self.layout.label(text="Hello World")

[* layout]
#bpy.types.UILayout

[* property]
`layout.prop`
#bpy_property

