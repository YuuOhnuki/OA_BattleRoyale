playsound minecraft:block.amethyst_block.chime player @s ~ ~ ~ 1.2 1.3
playsound minecraft:entity.experience_orb.pickup player @s ~ ~ ~ 1 1.1
scoreboard players set @s br.open 0

scoreboard players set #open_ray br.tmp 0
scoreboard players set #open_found br.flag 0
scoreboard players set #open_reward br.flag 0
execute at @s rotated as @s anchored eyes positioned ^ ^ ^0.1 anchored feet run function oa:br/loot/open_ray
execute if score #open_found br.flag matches 0 at @s as @e[type=minecraft:marker,tag=br.chest,distance=..5,sort=nearest,limit=1] at @s run function oa:br/loot/mark_open
execute if score #open_reward br.flag matches 1 if entity @s[tag=br.alive] run function oa:itori/count_chest
execute if score #open_reward br.flag matches 1 if entity @s[tag=br.alive] run scoreboard players add @s br.st_open 1
execute if score @s br.st_open matches 10 run function oa:ach/give {id:"chests10",name:"宝探し"}
execute if score @s br.st_open matches 20 run function oa:ach/give {id:"chests20",name:"大富豪"}
execute if score @s br.st_open matches 30 run function oa:ach/give {id:"greedy30",name:"強欲な探検家"}
