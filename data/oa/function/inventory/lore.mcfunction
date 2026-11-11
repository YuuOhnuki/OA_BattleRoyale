$execute if items entity @s $(slot) *[minecraft:custom_data~{oa:{kind:1}}] unless items entity @s $(slot) *[minecraft:custom_data~{oa:{lore_release1:1b}}] run item modify entity @s $(slot) oa:lore/k1
$execute if items entity @s $(slot) *[minecraft:custom_data~{oa:{kind:2}}] unless items entity @s $(slot) *[minecraft:custom_data~{oa:{fish_lore1916:1b}}] run item modify entity @s $(slot) oa:lore/k2
$execute if items entity @s $(slot) *[minecraft:custom_data~{oa:{kind:3}}] unless items entity @s $(slot) *[minecraft:custom_data~{oa:{lore_v160:1b}}] run item modify entity @s $(slot) oa:lore/k3
$execute if items entity @s $(slot) *[minecraft:custom_data~{oa:{kind:4}}] unless items entity @s $(slot) *[minecraft:custom_data~{oa:{lore_release1:1b}}] run item modify entity @s $(slot) oa:lore/k4
$execute if items entity @s $(slot) *[minecraft:custom_data~{oa:{kind:5}}] unless items entity @s $(slot) *[minecraft:custom_data~{oa:{lore_release1:1b}}] run item modify entity @s $(slot) oa:lore/k5
$execute if items entity @s $(slot) *[minecraft:custom_data~{oa:{kind:6}}] unless items entity @s $(slot) *[minecraft:custom_data~{oa:{lore_release1:1b}}] run item modify entity @s $(slot) oa:lore/k6
$execute if items entity @s $(slot) *[minecraft:custom_data~{oa:{kind:7}}] unless items entity @s $(slot) *[minecraft:custom_data~{oa:{lore_release1:1b}}] run item modify entity @s $(slot) oa:lore/k7
$execute if items entity @s $(slot) *[minecraft:custom_data~{oa:{kind:8}}] unless items entity @s $(slot) *[minecraft:custom_data~{oa:{lore_release1:1b}}] run item modify entity @s $(slot) oa:lore/k8

$execute if items entity @s $(slot) *[minecraft:custom_data~{oa:{kind:9}}] unless items entity @s $(slot) *[minecraft:custom_data~{oa:{lore_taya1926:1b}}] run item modify entity @s $(slot) oa:lore/k9

$execute if items entity @s $(slot) *[minecraft:custom_data~{oa:{kind:10}}] run function oa:itori/item_stage {slot:"$(slot)"}
