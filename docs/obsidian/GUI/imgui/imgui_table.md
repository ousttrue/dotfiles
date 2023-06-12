[[imgui]]

# header

```c++
if (ImGui::BeginTable("table1", 3, flags))
{
	ImGui::TableSetupColumn("One");
	ImGui::TableSetupColumn("Two");
	ImGui::TableSetupColumn("Three");
	ImGui::TableHeadersRow();
	ImGui::EndTable();
}
```
