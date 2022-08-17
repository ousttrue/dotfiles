[[OpenGL]]

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

- [ファイルの変更を監視して自動リロードするローカルWebサーバーの起動方法3選 | Hypertext Candy](https://www.hypertextcandy.com/live-reload-web-servers)

`"editor.formatOnSave": true`

- [Quick HTML Previewer - Visual Studio Marketplace](https://marketplace.visualstudio.com/items?itemName=daiyy.quick-html-previewer)


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

