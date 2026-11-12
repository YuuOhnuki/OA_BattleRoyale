execute if score #map oa.mapid matches 0 in oa:br as @e[distance=0..,type=minecraft:marker,tag=br.chest] at @s run function oa:br/loot/chest_tick
execute if score #map oa.mapid matches 1 in oa:br_nether as @e[distance=0..,type=minecraft:marker,tag=br.chest] at @s run function oa:br/loot/chest_tick
