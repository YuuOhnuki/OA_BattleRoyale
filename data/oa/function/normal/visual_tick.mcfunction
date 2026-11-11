execute if items entity @s weapon.mainhand *[minecraft:custom_data~{oa_normal:"bat"}] unless items entity @s weapon.mainhand *[minecraft:custom_data~{oa_bat_v151:1b}] run item modify entity @s weapon.mainhand oa:bat_visual
execute if items entity @s weapon.offhand *[minecraft:custom_data~{oa_normal:"bat"}] unless items entity @s weapon.offhand *[minecraft:custom_data~{oa_bat_v151:1b}] run item modify entity @s weapon.offhand oa:bat_visual

function oa:normal/nonstack/scan

function oa:medical/upgrade

execute if items entity @s weapon.mainhand *[minecraft:custom_data~{oa_furoball:1b}] unless items entity @s weapon.mainhand *[minecraft:custom_data~{furo_stack1927:1b}] run item modify entity @s weapon.mainhand oa:furo_stack1927

execute if items entity @s weapon.offhand *[minecraft:custom_data~{oa_furoball:1b}] unless items entity @s weapon.offhand *[minecraft:custom_data~{furo_stack1927:1b}] run item modify entity @s weapon.offhand oa:furo_stack1927
