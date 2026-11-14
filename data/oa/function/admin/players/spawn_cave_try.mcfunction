scoreboard players add #cave_try oa.tmp 1
$spreadplayers $(x) $(z) 0 $(range) under 76 false @e[distance=0..,type=minecraft:armor_stand,tag=oa.admin_spawn,limit=1]
execute as @e[distance=0..,type=minecraft:armor_stand,tag=oa.admin_spawn,limit=1] at @s if entity @s[y=45,dy=33] unless block ~ ~-1 ~ #minecraft:air if block ~ ~ ~ #oa:spawn_clear if block ~ ~1 ~ #oa:spawn_clear run return run scoreboard players set #roster_spawn oa.tmp 1
execute if score #cave_try oa.tmp matches 30.. run return 0
function oa:admin/players/spawn_cave_try with storage oa:roster_spawn args
