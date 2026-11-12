execute if score #map oa.mapid matches 0 in oa:br as @e[type=minecraft:marker,tag=br.supply_wait,tag=!br.supply_drop,limit=1] at @s run function oa:br/supply/launch
execute if score #map oa.mapid matches 1 in oa:br_nether as @e[type=minecraft:marker,tag=br.supply_wait,tag=!br.supply_drop,limit=1] at @s run function oa:br/supply/launch
