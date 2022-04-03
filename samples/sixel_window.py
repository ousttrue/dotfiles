from typing import List, Tuple, Optional
import re
import asyncio
import io
import sys
from PIL import Image
import prompt_toolkit.layout
import prompt_toolkit
import prompt_toolkit.key_binding
import libsixel
import logging
logger = logging.getLogger(__name__)


def to_sixel(image: Image) -> bytes:
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
            return s.getvalue()
        finally:
            libsixel.sixel_dither_unref(dither)
    finally:
        libsixel.sixel_output_unref(output)


def to_lines(data: str) -> List[List[Tuple[str, str]]]:

    escape_sequence = io.StringIO()

    pos = 0

    def push_escape_sequence(c):
        escape_sequence.write(c)
        return len(c)

    lines = []

    def new_line():
        lines.append([('', ' ')])

    while pos < len(data):
        c = data[pos:]

        use = 0
        if c[0:3] == '\x1bPq':
            # sixel
            use = push_escape_sequence('\x1bPq')
        elif m := re.match(r'^"\d+;\d+;\d+;\d+', c):
            # "1;1;502;285
            logger.debug(m)
            use = push_escape_sequence(m.group(0))
        elif m := re.match(r'^#\d+;\d+;\d+;\d+;\d+', c):
            # #1;2;50;47;50
            logger.debug(m)
            use = push_escape_sequence(m.group(0))
        elif m := re.match(r'^#\d+', c):
            # #0
            # logger.debug(m)
            use = push_escape_sequence(m.group(0))
        elif m := re.match(r'^!\d+', c):
            # !255
            # logger.debug(m)
            use = push_escape_sequence(m.group(0))
        elif m := re.match(r'^[?-~]', c):
            # ? ~ ~
            # logger.debug(m)
            use = push_escape_sequence(m.group(0))
        elif c[0] == '$':
            # newline
            use = push_escape_sequence('$')
        elif c[0] == '-':
            # newline
            use = push_escape_sequence('-')
            new_line()
        elif c == '\x1b\\':
            use = push_escape_sequence('\x1b\\')
            # end
            assert pos + use == len(data)
        else:
            raise NotImplementedError()
        pos += use

    # lines[0].insert(0, ('[ZeroWidthEscape]', escape_sequence.getvalue()))
    # return lines
    result = [[('', ' ')]] * 10 + [[('', 'z'), ('[ZeroWidthEscape]', escape_sequence.getvalue()), ('', 'a')]]
    return result


class ImageControl(prompt_toolkit.layout.UIControl):

    def __init__(self, image: Image, font_size=14):
        data = to_sixel(image)
        self.lines = to_lines(data.decode('ascii'))
        self.font_size = font_size

    def create_content(self, width: int,
                       height: int) -> prompt_toolkit.layout.UIContent:
        def get_line(i):
            return self.lines[i]
        return prompt_toolkit.layout.UIContent(
            get_line,
            len(self.lines)
        )

    def preferred_width(self, max_available_width: int) -> Optional[int]:
        return 5

    def preferred_height(
        self,
        width: int,
        max_available_height: int,
        wrap_lines: bool,
        get_line_prefix,
    ) -> Optional[int]:
        return len(self.lines)


async def main(path: str):
    image = Image.open(path)
    image_window  = prompt_toolkit.layout.Window(ImageControl(image))
    root = prompt_toolkit.layout.FloatContainer(prompt_toolkit.layout.Window(), floats=[
        prompt_toolkit.layout.Float(content=image_window, top=10, left=10)
    ])
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
    # logging.basicConfig(level=logging.DEBUG)
    # asyncio.run(main(sys.argv[1]))

    image = Image.open(sys.argv[1])
    sixel = to_sixel(image).decode('ascii')
    # import pathlib
    # pathlib.Path('tmp2.dat', 'w').write_text(sixel)
    sys.stdout.write(sixel)