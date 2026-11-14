scoreboard players set #pick_notice oa.tmp 0
data modify storage oa:scan item set value {}
$function oa:inventory/read_slot {path:"$(path)"}
execute store result score #serial oa.tmp run data get storage oa:scan item.components."minecraft:custom_data".oa.serial
# 1.9.157: 拾ったお知らせは、説明文（inventory/lore）を付けたあとに出す（名前にカーソルを合わせるとアイテムの説明が出る）
execute if score @s oa.owner matches 0 unless score @s oa.notice = #serial oa.tmp run scoreboard players set #pick_notice oa.tmp 1
execute if score @s oa.owner matches 0 run scoreboard players operation @s oa.notice = #serial oa.tmp
execute if score @s oa.owner matches 0 run scoreboard players operation @s oa.owner = #serial oa.tmp
$execute unless score #serial oa.tmp = @s oa.owner run return run function oa:inventory/drop {slot:"$(slot)"}
$execute if score @s oa.have matches 1.. run return run function oa:inventory/drop {slot:"$(slot)"}
$function oa:inventory/lore {slot:"$(slot)"}
$function oa:inventory/visual {slot:"$(slot)"}
scoreboard players set @s oa.have 1
$execute if score #pick_notice oa.tmp matches 1 run function oa:inventory/pick_notice {path:"$(path)"}
scoreboard players set #pick_notice oa.tmp 0
