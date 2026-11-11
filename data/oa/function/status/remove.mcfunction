$item modify entity @s $(slot) oa:status_remove
summon minecraft:item_display ~ ~ ~ {Tags:["oa.clean_stack"]}
$execute store success score #clean_ok oa.tmp run item replace entity @e[type=minecraft:item_display,tag=oa.clean_stack,limit=1] contents from entity @s $(slot)
execute as @e[type=minecraft:item_display,tag=oa.clean_stack,limit=1] run function oa:status/clean_display
$execute if score #clean_ok oa.tmp matches 1 run item replace entity @s $(slot) from entity @e[type=minecraft:item_display,tag=oa.clean_stack,limit=1] contents
kill @e[type=minecraft:item_display,tag=oa.clean_stack]
