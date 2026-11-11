scoreboard players set #foot_ok oa.tmp 0
execute if block ~-0.3 ~0.05 ~-0.3 #oa:push_passable run scoreboard players set #foot_ok oa.tmp 1
execute if block ~-0.3 ~0.05 ~-0.3 #minecraft:slabs[type=bottom] if score #frac oa.tmp matches 4.. run scoreboard players set #foot_ok oa.tmp 1
execute if block ~-0.3 ~0.05 ~-0.3 minecraft:snow[layers=1] if score #frac oa.tmp matches 1.. run scoreboard players set #foot_ok oa.tmp 1
execute if block ~-0.3 ~0.05 ~-0.3 minecraft:snow[layers=2] if score #frac oa.tmp matches 2.. run scoreboard players set #foot_ok oa.tmp 1
execute if block ~-0.3 ~0.05 ~-0.3 minecraft:snow[layers=3] if score #frac oa.tmp matches 3.. run scoreboard players set #foot_ok oa.tmp 1
execute if block ~-0.3 ~0.05 ~-0.3 minecraft:snow[layers=4] if score #frac oa.tmp matches 4.. run scoreboard players set #foot_ok oa.tmp 1
execute if score #foot_ok oa.tmp matches 0 run return run scoreboard players set @s oa.kpush 0
execute unless block ~-0.3 ~0.9 ~-0.3 #oa:push_passable run return run scoreboard players set @s oa.kpush 0
execute unless block ~-0.3 ~1.75 ~-0.3 #oa:push_passable run return run scoreboard players set @s oa.kpush 0
scoreboard players set #foot_ok oa.tmp 0
execute if block ~-0.3 ~0.05 ~0.3 #oa:push_passable run scoreboard players set #foot_ok oa.tmp 1
execute if block ~-0.3 ~0.05 ~0.3 #minecraft:slabs[type=bottom] if score #frac oa.tmp matches 4.. run scoreboard players set #foot_ok oa.tmp 1
execute if block ~-0.3 ~0.05 ~0.3 minecraft:snow[layers=1] if score #frac oa.tmp matches 1.. run scoreboard players set #foot_ok oa.tmp 1
execute if block ~-0.3 ~0.05 ~0.3 minecraft:snow[layers=2] if score #frac oa.tmp matches 2.. run scoreboard players set #foot_ok oa.tmp 1
execute if block ~-0.3 ~0.05 ~0.3 minecraft:snow[layers=3] if score #frac oa.tmp matches 3.. run scoreboard players set #foot_ok oa.tmp 1
execute if block ~-0.3 ~0.05 ~0.3 minecraft:snow[layers=4] if score #frac oa.tmp matches 4.. run scoreboard players set #foot_ok oa.tmp 1
execute if score #foot_ok oa.tmp matches 0 run return run scoreboard players set @s oa.kpush 0
execute unless block ~-0.3 ~0.9 ~0.3 #oa:push_passable run return run scoreboard players set @s oa.kpush 0
execute unless block ~-0.3 ~1.75 ~0.3 #oa:push_passable run return run scoreboard players set @s oa.kpush 0
scoreboard players set #foot_ok oa.tmp 0
execute if block ~0.3 ~0.05 ~-0.3 #oa:push_passable run scoreboard players set #foot_ok oa.tmp 1
execute if block ~0.3 ~0.05 ~-0.3 #minecraft:slabs[type=bottom] if score #frac oa.tmp matches 4.. run scoreboard players set #foot_ok oa.tmp 1
execute if block ~0.3 ~0.05 ~-0.3 minecraft:snow[layers=1] if score #frac oa.tmp matches 1.. run scoreboard players set #foot_ok oa.tmp 1
execute if block ~0.3 ~0.05 ~-0.3 minecraft:snow[layers=2] if score #frac oa.tmp matches 2.. run scoreboard players set #foot_ok oa.tmp 1
execute if block ~0.3 ~0.05 ~-0.3 minecraft:snow[layers=3] if score #frac oa.tmp matches 3.. run scoreboard players set #foot_ok oa.tmp 1
execute if block ~0.3 ~0.05 ~-0.3 minecraft:snow[layers=4] if score #frac oa.tmp matches 4.. run scoreboard players set #foot_ok oa.tmp 1
execute if score #foot_ok oa.tmp matches 0 run return run scoreboard players set @s oa.kpush 0
execute unless block ~0.3 ~0.9 ~-0.3 #oa:push_passable run return run scoreboard players set @s oa.kpush 0
execute unless block ~0.3 ~1.75 ~-0.3 #oa:push_passable run return run scoreboard players set @s oa.kpush 0
scoreboard players set #foot_ok oa.tmp 0
execute if block ~0.3 ~0.05 ~0.3 #oa:push_passable run scoreboard players set #foot_ok oa.tmp 1
execute if block ~0.3 ~0.05 ~0.3 #minecraft:slabs[type=bottom] if score #frac oa.tmp matches 4.. run scoreboard players set #foot_ok oa.tmp 1
execute if block ~0.3 ~0.05 ~0.3 minecraft:snow[layers=1] if score #frac oa.tmp matches 1.. run scoreboard players set #foot_ok oa.tmp 1
execute if block ~0.3 ~0.05 ~0.3 minecraft:snow[layers=2] if score #frac oa.tmp matches 2.. run scoreboard players set #foot_ok oa.tmp 1
execute if block ~0.3 ~0.05 ~0.3 minecraft:snow[layers=3] if score #frac oa.tmp matches 3.. run scoreboard players set #foot_ok oa.tmp 1
execute if block ~0.3 ~0.05 ~0.3 minecraft:snow[layers=4] if score #frac oa.tmp matches 4.. run scoreboard players set #foot_ok oa.tmp 1
execute if score #foot_ok oa.tmp matches 0 run return run scoreboard players set @s oa.kpush 0
execute unless block ~0.3 ~0.9 ~0.3 #oa:push_passable run return run scoreboard players set @s oa.kpush 0
execute unless block ~0.3 ~1.75 ~0.3 #oa:push_passable run return run scoreboard players set @s oa.kpush 0
tp @s ~ ~ ~
