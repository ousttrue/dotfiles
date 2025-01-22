`Playable API`

- @2019 [【Unity】Unity2019.1から"Timeline"がPackage Managerへ移動、ソースコードの確認や変更が可能に - テラシュールブログ](https://tsubakit1.hateblo.jp/entry/2019/01/21/210756)

`Timeline package 必要`

https://docs.unity3d.com/Packages/com.unity.timeline@1.7/manual/index.html

- @2022 [Unity - Timeline 解体新書 - yotiky Tech Blog](https://yotiky.hatenablog.com/entry/unity_timeline)
- @2022 [【Unity】TimelineのClipにBehaviourを生成させない - ノートの端の書き残し](https://nigiri.hatenablog.com/entry/2022/10/12/113417)
- @2019 [Unity の Timeline をカスタマイズするための詳細 #C# - Qiita](https://qiita.com/hadashiA/items/566f0d0222cb9a4e209b)

# version

## 1.7.6

# unity

## Playable Director

https://docs.unity3d.com/Packages/com.unity.timeline@1.8/manual/playable-director.html

## Timeline assets

https://docs.unity3d.com/Packages/com.unity.timeline@1.8/manual/tl-overview.html

## Timeline windows

https://docs.unity3d.com/Packages/com.unity.timeline@1.8/manual/tl-window.html

`Window > Sequencing > Timeline`

# tracks

## TrackAsset

## AnimationTrack: TrackAsset

```cs
    public partial class AnimationTrack : TrackAsset, ILayerable
```

> Legacy Animation Clips are not supported

## Playable Track

- @2021 [Unity TimelineのPlayable Trackとその実装方法について #PlayableDirector - Qiita](https://qiita.com/Hibiro22/items/7803a19da03f6cf231d7)
> TimeLine上に、スクリプト制御を設定できるTrack

## CustomTrack

- @2024 [【Unity】Timelineでカスタムトラックを作成する方法 | ゆいブロ](https://www.yui-tech-blog.com/entry/20200229-1582986697/)

# PlayableAsset & PlayableBehaviour

- @2022 [Unity で Timeline のカスタムトラックおよびクリップを作成して見た目をキレイにしてみた - 凹みTips](https://tips.hecomi.com/entry/2022/03/28/235336)

```cs
using UnityEngine;
using UnityEngine.Playables;

public class CustomClip : PlayableAsset
{
    public Gradient gradient;

    public override Playable CreatePlayable(PlayableGraph graph, GameObject go)
    {
        var playable = ScriptPlayable<CustomBehaviour>.Create(graph);
        var behaviour = playable.GetBehaviour();
        behaviour.clip = this;
        return playable;
    }
}
```


# binding

- @2021 [Unity Timeline(Playable Director)を複製した際にGameObjectのバインドがはずれてしまう。。 #C# - Qiita](https://qiita.com/kumi0708/items/20799452ab65996f0df6)
