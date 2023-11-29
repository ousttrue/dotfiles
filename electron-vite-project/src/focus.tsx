import { AreaJson, AreaItem, itemclass } from './JmaArea.jsx';
import React from 'react';
import Map from 'react-map-gl';
import maplibregl from 'maplibre-gl';
import 'maplibre-gl/dist/maplibre-gl.css';

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

function Info(props: {
  focusedItem?: string,
  item: { kind: itemclass, value: AreaItem } | null
}) {
  const item = props.item;
  if (item) {
    return (<div style={{
      display: 'flex',
      flexDirection: 'row',
      flexGrow: 0,
    }}>
      <div>{props.focusedItem}</div>
      <div>{item.kind}</div>
      <div>{item.value.name}</div>
    </div >);
  }
  else {
    return <div>'no'</div>;
  }
}


export default function Focus(props: {
  json: AreaJson | null,
  focusedItem?: string,
}) {

  return (<div style={{
    display: 'flex',
    flexDirection: 'column',
    height: '100%',
  }}>
    <Info
      focusedItem={props.focusedItem}
      item={getFocusedItem(props.json, props.focusedItem)}
    />
    <div
      style={{ flexGrow: 1 }}
    >
      <Map
        initialViewState={{
          longitude: 139.68786,
          latitude: 35.68355,
          zoom: 16,
        }}
        mapLib={maplibregl}
        mapStyle="https://tile.openstreetmap.jp/styles/osm-bright-ja/style.json"
      />
    </div>
  </div >);
}
