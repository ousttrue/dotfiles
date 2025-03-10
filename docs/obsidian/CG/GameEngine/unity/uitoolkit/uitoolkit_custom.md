- https://docs.unity3d.com/ja/2022.3/Manual/UIE-expose-custom-control-to-uxml.html

```cs
// 継承 定型
class StatusBar : VisualElement
{
    // factory 定型
    public new class UxmlFactory : UxmlFactory<StatusBar, UxmlTraits> {}

    // Trait カスタム
    public new class UxmlTraits : VisualElement.UxmlTraits
    {
        // xml 初期値
        UxmlStringAttributeDescription m_Status = new UxmlStringAttributeDescription { name = "status" };

        // children
        public override IEnumerable<UxmlChildElementDescription> uxmlChildElementsDescription
        {
            get { yield break; }
        }

        // 子要素を受ける
        // public override IEnumerable<UxmlChildElementDescription> uxmlChildElementsDescription
        // {
        //     get
        //     {
        //         yield return new UxmlChildElementDescription(typeof(VisualElement));
        //     }
        // }

        // 初期化 html 初期値を object に反映する
        public override void Init(VisualElement ve, IUxmlAttributes bag, CreationContext cc)
        {
            base.Init(ve, bag, cc);
            ((StatusBar)ve).status = m_Status.GetValueFromBag(bag, cc);
        }
    }
}
```

# articles

- @2020 [【Unity】【UI Toolkit（旧UIElements）】独自のUXML要素（コントロール）を作る - LIGHT11](https://light11.hatenadiary.com/entry/2020/04/26/124956)

# VisualElement

# Attribute
