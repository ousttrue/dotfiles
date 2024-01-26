import { defineConfig } from "vite";
import type { Plugin, ViteDevServer } from "vite";
import react from "@vitejs/plugin-react";
import Inspect from "vite-plugin-inspect";
import { glob } from "glob";
import { fileURLToPath } from "node:url";
import path from "node:path";
import process from "node:process";
import fs from "node:fs/promises";
import fm from "front-matter";

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

function myPlugin() {
  const virtualModuleId = "virtual:my-module";
  const resolvedVirtualModuleId = "\0" + virtualModuleId;

  return {
    name: "my-plugin", // 必須、警告やエラーで表示されます
    resolveId(id) {
      if (id === virtualModuleId) {
        return resolvedVirtualModuleId;
      }
    },
    load(id) {
      if (id === resolvedVirtualModuleId) {
        return `export const msg = "from virtual module"`;
      }
    },
  } satisfies Plugin;
}

function mountPlugin(mountPoint: string, dir: string, pattern: string) {
  const module = `${mountPoint}${mountPoint.endsWith("/") ? "" : "/"}index.js`;
  const collection = glob
    .globSync(pattern, {
      cwd: dir,
    })
    .map((x) => {
      const slug = x.replaceAll("\\", "/");
      return {
        slug: slug.replace(/\.md$/, ""),
        title: path.basename(slug, ".md"),
      };
    });
  // console.log(collection);

  let server: ViteDevServer;

  (async function () {
    console.log("gather front-matter...");
    for (const item of collection) {
      const itemPath = path.join(dir, item.slug + ".md");
      const text = await fs.readFile(itemPath, { encoding: "utf-8" });
      const { attributes } = fm(text);
      Object.assign(item, attributes);
    }
    console.log("update front-matter");

    if (server) {
      // server.ws.send({
      //   type: "custom",
      //   event: "mount-update",
      //   data: { mountPoint, collection },
      // });
      const node = server.moduleGraph.getModuleById(module);
      server.reloadModule(node);
    } else {
      console.warn("no server");
    }
  })();

  return {
    name: "mount-plugin", // this name will show up in logs and errors
    configureServer(_server: ViteDevServer) {
      console.log("set server");
      server = _server;

      server.ws.on("connection", () => {
        console.log("connected!");
        server.ws.send({
          type: "custom",
          event: "special-update",
          data: {},
        });
      });
    },
    resolveId(source: string) {
      if (source === module) {
        // this signals that Rollup should not ask other plugins or check
        // the file system to find this id
        return source;
      }
      return null; // other ids should be handled as usually
    },
    load(id: string) {
      if (id === module) {
        // the source code for "virtual-module"
        return `export default ${JSON.stringify(collection)};`;
      }
      return null; // other ids should be handled as usually
    },
    handleHotUpdate({ server }) {
      return [];
    },
  };
}

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [
    react(),
    mountPlugin(
      "/mount/",
      path.join(
        process.env.GHQ_ROOT,
        "github.com/ousttrue/ousttrue.github.io/src/content/posts",
      ),
      "**/*.md",
    ),
  ],
});
