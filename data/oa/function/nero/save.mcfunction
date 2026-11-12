data modify storage oa:position value set value {dim:"minecraft:overworld"}
execute if dimension minecraft:the_nether run data modify storage oa:position value.dim set value "minecraft:the_nether"
execute if dimension minecraft:the_end run data modify storage oa:position value.dim set value "minecraft:the_end"
data modify storage oa:position value.x set from entity @s Pos[0]
data modify storage oa:position value.y set from entity @s Pos[1]
data modify storage oa:position value.z set from entity @s Pos[2]
data modify storage oa:position value.yaw set from entity @s Rotation[0]
data modify storage oa:position value.pitch set from entity @s Rotation[1]

execute if dimension oa:practice run data modify storage oa:position value.dim set value "oa:practice"
execute if dimension oa:br run data modify storage oa:position value.dim set value "oa:br"
execute if dimension oa:br_nether run data modify storage oa:position value.dim set value "oa:br_nether"
