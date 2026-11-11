$execute if items entity @s $(slot) *[minecraft:custom_data~{oa:{kind:1}}] run item modify entity @s $(slot) oa:name/k1
$execute if items entity @s $(slot) *[minecraft:custom_data~{oa:{kind:2}}] run item modify entity @s $(slot) oa:name/k2
$execute if items entity @s $(slot) *[minecraft:custom_data~{oa:{kind:3}}] run item modify entity @s $(slot) oa:name/k3
$execute if items entity @s $(slot) *[minecraft:custom_data~{oa:{kind:4}}] run item modify entity @s $(slot) oa:name/k4
$execute if items entity @s $(slot) *[minecraft:custom_data~{oa:{kind:5}}] run item modify entity @s $(slot) oa:name/k5
$execute if items entity @s $(slot) *[minecraft:custom_data~{oa:{kind:6}}] run item modify entity @s $(slot) oa:name/k6
$execute if items entity @s $(slot) *[minecraft:custom_data~{oa:{kind:7}}] run item modify entity @s $(slot) oa:name/k7
$execute if items entity @s $(slot) *[minecraft:custom_data~{oa:{kind:8}}] run item modify entity @s $(slot) oa:name/k8
$execute if items entity @s $(slot) *[minecraft:custom_data~{oa:{kind:9}}] run item modify entity @s $(slot) oa:name/k9

$execute if items entity @s $(slot) *[minecraft:custom_data~{oa:{kind:10}}] run function oa:itori/item_stage {slot:"$(slot)"}
