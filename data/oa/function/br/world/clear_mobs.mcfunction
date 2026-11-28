# 1.9.266：ウォーデン・エンダードラゴン（タグ oa.boss、プラグイン）も消さない。
# 1.9.212: 災害の動物（タグ oa.dis_mob、ニワトリ大量発生・ブタの大行進）は消さない。災害が終わると disaster/k8・k11/end が消す
$execute if score #map oa.mapid matches 0 in oa:br positioned $(x) 0 $(z) align xz positioned ~-150 -64 ~-150 as @e[type=#oa:arena_mobs,tag=!oa.dis_mob,tag=!oa.boss,dx=299,dy=383,dz=299] run function oa:br/world/remove_mob
$execute if score #map oa.mapid matches 1 in oa:br_nether positioned $(x) 0 $(z) align xz positioned ~-150 -64 ~-150 as @e[type=#oa:arena_mobs,tag=!oa.dis_mob,tag=!oa.boss,dx=299,dy=383,dz=299] run function oa:br/world/remove_mob
$execute if score #map oa.mapid matches 2 in oa:br_cave positioned $(x) 0 $(z) align xz positioned ~-150 -64 ~-150 as @e[type=#oa:arena_mobs,tag=!oa.dis_mob,tag=!oa.boss,dx=299,dy=383,dz=299] run function oa:br/world/remove_mob
$execute if score #map oa.mapid matches 3 in oa:br_sky positioned $(x) 0 $(z) align xz positioned ~-150 -64 ~-150 as @e[type=#oa:arena_mobs,tag=!oa.dis_mob,tag=!oa.boss,dx=299,dy=383,dz=299] run function oa:br/world/remove_mob
$execute if score #map oa.mapid matches 4 in oa:br_end positioned $(x) 0 $(z) align xz positioned ~-150 -64 ~-150 as @e[type=#oa:arena_mobs,tag=!oa.dis_mob,tag=!oa.boss,dx=299,dy=383,dz=299] run function oa:br/world/remove_mob
