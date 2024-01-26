import { defineConfig } from "vite";
import type { Plugin } from "vite";
import react from "@vitejs/plugin-react";
import Inspect from "vite-plugin-inspect";
import { glob } from "glob";
import { fileURLToPath } from "node:url";
import path from "node:path";
import process from "node:process";

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
  const root = `${mountPoint}${mountPoint.endsWith("/") ? "" : "/"}index.js`;
  const collection = glob
    .globSync(pattern, {
      cwd: dir,
    })
    .map((x) => {
      const slug = x.replaceAll("\\", "/");
      return {
        slug,
        title: path.basename(slug, ".md"),
      };
    });
  console.log(collection);

  return {
    name: "mount-plugin", // this name will show up in logs and errors
    resolveId(source: string) {
      if (source === root) {
        // this signals that Rollup should not ask other plugins or check
        // the file system to find this id
        return source;
      }
      return null; // other ids should be handled as usually
    },
    load(id: string) {
      if (id === root) {
        // the source code for "virtual-module"
        return `export default ${JSON.stringify(collection)};`;
      }
      return null; // other ids should be handled as usually
    },
  };
}

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [
    myPlugin(),
    react(),
    Inspect(),
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
