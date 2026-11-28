execute unless items entity @s weapon.mainhand *[minecraft:custom_data~{oa:{nero_v2:1b}}] run function oa:nero/upgrade
# Read the default clock of the current dimension in the player's execution context.
execute store result score #day oa.tmp run time query minecraft:day
execute if dimension oa:br store result score #day oa.tmp run time query time
execute if dimension oa:br_nether store result score #day oa.tmp run time query time
execute if dimension oa:br_cave store result score #day oa.tmp run time query time
execute if dimension oa:br_sky store result score #day oa.tmp run time query time
execute if dimension oa:br_end store result score #day oa.tmp run time query time
execute if dimension oa:practice store result score #day oa.tmp run time query time
scoreboard players set #day_period oa.tmp 24000
scoreboard players operation #day oa.tmp %= #day_period oa.tmp
# 1.9.271：夜間バフ（移動速度・攻撃力・防具値+20%）は廃止。以前の版で付いたままの人は外す
execute if entity @s[tag=oa.night] run function oa:nero/night_off
execute if entity @s[tag=oa.self_decoy] run function oa:nero/decoy_tick
