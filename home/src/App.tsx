import './App.css'
import { type ItemType, ITEMS } from './data';

function Item(props: ItemType) {
  if (props.url) {
    return (
      <div className="item">
        <a href={props.url}>{props.img ? <img width={"100%"} height={"100%"} src={props.img} /> : props.name}</a>
      </div>
    );
  }
  else {
    return (
      <div className="item group">
        {props.img ? <img width={"100%"} height={"100%"} src={props.img} /> : props.name}
      </div>
    );
  }
}

function App() {
  return (
    <div className="container">
      {ITEMS.map((props, i) => <Item key={i} {...props} />)}
    </div>
  );
}

export default App
