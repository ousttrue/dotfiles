- [HTMLのdraggable属性でユーザが要素を自由に配置できるようにする](https://zenn.dev/mai/articles/cec0746ab1052e)
- [Three.js(WebGL)で一年以上学習した成果と便利なクラス/ライブラリを紹介](https://zenn.dev/uemuragame5683/articles/e2777b5b956f81)
- @2021 [Three.js であそんでみたよ　#techtekt Advent Calendar 2022 - techtekt](https://techtekt.persol-career.co.jp/entry/tech/221213_01)


[[Threejs_react]]

# Version
## r157

## r125
- `Geometry`削除

# Mesh
- Mesh
	- Geometry
	- Material

# Math
-- [three.js MathUtils全関数まとめ](https://zenn.dev/ajitama_tkd/articles/fbc7bc6066bfbe)

# Object3D
## set matrix
- [three.js - AFrame - updating an element's matrix - Stack Overflow](https://stackoverflow.com/questions/67812070/aframe-updating-an-elements-matrix)

- [GitHub - zz85/threejs-term: Terminal Renderer for Three.js](https://github.com/zz85/threejs-term)

- [TOPIC 12｜Three.jsで活用する[2/2]｜ReactでThree.jsを扱う | How To Use | PLATEAU [プラトー]](https://www.mlit.go.jp/plateau/learning/tpc12-2/)

# GeometryBuffer
https://threejs.org/docs/#api/en/core/BufferGeometry

- @2022 [【three.js】GeometryクラスからBufferGeometryを使うよう書き換える #JavaScript - Qiita](https://qiita.com/baikichiz/items/11e0079bf4cf48003a8b)

# WebGLProgram
https://threejs.org/docs/#api/en/renderers/webgl/WebGLProgram

## ShaderMaterial
- [ShaderMaterial – three.js docs](https://threejs.org/docs/#api/en/materials/ShaderMaterial)
- [WebGL研究 (3) Three.jsでGLSLを学習する時に初めに知りたいシステム変数・慣習的な変数｜北田 荘平 / THE GUILD](https://note.com/soohei/n/n2a49a1621750)

## gles3
THREE.ShaderMaterial `#version 300 es` は暗黙。自前で付けない。

```js
// シェーダーを使用する
const material = new THREE.RawShaderMaterial({
  vertexShader: vertexShaderSource,
  fragmentShader: fragmentShaderSource,
  glslVersion: THREE.GLSL3, // ← この行を追加
  uniforms: uniforms
})
```

```c
in vec4 vColor;
out highp vec4 FragColor;
void main() {
  FragColor = vColor;
}
```

# FBO
- [WebGLRenderTargetでオフスクリーンレンダリングする | TECH BLOG | SHOYA KAJITA.](https://blog.shoya-kajita.com/webglrendertarget/)
- [GitHub - spite/THREE.FBOHelper: FrameBuffer Object inspector for three.js](https://github.com/spite/THREE.FBOHelper)
- [GitHub - tuqire/three.js-fbo: GPGPU Module for use with THREE.js](https://github.com/tuqire/three.js-fbo)

# instancing
[three.js interactive cubes / openscience | Observable](https://observablehq.com/@openscience/three-js-interactive-cubes)
