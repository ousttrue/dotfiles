# busybox

# debian
```Dockerfile
FROM debian:buster-slim
```

# distroless
[[Debian]] 10(buster) base => `glibc-2.28`

[GitHub - GoogleContainerTools/distroless: 🥑 Language focused docker images, minus the operating system.](https://github.com/GoogleContainerTools/distroless)

> distrolessコンテナにはshやbashなどのshellは含まれていない

- @2022 [コンテナイメージ使うならdistrolessもいいよねという話](https://zenn.dev/yoshii0110/articles/21ddb58c6f6bfa)
- @2022 [Distrolessで遊ぶ - とことんDevOps | 日本仮想化技術のDevOps技術情報メディア](https://devops-blog.virtualtech.jp/entry/20220713/1657683666)
- @2021 [セキュアで軽量なdistrolessコンテナを作成する - Qiita](https://qiita.com/t_katsumura/items/462e2ae6321a9b5e473e)
