[[Unity]Prefabの同値での上書きを一括リバートするツール作った話 - Qiita](https://qiita.com/nakatsuji_tomohiro/items/80c5008f219f574c45ba)

- @2020 [【Unity】GUI, GUILayout, EditorGUI, EditorGUILayout の違い - うにてぃブログ](https://hacchi-man.hatenablog.com/entry/2020/01/14/220000)

# CustomEditor に `Script` を作る

- @2021 [【Unity】CustomEditor 作成時にスクリプトの参照を Inspector に表示する - うにてぃブログ](https://hacchi-man.hatenablog.com/entry/2021/01/22/220000)

```cs
[CustomEditor(typeof(SampleMonoBehaviour))]
public class SampleMonoBehaviourEditor : Editor
{
    private SerializedProperty _script;
    private void OnEnable()
    {
        _script = serializedObject.FindProperty("m_Script");
    }
    public override void OnInspectorGUI()
    {
        using (new EditorGUI.DisabledScope(true))
        {
            EditorGUILayout.PropertyField(_script);
        }
    }
}
```

# DrawPropertiesExcluding

# iterator

```cs
        protected virtual void RecursiveProperty(SerializedProperty root)
        {
            var depth = root.depth;
            var iterator = root.Copy();
            for (var enterChildren = true; iterator.NextVisible(enterChildren); enterChildren = false)
            {
                if (iterator.depth < depth)
                {
                    // 前の要素よりも浅くなった。脱出
                    return;
                }
                depth = iterator.depth;

                using (new EditorGUI.DisabledScope("m_Script" == iterator.propertyPath))
                {
                    EditorGUILayout.PropertyField(iterator, true);
                }
            }
        }
```

# bool

`EditorGUILayout.Toggle`

# object

# ReordearableList

# EditorGUILayout
