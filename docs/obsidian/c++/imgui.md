imgui
#gizmo
[[nodeeditor]]

	https://github.com/ocornut/imgui
		https://github.com/ocornut/imgui/releases

https://github.com/mahilab/mahi-gui


[* 入力ハンドリング]
	ImGui が消費する
		ImGui の Widgets が消費する
		ImGui の RenderTarget に転送する
	ImGui が消費しない

[* 1.81]

[* 1.80]
table API

[* 1.72]

[* 1.71] 20190613
	docking https://github.com/ocornut/imgui/issues/2109

code:.cpp
 // window
 if(ImGui::Begin()){
 }
 ImGui::End(); // begin が true でも end でも呼ばねばならぬ // Window だけ？
 
 // widgets
 if(ImGui::TreeNode()){
   ImGui::EndNode(); // true の時だけ呼ばねばならぬ
 }

[* articles]
https://blog.conan.io/2019/06/26/An-introduction-to-the-Dear-ImGui-library.html

	https://eliasdaler.github.io/using-imgui-with-sfml-pt2/
	[OpenGLやDirectXなGUIにimguiが最強すぎる https://qiita.com/Ushio/items/446d78c881334919e156]
	[最強すぎるGUIことImGuiの見た目もイイ感じにする https://qiita.com/izumin5210/items/26eaed69eea2c4318fcd]
	http://hikita12312.hatenablog.com/entry/2018/03/17/100535

	[WindowsでOpenGLES --- imgui導入 http://any-programming.hatenablog.com/entry/2017/04/26/112929]

	https://gamedev.stackexchange.com/questions/140693/how-can-i-render-an-opengl-scene-into-an-imgui-window

[** widgets]
[* logger]
https://github.com/ocornut/imgui/issues/300

https://github.com/CedricGuillemet/ImGuizmo

https://github.com/thennequin/ImWindow
