
- [GitHub - mozilla/hubs: Duck-themed multi-user virtual spaces in WebVR. Built with A-Frame.](https://github.com/mozilla/hubs)

[[janus]]

## articles

### local

- @2023 [Mozilla Hubsをセルフホストする #kubernetes - Qiita](https://qiita.com/dodolia907/items/c350f9a69deca6e3b831)

- @2022 [Mozilla Hubs Cloudをローカル（M1搭載Macbook）で実行してみた](https://zenn.dev/yh_haoareyou/articles/mozilla-hubs-run-locally-mac-m1)

- @2022 [続 Mozilla Hubs – VirtualBox でホストした自作シーンに入ってみた ｜株式会社インフィニットループ技術ブログ](https://www.infiniteloop.co.jp/blog/2022/03/mozilla-hubs-virtualbox-createscene/)

## CommunityEdition

https://github.com/mozilla/hubs-cloud/tree/master/community-edition

- @2023 https://hubs.mozilla.com/labs/welcoming-community-edition/

## Reticulum(main server)

`Erlang (v23.3) + Elixir (v1.14) + Phoenix`

[[elixir]]

`postgresql` https://github.com/mozilla/Reticulum

```sh
sudo apt-get install postgresql
sudo apt-get install elixir

```

### ecto

- @2022 [Elixir Ecto のまとめ #PostgreSQL - Qiita](https://qiita.com/sand/items/71d0b35d74a4781f3564)

`mix.exs`

`_build`, `deps`

```sh
mix deps.get
mix ecto.create
could not compile dependency :ecto, "mix compile" failed. Errors may have been logged above. You can recompile this dependency with "mix deps.compile ecto", update it with "mix deps.update ecto" or clean it with "mix deps.clean ecto"
```

https://elixirforum.com/t/compilation-error-caused-by-ecto-after-upgrading-to-otp-26/57848

- @2021 [Reticulumをローカルで動かしてデプロイする #chef - Qiita](https://qiita.com/hironori_nakae/items/b409fb9b0ff4ceb6eb9d)
- @2020 [Mozilla HubsのバックエンドサーバーReticulumを改造する方法](https://zenn.dev/kou029w/articles/hubs-custom-reticulum)

## Hubs(front)

## Dialog(webRTC?)

