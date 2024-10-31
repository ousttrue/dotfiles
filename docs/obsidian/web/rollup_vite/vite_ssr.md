https://ja.vite.dev/guide/ssr.html

# react

https://github.com/bluwy/create-vite-extra/tree/master/template-ssr-react

- index.html
- src/
  - main.js # exports env-agnostic (universal) app code
  - entry-client.js # mounts the app to a DOM element
  - entry-server.js # renders the app using the framework's SSR API

`index.html`

```html
<div id="app"><!--ssr-outlet--></div>
<script type="module" src="/src/entry-client.js"></script>
```

# process

```ts
function makeSsr(vite) {
  return async (req: IncomingMessage, res: ServerResponse, next) => {
    try {
      const url = req.originalUrl.replace(base, "");

      // Always read fresh template in development
      let template = await fs.readFile("./index.html", "utf-8");
      template = await vite.transformIndexHtml(url, template);
      const render = (await vite.ssrLoadModule("/src/entry-server.jsx")).render;

      const rendered = await render(url, ssrManifest);

      const html = template
        .replace(`<!--app-head-->`, rendered.head ?? "")
        .replace(`<!--app-html-->`, rendered.html ?? "");

      res.status(200).set({ "Content-Type": "text/html" }).send(html);
    } catch (e) {
      vite?.ssrFixStacktrace(e);
      console.log(e.stack);
      res.status(500).end(e.stack);
    }
  };
}
```

# express に 乗せる

```js
import express from "express";

// Create http server
const app = express();

// Add Vite or respective production middlewares
const { createServer } = await import("vite");
const vite = await createServer({
  server: { middlewareMode: true },
  appType: "custom",
  base,
});
app.use(vite.middlewares);

// Serve HTML 👇
app.use("*all", makeSsr(vite));

// Start http server
app.listen(port, () => {
  console.log(`Server started at http://localhost:${port}`);
});
```

# vite-plugin として 実行する

```ts
export default function pluginDevelop(): Plugin {
  return {
    name: "mydev-vite-plugin",
    configureServer: (vite: ViteDevServer) => {
      return () => {
        // https://ja.vitejs.dev/guide/ssr
        vite.middlewares.use(
          // 👇
          makeSsr(vite),
        );
      };
    },
  };
}
```
