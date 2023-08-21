#pragma once
#include <ftxui/component/component.hpp>
#include <vterm.h>

struct VtContent;
struct VtRenderer {
  std::shared_ptr<VtContent> m_vt;
  std::string m_cmd;
  int m_rows = 0;
  int m_cols = 0;
  std::function<void()> m_onDamaged;
  std::function<void()> m_onExit;
  int m_count = 0;

  void RequireRowsCols(int rows, int cols);

  void OnDamage();

  void OnExit();

  std::string Status() const;

  void Flush();

  void RenderPixel(const VTermPos &pos, ftxui::Pixel *pixel);

  std::string m_childInput;
  void WriteChild(const std::string &str);
};

struct VtNode : ftxui::Node {
  std::shared_ptr<VtRenderer> m_renderer;

  VtNode(const ftxui::Dimensions &dim) {
    requirement_.min_x = dim.dimx;
    requirement_.min_y = dim.dimy;
    requirement_.flex_grow_x = 1;
    requirement_.flex_grow_y = 1;
    requirement_.flex_shrink_x = 0;
    requirement_.flex_shrink_y = 0;
  }

  int Width() const { return box_.x_max - box_.x_min + 1; }
  int Height() const { return box_.y_max - box_.y_min + 1; }

  void SetBox(ftxui::Box box) override;

  void Render(ftxui::Screen &screen) override;
};

struct VtComponent : ftxui::ComponentBase {
  std::shared_ptr<VtNode> m_node;
  std::list<ftxui::Event> m_events;

  bool Focusable() const override { return true; }

  VtComponent(const std::shared_ptr<VtNode> &node) : m_node(node) {}

  ftxui::Element Render() override;

  bool OnEvent(ftxui::Event event) override;
};
