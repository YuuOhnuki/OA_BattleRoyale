$execute unless items entity @s $(slot) * run return 0
summon minecraft:item ~ ~0.5 ~ {Tags:["oa.transfer"],PickupDelay:100s,Item:{id:"minecraft:stone",count:1}}
$execute store success score #ok oa.tmp run item replace entity @e[type=minecraft:item,tag=oa.transfer,limit=1] contents from entity @s $(slot)
$execute if score #ok oa.tmp matches 1 run item replace entity @s $(slot) with minecraft:air
execute if score #ok oa.tmp matches 0 run kill @e[type=minecraft:item,tag=oa.transfer]
scoreboard players set @e[type=minecraft:item,tag=oa.transfer] oa.wait 100
tag @e[type=minecraft:item,tag=oa.transfer] remove oa.transfer
