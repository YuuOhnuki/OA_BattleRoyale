# 1.9.247：標的（本人）を自分の置き場へ戻す
scoreboard players operation #kp oa.tmp = @s oa.kb_pair
tag @s add oa.kb_self
execute as @e[type=minecraft:marker,tag=oa.kb_home] if score @s oa.kb_pair = #kp oa.tmp at @s run tp @e[type=minecraft:zombie,tag=oa.kb_self,limit=1] ~ ~ ~ ~ 0
tag @s remove oa.kb_self
data merge entity @s {Motion:[0.0d,0.0d,0.0d]}
scoreboard players set @s oa.kb_idle 61
execute at @s run particle minecraft:poof ~ ~1 ~ 0.3 0.6 0.3 0.02 12
