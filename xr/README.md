# tutorial

https://beprosto.me/webxr-tutorial/tutorial1

## require https

- https://qiita.com/hbjpn/items/925c8012cd93d9165be6

`192.168.137.1` wifi の mobile spot の固定アドレス

```sh
> mkcert -install
> mkdir cert
> cd cert
> mkcert localhost 127.0.0.1 192.168.137.1
> ls
localhost+2-key.pem localhost+2.pem
```

```sh
> npm install -g http-server
> http-server -c-1 . --ssl --key cert/localhost+2-key.pem --cert cert/localhost+2.pem --port 8000
```

