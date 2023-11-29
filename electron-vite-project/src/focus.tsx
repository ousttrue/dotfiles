import { AreaJson, AreaItem } from './JmaArea.jsx';

type itemclass = 'center' | 'office' | 'class10' | 'class15' | 'class20'

function getFocusedItem(
  json: AreaJson | null,
  focusedItem?: string
): { kind: itemclass, value: AreaItem } | null {
  if (!focusedItem) {
    return null;
  }
  const center = json?.centers[focusedItem];
  if (center) {
    return { kind: 'center', value: center };
  }
  const office = json?.offices[focusedItem];
  if (office) {
    return { kind: 'office', value: office };
  }
  const class10 = json?.class10s[focusedItem];
  if (class10) {
    return { kind: 'class10', value: class10 };
  }
  const class15 = json?.class15s[focusedItem];
  if (class15) {
    return { kind: 'class15', value: class15 };
  }
  const class20 = json?.class20s[focusedItem];
  if (class20) {
    return { kind: 'class20', value: class20 };
  }
  return null;
}


export default function Focus(props: {
  json: AreaJson | null,
  focusedItem?: string,
}) {

  const item = getFocusedItem(props.json, props.focusedItem);
  if (!item) {
    return <div>no</div>
  }

  return (<div>
    <div>{props.focusedItem}</div>
    <div>{item.kind}</div>
    <div>{item.value.name}</div>
  </div>);
}
