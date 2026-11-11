execute unless items entity @s weapon.mainhand *[minecraft:custom_data~{oa:{nero_v2:1b}}] run function oa:nero/upgrade
# Read the default clock of the current dimension in the player's execution context.
execute store result score #day oa.tmp run time query minecraft:day
execute if dimension oa:br store result score #day oa.tmp run time query time
execute if dimension oa:practice store result score #day oa.tmp run time query time
scoreboard players set #day_period oa.tmp 24000
scoreboard players operation #day oa.tmp %= #day_period oa.tmp
execute if score #day oa.tmp matches 13000..22999 unless entity @s[tag=oa.night] run function oa:nero/night_on
execute unless score #day oa.tmp matches 13000..22999 if entity @s[tag=oa.night] run function oa:nero/night_off
execute if entity @s[tag=oa.self_decoy] run function oa:nero/decoy_tick
