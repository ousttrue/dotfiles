[Xterm.js](https://xtermjs.org/)
[[node-pty]]
[[hyper.js]]

- [GitHub - EdisonDevadoss/xterm-terminal-demo](https://github.com/EdisonDevadoss/xterm-terminal-demo)

- @2022 [node-pty xterm.js websocket を利用したブラウザで動くShellの作成 | 404 motivation not found](https://tech-blog.s-yoshiki.com/entry/294)
- @2021 [ブラウザからTemrinalに接続するxterm.jsをNext.jsとNestJSで構築する - ハイパーマッスルエンジニア](https://www.rasukarusan.com/entry/2021/05/01/124642)
- @2020 [Xterm js Terminal. In this article, I will explain about… | by Edison Devadoss | YavarTechWorks | Medium](https://medium.com/yavar/xterm-js-terminal-2b19ccd2a52)
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

# onData
```ts
export class InputHandler extends Disposable implements IInputHandler {

  public triggerDataEvent(data: string, wasUserInput: boolean = false): void {

export class CoreService extends Disposable implements ICoreService {

    this.register(forwardEvent(this.coreService.onData, this._onData));
```

# keydown
```ts
export class Terminal extends CoreTerminal implements ITerminal {

  public open(parent: HTMLElement): void {

  private _initGlobal(): void {
    this._bindKeys();

  private _bindKeys(): void {
    this.register(addDisposableDomListener(this.textarea!, 'keyup', (ev: KeyboardEvent) => this._keyUp(ev), true));
    this.register(addDisposableDomListener(this.textarea!, 'keydown', (ev: KeyboardEvent) => this._keyDown(ev), true));
    this.register(addDisposableDomListener(this.textarea!, 'keypress', (ev: KeyboardEvent) => this._keyPress(ev), true));
```
