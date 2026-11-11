data modify storage oa:scan item set value {}
function oa:inventory/read_slot {path:"equipment.head"}
execute store result score @s oa.owner run data get storage oa:scan item.components."minecraft:custom_data".oa.serial
