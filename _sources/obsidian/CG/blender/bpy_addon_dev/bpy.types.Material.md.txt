material node
#blender

https://docs.blender.org/manual/en/latest/render/shader_nodes/index.html
https://docs.blender.org/api/blender_python_api_2_72_1/bpy.types.ShaderNode.html
https://blender.stackexchange.com/questions/23436/control-cycles-material-nodes-and-material-properties-in-python
https://blender.stackexchange.com/questions/89277/how-to-define-context-for-a-script
https://www.blenderguru.com/articles/cycles-input-encyclopedia

code:enable.py
 blender_material.use_nodes = True
	tree = blender_material.node_tree
	for x in tree.nodes:
		print(x)
  # <bpy_struct, ShaderNodeOutputMaterial("Material Output")>
  # <bpy_struct, ShaderNodeBsdfPrincipled("Principled BSDF")>

[* node_group]
	http://blenderaddonlist.blogspot.com/2014/08/addon-node-group-to-python-script-ngr.html

[* modules/rna_xml]
	https://github.com/lubosz/blender/blob/master/blender/intern/tools/dump_rna2xml.py
	https://blender.stackexchange.com/questions/43017/any-way-of-serializing-blender-cycles-materials-data

code:.py
 from rna_xml import rna2xml
 import bpy
 
 material = bpy.context.object.active_material
 xml = rna2xml(root_rna=material.node_tree, root_node = "glTF Metallic Roughness")
 print(xml)
