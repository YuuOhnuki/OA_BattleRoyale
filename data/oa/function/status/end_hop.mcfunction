execute if entity @s[tag=oa.hop_lift] run function oa:status/hop_release
attribute @s minecraft:movement_speed modifier remove oa:hop_compensation
tag @s remove oa.fish_hop

scoreboard players set @s oa.hoparc 0
