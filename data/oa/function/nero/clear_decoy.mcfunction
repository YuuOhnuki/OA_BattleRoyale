$data remove storage oa:players p$(id).decoy
$execute in minecraft:overworld run kill @e[distance=0..,tag=oa.decoy_origin,scores={oa.id=$(id)}]
$execute if score #map oa.mapid matches 0 in oa:br run kill @e[distance=0..,tag=oa.decoy_origin,scores={oa.id=$(id)}]
$execute if score #map oa.mapid matches 1 in oa:br_nether run kill @e[distance=0..,tag=oa.decoy_origin,scores={oa.id=$(id)}]
$execute in oa:practice run kill @e[distance=0..,tag=oa.decoy_origin,scores={oa.id=$(id)}]
$execute in minecraft:the_nether run kill @e[distance=0..,tag=oa.decoy_origin,scores={oa.id=$(id)}]
$execute in minecraft:the_end run kill @e[distance=0..,tag=oa.decoy_origin,scores={oa.id=$(id)}]
