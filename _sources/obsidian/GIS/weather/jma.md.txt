[[weather]]
[[nushell]]
[[GIS]]

- @2021 [気象庁JSONデータ - Qiita](https://qiita.com/michan06/items/48503631dd30275288f7)
- [GitHub - 9SQ/jma-amedas2geojson: 気象庁のアメダスCSVデータからGeoJSONを生成する](https://github.com/9SQ/jma-amedas2geojson)
- [気象庁 Japan Meteorological Agency](https://www.data.jma.go.jp/developer/gis.html)
- [気象庁の台風位置表から GeoJSON を作成する - Qiita](https://qiita.com/mg_kudo/items/d490f7b47f44e74e8b8e)

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
