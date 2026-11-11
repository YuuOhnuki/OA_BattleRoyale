execute if items entity @s armor.head *[minecraft:custom_data~{oa:{unique:1b}}] run return run function oa:br/ui/read_item {slot:"armor.head",path:"equipment.head"}
execute if items entity @s armor.chest *[minecraft:custom_data~{oa:{unique:1b}}] run return run function oa:br/ui/read_item {slot:"armor.chest",path:"equipment.chest"}
execute if items entity @s armor.legs *[minecraft:custom_data~{oa:{unique:1b}}] run return run function oa:br/ui/read_item {slot:"armor.legs",path:"equipment.legs"}
execute if items entity @s armor.feet *[minecraft:custom_data~{oa:{unique:1b}}] run return run function oa:br/ui/read_item {slot:"armor.feet",path:"equipment.feet"}
execute if items entity @s weapon.mainhand *[minecraft:custom_data~{oa:{unique:1b}}] run return run function oa:br/ui/read_item {slot:"weapon.mainhand",path:"SelectedItem"}
execute if items entity @s weapon.offhand *[minecraft:custom_data~{oa:{unique:1b}}] run return run function oa:br/ui/read_item {slot:"weapon.offhand",path:"equipment.offhand"}
data modify storage oa:br_item name set value {text:"素手",color:"gray"}
data modify storage oa:br_item stack set value {}
execute if items entity @s weapon.mainhand * run return run function oa:br/ui/read_item {slot:"weapon.mainhand",path:"SelectedItem"}
execute if items entity @s weapon.offhand * run return run function oa:br/ui/read_item {slot:"weapon.offhand",path:"equipment.offhand"}
