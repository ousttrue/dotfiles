- https://tech.framesynthesis.co.jp/unity/uitoolkit/
- https://docs.unity.cn/Manual/UIE-uxml-element-TreeView.html

# version

## 2023

- [New UI Toolkit demos for programmers and artists | Unity Blog](https://unity.com/blog/engine-platform/new-ui-toolkit-demos-for-programmers-artists)

## 2022.3

https://docs.unity3d.com/ja/2022.3/Manual/UIElements.html

## 2021

> Unity 2021.2以降では実行時にUI ToolkitのUIを使用できます。

## 2019.3

`UIELements` から名前が変わった。

# inspector

- https://gaprot.jp/2023/12/04/unity_ui_toolkit/

## CreateInspectorGUI

`1回のみ呼ばれ`

- @2020 [【Unity】CustomEditor を UIElements を使って作成する - うにてぃブログ](https://hacchi-man.hatenablog.com/entry/2020/11/04/220000)
- [【Unity】デフォルトのカスタムエディタを実装可能なisFallbackフラグの紹介【CustomEditor】 #UnityEditor - Qiita](https://qiita.com/su10/items/9d83b6b5c6ee43b08e4d)

```cs
using UIToolKitSample.Behaviour;
using UnityEditor;
using UnityEngine.UIElements;

namespace UIToolKitSample.Editor.Inspector
{
    /// <summary>
    /// SampleBehaviourのエディタ拡張クラス
    /// </summary>
    [CustomEditor(typeof(SampleBehaviour))]
    public class SampleBehaviourEditor : UnityEditor.Editor
    {
        /// <summary>
        /// CreateInspectorGUI
        /// </summary>
        /// <returns></returns>
        public override VisualElement CreateInspectorGUI()
        {
            var root = new VisualElement();
            root.Bind(serializedObject);
            {
                var s = new PropertyField { bindingPath = "m_Script" };
                s.SetEnabled(false);
                root.Add(s);
            }

            return root;
        }
    }
}
```

# UIElements

https://docs.unity3d.com/ja/2023.1/Manual/UIE-ElementRef.html

## ImGui

```cs
var container = new IMGUIContainer(OnInspectorGUI);
root.Add(container);
```

## Button

```cs
    // 出力ボタンElementを作成
    var outputButton = new Button(() => outputMethod.Invoke(instance, null));
    outputButton.text = "出力する";
    outputButton.style.width = 70;
    // ルートに出力ボタンElementを追加
    root.Add(outputButton);
```

## EnumField

```cs
    // DataTypeプルダウンElementを作成
    var dataTypeField = new EnumField("データの種類", DataType.None);
    // DataTypeプロパティを取得
    var dataTypeProp = serializedObject.FindProperty("_dataType");
    // フィールドにプロパティを紐付け
    dataTypeField.BindProperty(dataTypeProp);
    // ルートにDataTypeプルダウンElementを追加
    root.Add(dataTypeField);
```

## 継承

```cs
    /// <summary>
    /// SampleDataのElementクラス
    /// </summary>
    public class SampleDataElement : VisualElement
    {
        /// <summary>
        /// コンストラクタ
        /// </summary>
        public SampleDataElement()
        {
            // ここでインスペクタに表示する要素を作成していく
        }
    }
```

## items

https://docs.unity3d.com/2022.3/Documentation/Manual/UIE-ListView-TreeView.html

### ListView

- @2023 `itemsSource` [【Unity】UIElementsでListViewを使いたい #Unity - Qiita](https://qiita.com/tamutamuta/items/d330b87035ff29e4dc31)

- @2024 [【Unity】List Viewの中に複雑なUIを構築する（VisualElement.userData）【UI Toolkit】 #C# - Qiita](https://qiita.com/AtsuAtsu0120/items/65c02fc2ce8cd10d8fda)
- @2023 `UXML` [【Unity】【UI Toolkit】ListViewとListをBinding Pathを使ってバインドする - LIGHT11](https://light11.hatenadiary.com/entry/2023/07/19/192346)

### MultiColumnListView

https://docs.unity3d.com/2022.3/Documentation/Manual/UIE-uxml-element-MultiColumnListView.html

- @2023 [【Unity】【UI Toolkit】MultiColumnListViewを使って複数のカラムを持つリストビューを実装する - LIGHT11](https://light11.hatenadiary.com/entry/2023/05/16/194903)

### TreeView

- https://docs.unity3d.com/Manual/UIE-uxml-element-MultiColumnTreeView.html
