import App from './App.tsx'
import React from 'react'
import ReactDOMServer from 'react-dom/server'
import type { IncomingMessage } from 'connect';


export async function render(req: IncomingMessage): Promise<string | null> {
  let url = req.originalUrl || '';
  if (url.endsWith('/')) {
    url += 'index.html';
  }
  const html = ReactDOMServer.renderToString(
    <React.StrictMode>
      <App />
    </React.StrictMode >
  );
  return html;
}
