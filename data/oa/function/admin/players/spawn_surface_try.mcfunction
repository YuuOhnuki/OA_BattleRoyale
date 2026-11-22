scoreboard players add #surface_try oa.tmp 1
$execute store success score #roster_spawn oa.tmp run spreadplayers $(x) $(z) 0 $(range) false @e[distance=0..,type=minecraft:armor_stand,tag=oa.admin_spawn,limit=1]
execute unless score #roster_spawn oa.tmp matches 1 run return 0
scoreboard players set #spawn_floor br.flag 0
execute as @e[distance=0..,type=minecraft:armor_stand,tag=oa.admin_spawn,limit=1] at @s run function oa:admin/players/spawn_surface_check
execute if score #spawn_floor br.flag matches 1 run return 1
scoreboard players set #roster_spawn oa.tmp 0
execute if score #surface_try oa.tmp matches 30.. run return 0
function oa:admin/players/spawn_surface_try with storage oa:roster_spawn args
