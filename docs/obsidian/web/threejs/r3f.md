- @2022 [Three.jsとreact-three-fiberの実装を比較する #React - Qiita](https://qiita.com/itouoti/items/5cf05aa0598674d854ac)

# version

## 8

- @2021 https://docs.pmnd.rs/react-three-fiber/tutorials/v8-migration-guide

> Work on version 8 has begun 3 Sep 2021

## 4

## 3

- @2019 [超楽しくてカッコいい、Reactで始めるThree.js入門 #React - Qiita](https://qiita.com/hppRC/items/b3e292e210d02005120f)

# dom風の宣言記法

`<Canvas>` が root 要素でその配下は `three.js` 風になる。

```jsx
export const GridCameraLightStory: Story = () => (
  <Canvas shadows>
    <color attach="background" args={[0, 0, 0]} />
    <ambientLight intensity={0.8} />
    <pointLight intensity={1} position={[0, 6, 0]} />
    <directionalLight position={[10, 10, 5]} />
    <OrbitControls makeDefault />
    <Grid cellColor="white" args={[10, 10]} />
    <Box position={[0, 0.5, 0]}>
      <meshStandardMaterial />
    </Box>
  </Canvas>
);
```

# script 構築

- https://docs.pmnd.rs/react-three-fiber/api/objects

```jsx
const mesh = new THREE.Mesh(geometry, material)

function Component() {
  return <primitive object={mesh} position={[10, 0, 0]} />
```


`r3f`
[[Three.js]] [[React]]

- [React Three Fiber Documentation](https://docs.pmnd.rs/react-three-fiber/getting-started/introduction)
	- [React Three Fiber Documentation](https://docs.pmnd.rs/react-three-fiber/getting-started/your-first-scene)

- @2023 [Next.js(TypeScript) + react-three-fiberでVRMを表示する - Activ8 Tech Blog](https://synamon.hatenablog.com/entry/2023/06/06/181313)
- @2023 [blender使いがReact-Three-fiberでWebサイトに3Dを入れてみた｜itaru @cgart](https://note.com/itaru_cgart/n/n196188a99cd3)
- @2023 [ReactThreeFiberというReactで3D表現ができる神ライブラリ](https://zenn.dev/solb/articles/d25e664154cc0c)
- @2022 [驚くほど簡単に3Dシーンを構築！React Three Fiberを使ってみた | 株式会社LIG(リグ)｜DX支援・システム開発・Web制作](https://liginc.co.jp/587025)

```sh
> npm install three @types/three @react-three/fiber
```

# animation
[React Three Fiber Documentation](https://docs.pmnd.rs/react-three-fiber/tutorials/basic-animations)

# drei
[GitHub - pmndrs/drei: 🥉 useful helpers for react-three-fiber](https://github.com/pmndrs/drei)

[Staging / AccumulativeShadows - Docs ⋅ Storybook](https://drei.pmnd.rs/?path=/docs/staging-accumulativeshadows--docs)

- [TOPIC 12｜Three.jsで活用する[2/2]｜ReactでThree.jsを扱う | How To Use | PLATEAU [プラトー]](https://www.mlit.go.jp/plateau/learning/tpc12-2/)

https://qiita.com/osakasho/items/3155111258125ba6a22d
