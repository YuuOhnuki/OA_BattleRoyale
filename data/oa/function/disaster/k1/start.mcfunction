scoreboard players set #dis_left br.tmp 30
scoreboard players operation #dis_wx_prev br.tmp = #weather_target br.tmp
scoreboard players set #weather_target br.tmp 1
execute if score #map oa.mapid matches 0 in oa:br run function oa:br/weather/apply
execute if score #map oa.mapid matches 1 in oa:br_nether run function oa:br/weather/apply
title @a[tag=br.playing] times 10 60 15
title @a[tag=br.playing] subtitle {text:"頭に防具を着けるか、屋根の下へ",color:"yellow"}
title @a[tag=br.playing] title {text:"⚠ 災害：酸性雨",color:"green",bold:true}
tellraw @a[tag=br.playing] [{text:"⚠ 災害発生：",color:"green",bold:true},{text:"酸性雨　",color:"white",bold:true},{text:"空の見える所で雨に当たると毎秒2ダメージ。頭防具か屋根で防げる（30秒）",color:"gray"}]
