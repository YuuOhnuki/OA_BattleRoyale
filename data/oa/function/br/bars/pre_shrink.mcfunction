bossbar set oa:zone_timer max 10
bossbar set oa:zone_timer color yellow
bossbar set oa:zone_timer visible true
execute store result bossbar oa:zone_timer value run scoreboard players get #bar_left br.tmp
bossbar set oa:zone_timer name [{text:"安置収縮開始まで： ",color:"yellow"},{score:{name:"#bar_left",objective:"br.tmp"}},{text:"秒"}]
