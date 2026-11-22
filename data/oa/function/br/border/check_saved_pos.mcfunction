$execute if score #map oa.mapid matches 0 in oa:br positioned $(x) $(y) $(z) run function oa:br/border/check_position
$execute if score #map oa.mapid matches 1 in oa:br_nether positioned $(x) $(y) $(z) run function oa:br/border/check_position
$execute if score #map oa.mapid matches 2 in oa:br_cave positioned $(x) $(y) $(z) run function oa:br/border/check_position
$execute if score #map oa.mapid matches 3 in oa:br_sky positioned $(x) $(y) $(z) run function oa:br/border/check_position
$execute if score #map oa.mapid matches 4 in oa:br_end positioned $(x) $(y) $(z) run function oa:br/border/check_position
