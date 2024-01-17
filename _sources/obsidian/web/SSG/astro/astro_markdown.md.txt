# astro.config.mjs markdown 設定

https://docs.astro.build/en/reference/configuration-reference/

```js
export const markdownConfigDefaults: Required<AstroMarkdownOptions> ={
	syntaxHighlight: 'shiki',
	shikiConfig: {
		langs: [],
		theme: 'github-dark',
		experimentalThemes: {},
		wrap: false,
		transformers: [],
	},
	remarkPlugins: [],
	rehypePlugins: [],
	remarkRehype: {},
	gfm: true,
	smartypants: true,
};

export default defineConfig({
  markdown: {
    gfm: true,
    // remarkPlugins: [remarkCodeBlock],
    extendDefaultPlugins: true,
    syntaxHighlight: false,
    rehypePlugins: [[rehypePrettyCode, {}]],
  }
});
```

# remark の呼び出し

`packages\markdown\remark\src\index.ts`

```ts
export async function createMarkdownProcessor
```

```ts packages\astro\src\vite-plugin-markdown\index.ts
export default function markdown({
  settings,
  logger,
}: AstroPluginOptions): Plugin {
  return {
		enforce: 'pre',
		name: 'astro:markdown',

    async buildStart() {
      // これ
      processor = await createMarkdownProcessor(settings.config.markdown);
    },

  };
}
```

call from `packages\astro\src\vite-plugin-astro-server\vite.ts`

