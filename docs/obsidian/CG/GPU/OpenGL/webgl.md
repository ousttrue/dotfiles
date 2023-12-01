[[OpenGL]]
[[wasm]]

[WebGL Overview - The Khronos Group Inc](https://www.khronos.org/webgl/)
- [WebGL/webgl2.idl at main · KhronosGroup/WebGL · GitHub](https://github.com/KhronosGroup/WebGL/blob/main/specs/2.0.0/webgl2.idl)

- [WebGL - Less Code, More Fun](https://webglfundamentals.org/webgl/lessons/webgl-less-code-more-fun.html)
- [WebGL: 2D and 3D graphics for the web - Web APIs | MDN](https://developer.mozilla.org/en-US/docs/Web/API/WebGL_API)
	- [WebGL tutorial - Web APIs | MDN](https://developer.mozilla.org/en-US/docs/Web/API/WebGL_API/Tutorial)
	- [Adding 2D content to a WebGL context - Web APIs | MDN](https://developer.mozilla.org/en-US/docs/Web/API/WebGL_API/Tutorial/Adding_2D_content_to_a_WebGL_context)
	- [Using shaders to apply color in WebGL - Web APIs | MDN](https://developer.mozilla.org/en-US/docs/Web/API/WebGL_API/Tutorial/Using_shaders_to_apply_color_in_WebGL)
- [Animating objects with WebGL - Web APIs | MDN](https://developer.mozilla.org/en-US/docs/Web/API/WebGL_API/Tutorial/Animating_objects_with_WebGL)
- [Creating 3D objects using WebGL - Web APIs | MDN](https://developer.mozilla.org/en-US/docs/Web/API/WebGL_API/Tutorial/Creating_3D_objects_using_WebGL)
- [Using textures in WebGL - Web APIs | MDN](https://developer.mozilla.org/en-US/docs/Web/API/WebGL_API/Tutorial/Using_textures_in_WebGL)
- [Lighting in WebGL - Web APIs | MDN](https://developer.mozilla.org/en-US/docs/Web/API/WebGL_API/Tutorial/Lighting_in_WebGL)
- [Animating textures in WebGL - Web APIs | MDN](https://developer.mozilla.org/en-US/docs/Web/API/WebGL_API/Tutorial/Animating_textures_in_WebGL)

zig で WEBGL互換のラッパーライブラリを作る
- wasm WebGL2
- Windows/Linux glfw OpenGL4
- android OpenGL ES3

- [ファイルの変更を監視して自動リロードするローカルWebサーバーの起動方法3選 | Hypertext Candy](https://www.hypertextcandy.com/live-reload-web-servers)

`"editor.formatOnSave": true`

- [Quick HTML Previewer - Visual Studio Marketplace](https://marketplace.visualstudio.com/items?itemName=daiyy.quick-html-previewer)

# Version
## 2


```html
 <body>
     <canvas id="glCanvas" width="640" height="480"></canvas>
 </body>
 <script src="renderer.js"></script>
 <script>
     const renderer = new Renderer("#glCanvas");
     renderer.frame();
 </script>

code:renderer.js
 class Renderer {
 
     constructor(canvas_id) {
         const canvas = document.querySelector(canvas_id);
         this.gl = canvas.getContext("webgl2");
         if (this.gl === null) {
             alert("Unable to initialize WebGL. Your browser or machine may not support it.");
         }
     }
 
     // animation
     update(time_ms) {
         const angle = time_ms * 0.001 * Math.PI;
         this.bg = Math.sin(angle) + 1;
         this.clear_color = [this.bg, this.bg, this.bg, 1];
     }
 
     // draw
     render(gl) {
         // Set clear color to black, fully opaque
         gl.clearColor(...this.clear_color);
         // Clear the color buffer with specified clear color
         gl.clear(gl.COLOR_BUFFER_BIT);
     }
 
     frame() {
         this.update(Date.now());
         this.render(this.gl);
         requestAnimationFrame(() => { this.frame(); });
     }
 }
```

- [WebGL用のJavaScript行列計算ライブラリMatrixGLを公開しました](https://sbfl.net/blog/2018/02/05/webgl-matrixgl/#i-2)
- [glMatrix](http://glmatrix.net/)
- [WebGL model view projection - Web APIs | MDN](https://developer.mozilla.org/en-US/docs/Web/API/WebGL_API/WebGL_model_view_projection)
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
