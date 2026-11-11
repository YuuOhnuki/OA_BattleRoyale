execute if score #state br.state matches 1.. run return 0
tag @s remove br.pick_rearm
execute unless entity @s[team=oa_br7] run team join oa_br7 @s
execute if score @s br.pick matches 7 run return 0
scoreboard players set @s br.pick 7
tellraw @s [{text:"チーム7（紫）",color:"dark_purple"},{text:"に参加しました。",color:"white"}]
playsound minecraft:block.amethyst_block.chime player @s ~ ~ ~ 1 1.2
particle minecraft:happy_villager ~ ~1 ~ 0.6 0.8 0.6 0 18 normal @a[distance=..20]

particle minecraft:firework ~ ~1 ~ 0.7 0.8 0.7 0.04 20 normal @a[distance=..24]
playsound minecraft:entity.firework_rocket.twinkle player @s ~ ~ ~ 0.8 1.4
