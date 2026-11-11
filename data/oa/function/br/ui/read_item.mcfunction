$data modify storage oa:br_item stack set from entity @s $(path)
data modify storage oa:br_item id set from storage oa:br_item stack.id
function oa:br/ui/default_name with storage oa:br_item
execute if data storage oa:br_item stack.components."minecraft:potion_contents".potion run function oa:br/ui/potion_name
execute if data storage oa:br_item stack.components."minecraft:item_name" run data modify storage oa:br_item name set from storage oa:br_item stack.components."minecraft:item_name"
execute if data storage oa:br_item stack.components."minecraft:custom_name" run data modify storage oa:br_item name set from storage oa:br_item stack.components."minecraft:custom_name"
