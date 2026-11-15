execute if entity @s[tag=oa.db_multi] run return run function oa:debug/inventory
scoreboard players set @s oa.have 0
execute store result storage oa:args serial int 1 run scoreboard players get @s oa.owner
function oa:inventory/find_old with storage oa:args
execute if score @s oa.have matches 0 if score @s oa.owner matches 1.. run function oa:internal/cleanup
execute if score @s oa.have matches 0 run scoreboard players set @s oa.owner 0
scoreboard players set @s oa.have 0
# 1.9.182: 軽量化。固有武器がどこにもなければ、41マスを1つずつ調べない（毎tick・全員。調べる中身は inventory/scan_slots に移しただけ）
scoreboard players set #inv_u oa.tmp 0
execute if items entity @s container.* *[minecraft:custom_data~{oa:{unique:1b}}] run scoreboard players set #inv_u oa.tmp 1
execute if score #inv_u oa.tmp matches 0 if items entity @s weapon.offhand *[minecraft:custom_data~{oa:{unique:1b}}] run scoreboard players set #inv_u oa.tmp 1
execute if score #inv_u oa.tmp matches 0 if items entity @s armor.* *[minecraft:custom_data~{oa:{unique:1b}}] run scoreboard players set #inv_u oa.tmp 1
execute if score #inv_u oa.tmp matches 1 run function oa:inventory/scan_slots
function oa:inventory/equip_curse

function oa:inventory/equip_yuua
