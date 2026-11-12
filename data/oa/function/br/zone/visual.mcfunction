execute unless dimension oa:br unless dimension oa:br_nether run return 0
execute store result score #px br.x run data get entity @s Pos[0] 1000
execute store result score #pz br.z run data get entity @s Pos[2] 1000
data modify storage oa:br_zone x set from entity @s Pos[0]
data modify storage oa:br_zone y set from entity @s Pos[1]
data modify storage oa:br_zone z set from entity @s Pos[2]
execute store result storage oa:br_zone cx double 0.001 run scoreboard players get #cx br.x
execute store result storage oa:br_zone cz double 0.001 run scoreboard players get #cz br.z
function oa:br/zone/particles
