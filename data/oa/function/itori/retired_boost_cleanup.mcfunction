attribute @s minecraft:attack_damage modifier remove oa:xilonen_damage
execute if data entity @s active_effects[{id:"minecraft:speed",amplifier:1}] run effect clear @s minecraft:speed
tag @s remove oa.itori_boost
scoreboard players set @s oa.i_boost 0
scoreboard players set @s oa.i_leap 0
execute unless entity @s[tag=oa.itori_shield] run tag @s remove oa.itori_effect
