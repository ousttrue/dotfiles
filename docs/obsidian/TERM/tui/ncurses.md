[GitHub - mirror/ncurses: ncurses Git mirror](https://github.com/mirror/ncurses.git)


ncurses
code:.c
 // scroll 可能領域
 WINDOW* w = newpad(lines, cols);

https://docs.python.org/ja/3/library/curses.html

[* wresize]

[* noutrefresh, doupdate]

[* scrollok, wscrl]

[** type]
[* chtype]
文字と属性のデータを持つ

[** wide]
[* wint_t]
> stores  a  wchar_t  or  WEOF 

[* cchar_t]
文字(複数文字がありえる)と属性のデータを持つ
code:.c
 typedef struct
 {
     attr_t	attr;
     wchar_t	chars[CCHARW_MAX];
 #if 1
 #undef NCURSES_EXT_COLORS
 #define NCURSES_EXT_COLORS 20200212
     int		ext_color;	/* color pair, must be more than 16-bits */
 #endif
 }
 cchar_t;

