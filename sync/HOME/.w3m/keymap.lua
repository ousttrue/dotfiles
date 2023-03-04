-- vim:set ft=lua
w3m.keymap("q", "CLOSE_TAB")
w3m.keymap("Q", "QUIT")
w3m.keymap("?", "HELP")
w3m.keymap(":", "COMMAND")
w3m.keymap("[", "PREV_TAB")
w3m.keymap("]", "NEXT_TAB")
w3m.keymap("M", "TAB_LINK")
w3m.keymap("T", "TAB_GOTO", "~/dotfiles/home.html")
w3m.keymap("0", "LINE_BEGIN")

w3m.keymap("B", "PREV")
w3m.keymap("F", "NEXT")
w3m.keymap("b", "PREV_WORD")
w3m.keymap("i", "PREV_PAGE")
w3m.keymap("SPC", "NEXT_PAGE")
w3m.keymap(">", "UP")
w3m.keymap("<", "DOWN")
w3m.keymap(",", "CURSOR_TOP")
w3m.keymap(".", "CURSOR_BOTTOM")

w3m.keymap("j", "MOVE_DOWN1")
w3m.keymap("k", "MOVE_UP1")
w3m.keymap("H", "NEXT_LEFT")
w3m.keymap("J", "NEXT_DOWN")
w3m.keymap("K", "NEXT_UP")
w3m.keymap("L", "NEXT_RIGHT")

w3m.keymap("x", "EXTERN")
w3m.keymap(";", "MARK_URL")

-- custom
w3m.keymap("u", "CURSORLINE_TOP")

w3m.keymap("x", function()
  print "HELLO!"
end)
