# wtf8
- [The WTF-8 encoding](https://simonsapin.github.io/wtf-8/)

```
content => buffer => display => term 

message => term
```

# copy url
- @2005 [w3m から url を X のクリップボードへコピー - (((memo)))](https://emacsjjj.hatenadiary.org/entry/20050625/p1)
```sh
#!/bin/sh
echo "$1" | tr -d '\n' | xclip
```

# CESU-8
サロゲートペア
- Compatibility Encoding Scheme for UTF-16: 8-Bit (CESU-8)

# Load

## file.c
```c:file.c
Buffer *loadGeneralFile(
	char *path, 
	ParsedURL *volatile current, 
	char *referer,
	int flag, 
	FormList *volatile request);

👇

static Buffer *loadSomething(
	URLFile *f,
	Buffer *(*loadproc)(
		URLFile *, 
		Buffer *),
	Buffer *defaultbuf);

👇

// UTF-8 ?
Buffer *loadBuffer(URLFile *uf, Buffer *volatile newBuf) {
	while ((lineBuf2 = StrmyISgets(uf->stream))->length) {
	
		// WC_CES_UTF_8 => INTERNAL
		lineBuf2 = convertLine(uf, lineBuf2, PAGER_MODE, &charset, doc_charset);
	
	}
}

👇

Str convertLine(
	URLFile *uf, 
	Str line, 
	int mode, 
	wc_ces *charset,
	wc_ces doc_charset)
{
	line = wc_Str_conv_with_detect(line, charset, doc_charset, InnerCharset);
}
```

👇
## libwc

```c:conv.c
Str wc_Str_conv_with_detect(
	Str is, 
	wc_ces *f_ces, // from
	wc_ces hint, 
	wc_ces t_ces) // to

Str wc_Str_conv(
	Str is, 
	wc_ces f_ces, // from
	wc_ces t_ces) // to
{
    if (f_ces != WC_CES_WTF)
        is = (*WcCesInfo[WC_CES_INDEX(f_ces)].conv_from)(is, f_ces);
    if (t_ces != WC_CES_WTF)
        return wc_conv_to_ces(is, t_ces);
    else
        return is;
}
```

👇

```c:utf8.c
//  UTF8 to WTF
Str
wc_conv_from_utf8(
	Str is, 
	wc_ces _) // 未使用
{

}

// 戻る
// utf8[]{346, 210, 273, 343, 202, 213}
// wtf8[]{211, 201, 'L', 211, 200, 341, 213}
```

## etc.c
```c
Str checkType(Str s, Lineprop **oprop, Linecolor **ocolor) {

```


HTMLlineproc0

# Display

## display.c
```c
static Line *redrawLine(
	Buffer *buf, 
	Line *l, 
	int i)

👇

void addMChar(
	char *p, // 日本語
	Lineprop mode, 
	size_t len); // 5 ? wtf に依存
```

```c
void message(
	char *s, 
	int return_x, 
	int return_y);
```

## terms.cpp

```c
void addnstr(char *s, int n) {
  int i;
  int len, width;

  for (i = 0; *s != '\0';) {
    width = wtf_width((wc_uchar *)s);
    if (i + width > n)
      break;
    len = wtf_len((wc_uchar *)s); // <- これ
    addmch(s, len);
    s += len;
    i += width;
  }
}
```
## libwc/wtf.cpp

```cpp
size_t wtf_len(wc_uchar *p)
{
    wc_uchar *q = p;
    wc_uchar *strz = p + strlen((const char*)p);

    q += WTF_LEN_MAP[*q];
    while (q < strz && ! WTF_WIDTH_MAP[*q])
	q += WTF_LEN_MAP[*q];
    return q - p;
}
```

## menu.cpp
```c
void new_menu(Menu *menu, MenuItem *item)
{
}
```

## etc.cpp

```c
static int nextColumn(int n, char *p, Lineprop *pr) {
}
```

## libwc/putc.cpp
```c
void
	wc_putc(char *c, FILE *f)
```

# chawan

- https://git.sr.ht/~bptato/chawan
