export const JMA_AREA_URL = 'https://www.jma.go.jp/bosai/common/const/area.json'

type areaId = string;

type Id<T> = {
  [K in keyof T]: T[K];
} & { id: string }

type center = {
  name: string,
  enName: string,
  officeName: string,
  children: areaId[],
}

type office = {
  name: string,
  enName: string,
  officeName: string,
  children: areaId[],
  parent: areaId,
}

type class10 = {
  name: string,
  enName: string,
  children: areaId[],
  parent: areaId,
}

type class15 = {
  name: string,
  enName: string,
  children: areaId[],
  parent: areaId,
}

type class20 = {
  name: string,
  enName: string,
  kana: string,
  parent: areaId,
}

type areaJson = {
  centers: { [key: areaId]: center },
  offices: { [key: areaId]: office },
  class10s: { [key: areaId]: class10 },
  class15s: { [key: areaId]: class15 },
  class20s: { [key: areaId]: class20 },
}

export class JmaArea {
  centers: Id<center>[];
  offices: Id<office>[];
  class10s: Id<class10>[];
  class15s: Id<class15>[];
  class20s: Id<class20>[];

  constructor(json: areaJson) {
    function compareId(a: { id: string }, b: { id: string }): number {
      return parseFloat(a.id) - parseFloat(b.id)
    }
    this.centers = Object.entries(json.centers).map(([key, value]) => {
      return Object.assign(value, { id: key });
    }).toSorted(compareId);
    this.offices = Object.entries(json.offices).map(([key, value]) => {
      return Object.assign(value, { id: key });
    }).toSorted(compareId);
    this.class10s = Object.entries(json.class10s).map(([key, value]) => {
      return Object.assign(value, { id: key });
    }).toSorted(compareId);
    this.class15s = Object.entries(json.class15s).map(([key, value]) => {
      return Object.assign(value, { id: key });
    }).toSorted(compareId);
    this.class20s = Object.entries(json.class20s).map(([key, value]) => {
      return Object.assign(value, { id: key });
    }).toSorted(compareId);
  }
}

function Center(props: {
  center: Id<center>,
}) {
  return (<li>
    {props.center.name}
  </li>);
}

function Centers(props: {
  centers: Id<center>[]
}) {
  return (<ul>
    {props.centers.map((center) => <Center center={center} key={center.id} />)}
  </ul>);
}

export function AreaSelector(props: {
  area?: JmaArea
}) {
  if (props.area) {
    return <Centers centers={props.area.centers} />
  }
  else {
    return <div />;
  }
}
