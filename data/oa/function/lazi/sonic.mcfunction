function oa:combat/select_targets
data modify storage oa:damage amount set value 6
data modify storage oa:damage type set value "oa:sonic"
execute as @e[tag=oa.target,distance=..4] at @s run function oa:combat/gated_damage
function oa:lazi/ring
playsound minecraft:entity.generic.explode player @a[distance=..32] ~ ~ ~ 1.6 1.2
particle minecraft:explosion ~ ~1 ~ 0.4 0.2 0.4 0 2 normal @a[distance=..32]
particle minecraft:cloud ~ ~1 ~ 1 0.2 1 0.08 24 normal @a[distance=..32]
playsound minecraft:block.note_block.bell player @a[distance=..24] ~ ~ ~ 0.88 0.8
playsound minecraft:block.note_block.chime player @a[distance=..24] ~ ~ ~ 0.72 1.4
function oa:combat/finish

particle minecraft:firework ~ ~1 ~ 0.5 0.7 0.5 0.03 16 normal @a[distance=..24]
