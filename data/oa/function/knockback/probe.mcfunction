execute unless loaded ~ ~ ~ run return run scoreboard players set @s oa.kpush 0
scoreboard players set #eight oa.tmp 8
execute store result score #frac oa.tmp run data get entity @s Pos[1] 8
scoreboard players operation #frac oa.tmp %= #eight oa.tmp
scoreboard players set #raise oa.tmp 0
execute if block ~-0.3 ~0.05 ~-0.3 #minecraft:slabs[type=bottom] if score #frac oa.tmp matches ..3 run scoreboard players set #raise oa.tmp 4
execute if block ~-0.3 ~0.05 ~-0.3 minecraft:snow[layers=1] if score #frac oa.tmp matches ..0 if score #raise oa.tmp matches ..0 run scoreboard players set #raise oa.tmp 1
execute if block ~-0.3 ~0.05 ~-0.3 minecraft:snow[layers=2] if score #frac oa.tmp matches ..1 if score #raise oa.tmp matches ..1 run scoreboard players set #raise oa.tmp 2
execute if block ~-0.3 ~0.05 ~-0.3 minecraft:snow[layers=3] if score #frac oa.tmp matches ..2 if score #raise oa.tmp matches ..2 run scoreboard players set #raise oa.tmp 3
execute if block ~-0.3 ~0.05 ~-0.3 minecraft:snow[layers=4] if score #frac oa.tmp matches ..3 if score #raise oa.tmp matches ..3 run scoreboard players set #raise oa.tmp 4
execute if block ~-0.3 ~0.05 ~0.3 #minecraft:slabs[type=bottom] if score #frac oa.tmp matches ..3 run scoreboard players set #raise oa.tmp 4
execute if block ~-0.3 ~0.05 ~0.3 minecraft:snow[layers=1] if score #frac oa.tmp matches ..0 if score #raise oa.tmp matches ..0 run scoreboard players set #raise oa.tmp 1
execute if block ~-0.3 ~0.05 ~0.3 minecraft:snow[layers=2] if score #frac oa.tmp matches ..1 if score #raise oa.tmp matches ..1 run scoreboard players set #raise oa.tmp 2
execute if block ~-0.3 ~0.05 ~0.3 minecraft:snow[layers=3] if score #frac oa.tmp matches ..2 if score #raise oa.tmp matches ..2 run scoreboard players set #raise oa.tmp 3
execute if block ~-0.3 ~0.05 ~0.3 minecraft:snow[layers=4] if score #frac oa.tmp matches ..3 if score #raise oa.tmp matches ..3 run scoreboard players set #raise oa.tmp 4
execute if block ~0.3 ~0.05 ~-0.3 #minecraft:slabs[type=bottom] if score #frac oa.tmp matches ..3 run scoreboard players set #raise oa.tmp 4
execute if block ~0.3 ~0.05 ~-0.3 minecraft:snow[layers=1] if score #frac oa.tmp matches ..0 if score #raise oa.tmp matches ..0 run scoreboard players set #raise oa.tmp 1
execute if block ~0.3 ~0.05 ~-0.3 minecraft:snow[layers=2] if score #frac oa.tmp matches ..1 if score #raise oa.tmp matches ..1 run scoreboard players set #raise oa.tmp 2
execute if block ~0.3 ~0.05 ~-0.3 minecraft:snow[layers=3] if score #frac oa.tmp matches ..2 if score #raise oa.tmp matches ..2 run scoreboard players set #raise oa.tmp 3
execute if block ~0.3 ~0.05 ~-0.3 minecraft:snow[layers=4] if score #frac oa.tmp matches ..3 if score #raise oa.tmp matches ..3 run scoreboard players set #raise oa.tmp 4
execute if block ~0.3 ~0.05 ~0.3 #minecraft:slabs[type=bottom] if score #frac oa.tmp matches ..3 run scoreboard players set #raise oa.tmp 4
execute if block ~0.3 ~0.05 ~0.3 minecraft:snow[layers=1] if score #frac oa.tmp matches ..0 if score #raise oa.tmp matches ..0 run scoreboard players set #raise oa.tmp 1
execute if block ~0.3 ~0.05 ~0.3 minecraft:snow[layers=2] if score #frac oa.tmp matches ..1 if score #raise oa.tmp matches ..1 run scoreboard players set #raise oa.tmp 2
execute if block ~0.3 ~0.05 ~0.3 minecraft:snow[layers=3] if score #frac oa.tmp matches ..2 if score #raise oa.tmp matches ..2 run scoreboard players set #raise oa.tmp 3
execute if block ~0.3 ~0.05 ~0.3 minecraft:snow[layers=4] if score #frac oa.tmp matches ..3 if score #raise oa.tmp matches ..3 run scoreboard players set #raise oa.tmp 4
execute if score #raise oa.tmp matches 1.. run return run function oa:knockback/raise
function oa:knockback/clear
