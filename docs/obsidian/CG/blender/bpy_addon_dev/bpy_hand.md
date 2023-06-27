bpy hand
https://twitter.com/kiofwjjptyq08cz/status/1131168550968672257

```python
import bpy
from mathutils import Vector
from typing import NamedTuple


class Bone(NamedTuple):
    name: str
    length: float


def activate(obj):
    bpy.context.view_layer.objects.active = obj
    obj.select_set(True)


def get_or_create_bone(armature: bpy.types.Armature, name: str):
    if name in armature.edit_bones:
        return armature.edit_bones[name]
    return armature.edit_bones.new(name)


class Hand:
    '''
    手首から指: 10
    指: 5-3-2
    親指: 5-4-3
    '''

    def __init__(self, scale: float, suffix: str):
        self.scale = scale
        self.suffix = suffix

    def create_finger(self, armature: bpy.types.Armature,
                       hand: bpy.types.EditBone, offset: Vector, name: str,
                       proximal_length: float, intermediate_length: float,
                       distal_length: float):
 
         # proximal
         proximal = get_or_create_bone(armature, f'{name}1{self.suffix}')
         proximal.parent = hand
         proximal.head = hand.tail + offset * self.scale
         proximal.tail = proximal.head + Vector(
             (proximal_length * self.scale, 0, 0))
 
         # intermediate
         intermediate = get_or_create_bone(armature, f'{name}2{self.suffix}')
         intermediate.parent = proximal
         intermediate.head = proximal.tail
         intermediate.tail = intermediate.head + Vector(
             (intermediate_length * self.scale, 0, 0))
 
         # distal
         distal = get_or_create_bone(armature, f'{name}3{self.suffix}')
         distal.parent = intermediate
         distal.head = intermediate.tail
         distal.tail = distal.head + Vector((distal_length * self.scale, 0, 0))
 
     def create(self, obj: bpy.types.Object):
         activate(obj)
         armature = obj.data
         if not isinstance(armature, bpy.types.Armature):
             raise Exception('not armature')
 
         # to edit mode
         mode = bpy.context.object.mode
         if mode != 'EDIT':
             print(f'enter EDIT mode from {mode} mode')
             bpy.ops.object.mode_set(mode='EDIT')
 
         armature.show_names = True
         armature.display_type = 'STICK'
 
         # hand
         hand = get_or_create_bone(armature, 'hand' + self.suffix)
         hand.head = (0, 0, 0)
         hand.tail = (1 * self.scale, 0, 0)
 
         # fingers
         self.create_finger(armature, hand, Vector((0, -2, 0)), 'thumb', 5, 4,
                            3)
         self.create_finger(armature, hand, Vector((4, -1, 0)), 'index', 5, 3,
                            2)
         self.create_finger(armature, hand, Vector((4, 0, 0)), 'middle', 5, 3,
                            2)
         self.create_finger(armature, hand, Vector((4, 1, 0)), 'ring', 5, 3, 2)
         self.create_finger(armature, hand, Vector((4, 2, 0)), 'little', 5, 3,
                            2)
 
 
def get_or_create_armature():
    active = bpy.context.active_object
    if active and isinstance(active.data, bpy.types.Armature):
        print('found')
        return active

    print('create')
    # data
    data = bpy.data.armatures.new(name="Armature")
    # obj
    obj = bpy.data.objects.new(name="Armature", object_data=data)
    # link
    bpy.context.scene.collection.objects.link(obj)

    return obj


def run():
    print('## start ##')
    obj = get_or_create_armature()
    hand = Hand(0.15 / 20, '.L')
    hand.create(obj)
```
