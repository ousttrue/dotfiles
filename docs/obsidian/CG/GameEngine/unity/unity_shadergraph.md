[Shader Graph とは | Shader Graph | 10.0.0-preview.27 ](https://docs.unity3d.com/ja/Packages/com.unity.shadergraph@10.0/manual/index.html)

- [Making a Toon Shader with Unity! (Shader Graph tutorial) - YouTube](https://www.youtube.com/watch?v=_jTXd3x6gOY)

# Version

> 2018.1 以降の Unity
> (URP) や HD レンダーパイプライン (HDRP) などの事前に構築されたスクリプタブルレンダーパイプライン (SRP) をインストールすると、Unity によって Shader Graph が自動的にプロジェクトにインストール
> 事前に構築された SRP パッケージと別に Shader Graph のインストールや更新を行うことは避けてください
> ビルトインのレンダラーには対応していません。

## 10.0.0-preview.27

# Detail

## API

- https://qiita.com/up-hash/items/dc9c9c19bebefbe869cd

## Source

- https://github.com/Unity-Technologies/ShaderGraph
- https://github.com/Unity-Technologies/Graphics

# 構成

### Target

- https://docs.unity3d.com/ja/Packages/com.unity.shadergraph@10.0/manual/Graph-Target.html
- https://github.com/haw2fregel/CustomShaderGraphTarget

## input: Properties / ブラックボード

- https://docs.unity3d.com/ja/Packages/com.unity.shadergraph@10.0/manual/Blackboard.html

### MainTex

## output: MasterStack / MasterNode(旧)

- https://docs.unity3d.com/ja/Packages/com.unity.shadergraph@10.0/manual/Master-Stack.html

### BlockNode

- https://docs.unity3d.com/Packages/com.unity.shadergraph@14.0/manual/Block-Node.html
- https://docs.unity3d.com/ja/Packages/com.unity.shadergraph@10.0/manual/Built-In-Blocks.html

### MasterNode

- [MasterNode解説 &#8211; Unity Shader Graph まとめ](https://shadergraph.sanukin.net/masternode)

## SubGraph

- https://docs.unity3d.com/ja/Packages/com.unity.shadergraph@10.0/manual/Sub-graph.html

## CustomFunction

- https://docs.unity3d.com/ja/Packages/com.unity.shadergraph@10.0/manual/Custom-Function-Node.html

### CustomNode(旧)

- [【Unity】C#で定義されたShaderGraphのカスタムノードが使えない時の対応 #Unity - Qiita](https://qiita.com/pio/items/1127198fb269243a5392)
- [ShaderGraphで自作のNodeを作る際に手順　＋　つまったところ #Unity - Qiita](https://qiita.com/herieru/items/cbc65f4849d048fa27c9)

# MaterialOverride

- [【Unity】ShaderGraph で Material 側で Surface Options を編集する - うにてぃブログ](https://hacchi-man.hatenablog.com/entry/2022/10/02/220000)

# Lighting

## main light direction

`unlit` に対して時前 `Lighting`

- [ShaderGraphでLightを使用する。 - 夜風のMixedReality](https://redhologerbera.hatenablog.com/entry/2021/08/15/194638)
- [Creating Custom Lighting in Unity’s Shader Graph with Universal Render Pipeline](https://nedmakesgames.medium.com/creating-custom-lighting-in-unitys-shader-graph-with-universal-render-pipeline-5ad442c27276)

- https://x.com/ost_51/status/1602535883055697920?lang=ar

# Builtin

- [【Unity】ShaderGraphからShaderLabに人力で書き出すワザ｜氷音](https://note.com/hyoune_note/n/n71d5f872e403)

# Toon

- @2020 [Unity:VRでも使えるMToon互換のURPシェーダを30分で作ろう - simplestarの技術ブログ](https://simplestar-tech.hatenablog.com/entry/2020/02/16/164252)
- @2020 [UniversalRPでなんちゃってMToonシェーダーを作ってみた話 &#8211; ギャップロ](https://gaprot.jp/2020/04/14/universalrp-mtoon/)
- @2019 [Unity:VRMのMToonマテリアルをLWRPのShaderGraphで、その２ - simplestarの技術ブログ](https://simplestar-tech.hatenablog.com/entry/2019/07/15/173818)
- @2019 [Unity:VRMのMToonマテリアルをLWRPのShaderGraphで、その１ - simplestarの技術ブログ](https://simplestar-tech.hatenablog.com/entry/2019/07/15/110051)
