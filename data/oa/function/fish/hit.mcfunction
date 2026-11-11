execute if entity @s[tag=br.pvp_grace] run return 0
execute if entity @s[tag=oa.self_decoy] run return 0
execute if entity @s[tag=oa.decoy_grace] run return 0
scoreboard players set @s oa.hop 100
scoreboard players add @s oa.hoparc 0
tag @s add oa.fish_hop
attribute @s minecraft:movement_speed modifier remove oa:hop_compensation
# Compensation only: target is approximately normal speed on average, not holder's fast speed.
attribute @s minecraft:movement_speed modifier add oa:hop_compensation 0.5 add_multiplied_total
execute if entity @s[nbt={OnGround:1b}] at @s run function oa:status/hop_tick
particle minecraft:snowflake ~ ~1 ~ 0.4 0.5 0.4 0.03 12 normal @a[distance=..24]
playsound minecraft:block.glass.hit player @a[distance=..20] ~ ~ ~ 0.7 1.6
