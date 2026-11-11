execute if score #state br.state matches 1 run function oa:br/border/check_position
execute if score #state br.state matches 1 if score #inside br.flag matches 0 run return run scoreboard players set @s oa.steps 0
execute unless loaded ~ ~ ~ run return run scoreboard players set @s oa.steps 0
execute unless block ~-0.31 ~0 ~-0.31 #minecraft:air run return run scoreboard players set @s oa.steps 0
execute unless block ~-0.31 ~0.9 ~-0.31 #minecraft:air run return run scoreboard players set @s oa.steps 0
execute unless block ~-0.31 ~1.8 ~-0.31 #minecraft:air run return run scoreboard players set @s oa.steps 0
execute unless block ~-0.31 ~0 ~0.31 #minecraft:air run return run scoreboard players set @s oa.steps 0
execute unless block ~-0.31 ~0.9 ~0.31 #minecraft:air run return run scoreboard players set @s oa.steps 0
execute unless block ~-0.31 ~1.8 ~0.31 #minecraft:air run return run scoreboard players set @s oa.steps 0
execute unless block ~0.31 ~0 ~-0.31 #minecraft:air run return run scoreboard players set @s oa.steps 0
execute unless block ~0.31 ~0.9 ~-0.31 #minecraft:air run return run scoreboard players set @s oa.steps 0
execute unless block ~0.31 ~1.8 ~-0.31 #minecraft:air run return run scoreboard players set @s oa.steps 0
execute unless block ~0.31 ~0 ~0.31 #minecraft:air run return run scoreboard players set @s oa.steps 0
execute unless block ~0.31 ~0.9 ~0.31 #minecraft:air run return run scoreboard players set @s oa.steps 0
execute unless block ~0.31 ~1.8 ~0.31 #minecraft:air run return run scoreboard players set @s oa.steps 0
tp @s ~ ~ ~
