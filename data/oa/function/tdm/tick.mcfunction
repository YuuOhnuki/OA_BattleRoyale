execute unless score #active tdm.sys matches 1 run return 0
scoreboard players add #time tdm.sys 1
execute as @a[tag=tdm.player] run function oa:tdm/count_kills
execute if score #time tdm.sys matches 6000.. run return run function oa:tdm/finish
execute as @a[tag=tdm.player,tag=br.alive,nbt={Health:0.0f}] at @s run function oa:tdm/death
scoreboard players remove @a[tag=tdm.player,scores={tdm.wait=1..}] tdm.wait 1
execute as @a[tag=tdm.player,tag=!br.alive,scores={tdm.wait=0},nbt=!{Health:0.0f}] at @s run function oa:tdm/respawn
scoreboard players remove @a[tag=tdm.player,scores={tdm.guard=1..}] tdm.guard 1
execute as @a[tag=tdm.player,tag=br.pvp_grace,scores={tdm.guard=0}] run effect clear @s minecraft:resistance
tag @a[tag=tdm.player,scores={tdm.guard=0}] remove br.pvp_grace
execute as @a[tag=tdm.player,tag=br.alive] at @s unless dimension oa:tdm run function oa:tdm/death
execute in oa:tdm as @a[tag=tdm.player,tag=br.alive] at @s if entity @s[y=-64,dy=125] run function oa:tdm/death
execute in oa:tdm run function oa:world_tick
execute in oa:tdm run function oa:tdm/loot/tick
execute if score #perf oa.tmp matches 0 run function oa:tdm/hud
