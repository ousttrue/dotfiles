[[React]]

[Node-Based UIs in React – React Flow](https://reactflow.dev/)
- [Quickstart – React Flow](https://reactflow.dev/learn#creating-your-first-flow)

```jsx
import React from 'react';
import ReactFlow from 'reactflow';
 
import 'reactflow/dist/style.css';
 
const initialNodes = [
  { id: '1', position: { x: 0, y: 0 }, data: { label: '1' } },
  { id: '2', position: { x: 0, y: 100 }, data: { label: '2' } },
];
const initialEdges = [{ id: 'e1-2', source: '1', target: '2' }];
 
export default function App() {
  return (
    <div style={{ width: '100vw', height: '100vh' }}>
      <ReactFlow nodes={initialNodes} edges={initialEdges} />
    </div>
  );
}
```

# tutorial
- [Quickstart – React Flow](https://reactflow.dev/learn)
	- [Core Concepts – React Flow](https://reactflow.dev/learn/concepts/core-concepts)
	- [Building a Flow – React Flow](https://reactflow.dev/learn/getting-started/building-a-flow)
	- [Adding Interactivity – React Flow](https://reactflow.dev/learn/getting-started/adding-interactivity) 
- [Tutorials – React Flow](https://reactflow.dev/learn/tutorials)
	- @2023 [Integrating React Flow and the Web Audio API – React Flow](https://reactflow.dev/learn/tutorials/react-flow-and-the-web-audio-api)
	-  [GitHub - xyflow/react-flow-web-audio: A simple Web Audio playground built with React Flow. Follow the tutorial to learn how to build it yourself.](https://github.com/xyflow/react-flow-web-audio)

# sample
- [Schema Visualizer](https://sqlhabit.github.io/sql_schema_visualizer/)
- [GitHub - CGeekDylan/Reactflow-data-story: ReactFlow project](https://github.com/CGeekDylan/Reactflow-data-story)
- [GitHub - Azim-Ahmed/Node-flow-diagram: A node based diagram which is built by Reactflow](https://github.com/Azim-Ahmed/Node-flow-diagram)
- [GitHub - JULLIAIP/ProjetoCircles: ReactFlow](https://github.com/JULLIAIP/ProjetoCircles)
- [S](https://kaleidoscopic-arithmetic-3b682b.netlify.app/)
- [WorkFlow Automation-v-1.001](https://workflowautomation.netlify.app/)
- [GitHub - beeglebug/behave-flow: a ui for behave-graph using react-flow](https://github.com/beeglebug/behave-flow)



 