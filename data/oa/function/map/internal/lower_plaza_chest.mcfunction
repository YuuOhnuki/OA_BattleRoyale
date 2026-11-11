execute unless block ~ ~ ~ minecraft:chest run return 0
execute unless block ~ ~-1 ~ minecraft:air unless block ~ ~-1 ~ minecraft:stone_bricks run return 0
execute store success score #plaza_moved oa.map2 run clone ~ ~ ~ ~ ~ ~ ~ ~-1 ~ replace move
execute unless score #plaza_moved oa.map2 matches 1 run return 0
execute positioned ~0.5 ~0.5 ~0.5 as @e[type=minecraft:marker,tag=br.chest,distance=..0.2] at @s run tp @s ~ ~-1 ~
execute positioned ~0.5 ~1.7 ~0.5 as @e[type=minecraft:text_display,tag=br.open_label,distance=..0.2] at @s run tp @s ~ ~-1 ~
