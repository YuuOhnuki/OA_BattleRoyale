scoreboard players set @s oa.blocked 1
execute if entity @s[type=minecraft:player,tag=br.playing] run function oa:ach/give {id:"killing_guard",name:"やっべ思い出忘れてきた！"}
execute if score @s oa.guard_fx = #total oa.gtime run return 0
scoreboard players operation @s oa.guard_fx = #total oa.gtime
# 1.9.221：派手に（閃光・衝撃波・紫の輪・火花・トーテム風の粒。音は盾＋金床＋鐘＋トーテム＋花火を重ねる）
particle minecraft:flash{color:[0.8,0.3,1.0,1.0]} ~ ~1 ~ 0 0 0 0 1 normal @a[distance=..40]
particle minecraft:sonic_boom ~ ~1 ~ 0 0 0 0 1 normal @a[distance=..40]
particle minecraft:firework ~ ~1 ~ 0.6 0.8 0.6 0.25 70 normal @a[distance=..40]
particle minecraft:reverse_portal ~ ~1 ~ 0.6 0.8 0.6 0.4 60 normal @a[distance=..40]
particle minecraft:totem_of_undying ~ ~1 ~ 0.5 0.8 0.5 0.6 50 normal @a[distance=..40]
particle minecraft:electric_spark ~ ~1 ~ 0.5 0.8 0.5 0.6 40 normal @a[distance=..40]
particle minecraft:end_rod ~ ~1 ~ 0 0 0 0.3 30 normal @a[distance=..40]
# 腰の高さに紫の輪（半径1.4、12か所）
particle minecraft:dust{"color":[0.75,0.2,1.0],"scale":2.0} ~1.4 ~1 ~0 0.05 0.05 0.05 0 4 normal @a[distance=..40]
particle minecraft:dust{"color":[0.75,0.2,1.0],"scale":2.0} ~1.21 ~1 ~0.7 0.05 0.05 0.05 0 4 normal @a[distance=..40]
particle minecraft:dust{"color":[0.75,0.2,1.0],"scale":2.0} ~0.7 ~1 ~1.21 0.05 0.05 0.05 0 4 normal @a[distance=..40]
particle minecraft:dust{"color":[0.75,0.2,1.0],"scale":2.0} ~0 ~1 ~1.4 0.05 0.05 0.05 0 4 normal @a[distance=..40]
particle minecraft:dust{"color":[0.75,0.2,1.0],"scale":2.0} ~-0.7 ~1 ~1.21 0.05 0.05 0.05 0 4 normal @a[distance=..40]
particle minecraft:dust{"color":[0.75,0.2,1.0],"scale":2.0} ~-1.21 ~1 ~0.7 0.05 0.05 0.05 0 4 normal @a[distance=..40]
particle minecraft:dust{"color":[0.75,0.2,1.0],"scale":2.0} ~-1.4 ~1 ~0 0.05 0.05 0.05 0 4 normal @a[distance=..40]
particle minecraft:dust{"color":[0.75,0.2,1.0],"scale":2.0} ~-1.21 ~1 ~-0.7 0.05 0.05 0.05 0 4 normal @a[distance=..40]
particle minecraft:dust{"color":[0.75,0.2,1.0],"scale":2.0} ~-0.7 ~1 ~-1.21 0.05 0.05 0.05 0 4 normal @a[distance=..40]
particle minecraft:dust{"color":[0.75,0.2,1.0],"scale":2.0} ~0 ~1 ~-1.4 0.05 0.05 0.05 0 4 normal @a[distance=..40]
particle minecraft:dust{"color":[0.75,0.2,1.0],"scale":2.0} ~0.7 ~1 ~-1.21 0.05 0.05 0.05 0 4 normal @a[distance=..40]
particle minecraft:dust{"color":[0.75,0.2,1.0],"scale":2.0} ~1.21 ~1 ~-0.7 0.05 0.05 0.05 0 4 normal @a[distance=..40]
playsound minecraft:item.shield.block player @a[distance=..32] ~ ~ ~ 2 0.6
playsound minecraft:block.anvil.land player @a[distance=..32] ~ ~ ~ 0.9 1.7
playsound minecraft:block.bell.use player @a[distance=..32] ~ ~ ~ 1.6 1.4
playsound minecraft:item.totem.use player @a[distance=..32] ~ ~ ~ 0.55 1.8
playsound minecraft:block.amethyst_block.resonate player @a[distance=..32] ~ ~ ~ 1.8 1.6
playsound minecraft:entity.firework_rocket.large_blast player @a[distance=..32] ~ ~ ~ 1.4 1.2
playsound minecraft:entity.firework_rocket.twinkle player @a[distance=..32] ~ ~ ~ 1.2 1.4
