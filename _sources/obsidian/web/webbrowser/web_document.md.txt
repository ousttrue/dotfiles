
# event
@2023 [【JS】 DOMContentLoaded と load の違いを新人でもわかるように解説](https://takayamato.com/eventlistener/)

# addEventListener

```js
button.addEventListener("click", () => { console.log("clicked"); });
```

## DOMContentLoaded

```js
document.addEventListener("DOMContentLoaded", (event) => {
  console.log("DOM fully loaded and parsed");
});
```

## loaded
