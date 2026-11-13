scoreboard players set @s br.dtmr 14
particle minecraft:cloud ~ ~ ~ 0.3 2.5 0.3 0.2 80 force @a[distance=..64]
playsound minecraft:entity.generic.splash player @a[distance=..40] ~ ~ ~ 1.5 0.7
execute if score #map oa.mapid matches 1 run particle minecraft:flame ~ ~ ~ 0.3 2 0.3 0.15 60 force @a[distance=..64]
execute unless score #map oa.mapid matches 1 run particle minecraft:splash ~ ~ ~ 0.4 2 0.4 0.2 60 force @a[distance=..64]
execute unless score #map oa.mapid matches 1 as @a[tag=br.alive,distance=..2.2] run function oa:disaster/gimmick/launch
execute if score #map oa.mapid matches 1 as @a[tag=br.alive,distance=..2.2] run function oa:disaster/gimmick/vent_hit
