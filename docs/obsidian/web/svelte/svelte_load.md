> before `+page.sevelte` & `+layout.svelte`

[Loading data • Docs • SvelteKit](https://kit.svelte.dev/docs/load)

# +page.svelte
```html
<script lang="ts"> 
	import type { PageData } from './$types';
	export let data: PageData;
</script>
```

# +page.server.js
## load


# +page.js
## load
>  A `load` function in a `+page.js` file runs both on the server and in the browser

```ts
import type { PageServerLoad } from './$types';

export const load: PageServerLoad = async ({ params }) => {
	return {
		post: await db.getPost(params.slug),
	};
};
```
