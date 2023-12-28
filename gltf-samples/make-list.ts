import fs from 'node:fs';
import path from 'node:path';
import { glob } from 'glob';

const SAMPLE_DIR = 'glTF-Sample-Models';
const stat = fs.statSync(SAMPLE_DIR);
if (!stat) {
  throw new Error(SAMPLE_DIR)
}

class Item {
  name: string;
  constructor(
    public readonly dir: string,
    public readonly files: string[],
    public readonly ss?: string
  ) {
    this.name = path.basename(dir);
  }
  static fromDir(dir: string): Item {

    const files = glob.globSync('**/*.{gltf,glb}', { cwd: dir });
    const ss = glob.globSync('screenshot/screenshot.{jpg,png,gif}', { cwd: dir });
    return new Item(
      dir.replaceAll('\\', '/'),
      files.map(x => x.replaceAll('\\', '/')),
      ss.length > 0 ? ss[0].replaceAll('\\', '/') : undefined);
  }
}

function* items(dir: string) {
  console.log(dir);
  for (const f of fs.readdirSync(dir)) {
    const fullpath = path.join(dir, f);
    if (fs.statSync(fullpath).isDirectory()) {
      yield Item.fromDir(fullpath);
    }
  }
}

const list = [...items(path.join(SAMPLE_DIR, '2.0'))];
console.log(list);
fs.writeFileSync('list.json', JSON.stringify(list));
console.log('list.json');

