import { useState, useEffect } from 'react'
import {
  JMA_AREA_URL, JmaArea, AreaSelector, AreaJson
} from './JmaArea.jsx';
import './App.css'

function App() {

  // const [area, setArea] = useState<JmaArea>(null);
  const [json, setJson] = useState<AreaJson | null>(null);

  // init
  useEffect(() => {
    fetch(JMA_AREA_URL).then(async (res) => {
      const json = await res.json();
      // console.log(json);
      // setArea(new JmaArea(json));
      setJson(json);
    });
  }, []);


  return (
    <>
      <AreaSelector json={json} />
    </>
  )
}

export default App
