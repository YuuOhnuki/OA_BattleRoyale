
execute unless data storage oa:day backup run return 0
execute if score #map oa.mapid matches 0 in oa:br run function oa:br/day/set with storage oa:day backup
execute if score #map oa.mapid matches 1 in oa:br_nether run function oa:br/day/set with storage oa:day backup
execute if score #map oa.mapid matches 0 in oa:br run time resume
execute if score #map oa.mapid matches 1 in oa:br_nether run time resume
data remove storage oa:day backup
