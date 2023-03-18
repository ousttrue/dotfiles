[MoviePyを使ってPythonで動画編集をする - Qiita](https://qiita.com/hosokawaR/items/ae349122be575b5e546c)

# webm
```python
import moviepy.editor
import pathlib
import sys


def main(src: pathlib.Path):
    clip = moviepy.editor.VideoFileClip(str(src))
    clip.write_videofile(src.stem + ".webm")


if __name__ == "__main__":
    main(pathlib.Path(sys.argv[1]))
```
