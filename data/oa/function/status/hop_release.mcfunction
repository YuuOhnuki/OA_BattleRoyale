# Do not clear an externally replaced levitation effect with a different amplifier.
scoreboard players set #lift_amp oa.tmp -1
execute if entity @s[tag=oa.hop_lift] store result score #lift_amp oa.tmp run data get entity @s active_effects[{id:"minecraft:levitation"}].amplifier
execute if entity @s[tag=oa.hop_lift] if score #lift_amp oa.tmp matches 21 run effect clear @s minecraft:levitation
tag @s remove oa.hop_lift
scoreboard players set @s oa.hlift 0
scoreboard players set @s oa.hoparc 4
