execute unless items entity @s hotbar.* *[minecraft:custom_data~{oa:{kind:10}}] unless items entity @s inventory.* *[minecraft:custom_data~{oa:{kind:10}}] unless items entity @s weapon.offhand *[minecraft:custom_data~{oa:{kind:10}}] run return 0
execute unless score @s oa.i_round = #round br.round run function oa:itori/progress_reset
execute if score @s oa.i_points matches 15.. run return 0
scoreboard players add @s oa.i_ore 1
execute unless score @s oa.i_ore matches 3.. run return 0
scoreboard players remove @s oa.i_ore 3
scoreboard players add @s oa.i_points 1
