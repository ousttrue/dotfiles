import path from 'node:path';
import url from 'node:url';
const __dirname = path.dirname(url.fileURLToPath(import.meta.url));
console.log(`__dirname => ${__dirname}`);
const dist = path.resolve(__dirname, 'dist');

import { createServer } from "vite";
// https://github.com/vitejs/vite/issues/3555
const vite = await createServer({ server: { middlewareMode: 'ssr' } });

const { generate } = await vite.ssrLoadModule('/src/entry-ssg.ts')
generate(dist);
vite.close();
