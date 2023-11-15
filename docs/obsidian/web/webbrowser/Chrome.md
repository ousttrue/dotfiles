[[firefox]]
# UserScript
`.user.js`
- [User Scripts](https://www.chromium.org/developers/design-documents/user-scripts/)

- @2021 [UserScript #JavaScript - Qiita](https://qiita.com/aoirint/items/3467427c28fe71d3cd57)
- @2018 [UserScriptで業務改善](https://kenchan0130.github.io/post/2018-05-21-1)

# Tampermonkey
[ホーム | Tampermonkey](https://www.tampermonkey.net/)

- @2019 [Google検索結果から不要な結果を削除するTampermonkey ユーザースクリプト - Because We Love Happy Coding](https://code.74th.net/entry/2019/12/07/222755)

# for google search
```js
// ==UserScript==
// @name         Google Search
// @namespace    http://tampermonkey.net/
// @version      0.1
// @description  try to take over the world!
// @author       You
// @match        https://www.google.com/search?*
// @icon         https://www.google.com/s2/favicons?sz=64&domain=google.com
// @grant        none
// ==/UserScript==

(function() {
    'use strict';

    // Your code here...
    const spamList = [
        "https://ubunlog.com/",
    ];

    const used = new Set();

    function isSpam(a)
    {
        if(!a){
            return;
        }

        const href=a.href;
        if(!href){
            return;
        }

        if(used.has(href)){
            return;
        }

        used.add(href);

        if(href.startsWith("/url?")){
            console.info('[drop]', href);
            return "#ffcccc";
        }

        for(const x of spamList)
        {
            if(href.includes(x)){
                console.info('[drop]', href);
                return "#cccccc";
            }
        }

        console.log(href);
    }

    function traverse(e, callback)
    {
        callback(e);
        for(const child of e.children)
        {
            traverse(child, callback);
        }
    }

    //document.querySelector("#rhs").style.display = "none";


    function process(){
        console.log('process');
        for(const e of document.querySelectorAll("div.hlcw0c,div.MjjYud"))
        {
            const a = e.querySelector("div > div > div > div > div > span > a");
            const color = isSpam(a);
            if(color){
                // e.style.border = "#FFFFFF solid 1px";
                traverse(e, (x)=>{
                    x.style.color = color;
                });
            }
        }
    }

    const callback = (mutationsList, observer) => {
        process();
    };
    const observer = new MutationObserver(callback);
    observer.observe(document.body, {
        childList: true,
        subtree: true
    });

    process();
})();
```

```js
    function removeS()
    {
        requestAnimationFrame(removeS);
        for(const s of document.querySelectorAll("script"))
        {
            console.log('remove', s);
            s.remove();
        }
        for(const s of document.querySelectorAll("iframe"))
        {
            console.log('remove', s);
            s.remove();
        }
    }
    removeS();
```
