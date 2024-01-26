import { useState } from "react";
import reactLogo from "./assets/react.svg";
import viteLogo from "/vite.svg";
import "./App.css";
import collection from "/mount/index.js";

type ItemType = {
  slug: string;
  title: string;
};

function Item({ slug, title }: ItemType) {
  return <div>{title}</div>;
}

function App() {
  const [count, setCount] = useState(0);

  return (
    <div>
      {collection.map((item: ItemType, i: number) => (
        <Item key={i} {...item} />
      ))}
    </div>
  );
}

export default App;
