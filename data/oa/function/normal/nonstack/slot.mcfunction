$execute store result score #stack_count oa.tmp run data get entity @s $(path).count
$execute if score #stack_count oa.tmp matches ..1 run return run item modify entity @s $(slot) oa:nonstack
summon minecraft:item ~ ~0.5 ~ {Tags:["oa.stack_source"],PickupDelay:10,Item:{id:"minecraft:stone",count:1}}
$execute store success score #stack_ok oa.tmp run item replace entity @e[type=minecraft:item,tag=oa.stack_source,limit=1] contents from entity @s $(slot)
execute unless score #stack_ok oa.tmp matches 1 run return run kill @e[type=minecraft:item,tag=oa.stack_source]
$item replace entity @s $(slot) with minecraft:air
execute as @e[type=minecraft:item,tag=oa.stack_source] at @s run function oa:normal/nonstack/split
tag @e[tag=oa.stack_source] remove oa.stack_source
