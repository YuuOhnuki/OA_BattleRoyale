execute unless score #map oa.mapid matches 1 run particle minecraft:splash ~ ~0.2 ~ 0.3 0.1 0.3 0.1 25 force @a[distance=..48]
execute unless score #map oa.mapid matches 1 run playsound minecraft:block.bubble_column.upwards_inside player @a[distance=..24] ~ ~ ~ 1 1
execute if score #map oa.mapid matches 1 run particle minecraft:lava ~ ~0.2 ~ 0.3 0.1 0.3 0 8 force @a[distance=..48]
execute if score #map oa.mapid matches 1 run playsound minecraft:block.lava.pop player @a[distance=..24] ~ ~ ~ 1 0.7
