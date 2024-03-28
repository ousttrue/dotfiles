https://threepipe.org/

- [HTML の draggable 属性でユーザが要素を自由に配置できるようにする](https://zenn.dev/mai/articles/cec0746ab1052e)
- [Three.js(WebGL)で一年以上学習した成果と便利なクラス/ライブラリを紹介](https://zenn.dev/uemuragame5683/articles/e2777b5b956f81)
- `vite` @2021 [Three.js で 3D モデル(glTF)を表示する | Octo's blog](https://www.ccbaxy.xyz/blog/2021/04/01/js16/)
- @2021 [Three.js であそんでみたよ　#techtekt Advent Calendar 2022 - techtekt](https://techtekt.persol-career.co.jp/entry/tech/221213_01)
- [Three.js をかじる本](https://zenn.dev/sdkfz181tiger/books/735e854bee9fc9)

# Version

## r162

## r157

## r125

- `Geometry`削除 => `BufferGeometry` [[three_geometry]]

# Mesh

- Mesh
  - Geometry
  - Material

# Math

-- [three.js MathUtils 全関数まとめ](https://zenn.dev/ajitama_tkd/articles/fbc7bc6066bfbe)

# THREE.Object3D

[[object3d]]

## mesh

# WebGLProgram

https://threejs.org/docs/#api/en/renderers/webgl/WebGLProgram

## ShaderMaterial

- [ShaderMaterial – three.js docs](https://threejs.org/docs/#api/en/materials/ShaderMaterial)
- [WebGL 研究 (3) Three.js で GLSL を学習する時に初めに知りたいシステム変数・慣習的な変数｜北田 荘平 / THE GUILD](https://note.com/soohei/n/n2a49a1621750)

## gles3

THREE.ShaderMaterial `#version 300 es` は暗黙。自前で付けない。

```js
// シェーダーを使用する
const material = new THREE.RawShaderMaterial({
  vertexShader: vertexShaderSource,
  fragmentShader: fragmentShaderSource,
  glslVersion: THREE.GLSL3, // ← この行を追加
  uniforms: uniforms,
});
```

```c
in vec4 vColor;
out highp vec4 FragColor;
void main() {
  FragColor = vColor;
}
```

# FBO

- [WebGLRenderTarget でオフスクリーンレンダリングする | TECH BLOG | SHOYA KAJITA.](https://blog.shoya-kajita.com/webglrendertarget/)
- [GitHub - spite/THREE.FBOHelper: FrameBuffer Object inspector for three.js](https://github.com/spite/THREE.FBOHelper)
- [GitHub - tuqire/three.js-fbo: GPGPU Module for use with THREE.js](https://github.com/tuqire/three.js-fbo)

# instancing

[three.js interactive cubes / openscience | Observable](https://observablehq.com/@openscience/three-js-interactive-cubes)

# char

[Creating 3D Characters in Three.js | Codrops](https://tympanus.net/codrops/2021/10/04/creating-3d-characters-in-three-js/)
