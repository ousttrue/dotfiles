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
