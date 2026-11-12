$execute if score #map oa.mapid matches 0 in oa:br positioned $(x) 0 $(z) align xz positioned ~-150 -64 ~-150 as @e[type=#oa:arena_mobs,dx=299,dy=383,dz=299] run function oa:br/world/remove_mob
$execute if score #map oa.mapid matches 1 in oa:br_nether positioned $(x) 0 $(z) align xz positioned ~-150 -64 ~-150 as @e[type=#oa:arena_mobs,dx=299,dy=383,dz=299] run function oa:br/world/remove_mob
