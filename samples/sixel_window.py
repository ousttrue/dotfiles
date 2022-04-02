import asyncio
import io
import sys
from PIL import Image
import prompt_toolkit.layout
import prompt_toolkit
import prompt_toolkit.key_binding
import libsixel


def encode(image: Image):
    width, height = image.size
    data = image.tobytes()
    s = io.BytesIO()
    output = libsixel.sixel_output_new(lambda data, s: s.write(data), s)
    try:
        if image.mode == 'RGBA':
            dither = libsixel.sixel_dither_new(256)
            libsixel.sixel_dither_initialize(
                dither, data, width, height,
                libsixel.SIXEL_PIXELFORMAT_RGBA8888)
        elif image.mode == 'RGB':
            dither = libsixel.sixel_dither_new(256)
            libsixel.sixel_dither_initialize(dither, data, width, height,
                                             libsixel.SIXEL_PIXELFORMAT_RGB888)
        elif image.mode == 'P':
            palette = image.getpalette()
            dither = libsixel.sixel_dither_new(256)
            libsixel.sixel_dither_set_palette(dither, palette)
            libsixel.sixel_dither_set_pixelformat(
                dither, libsixel.SIXEL_PIXELFORMAT_PAL8)
        elif image.mode == 'L':
            dither = libsixel.sixel_dither_get(libsixel.SIXEL_BUILTIN_G8)
            libsixel.sixel_dither_set_pixelformat(
                dither, libsixel.SIXEL_PIXELFORMAT_G8)
        elif image.mode == '1':
            dither = libsixel.sixel_dither_get(libsixel.SIXEL_BUILTIN_G1)
            libsixel.sixel_dither_set_pixelformat(
                dither, libsixel.SIXEL_PIXELFORMAT_G1)
        else:
            raise RuntimeError('unexpected image mode')

        try:
            libsixel.sixel_encode(data, width, height, 1, dither, output)
            return s.getvalue().decode('ascii').split('\n')
        finally:
            libsixel.sixel_dither_unref(dither)
    finally:
        libsixel.sixel_output_unref(output)


class ImageControl(prompt_toolkit.layout.UIControl):

    def __init__(self, image: Image, pixel_par_line=20):
        self.pixel_par_line = pixel_par_line
        self.lines = [line + '\n' for line in encode(image)]

    def create_content(self, width: int,
                       height: int) -> prompt_toolkit.layout.UIContent:
        return prompt_toolkit.layout.UIContent(
            lambda line: self.lines[line - 1], len(self.lines))


async def main(path: str):
    image = Image.open(path)
    content = ImageControl(image)
    root = prompt_toolkit.layout.Window(content)
    kb = prompt_toolkit.key_binding.KeyBindings()
    app = prompt_toolkit.Application(
        full_screen=True,
        layout=prompt_toolkit.layout.Layout(root),
        key_bindings=kb,
    )

    @kb.add('q')
    def _(e: prompt_toolkit.key_binding.KeyPressEvent):
        e.app.exit()

    await app.run_async()


if __name__ == '__main__':
    asyncio.run(main(sys.argv[1]))
