$execute if items entity @s hotbar.* *[minecraft:custom_data~{oa:{serial:$(serial)}}] run scoreboard players set @s oa.have 1
$execute if items entity @s inventory.* *[minecraft:custom_data~{oa:{serial:$(serial)}}] run scoreboard players set @s oa.have 1
$execute if items entity @s weapon.offhand *[minecraft:custom_data~{oa:{serial:$(serial)}}] run scoreboard players set @s oa.have 1
$execute if items entity @s armor.* *[minecraft:custom_data~{oa:{serial:$(serial)}}] run scoreboard players set @s oa.have 1
