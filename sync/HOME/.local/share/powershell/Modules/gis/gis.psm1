if ($env:GIS_DIR -and (Test-Path (Join-Path $env:GIS_DIR "jma/area.json")))
{
  $area = (Get-Content (Join-Path $env:GIS_DIR "jma/area.json") | ConvertFrom-Json -AsHashtable)[0]
} else
{
  $area = @{}
}

# function areaItems($key, $list)
# {
#   $items = $area[$key]
#   foreach($key in $items.keys)
#   {
#     $value = $items[$key]
#     $value["id"]= $key
#     [void]$list.Add($value)
#   }
# }

# function Get-Area()
# {
#   $list = [System.Collections.ArrayList]::new()
#
#   areaItems "centers" $list
#   areaItems "offices" $list
#   areaItems "class10s" $list
#   areaItems "class15s" $list
#   areaItems "class20s" $list
#
#   $list.ToArray()
# }
# 
