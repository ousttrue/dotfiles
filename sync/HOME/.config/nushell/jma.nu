export-env {
$env.jma_area = if ("JMA_AREA" in $env) {
    $env.JMA_AREA
} else {
    "130000"
}
$env.jma_class10s = if ("JMA_CLASS10S" in $env) {
    $env.JMA_CLASS10S
} else {
    "130010"
}


$env.jma = {
    area: "https://www.jma.go.jp/bosai/common/const/area.json"
    overview: $"https://www.jma.go.jp/bosai/forecast/data/overview_forecast/($env.jma_area).json"
    forecast: $"https://www.jma.go.jp/bosai/forecast/data/forecast/($env.jma_area).json"
    latest_time: "https://www.jma.go.jp/bosai/amedas/data/latest_time.txt"
    amedastable: "https://www.jma.go.jp/bosai/amedas/const/amedastable.json"
}

} # export-env

export def area [key: string@area_completion] {
    # centers
    http get $env.jma.area | get $key | transpose c0 c1 | each {|e| {$key:$e.c0}|merge $e.c1}
}

export def amedas [] {
    let latest_time = http get $env.jma.latest_time
    http get $"https://www.jma.go.jp/bosai/amedas/data/map/($latest_time | date format '%Y%m%d%H%M%S').json"
}

