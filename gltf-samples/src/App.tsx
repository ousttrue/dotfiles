import React from 'react'
import './App.css'
import list from '../list.json';
import { Card, Button, Badge } from 'react-daisyui';
import { Gltf, useGLTF } from '@react-three/drei'
import { Canvas } from '@react-three/fiber'
import { OrbitControls } from '@react-three/drei'


type ItemType = {
  dir: string;
  name: string;
  files: string[];
  ss: string | null;
}

function getName(f: string) {
  const l = f.split('/')
  return l[l.length - 2];
}

function GltfButton(props: { dir: string, file: string, setCurrent: Function }) {
  return (<Button
    onClick={() => { props.setCurrent(`${props.dir}/${props.file}`); }}
    size="xs"
    color="primary" >
    {getName(props.file)}
  </Button >)
}

function Item(props: ItemType & { setCurrent: Function }) {
  return (<Card className="p-0 m-2 shadow">
    {props.ss ? <Card.Image className="h-24" src={`${props.dir}/${props.ss}`} /> : ""}
    <Card.Body className="items-center text-center">
      <Card.Title className="text-lg">{props.name}</Card.Title>
      <Card.Actions>
        {props.files.map((f, i) => <GltfButton key={i}
          dir={props.dir} file={f}
          setCurrent={props.setCurrent}
        />)}
      </Card.Actions>
    </Card.Body>
  </Card>);
}


function GltfView(props: { src: string }) {
  return (<Canvas shadows camera={{ position: [0, 0, 10] }}>
    <ambientLight intensity={0.1} />
    <directionalLight position={[0, 0, 5]} castShadow />
    {/* <GeoBox /> */}
    {/* <GeoText /> */}
    {/* <GeoText3d /> */}
    {/* <GeoTexture /> */}
    {/* <GeoEnv /> */}
    {props.src.length > 0 ? <Gltf src={props.src} /> : ''}
    <OrbitControls />
  </Canvas>)
}


function App() {
  const [current, setCurrent] = React.useState('')

  return (<>
    <div style={{ width: '300px', height: '100%', overflowY: 'scroll' }}>
      {list.map((x: ItemType, i) => <Item key={i} setCurrent={setCurrent} {...x} />)}
    </div>
    <GltfView src={current} />
  </>
  )
}

export default App
