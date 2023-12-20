import React from 'react'

const url =
  (location.protocol === 'https:' ? 'wss://' : 'ws://')
  + location.hostname
  + (location.port ? `:${location.port}` : '')
  + '/ws';
console.log(url);

var ws: WebSocket | null = null;

type SiteType = {
  url: string;
  title: string;
};

function Site(props: SiteType) {
  return (
    <a className="site" href={props.url}>{props.title}</a>
  );
}

export default function App() {
  const [state, setState] = React.useState<SiteType[]>([]);

  React.useEffect(() => {
    ws = new WebSocket(url);
    console.log(`${url}: connect...`);

    ws.onopen = function() {
      console.log('connected');
    };
    ws.onmessage = function(event) {
      console.log('message', event.data);

      const data = event.data;
      if (data instanceof Blob) {
        data.text().then((text) => {
          const parsed = JSON.parse(text);
          console.log(parsed);
          setState(parsed.sites);
        });
      }

      // setState([
      //   {
      //     title: "google",
      //     url: "http://www.google.com",
      //   }
      // ]);
    };
  }, []);

  return (<>
    <div className="sites">
      {state.map((x, i) => <Site key={i} {...x} />)}
    </div>
  </>);
}
