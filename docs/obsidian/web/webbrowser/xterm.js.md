[Xterm.js](https://xtermjs.org/)

`escape sequence renderer`

- @2022 [node-pty xterm.js websocket を利用したブラウザで動くShellの作成 | 404 motivation not found](https://tech-blog.s-yoshiki.com/entry/294)
- @2020 [xterm.jsの見た目を変更する - haku-maiのブログ](https://n-guitar.hatenablog.com/entry/2020/11/14/212751)
- @2020 [xterm.jsでキーボード入力を受け付ける方法 - haku-maiのブログ](https://n-guitar.hatenablog.com/entry/2020/11/14/203521)
- [GitHub - s-yoshiki/node-websh: node-pty xterm.js websocket を利用したブラウザで動くShell](https://github.com/s-yoshiki/node-websh)

_onRequestRefreshRows

Open
  private _renderService: IRenderService | undefined;

`src/browser/services/Services.mts`
```js
export interface IRenderService extends IDisposable {
  /**
   * Fires on render
   */
  onRender: IEvent<{ start: number, end: number }>;
```



# node-pty
```
npm install --global --production windows-build-tools
```
Downloading installers failed. Error: TypeError: 'process.env' only accepts a configurable, writable, and enumerable data descriptor

[GitHub - microsoft/node-pty: Fork pseudoterminals in Node.JS](https://github.com/microsoft/node-pty)

ビルドが必要。gyp ではまる。`prebuilt` 探すべし

👇

[GitHub - homebridge/node-pty-prebuilt-multiarch: A parallel fork of node-pty providing ia32, amd64, arm, and aarch64 prebuilt packages for macOS, Windows and Linux (glibc and musl libc).](https://github.com/homebridge/node-pty-prebuilt-multiarch)

# xterm-addon-webgl
`TODO`
https://twitter.com/azu_re/status/1125305880042360832


# aframe-xterm-component
@2019
canvas 2d への描画からのコピーを使っているポイ。重い。`quest pro` が負荷で落ちた。
[GitHub - RangerMauve/aframe-xterm-component: Playing around with getting xterm.js working in Aframe VR](https://github.com/RangerMauve/aframe-xterm-component)

# XRTerm
@2020 Three.js の glContext で描画する AframeAddon がソースが無かった。weback よくわからん。
https://github.com/szk/xrterm

# repl
- [GitHub - homma/js-repl: JavaScript REPL on Web Browser](https://github.com/homma/js-repl)

# cell
`/src/common/buffer/CellData.mts`
```ts
export class CellData extends AttributeData implements ICellData
{
  public content = 0;
  public fg = 0;
  public bg = 0;
}
```
