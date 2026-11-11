execute store result score #stack_count oa.tmp run data get entity @s Item.count
execute if score #stack_count oa.tmp matches ..1 run return run item modify entity @s contents oa:nonstack
summon minecraft:item ~ ~ ~ {Tags:["oa.stack_copy"],PickupDelay:10,Item:{id:"minecraft:stone",count:1}}
execute store success score #stack_ok oa.tmp run item replace entity @e[type=minecraft:item,tag=oa.stack_copy,limit=1] contents from entity @s contents oa:nonstack_one
execute unless score #stack_ok oa.tmp matches 1 run return run kill @e[type=minecraft:item,tag=oa.stack_copy]
scoreboard players remove #stack_count oa.tmp 1
execute store result entity @s Item.count int 1 run scoreboard players get #stack_count oa.tmp
tag @e[type=minecraft:item,tag=oa.stack_copy] remove oa.stack_copy
function oa:normal/nonstack/split
