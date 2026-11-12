execute unless score #wx br.tmp matches 1 run return 0
scoreboard players operation #weather_mod br.tmp = #time br.time
scoreboard players set #weather_period br.tmp 3600
scoreboard players operation #weather_mod br.tmp %= #weather_period br.tmp
execute if score #time br.time matches 3600.. if score #weather_mod br.tmp matches 0 run function oa:br/weather/roll
execute if score #perf oa.tmp matches 0 if score #weather_target br.tmp matches 0..2 if score #map oa.mapid matches 0 in oa:br run function oa:br/weather/maintain
execute if score #perf oa.tmp matches 0 if score #weather_target br.tmp matches 0..2 if score #map oa.mapid matches 1 in oa:br_nether run function oa:br/weather/maintain
