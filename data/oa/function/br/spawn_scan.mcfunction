function oa:br/spawn_check
execute if score #spawn_floor br.flag matches 1 run return run tp @s ~ ~ ~
scoreboard players remove #spawn_depth br.tmp 1
execute if score #spawn_depth br.tmp matches ..0 run return 0
execute unless loaded ~ ~-1 ~ run return 0
execute unless block ~ ~-0.1 ~ #oa:spawn_clear unless block ~ ~-0.1 ~ #minecraft:leaves run return 0
execute positioned ~ ~-1 ~ run function oa:br/spawn_scan
