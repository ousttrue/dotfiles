[[weather]]
[[nushell]]
[[GIS]]

- @2021 [気象庁JSONデータ - Qiita](https://qiita.com/michan06/items/48503631dd30275288f7)
- [GitHub - 9SQ/jma-amedas2geojson: 気象庁のアメダスCSVデータからGeoJSONを生成する](https://github.com/9SQ/jma-amedas2geojson)
- [気象庁 Japan Meteorological Agency](https://www.data.jma.go.jp/developer/gis.html)
- [気象庁の台風位置表から GeoJSON を作成する - Qiita](https://qiita.com/mg_kudo/items/d490f7b47f44e74e8b8e)
# go
- [GitHub - pen/jma-go: client for pseudo-api of https://www.jma.go.jp/bosai/forecast/ [気象庁][天気][JSON]](https://github.com/pen/jma-go)
- [気象庁サイトから取得したJSON天気データを使って明日の天気をLINEで送信する機能を作ってみた - Qiita](https://qiita.com/AsuyaKakegawa/items/2e8d27393f2955b32f6f)
- [雨雲レーダーを❝サクッと❞Mapboxにプロットしてみる](https://zenn.dev/come25136/articles/c31740d7e59f40e14e1d)
- [Try Golang! スクレイピング実践. Let’s WEB Scraping with Golang! | by Takuo | VELTRA Engineering | Medium](https://medium.com/veltra-engineering/lets-web-scraping-with-golang-9c1723b732b5)

## forecast
- [GitHub - schachmat/wego: weather app for the terminal](https://github.com/schachmat/wego)

# weathercode
- [GitHub - ciscorn/jma-weather-images: 気象庁のテロップ番号に対応する画像を、基本天気画像の組み合わせによって合成するだけ](https://github.com/ciscorn/jma-weather-images)

# area
## centers
```nu
http get https://www.jma.go.jp/bosai/common/const/area.json | get centers | transpose | each { |e| $e.column1 | insert center $e.column0 }
```

```
key: center
record<name: string, enName: string, officeName: string, children: list<string>>
```

### centers.children => oficces
```
http get https://www.jma.go.jp/bosai/common/const/area.json | get centers | values | get children |                  08/02/2023 01:13:01 AM
::: flatten
```

## offices
```nu
http get https://www.jma.go.jp/bosai/common/const/area.json | get offices | transpose | each { |e| $e.column1 }
```

### select office
```
http get https://www.jma.go.jp/bosai/common/const/area.json | get offices | str join (char nl) | fzf
```
## class10s
http get https://www.jma.go.jp/bosai/common/const/area.json | get class10s | transpose | each { |e| $e.column1 }

## class15s

## class20s

# forecast
[https://www.jma.go.jp/bosai/forecast/data/overview_forecast/130000.json](https://www.jma.go.jp/bosai/forecast/data/overview_forecast/130000.json)
https://www.jma.go.jp/bosai/forecast/data/forecast/130000.json

## weathercode
```nu
http get https://www.jma.go.jp/bosai/forecast/data/forecast/130000.json | get 0.timeSeries.0.areas.0.weatherCodes
```

- [気象庁JSON ファイルにある weatherCode 一覧 │ TEAM T3A](https://www.t3a.jp/blog/web-develop/weather-code-list/)

# amedas
[気象庁のアメダスのデータ](https://okumuralab.org/~okumura/python/amedas.html)
[気象庁10分データJSON取得 - Qiita](https://qiita.com/pirotan628/items/b58c9fbebde4c746845d)

# ２週間予報
- [気象庁｜確率予測資料（2週間気温予報）：北海道地方](https://www.data.jma.go.jp/risk/probability/guidance/csv_k2w.php)
- [気象庁 | 確率予測資料について（地域番号、地点番号の対応表）](https://www.data.jma.go.jp/risk/probability/info/number.html)
