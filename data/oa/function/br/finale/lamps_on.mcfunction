$execute if score #map oa.mapid matches 0 in oa:br positioned $(x) 80 $(z) run function oa:br/finale/lamps_on_at
$execute if score #map oa.mapid matches 1 in oa:br_nether positioned $(x) 80 $(z) run function oa:br/finale/lamps_on_at
$execute if score #map oa.mapid matches 2 in oa:br_cave positioned $(x) 80 $(z) run function oa:br/finale/lamps_on_at
$execute if score #map oa.mapid matches 3 in oa:br_sky positioned $(x) 80 $(z) run function oa:br/finale/lamps_on_at
$execute if score #map oa.mapid matches 4 in oa:br_end positioned $(x) 80 $(z) run function oa:br/finale/lamps_on_at
# 1.9.171: 洞窟の神殿の点滅ランプを全部つけた状態に戻す（神殿の床の立ち位置 y51）
$execute if score #map oa.mapid matches 2 in oa:br_cave positioned $(x) 51 $(z) run function oa:maps/cave/finale_all_on
