bossbar set oa:zone_timer max 10
bossbar set oa:zone_timer color yellow
bossbar set oa:zone_timer visible true
execute store result bossbar oa:zone_timer value run scoreboard players get #next br.tmp
bossbar set oa:zone_timer name [{text:"安全地帯の収縮開始まで： ",color:"yellow"},{score:{name:"#next",objective:"br.tmp"}},{text:"秒"}]
