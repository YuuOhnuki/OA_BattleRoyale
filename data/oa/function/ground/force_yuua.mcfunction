scoreboard players set #hat_ok oa.tmp 1
# 1.9.253: 元の頭の物はインベントリの空きへ（inventory/hold_head・release_head）
function oa:inventory/hold_head
execute if items entity @s armor.head * run return 0
execute store success score #hat_ok oa.tmp run item replace entity @s armor.head from entity @e[type=minecraft:item,tag=oa.pick,limit=1] contents
execute if score #hat_ok oa.tmp matches 0 if entity @e[type=minecraft:item,tag=oa.hat_hold,limit=1] run function oa:inventory/release_to {slot:"armor.head"}
function oa:inventory/release_head
execute if score #hat_ok oa.tmp matches 1 run scoreboard players set @s oa.notice 0
execute if score #hat_ok oa.tmp matches 1 run playsound minecraft:entity.experience_orb.pickup player @s ~ ~ ~ 1 1.2
execute if score #hat_ok oa.tmp matches 1 run playsound minecraft:block.amethyst_block.chime player @s ~ ~ ~ 0.8 1.4
execute if score #hat_ok oa.tmp matches 1 run kill @e[type=minecraft:item,tag=oa.pick]
tag @e[type=minecraft:item,tag=oa.pick] remove oa.pick
