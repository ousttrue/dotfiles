import { useState } from "react";
import reactLogo from "./assets/react.svg";
import viteLogo from "/vite.svg";
import "./App.css";
import collection from "/mount/index.js";

if (import.meta.hot) {
  console.log(import.meta.hot);
  import.meta.hot.on("mount-update", (data) => {
    console.log("mount-update", data);
  });
  import.meta.hot.on("special-update", (data) => {
    console.log("special-update", data);
  });
} else {
  console.log("not hot");
}

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
