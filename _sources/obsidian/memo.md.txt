## dotfiles

- vim
- git clone

- DotNet 8
- pwsh-7.4
- nvim
- go/ghq, fzf
- hackgen-nerd
- rustup
- zoxide
- golang

- [ ] powershell の分割

## vulkan

`VK_EXT_MESH_SHADER` が面白そう。
こいつを中心に、四角形mesh assetを運用するシステムを作りたい。

- dcc(blenderとか) <=> 四角形メッシュ => `VK_EXT_MESH_SHADER` によるレンダリング  

四角なので subdiv とか cloth を混ぜれる。

`wgpu` に mesh shader が来るのに数年かかるだろうから、
のんびりと。

## python

久しぶりに xonsh にしてみるとか

| 用途          | version | comment              |
| ------------- | ------- | -------------------- |
| xonsh         | 3.12    | 最新版で速い方が良い |
| qtile         | 3.12    | 最新版で速い方が良い |
| bpy           | 3.11    | 固定                 |
| gentoo-system | 3.11    | 固定                 |
| arch-system   | 3.11    | 固定                 |
| ubuntu-system | 3.11    | 固定                 |

match 式が 3.11 から使えるのでよかろう。

## lang

https://github.com/vtereshkov/umka-lang

## raylib + zig

どうか

## lsp

- [[lsp]]

## prefix

[[glib]]
[[font_build]]

## os

## backend

- [[elixir]]

## frontend

| DSL        | Router                  | Bundler       |
| ---------- | ----------------------- | ------------- |
| [[React]]  | [[Next.js]]             | [[Turbopack]] |
| [[React]]  | [[react-router]]        | [[Vite]]      |
| [[React]]  | [[Remix]]               | [[Vite]]      |
| [[React]]  | [[minista]]             | [[Vite]]      |
| [[React]]  | [[Docusaurus]]          | [[webpack]]   |
| [[Vue.js]] | [[unplugin-vue-router]] | [[Vite]]      |
| [[Vue.js]] | [[Nuxt]]                | [[Vite]]      |
| [[Vue.js]] | [[VitePress]]           | [[Vite]]      |
|            | [[vite-plugin-pages]]   | [[Vite]]      |
| [[Svelte]] | [[SvelteKit]]           | [[Vite]]      |
| [[Astro]]  | [[astro]]               | [[Vite]]      |
| [[Astro]]  | [[Starlight]]           | [[Vite]]      |

https://github.com/Daydreamer-riri/vite-react-ssg

https://nextra.site/

## xr

- webxr
- remote desktop
- MR

- https://github.com/takahirox/tiny-web-metaverse

## gui widgets

- tree: select / add / remove
  - context menu
- inspector
  - T: position
  - R: rotation
  - S: scale
- gizmo

### layout

- splitter
- dock

# 不明瞭なfilepath

```sh
cp from to

cp from to
# or
cp from to/(from.name)
```
