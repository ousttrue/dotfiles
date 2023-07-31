
# Normalized Device Coordinate (NDC)
[Projection Matrixについて | shikihuiku – 色不異空 – Real-time rendering topics in Japanese.](https://shikihuiku.github.io/post/projection_matrix/)

## OpenGL
[[OpenGL]]

`gl_Position` => xyzw => w で割った値(正規化デバイス座標)を -1 ~ 1 でクリップする

- `-1 ≤ x ≤ 1`
- `-1 ≤ y ≤ 1`
- `-1 ≤ z ≤ 1`

- [床井研究室 - 第５回 座標変換](https://marina.sys.wakayama-u.ac.jp/~tokoi/?date=20090829)

### 深度値の書き込み値
[glOrtho()のnear/farとz値、デプスバッファ値の関係 : あかすくぱるふぇ](http://akasuku.blog.jp/archives/70170885.html)
> OpenGLは手前側がz軸の正方向なので、正負が入れ替わるのですね。  
一方、デプスバッファの値（デプス値）は、前方面のデプス値が0, 後方面のデプス値が1となるように書き込まれます。

`gl_FragDepth`
- [【WebGL2】gl_FragDepthを使ってフラグメントシェーダーで深度を書き込む - Qiita](https://qiita.com/aa_debdeb/items/3306ecee493603ac0dd0)

## DirectX
[ビューポートとクリッピング (Direct3D 9) - Win32 apps | Microsoft Learn](https://learn.microsoft.com/ja-jp/windows/win32/direct3d9/viewports-and-clipping#set-up-the-viewport-for-clipping)

- `-1 ≤ x ≤ 1`
- `-1 ≤ y ≤ 1`
- `0 ≤ z ≤ 1`

[その70 完全ホワイトボックスなパースペクティブ射影変換行列](http://marupeke296.com/DXG_No70_perspective.html)

