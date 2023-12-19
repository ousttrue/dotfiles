[[GIS]] [[zxytile]] [[MapLibre]]

`Mapbox Vector Tiles format`

- ベクトルタイルの生成 => [[tilemaker]]
- セルフホスティングとStyleの記述 [[map_style]]

- @2021 [ベクトルタイルのカレンダー | Advent Calendar 2021 - Qiita](https://qiita.com/advent-calendar/2021/vt)

- [GitHub - mapbox/awesome-vector-tiles: awesome implementations of the Mapbox Vector Tile specification](https://github.com/mapbox/awesome-vector-tiles)
- [地理院地図｜ベクトルタイルとその提供実験について](https://maps.gsi.go.jp/development/vt.html)

# format
`//host/path/{zoom}/{x}/{y}.pbf`

- @2023 [MapboxのVectorDataを利用する](https://zenn.dev/mapbox_japan/articles/02201124476d84)
- @2021 [Create, style and render self-hosted vector maps 🗺](https://blog.tmlmt.com/create-style-and-render-self-hosted-vector-maps/)
- @2020 [Mapbox Vector Tiles のデータ構造 #mapbox - Qiita](https://qiita.com/yuskesuzki@github/items/9ba9c65160e525b08d0e)
- @2017 [バイナリベクトルタイルの拡張子が mvt であったり pbf であったりするのはなんでだろう #geo - Qiita](https://qiita.com/hfu/items/69fbe24be92654f634da)
- @2017 [gh-pagesで OSM 日本ベクトルタイル提供 #geo - Qiita](https://qiita.com/hfu/items/e7c0318bba67827d4327)

## mvt
`mapbox vector tile`

## pbf
`protocol buffer`

- @2021 [クリーンなJavaScriptのESモジュールで地図ライブラリを再構築するプロジェクト「mapthree-es」](https://fukuno.jig.jp/3207)
- @2018 [バイナリベクトルタイルを地図ライブラリ以外で扱う #JavaScript - Qiita](https://qiita.com/cieloazul310/items/32d692a95b87b113bf35)
- [GitHub - mapbox/vector-tile-js: Parses vector tiles with JavaScript](https://github.com/mapbox/vector-tile-js)
- @2016 [[OSM] .osm.pbfファイルを読み込んでみる１](https://code-house.jp/2016/10/18/osmpbf1/)

## geojson
[[geojson]] を `pbf` に変換する場合がある

# Csharp
- @2023 [ベクトルタイルを作成する方法](https://zenn.dev/yumori/articles/93289d07e8551c)

# Renderer
[[MapLibre]]
[[OpenLayers]]
[[Leaflet]]

# golang
- [GitHub - murphy214/vector-tile-go: Reads / Writes vector-tiles in go. With faster reads / writes than normal protobuf implementations.](https://github.com/murphy214/vector-tile-go)
- [GitHub - vicapow/go-vtile-example: An example go server for serving vector tiles](https://github.com/vicapow/go-vtile-example)
- [GitHub - whosonfirst/go-rasterzen: Tools for rendering raster tiles derived from Nextzen (Mapzen) Vector tiles.](https://github.com/whosonfirst/go-rasterzen)


