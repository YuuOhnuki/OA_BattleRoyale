$data modify storage oa:spawn_pool candidate set from storage oa:spawn_pool points[$(scan)]
execute store result score #px br.tmp run data get storage oa:spawn_pool candidate.x
execute store result score #pz br.tmp run data get storage oa:spawn_pool candidate.z
scoreboard players set #min_distance br.tmp 2147483647
data modify storage oa:spawn_pool compare set from storage oa:spawn_pool used
function oa:br/spawn_points/distance
