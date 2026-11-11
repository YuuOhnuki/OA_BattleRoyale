# Read exact components through a transient item display; never write Player NBT.
summon minecraft:item_display ~ ~ ~ {Tags:["oa.db_reader"]}
$item replace entity @e[type=minecraft:item_display,tag=oa.db_reader,limit=1] contents from entity @s $(slot)
data modify storage oa:debug_item item set from entity @e[type=minecraft:item_display,tag=oa.db_reader,limit=1] item
kill @e[type=minecraft:item_display,tag=oa.db_reader]
data modify storage oa:debug_item item.count set value 1
data remove storage oa:debug_item item.components."minecraft:use_remainder"
$data modify storage oa:debug_item slot set value "$(slot)"
execute if entity @s[tag=oa.db_infinite] run function oa:debug/remainder with storage oa:debug_item
$execute unless entity @s[tag=oa.db_infinite] run item modify entity @s $(slot) oa:debug/remove_remainder
$execute if entity @s[tag=oa.db_free_cd] if items entity @s $(slot) *[minecraft:custom_data~{oa_furoball:1b}] run item modify entity @s $(slot) oa:debug/remove_cooldown

$execute unless entity @s[tag=oa.db_free_cd] if items entity @s $(slot) *[minecraft:custom_data~{oa_furoball:1b}] run item modify entity @s $(slot) oa:debug/restore_furo_cooldown

$item modify entity @s $(slot) oa:debug/mark_patch
