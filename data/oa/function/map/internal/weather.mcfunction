execute unless score #state oa.map2 matches 3 run return 0
scoreboard players add #snow oa.map2 1
execute if score #snow oa.map2 matches 10.. as @a[tag=br.playing] at @s if dimension oa:br if biome ~ ~ ~ minecraft:snowy_plains run particle minecraft:snowflake ~ ~4 ~ 5 2 5 0.01 14 normal @s
execute if score #snow oa.map2 matches 10.. run scoreboard players set #snow oa.map2 0