def get_wether_emoji [$code] {

let jma_weather_codes = [
  ["100", "晴", "CLEAR", "🌞"],
  ["101", "晴時々曇", "PARTLY CLOUDY", "🌤️"],
  ["102", "晴一時雨", "CLEAR, OCCASIONAL SCATTERED SHOWERS", "🌦️"],
  ["103", "晴時々雨", "CLEAR, FREQUENT SCATTERED SHOWERS", "🌦️"],
  ["104", "晴一時雪", "CLEAR, SNOW FLURRIES", "🌦️"],
  ["105", "晴時々雪", "CLEAR, FREQUENT SNOW FLURRIES", "🌦️"],
  [
    "106",
    "晴一時雨か雪",
    "CLEAR, OCCASIONAL SCATTERED SHOWERS OR SNOW FLURRIES", "🌦️"
  ],
  ["107", "晴時々雨か雪", "CLEAR, FREQUENT SCATTERED SHOWERS OR SNOW FLURRIES", "🌦️"],
  [
    "108",
    "晴一時雨か雷雨",
    "CLEAR, OCCASIONAL SCATTERED SHOWERS AND/OR THUNDER", "🌦️"
  ],
  ["110", "晴後時々曇", "CLEAR, PARTLY CLOUDY LATER", "🌤️"],
  ["111", "晴後曇", "CLEAR, CLOUDY LATER", "🌤️"],
  ["112", "晴後一時雨", "CLEAR, OCCASIONAL SCATTERED SHOWERS LATER", "🌦️"],
  ["113", "晴後時々雨", "CLEAR, FREQUENT SCATTERED SHOWERS LATER", "🌦️"],
  ["114", "晴後雨", "CLEAR,RAIN LATER", "🌦️"],
  ["115", "晴後一時雪", "CLEAR, OCCASIONAL SNOW FLURRIES LATER", "🌦️"],
  ["116", "晴後時々雪", "CLEAR, FREQUENT SNOW FLURRIES LATER", "🌦️"],
  ["117", "晴後雪", "CLEAR,SNOW LATER", "🌦️"],
  ["118", "晴後雨か雪", "CLEAR, RAIN OR SNOW LATER", "🌦️"],
  ["119", "晴後雨か雷雨", "CLEAR, RAIN AND/OR THUNDER LATER", "🌦️"],
  [
    "120",
    "晴朝夕一時雨",
    "OCCASIONAL SCATTERED SHOWERS IN THE MORNING AND EVENING, CLEAR DURING THE DAY", "🌦️"
  ],
  [
    "121",
    "晴朝の内一時雨",
    "OCCASIONAL SCATTERED SHOWERS IN THE MORNING, CLEAR DURING THE DAY", "🌦️"
  ],
  ["122", "晴夕方一時雨", "CLEAR, OCCASIONAL SCATTERED SHOWERS IN THE EVENING", "🌦️"],
  [
    "123",
    "晴山沿い雷雨",
    "CLEAR IN THE PLAINS, RAIN AND THUNDER NEAR MOUTAINOUS AREAS", "🌦️"
  ],
  ["124", "晴山沿い雪", "CLEAR IN THE PLAINS, SNOW NEAR MOUTAINOUS AREAS", "🌦️"],
  ["125", "晴午後は雷雨", "CLEAR, RAIN AND THUNDER IN THE AFTERNOON", "🌦️"],
  ["126", "晴昼頃から雨", "CLEAR, RAIN IN THE AFTERNOON", "🌦️"],
  ["127", "晴夕方から雨", "CLEAR, RAIN IN THE EVENING", "🌦️"],
  ["128", "晴夜は雨", "CLEAR, RAIN IN THE NIGHT", "🌦️"],
  ["130", "朝の内霧後晴", "FOG IN THE MORNING, CLEAR LATER", "🌤️"],
  ["131", "晴明け方霧", "FOG AROUND DAWN, CLEAR LATER", "🌤️"],
  [
    "132",
    "晴朝夕曇",
    "CLOUDY IN THE MORNING AND EVENING, CLEAR DURING THE DAY", "🌤️"
  ],
  [
    "140",
    "晴時々雨で雷を伴う",
    "CLEAR, FREQUENT SCATTERED SHOWERS AND THUNDER", "🌦️"
  ],
  [
    "160",
    "晴一時雪か雨",
    "CLEAR, SNOW FLURRIES OR OCCASIONAL SCATTERED SHOWERS", "🌦️"
  ],
  ["170", "晴時々雪か雨", "CLEAR, FREQUENT SNOW FLURRIES OR SCATTERED SHOWERS", "🌦️"],
  ["181", "晴後雪か雨", "CLEAR, SNOW OR RAIN LATER", "🌦️"],
  ["200", "曇", "CLOUDY", "☁️"],
  ["201", "曇時々晴", "MOSTLY CLOUDY", "☁️"],
  ["202", "曇一時雨", "CLOUDY, OCCASIONAL SCATTERED SHOWERS", "🌧️"],
  ["203", "曇時々雨", "CLOUDY, FREQUENT SCATTERED SHOWERS", "🌧️"],
  ["204", "曇一時雪", "CLOUDY, OCCASIONAL SNOW FLURRIES", "🌨️"],
  ["205", "曇時々雪", "CLOUDY FREQUENT SNOW FLURRIES", "🌨️"],
  [
    "206",
    "曇一時雨か雪",
    "CLOUDY, OCCASIONAL SCATTERED SHOWERS OR SNOW FLURRIES", "🌨️"
  ],
  [
    "207",
    "曇時々雨か雪",
    "CLOUDY, FREQUENT SCCATERED SHOWERS OR SNOW FLURRIES", "🌨️"
  ],
  [
    "208",
    "曇一時雨か雷雨",
    "CLOUDY, OCCASIONAL SCATTERED SHOWERS AND/OR THUNDER", "🌩️"
  ],
  ["209", "霧", "FOG", "☁️"],
  ["210", "曇後時々晴", "CLOUDY, PARTLY CLOUDY LATER", "☁️"],
  ["211", "曇後晴", "CLOUDY, CLEAR LATER", "☁️"],
  ["212", "曇後一時雨", "CLOUDY, OCCASIONAL SCATTERED SHOWERS LATER", "🌧️"],
  ["213", "曇後時々雨", "CLOUDY, FREQUENT SCATTERED SHOWERS LATER", "🌧️"],
  ["214", "曇後雨", "CLOUDY, RAIN LATER", "🌧️"],
  ["215", "曇後一時雪", "CLOUDY, SNOW FLURRIES LATER", "🌨️"],
  ["216", "曇後時々雪", "CLOUDY, FREQUENT SNOW FLURRIES LATER", "🌨️"],
  ["217", "曇後雪", "CLOUDY, SNOW LATER", "🌨️"],
  ["218", "曇後雨か雪", "CLOUDY, RAIN OR SNOW LATER", "🌨️"],
  ["219", "曇後雨か雷雨", "CLOUDY, RAIN AND/OR THUNDER LATER", "🌩️"],
  [
    "220",
    "曇朝夕一時雨",
    "OCCASIONAL SCCATERED SHOWERS IN THE MORNING AND EVENING, CLOUDY DURING THE DAY", "🌧️"
  ],
  [
    "221",
    "曇朝の内一時雨",
    "CLOUDY OCCASIONAL SCCATERED SHOWERS IN THE MORNING", "🌧️"
  ],
  [
    "222",
    "曇夕方一時雨",
    "CLOUDY, OCCASIONAL SCCATERED SHOWERS IN THE EVENING", "🌧️"
  ],
  [
    "223",
    "曇日中時々晴",
    "CLOUDY IN THE MORNING AND EVENING, PARTLY CLOUDY DURING THE DAY,", "☁️"
  ],
  ["224", "曇昼頃から雨", "CLOUDY, RAIN IN THE AFTERNOON", "🌧️"],
  ["225", "曇夕方から雨", "CLOUDY, RAIN IN THE EVENING", "🌧️"],
  ["226", "曇夜は雨", "CLOUDY, RAIN IN THE NIGHT", "🌧️"],
  ["228", "曇昼頃から雪", "CLOUDY, SNOW IN THE AFTERNOON", "🌨️"],
  ["229", "曇夕方から雪", "CLOUDY, SNOW IN THE EVENING", "🌨️"],
  ["230", "曇夜は雪", "CLOUDY, SNOW IN THE NIGHT", "🌨️"],
  [
    "231",
    "曇海上海岸は霧か霧雨",
    "CLOUDY, FOG OR DRIZZLING ON THE SEA AND NEAR SEASHORE", "🌧️"
  ],
  [
    "240",
    "曇時々雨で雷を伴う",
    "CLOUDY, FREQUENT SCCATERED SHOWERS AND THUNDER", "🌩️"
  ],
  ["250", "曇時々雪で雷を伴う", "CLOUDY, FREQUENT SNOW AND THUNDER", "🌩️"],
  [
    "260",
    "曇一時雪か雨",
    "CLOUDY, SNOW FLURRIES OR OCCASIONAL SCATTERED SHOWERS", "🌧️"
  ],
  [
    "270",
    "曇時々雪か雨",
    "CLOUDY, FREQUENT SNOW FLURRIES OR SCATTERED SHOWERS", "🌧️"
  ],
  ["281", "曇後雪か雨", "CLOUDY, SNOW OR RAIN LATER", "🌨️"],
  ["300", "雨", "RAIN", "☔"],
  ["301", "雨時々晴", "RAIN, PARTLY CLOUDY", "☔"],
  ["302", "雨時々止む", "SHOWERS THROUGHOUT THE DAY", "☔"],
  ["303", "雨時々雪", "RAIN,FREQUENT SNOW FLURRIES", "☔"],
  ["304", "雨か雪", "RAINORSNOW","☃️"],
  ["306", "大雨", "HEAVYRAIN", "☔"],
  ["308", "雨で暴風を伴う", "RAINSTORM", "☔"],
  ["309", "雨一時雪", "RAIN,OCCASIONAL SNOW", "☔"],
  ["311", "雨後晴", "RAIN,CLEAR LATER", "☔"],
  ["313", "雨後曇", "RAIN,CLOUDY LATER", "☔"],
  ["314", "雨後時々雪", "RAIN, FREQUENT SNOW FLURRIES LATER", "☔"],
  ["315", "雨後雪", "RAIN,SNOW LATER", "☔"],
  ["316", "雨か雪後晴", "RAIN OR SNOW, CLEAR LATER", "☔"],
  ["317", "雨か雪後曇", "RAIN OR SNOW, CLOUDY LATER", "☔"],
  ["320", "朝の内雨後晴", "RAIN IN THE MORNING, CLEAR LATER", "☔"],
  ["321", "朝の内雨後曇", "RAIN IN THE MORNING, CLOUDY LATER", "☔"],
  [
    "322",
    "雨朝晩一時雪",
    "OCCASIONAL SNOW IN THE MORNING AND EVENING, RAIN DURING THE DAY", "☔"
  ],
  ["323", "雨昼頃から晴", "RAIN, CLEAR IN THE AFTERNOON", "☔"],
  ["324", "雨夕方から晴", "RAIN, CLEAR IN THE EVENING", "☔"],
  ["325", "雨夜は晴", "RAIN, CLEAR IN THE NIGHT", "☔"],
  ["326", "雨夕方から雪", "RAIN, SNOW IN THE EVENING", "☔"],
  ["327", "雨夜は雪", "RAIN,SNOW IN THE NIGHT", "☔"],
  ["328", "雨一時強く降る", "RAIN, EXPECT OCCASIONAL HEAVY RAINFALL", "☔"],
  ["329", "雨一時みぞれ", "RAIN, OCCASIONAL SLEET", "☔"],
  ["340", "雪か雨", "SNOWORRAIN", "☔"],
  ["350", "雨で雷を伴う", "RAIN AND THUNDER", "☔"],
  ["361", "雪か雨後晴", "SNOW OR RAIN, CLEAR LATER", "☃️"],
  ["371", "雪か雨後曇", "SNOW OR RAIN, CLOUDY LATER", "☃️"],
  ["400", "雪", "SNOW", "☃️"],
  ["401", "雪時々晴", "SNOW, FREQUENT CLEAR", "☃️"],
  ["402", "雪時々止む", "SNOWTHROUGHOUT THE DAY", "☃️"],
  ["403", "雪時々雨", "SNOW,FREQUENT SCCATERED SHOWERS", "☃️"],
  ["405", "大雪", "HEAVYSNOW", "☃️"],
  ["406", "風雪強い", "SNOWSTORM", "☃️"],
  ["407", "暴風雪", "HEAVYSNOWSTORM", "☃️"],
  ["409", "雪一時雨", "SNOW, OCCASIONAL SCCATERED SHOWERS", "☃️"],
  ["411", "雪後晴", "SNOW,CLEAR LATER", "☃️"],
  ["413", "雪後曇", "SNOW,CLOUDY LATER", "☃️"],
  ["414", "雪後雨", "SNOW,RAIN LATER", "☃️"],
  ["420", "朝の内雪後晴", "SNOW IN THE MORNING, CLEAR LATER", "☃️"],
  ["421", "朝の内雪後曇", "SNOW IN THE MORNING, CLOUDY LATER", "☃️"],
  ["422", "雪昼頃から雨", "SNOW, RAIN IN THE AFTERNOON", "☃️"],
  ["423", "雪夕方から雨", "SNOW, RAIN IN THE EVENING", "☃️"],
  ["425", "雪一時強く降る", "SNOW, EXPECT OCCASIONAL HEAVY SNOWFALL", "☃️"],
  ["426", "雪後みぞれ", "SNOW, SLEET LATER", "☃️"],
  ["427", "雪一時みぞれ", "SNOW, OCCASIONAL SLEET", "☃️"],
  ["450", "雪で雷を伴う", "SNOW AND THUNDER", "☃️"],
]

let found = $jma_weather_codes | | each {|e| {code: $e.0, name: $e.1, eng: $e.2, emoji: $e.3}} | where code == $code
    if ($found | is-empty) {
        ""
    } else {
        $found | get 0.emoji
    }
}

export def weather [d:datetime] {
    let forecast = http get $env.jma.forecast | get 1.timeSeries.0
    let times = $forecast | get timeDefines | into datetime | date format "%Y-%m-%d" | into datetime
    let area = $forecast | get areas | where area.code == $env.jma_class10s | first
    let found = $times | zip ($area | get weatherCodes) | each {|e| {date:$e.0 weather:$e.1}} | where date == $d
    if ($found | is-empty) {
        ""
    } else {
        (get_wether_emoji ($found | get 0.weather)) 
    }
}

