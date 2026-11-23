execute store result score #dx br.tmp run data get storage oa:spawn_pool compare[0].x
execute store result score #dz br.tmp run data get storage oa:spawn_pool compare[0].z
scoreboard players operation #dx br.tmp -= #px br.tmp
scoreboard players operation #dz br.tmp -= #pz br.tmp
scoreboard players operation #dx br.tmp *= #dx br.tmp
scoreboard players operation #dz br.tmp *= #dz br.tmp
scoreboard players operation #dx br.tmp += #dz br.tmp
scoreboard players operation #min_distance br.tmp < #dx br.tmp
data remove storage oa:spawn_pool compare[0]
execute if data storage oa:spawn_pool compare[0] run function oa:br/spawn_points/distance
