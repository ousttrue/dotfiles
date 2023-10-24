- [node.js - node-gyp configure got "gyp ERR! find VS" - Stack Overflow](https://stackoverflow.com/questions/57541402/node-gyp-configure-got-gyp-err-find-vs)

```
npm ERR! gyp ERR! node -v v18.15.0
npm ERR! gyp ERR! node-gyp -v v7.1.2
```

- [node.js - How can I solve error gypgyp ERR!ERR! find VSfind VS msvs\_version not set from command line or npm config? - Stack Overflow](https://stackoverflow.com/questions/57879150/how-can-i-solve-error-gypgyp-errerr-find-vsfind-vs-msvs-version-not-set-from-c)
👇
```
> npm config delete msvs_version
> npm config delete msvs_version --global
> npm config delete msbuild_path
> npm config delete msbuild_path --global
```
