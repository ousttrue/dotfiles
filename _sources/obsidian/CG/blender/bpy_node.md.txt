NodeGroup
#blender #bpy

https://docs.blender.org/manual/ja/2.83/interface/controls/nodes/groups.html

code:.py
 g = bl_material.node_tree.nodes.new('ShaderNodeGroup')
 g.node_tree = bpy.data.node_groups['GLTF']

[* python で node 作る]
https://blender.stackexchange.com/questions/5387/how-to-handle-creating-a-node-group-in-a-script
