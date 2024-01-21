## Reticulum(main server)

```title=".tool-versions"
elixir 1.14.3-otp-23
erlang 23.3.4.18
```

`Erlang (v23.3) + Elixir (v1.14) + Phoenix`

[[elixir]]

`postgresql` https://github.com/mozilla/Reticulum

```sh
# sudo apt-get install postgresql
# sudo apt-get install elixir

asdf install elixir 1.14.5-otp-23
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


