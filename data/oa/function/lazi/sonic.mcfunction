function oa:combat/select_targets
data modify storage oa:damage amount set value 2
data modify storage oa:damage type set value "oa:sonic"
# 1.9.249: 足もとから高さ4m・半径4mの円柱（1.9.248 は上下6、それ以前は半径4の球）
execute store result score #lazi_cx oa.tmp run data get entity @s Pos[0] 100
execute store result score #lazi_cy oa.tmp run data get entity @s Pos[1] 100
execute store result score #lazi_cz oa.tmp run data get entity @s Pos[2] 100
execute as @e[tag=oa.target,distance=..7] at @s run function oa:lazi/cylinder_hit
function oa:lazi/ring
playsound minecraft:entity.generic.explode player @a[distance=..32] ~ ~ ~ 1.6 1.2
particle minecraft:explosion ~ ~1 ~ 0.4 0.2 0.4 0 2 normal @a[distance=..32]
particle minecraft:cloud ~ ~1 ~ 1 0.2 1 0.08 24 normal @a[distance=..32]
playsound minecraft:block.note_block.bell player @a[distance=..24] ~ ~ ~ 0.88 0.8
playsound minecraft:block.note_block.chime player @a[distance=..24] ~ ~ ~ 0.72 1.4
function oa:combat/finish

particle minecraft:firework ~ ~1 ~ 0.5 0.7 0.5 0.03 16 normal @a[distance=..24]
