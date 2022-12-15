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
