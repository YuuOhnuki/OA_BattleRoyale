execute align xyz positioned ~0.5 ~0.5 ~0.5 if entity @e[type=minecraft:marker,tag=br.chest,distance=..0.2] run scoreboard players set #open_found br.flag 1
execute align xyz positioned ~0.5 ~0.5 ~0.5 as @e[tag=br.chest,distance=..0.2,limit=1] at @s run function oa:br/loot/mark_open
