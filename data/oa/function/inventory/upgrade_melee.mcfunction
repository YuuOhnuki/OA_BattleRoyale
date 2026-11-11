# Upgrade existing handheld uniques once; do not rewrite unrelated items.
execute if items entity @s weapon.mainhand *[minecraft:custom_data~{oa:{kind:2}}] unless items entity @s weapon.mainhand *[minecraft:custom_data~{oa:{fish_v146:1b}}] run item modify entity @s weapon.mainhand oa:melee_fish
execute if items entity @s weapon.mainhand *[minecraft:custom_data~{oa:{kind:4}}] unless items entity @s weapon.mainhand *[minecraft:custom_data~{oa:{melee_v1310:1b}}] run item modify entity @s weapon.mainhand oa:melee_iron
execute if items entity @s weapon.mainhand *[minecraft:custom_data~{oa:{kind:6}}] unless items entity @s weapon.mainhand *[minecraft:custom_data~{oa:{melee_v1310:1b}}] run item modify entity @s weapon.mainhand oa:melee_iron
execute if items entity @s weapon.mainhand *[minecraft:custom_data~{oa:{kind:7}}] unless items entity @s weapon.mainhand *[minecraft:custom_data~{oa:{staple_damage147:1b}}] run item modify entity @s weapon.mainhand oa:melee_staple
execute if items entity @s weapon.mainhand *[minecraft:custom_data~{oa:{kind:7}}] unless items entity @s weapon.mainhand *[minecraft:custom_data~{oa:{staple_v146:1b}}] run item modify entity @s weapon.mainhand oa:staple_upgrade

execute if items entity @s weapon.mainhand *[minecraft:custom_data~{oa:{kind:9}}] unless items entity @s weapon.mainhand *[minecraft:custom_data~{oa:{taya_registry171:1b}}] run item modify entity @s weapon.mainhand oa:tayayuyu_upgrade
