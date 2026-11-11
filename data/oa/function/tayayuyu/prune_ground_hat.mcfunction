execute unless entity @s[tag=br.matchloot] unless items entity @s contents *[minecraft:custom_data~{oa:{br_hat:1b}}] run return 0
execute store result score #hat_serial oa.tmp run data get entity @s Item.components."minecraft:custom_data".oa.serial
execute if score #hat_serial oa.tmp <= #hat_cut oa.serial run kill @s
