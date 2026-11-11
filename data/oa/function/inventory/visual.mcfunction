$execute if items entity @s $(slot) *[minecraft:custom_data~{oa:{kind:1}}] unless items entity @s $(slot) *[minecraft:custom_data~{oa:{visual_v140:1b}}] run item modify entity @s $(slot) oa:visual/k1
$execute if items entity @s $(slot) *[minecraft:custom_data~{oa:{kind:2}}] unless items entity @s $(slot) *[minecraft:custom_data~{oa:{visual_v140:1b}}] run item modify entity @s $(slot) oa:visual/k2
$execute if items entity @s $(slot) *[minecraft:custom_data~{oa:{kind:3}}] unless items entity @s $(slot) *[minecraft:custom_data~{oa:{mask_v197:1b}}] run item modify entity @s $(slot) oa:visual/k3
$execute if items entity @s $(slot) *[minecraft:custom_data~{oa:{kind:4}}] unless items entity @s $(slot) *[minecraft:custom_data~{oa:{visual_v140:1b}}] run item modify entity @s $(slot) oa:visual/k4
$execute if items entity @s $(slot) *[minecraft:custom_data~{oa:{kind:5}}] unless items entity @s $(slot) *[minecraft:custom_data~{oa:{mask_v161:1b}}] run item modify entity @s $(slot) oa:visual/k5
$execute if items entity @s $(slot) *[minecraft:custom_data~{oa:{kind:6}}] unless items entity @s $(slot) *[minecraft:custom_data~{oa:{visual_v140:1b}}] run item modify entity @s $(slot) oa:visual/k6
$execute if items entity @s $(slot) *[minecraft:custom_data~{oa:{kind:7}}] unless items entity @s $(slot) *[minecraft:custom_data~{oa:{visual_v140:1b}}] run item modify entity @s $(slot) oa:visual/k7

$execute if items entity @s $(slot) *[minecraft:custom_data~{oa:{unique:1b}}] unless items entity @s $(slot) *[minecraft:custom_data~{oa:{speed_v160:1b}}] run item modify entity @s $(slot) oa:unique_speed

$execute if items entity @s $(slot) *[minecraft:custom_data~{oa:{kind:1}}] if entity @s[tag=br.playing,tag=!oa.practice] if score #state br.state matches 1 if score @s br.round = #round br.round if score #hat_round oa.serial = #round br.round run function oa:tayayuyu/prune_slot {slot:"$(slot)"}

$execute unless items entity @s $(slot) *[minecraft:custom_data~{oa:{name_v172:1b}}] run function oa:inventory/name {slot:"$(slot)"}
