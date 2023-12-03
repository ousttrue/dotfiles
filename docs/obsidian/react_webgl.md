
```ts
import React from 'react'
import './App.css'
import { Renderer } from './webgl.js';

function App() {
  // canvas reference
  const ref = React.useRef<HTMLCanvasElement>(null);

  // renderer
  const [state, setState] = React.useState<Renderer | null>(null);

  function getOrCreateState(): Renderer {
    if (state) {
      return state;
    }

    // current size
    const canvas = ref.current!;
    canvas.width = canvas.clientWidth;
    canvas.height = canvas.clientHeight;
    // observe size
    const observer = new ResizeObserver((_) => {
      const canvas = ref.current;
      if (canvas) {
        canvas.width = canvas.clientWidth;
        canvas.height = canvas.clientHeight;
      }
    });
    observer.observe(canvas);

    const gl = canvas.getContext('webgl2');
    if (!gl) {
      throw new Error('no webgl2');
    }
    const newState = new Renderer(gl, observer);
    setState(newState);
    return newState;
  }

  React.useEffect(() => {
    if (!ref.current) {
      return;
    }

    const state = getOrCreateState();

    // render current time
    state.render(ref.current.width, ref.current.height, Date.now());
  });

  const [count, setCount] = React.useState(0);
  requestAnimationFrame(() => {
    // kick animation
    setCount(count + 1);
  });

  return <canvas ref={ref} />;
}

export default App
```