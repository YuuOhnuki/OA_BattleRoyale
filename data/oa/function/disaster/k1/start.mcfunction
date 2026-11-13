scoreboard players set #dis_left br.tmp 30
scoreboard players operation #dis_wx_prev br.tmp = #weather_target br.tmp
scoreboard players set #weather_target br.tmp 1
execute if score #map oa.mapid matches 0 in oa:br run function oa:br/weather/apply
execute if score #map oa.mapid matches 1 in oa:br_nether run function oa:br/weather/apply
