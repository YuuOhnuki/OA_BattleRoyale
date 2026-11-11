$execute store success score #ok oa.tmp run item replace entity @s $(slot) from entity @e[type=minecraft:item,tag=oa.pick,limit=1] contents
execute if score #ok oa.tmp matches 1 run scoreboard players set @s oa.notice 0
execute if score #ok oa.tmp matches 1 run playsound minecraft:entity.experience_orb.pickup player @s ~ ~ ~ 1 1.2
execute if score #ok oa.tmp matches 1 run playsound minecraft:block.amethyst_block.chime player @s ~ ~ ~ 0.8 1.4
execute if score #ok oa.tmp matches 1 run kill @e[type=minecraft:item,tag=oa.pick]
tag @e[type=minecraft:item,tag=oa.pick] remove oa.pick
