[[OpenStreetMap]] [[NaturalEarth]]
[[charites]]
[[maputnik]]

- @2023 [MapLibre GL JSのスタイルファイルを読む ##Map - Qiita](https://qiita.com/moritoru/items/e160f14e822ada67461c)
- @2022 [ベクトルタイル用スタイルの書き方メモ（Mapbox, Maplibre, ArcGIS API for Javascript） #MapLibre - Qiita](https://qiita.com/T-ubu/items/02a9725dd6329d35d477)
	- @2022 [ベクトルタイル用スタイル・Expressionsについて（MapBoxスタイル仕様、MapLibreスタイル仕様） #mapbox - Qiita](https://qiita.com/T-ubu/items/961176fb92fb66a927e0)

- MapLibre
- ArcGIS API for Javascript

# tile schema
## source layer
tilemaker `metadata.json`
```json
{
  "bounds": [122.5607, 20.08228000000001, 154.4709, 45.815403],
  "name": "Tilemaker example",
  "version": "0.1",
  "description": "Sample vector tiles for Tilemaker",
  "minzoom": 12,
  "maxzoom": 14,
  "vector_layers": [
    {
      "id": "waterway", // 👈 source-layer: 川
      "fields": { "class": "String" },
      "minzoom": 11,
      "maxzoom": 14
    },
    {
      "id": "transportation", // 👈 source-layer: 道
      "fields": { "class": "String" },
      "minzoom": 12,
      "maxzoom": 14
    },
    { "id": "building", "fields": {}, "minzoom": 14, "maxzoom": 14 },
    {
      "id": "poi",
      "fields": { "class": "String", "name": "String" },
      "minzoom": 13,
      "maxzoom": 14
    }
  ]
}
```

# style.json
https://openmaptiles.org/schema/

- @2022 [全世界のベクトルタイルOpenMapTilesを使って地図のスタイリングをする #OpenStreetMap - Qiita](https://qiita.com/moritoru/items/434783e50345a35d9d45)

## Layers
描画順
- background
- water
- landcover
- landuse

# Mapbox GL style
[Open-source map styles – OpenMapTiles](https://openmaptiles.org/styles/)


# glyphs
[[font_pbf]]

