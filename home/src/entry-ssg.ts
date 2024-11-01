import fs from 'node:fs';
import path from 'node:path';
import { render } from './main.tsx';
import type { IncomingMessage } from 'connect';

// pre-render each route...
async function prerenderAndWrite(template: string, url: string, dist: string) {
  let filePath = path.join(dist, url);
  console.log('pre-render...:', filePath)

  const rendered = await render({
    originalUrl: url,
  } as IncomingMessage)
  if (rendered) {
    // 5. アプリケーションのレンダリングされた HTML をテンプレートに挿入します。
    const html = template.replace(`<!--ssr-outlet-->`, rendered);

    if (filePath.endsWith('/')) {
      filePath += 'index.html';
    }
    const dir = path.dirname(filePath);
    try {
      if (!fs.existsSync(dir)) {
        // console.log('mkdir', dir);
        fs.mkdirSync(dir, { recursive: true });
      }
      fs.writeFileSync(filePath, html)
    }
    catch (e) {
      console.error(e);
    }
  }
  else {
    console.error(`${url} failed`)
  }
}

export async function generate(dist: string) {
  const template_src = fs.readFileSync(
    'index.html',
    'utf-8',
  )

  await prerenderAndWrite(template_src, 'index.html', dist);
}
