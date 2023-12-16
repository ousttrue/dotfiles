[[VectorTile]] [[OpenStreetMap]]

[tilemaker | DIY vector tiles from OpenStreetMap data](https://tilemaker.org/)
- [GitHub - systemed/tilemaker: Make OpenStreetMap vector tiles without the stack](https://github.com/systemed/tilemaker)
- @2023 [Generating self-hosted maps using tilemaker | Wouter van Kleunen](https://blog.kleunen.nl/blog/tilemaker-generate-map)

- @2022 [tilemakerでOpenStreetMapのデータからベクトルタイルを作成する · 可視化技研株式会社](https://kasika.xyz/articles/generate-vector-tiles-from-openstreetmap-data-with-tilemaker/)
- @2021 [tilemakerを使って爆速でOSMベクタータイルを作る #OpenStreetMap - Qiita](https://qiita.com/Kanahiro/items/6a98ee285d3de7ac61fc)
# build済み
ビルド済み tilemaker をダウンロードすると
```
+ build
	+ tilemaker # 実行ファイル 
+ resource # 設定ファイル config と process ２セット
    + config-example.json, process-example.lua
	+ config-openmaptiles.json, process-openmaptiles.lua
```

が入っている。

## example で実行
example の方はすぐに終わるので、こちらで動作確認するとよい

```
tilemaker 
  --input japan-latest.osm.pbf 
  --output out_dir
  --config config-example.json
  --process process-example.lua
```

`config.json`
```json
{
	"layers": {
		"waterway": { "minzoom": 11, "maxzoom": 14 },
		"transportation": { "minzoom": 12, "maxzoom": 14, "simplify_below": 13, "simplify_level": 0.0001, "simplify_ratio": 2.0 },
		"building": { "minzoom": 14, "maxzoom": 14 },
		"poi": { "minzoom": 13, "maxzoom": 14 }
	},
	"settings": {
		"minzoom": 12,
		"maxzoom": 14,
		"basezoom": 14,
		"include_ids": false,
		"name": "Tilemaker example",
		"version": "0.1",
		"description": "Sample vector tiles for Tilemaker",
		"compress": "gzip", # 👈
		"metadata": {
			"json": { "vector_layers": [
						{ "id": "transportation",     "description": "transportation",     "fields": {"class":"String"}},
						{ "id": "waterway",     "description": "waterway",     "fields": {"class":"String"}},
						{ "id": "building", "description": "building", "fields": {}}
					] }
		}
	}
}
```

process.lua
```lua
-- Nodes will only be processed if one of these keys is present

node_keys = { "amenity", "shop" }

-- Initialize Lua logic

function init_function()
end

-- Finalize Lua logic()
function exit_function()
end

-- Assign nodes to a layer, and set attributes, based on OSM tags

function node_function(node)
	local amenity = node:Find("amenity")
	local shop = node:Find("shop")
	if amenity~="" or shop~="" then
		node:Layer("poi", false)
		if amenity~="" then node:Attribute("class",amenity)
		else node:Attribute("class",shop) end
		node:Attribute("name", node:Find("name"))
	end
end

-- Similarly for ways

function way_function(way)
	local highway = way:Find("highway")
	local waterway = way:Find("waterway")
	local building = way:Find("building")
	if highway~="" then
		way:Layer("transportation", false)
		way:Attribute("class", highway)
--		way:Attribute("id",way:Id())
--		way:AttributeNumeric("area",37)
	end
	if waterway~="" then
		way:Layer("waterway", false)
		way:Attribute("class", waterway)
	end
	if building~="" then
		way:Layer("building", true)
	end
end
```

実行した結果
```
+ output
	+ metadata.json
	+ 12 => 127 MB
		+ 3446
			+ 1760.pbf  
			+ 1761.pbf  
	+ 13 => 245 MB
	+ 14 => 555 MB
```

## metadata.json

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
      "id": "waterway",
      "fields": { "class": "String" },
      "minzoom": 11,
      "maxzoom": 14
    },
    {
      "id": "transportation",
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

## style.json の作成
server の hosting 情報と、pbf ファイルの内容に関する情報

`style.json`
```json
{
  "version": 8,
  "name": "Basic",
  "sources": {
    "openmaptiles": {
      "type": "vector",
      "url": "http://localhost:5173/japan/metadata.json",
      "tiles": ["http://localhost:5173/japan/{z}/{x}/{y}.pbf.gz"]
    }
  },
  "layers": [
    {
      "id": "background",
      "type": "background",
      "paint": { "background-color": "hsl(47, 26%, 88%)" }
    },
    {
      "id": "tunnel_railway_transit",
      "type": "line",
      "source": "openmaptiles",
      "source-layer": "transportation",
      "minzoom": 0,
      "filter": [
        "all",
        ["==", "$type", "LineString"],
        ["==", "brunnel", "tunnel"],
        ["==", "class", "transit"]
      ],
      "layout": { "line-cap": "butt", "line-join": "miter" },
      "paint": {
        "line-color": "hsl(34, 12%, 66%)",
        "line-dasharray": [3, 3],
        "line-opacity": {
          "base": 1,
          "stops": [
            [11, 0],
            [16, 1]
          ]
        }
      }
    },
    {
      "id": "building",
      "type": "fill",
      "source": "openmaptiles",
      "source-layer": "building",
      "paint": {
        "fill-antialias": true,
        "fill-color": "rgba(222, 211, 190, 1)",
        "fill-opacity": {
          "base": 1,
          "stops": [
            [13, 0],
            [15, 1]
          ]
        },
        "fill-outline-color": {
          "stops": [
            [15, "rgba(212, 177, 146, 0)"],
            [16, "rgba(212, 177, 146, 0.5)"]
          ]
        }
      }
    },
    {
      "id": "waterway",
      "type": "line",
      "source": "openmaptiles",
      "source-layer": "waterway",
      "filter": ["==", "$type", "LineString"],
      "paint": {
        "line-color": "hsl(205, 56%, 73%)",
        "line-width": {
          "base": 1.4,
          "stops": [
            [8, 1],
            [20, 8]
          ]
        },
        "line-opacity": 1
      }
    },
    {
      "id": "road_area_pier",
      "type": "fill",
      "metadata": {},
      "source": "openmaptiles",
      "source-layer": "transportation",
      "filter": ["all", ["==", "$type", "Polygon"], ["==", "class", "pier"]],
      "layout": { "visibility": "visible" },
      "paint": { "fill-antialias": true, "fill-color": "hsl(47, 26%, 88%)" }
    },
    {
      "id": "road_pier",
      "type": "line",
      "metadata": {},
      "source": "openmaptiles",
      "source-layer": "transportation",
      "filter": ["all", ["==", "$type", "LineString"], ["in", "class", "pier"]],
      "layout": { "line-cap": "round", "line-join": "round" },
      "paint": {
        "line-color": "hsl(47, 26%, 88%)",
        "line-width": {
          "base": 1.2,
          "stops": [
            [15, 1],
            [17, 4]
          ]
        }
      }
    },
    {
      "id": "road_bridge_area",
      "type": "fill",
      "source": "openmaptiles",
      "source-layer": "transportation",
      "filter": [
        "all",
        ["==", "$type", "Polygon"],
        ["in", "brunnel", "bridge"]
      ],
      "layout": {},
      "paint": { "fill-color": "hsl(47, 26%, 88%)", "fill-opacity": 0.5 }
    },
    {
      "id": "road_path",
      "type": "line",
      "source": "openmaptiles",
      "source-layer": "transportation",
      "filter": [
        "all",
        ["==", "$type", "LineString"],
        ["in", "class", "path", "track"]
      ],
      "layout": { "line-cap": "square", "line-join": "bevel" },
      "paint": {
        "line-color": "hsl(0, 0%, 97%)",
        "line-dasharray": [1, 1],
        "line-width": {
          "base": 1.55,
          "stops": [
            [4, 0.25],
            [20, 10]
          ]
        }
      }
    },
    {
      "id": "road_minor",
      "type": "line",
      "source": "openmaptiles",
      "source-layer": "transportation",
      "minzoom": 13,
      "filter": [
        "all",
        ["==", "$type", "LineString"],
        ["in", "class", "minor", "service"]
      ],
      "layout": { "line-cap": "round", "line-join": "round" },
      "paint": {
        "line-color": "hsl(0, 0%, 97%)",
        "line-width": {
          "base": 1.55,
          "stops": [
            [4, 0.25],
            [20, 30]
          ]
        }
      }
    },
    {
      "id": "tunnel_minor",
      "type": "line",
      "source": "openmaptiles",
      "source-layer": "transportation",
      "filter": [
        "all",
        ["==", "$type", "LineString"],
        ["==", "brunnel", "tunnel"],
        ["==", "class", "minor_road"]
      ],
      "layout": { "line-cap": "butt", "line-join": "miter" },
      "paint": {
        "line-color": "#efefef",
        "line-dasharray": [0.36, 0.18],
        "line-width": {
          "base": 1.55,
          "stops": [
            [4, 0.25],
            [20, 30]
          ]
        }
      }
    },
    {
      "id": "tunnel_major",
      "type": "line",
      "source": "openmaptiles",
      "source-layer": "transportation",
      "filter": [
        "all",
        ["==", "$type", "LineString"],
        ["==", "brunnel", "tunnel"],
        ["in", "class", "primary", "secondary", "tertiary", "trunk"]
      ],
      "layout": { "line-cap": "butt", "line-join": "miter" },
      "paint": {
        "line-color": "#fff",
        "line-dasharray": [0.28, 0.14],
        "line-width": {
          "base": 1.4,
          "stops": [
            [6, 0.5],
            [20, 30]
          ]
        }
      }
    },
    {
      "id": "road_trunk_primary",
      "type": "line",
      "source": "openmaptiles",
      "source-layer": "transportation",
      "filter": [
        "all",
        ["==", "$type", "LineString"],
        ["in", "class", "trunk", "primary"]
      ],
      "layout": { "line-cap": "round", "line-join": "round" },
      "paint": {
        "line-color": "#fff",
        "line-width": {
          "base": 1.4,
          "stops": [
            [6, 0.5],
            [20, 30]
          ]
        }
      }
    },
    {
      "id": "road_secondary_tertiary",
      "type": "line",
      "source": "openmaptiles",
      "source-layer": "transportation",
      "filter": [
        "all",
        ["==", "$type", "LineString"],
        ["in", "class", "secondary", "tertiary"]
      ],
      "layout": { "line-cap": "round", "line-join": "round" },
      "paint": {
        "line-color": "#fff",
        "line-width": {
          "base": 1.4,
          "stops": [
            [6, 0.5],
            [20, 20]
          ]
        }
      }
    },
    {
      "id": "road_major_motorway",
      "type": "line",
      "source": "openmaptiles",
      "source-layer": "transportation",
      "filter": [
        "all",
        ["==", "$type", "LineString"],
        ["==", "class", "motorway"]
      ],
      "layout": { "line-cap": "round", "line-join": "round" },
      "paint": {
        "line-color": "hsl(0, 0%, 100%)",
        "line-offset": 0,
        "line-width": {
          "base": 1.4,
          "stops": [
            [8, 1],
            [16, 10]
          ]
        }
      }
    },
    {
      "id": "railway-transit",
      "type": "line",
      "source": "openmaptiles",
      "source-layer": "transportation",
      "filter": [
        "all",
        ["==", "class", "transit"],
        ["!=", "brunnel", "tunnel"]
      ],
      "layout": { "visibility": "visible" },
      "paint": {
        "line-color": "hsl(34, 12%, 66%)",
        "line-opacity": {
          "base": 1,
          "stops": [
            [11, 0],
            [16, 1]
          ]
        }
      }
    },
    {
      "id": "railway",
      "type": "line",
      "source": "openmaptiles",
      "source-layer": "transportation",
      "filter": ["==", "class", "rail"],
      "layout": { "visibility": "visible" },
      "paint": {
        "line-color": "hsl(34, 12%, 66%)",
        "line-opacity": {
          "base": 1,
          "stops": [
            [11, 0],
            [16, 1]
          ]
        }
      }
    },
    {
      "id": "bridge_minor case",
      "type": "line",
      "source": "openmaptiles",
      "source-layer": "transportation",
      "filter": [
        "all",
        ["==", "$type", "LineString"],
        ["==", "brunnel", "bridge"],
        ["==", "class", "minor_road"]
      ],
      "layout": { "line-cap": "butt", "line-join": "miter" },
      "paint": {
        "line-color": "#dedede",
        "line-gap-width": {
          "base": 1.55,
          "stops": [
            [4, 0.25],
            [20, 30]
          ]
        },
        "line-width": {
          "base": 1.6,
          "stops": [
            [12, 0.5],
            [20, 10]
          ]
        }
      }
    },
    {
      "id": "bridge_major case",
      "type": "line",
      "source": "openmaptiles",
      "source-layer": "transportation",
      "filter": [
        "all",
        ["==", "$type", "LineString"],
        ["==", "brunnel", "bridge"],
        ["in", "class", "primary", "secondary", "tertiary", "trunk"]
      ],
      "layout": { "line-cap": "butt", "line-join": "miter" },
      "paint": {
        "line-color": "#dedede",
        "line-gap-width": {
          "base": 1.55,
          "stops": [
            [4, 0.25],
            [20, 30]
          ]
        },
        "line-width": {
          "base": 1.6,
          "stops": [
            [12, 0.5],
            [20, 10]
          ]
        }
      }
    },
    {
      "id": "bridge_minor",
      "type": "line",
      "source": "openmaptiles",
      "source-layer": "transportation",
      "filter": [
        "all",
        ["==", "$type", "LineString"],
        ["==", "brunnel", "bridge"],
        ["==", "class", "minor_road"]
      ],
      "layout": { "line-cap": "round", "line-join": "round" },
      "paint": {
        "line-color": "#efefef",
        "line-width": {
          "base": 1.55,
          "stops": [
            [4, 0.25],
            [20, 30]
          ]
        }
      }
    },
    {
      "id": "bridge_major",
      "type": "line",
      "source": "openmaptiles",
      "source-layer": "transportation",
      "filter": [
        "all",
        ["==", "$type", "LineString"],
        ["==", "brunnel", "bridge"],
        ["in", "class", "primary", "secondary", "tertiary", "trunk"]
      ],
      "layout": { "line-cap": "round", "line-join": "round" },
      "paint": {
        "line-color": "#fff",
        "line-width": {
          "base": 1.4,
          "stops": [
            [6, 0.5],
            [20, 30]
          ]
        }
      }
    }
  ],
  "id": "basic"
}
```

## pbf parse error
**tilemaker の compress 設定で pbf は gz 圧縮されている**

> rename `*.pbf` to `*.pbf.gz`

[Improving tilemaker hosting speed | Wouter van Kleunen](https://blog.kleunen.nl/blog/improving-tilemaker-hosting-speed)

```
Unable to parse the tile at http://xxx/{zoom}/{x}/{y}.pbf, please make sure the data is not gzipped and that you have configured the relevant header in the server
```
