[[GIS]]

- [GDAL — GDAL documentation](https://gdal.org/index.html)

> translator library for raster and vector geospatial data formats

- [GDAL/OGR クイックスタート — OSGeo-Live 10.5 Documentation](https://live.osgeo.org/archive/10.5/ja/quickstart/gdal_quickstart.html)
- http://www2.geog.ucl.ac.uk/~plewis/geogg122_current/_build/html/Chapter0_Introduction/f1_index.html

## build
- [OSGeo4W](https://trac.osgeo.org/osgeo4w/)

- [Build hints (cmake) — GDAL documentation](https://gdal.org/build_hints.html)

### PROJ に依存

- [GitHub - OSGeo/PROJ: PROJ - Cartographic Projections and Coordinate Transformations Library](https://github.com/OSGeo/PROJ/)

`sqlite3` が必用。
	
## shp
- [Raster API tutorial — GDAL documentation](https://gdal.org/tutorials/raster_api_tut.html)

```python
from osgeo import gdal, ogr


def main(shp_file):
	geo = ogr.Open(shp_file)
	# print(geo.GetLayerCount())
	layer = geo.GetLayer()
	x_min, x_max, y_min, y_max = layer.GetExtent()
	
	aspect = (x_max - x_min) / (y_max - y_min)
	height = 512
	
	ds = gdal.GetDriverByName('GTiff').Create('tmp.tif', int(height * aspect),
										   height, 1, gdal.GDT_Int16)
	res = (y_max - y_min) / height
	
	# x, width, x_skew, y, y_skew, height
	# ds.SetGeoTransform((x_min, res, 0, y_min, 0, res))
	ds.SetGeoTransform((x_min, res, 0, y_max, 0, -res)) # flip vertical
	# white background
	band = ds.GetRasterBand(1)
	band.SetNoDataValue(-9999)
	
	gdal.RasterizeLayer(ds, [1], layer, burn_values=[0]) 
```

[都道府県の画像アセットを全自動生成しよう。 - Zopfcode](http://www.zopfco.de/entry/2016/12/22/002947)
