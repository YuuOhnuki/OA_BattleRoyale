data modify storage oa:scan item set value {}
$function oa:inventory/read_slot {path:"$(path)"}
execute store result score #serial oa.tmp run data get storage oa:scan item.components."minecraft:custom_data".oa.serial
execute if score @s oa.owner matches 0 unless score @s oa.notice = #serial oa.tmp run tellraw @a [{selector:"@s",color:"yellow"},{text:" が "},{nbt:'item.components."minecraft:custom_name"',storage:"oa:scan",interpret:true},{text:" を拾いました！",color:"gold"}]
execute if score @s oa.owner matches 0 run scoreboard players operation @s oa.notice = #serial oa.tmp
execute if score @s oa.owner matches 0 run scoreboard players operation @s oa.owner = #serial oa.tmp
$execute unless score #serial oa.tmp = @s oa.owner run return run function oa:inventory/drop {slot:"$(slot)"}
$execute if score @s oa.have matches 1.. run return run function oa:inventory/drop {slot:"$(slot)"}
$function oa:inventory/lore {slot:"$(slot)"}
$function oa:inventory/visual {slot:"$(slot)"}
scoreboard players set @s oa.have 1
