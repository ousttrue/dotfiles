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
    twoweek_areas: [
        {code:11 name:"北海道地方"},
        {code:12 name:"北海道日本海側"},
        {code:13 name:"北海道オホーツク海側"},
        {code:14 name:"北海道太平洋側"},
        {code:15 name:"東北地方"},
        {code:16 name:"東北日本海側"},
        {code:17 name:"東北太平洋側"},
        {code:18 name:"東北北部"},
        {code:19 name:"東北南部"},
        {code:20 name:"関東甲信地方"},
        {code:21 name:"北陸地方"},
        {code:22 name:"東海地方"},
        {code:23 name:"近畿地方"},
        {code:24 name:"近畿日本海側"},
        {code:25 name:"近畿太平洋側"},
        {code:26 name:"中国地方"},
        {code:27 name:"山陰"},
        {code:28 name:"山陽"},
        {code:29 name:"四国地方"},
        {code:30 name:"九州北部地方"},
        {code:31 name:"九州南部・奄美地方"},
        {code:32 name:"九州南部"},
        {code:33 name:"奄美地方"},
        {code:34 name:"沖縄地方"},
    ]
    twoweek_points: [
        {code:47401 name:"稚内"},
        {code:47402 name:"北見枝幸"},
        {code:47404 name:"羽幌"},
        {code:47405 name:"雄武"},
        {code:47406 name:"留萌"},
        {code:47407 name:"旭川"},
        {code:47409 name:"網走"},
        {code:47411 name:"小樽"},
        {code:47412 name:"札幌"},
        {code:47413 name:"岩見沢"},
        {code:47417 name:"帯広"},
        {code:47418 name:"釧路"},
        {code:47420 name:"根室"},
        {code:47421 name:"寿都"},
        {code:47423 name:"室蘭"},
        {code:47424 name:"苫小牧"},
        {code:47426 name:"浦河"},
        {code:47428 name:"江差"},
        {code:47430 name:"函館"},
        {code:47433 name:"倶知安"},
        {code:47435 name:"紋別"},
        {code:47440 name:"広尾"},
        {code:47512 name:"大船渡"},
        {code:47520 name:"新庄"},
        {code:47570 name:"若松"},
        {code:47574 name:"深浦"},
        {code:47575 name:"青森"},
        {code:47576 name:"むつ"},
        {code:47581 name:"八戸"},
        {code:47582 name:"秋田"},
        {code:47584 name:"盛岡"},
        {code:47585 name:"宮古"},
        {code:47587 name:"酒田"},
        {code:47588 name:"山形"},
        {code:47590 name:"仙台"},
        {code:47592 name:"石巻"},
        {code:47595 name:"福島"},
        {code:47597 name:"白河"},
        {code:47598 name:"小名浜"},
        {code:47600 name:"輪島"},
        {code:47602 name:"相川"},
        {code:47604 name:"新潟"},
        {code:47605 name:"金沢"},
        {code:47606 name:"伏木"},
        {code:47607 name:"富山"},
        {code:47610 name:"長野"},
        {code:47612 name:"高田"},
        {code:47615 name:"宇都宮"},
        {code:47616 name:"福井"},
        {code:47617 name:"高山"},
        {code:47618 name:"松本"},
        {code:47620 name:"諏訪"},
        {code:47622 name:"軽井沢"},
        {code:47624 name:"前橋"},
        {code:47626 name:"熊谷"},
        {code:47629 name:"水戸"},
        {code:47631 name:"敦賀"},
        {code:47632 name:"岐阜"},
        {code:47636 name:"名古屋"},
        {code:47637 name:"飯田"},
        {code:47638 name:"甲府"},
        {code:47640 name:"河口湖"},
        {code:47641 name:"秩父"},
        {code:47646 name:"館野"},
        {code:47648 name:"銚子"},
        {code:47649 name:"上野"},
        {code:47651 name:"津"},
        {code:47653 name:"伊良湖"},
        {code:47654 name:"浜松"},
        {code:47655 name:"御前崎"},
        {code:47656 name:"静岡"},
        {code:47657 name:"三島"},
        {code:47662 name:"東京"},
        {code:47663 name:"尾鷲"},
        {code:47666 name:"石廊崎"},
        {code:47668 name:"網代"},
        {code:47670 name:"横浜"},
        {code:47672 name:"館山"},
        {code:47674 name:"勝浦"},
        {code:47675 name:"大島"},
        {code:47677 name:"三宅島"},
        {code:47678 name:"八丈島"},
        {code:47682 name:"千葉"},
        {code:47684 name:"四日市"},
        {code:47690 name:"日光"},
        {code:47740 name:"西郷"},
        {code:47741 name:"松江"},
        {code:47742 name:"境"},
        {code:47744 name:"米子"},
        {code:47746 name:"鳥取"},
        {code:47747 name:"豊岡"},
        {code:47750 name:"舞鶴"},
        {code:47754 name:"萩"},
        {code:47755 name:"浜田"},
        {code:47756 name:"津山"},
        {code:47759 name:"京都"},
        {code:47761 name:"彦根"},
        {code:47762 name:"下関"},
        {code:47765 name:"広島"},
        {code:47766 name:"呉"},
        {code:47767 name:"福山"},
        {code:47768 name:"岡山"},
        {code:47769 name:"姫路"},
        {code:47770 name:"神戸"},
        {code:47772 name:"大阪"},
        {code:47776 name:"洲本"},
        {code:47777 name:"和歌山"},
        {code:47778 name:"潮岬"},
        {code:47780 name:"奈良"},
        {code:47784 name:"山口"},
        {code:47800 name:"厳原"},
        {code:47805 name:"平戸"},
        {code:47807 name:"福岡"},
        {code:47809 name:"飯塚"},
        {code:47812 name:"佐世保"},
        {code:47813 name:"佐賀"},
        {code:47814 name:"日田"},
        {code:47815 name:"大分"},
        {code:47817 name:"長崎"},
        {code:47819 name:"熊本"},
        {code:47822 name:"延岡"},
        {code:47823 name:"阿久根"},
        {code:47824 name:"人吉"},
        {code:47827 name:"鹿児島"},
        {code:47829 name:"都城"},
        {code:47830 name:"宮崎"},
        {code:47831 name:"枕崎"},
        {code:47835 name:"油津"},
        {code:47836 name:"屋久島"},
        {code:47837 name:"種子島"},
        {code:47838 name:"牛深"},
        {code:47843 name:"福江"},
        {code:47887 name:"松山"},
        {code:47890 name:"多度津"},
        {code:47891 name:"高松"},
        {code:47892 name:"宇和島"},
        {code:47893 name:"高知"},
        {code:47895 name:"徳島"},
        {code:47897 name:"宿毛"},
        {code:47898 name:"清水"},
        {code:47899 name:"室戸岬"},
        {code:47909 name:"名瀬"},
        {code:47912 name:"与那国島"},
        {code:47918 name:"石垣島"},
        {code:47927 name:"宮古島"},
        {code:47929 name:"久米島"},
        {code:47936 name:"那覇"},
        {code:47940 name:"名護"},
        {code:47942 name:"沖永良部"},
        {code:47945 name:"南大東島"},
        {code:47971 name:"父島"},
    ]
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

export def twoweek [point] {
    http get $"https://www.data.jma.go.jp/cpd/twoweek/data/Latest/data_($point).json"
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

