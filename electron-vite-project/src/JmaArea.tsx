import {
  UncontrolledTreeEnvironment,
  Tree, StaticTreeDataProvider,
  TreeItem
} from 'react-complex-tree';
import 'react-complex-tree/lib/style-modern.css';

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

type AreaItem = center | office | class10 | class15 | class20;

export type AreaJson = {
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

  constructor(public readonly json: AreaJson) {
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

function Class20(props: {
  area: JmaArea,
  class20: Id<class20>,
}) {
  return (<li>
    {props.class20.name}
  </li>);
}

function Class15(props: {
  area: JmaArea,
  class15: Id<class15>,
}) {
  return (<li>
    {props.class15.name}
    <ul>
      {props.area.class20s
        .filter((class20) => class20.parent == props.class15.id)
        .map((class20) => <Class20 area={props.area} class20={class20} key={class20.id} />)}
    </ul>
  </li>);
}

function Class10(props: {
  area: JmaArea,
  class10: Id<class10>,
}) {
  return (<li>
    {props.class10.name}
    <ul>
      {props.area.class15s
        .filter((class15) => class15.parent == props.class10.id)
        .map((class15) => <Class15 area={props.area} class15={class15} key={class15.id} />)}
    </ul>
  </li>);
}

function Office(props: {
  area: JmaArea,
  office: Id<office>,
}) {
  return (<li>
    {props.office.name}
    <ul>
      {props.area.class10s
        .filter((class10) => class10.parent == props.office.id)
        .map((class10) => <Class10 area={props.area} class10={class10} key={class10.id} />)}
    </ul>
  </li>);
}

function Center(props: {
  area: JmaArea,
  center: Id<center>,
}) {
  return (<li>
    {props.center.name}
    <ul>
      {props.area.offices
        .filter((office) => office.parent == props.center.id)
        .map((office) => <Office area={props.area} office={office} key={office.id} />)}
    </ul>
  </li>);
}


function toTreeItems(json: AreaJson): Record<string, TreeItem<AreaItem>> {
  const items: Record<string, TreeItem<any>> = {
    'root': {
      'index': 'root',
      'data': {
        'name': 'root',
      },
      'children': Object.keys(json.centers),
    },
  }
  function addItems(values: { [key: string]: AreaItem }) {
    for (const index in values) {
      const data = values[index];
      const item: TreeItem = {
        index,
        data: { name: data.name },
      }
      if ('children' in data) {
        item.children = data.children
        item.isFolder = true
      }
      items[index] = item
    }
  }
  addItems(json.centers);
  addItems(json.offices);
  addItems(json.class10s);
  addItems(json.class15s);
  addItems(json.class20s);
  return items;
}


export function AreaSelector(props: {
  // area?: JmaArea
  json: AreaJson | null
}) {
  const json = props.json;
  if (json) {
    // return (<ul>
    //   {area.centers.map((center) => <Center area={area} center={center} key={center.id} />)}
    // </ul>

    const items = toTreeItems(json);
    console.log(items);
    const dataProvider = new StaticTreeDataProvider(items);

    return (
      <UncontrolledTreeEnvironment
        dataProvider={dataProvider}
        getItemTitle={(item: TreeItem<AreaItem>) => item.data.name}
        viewState={{}
        }
      >
        <Tree treeId="tree-1" rootItem="root" treeLabel="Tree Example" />
      </UncontrolledTreeEnvironment >
    );
  }
  else {
    return <div />;
  }
}
