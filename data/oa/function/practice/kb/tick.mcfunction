# 1.9.247：吹き飛ぶ標的（練習場、oa:practice で毎tick。tick から、練習中の人がいるときだけ）
# 置き場（oa.kb_home）ごとに標的がいなければ出す
execute as @e[type=minecraft:marker,tag=oa.kb_home] at @s run function oa:practice/kb/ensure
# 当たった直後（HurtTime>0）は数え直し、当たらないまま3秒たったら置き場へ戻す。体力は毎秒満タンに
execute as @e[type=minecraft:zombie,tag=oa.kb_target] store result score @s oa.tmp run data get entity @s HurtTime
scoreboard players set @e[type=minecraft:zombie,tag=oa.kb_target,scores={oa.tmp=1..}] oa.kb_idle 0
scoreboard players add @e[type=minecraft:zombie,tag=oa.kb_target,scores={oa.tmp=0}] oa.kb_idle 1
execute as @e[type=minecraft:zombie,tag=oa.kb_target,scores={oa.kb_idle=60}] run function oa:practice/kb/home
execute as @e[type=minecraft:zombie,tag=oa.kb_target] at @s if entity @s[y=-64,dy=123] run function oa:practice/kb/home
execute if score #perf oa.tmp matches 0 as @e[type=minecraft:zombie,tag=oa.kb_target] run data merge entity @s {Health:1024.0f,Fire:0s}
