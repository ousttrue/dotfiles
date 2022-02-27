imgui nodegraph
#imgui

[Node Graph Editors with ImGui https://github.com/ocornut/imgui/issues/306]

[** basic]
https://gist.github.com/ocornut/7e9b3ec566a333d725d4
	見た目のデモ。コード読むべし
[https://gyazo.com/f0294fe260a4857dc5d09e542980d201]

https://github.com/Flix01/imgui/tree/imgui_with_addons
	他の機能とセットになっていて、ビルドがようわからん
[https://cloud.githubusercontent.com/assets/9608982/10732598/1dc21962-7bfb-11e5-99ef-5ffb03a0c42f.png]

https://github.com/Nelarius/imnodes



[** ImNodes]
https://github.com/rokups/ImNodes
[https://user-images.githubusercontent.com/19151258/59259827-23a19400-8c43-11e9-9fdb-a3e4465a98e5.png]

[* canvas]
	ImNodes::BeginCanvas
	ImNodes::EndCanvas
	wheel を スクロールからズームに変えたい

[* EzNode]
	ImNodes::Ez::BeginNode
	ImNodes::Ez::EndNode
	マウスでノードを削除する方法

[* connection]
	ImNodes::Connection
	マウスで接続を解除する方法
		接続が成立している、outもしくはinからドラッグを開始すると既存の接続を解除

[** imnodes]
https://github.com/Nelarius/imnodes

[** imgui-node-editor]
https://github.com/thedmd/imgui-node-editor
	imgui本体にパッチを当てる必要あり
[https://github.com/thedmd/imgui-node-editor/raw/master/Screenshots/node_editor_overview.gif]
