execute unless score @s br.round = #round br.round run return run kill @s
execute unless entity @s[tag=oa.db_projectile] unless score #state br.state matches 1 run return run kill @s
scoreboard players remove @s oa.gbomb 1
particle minecraft:smoke ~0.5 ~1 ~0.5 0.1 0.1 0.1 0 1 normal @a[distance=..24]
execute if score @s oa.gbomb matches 0 run function oa:tayayuyu/bomb_explode
