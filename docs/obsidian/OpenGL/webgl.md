[[wasm]]


	https://webglfundamentals.org/webgl/lessons/webgl-less-code-more-fun.html

	https://developer.mozilla.org/en-US/docs/Web/API/WebGL_API
		https://developer.mozilla.org/en-US/docs/Web/API/WebGL_API/Tutorial
		https://developer.mozilla.org/en-US/docs/Web/API/WebGL_API/Tutorial/Adding_2D_content_to_a_WebGL_context
  https://developer.mozilla.org/en-US/docs/Web/API/WebGL_API/Tutorial/Using_shaders_to_apply_color_in_WebGL
  https://developer.mozilla.org/en-US/docs/Web/API/WebGL_API/Tutorial/Animating_objects_with_WebGL
  https://developer.mozilla.org/en-US/docs/Web/API/WebGL_API/Tutorial/Creating_3D_objects_using_WebGL
  https://developer.mozilla.org/en-US/docs/Web/API/WebGL_API/Tutorial/Using_textures_in_WebGL
  https://developer.mozilla.org/en-US/docs/Web/API/WebGL_API/Tutorial/Lighting_in_WebGL
		https://developer.mozilla.org/en-US/docs/Web/API/WebGL_API/Tutorial/Animating_textures_in_WebGL

[* live server]
https://www.hypertextcandy.com/live-reload-web-servers

[* vscode]

`"editor.formatOnSave": true`

	https://marketplace.visualstudio.com/items?itemName=daiyy.quick-html-previewer


[* hello]
code:index.html
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

[* matrix]
	https://sbfl.net/blog/2018/02/05/webgl-matrixgl/#i-2
	http://glmatrix.net/
 	https://developer.mozilla.org/en-US/docs/Web/API/WebGL_API/WebGL_model_view_projection
	https://github.com/infusion/Quaternion.js/
