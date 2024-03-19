[[OpenGL]] [[wasm]]

[WebGL Overview - The Khronos Group Inc](https://www.khronos.org/webgl/)
- [WebGL/webgl2.idl at main · KhronosGroup/WebGL · GitHub](https://github.com/KhronosGroup/WebGL/blob/main/specs/2.0.0/webgl2.idl)
- [WebGL: 2D and 3D graphics for the web - Web APIs | MDN](https://developer.mozilla.org/en-US/docs/Web/API/WebGL_API)

# Version
## 2

# min triangle

```ts
const GL = WebGL2RenderingContext;


const VS = `#version 300 es
in vec2 aPosition;

void main()
{
  gl_Position = vec4(aPosition, 0, 1);
}
`;

const FS = `#version 300 es
precision mediump float;
out vec4 _Color;

void main(){
  _Color = vec4(1,1,1,1);
}
`;

// shaderSource
// compile
function compileShader(errorPrefix: string, gl: WebGL2RenderingContext,
  src: string, type: number): WebGLShader {
  const shader = gl.createShader(type);
  if (!shader) {
    throw new Error('createShader');
  }
  gl.shaderSource(shader, src);
  gl.compileShader(shader);
  if (!gl.getShaderParameter(shader, GL.COMPILE_STATUS)) {
    const info = gl.getShaderInfoLog(shader);
    gl.deleteShader(shader);
    throw new Error(`${errorPrefix}${info}: ${src}`);
  }
  return shader;
}


class ShaderProgram implements Disposable {
  program: WebGLProgram;

  constructor(public readonly gl: WebGL2RenderingContext) {
    this.program = gl.createProgram()!;
    if (!this.program) {
      throw new Error('createProgram');
    }
  }

  [Symbol.dispose]() {
    this.gl.deleteProgram(this.program);
  }

  link(vs: WebGLShader, fs: WebGLShader) {
    const gl = this.gl;
    gl.attachShader(this.program, vs);
    gl.attachShader(this.program, fs);
    gl.linkProgram(this.program);
    if (!gl.getProgramParameter(this.program, GL.LINK_STATUS)) {
      const info = gl.getProgramInfoLog(this.program);
      throw new Error(`[LinkProgram]: ${info}`);
    }
  }

  // compile, attach, link
  static create(gl: WebGL2RenderingContext, vsSrc: string, fsSrc: string): ShaderProgram {
    const vs = compileShader('[VERTEX_SHADER]: ', gl, vsSrc, GL.VERTEX_SHADER);
    const fs = compileShader('[FRAGMENT_SHADER]: ', gl, fsSrc, GL.FRAGMENT_SHADER);
    const program = new ShaderProgram(gl);
    program.link(vs, fs);
    return program;
  }

  use(gl: WebGL2RenderingContext) {
    gl.useProgram(this.program);
  }
}


class Buffer implements Disposable {
  buffer: WebGLBuffer;
  constructor(
    public readonly gl: WebGL2RenderingContext,
    public readonly type = GL.ARRAY_BUFFER,
  ) {
    this.buffer = gl.createBuffer()!;
    if (!this.buffer) {
      throw new Error('createBuffer');
    }
  }

  [Symbol.dispose](): void {
    this.gl.deleteBuffer(this.buffer);
  }

  static create(gl: WebGL2RenderingContext, bytes: ArrayBuffer): Buffer {
    const buffer = new Buffer(gl, GL.ARRAY_BUFFER);
    buffer.upload(bytes);
    return buffer;
  }

  upload(bytes: ArrayBuffer) {
    const gl = this.gl;
    gl.bindBuffer(this.type, this.buffer);
    gl.bufferData(this.type, bytes, gl.STATIC_DRAW);
    gl.bindBuffer(this.type, null);
  }
}


type VertexAttribute = {
  buffer: Buffer,
  componentType: number,
  componentCount: number,
  bufferStride: number,
  bufferOffset: number,
}


class Vao implements Disposable {
  vao: WebGLVertexArrayObject;
  constructor(public readonly gl: WebGL2RenderingContext) {
    this.vao = gl.createVertexArray()!;
    if (!this.vao) {
      throw new Error('createVertexArray');
    }
  }

  [Symbol.dispose](): void {
    this.gl.deleteVertexArray(this.vao);
  }

  static create(gl: WebGL2RenderingContext, attributes: VertexAttribute[]) {
    const vao = new Vao(gl);
    gl.bindVertexArray(vao.vao);
    let location = 0;
    for (const a of attributes) {
      gl.bindBuffer(GL.ARRAY_BUFFER, a.buffer.buffer);
      gl.enableVertexAttribArray(location);
      gl.vertexAttribPointer(location, a.componentCount, a.componentType, false,
        a.bufferStride, a.bufferOffset);
    }
    gl.bindBuffer(GL.ARRAY_BUFFER, null);
    gl.bindVertexArray(null);
    return vao;
  }

  draw(count: number) {
    this.gl.bindVertexArray(this.vao);
    this.gl.drawArrays(GL.TRIANGLES, 0, count);
    this.gl.bindVertexArray(null);
  }
}


class Renderer {
  shader: ShaderProgram | null = null;
  vbo: Buffer | null = null;
  vao: Vao | null = null;
  render(gl: WebGL2RenderingContext) {
    const { shader, vao } = this.getOrCreate(gl);

    gl.clearColor(0, 0, 0, 1);
    gl.clear(GL.COLOR_BUFFER_BIT);

    shader.use(gl);
    vao.draw(6);
  }

  private getOrCreate(gl: WebGL2RenderingContext): { shader: ShaderProgram, vao: Vao } {
    let shader = this.shader;
    if (!shader) {
      shader = ShaderProgram.create(gl, VS, FS);
      this.shader = shader;
    }

    let vao = this.vao;
    if (!vao) {
      //  2
      // 0>1
      const pos = [
        -1, -1,
        1, -1,
        0, 1,
      ];
      const vbo = Buffer.create(gl, new Float32Array(pos).buffer);
      vao = Vao.create(gl, [
        {
          buffer: vbo,
          bufferStride: 2 * 4,
          bufferOffset: 0,
          componentCount: 2,
          componentType: GL.FLOAT,
        }
      ]);
      this.vao = vao;
    }

    return { shader, vao };
  }
}


function onLoaded() {

  const root = document.getElementById('root') as HTMLDivElement;
	  if (!root) {
    throw new Error('no root');
  }

  const canvas = document.createElement('canvas');
  root.appendChild(canvas);
  canvas.width = canvas.clientWidth;
  canvas.height = canvas.clientHeight;
  console.log(canvas);

  const gl = canvas.getContext('webgl2');
  if (!gl) {
    throw new Error('no webgl2');
  }

  const r = new Renderer();
  r.render(gl);

  console.log('end');
}

document.addEventListener("DOMContentLoaded", onLoaded);
```

# lib
## math
- [WebGL用のJavaScript行列計算ライブラリMatrixGLを公開しました](https://sbfl.net/blog/2018/02/05/webgl-matrixgl/#i-2)
- [glMatrix](http://glmatrix.net/)
- [GitHub - infusion/Quaternion.js: A JavaScript Quaternion library](https://github.com/infusion/Quaternion.js/)

# editor
- [GitHub - realJustinLee/LiAg: LiAg (LiXin Avatar Generator) is an open source 3D avatar modeling software implemented in React.js and WebGL, which provides web side 3D avatar modeling and rendering service, and users can export the avatars into STL files which can be used for 3D printing.](https://github.com/realJustinLee/LiAg)

- [GitHub - coka/webgl-editor: 3D modeling made easy with Polymer and three.js](https://github.com/coka/webgl-editor)

- [Wonder](https://yyc-git.github.io/wonder/index.html)

- [GitHub - Megabyteceer/thing-editor: pixi.js based visual game editor](https://github.com/Megabyteceer/thing-editor)

- [GitHub - chrmoritz/Troxel: WebGL-based voxel viewer and editor](https://github.com/chrmoritz/Troxel)

- [GitHub - tengge1/ShadowEditor-examples: ShadowEditor Demo. https://tengge1.github.io/ShadowEditor-examples/](https://github.com/tengge1/ShadowEditor-examples)

- [GitHub - felixmariotto/Edelweiss-Editor: WebGL platformer game with special game engine](https://github.com/felixmariotto/Edelweiss-Editor)

- [GitHub - adamsol/ThreeStudio: 3D game editor based on Three.js and Electron.](https://github.com/adamsol/ThreeStudio)

- [GitHub - baues/building-editor: 3D model editor for building/architecture](https://github.com/baues/building-editor)

- [GitHub - hakudoshi23/cobweb: A mesh editor for the browser.](https://github.com/hakudoshi23/cobweb)

- [Blockbench](https://www.blockbench.net/)

## model
[3dhaupt's Profile - Free3D](https://free3d.com/user/3dhaupt)

## c++
- [GitHub - riidefi/RiiStudio: Editor for various 3D model formats](https://github.com/riidefi/RiiStudio)
- [GitHub - zturtleman/mm3d: Maverick Model 3D is a 3D model editor based on Misfit Model 3D.](https://github.com/zturtleman/mm3d)

## fiber
- [GitHub - polygonjs/polygonjs-react-three-fiber: React Three Fiber component to load scene created with Polygonjs visual editor](https://github.com/polygonjs/polygonjs-react-three-fiber)

## GIS
- [GitHub - heremaps/xyz-maps: XYZ Maps is an open-source map editor written in TypeScript.](https://github.com/heremaps/xyz-maps)

- [GitHub - siposdani87/expo-maps-polygon-editor: This multi polygon editor is written in TypeScript for the React Native Maps component. This component allows you to select, create, or modify areas on Apple Maps and Google Maps. You can edit multiple polygons at the same time.](https://github.com/siposdani87/expo-maps-polygon-editor)

## vrm
- [GitHub - gatosyocora/vrm-avatar-editor: Web Application Editting VRM Avatar](https://github.com/gatosyocora/vrm-avatar-editor)


zig で WEBGL互換のラッパーライブラリを作る
- wasm WebGL2
- Windows/Linux glfw OpenGL4
- android OpenGL ES3

- [ファイルの変更を監視して自動リロードするローカルWebサーバーの起動方法3選 | Hypertext Candy](https://www.hypertextcandy.com/live-reload-web-servers)

`"editor.formatOnSave": true`

- [Quick HTML Previewer - Visual Studio Marketplace](https://marketplace.visualstudio.com/items?itemName=daiyy.quick-html-previewer)
