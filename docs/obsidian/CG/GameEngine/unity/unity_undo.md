
```cs
UnityEditor.Undo.IncrementCurrentGroup();
UnityEditor.Undo.SetCurrentGroupName("VRM10SpringBoneColliderGroup.Separate");
var undo = UnityEditor.Undo.GetCurrentGroup();
{
  // do something
}
UnityEditor.Undo.CollapseUndoOperations(undo);
```
