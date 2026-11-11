data modify storage oa:br_potion id set from storage oa:br_item id
data modify storage oa:br_potion potion set from storage oa:br_item stack.components."minecraft:potion_contents".potion
function oa:br/ui/potion_lookup with storage oa:br_potion
