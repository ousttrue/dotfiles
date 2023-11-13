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
// @name         New Userscript
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

    console.log("HELLO");

    const spamList = [
        "https://ubunlog.com/",
    ];
    function isSpam(href)
    {
        for(const x of spamList)
        {
            if(href.includes(x)){
                return true;
            }
        }
    }

    function traverse(e, callback)
    {
        callback(e);
        for(const child of e.children)
        {
            traverse(child, callback);
        }
    }

    document.querySelector("#rhs").style.display = "none";

    // Your code here...
    for(const e of document.querySelectorAll("#rso > div"))
    {
        const a = e.querySelector("div > div > div > div > div > span > a");
        if(a && isSpam(a.href)){
            // e.style.border = "#FFFFFF solid 1px";
            traverse(e, (x)=>{
                x.style.color = "#444444";
            });
        }
    }

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
