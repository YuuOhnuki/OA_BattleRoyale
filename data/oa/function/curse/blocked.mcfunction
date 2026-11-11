scoreboard players set @s oa.blocked 1
execute if entity @s[type=minecraft:player,tag=br.playing] run function oa:ach/give {id:"killing_guard",name:"25%の奇跡"}
execute if score @s oa.guard_fx = #total oa.gtime run return 0
scoreboard players operation @s oa.guard_fx = #total oa.gtime
particle minecraft:flash{color:[0.8,0.3,1.0,1.0]} ~ ~1 ~ 0 0 0 0 1 normal @a[distance=..40]
particle minecraft:firework ~ ~1 ~ 0.6 0.8 0.6 0.1 40 normal @a[distance=..40]
particle minecraft:reverse_portal ~ ~1 ~ 0.6 0.8 0.6 0.25 36 normal @a[distance=..40]
playsound minecraft:item.shield.block player @a[distance=..32] ~ ~ ~ 1.8 0.65
playsound minecraft:block.amethyst_block.resonate player @a[distance=..32] ~ ~ ~ 1.6 1.6
playsound minecraft:entity.firework_rocket.blast player @a[distance=..32] ~ ~ ~ 1.2 1.3
