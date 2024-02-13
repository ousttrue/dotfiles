# glb

glb 出力例

```python
def glb_bytes(json_chunk: bytes, bin_chunk: bytes) -> Iterable[bytes]:
	def chunk_size(chunk: bytes) -> Tuple[int, int]:
	    chunk_size = len(chunk)
	    padding = 4 - chunk_size % 4
	    return chunk_size, padding

    json_chunk_size, json_chunk_padding = chunk_size(json_chunk)
    bin_chunk_size, bin_chunk_padding = chunk_size(bin_chunk)
    total_size = 12 + (8 + json_chunk_size + json_chunk_padding) + \
        (8 + bin_chunk_size + bin_chunk_padding)

    yield struct.pack('III', 0x46546C67, 2, total_size)
    yield struct.pack('II', json_chunk_size+json_chunk_padding, 0x4E4F534A)
    yield json_chunk
    yield b' ' * json_chunk_padding
    yield struct.pack('II', bin_chunk_size+bin_chunk_padding, 0x004E4942)
    yield bin_chunk
    yield b'\0' * bin_chunk_padding
```

# sample

- https://github.com/KhronosGroup/glTF-Sample-Assets
  - https://github.com/KhronosGroup/glTF-Sample-Assets/blob/main/Models/Models-showcase.md
- [Graphics Research Samples](https://www.intel.com/content/www/us/en/developer/topic-technology/graphics-research/samples.html)

# Viewer

## c++

- [glTF Viewer Tutorial / gltf-viewer · GitLab](https://gitlab.com/gltf-viewer-tutorial/gltf-viewer)
- [GitHub - syoyo/tinygltf: Header only C++11 tiny glTF 2.0 library](https://github.com/syoyo/tinygltf)

## sokol

- [GitHub - ukabuer/ModelViewer: GLTF model viewer](https://github.com/ukabuer/ModelViewer)

## webgl

- [GitHub - KhronosGroup/glTF-Sample-Viewer: Physically-Based Rendering in glTF 2.0 using WebGL](https://github.com/KhronosGroup/glTF-Sample-Viewer)

### three.js

- [GitHub - donmccurdy/three-gltf-viewer: Drag-and-drop preview for glTF 2.0 models in WebGL using three.js.](https://github.com/donmccurdy/three-gltf-viewer)
