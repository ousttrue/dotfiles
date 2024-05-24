#pragma once
#include <span>
#include <string_view>

namespace posix {
bool launch(std::span<std::string_view> args);
}
