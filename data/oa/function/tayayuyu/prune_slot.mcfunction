summon minecraft:item_display ~ ~ ~ {Tags:["oa.hat_reader"]}
$item replace entity @e[type=minecraft:item_display,tag=oa.hat_reader,limit=1] contents from entity @s $(slot)
execute store result score #hat_serial oa.tmp run data get entity @e[type=minecraft:item_display,tag=oa.hat_reader,limit=1] item.components."minecraft:custom_data".oa.serial
kill @e[type=minecraft:item_display,tag=oa.hat_reader]
$execute if score #hat_serial oa.tmp <= #hat_cut oa.serial run item replace entity @s $(slot) with minecraft:air
