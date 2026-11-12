function oa:br/weather/gate with storage oa:maps
execute unless score #wx br.tmp matches 1 run return run data remove storage oa:weather backup

data modify storage oa:weather backup.kind set value 0
execute if score #map oa.mapid matches 0 in oa:br if predicate oa:weather/rain run data modify storage oa:weather backup.kind set value 1
execute if score #map oa.mapid matches 1 in oa:br_nether if predicate oa:weather/rain run data modify storage oa:weather backup.kind set value 1
execute if score #map oa.mapid matches 0 in oa:br if predicate oa:weather/thunder run data modify storage oa:weather backup.kind set value 2
execute if score #map oa.mapid matches 1 in oa:br_nether if predicate oa:weather/thunder run data modify storage oa:weather backup.kind set value 2
scoreboard players set #weather_target br.tmp 0
execute if score #map oa.mapid matches 0 in oa:br run function oa:br/weather/apply
execute if score #map oa.mapid matches 1 in oa:br_nether run function oa:br/weather/apply
