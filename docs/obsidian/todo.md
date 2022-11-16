#blue

[[zig]] + [[OpenGL]] + [[wasm]]
[[python]] + [[flask]] + [[Leaflet]]
[[OpenXR]]

# PySpout
- TimerRecorder

# PyGtk4
- cairo
- pygobject(-Dtests=false)
- gtk(-Dmedisa-gstreamer=disabled, -Dbuild-tests=false)
- gstreamer

# GTK install order
- gobject-introspection (-Dbuild_introspection_data=false)
-- gir & typelib を使う環境ができる
- gobject-introspection (LIB=c:/gnome/lib)
- gtk(-Dmedisa-gstreamer=disabled, -Dbuild-tests=false)
	fix fontconfig symlink
- pygobject(-Dtests=false)

- gstreamer(with gir)

# Stream
- Unity
- [[spout]]
- [[gst-python]] 

# QuestPro

## avatar tracker
- body tracking
- hand tracking
- eye tracking
- facial tracking
- osc sender
- local mirror renderer

## avatracker receiver
- osc renceiver
- renderer
- [[spout]]

## MRWorkSpace
- pass through
- spacial anchor

# SceneServer
- SpacialAnchor
- Scene

# [[neovim|nvim]]
## [[vim_plugins]]
- [ ] project 単位の設定

# [[lsp]]
## [[nvim]]
- [ ] [[nvim]] lsp: symbol debug. range
- [ ] winbar debug

## [[zig]]
- [ ] type を返す関数
- [ ] ponter型の payload
- [ ] index type
- [ ] OpenGL parse code 生成

# w3m
- [ ] push 時のキャッシュ挙動

# [[tui]]
- [GitHub - afify/sfm: simple file manager](https://github.com/afify/sfm)
- yazls のデバッグツール作りたい