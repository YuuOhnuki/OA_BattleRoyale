tag @a remove oa.radar_viewer
tag @a remove oa.radar_target
tag @s add oa.radar_viewer
data modify storage oa:radar viewer_dim set from entity @s Dimension
execute store result score #vx oa.tmp run data get entity @s Pos[0]
execute store result score #vz oa.tmp run data get entity @s Pos[2]
