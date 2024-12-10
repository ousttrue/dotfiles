https://docs.unity3d.com/6000.0/Documentation/Manual/Playables.html
https://docs.unity3d.com/ja/2022.3/Manual/Playables-Examples.html

- @2023 [【Unity】Timeline のアニメーション出力をアニメーターのアニメーションとブレンドする【Playable】 #timeline - Qiita](https://qiita.com/tsukimi_neko/items/f8a62df5e45fb9556f4d)

# PlayableGraph Visualizer

`com.unity.playablegraph-visualizer`

https://docs.unity3d.com/ja/2019.4/Manual/com.unity.playablegraph-visualizer.html

https://github.com/Unity-Technologies/graph-visualizer/blob/master/Documentation~/playablegraph-visualizer.md

https://github.com/Unity-Technologies/graph-visualizer

# Playable

- @2024 [Unity Playable API を使いこなす](https://zenn.dev/allways/articles/5b9ef33032d5fa)

> Playable API は AnimatorController に依存せずにアニメーションを再生できる

# PlayableGraph

```cs
    private void Start()
    {
        _playableGraph = PlayableGraph.Create("Example Playable");

        // 更新モードを手動に変更
        _playableGraph.SetTimeUpdateMode(DirectorUpdateMode.Manual);
    }

    private void Update()
    {
        // 2倍の速度で再生する
        var timeScale = 2;
        _playableGraph.Evaluate(Time.deltaTime * timeScale);
    }
```

# PlayableBehaviour

```cs
using UnityEngine;
using UnityEngine.Playables;

public class ParticleSystemPlayable : PlayableBehaviour
{
    private ParticleSystem _particleSystem;

    // 初期化する
    public void Initialize(ParticleSystem particleSystem)
    {
        _particleSystem = particleSystem;
        _particleSystem.Stop();
        if (_particleSystem.useAutoRandomSeed) {
            _particleSystem.randomSeed = 0;
            _particleSystem.useAutoRandomSeed = false;
        }
    }

    // Playableが再生されたときの処理
    public override void OnBehaviourPlay(Playable playable, FrameData info)
    {
        _particleSystem.Play();
    }

    // Playableの再生が止まった時の処理
    public override void OnBehaviourPause(Playable playable, FrameData info)
    {
        _particleSystem.Stop();
    }

    // フレーム毎の処理
    public override void ProcessFrame(Playable playable, FrameData info, object playerData)
    {
        _particleSystem.Simulate(info.deltaTime, false, false);
    }
}
```

# IPlayableOutput

## AnimationPlayableOutput

`animator`

```cs
public static Animations.AnimationPlayableOutput Create (
  Playables.PlayableGraph graph,
  string name,
  Animator target // 👈
);
```

### AnimationScriptPlayable

## AudioPlayableOutput

## ScriptPlayableOutput

- @2021 [【Unity】自作のPlayableを作成しTimelineで再生できるようにする - albatrusのブログ](https://albatrus.com/entry/2021/07/10/190000)

`timeline`

## TexturerPlayaleOutput

# PlayableBehaviour

## nodes

### AnimationClipPlayable

## AnimatorController

### AnimationMixer

### AnimationPose

# Timeline

- [\[Unity\]\[Timeline\] スクリプトから動的に各種TimelineAsset/TrackAsset/TimelineClipなどを生成するTips #timeline - Qiita](https://qiita.com/jukey17/items/af494ee34d0b9669bafb)

# AnimationPlayableUtilities

https://docs.unity3d.com/ja/2023.2/ScriptReference/Playables.AnimationPlayableUtilities.html

# AnimationRig

- @2023 [Animation Riggingでキャラがターゲットを見続け上半身も連動する挙動を実装する | Sirohood](https://sirohood.exp.jp/20230706-4980/)
- @2019 [UnityのAnimation Riggingで良い感じの足のコントローラを作成する | 測度ゼロの抹茶チョコ](https://matcha-choco010.net/2019/11/23/unity-animation-rigging-leg-controller/)
- @2019 [UnityのAnimation Riggingで腕と簡易的な手のコントローラを作った | 測度ゼロの抹茶チョコ](https://matcha-choco010.net/2019/11/24/unity-animation-rigging-hand-arm-controller/)
  - https://github.com/MatchaChoco010/UnityAnimationRiggingHandArmRig

# TImeline と AnimationController

- https://obecogames.com/timeline_animation_extrapolation/
- [Unity Timeline の拡張パターン - ゆとくん.com](https://yutokun.com/knowledges/unity-timeline-extension/index.html)
