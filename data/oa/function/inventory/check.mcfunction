execute if entity @s[tag=oa.db_multi] run return run function oa:debug/inventory
scoreboard players set @s oa.have 0
execute store result storage oa:args serial int 1 run scoreboard players get @s oa.owner
function oa:inventory/find_old with storage oa:args
execute if score @s oa.have matches 0 if score @s oa.owner matches 1.. run function oa:internal/cleanup
execute if score @s oa.have matches 0 run scoreboard players set @s oa.owner 0
scoreboard players set @s oa.have 0
execute if items entity @s hotbar.0 *[minecraft:custom_data~{oa:{unique:1b}}] run function oa:inventory/slot {slot:"hotbar.0",path:"Inventory[{Slot:0b}]"}
execute if items entity @s hotbar.1 *[minecraft:custom_data~{oa:{unique:1b}}] run function oa:inventory/slot {slot:"hotbar.1",path:"Inventory[{Slot:1b}]"}
execute if items entity @s hotbar.2 *[minecraft:custom_data~{oa:{unique:1b}}] run function oa:inventory/slot {slot:"hotbar.2",path:"Inventory[{Slot:2b}]"}
execute if items entity @s hotbar.3 *[minecraft:custom_data~{oa:{unique:1b}}] run function oa:inventory/slot {slot:"hotbar.3",path:"Inventory[{Slot:3b}]"}
execute if items entity @s hotbar.4 *[minecraft:custom_data~{oa:{unique:1b}}] run function oa:inventory/slot {slot:"hotbar.4",path:"Inventory[{Slot:4b}]"}
execute if items entity @s hotbar.5 *[minecraft:custom_data~{oa:{unique:1b}}] run function oa:inventory/slot {slot:"hotbar.5",path:"Inventory[{Slot:5b}]"}
execute if items entity @s hotbar.6 *[minecraft:custom_data~{oa:{unique:1b}}] run function oa:inventory/slot {slot:"hotbar.6",path:"Inventory[{Slot:6b}]"}
execute if items entity @s hotbar.7 *[minecraft:custom_data~{oa:{unique:1b}}] run function oa:inventory/slot {slot:"hotbar.7",path:"Inventory[{Slot:7b}]"}
execute if items entity @s hotbar.8 *[minecraft:custom_data~{oa:{unique:1b}}] run function oa:inventory/slot {slot:"hotbar.8",path:"Inventory[{Slot:8b}]"}
execute if items entity @s inventory.0 *[minecraft:custom_data~{oa:{unique:1b}}] run function oa:inventory/slot {slot:"inventory.0",path:"Inventory[{Slot:9b}]"}
execute if items entity @s inventory.1 *[minecraft:custom_data~{oa:{unique:1b}}] run function oa:inventory/slot {slot:"inventory.1",path:"Inventory[{Slot:10b}]"}
execute if items entity @s inventory.2 *[minecraft:custom_data~{oa:{unique:1b}}] run function oa:inventory/slot {slot:"inventory.2",path:"Inventory[{Slot:11b}]"}
execute if items entity @s inventory.3 *[minecraft:custom_data~{oa:{unique:1b}}] run function oa:inventory/slot {slot:"inventory.3",path:"Inventory[{Slot:12b}]"}
execute if items entity @s inventory.4 *[minecraft:custom_data~{oa:{unique:1b}}] run function oa:inventory/slot {slot:"inventory.4",path:"Inventory[{Slot:13b}]"}
execute if items entity @s inventory.5 *[minecraft:custom_data~{oa:{unique:1b}}] run function oa:inventory/slot {slot:"inventory.5",path:"Inventory[{Slot:14b}]"}
execute if items entity @s inventory.6 *[minecraft:custom_data~{oa:{unique:1b}}] run function oa:inventory/slot {slot:"inventory.6",path:"Inventory[{Slot:15b}]"}
execute if items entity @s inventory.7 *[minecraft:custom_data~{oa:{unique:1b}}] run function oa:inventory/slot {slot:"inventory.7",path:"Inventory[{Slot:16b}]"}
execute if items entity @s inventory.8 *[minecraft:custom_data~{oa:{unique:1b}}] run function oa:inventory/slot {slot:"inventory.8",path:"Inventory[{Slot:17b}]"}
execute if items entity @s inventory.9 *[minecraft:custom_data~{oa:{unique:1b}}] run function oa:inventory/slot {slot:"inventory.9",path:"Inventory[{Slot:18b}]"}
execute if items entity @s inventory.10 *[minecraft:custom_data~{oa:{unique:1b}}] run function oa:inventory/slot {slot:"inventory.10",path:"Inventory[{Slot:19b}]"}
execute if items entity @s inventory.11 *[minecraft:custom_data~{oa:{unique:1b}}] run function oa:inventory/slot {slot:"inventory.11",path:"Inventory[{Slot:20b}]"}
execute if items entity @s inventory.12 *[minecraft:custom_data~{oa:{unique:1b}}] run function oa:inventory/slot {slot:"inventory.12",path:"Inventory[{Slot:21b}]"}
execute if items entity @s inventory.13 *[minecraft:custom_data~{oa:{unique:1b}}] run function oa:inventory/slot {slot:"inventory.13",path:"Inventory[{Slot:22b}]"}
execute if items entity @s inventory.14 *[minecraft:custom_data~{oa:{unique:1b}}] run function oa:inventory/slot {slot:"inventory.14",path:"Inventory[{Slot:23b}]"}
execute if items entity @s inventory.15 *[minecraft:custom_data~{oa:{unique:1b}}] run function oa:inventory/slot {slot:"inventory.15",path:"Inventory[{Slot:24b}]"}
execute if items entity @s inventory.16 *[minecraft:custom_data~{oa:{unique:1b}}] run function oa:inventory/slot {slot:"inventory.16",path:"Inventory[{Slot:25b}]"}
execute if items entity @s inventory.17 *[minecraft:custom_data~{oa:{unique:1b}}] run function oa:inventory/slot {slot:"inventory.17",path:"Inventory[{Slot:26b}]"}
execute if items entity @s inventory.18 *[minecraft:custom_data~{oa:{unique:1b}}] run function oa:inventory/slot {slot:"inventory.18",path:"Inventory[{Slot:27b}]"}
execute if items entity @s inventory.19 *[minecraft:custom_data~{oa:{unique:1b}}] run function oa:inventory/slot {slot:"inventory.19",path:"Inventory[{Slot:28b}]"}
execute if items entity @s inventory.20 *[minecraft:custom_data~{oa:{unique:1b}}] run function oa:inventory/slot {slot:"inventory.20",path:"Inventory[{Slot:29b}]"}
execute if items entity @s inventory.21 *[minecraft:custom_data~{oa:{unique:1b}}] run function oa:inventory/slot {slot:"inventory.21",path:"Inventory[{Slot:30b}]"}
execute if items entity @s inventory.22 *[minecraft:custom_data~{oa:{unique:1b}}] run function oa:inventory/slot {slot:"inventory.22",path:"Inventory[{Slot:31b}]"}
execute if items entity @s inventory.23 *[minecraft:custom_data~{oa:{unique:1b}}] run function oa:inventory/slot {slot:"inventory.23",path:"Inventory[{Slot:32b}]"}
execute if items entity @s inventory.24 *[minecraft:custom_data~{oa:{unique:1b}}] run function oa:inventory/slot {slot:"inventory.24",path:"Inventory[{Slot:33b}]"}
execute if items entity @s inventory.25 *[minecraft:custom_data~{oa:{unique:1b}}] run function oa:inventory/slot {slot:"inventory.25",path:"Inventory[{Slot:34b}]"}
execute if items entity @s inventory.26 *[minecraft:custom_data~{oa:{unique:1b}}] run function oa:inventory/slot {slot:"inventory.26",path:"Inventory[{Slot:35b}]"}
execute if items entity @s weapon.offhand *[minecraft:custom_data~{oa:{unique:1b}}] run function oa:inventory/slot {slot:"weapon.offhand",path:"equipment.offhand"}
execute if items entity @s armor.head *[minecraft:custom_data~{oa:{unique:1b}}] run function oa:inventory/slot {slot:"armor.head",path:"equipment.head"}
execute if items entity @s armor.chest *[minecraft:custom_data~{oa:{unique:1b}}] run function oa:inventory/slot {slot:"armor.chest",path:"equipment.chest"}
execute if items entity @s armor.legs *[minecraft:custom_data~{oa:{unique:1b}}] run function oa:inventory/slot {slot:"armor.legs",path:"equipment.legs"}
execute if items entity @s armor.feet *[minecraft:custom_data~{oa:{unique:1b}}] run function oa:inventory/slot {slot:"armor.feet",path:"equipment.feet"}
function oa:inventory/equip_curse

function oa:inventory/equip_yuua
