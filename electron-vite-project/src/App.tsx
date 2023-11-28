import { useState, useEffect } from 'react'
import {
  JMA_AREA_URL, JmaArea, AreaSelector
} from './JmaArea.jsx';
import './App.css'

function App() {

  const [area, setArea] = useState<JmaArea>(null);

  // init
  useEffect(() => {
    fetch(JMA_AREA_URL).then(async (res) => {
      const json = await res.json();
      console.log(json);
      setArea(new JmaArea(json));
    });
  }, []);


  return (
    <>
      <AreaSelector area={area} />
    </>
  )
}

export default App
