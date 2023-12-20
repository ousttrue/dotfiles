import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'
import path from "node:path";
import { fileURLToPath } from "node:url";
const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

// https://vitejs.dev/config/
export default defineConfig({
  // root: path.join(__dirname, 'client'),
  plugins: [react()],
  server: {
    proxy: {
      '/ws': {
        target: 'ws://localhost:8080',
        ws: true,
      }
    }
  },
})
