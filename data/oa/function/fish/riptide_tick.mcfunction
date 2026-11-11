# Vanilla Riptide itself checks water contact or rain. Dry use cannot throw the fish.
execute if score @s oa.riptide matches 1.. run scoreboard players set @s oa.cd 100
scoreboard players add @s oa.cd 0
execute unless score @s oa.cd matches 1.. unless items entity @s weapon.mainhand minecraft:trident run item modify entity @s weapon.mainhand oa:fish_riptide_on
# Upgrade fish that was already in the ready form in the previous release.
execute unless score @s oa.cd matches 1.. unless items entity @s weapon.mainhand *[minecraft:custom_data~{oa:{riptide1916:1b}}] run item modify entity @s weapon.mainhand oa:fish_riptide_on
execute if score @s oa.cd matches 1.. if items entity @s weapon.mainhand minecraft:trident run item modify entity @s weapon.mainhand oa:fish_riptide_off
